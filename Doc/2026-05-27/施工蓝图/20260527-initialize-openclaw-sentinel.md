# Code Change Log

## 时间
- 日期: 2026-05-27
- 任务: 初始化 OpenClaw Sentinel 项目结构并推送 GitHub

## 变更摘要
- 创建 OpenClaw Sentinel 项目基础目录与文件。
- 编写中英双语 README、路由策略与 Agent 预设。
- 新增安装/备份/校验脚本并赋予执行权限。
- 增加安全忽略规则与示例环境变量文件。
- 修复 `scripts/validate.sh` 对 `.env.example` 的误报逻辑。

## 影响文件
- `README.md`: 项目定位、职责边界、安装/使用/验证/安全说明（中英双语）
- `LICENSE`: MIT 许可证
- `.gitignore`: 敏感文件与常见噪声忽略规则
- `.env.example`: API key 占位示例
- `presets/main.agent.md`: main Agent 路由与默认工具规则
- `presets/web-researcher.agent.md`: web-researcher 行为边界
- `presets/routing-policy.md`: 路由触发条件与策略
- `presets/openclaw.config.example.json`: 示例配置
- `scripts/install.sh`: 安装与保护 secrets 的策略实现
- `scripts/validate.sh`: OpenClaw 校验与疑似密钥扫描
- `scripts/backup-openclaw-config.sh`: 本地配置备份
- `docs/architecture.md`: 两层 Agent 架构
- `docs/security.md`: 安全控制面
- `docs/usage.md`: 快速使用说明

## 验证
- 执行命令: `bash scripts/validate.sh`
- 结果: 通过
- 执行命令: `grep -R "pplx-" . && grep -R "sk-" . && grep -R "API_KEY=" . && grep -R "SECRET" . && grep -R "TOKEN" .`
- 结果: 仅命中示例占位和扫描脚本自身，无真实密钥

## 风险与回滚
- 风险: 远端仓库预置文件可能导致 rebase 冲突（本次已处理 LICENSE 冲突）
- 回滚: `git reset --hard <commit>` 或 `git revert <commit>`
