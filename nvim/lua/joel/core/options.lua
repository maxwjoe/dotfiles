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

-- Ensure pipx-managed tools (black, isort) are on PATH when nvim is launched from a GUI or non-login shell
if vim.fn.has("win32") == 0 then
  local local_bin = vim.env.HOME .. "/.local/bin"
  if not vim.env.PATH:find(local_bin, 1, true) then
    vim.env.PATH = local_bin .. ":" .. vim.env.PATH
  end
end

-- Inject tool paths that mason and treesitter need but that may not be in nvim's inherited PATH
if vim.fn.has("win32") == 1 then
  local extra = {
    "C:/msys64/ucrt64/bin",          -- gcc, ninja (treesitter + telescope fzf build)
    "C:/msys64/usr/bin",              -- unzip, gzip (mason archive extraction)
    "C:/Program Files/7-Zip",         -- 7z (mason archive extraction)
    "C:/Program Files/PowerShell/7",  -- pwsh (mason + :terminal)
  }
  for _, p in ipairs(extra) do
    if vim.fn.isdirectory(p) == 1 and not vim.env.PATH:find(p, 1, true) then
      vim.env.PATH = p .. ";" .. vim.env.PATH
    end
  end
end

-- Suppress optional providers we don't use (eliminates health warnings)
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

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
