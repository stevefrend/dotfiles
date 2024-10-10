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
        auto_trigger = false,
        debounce = 100,
        keymap = {
          prev = '<leader>j',
          next = '<leader>k',
          accept = '<leader>l',
          dismiss = '<leader>ll',
        },
      },
    }
  end,
}
