local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs
opt.shiftwidth = 2 -- 2 spaces for indent
opt.expandtab = true -- make tabs spaces
opt.autoindent = true -- use previous line's indent when adding a new one


-- line wrapping
opt.wrap = false

-- search
opt.ignorecase = true
opt.smartcase = true


-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true


-- makes dash part of a word for diw etc
opt.iskeyword:append("-")


