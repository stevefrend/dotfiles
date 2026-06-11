-- Format prettier filetypes with prettierd (a resident daemon) instead of the
-- prettier CLI.
--
-- Why: the plain `prettier` CLI cold-starts a fresh Node process and reloads the
-- TypeScript/Vue parser plugins on EVERY save. Measured on a real Vue file in a
-- p8p MFE: first run ~5.07s (blows past the format-on-save timeout), warm runs
-- still 0.37-0.87s. prettierd keeps prettier resident in memory: ~1.4s once to
-- spawn the daemon, then ~0.06s per format -- i.e. VS Code-class speed. It still
-- resolves each project's local prettier version, config and plugins, so output
-- is identical.
--
-- LazyVim's prettier extra registers `prettier` for these filetypes; this spec
-- replaces that mapping with prettierd-first.

local prettier_fts = {
  "css", "graphql", "handlebars", "html",
  "javascript", "javascriptreact", "json", "jsonc",
  "less", "markdown", "markdown.mdx", "scss",
  "typescript", "typescriptreact", "vue", "yaml",
}

-- Resolve the prettierd binary (mason prepends its bin to PATH; fall back to the
-- known mason location just in case).
local function prettierd_bin()
  local p = vim.fn.exepath("prettierd")
  if p == "" then
    p = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin", "prettierd")
  end
  return vim.fn.executable(p) == 1 and p or nil
end

-- Pre-warm: the first time a prettier filetype is opened in a project, fire a
-- throwaway async prettierd format. This spawns the daemon AND loads this
-- project's prettier + plugins (the slow part -- prettier-plugin-tailwindcss in
-- particular) in the background while you read code, so your first *save* is
-- already warm (~100ms) instead of paying the cold-start cost (and timing out).
local function setup_warmup()
  local warmed = {}
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("prettierd_warmup", { clear = true }),
    pattern = prettier_fts,
    callback = function(ev)
      local fname = vim.api.nvim_buf_get_name(ev.buf)
      if fname == "" then
        return
      end
      local root = vim.fs.root(ev.buf, { "package.json", ".git" }) or vim.fs.dirname(fname)
      if warmed[root] then
        return
      end
      warmed[root] = true
      local bin = prettierd_bin()
      if not bin then
        return
      end
      local content = table.concat(vim.api.nvim_buf_get_lines(ev.buf, 0, -1, false), "\n")
      -- fire-and-forget; we don't apply the output, we just want the daemon warm
      pcall(vim.system, { bin, fname }, { stdin = content, text = true }, function() end)
    end,
  })
end

return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "prettierd" } },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    init = setup_warmup,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs(prettier_fts) do
        -- With stop_after_first (set in custom.lua's default_format_opts),
        -- conform runs prettierd and falls back to prettier only if it's absent.
        opts.formatters_by_ft[ft] = { "prettierd", "prettier" }
      end
    end,
  },
}
