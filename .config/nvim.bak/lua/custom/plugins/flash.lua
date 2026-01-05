return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    modes = {
      search = {
        -- why not keep this on? if you search for a word that does not exist but the first part does,
        -- it's pretty likely you'll enter the next char and jump to the partial. Better would be to
        -- search normally, and then manually trigger flash when done typing but feels overkill.
        enabled = false,
      },
    },
  },
  keys = {
    {
      '<leader>f',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
  },
}
