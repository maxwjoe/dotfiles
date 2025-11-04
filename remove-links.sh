#!/usr/bin/env bash
set -e

echo "Removing dotfile symlinks…"

if [ -L "$HOME/.config/nvim" ]; then
  rm "$HOME/.config/nvim"
  echo "Removed symlink ~/.config/nvim"
else
  echo "Skipped ~/.config/nvim (not a symlink)"
fi

if [ -L "$HOME/.tmux.conf" ]; then
  rm "$HOME/.tmux.conf"
  echo "Removed symlink ~/.tmux.conf"
else
  echo "Skipped ~/.tmux.conf (not a symlink)"
fi

if [ -L "$HOME/.tmux" ]; then
  rm "$HOME/.tmux"
  echo "Removed symlink ~/.tmux"
else
  echo "Skipped ~/.tmux (not a symlink)"
fi

if [ -L "$HOME/.config/opencode" ]; then
  rm "$HOME/.config/opencode"
  echo "Removed symlink ~/.config/opencode"
else
  echo "Skipped ~/.config/opencode (not a symlink)"
fi

echo "Done."
