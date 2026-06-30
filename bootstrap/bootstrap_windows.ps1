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
winget install --id LLVM.LLVM -e --accept-package-agreements --accept-source-agreements
winget install --id Ninja-build.Ninja -e --accept-package-agreements --accept-source-agreements
winget install --id OpenJS.NodeJS.LTS -e --accept-package-agreements --accept-source-agreements
winget install --id Python.Python.3.14 -e --accept-package-agreements --accept-source-agreements
winget install --id GitHub.cli -e --accept-package-agreements --accept-source-agreements
winget install --id JesseDuffield.lazygit -e --accept-package-agreements --accept-source-agreements
winget install --id Microsoft.PowerShell -e --accept-package-agreements --accept-source-agreements
winget install --id 7zip.7zip -e --accept-package-agreements --accept-source-agreements

# Refresh PATH so node/npm/pwsh/7z installed above are available in this session
$env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")

npm install -g @anthropic-ai/claude-code
npm install -g neovim

python -m pip install --upgrade pip
python -m pip install pynvim
python -m pip install pipx
python -m pipx ensurepath

$env:PATH += ";$env:USERPROFILE\.local\bin"

python -m pipx install black --force
python -m pipx install isort --force

Write-Host "Installing MesloLGS Nerd Font Mono..."
$nfTag = (Invoke-RestMethod "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest").tag_name
$zipPath = "$env:TEMP\Meslo.zip"
$extractPath = "$env:TEMP\MesloNF"
Invoke-WebRequest -Uri "https://github.com/ryanoasis/nerd-fonts/releases/download/$nfTag/Meslo.zip" -OutFile $zipPath -UseBasicParsing
Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force

$fontsDir = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
New-Item -ItemType Directory -Force -Path $fontsDir | Out-Null
$regKey = "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"
# Install only the Mono variants (LGS = Line Gap Small, the style wezterm references)
Get-ChildItem "$extractPath" -Filter "MesloLGSNerdFontMono-*.ttf" | ForEach-Object {
    Copy-Item $_.FullName -Destination "$fontsDir\$($_.Name)" -Force
    Set-ItemProperty -Path $regKey -Name "$($_.BaseName) (TrueType)" -Value "$fontsDir\$($_.Name)"
}
Remove-Item $zipPath, $extractPath -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "Font installed."

& "$PSScriptRoot\setup_symlinks.ps1"

Write-Host "Done. Restart PowerShell and run nvim."
