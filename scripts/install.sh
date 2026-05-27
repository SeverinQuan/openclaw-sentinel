#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PRESET_SRC="$PROJECT_ROOT/presets/openclaw.config.example.json"
TARGET_CONFIG="${OPENCLAW_CONFIG_PATH:-$HOME/.config/openclaw/openclaw.json}"
TARGET_DIR="$(dirname "$TARGET_CONFIG")"

bash "$SCRIPT_DIR/backup-openclaw-config.sh"

read -r -p "Apply Sentinel preset to $TARGET_CONFIG ? [y/N] " CONFIRM
if [[ "${CONFIRM}" != "y" && "${CONFIRM}" != "Y" ]]; then
  echo "[info] Cancelled by user"
  exit 0
fi

mkdir -p "$TARGET_DIR"

if [[ -f "$TARGET_CONFIG" ]]; then
  tmp_file="$(mktemp)"
  if grep -Ei 'secret|token|api[_-]?key' "$TARGET_CONFIG" >/dev/null 2>&1; then
    echo "[warn] Existing config appears to include secret-like keys; preserving file and writing preset copy only."
    cp "$PRESET_SRC" "$TARGET_CONFIG.sentinel.example"
    echo "[ok] Preset copy written: $TARGET_CONFIG.sentinel.example"
    rm -f "$tmp_file"
    exit 0
  fi
  cp "$PRESET_SRC" "$tmp_file"
  mv "$tmp_file" "$TARGET_CONFIG"
else
  cp "$PRESET_SRC" "$TARGET_CONFIG"
fi

echo "[ok] Sentinel preset installed"
echo "[note] No secrets were printed or overwritten by this installer."
