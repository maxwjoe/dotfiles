$ErrorActionPreference = "Stop"

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Error "winget is required."
    exit 1
}

Write-Host "Installing tools..."

winget install --id Neovim.Neovim -e --accept-package-agreements --accept-source-agreements
winget install --id Git.Git -e --accept-package-agreements --accept-source-agreements
winget install --id BurntSushi.ripgrep.MSVC -e --accept-package-agreements --accept-source-agreements
winget install --id sharkdp.fd -e --accept-package-agreements --accept-source-agreements
winget install --id Kitware.CMake -e --accept-package-agreements --accept-source-agreements
winget install --id OpenJS.NodeJS.LTS -e --accept-package-agreements --accept-source-agreements
winget install --id Python.Python.3.14 -e --accept-package-agreements --accept-source-agreements
winget install --id GitHub.cli -e --accept-package-agreements --accept-source-agreements
winget install --id JesseDuffield.lazygit -e --accept-package-agreements --accept-source-agreements

python -m pip install --upgrade pip
python -m pip install pipx
python -m pipx ensurepath

$env:PATH += ";$env:USERPROFILE\.local\bin"

python -m pipx install black --force
python -m pipx install isort --force

& "$PSScriptRoot\setup_symlinks.ps1"

Write-Host "Done. Restart PowerShell and run nvim."
