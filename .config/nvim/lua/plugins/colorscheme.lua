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
      -- rose-pine's default Visual blend (15%) is too close to the
      -- background to read as a selection; bump it up.
      highlight_groups = {
        Visual = { bg = "iris", blend = 35 },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "rose-pine-moon" },
  },
}
