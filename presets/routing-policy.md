# Routing Policy

## Objective
Enforce secure, predictable, and auditable routing between `main` and `web-researcher`.

## Policy
1. `main` handles default requests and uses DuckDuckGo for lightweight search.
2. `main` does not use Perplexity by default.
3. `web-researcher` is invoked only when complexity justifies deep research.
4. Explicit user request for `web-researcher` is honored.
5. `web-researcher` performs research-only tasks and never mutates system state.

## Complexity Triggers
- Cross-source conflict resolution
- Technology selection with trade-offs
- Architecture decision support
- Compliance/risk-sensitive research requiring source traceability
