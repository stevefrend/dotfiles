return { -- Enable better commenting (fixes broken comments in Vue <template>)
  'folke/ts-comments.nvim',
  opts = {},
  event = 'VeryLazy',
  enabled = vim.fn.has 'nvim-0.10.0' == 1,
}
