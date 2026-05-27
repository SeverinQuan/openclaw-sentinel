#!/usr/bin/env bash
set -euo pipefail

echo "[step] openclaw config validate"
openclaw config validate

echo "[step] openclaw agents list --bindings"
openclaw agents list --bindings

echo "[step] scanning for suspicious secrets"

# Hard patterns: token formats that strongly imply real credentials.
HARD_PATTERNS=(
  'pplx-[A-Za-z0-9_-]{20,}'
  'sk-[A-Za-z0-9_-]{20,}'
)

for p in "${HARD_PATTERNS[@]}"; do
  if grep -R -E -n --binary-files=without-match --exclude-dir=.git "$p" . >/dev/null 2>&1; then
    echo "[fail] suspicious credential pattern found: $p"
    grep -R -E -n --binary-files=without-match --exclude-dir=.git "$p" . || true
    exit 1
  fi
done

# Soft patterns: assignment-like secrets; allow known placeholder examples.
if grep -R -E -n --binary-files=without-match --exclude-dir=.git '(API_KEY|SECRET|TOKEN)[A-Z0-9_\-]*=' . >/tmp/sentinel_secret_hits.txt 2>/dev/null; then
  filtered="$(grep -Ev 'your_[a-z0-9_]+_here|example|placeholder|dummy|changeme' /tmp/sentinel_secret_hits.txt || true)"
  if [[ -n "$filtered" ]]; then
    echo "[fail] suspicious key/value assignments found"
    echo "$filtered"
    rm -f /tmp/sentinel_secret_hits.txt
    exit 1
  fi
fi
rm -f /tmp/sentinel_secret_hits.txt

echo "[ok] validation passed"
