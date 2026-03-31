return {
  {
    {
      "stevearc/conform.nvim",
      opts = {
        default_format_opts = {
          lsp_fallback = true,
          timeout_ms = 5000,
        },
      },
    },
    {
      "stevearc/oil.nvim",
      keys = {
        {
          "<leader>p",
          -- "<cmd>Oil.open_float()<cr>",
          function()
            require("oil").toggle_float()
          end,
          desc = "oil",
        },
      },
      opts = {
        keymaps = {
          ["q"] = { "actions.close", mode = "n" },
          ["<esc>"] = { "actions.close", mode = "n" },
        },
        view_options = {
          show_hidden = true,
        },
        float = {
          max_width = 0.6,
          max_height = 0.8,
        },
      },
    },
    {
      "folke/snacks.nvim",
      opts = {
        picker = {
          sources = {
            files = {
              hidden = true,
            },
          },
        },
      },
    },
    {
      "christoomey/vim-tmux-navigator",
      cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
        "TmuxNavigatorProcessList",
      },
      keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
      },
    },
  },
}
