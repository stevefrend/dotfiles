vim.g.mapleader = " "

local km = vim.keymap

-- Comment, using plugin for this, is gcc

-- general
-- km.set("i", "jk", "<ESC>")
-- mode, keys, command

km.set("n", "<leader>cl", ":nohl<CR>", { desc = "Clear search highlights" })

-- Tabs
km.set("n", "<leader>t", ":tabnew<CR>") -- open new tab
km.set("n", "<leader>w", ":tabclose<CR>") -- close current tab
km.set("n", "<leader><Tab>", ":tabn<CR>") --  go to next tab
