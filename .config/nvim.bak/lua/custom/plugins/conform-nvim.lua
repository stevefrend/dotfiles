-- Important: since we're using prettierd here, we need to make sure the daemon is running or formatting will be weird
-- Do this by running `prettierd status/start/stop`. See all commands with prettierd -h.
-- Another caveat, this daemon can build up over time, so it's probably good to purge all node processes now and again
-- or just restart the computer.

return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>dfd',
      function()
        vim.cmd 'FormatDisable'
      end,
      mode = 'n',
      desc = '[D]ocument [F]ormat [D]isable',
    },
    {
      '<leader>dfe',
      function()
        vim.cmd 'FormatEnable'
      end,
      mode = 'n',
      desc = '[D]ocument [F]ormat [E]nable',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true, javascript = true, typescript = true, vue = true }

      local lsp_format_opt

      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end

      return {
        timeout_ms = 3000,
        lsp_format = lsp_format_opt,
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_format', 'ruff_fix', 'ruff_organize_imports' },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      javascript = { 'prettierd' },
      typescript = { 'prettierd' },
      vue = { 'prettierd' },
      json = { 'prettierd' },
      markdown = { 'prettierd' },
    },
  },
  init = function()
    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
        print 'Disabled Formatting for this buffer'
      else
        vim.g.disable_autoformat = true
        print 'Disabled Formatting'
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true,
    })

    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
      print 'Enabled Formatting'
    end, {
      desc = 'Re-enable autoformat-on-save',
    })
  end,
}
