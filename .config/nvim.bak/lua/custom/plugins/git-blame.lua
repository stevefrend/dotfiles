return {
  'f-person/git-blame.nvim',
  event = 'VimEnter',
  opts = {
    enabled = true,
    message_template = ' <summary> • <date> • <author> • <<sha>>',
    date_format = '%m-%d-%Y %H:%M:%S',
    virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
  },
  config = function()
    vim.cmd [[GitBlameToggle]] -- default to toggling it off
    vim.keymap.set('n', '<leader>gbo', '<CMD>GitBlameOpenCommitURL<CR>', { desc = 'Git Blame Open' })
    vim.keymap.set('n', '<leader>gb', '<CMD>GitBlameToggle<CR>', { desc = 'Git Blame Toggle' })
  end,
}
