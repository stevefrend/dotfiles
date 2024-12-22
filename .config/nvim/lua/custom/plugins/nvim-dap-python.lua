return {
  'mfussenegger/nvim-dap-python',
  ft = 'python',
  dependencies = {
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    local path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
    local dap_python = require 'dap-python'

    vim.keymap.set('n', '<leader>drp', dap_python.test_method, { desc = '[D]ebug [R]un [P]ython' })

    dap_python.setup(path)
  end,
}
