return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  opt = {},
  enabled = vim.env.LOCATION == 'work',
  config = function()
    require('copilot').setup {
      panel = {
        enabled = false,
      },
      suggestion = {
        auto_trigger = true,
        debounce = 150,
        keymap = {
          accept = '<C-k>',
        },
      },
    }
  end,
}
