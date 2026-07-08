return {
  {
    {
      "stevearc/conform.nvim",
      opts = {
        default_format_opts = {
          -- `lsp_format = "fallback"` is also the LazyVim default; it replaces
          -- the deprecated `lsp_fallback` key.
          lsp_format = "fallback",
          -- Warm prettierd formats are ~100ms. prettier.lua pre-warms the daemon
          -- on the first JS/TS/Vue buffer, so saves are normally warm. This high
          -- timeout is just a safety net: if you save during the brief cold-boot
          -- warm-up window, the format succeeds (slowly) instead of timing out.
          timeout_ms = 8000,
          -- prettier.lua maps prettier filetypes to { "prettierd", "prettier" };
          -- stop_after_first runs prettierd and only falls back to prettier if
          -- prettierd is unavailable (instead of running both).
          stop_after_first = true,
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
            grep = {
              hidden = true,
              args = { "--glob=!.git", "--glob=!node_modules" },
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
  {
    "f-person/git-blame.nvim",
    -- event = 'VimEnter',
    -- opts = {
    --   enabled = true,
    --   message_template = ' <summary> • <date> • <author> • <<sha>>',
    --   date_format = '%m-%d-%Y %H:%M:%S',
    --   virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
    -- },
    config = function()
      vim.cmd([[GitBlameToggle]]) -- default to toggling it off
      vim.keymap.set("n", "<leader>gbo", "<CMD>GitBlameOpenCommitURL<CR>", { desc = "Git Blame Open" })
      vim.keymap.set("n", "<leader>gbt", "<CMD>GitBlameToggle<CR>", { desc = "Git Blame Toggle" })
    end,
  },
}
