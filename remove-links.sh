#!/usr/bin/env bash
set -e

echo "Removing dotfile symlinks…"

if [ -L "$HOME/.config/nvim" ]; then
  rm "$HOME/.config/nvim"
  echo "Removed symlink ~/.config/nvim"
else
  echo "Skipped ~/.config/nvim (not a symlink)"
fi

if [ -L "$HOME/.config/wezterm" ]; then
  rm "$HOME/.config/wezterm"
  echo "Removed symlink ~/.config/wezterm"
else
  echo "Skipped ~/.config/wezterm(not a symlink)"
fi

echo "Done."
