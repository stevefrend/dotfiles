return { -- File switcher
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'VimEnter',
  opts = {},
  config = function()
    local harpoon = require 'harpoon'

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = '[H]arpoon [A]dd' })

    vim.keymap.set('n', '<leader>hl', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = '[H]arpoon [L]ist' })

    vim.keymap.set('n', '<C-a>', function()
      harpoon:list():select(1)
    end, { desc = '[H]arpoon 1' })
    vim.keymap.set('n', '<C-s>', function()
      harpoon:list():select(2)
    end, { desc = '[H]arpoon 2' })
    vim.keymap.set('n', '<C-d>', function()
      harpoon:list():select(3)
    end, { desc = '[H]arpoon 4' })
    vim.keymap.set('n', '<C-f>', function()
      harpoon:list():select(4)
    end, { desc = '[H]arpoon 4' })
  end,
}
