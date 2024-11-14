return {
  'stevearc/oil.nvim',
  config = function()
    require('oil').setup {
      keymaps = {
        -- still want to be able to use vim key in oil menu
        ['<C-h>'] = false,
        ['<esc>'] = 'actions.close',
      },
      view_options = {
        show_hidden = true,
      },
    }

    vim.keymap.set('n', '<leader>e', require('oil').toggle_float, { desc = 'Open File Tree' })
  end,
}
