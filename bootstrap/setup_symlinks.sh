#!/usr/bin/env bash
# Link each app: dotfiles/<app> -> ~/.config/<app>. Safe to re-run.
# Run from anywhere — paths are resolved relative to this script's location.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/apps.sh"

for app in "${APPS[@]}"; do
  src="$DOTFILES_DIR/$app"
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

# AGENTS.md: link to ~/.claude/AGENTS.md (Claude) and ~/AGENTS.md (generic agents)
AGENTS_SRC="$DOTFILES_DIR/AGENTS.md"
for dst in "$HOME/.claude/AGENTS.md" "$HOME/.claude/CLAUDE.md" "$HOME/AGENTS.md"; do
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    backup="$dst.backup.$(date +%s)"
    echo "Backing up $dst -> $backup"
    mv "$dst" "$backup"
  fi
  ln -sfn "$AGENTS_SRC" "$dst"
  echo "Linked $dst -> $AGENTS_SRC"
done
