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
    nodejs \
    npm \
    python3 \
    python3-pip \
    pipx

pipx ensurepath

export PATH="$HOME/.local/bin:$PATH"

pipx install black --force
pipx install isort --force

"$SCRIPT_DIR/setup-symlinks.sh"

echo "Done."
echo "Restart your shell and run nvim."
