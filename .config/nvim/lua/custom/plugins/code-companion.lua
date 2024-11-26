return {
  'olimorris/codecompanion.nvim',
  enabled = false,
  dependencies = {
    { 'nvim-lua/plenary.nvim', branch = 'master' },
    'nvim-treesitter/nvim-treesitter',
    -- The following are optional:
    { 'MeanderingProgrammer/render-markdown.nvim', ft = { 'markdown', 'codecompanion' } },
  },
  config = function()
    require('codecompanion').setup {
      opts = {
        log_level = 'DEBUG',
      },
    }
  end,
}
