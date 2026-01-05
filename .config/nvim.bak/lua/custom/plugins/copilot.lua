-- return {
--   'zbirenbaum/copilot.lua',
--   cmd = 'Copilot',
--   event = 'InsertEnter',
--   opt = {},
--   enabled = vim.env.LOCATION == 'work',
--   config = function()
--     require('copilot').setup {
--       panel = {
--         enabled = false,
--       },
--       suggestion = {
--         auto_trigger = true,
--         debounce = 60,
--         keymap = {
--           -- prev = '<leader>j',
--           -- next = '<leader>k',
--           accept = '<Tab>',
--           -- dismiss = '<leader>ll',
--         },
--       },
--     }
--   end,
-- }
return {
  'github/copilot.vim',
  -- enabled = vim.env.LOCATION == 'work',
  enabled = false,
}
