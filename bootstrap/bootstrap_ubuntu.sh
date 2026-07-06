#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo apt update

sudo apt install -y \
    neovim \
    git \
    ripgrep \
    fd-find \
    cmake \
    build-essential \
    unzip \
    python3 \
    python3-pip \
    pipx

# Node.js LTS via NodeSource — apt's bundled nodejs is too old (v12) for claude-code
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# lazygit
LAZYGIT_VERSION=$(curl -fsSL "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
  | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'].lstrip('v'))")

case "$(uname -m)" in
  x86_64)  LAZYGIT_ARCH="x86_64" ;;
  aarch64) LAZYGIT_ARCH="arm64" ;;
  armv7l)  LAZYGIT_ARCH="armv6" ;;
  *)       echo "Unsupported architecture: $(uname -m)"; exit 1 ;;
esac

curl -fsSL "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_${LAZYGIT_ARCH}.tar.gz" \
  | tar xz -C /tmp lazygit
sudo install /tmp/lazygit /usr/local/bin/lazygit

# GitHub CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
  | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update && sudo apt install -y gh

# Claude Code + neovim node provider
sudo npm install -g @anthropic-ai/claude-code
sudo npm install -g neovim

# tree-sitter CLI — required by nvim-treesitter (main branch) to compile parsers
sudo npm install -g tree-sitter-cli

# uv — Python package/project manager (not in apt; installs to ~/.local/bin)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Python formatters and neovim python provider
pip3 install pynvim --break-system-packages
pipx ensurepath
export PATH="$HOME/.local/bin:$PATH"
pipx install black --force
pipx install isort --force
pipx install harlequin --force
pipx install posting --force

# MesloLGS Nerd Font Mono
echo "Installing MesloLGS Nerd Font Mono..."
NF_TAG=$(curl -fsSL "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest" \
  | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'])")
curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/download/${NF_TAG}/Meslo.zip" -o /tmp/Meslo.zip
mkdir -p "$HOME/.local/share/fonts"
unzip -jo /tmp/Meslo.zip "MesloLGSNerdFontMono-*" -d "$HOME/.local/share/fonts/"
fc-cache -f
rm /tmp/Meslo.zip
echo "Font installed."

"$SCRIPT_DIR/setup_symlinks.sh"

echo "Done."
echo "Restart your shell and run nvim."
