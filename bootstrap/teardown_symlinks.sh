#!/usr/bin/env bash
# Remove each app symlink (only if it is a symlink).
# Run from anywhere — paths are resolved relative to this script's location.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/apps.sh"

for app in "${APPS[@]}"; do
  dst="$HOME/.config/$app"
  if [ -L "$dst" ]; then
    rm "$dst"
    echo "Removed $dst"
  else
    echo "Skipped $dst (not a symlink)"
  fi
done

# AGENTS.md symlinks
for dst in "$HOME/.claude/AGENTS.md" "$HOME/.claude/CLAUDE.md" "$HOME/AGENTS.md"; do
  if [ -L "$dst" ]; then
    rm "$dst"
    echo "Removed $dst"
  else
    echo "Skipped $dst (not a symlink)"
  fi
done
