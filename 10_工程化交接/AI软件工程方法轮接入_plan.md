# AI 软件工程方法轮接入 plan

## 1. 需求澄清摘要

### 当前想做什么

把当前项目从“聊天中不断推进”升级为一套可沉淀到 GitHub 的 AI 软件工程工作流。

该工作流覆盖：

```text
需求拷问 -> spec -> issue -> Codex -> TDD -> QA/CI -> PR -> 人类判断 -> GitHub 记录
```

### 理解的目标

```text
1. 建立需求澄清与 spec 生成模板。
2. 让 Codex 只作为执行器，而不是继续扩展需求。
3. 让 GitHub 成为长期记忆。
4. 把 owner 决策点从 AI 自动执行中分离出来。
5. 为后续 MQL5 观察器、样本标注器、状态机实现等工程任务提供标准交接方式。
```

### 关键约束

```text
1. 不急着编码。
2. 不编造项目事实。
3. UNKNOWN 必须显式标记。
4. 没有验收标准不交给 Codex。
5. Codex 是 maker，review/CI/QA/人类是 checker。
6. GitHub 是长期记忆，聊天只是临时工作台。
```

### 当前不确定点

```text
1. GitHub repo 是否已存在：UNKNOWN。
2. 当前第一个要落地的工程 feature 是什么：UNKNOWN。
3. Codex 执行环境：UNKNOWN。
4. CI / Playwright / 安全扫描是否已配置：UNKNOWN。
5. 是否允许本 Agent 创建 GitHub issue：UNKNOWN。
```

---

## 2. 好问题清单

### Q1

原始模糊问题：

```text
我要接入 AI 软件工程方法轮。
```

更好的问题：

```text
第一个要用这套方法轮工程化的具体 feature 是什么？
```

为什么这样问：

```text
没有具体 feature，spec 和 issue 只能是流程模板，不能进入 Codex 执行。
```

需要 owner 回答：

```text
选择第一个 feature，例如 MQL5观察指标MVP、样本CSV校验器、状态机标注器、GitHub issue 模板等。
```

影响决策：

```text
决定 issue 拆分、测试策略、Codex handoff 内容。
```

### Q2

原始模糊问题：

```text
记录到 GitHub。
```

更好的问题：

```text
GitHub repo 地址是什么？是否允许 Agent 创建 issue / branch / PR？
```

为什么这样问：

```text
GitHub 是长期记忆，但创建 issue/PR 属于外部副作用，需要 owner 授权。
```

需要 owner 回答：

```text
repo URL、权限范围、是否允许创建 issue。
```

影响决策：

```text
决定只生成本地 issue 草案，还是实际调用 gh 创建 issue。
```

### Q3

原始模糊问题：

```text
Codex 执行。
```

更好的问题：

```text
Codex 应该在哪个环境执行？本地仓库、GitHub Codespaces、远程容器，还是当前 Hermes 工作区？
```

为什么这样问：

```text
执行环境影响路径、测试命令、权限、依赖安装和 CI 结果。
```

需要 owner 回答：

```text
Codex 运行位置与权限。
```

影响决策：

```text
决定 handoff 的 Read 路径、测试命令和 stop conditions。
```

### Q4

原始模糊问题：

```text
QA / Playwright / 可访问性 / 安全审计。
```

更好的问题：

```text
当前项目是否有 UI 或 Web 端？如果没有，Playwright/a11y 是否只是未来模板要求？
```

为什么这样问：

```text
MQL5/Markdown 知识库可能没有 UI；不应强行引入无关测试。
```

需要 owner 回答：

```text
当前是否存在 UI、Web dashboard 或未来计划。
```

影响决策：

```text
决定 QA 检查是 Playwright/a11y，还是 Markdown lint、CSV schema、MQL5 compile、Python unit tests。
```

---

## 3. 缺失信息清单

### 必须回答

```text
1. 第一个要工程化的具体 feature。
2. GitHub repo 地址和是否允许创建 issue。
3. Codex 执行环境与权限。
4. 当前是否允许修改 AGENTS.md / CONTEXT.md / specs/ 结构。
```

### 最好回答

```text
1. 是否已有 CI。
2. 是否已有测试命令。
3. 是否有 Web/UI，因此需要 Playwright/a11y。
4. 目标语言/框架，例如 MQL5、Python、Node、Markdown-only。
```

### 可以后置

```text
1. PR 模板细节。
2. ADR 编号规范。
3. 发布流程。
4. 安全扫描工具选型。
```

---

## 4. 风险地图

```text
产品风险：需求轮本身做得太大，无法落到第一个 feature。
技术风险：没有代码仓库或测试命令，Codex 无法验证。
安全风险：Codex 误触凭据、权限或发布流程。
数据风险：聊天记录未写入 repo，长期记忆丢失。
权限风险：未经授权创建 issue/PR/branch。
测试风险：验收标准抽象，测试不可执行。
运维风险：CI 不存在或失败原因不明。
成本风险：过度引入 Playwright/安全扫描/多 Agent 流程，超过当前项目阶段需要。
```

---

## 5. 实施计划

### Phase 1：本地 spec 四件套

产出：

```text
10_工程化交接/AI软件工程方法轮接入_spec.md
10_工程化交接/AI软件工程方法轮接入_plan.md
10_工程化交接/AI软件工程方法轮接入_tasks.md
10_工程化交接/AI软件工程方法轮接入_checklist.md
```

### Phase 2：issue 草案

产出：

```text
10_工程化交接/issues/issue-001-建立需求拷问与spec模板.md
10_工程化交接/issues/issue-002-建立Codex交接模板.md
10_工程化交接/issues/issue-003-建立owner-decision-brief模板.md
```

### Phase 3：等待 owner 决策

需要 owner 决策：

```text
1. 是否创建 GitHub issue。
2. 第一个真实工程 feature 是什么。
3. 是否允许 Codex 执行。
```
