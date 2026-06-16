# Hermes 调用 Codex 命令编排工作流 v0.1

> 分线：10_工程化交接 / 多端口 AI 工作流 / Codex 命令编排  
> 状态：v0.1 / 需求澄清端确认后的执行认知  
> 目的：把“不是用户直接使用 Codex，而是 Hermes 作为控制端调用 Codex worker”的工作方式固定到项目真源中，避免后续 Agent 把 Codex 当成一个泛泛执行端，或在错误场景下使用错误命令。

---

## 1. 本文件解决什么

当前项目已经形成多端口工作流，但仍有一个关键风险：

```text
只说“用 Codex”，不说明由谁调用、用什么命令、什么 sandbox、是否后台、输出写哪里、如何审查。
```

正确认知是：

```text
Hermes = 需求澄清端 / 控制端 / Codex 命令编排器 / checker
Codex = 被 Hermes 调用的 maker worker
GitHub + CI = repo 真源与客观验证
Owner = 方向、权限、合并、交易阶段门决策者
```

因此，本项目后续复杂任务不能把 Codex 当成单一“执行端”，而要由 Hermes 需求澄清端根据任务性质选择合适的 Codex 命令组合。

---

## 2. 不同端口的真实含义

### 2.1 需求澄清端

工具：

```text
Hermes 当前 Telegram bot / Hermes CLI
```

职责：

```text
需求拷问
好问题生成
任务路由
Codex prompt 文件生成
Codex 命令模式选择
禁止事项与权限边界
验收标准与 checker 计划
Owner decision brief
```

不做：

```text
不直接让模糊需求进入 Codex
不在需求未澄清时改 repo
不让 maker 自己审查自己
不授权交易私钥、swap、实盘、自动下单
```

---

### 2.2 理论生成端

工具：

```text
Codex CLI，由 Hermes terminal 调用
```

职责：

```text
根据需求澄清端生成的 prompt，生成长理论草案、系统层次、资料归位、缺口清单、MVP、迁移路线。
```

建议模式：

```text
codex exec + read-only sandbox + add-dir + output-last-message + stdin prompt + background
```

不做：

```text
不改 repo
不写代码
不接 API key
不接 private key
不做 swap
不做自动下单
不提交 git
```

---

### 2.3 执行落库端

工具：

```text
Codex CLI，由 Hermes terminal 调用
```

职责：

```text
把已经通过 Hermes 审查的理论草案拆成 repo 文件，更新入口、索引、变更记录，并可运行验证命令。
```

建议模式：

```text
codex exec + workspace-write sandbox
fallback: danger-full-access（仅当 workspace-write 在 Hermes gateway 环境失败，且工作区干净、任务窄、允许路径明确）
```

不做：

```text
不重新发明理论方向
不越权接 GMGN_API_KEY / GMGN_PRIVATE_KEY
不做交易执行代码
不合并 PR
不删除旧文件
不大规模搬迁目录
```

---

### 2.4 验证审查端

工具：

```text
Hermes + git + scripts/validate_all.py + gh + GitHub Actions
```

职责：

```text
检查 Codex 输出是否符合需求 brief、是否越权、是否更新真源入口、是否通过 validate_all 和 CI。
```

---

## 3. Codex 命令能力分类

本机 Codex CLI 版本：

```text
codex-cli 0.139.0
```

常用命令按项目用途分为：

```text
codex doctor            # 诊断安装、认证、配置、运行环境
codex exec              # 非交互式执行任务，最常用
codex exec resume       # 继续上一次 exec session
codex resume            # 恢复交互式 session
codex review            # 代码 / diff / PR 审查
codex exec review       # 非交互式 review
codex apply             # 应用 Codex 最新 diff
codex sandbox           # sandbox 相关能力
codex features          # 查看 feature flags
codex update            # 更新 Codex
```

项目默认不要使用：

```text
--dangerously-bypass-approvals-and-sandbox
```

除非 Owner 明确授权，并且任务运行在外部隔离环境。

---

## 4. 命令选择决策表

### 4.1 长理论生成

适合场景：

```text
生成 GMGN 自建 meme 量化交易系统总控理论
生成大型归位矩阵
生成阶段门与 MVP 总纲
```

