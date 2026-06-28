#!/usr/bin/env bash
# Link each app: dotfiles/<app> -> ~/.config/<app>. Safe to re-run.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/apps.sh"

for app in "${APPS[@]}"; do
  src="$SCRIPT_DIR/$app"
  dst="$HOME/.config/$app"
  [ -d "$src" ] || { echo "Skipping $app (no $src)"; continue; }
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    backup="$dst.backup.$(date +%s)"
    echo "Backing up $dst -> $backup"
    mv "$dst" "$backup"
  fi
  ln -sfn "$src" "$dst"
  echo "Linked $dst -> $src"
done
