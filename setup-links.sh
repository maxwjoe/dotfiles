#!/usr/bin/env bash
set -e

echo "Linking dotfiles…"

mkdir -p "$HOME/.config"

ln -sfn "$HOME/.config/dotfiles/nvim" "$HOME/.config/nvim"
ln -sfn "$HOME/.config/dotfiles/tmux/.tmux" "$HOME/.tmux"
ln -sfn "$HOME/.config/dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"
ln -sfn "$HOME/.config/dotfiles/opencode" "$HOME/.config/opencode"

echo "Done."
echo "Open a new terminal."
