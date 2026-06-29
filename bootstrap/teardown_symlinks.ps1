$ErrorActionPreference = "Stop"
. "$PSScriptRoot\win_destinations.ps1"

function Remove-Link($dst) {
    $item = Get-Item $dst -Force -ErrorAction SilentlyContinue
    if ($item -and ($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint)) {
        Remove-Item $dst -Force
        Write-Host "Removed $dst"
    } else {
        Write-Host "Skipped $dst (not a symlink)"
    }
}

Get-Content "$PSScriptRoot\apps.txt" | Where-Object { $_ -notmatch '^\s*#' -and $_ -notmatch '^\s*$' } | ForEach-Object {
    $app = $_.Trim()
    $dst = if ($WIN_DESTINATIONS.ContainsKey($app)) { $WIN_DESTINATIONS[$app] } else { "$env:USERPROFILE\.config\$app" }
    Remove-Link $dst
}

foreach ($dst in @(
    "$env:USERPROFILE\.claude\AGENTS.md",
    "$env:USERPROFILE\.claude\CLAUDE.md",
    "$env:USERPROFILE\AGENTS.md"
)) {
    Remove-Link $dst
}
