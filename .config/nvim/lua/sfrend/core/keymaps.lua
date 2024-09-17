vim.g.mapleader = " "

local km = vim.keymap

-- Comment, using plugin for this, is gcc

-- general
 -- km.set("i", "jk", "<ESC>")
 -- mode, keys, command
 --
 km.set("n", "x", "_x") -- do not put deleted items into copy bin

 km.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- leader e opens/closes file tree


 -- telescope
km.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
km.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
km.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
km.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
km.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- Tabs, wait to see if we need it
-- keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
-- keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
-- keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
-- keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab
