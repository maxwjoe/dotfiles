#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BREW_BIN=""
for candidate in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  [ -x "$candidate" ] && { BREW_BIN="$candidate"; break; }
done
if [ -z "$BREW_BIN" ]; then
  echo "Homebrew not found. Install it from https://brew.sh, then re-run."
  exit 1
fi

# Put Homebrew ahead of /usr/bin for this script (otherwise Apple's python3/pip3 win),
# and persist it for login shells so nvim etc. see the same tools.
eval "$("$BREW_BIN" shellenv)"
SHELLENV_LINE="eval \"\$($BREW_BIN shellenv)\""
touch "$HOME/.zprofile"
grep -qxF "$SHELLENV_LINE" "$HOME/.zprofile" || echo "$SHELLENV_LINE" >> "$HOME/.zprofile"

xcode-select -p >/dev/null 2>&1 || xcode-select --install || true

echo "Installing tools..."
brew install neovim git ripgrep fd cmake node python pipx uv lazygit gh harlequin posting tree-sitter-cli

# claude-code@latest conflicts with the stable `claude-code` cask; use the latest channel.
brew install --cask claude-code@latest
brew install --cask wezterm
brew install --cask font-meslo-lg-nerd-font || true

npm install -g neovim

echo "Installing Python formatters and providers..."
python3 -m pip install pynvim --break-system-packages
pipx ensurepath
export PATH="$HOME/.local/bin:$PATH"

pipx install black --force
pipx install isort --force

"$SCRIPT_DIR/setup_symlinks.sh"

echo "Done."
echo "Restart your terminal, then launch nvim and run :checkhealth."