推荐命令：

```bash
codex exec \
  -C "/c/Users/Administrator/Documents/MQL5_第一控盘区成本中枢回收模型_学习资料" \
  --add-dir "/c/Users/Administrator/gmgn_requirement_knowledge_base" \
  --add-dir "/c/Users/Administrator/source_repos/gmgn-skills" \
  --sandbox read-only \
  --output-last-message "/c/Users/Administrator/AppData/Local/hermes/profiles/cangwei/home/codex-outputs/meme-quant-master-theory-draft.md" \
  - < "/c/Users/Administrator/AppData/Local/hermes/profiles/cangwei/home/codex-prompts/meme-quant-master-theory.md"
```

Hermes terminal 调用方式：

```text
background=True
pty=True
notify_on_complete=True
```

原因：

```text
长任务不阻塞；read-only 防止污染 repo；--add-dir 允许读取 GMGN 知识库和 gmgn-skills；--output-last-message 避免终端输出过长；stdin prompt 避免超长命令行。
```

完成后 Hermes 必须检查：

```bash
git diff --exit-code
test -s "/c/Users/Administrator/AppData/Local/hermes/profiles/cangwei/home/codex-outputs/meme-quant-master-theory-draft.md"
```

如果出现 repo diff，说明理论生成端越权，必须停止并审查。

---

### 4.2 短总结 / 小审计

适合场景：

```text
总结单个文件
审计某个小目录
生成短 checklist
```

推荐命令：

```bash
codex exec \
  -C "/c/Users/Administrator/Documents/MQL5_第一控盘区成本中枢回收模型_学习资料" \
  --sandbox read-only \
  - < prompt.md
```

Hermes 调用方式：

```text
foreground 或 background 均可；预计少于 2-3 分钟可 foreground。
```

---

### 4.3 理论未完成，需要继续

适合场景：

```text
Codex 输出被截断
长理论只完成前半部分
需要保持同一上下文继续
```

命令：

```bash
codex exec resume --last
```

或：

```bash
codex resume --last
```

需求端判断：

```text
如果已有 draft 文件，更稳的方式是新建 prompt：基于 draft.md 继续补第 X 部分，而不是盲目 resume。
```

---

### 4.4 执行落库

适合场景：

```text
把审查通过的理论草案拆成 13_量化交易系统架构/ 文件
更新 README / SOURCE_OF_TRUTH / ROADMAP / 索引 / 变更记录
```

推荐命令：

```bash
codex exec \
  -C "/c/Users/Administrator/Documents/MQL5_第一控盘区成本中枢回收模型_学习资料" \
  --sandbox workspace-write \
  --output-last-message "/c/Users/Administrator/AppData/Local/hermes/profiles/cangwei/home/codex-outputs/meme-quant-master-landing-report.md" \
  - < "/c/Users/Administrator/AppData/Local/hermes/profiles/cangwei/home/codex-prompts/meme-quant-master-landing.md"
```

如果 workspace-write 在 Hermes gateway/service 环境失败，可 fallback：

```bash
codex exec \
  -C "/c/Users/Administrator/Documents/MQL5_第一控盘区成本中枢回收模型_学习资料" \
  --sandbox danger-full-access \
  --output-last-message "/c/Users/Administrator/AppData/Local/hermes/profiles/cangwei/home/codex-outputs/meme-quant-master-landing-report.md" \
  - < "/c/Users/Administrator/AppData/Local/hermes/profiles/cangwei/home/codex-prompts/meme-quant-master-landing.md"
```

fallback 使用条件：

```text
1. git status 先确认工作区干净。
2. prompt 明确 allowed_paths。
3. Codex 只允许改指定文件/目录。
4. 完成后 Hermes 必须检查 git diff、git diff --check、validate_all。
```

执行端完成后，Hermes 必须运行：

```bash
git diff --stat
git diff --check
python scripts/validate_all.py
git status --short --branch
```

commit/push 最好由 Hermes 执行，而不是 Codex 自己执行。

---

### 4.5 PR / diff 审查

适合场景：

```text
需要第二意见审查 PR 或 diff。
```

可用命令：

