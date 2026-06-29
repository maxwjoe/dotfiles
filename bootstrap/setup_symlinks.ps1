$ErrorActionPreference = "Stop"
$DOTFILES_DIR = (Resolve-Path "$PSScriptRoot\..").Path

# Windows destination overrides; unlisted apps fall back to $env:USERPROFILE\.config\<app>
$WIN_DESTINATIONS = @{
    "nvim" = "$env:LOCALAPPDATA\nvim"
}

function Link-Path($src, $dst, $kind) {
    $parent = Split-Path $dst
    if ($parent -and -not (Test-Path $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }
    $existing = Get-Item $dst -Force -ErrorAction SilentlyContinue
    if ($existing) {
        if ($existing.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
            Remove-Item $dst -Force
        } else {
            $backup = "$dst.backup.$([DateTimeOffset]::UtcNow.ToUnixTimeSeconds())"
            Write-Host "Backing up $dst -> $backup"
            Move-Item $dst $backup
        }
    }
    New-Item -ItemType $kind -Path $dst -Target $src | Out-Null
    Write-Host "Linked $dst -> $src"
}

Get-Content "$PSScriptRoot\apps.txt" | Where-Object { $_ -notmatch '^\s*#' -and $_ -notmatch '^\s*$' } | ForEach-Object {
    $app = $_.Trim()
    $src = "$DOTFILES_DIR\$app"
    $dst = if ($WIN_DESTINATIONS.ContainsKey($app)) { $WIN_DESTINATIONS[$app] } else { "$env:USERPROFILE\.config\$app" }
    if (-not (Test-Path $src)) { Write-Host "Skipping $app (no $src)"; return }
    Link-Path $src $dst "Junction"
}

$AGENTS_SRC = "$DOTFILES_DIR\AGENTS.md"
foreach ($dst in @(
    "$env:USERPROFILE\.claude\AGENTS.md",
    "$env:USERPROFILE\.claude\CLAUDE.md",
    "$env:USERPROFILE\AGENTS.md"
)) {
    Link-Path $AGENTS_SRC $dst "SymbolicLink"
}
