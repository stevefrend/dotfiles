return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    enabled = vim.env.LOCATION == 'work',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      debug = false,
      model = 'claude-3.5-sonnet',
      window = {
        width = 0.45,
      },
      auto_insert_mode = true,
      insert_at_end = true,
    },
    keys = {
      {
        '<leader>ch',
        ':CopilotChatToggle<CR>',
        mode = { 'n' },
        desc = 'CopilotChat - Toggle',
      },
      {
        '<leader>cc',
        function()
          local input = vim.fn.input 'Quick Chat: '
          if input ~= '' then
            require('CopilotChat').ask(input, { selection = require('CopilotChat.select').visual })
          end
        end,
        mode = { 'v' },
        desc = 'CopilotChat - Ask with Selection',
      },
    },
  },
}
