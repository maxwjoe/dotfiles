vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- Tabs and Indentation 

opt.tabstop = 4
opt.shiftwidth = 4
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

-- Native Windows: route :terminal and shell-outs through PowerShell (UTF-8)
if vim.fn.has("win32") == 1 and vim.fn.executable("pwsh") == 1 then
  vim.o.shell = "pwsh"
  vim.o.shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
  vim.o.shellpipe  = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
end
