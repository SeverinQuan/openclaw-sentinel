# OpenClaw Sentinel

Secure Agent Routing for DuckDuckGo + Perplexity MCP

## 中文说明

### OpenClaw Sentinel 是什么
OpenClaw Sentinel 是一个面向 OpenClaw 的 Agent 路由与工具边界预设项目。它通过明确的角色拆分，把常规搜索与复杂研究分层处理，降低误用高成本工具和越权操作风险。

### 为什么 main Agent 默认用 DuckDuckGo
- DuckDuckGo 适合轻量、快速、低风险的日常联网查询。
- 作为默认入口工具，可减少不必要的复杂调用和成本。
- 对“先查再答”的常规问题响应更直接。

### 为什么 Perplexity MCP 只交给 web-researcher
- Perplexity 更适合复杂研究、多来源核验与技术判断。
- 限制在专用子 Agent 内可强化边界控制与审计。
- 避免 main Agent 在普通问题中误触发高成本或过度研究流程。

### main Agent 与 web-researcher 职责边界
- main Agent：默认入口、常规问答、轻量搜索、任务分流。
- web-researcher：仅做复杂联网研究、核验、总结；不改文件、不执行危险操作。

### 安装方式
1. 克隆本仓库。
2. 检查并按需修改 `presets/openclaw.config.example.json`。
3. 运行 `scripts/install.sh`，按提示确认。

### 使用方式
- 常规问题：由 main Agent 直接处理（默认 DuckDuckGo）。
- 复杂研究任务：由 main Agent 按策略委派 web-researcher。
- 用户明确要求 web-researcher：允许直接委派。

### 验证方式
运行：

```bash
bash scripts/validate.sh
```

该脚本会执行配置校验、Agent 绑定检查，并扫描疑似密钥泄漏。

### 安全注意事项
- 严禁提交真实 `.env`、token、API Key、私钥等敏感信息。
- `scripts/install.sh` 不覆盖 secrets，不打印任何密钥。
- web-researcher 禁止执行删除、部署、推送、写配置等高风险动作。

## English

### What Is OpenClaw Sentinel
OpenClaw Sentinel is a preset project for OpenClaw that enforces agent routing and tool boundaries. It separates routine search from deep research to reduce misuse, cost, and operational risk.

### Why the main Agent Defaults to DuckDuckGo
- DuckDuckGo is suitable for lightweight, fast, low-risk web lookup.
- It keeps default behavior simple and cost-efficient.
- It avoids unnecessary escalation for routine questions.

### Why Perplexity MCP Is Reserved for web-researcher
- Perplexity fits complex research, multi-source verification, and architecture/technical judgment.
- Restricting it to a dedicated sub-agent improves governance and auditability.
- It prevents accidental overuse in standard request handling.

### Responsibility Boundary: main Agent vs web-researcher
- main Agent: default entrypoint, normal Q&A, lightweight search, routing decisions.
- web-researcher: complex web research, verification, synthesis only; no file mutation or dangerous operations.

### Installation
1. Clone this repository.
2. Review and adapt `presets/openclaw.config.example.json`.
3. Run `scripts/install.sh` and confirm when prompted.

### Usage
- Routine requests: handled by main Agent directly (DuckDuckGo by default).
- Complex research: delegated by main Agent based on routing policy.
- Explicit user request for web-researcher: direct delegation allowed.

### Validation
Run:

```bash
bash scripts/validate.sh
```

It validates OpenClaw config, agent bindings, and scans for possible key leaks.

### Security Notes
- Never commit real `.env` values, tokens, API keys, or private keys.
- `scripts/install.sh` never overwrites secrets and never prints API keys.
- web-researcher must not delete files, deploy, push changes, or write runtime secrets/config.
