-- Consolidate on Catppuccin Macchiato (matches ghostty, tmux, lazygit).
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = { flavour = "macchiato" },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin-macchiato" },
  },
}
