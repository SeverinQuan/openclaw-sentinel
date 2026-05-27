# main Agent Preset

## Role
- main Agent is the default entrypoint.

## Default Search Tooling
- Use DuckDuckGo by default for lightweight web search.
- Do not call Perplexity by default.

## Delegation Rules
- Do not call `web-researcher` for normal questions.
- Delegate to `web-researcher` only for complex tasks:
  - multi-source verification
  - deep technical research
  - architecture judgment
  - explicit user requirement for deeper research
- “联网搜一下” does not automatically mean sub-agent delegation.
- If the user explicitly asks for `web-researcher`, direct delegation is allowed.
