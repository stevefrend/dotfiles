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
return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "prettierd" } },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      local prettier_fts = {
        "css", "graphql", "handlebars", "html",
        "javascript", "javascriptreact", "json", "jsonc",
        "less", "markdown", "markdown.mdx", "scss",
        "typescript", "typescriptreact", "vue", "yaml",
      }
      for _, ft in ipairs(prettier_fts) do
        -- With stop_after_first (set in custom.lua's default_format_opts),
        -- conform runs prettierd and falls back to prettier only if it's absent.
        opts.formatters_by_ft[ft] = { "prettierd", "prettier" }
      end
    end,
  },
}
