# MQL5 FCZ Reclaim Model Tasks

> Feature: mql5-fcz-reclaim-model  
> Status: ready-for-local-issue-draft  
> Rule: tasks must become bounded vertical slices before Codex execution.

---

## 1. Task Principles

后续任务必须遵守：

```text
1. 不重新发明方法论。
2. 不把聊天记录当长期事实。
3. 不跳过 spec / plan / tasks / checklist。
4. 不让 Codex 扩展 scope。
5. 不把观察指标升级为自动下单 EA。
6. 不声称策略有效，除非有真实样本、消融实验、样本外验证和执行成本证据。
7. 每个 issue 都必须能被 tests / QA / review / owner decision 验证。
```

---

## 2. Completed / Current Task

### Task P28: Create project-level spec set

状态：本阶段执行中 / 完成后可进入 issue draft。

目标：创建项目级 spec 四件套。

输出：

```text
specs/mql5-fcz-reclaim-model/spec.md
specs/mql5-fcz-reclaim-model/plan.md
specs/mql5-fcz-reclaim-model/tasks.md
specs/mql5-fcz-reclaim-model/checklist.md
```

验收：

```text
1. 四个文件存在。
2. 索引已登记。
3. 变更记录已登记。
4. python scripts/validate_all.py 通过。
```

---

## 3. Recommended GitHub Issue Slices

以下任务是后续可拆 issue 的 vertical slices。

---

### Issue Slice 1: Real sample collection workflow hardening

推荐优先级：P1  
推荐状态：Ready for GitHub issue draft  
Codex 可执行：部分可执行，需避免假造样本数据。

#### Background

当前已有：

```text
07_样本标注/反证样本库_v0.1.csv
07_样本标注/真实样本采集执行清单_v0.1.md
07_样本标注/样本记录/FCZ_B_0001.md
07_样本标注/样本记录/FCZ_C_0001.md
07_样本标注/样本记录/FCZ_D_0001.md
```

但真实样本仍多为 pending，下一步应硬化流程，而不是伪造数据。

#### Scope

```text
1. 读取真实样本采集执行清单。
2. 检查前三个样本记录模板是否覆盖必填字段。
3. 生成真实样本采集 QA checklist。
4. 可选：创建 scripts/validate_sample_records.py，检查样本 Markdown 记录是否存在必填标题。
5. 不填真实市场数据，除非 owner 提供数据源。
```

#### Non-scope

```text
1. 不抓取未知交易数据。
2. 不生成模拟样本冒充真实样本。
3. 不计算策略胜率。
4. 不修改交易规则。
```

#### Acceptance Criteria

```text
1. 有本地 issue 草案。
2. 有 Codex handoff。
3. 如实现 validator，必须有 unittest。
4. validate_all 仍通过。
5. 文档明确 pending_real_sample 不等于验证完成。
```

---

### Issue Slice 2: MQL5 observer MVP spec set

推荐优先级：P2  
推荐状态：Ready for spec  
Codex 可执行：只可生成 spec，不应直接写 MQL5 代码。

#### Background

当前策略最合理商业角色是：

```text
MQL5观察指标 + 样本标注器 + 风险审查器
```

已有参考：

```text
08_指标需求/MQL5观察指标需求_v0.2.md
08_指标需求/MQL5观察指标字段映射与模块优先级_v0.1.md
09_规则与回测/状态机规则整合_v0.1.md
07_样本标注/样本字段表_v0.1.md
```

#### Scope

创建：

```text
specs/mql5-observer-mvp/spec.md
specs/mql5-observer-mvp/plan.md
specs/mql5-observer-mvp/tasks.md
specs/mql5-observer-mvp/checklist.md
```

内容必须明确：

```text
1. 输出 current_state，而非 buy/sell signal。
2. 输出 POC / AVWAP / sweep / reclaim / pullback / second_start 相关观察字段。
3. 不自动下单。
4. 不管理仓位。
5. 不连接交易所 API。
```

#### Acceptance Criteria

```text
1. 四件套存在。
2. 明确 MVP 输入输出。
3. 明确 MQL5 指标只做观察状态与导出字段。
4. 明确后续代码实现前需 GitHub issue 与 owner decision。
```

