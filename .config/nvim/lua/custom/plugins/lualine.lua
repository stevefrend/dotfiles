function Harpoon_files()
  local contents = {}
  local marks_length = require('harpoon'):list():length()
  local current_file_path = vim.fn.fnamemodify(vim.fn.expand '%:p', ':.')

  for index = 1, marks_length do
    local harpoon_file_path = require('harpoon'):list():get(index).value
    local file_name = harpoon_file_path == '' and '(empty)' or vim.fn.fnamemodify(harpoon_file_path, ':t')

    if current_file_path == harpoon_file_path then
      contents[index] = string.format('%%#HarpoonNumberActive#%s. %%#HarpoonActive#%s', index, file_name)
    else
      contents[index] = string.format('%%#HarpoonNumberInactive#%s. %%#HarpoonInactive#%s', index, file_name)
    end
  end

  -- Set color variables for highlight groups to be used above using vim hlgroup variables
  vim.cmd [[highlight HarpoonNumberActive ctermfg=255 guifg=orange]]
  vim.cmd [[highlight HarpoonActive ctermfg=255 guifg=cornflowerblue]]
  vim.cmd [[highlight HarpoonNumberInactive ctermfg=255 guifg=orange]]
  vim.cmd [[highlight HarpoonInactive ctermfg=255 guifg=white]]

  -- Set contents of tabline and add a tab as separator between each item
  return table.concat(contents, '  ')
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        theme = 'tokyonight',
      },
      tabline = {
        lualine_a = { { Harpoon_files, separator = { left = '', right = '' } } },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'filetype' },
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}
