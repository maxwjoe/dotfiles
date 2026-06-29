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
    nodejs \
    npm \
    python3 \
    python3-pip \
    pipx

LAZYGIT_VERSION=$(curl -fsSL "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
  | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'].lstrip('v'))")

case "$(uname -m)" in
  x86_64)  LAZYGIT_ARCH="x86_64" ;;
  aarch64) LAZYGIT_ARCH="arm64" ;;
  armv7l)  LAZYGIT_ARCH="armv6" ;;
  *)       echo "Unsupported architecture: $(uname -m)"; exit 1 ;;
esac

curl -fsSL "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_${LAZYGIT_ARCH}.tar.gz" | tar xz -C /tmp lazygit
sudo install /tmp/lazygit /usr/local/bin/lazygit

pipx ensurepath

export PATH="$HOME/.local/bin:$PATH"

pipx install black --force
pipx install isort --force

"$SCRIPT_DIR/setup_symlinks.sh"

echo "Done."
echo "Restart your shell and run nvim."
