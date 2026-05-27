#!/usr/bin/env bash
set -euo pipefail

TS="$(date +%Y%m%d-%H%M%S)"
SRC="${OPENCLAW_CONFIG_PATH:-$HOME/.config/openclaw/openclaw.json}"
DST="${SRC}.backup.${TS}"

if [[ ! -f "$SRC" ]]; then
  echo "[warn] OpenClaw config not found: $SRC"
  exit 0
fi

cp "$SRC" "$DST"
echo "[ok] Backup created: $DST"
