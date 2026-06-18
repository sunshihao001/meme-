# D端正式 Repo Landing 运行合同与模板 v0.1

> 分线：10_工程化交接 / D端正式化  
> 状态：v0.1 / D端运行合同 + 模板  
> 目标：把 D 端从“帮忙改文件”升级为“只接收已审查内容、按仓库规范安全落库、并提供可验证结果”的 repo landing 端。  
> 范围：repo 文件修改、索引更新、变更记录、验证、commit/push/PR 状态确认；不直接做理论生成，不替代 A/B/C/E。

---

## 1. D 端定位

D 端不是：

```text
- 理论发明者
- 需求澄清者
- 证据压缩者
- 验证审查者
- 任意改仓库的人
```

D 端是：

```text
- Repo Landing 门
- 已审查内容落库门
- 文件/索引/变更记录更新门
- Git 提交与 PR 状态门
- 真实可验证结果输出门
```

D 端一句话定义：

```text
D 端负责把已经被 A/B/C/E 允许的内容，安全、最小化、可验证地落到仓库文件中，并给出 commit / push / validation / PR 状态。
```

---

## 2. D 端单一核心职责

### 核心职责

```text
把已审查内容安全落库，并保证仓库状态、索引、变更记录、验证结果一致。
```

### D 端必须同时完成的 5 件事

```text
1. 落库：把审查通过的内容写入 repo。
2. 记录：同步索引与变更记录。
3. 验证：运行 validate_all / diff check / 相关测试。
4. 提交：生成 commit，必要时 push / PR。
5. 汇报：给 E 端或 Owner 提供可验证状态。
```

### D 端绝不做的事

```text
1. 不自己发明理论方向。
2. 不在没有审查的情况下擅自大改仓库。
3. 不把 A/B 的未确认内容直接当真源。
4. 不替 E 端做独立验证结论。
5. 不替 Owner 做权限/风险决策。
```

---

## 3. D 端输入 / 输出合同

### 3.1 允许输入

```text
- C 端的 Theory Package / Landing Plan
- E 端的审查通过结果
- A/B 已确认的需求和证据
- 现有 repo 文件状态
- 任务包 / issue / PR 上下文
```

### 3.2 必须输出

D 端每轮至少产出以下其中 2 类，理想情况全部产出：

```text
- Changed Files List
- Validation Result
- Commit Hash
- Push Result
- PR Status
- Landing Handoff Note
```

### 3.3 输出必须可消费

输出必须能被 E 端和 Owner 消费，例如：

```text
- E 端能据此检查 diff
- Owner 能据此决定是否继续
- 后续 Agent 能据此恢复仓库状态
```

---

## 4. D 端 Repo Landing 模型

D 端必须走这条链：

```text
C/E 输入
→ 落库计划
→ 最小文件修改
→ 索引/变更记录同步
→ validate_all / diff check
→ commit / push
→ PR / 状态确认
→ durable artifact
```

### 4.1 Repo Landing 要回答的 6 个问题

```text
1. 这轮要落哪些文件？
2. 哪些文件是主文件，哪些是索引/变更记录？
3. 哪些地方最容易误改？
4. 哪些验证命令必须跑？
5. commit / push / PR 状态是什么？
6. 有没有越权或副作用？
```

### 4.2 不能犯的落库错误

```text
- 不能先改后审。
- 不能把草稿当终稿直接覆盖真源。
- 不能只改正文不改索引。
- 不能写完不验证。
- 不能把 fail 的验证报告成 pass。
```

---

## 5. D 端技能编排协议

D 端不是单纯改文件，而是一个 repo landing orchestration 门。

### 5.1 D 端默认技能编排顺序

```text
1. github-pr-workflow
2. github-repo-management
3. ai-method-wheel
4. codex（如需配合自动 landing）
5. requesting-code-review（如需复核落库说明）
```

### 5.2 技能状态必须区分

```text
listed_only
installed
loaded
activated
executed
output_consumed
referenced_only
conditional_not_executed
missing
forbidden
```

### 5.3 运行规则

```text
1. 先确认落库计划，再改文件。
2. 每次必须同步索引与变更记录。
3. 每次必须跑验证。
4. 通过前不得自称完成。
5. 如果有 PR/CI，必须确认状态后再汇报。
```

---

## 6. D 端的技能栈矩阵

### 6.1 主 skill

```text
meme-repo-landing-port
```

### 6.2 D 端固定辅助技能

```text
github-pr-workflow
github-repo-management
ai-method-wheel
```

### 6.3 D 端落库辅助技能

```text
codex
requesting-code-review
```

### 6.4 D 端可选外部模式

```text
repo landing checklist：pattern_only
release engineering habit：pattern_only
```

说明：

```text
D 端可以吸收落库和发布习惯，但不能把“做过类似动作”当成“已完成本次落库”。
```

---

## 7. D 端输出模板

### 7.1 Repo Landing Plan 模板

```md
# Repo Landing Plan

## 1. Goal

## 2. Input Files

## 3. Output Files

## 4. Files to Touch

## 5. Files Not to Touch

## 6. Validation Commands

## 7. Commit / Push Plan

## 8. PR / CI Check Plan

## 9. Stop Conditions
```

### 7.2 Changed Files List 模板

```md
# Changed Files

- path
- why changed
- linked source
```

### 7.3 Landing Handoff Note 模板

```md
# Landing Handoff

## What was landed

## What was not landed

## Validation results

## Commit / PR status

## Remaining risks
```

---

## 8. D 端落库分级

### 8.1 安全落库

```text
只改目标文件和索引/变更记录，且验证通过。
```

### 8.2 受限落库

```text
有少量不确定性，但风险可控，且已明确列出。
```

### 8.3 不允许落库

```text
- 没有审查通过
- 没有输入边界
- 没有验证计划
- 涉及权限/风险/交易副作用
```

---

## 9. D 端与 C/E 的边界

D 端不做：

```text
- 理论生成
- 证据压缩
- 独立审查结论
- owner 决策
```

C 端不做：

```text
- Repo 修改
- 直接 commit/push
```

E 端不做：

```text
- 落库执行
```

---

## 10. D 端与 A/B/C/E 的协作

### 10.1 C → D

```text
C 端给出落库计划、文件清单、理论包、风险说明。
```

### 10.2 E → D

```text
E 端先审查通过，再允许 D 落库或确认落库结果。
```

### 10.3 A/B → D

```text
A/B 提供已确认的需求和证据，D 不得越过这些输入直接写真源。
```

---

## 11. D 端验收标准

D 端本轮是否完成，看这 6 个结果：

```text
1. 目标文件是否正确落库。
2. 索引和变更记录是否同步。
3. validate_all 是否通过。
4. commit / push 是否完成。
5. PR / CI 状态是否确认。
6. 是否留下可复用 landing handoff。
```

---

## 12. D 端输出文件建议

建议后续每轮固定输出：

```text
D端_Repo_Landing_Plan_<date>.md
D端_Changed_Files_<date>.md
D端_Landing_Handoff_<date>.md
D端_Validation_and_PR_Status_<date>.md
```

---

## 13. 本版结论

```text
D 端的专业化路径已经明确：

D 端不是“帮忙改文件”，而是“把已审查内容安全落库并证明它真的落库了”。

如果 D 端没有验证与状态确认，落库就只是写文件，不是完成。
```
