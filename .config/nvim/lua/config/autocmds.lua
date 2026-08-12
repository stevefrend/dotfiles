-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Disable format-on-save for filetypes without an enforced/required formatter
-- config in the project (unlike TS projects, which require a prettier config).
-- Formatting is still available on-demand via <leader>cf / :LazyFormat.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("disable_autoformat", { clear = true }),
  pattern = { "kotlin", "yaml", "yaml.docker-compose" },
  callback = function()
    vim.b.autoformat = false
  end,
})
