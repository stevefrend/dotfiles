-- Rosé Pine Moon (matches ghostty, tmux, lazygit).
return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "moon",
      -- transparent background so ghostty's opacity/blur shows through
      -- (rose-pine's equivalent of tokyonight's `transparent = true`;
      -- covers floats/sidebars too).
      styles = { transparency = true },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "rose-pine-moon" },
  },
}
