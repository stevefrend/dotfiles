return {
  'MagicDuck/grug-far.nvim',
  event = 'VimEnter',
  opts = {},
  config = function()
    local grug = require 'grug-far'
    grug.setup()

    vim.keymap.set('n', '<leader>sr', function()
      grug.open { prefills = { search = vim.fn.expand '<cword>' } }
    end, { desc = '[S]earch and [R]eplace' })
  end,
}
