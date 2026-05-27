#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CURSOR_SETTINGS="${DOTFILES}/cursor"
CURSOR_USER="${HOME}/Library/Application Support/Cursor/User"

mkdir -p "$CURSOR_SETTINGS" "$CURSOR_USER"

for f in "$CURSOR_SETTINGS"/*; do
  [[ -e "$f" ]] || continue
  target="${CURSOR_USER}/$(basename "$f")"
  if [[ -e "$target" && ! -L "$target" ]]; then
    cp -a "$target" "${target}.bak"
  fi
  ln -sf "$f" "$target"
done
