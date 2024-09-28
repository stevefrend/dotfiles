return {
  'kdheepak/lazygit.nvim',
  event = 'VeryLazy',
  -- optional for floating window border decoration
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {},
  config = function()
    local g = require 'lazygit'
    vim.keymap.set('n', '<leader>g', function()
      g.lazygit()
    end, { desc = 'Git' })
  end,
}