```bash
codex review
codex exec review
```

项目规则：

```text
Codex review 只能作为第二意见；最终 checker 仍由 Hermes / CI / Owner 决定。
```

---

### 4.6 生成 patch 后再应用

适合场景：

```text
代码改动较高风险
想先看 Codex 生成的 diff，再决定是否应用
```

可用命令：

```bash
codex apply
```

推荐流程：

```text
Codex 生成 diff → Hermes 审查 diff → codex apply → validate_all → commit
```

当前文档落库任务通常不必使用 apply；高风险代码修改才考虑。

---

### 4.7 非 git 知识库分析

适合场景：

```text
分析 gmgn_requirement_knowledge_base 这类非 git 目录
```

推荐命令：

```bash
codex exec \
  --skip-git-repo-check \
  -C "/c/Users/Administrator/gmgn_requirement_knowledge_base" \
  --sandbox read-only \
  - < prompt.md
```

---

### 4.8 需要外部资料搜索

可用参数：

```bash
--search
```

默认不启用。

使用条件：

```text
本地资料不足，需要当前外部资料、官方 API 文档、市场最新信息。
```

当前项目大多数任务是收敛已有资料，不应默认联网扩散。

---

### 4.9 结构化输出

可用参数：

```bash
--output-schema <FILE>
--json
```

适合：

```text
路由决策
任务分类
自动化检查报告
固定字段审查结果
```

不适合：

```text
长 Markdown 总理论
```

长 Markdown 优先用：

```bash
--output-last-message <FILE>
```

---

## 5. 当前项目的默认命令策略

```text
长理论生成：codex exec + read-only + add-dir + output-last-message + background
短审计：codex exec + read-only + foreground
落库改文档：codex exec + workspace-write + output-last-message + background
sandbox 失败：workspace-write → danger-full-access fallback
高风险代码改动：先生成 diff，Hermes 审查后再 apply
非 git 知识库：--skip-git-repo-check
需要外部资料：显式 --search，默认不用
结构化 routing：--output-schema 或 --json
最终 checker：Hermes + validate_all + CI + Owner
```

---

## 6. 当前 GMGN 量化总控任务的推荐调用链

```text
1. Hermes 需求澄清端生成 Codex 理论 prompt 文件。
2. Hermes 以 background + pty + notify_on_complete 调用 Codex 理论端。
3. Codex 使用 read-only sandbox，多目录读取，输出到 codex-outputs/*.md。
4. Hermes 检查 git diff，确保理论端未改 repo。
5. Hermes 审查理论草案是否符合禁止事项和量化系统层次。
6. 若通过，Hermes 生成落库 prompt。
7. Hermes 调用 Codex 执行落库端，允许 workspace-write，但限定 allowed_paths。
8. Hermes 检查 diff、运行 validate_all。
9. Hermes commit / push / PR / CI。
10. Owner 决策是否合并。
```

---

## 7. Allowed paths 模板

执行落库端默认只允许修改：

```text
13_量化交易系统架构/*
README.md
SOURCE_OF_TRUTH.md
ROADMAP.md
00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md
00_知识库设计规范/05_索引与变更记录/设计规范变更记录.md
```

默认不允许修改：

```text
mql5/indicators/*
07_样本标注/*
09_规则与回测/*
任何交易执行代码
任何 .env / secret / key 文件
任何 GitHub workflow
```

如需修改不允许路径，必须回到需求澄清端重新授权。

---

## 8. 本版结论

本项目后续高效 AI 执行的关键不是“是否使用 Codex”，而是：

```text
由 Hermes 需求澄清端根据任务性质选择合适的 Codex 命令组合。
```

固定原则：

```text
Hermes 负责编排、审查、验证、提交；
Codex 负责被调用的 maker 工作；
GitHub/CI 负责客观真源和检查；
Owner 负责方向、权限、合并和交易阶段门。
```

当前 GMGN 自建 meme 量化交易系统总控任务的最佳理论生成命令是：

```text
codex exec + -C meme repo + --add-dir GMGN 知识库 + --add-dir gmgn-skills + --sandbox read-only + --output-last-message + stdin prompt + Hermes background 调用
```
