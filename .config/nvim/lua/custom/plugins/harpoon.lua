return { -- File switcher
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'VimEnter',
  opts = {},
  config = function()
    local harpoon = require 'harpoon'

    vim.keymap.set('n', '<leader>hh', function()
      harpoon:list():add()
    end, { desc = 'Harpoon Add' })

    vim.keymap.set('n', '<leader>hl', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon List' })

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():select(1)
    end, { desc = 'Harpoon 1' })
    vim.keymap.set('n', '<leader>hs', function()
      harpoon:list():select(2)
    end, { desc = 'Harpoon 2' })
    vim.keymap.set('n', '<leader>hd', function()
      harpoon:list():select(3)
    end, { desc = 'Harpoon 4' })
    vim.keymap.set('n', '<leader>hf', function()
      harpoon:list():select(4)
    end, { desc = 'Harpoon 4' })
  end,
}
