#!/usr/bin/env bash
# Remove each app symlink (only if it is a symlink).
# Run from anywhere — paths are resolved relative to this script's location.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

while IFS= read -r app || [[ -n "$app" ]]; do
  [[ -z "$app" || "$app" == \#* ]] && continue
  dst="$HOME/.config/$app"
  if [ -L "$dst" ]; then
    rm "$dst"
    echo "Removed $dst"
  else
    echo "Skipped $dst (not a symlink)"
  fi
done < "$SCRIPT_DIR/apps.txt"

for dst in "$HOME/.claude/AGENTS.md" "$HOME/.claude/CLAUDE.md" "$HOME/AGENTS.md"; do
  if [ -L "$dst" ]; then
    rm "$dst"
    echo "Removed $dst"
  else
    echo "Skipped $dst (not a symlink)"
  fi
done
