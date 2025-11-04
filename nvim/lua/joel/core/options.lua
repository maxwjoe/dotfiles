vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- Tabs and Indentation 

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

-- Search Settings

opt.ignorecase = true -- Ignores case by default
opt.smartcase = true -- Case sensitive search if mixed case is used

opt.cursorline = true

-- Terminal Colours

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Backspace

opt.backspace = "indent,eol,start"

-- Clipboard

opt.clipboard:append("unnamedplus") -- Use system clipboard as default register

-- Split Windows 

opt.splitright = true -- Splits a vertical window to the right
opt.splitbelow = true -- Splits a horizontal window to the left
