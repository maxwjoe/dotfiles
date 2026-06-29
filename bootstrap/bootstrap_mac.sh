## TODO: ADD LAZYGIT INSTALLATION TO THIS + WINDOWS + UBUNTU
#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Install it from https://brew.sh, then re-run."
  exit 1
fi

xcode-select -p >/dev/null 2>&1 || xcode-select --install || true

echo "Installing tools..."
brew install neovim git ripgrep fd cmake node python pipx

brew install --cask claude-code
brew install --cask font-meslo-lg-nerd-font || true

echo "Installing Python formatters..."
pipx ensurepath
export PATH="$HOME/.local/bin:$PATH"

pipx install black --force
pipx install isort --force

"$SCRIPT_DIR/setup_symlinks.sh"

echo "Done."
echo "Restart your terminal, then launch nvim and run :checkhealth."
