#!/usr/bin/env bash
set -e

echo "Linking dotfiles…"

mkdir -p "$HOME/.config"

ln -sfn "$HOME/.config/dotfiles/nvim" "$HOME/.config/nvim"
ln -sfn "$HOME/.config/dotfiles/wezterm" "$HOME/.config/wezterm"

echo "Done."
echo "Open a new terminal."
