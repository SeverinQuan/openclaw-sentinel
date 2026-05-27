# OpenClaw Sentinel

> Secure Agent Routing for DuckDuckGo + Perplexity MCP  
> 面向 OpenClaw 的安全 Agent 路由与工具边界预设。

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE)
![Status](https://img.shields.io/badge/status-community%20preset-blue)
![OpenClaw](https://img.shields.io/badge/OpenClaw-Agent%20Routing-red)
![MCP](https://img.shields.io/badge/MCP-Tool%20Boundary-purple)
![Security](https://img.shields.io/badge/security-no%20secrets%20committed-brightgreen)

---

## Language / 语言

- [中文说明](#中文说明)
- [English](#english)

## Quick Jump / 快速跳转

**中文**

- [OpenClaw Sentinel 是什么](#openclaw-sentinel-是什么)
- [核心设计](#核心设计)
- [Agent 职责边界](#agent-职责边界)
- [快速开始](#快速开始)
- [项目结构](#项目结构)
- [安全边界](#安全边界)
- [验证方式](#验证方式)
- [上游贡献计划](#上游贡献计划)
- [许可证](#许可证)

**English**

- [What is OpenClaw Sentinel](#what-is-openclaw-sentinel)
- [Core Design](#core-design)
- [Agent Responsibility Boundary](#agent-responsibility-boundary)
- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [Security Boundary](#security-boundary)
- [Validation](#validation)
- [Upstream Contribution Plan](#upstream-contribution-plan)
- [License](#license)

---

# 中文说明

## OpenClaw Sentinel 是什么

**OpenClaw Sentinel** 是一个面向 OpenClaw 的 Agent 路由与工具边界预设项目。

它的目标不是替代 OpenClaw，而是为 OpenClaw 用户提供一套更清晰、更安全、更节省成本的 Agent 工具使用策略：

- `main Agent` 作为默认交互入口；
- `main Agent` 默认使用 DuckDuckGo 做轻量搜索；
- `main Agent` 不默认调用 Perplexity；
- 只有当任务足够复杂时，才委派给 `web-researcher` 子 Agent；
- `web-researcher` 专门负责 Perplexity MCP 搜索、研究、核验与总结；
- 严格禁止将真实 API Key、`.env`、token、私钥、secrets 提交到仓库。

一句话概括：

> 让 OpenClaw 的主 Agent 保持轻量、高效、低成本；让复杂研究任务交给专门的研究子 Agent。

---

## 核心设计

```text
User
  │
  ▼
main Agent
  │
  ├── 普通问答
  ├── 代码修改
  ├── 文件操作
  ├── 任务规划
  └── DuckDuckGo 轻量搜索
        │
        │ 仅当任务复杂 / 需要深度研究 / 用户明确要求
        ▼
web-researcher Sub-Agent
  │
  ├── Perplexity MCP Search
  ├── Perplexity MCP Ask
  ├── Perplexity MCP Research
  └── Perplexity MCP Reason
        │
        ▼
结构化研究结果返回 main Agent
```

---

## Agent 职责边界

### main Agent

`main Agent` 是默认入口，负责日常操作：

- 普通问答；
- 代码阅读与修改；
- 文件操作；
- 命令执行；
- 任务规划；
- 项目维护；
- 使用 DuckDuckGo 完成轻量联网检索。

适合 `main Agent` 自己处理的任务：

- 查一个链接；
- 找一个 GitHub 仓库；
- 查询某个工具的基础信息；
- 一次搜索即可回答的问题；
- 不需要复杂交叉验证的问题。

---

### web-researcher

`web-researcher` 是专用研究子 Agent，只在必要时被调用。

适合委派给 `web-researcher` 的任务：

- 深度研究；
- 多来源交叉验证；
- 技术选型；
- 架构取舍；
- 竞品分析；
- MCP / Agent 方案设计；
- 模型能力对比；
- API 状态、价格、政策等需要较新信息的问题；
- 用户明确要求调用 `web-researcher`。

`web-researcher` 只应负责：

- 搜索；
- 研究；
- 核验；
- 推理；
- 总结；
- 输出来源与不确定性。

`web-researcher` 不应执行：

- 修改项目文件；
- 删除文件；
- 部署；
- 写入配置；
- `git commit`；
- `git push`；
- 输出或读取真实 secrets。

---

## 快速开始

### 1. 克隆仓库

```bash
git clone https://github.com/SeverinQuan/openclaw-sentinel.git
cd openclaw-sentinel
```

### 2. 查看示例配置

```bash
ls presets
```

核心文件包括：

```text
presets/main.agent.md
presets/web-researcher.agent.md
presets/routing-policy.md
presets/openclaw.config.example.json
```

### 3. 准备环境变量示例

本仓库只提供 `.env.example`，不会保存真实密钥。

```bash
cp .env.example .env
```

然后在你自己的安全环境中填写真实 API Key。

请注意：

```text
不要提交 .env
不要提交真实 API Key
不要提交 secrets 目录
不要提交服务器私钥
```

### 4. 安装预设

```bash
bash scripts/install.sh
```

安装脚本应遵守以下原则：

- 先备份当前 OpenClaw 配置；
- 不覆盖 secrets；
- 不打印 API Key；
- 不提交任何敏感文件。

### 5. 验证配置

```bash
bash scripts/validate.sh
```

---

## 项目结构

```text
openclaw-sentinel/
├── README.md
├── LICENSE
├── .gitignore
├── .env.example
├── presets/
│   ├── main.agent.md
│   ├── web-researcher.agent.md
│   ├── routing-policy.md
│   └── openclaw.config.example.json
├── scripts/
│   ├── install.sh
│   ├── validate.sh
│   └── backup-openclaw-config.sh
└── docs/
    ├── architecture.md
    ├── security.md
    ├── usage.md
    └── upstream-contribution-plan.md
```

---

## 安全边界

OpenClaw Sentinel 的核心原则是：

> 工具能力可以增强，但工具边界必须清晰。

本仓库禁止提交：

- `.env`
- `*.env`
- API Key
- token
- secret
- cookie
- SSH 私钥
- OAuth code
- 真实 OpenClaw 运行配置
- `/root/.config/openclaw/secrets`
- 任何包含用户凭据的文件

建议推送前执行：

```bash
grep -R "pplx-" .
grep -R "sk-" .
grep -R "API_KEY=" .
grep -R "SECRET" .
grep -R "TOKEN" .
```

如果发现真实密钥，应立即停止：

```bash
git reset
```

并清理敏感内容后重新提交。

---

## 验证方式

运行：

```bash
bash scripts/validate.sh
```

验证内容包括：

- OpenClaw 配置是否可解析；
- Agent 绑定是否符合预期；
- 是否存在疑似真实密钥；
- 是否误提交 `.env` 或 secrets 文件；
- `main Agent` 与 `web-researcher` 的职责边界是否清晰。

---

## 上游贡献计划

OpenClaw Sentinel 当前作为一个独立社区 preset 项目维护。

后续可以向 `openclaw/openclaw` 提交文档型 PR，而不是直接要求上游合并整个项目。

推荐贡献形式：

- `docs`: 新增 Agent routing guide；
- `examples`: 新增 DuckDuckGo + Perplexity MCP routing example；
- `community`: 新增 community preset 入口；
- `security guide`: 新增 MCP tool boundary best practices。

建议 PR 标题：

```text
docs: add secure agent routing pattern for DuckDuckGo and Perplexity MCP
```

目标是让更多 OpenClaw 用户了解：

- 如何避免主 Agent 过度调用昂贵研究工具；
- 如何将 Perplexity MCP 限定给研究子 Agent；
- 如何在 Agent 系统中建立清晰的工具边界；
- 如何避免 secrets 被错误提交到仓库。

---

## 许可证

本项目采用 [MIT License](./LICENSE) 开源。

你可以自由使用、复制、修改、合并、发布、分发和再授权本项目代码与文档，但需要保留原始版权声明和许可证声明。

---

# English

## What is OpenClaw Sentinel

**OpenClaw Sentinel** is an agent routing and tool boundary preset for OpenClaw.

It is not a replacement for OpenClaw. Instead, it provides a safer and more cost-aware routing pattern for users who want to combine lightweight search with a dedicated research sub-agent.

The basic idea:

- `main Agent` remains the default interaction entrypoint;
- `main Agent` uses DuckDuckGo for lightweight search by default;
- `main Agent` does not call Perplexity by default;
- complex research tasks are delegated to `web-researcher`;
- `web-researcher` is responsible for Perplexity MCP search, research, verification, and reasoning;
- real API keys, `.env` files, tokens, private keys, and secrets must never be committed.

In one sentence:

> Keep the main Agent lightweight and cost-efficient, while delegating complex research to a dedicated Perplexity-powered sub-agent.

---

## Core Design

```text
User
  │
  ▼
main Agent
  │
  ├── General Q&A
  ├── Code editing
  ├── File operations
  ├── Task planning
  └── DuckDuckGo lightweight search
        │
        │ Only when the task is complex / research-heavy / explicitly requested
        ▼
web-researcher Sub-Agent
  │
  ├── Perplexity MCP Search
  ├── Perplexity MCP Ask
  ├── Perplexity MCP Research
  └── Perplexity MCP Reason
        │
        ▼
Structured research result returned to main Agent
```

---

## Agent Responsibility Boundary

### main Agent

The `main Agent` is the default entrypoint.

It handles:

- general Q&A;
- code reading and editing;
- file operations;
- command execution;
- task planning;
- project maintenance;
- lightweight web lookup through DuckDuckGo.

Tasks suitable for `main Agent`:

- finding a link;
- checking a GitHub repository;
- looking up basic documentation;
- answering a question that requires only one lightweight search;
- handling routine requests without multi-source verification.

---

### web-researcher

`web-researcher` is a dedicated research sub-agent.

It should only be invoked when needed.

Tasks suitable for `web-researcher`:

- deep research;
- multi-source verification;
- technical comparison;
- architecture decisions;
- competitor analysis;
- MCP / Agent system design;
- model capability comparison;
- recent API status, pricing, policy, or ecosystem changes;
- explicit user request to call `web-researcher`.

`web-researcher` should only perform:

- search;
- research;
- verification;
- reasoning;
- summarization;
- source-aware reporting;
- uncertainty reporting.

`web-researcher` should not perform:

- project file modification;
- file deletion;
- deployment;
- config writing;
- `git commit`;
- `git push`;
- reading or printing real secrets.

---

## Quick Start

### 1. Clone this repository

```bash
git clone https://github.com/SeverinQuan/openclaw-sentinel.git
cd openclaw-sentinel
```

### 2. Review preset files

```bash
ls presets
```

Main preset files:

```text
presets/main.agent.md
presets/web-researcher.agent.md
presets/routing-policy.md
presets/openclaw.config.example.json
```

### 3. Prepare environment example

This repository only provides `.env.example`.

It does not store real credentials.

```bash
cp .env.example .env
```

Fill real keys only in your own secure runtime environment.

Do not commit:

```text
.env
real API keys
secrets directory
private keys
runtime credentials
```

### 4. Install preset

```bash
bash scripts/install.sh
```

The install script should:

- back up the existing OpenClaw config;
- avoid overwriting secrets;
- avoid printing API keys;
- avoid committing sensitive files.

### 5. Validate

```bash
bash scripts/validate.sh
```

---

## Project Structure

```text
openclaw-sentinel/
├── README.md
├── LICENSE
├── .gitignore
├── .env.example
├── presets/
│   ├── main.agent.md
│   ├── web-researcher.agent.md
│   ├── routing-policy.md
│   └── openclaw.config.example.json
├── scripts/
│   ├── install.sh
│   ├── validate.sh
│   └── backup-openclaw-config.sh
└── docs/
    ├── architecture.md
    ├── security.md
    ├── usage.md
    └── upstream-contribution-plan.md
```

---

## Security Boundary

The core principle of OpenClaw Sentinel is:

> Tool capability can be expanded, but tool boundaries must remain explicit.

This repository must not include:

- `.env`
- `*.env`
- API keys
- tokens
- secrets
- cookies
- SSH private keys
- OAuth codes
- real OpenClaw runtime config
- `/root/.config/openclaw/secrets`
- any file containing user credentials

Before pushing, run:

```bash
grep -R "pplx-" .
grep -R "sk-" .
grep -R "API_KEY=" .
grep -R "SECRET" .
grep -R "TOKEN" .
```

If a real secret is found, stop immediately:

```bash
git reset
```

Then remove the sensitive content before committing again.

---

## Validation

Run:

```bash
bash scripts/validate.sh
```

The validation process checks:

- whether OpenClaw config can be parsed;
- whether agent bindings look correct;
- whether possible real secrets exist;
- whether `.env` or secrets files were accidentally included;
- whether the `main Agent` and `web-researcher` boundaries are clearly separated.

---

## Upstream Contribution Plan

OpenClaw Sentinel is currently maintained as an independent community preset.

A future contribution to `openclaw/openclaw` should preferably be a documentation or example PR, rather than a full project merge.

Possible upstream contribution formats:

- `docs`: add an Agent routing guide;
- `examples`: add a DuckDuckGo + Perplexity MCP routing example;
- `community`: add a community preset entry;
- `security guide`: add MCP tool boundary best practices.

Suggested PR title:

```text
docs: add secure agent routing pattern for DuckDuckGo and Perplexity MCP
```

The goal is to help OpenClaw users understand:

- how to avoid overusing expensive research tools from the main Agent;
- how to reserve Perplexity MCP for a research sub-agent;
- how to define clear tool boundaries in an Agent system;
- how to prevent secrets from being committed accidentally.

---

## License

This project is open-sourced under the [MIT License](./LICENSE).

You are free to use, copy, modify, merge, publish, distribute, sublicense, and sell copies of this project, provided that the original copyright notice and license notice are included.

---

## Repository

GitHub:

```text
https://github.com/SeverinQuan/openclaw-sentinel
```