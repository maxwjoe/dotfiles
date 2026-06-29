# dotfiles

## Clone

The repo must live at `~/.config/dotfiles` on all platforms so the symlinks resolve correctly.

**macOS / Linux**
```bash
git clone <repo-url> ~/.config/dotfiles
```

**Windows** (PowerShell)
```powershell
git clone <repo-url> "$env:USERPROFILE\.config\dotfiles"
```

---

## macOS

**Prerequisites:** [Homebrew](https://brew.sh)

```bash
~/.config/dotfiles/bootstrap/bootstrap_mac.sh
```

Installs: neovim, git, ripgrep, fd, cmake, node, python, pipx, lazygit, claude-code, MesloLGS Nerd Font. Then links all configs.

After: restart your terminal, open nvim and run `:checkhealth`.

---

## Ubuntu

**Prerequisites:** sudo access, curl

```bash
~/.config/dotfiles/bootstrap/bootstrap_ubuntu.sh
```

Installs: neovim, git, ripgrep, fd-find, cmake, nodejs, npm, python3, pipx, lazygit (from GitHub releases). Then links all configs.

After: restart your shell, open nvim and run `:checkhealth`.

---

## Windows

**Prerequisites:**
- winget (built into Windows 11; [install on Windows 10](https://aka.ms/getwinget))
- Developer Mode enabled (`Settings → System → For developers`) — required for file symlinks

Run in PowerShell (as Administrator or with Developer Mode):
```powershell
~\.config\dotfiles\bootstrap\bootstrap_windows.ps1
```

Installs: neovim, git, ripgrep, fd, cmake, node, python, gh, lazygit. Then links all configs.

After: restart PowerShell, open nvim and run `:checkhealth`.

---

## Symlinks

| Source | macOS / Linux | Windows |
|---|---|---|
| `dotfiles/nvim` | `~/.config/nvim` | `%LOCALAPPDATA%\nvim` |
| `dotfiles/wezterm` | `~/.config/wezterm` | `%USERPROFILE%\.config\wezterm` |
| `dotfiles/AGENTS.md` | `~/.claude/AGENTS.md` | `%USERPROFILE%\.claude\AGENTS.md` |
| `dotfiles/AGENTS.md` | `~/.claude/CLAUDE.md` | `%USERPROFILE%\.claude\CLAUDE.md` |
| `dotfiles/AGENTS.md` | `~/AGENTS.md` | `%USERPROFILE%\AGENTS.md` |

To add a new app, add its name to `bootstrap/apps.txt`. If it needs a non-standard path on Windows, also add it to `$WIN_DESTINATIONS` in `bootstrap/setup_symlinks.ps1` and `bootstrap/teardown_symlinks.ps1`.

**Manage symlinks manually:**
```bash
# macOS / Linux
bootstrap/setup_symlinks.sh
bootstrap/teardown_symlinks.sh
```
```powershell
# Windows
bootstrap\setup_symlinks.ps1
bootstrap\teardown_symlinks.ps1
```
