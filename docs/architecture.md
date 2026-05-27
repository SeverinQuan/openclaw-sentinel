# Architecture

OpenClaw Sentinel uses a two-layer agent model:

- Layer 1 (`main`): default entry, lightweight retrieval, routing controller.
- Layer 2 (`web-researcher`): deep web research and synthesis only.

## Design Goals
- Minimize accidental high-cost tool usage.
- Enforce strict operational boundaries.
- Keep routing auditable and predictable.

## Decision Flow
1. Incoming task enters `main`.
2. If task is routine, `main` answers directly.
3. If complexity triggers match policy, `main` delegates to `web-researcher`.
4. `web-researcher` returns research results with sources and uncertainty.
