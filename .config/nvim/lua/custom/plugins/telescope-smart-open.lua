return {
  'danielfalk/smart-open.nvim',
  branch = '0.2.x',
  config = function()
    require('telescope').load_extension 'smart_open'

    vim.keymap.set('n', '<leader>sf', function()
      require('telescope').extensions.smart_open.smart_open()
    end, { noremap = true, silent = true, desc = 'Search Files (Smart Open)' })
  end,
  dependencies = {
    'kkharji/sqlite.lua',
    -- Only required if using match_algorithm fzf
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
}
