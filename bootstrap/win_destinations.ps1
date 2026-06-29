# Windows destination overrides for app symlinks.
# Dot-source this file. Unlisted apps fall back to $env:USERPROFILE\.config\<app>.
$WIN_DESTINATIONS = @{
    "nvim" = "$env:LOCALAPPDATA\nvim"
}