---

### Issue Slice 3: Local GitHub issue drafts and Codex handoff set

推荐优先级：P3  
推荐状态：Ready for GitHub issue draft  
Codex 可执行：可以。

#### Scope

基于本 tasks.md 生成：

```text
10_工程化交接/issues/issue-002-real-sample-collection-workflow.md
10_工程化交接/issues/issue-003-mql5-observer-mvp-spec.md
10_工程化交接/codex_handoff/issue-002-real-sample-collection-workflow.md
10_工程化交接/codex_handoff/issue-003-mql5-observer-mvp-spec.md
```

#### Acceptance Criteria

```text
1. 每个 issue 草案包含背景、范围、非范围、验收标准、测试要求、风险、Codex handoff 输入。
2. 不假造真实 GitHub issue 编号。
3. Codex handoff 明确只实现一个 issue。
4. 索引与变更记录更新。
```

---

### Issue Slice 4: Spec artifact validator

推荐优先级：P4  
推荐状态：Backlog  
Codex 可执行：可以，适合 TDD。

#### Scope

创建：

```text
scripts/validate_specs.py
tests/test_validate_specs.py
```

校验：

```text
1. specs/mql5-fcz-reclaim-model 四件套存在。
2. 每个 spec set 至少包含 spec.md、plan.md、tasks.md、checklist.md。
3. checklist.md 包含 Codex、CI、owner decision 关键词。
4. spec.md 包含 Non-goals / Acceptance Criteria / Testing Requirements。
```

#### Acceptance Criteria

```text
1. unittest 覆盖缺文件、缺关键章节、有效 spec set。
2. validate_specs.py 可被 validate_all.py 串联。
3. validate_all.py 仍通过。
```

---

### Issue Slice 5: GitHub repo initialization / remote connection

推荐优先级：Owner decision  
推荐状态：Blocked until owner provides repo URL / permission  
Codex 可执行：不建议交给 Codex；应由 maintainer/orchestrator 或 human 执行。

#### Scope

```text
1. owner 提供 repo URL / owner-repo。
2. owner 确认是否允许当前目录 git init / push。
3. 检查敏感文件。
4. 设置 remote。
5. 推送 main。
6. 创建真实 GitHub issue。
```

#### Blockers

```text
1. 当前目录此前探测为不是 git repo。
2. gh CLI 此前探测为不可用。
3. 需要确认 token/remote 方式，但不得在文档中保存凭据。
```

---

## 4. Recommended First Next Task

推荐下一步不是继续理论深化，而是：

```text
Issue Slice 1: Real sample collection workflow hardening
```

原因：

```text
1. 当前策略成熟度瓶颈是真实样本与反证验证，不是更多概念。
2. 已经有 CSV、字段表、状态机、校验器，可以进入样本流程硬化。
3. 不需要 GitHub 真实 repo 也能先生成本地 issue 草案。
```

---

## 5. Codex Handoff Gate

任何 issue 交给 Codex 前，必须包含：

```text
Read:
- AGENTS.md
- SOURCE_OF_TRUTH.md
- specs/<feature>/spec.md
- specs/<feature>/plan.md
- specs/<feature>/tasks.md
- specs/<feature>/checklist.md
- 相关 issue 草案

Task:
Implement issue only.

Rules:
- Do not expand scope.
- Do not invent market data.
- Do not write live trading logic.
- Prefer TDD for scripts.
- Run available tests.
- Report changed files and exact verification output.
- If blocked, stop and ask with owner decision brief.
```

---

## 6. Stop Conditions

遇到以下情况必须停止并请求 owner decision：

```text
1. 需要 GitHub repo URL / remote / token。
2. 需要真实市场数据来源。
3. 需要接交易平台 API。
4. 需要决定是否允许自动下单。
5. 需要删除或大规模移动历史资料。
6. 测试失败且修复会改变既有策略定义。
7. 发现凭据、私钥、token 或敏感连接字符串。
```

---

## 7. Stage Label

当前四件套完成后，阶段标签为：

```text
Ready for GitHub issue draft
```

不应标记为：

```text
Ready for Codex
```

直到具体 issue 草案和 Codex handoff 已生成。
