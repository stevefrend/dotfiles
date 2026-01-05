return { -- zen mode, centered buffer
  'shortcuts/no-neck-pain.nvim',
  config = function()
    -- require('mini.ai').setup { n_lines = 500 }
    -- require('mini.surround').setup()
    require('no-neck-pain').setup { version = '*', autocmds = { enableOnVimEnter = true }, width = 200 }
  end,
}
