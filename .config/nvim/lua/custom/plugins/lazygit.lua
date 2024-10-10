return {
  'kdheepak/lazygit.nvim',
  event = 'VimEnter',
  -- optional for floating window border decoration
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local home = os.getenv 'HOME'
    local correct_path = home .. '/.config/lazygit/config.yml'

    vim.g.lazygit_use_custom_config_file_path = 1
    vim.g.lazygit_config_file_path = correct_path

    local g = require 'lazygit'

    vim.keymap.set('n', '<leader>g', function()
      g.lazygit()
    end, { desc = 'Git' })
  end,
}
