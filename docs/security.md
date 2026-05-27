# Security

## Secret Hygiene
- Never commit real `.env` files.
- Never commit API keys, tokens, or private keys.
- Keep runtime secrets outside version control.

## Agent Boundary Controls
- `main` does not use Perplexity by default.
- `web-researcher` is research-only and cannot mutate project state.
- Dangerous operations (delete, deploy, push, config writes) are disallowed for `web-researcher`.

## Pre-Push Controls
Run `scripts/validate.sh` and explicit grep checks before commit/push.
