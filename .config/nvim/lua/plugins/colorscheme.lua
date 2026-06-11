-- Test: Rosé Pine Moon (matches ghostty, tmux, lazygit).
return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = { variant = "moon" },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "rose-pine-moon" },
  },
}
