#!/usr/bin/env bash
# Remove each app symlink (only if it is a symlink).
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/apps.sh"

for app in "${APPS[@]}"; do
  dst="$HOME/.config/$app"
  if [ -L "$dst" ]; then
    rm "$dst"
    echo "Removed symlink $dst"
  else
    echo "Skipped $dst (not a symlink)"
  fi
done
