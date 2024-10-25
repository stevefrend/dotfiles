return {
  'folke/tokyonight.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    require('tokyonight').setup {
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
      on_highlights = function(hl, colors)
        hl.LineNrAbove = { fg = colors.magenta }
        hl.LineNrBelow = { fg = colors.magenta }
      end,
    }
  end,
}
