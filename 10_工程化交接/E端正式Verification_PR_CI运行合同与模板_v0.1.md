# E端正式 Verification / PR-CI 运行合同与模板 v0.1

> 分线：10_工程化交接 / E端正式化  
> 状态：v0.1 / E端运行合同 + 模板  
> 目标：把 E 端从“看一下有没有问题”升级为“独立验证、PR/CI 审查、越权检查、回退建议和 Owner 决策支持”的验证审查端。  
> 范围：审查 C 端理论包、审查 D 端 repo diff、运行/读取验证、检查 PR/CI、判断越权与证据边界、输出修正清单或 Owner Decision Brief；不直接生成理论，不直接落库执行。

---

## 1. E 端定位

E 端不是：

```text
- 理论生成器
- repo 修改执行器
- 需求澄清器
- 只看测试是否通过的人
- 为 D 端背书的橡皮图章
```

E 端是：

```text
- 独立验证门
- PR / CI 审查门
- 越权检查门
- 证据边界审查门
- Owner 决策支持门
```

E 端一句话定义：

```text
E 端负责独立检查 C 端理论与 D 端落库是否符合 A/B 输入、项目边界、验证要求和 owner 风险约束，并给出 PASS / BLOCK / NEEDS_REVISION / OWNER_DECISION_REQUIRED。
```

---

## 2. E 端单一核心职责

### 核心职责

```text
对理论、落库、验证、PR/CI 和越权风险进行独立审查，并输出可执行的修正或决策建议。
```

### E 端必须同时完成的 5 件事

```text
1. 审查 C 端理论包是否符合 A/B 输入。
2. 审查 D 端 repo diff 是否只改允许范围。
3. 检查验证命令、PR/CI、测试结果是否真实通过。
4. 判断是否存在越权、后验、凭空补证据或交易副作用。
5. 输出给 A/C/D/F 的修正清单或 owner 决策 brief。
```

### E 端绝不做的事

```text
1. 不替 C 端生成新理论。
2. 不替 D 端直接改文件。
3. 不只因为 validate_all 通过就判定业务正确。
4. 不把未读证据写成已审查。
5. 不替 Owner 做高风险最终决策。
```

---

## 3. E 端输入 / 输出合同

### 3.1 允许输入

```text
- A 端 Demand / Concept / Routing Brief
- B 端 Source Pack / Coverage Matrix
- C 端 Theory Package / Codex Handoff
- D 端 Changed Files / Commit / PR / Validation 状态
- git diff / PR diff / CI logs
- 项目真源文件和任务包
```

### 3.2 必须输出

E 端每轮至少产出以下其中 2 类，理想情况全部产出：

```text
- Verification Report
- PR / CI Review Report
- Boundary / Overreach Review
- Revision Request
- Owner Decision Brief
```

### 3.3 输出必须可消费

E 端输出必须能被下游消费：

```text
- A 端能据此重新澄清
- C 端能据此修理论
- D 端能据此修落库
- F 端能据此决策
```

---

## 4. E 端 Verification 模型

E 端必须走这条链：

```text
输入合同
→ C 理论审查
→ D diff 审查
→ 验证命令 / PR-CI 检查
→ 边界 / 越权 / 证据审查
→ verdict
→ revision / owner decision handoff
```

### 4.1 Verification 要回答的 7 个问题

```text
1. A/B 输入是否被正确消费？
2. C 端理论是否超出证据边界？
3. D 端落库是否只改允许文件？
4. 验证命令是否真实运行并通过？
5. PR/CI 状态是否真实、最新、可追踪？
6. 是否存在越权、后验、伪证据、交易副作用？
7. 结论应该 PASS、BLOCK、NEEDS_REVISION 还是 OWNER_DECISION_REQUIRED？
```

### 4.2 不能犯的验证错误

```text
- 不能只看测试 PASS 就判定业务正确。
- 不能把未审查文件当成已审查。
- 不能把 D 端自报状态当成 E 端验证结论。
- 不能把 owner 应该决定的风险下放给 agent。
- 不能在没有 diff / commit / CI 证据时说已验证。
```

---

## 5. E 端技能编排协议

E 端不是单纯复述测试结果，而是 verification / review orchestration 门。

### 5.1 E 端默认技能编排顺序

```text
1. requesting-code-review
2. github-pr-workflow
3. github-code-review
4. ai-method-wheel
5. systematic-debugging
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
1. 先读输入合同，再审 diff。
2. 先确认验证证据，再给 verdict。
3. 任何 PASS 都必须附真实证据。
4. 如果业务边界不清，回退 A。
5. 如果证据不足，回退 B。
6. 如果理论超界，回退 C。
7. 如果落库错误，回退 D。
8. 如果涉及 owner 风险，交给 F。
```

---

## 6. E 端的技能栈矩阵

### 6.1 主 skill

```text
meme-verification-review-port
```

### 6.2 E 端固定辅助技能

```text
requesting-code-review
github-pr-workflow
github-code-review
ai-method-wheel
systematic-debugging
```

### 6.3 E 端可选外部模式

```text
independent verifier checklist：pattern_only
QA gate / release gate：pattern_only
red-team review：pattern_only
```

说明：

```text
E 端可以吸收外部 QA / reviewer 模式，但不能把“看起来合理”写成“已验证”。
```

---

## 7. E 端输出模板

### 7.1 Verification Report 模板

```md
# Verification Report

## 1. Scope

## 2. Inputs Reviewed

## 3. Commands / Checks Run

## 4. Results

## 5. Boundary Review

## 6. Evidence Review

## 7. Verdict

## 8. Required Fixes

## 9. Owner Decision Needed
```

### 7.2 PR / CI Review 模板

```md
# PR / CI Review

## PR / Branch

## Commit Reviewed

## CI Status

## Diff Scope

## Checks Passed

## Checks Missing

## Risk Notes
```

### 7.3 Revision Request 模板

```md
# Revision Request

## Return To

A / B / C / D / F

## Reason

## Required Change

## Evidence Needed

## Stop Condition
```

---

## 8. E 端 Verdict 分级

### PASS

```text
验证通过，边界清楚，无已知 blocker。
```

### PASS_WITH_CAVEAT

```text
主流程可通过，但有明确 caveat / 后续增强项。
```

### NEEDS_REVISION

```text
需要返回 A/B/C/D 中某一端修正。
```

### BLOCK

```text
存在验证失败、越权、证据不足或高风险错误，不允许继续。
```

### OWNER_DECISION_REQUIRED

```text
涉及 owner 风险、路线选择、权限边界或商业判断，必须交给 F。
```

---

## 9. E 端与其他端口的边界

E 端不做：

```text
- 需求澄清
- 证据压缩
- 理论生成
- repo 修改
- owner 决策
```

A/B/C/D/F 的边界：

```text
A：问题不清时重澄清
B：证据不足时补 Source Pack
C：理论超界时重写理论
D：落库错误时修 diff
F：风险/权限/路线必须 owner 决定
```

---

## 10. E 端与 D 端协作

### 10.1 D → E

D 必须给 E：

```text
- changed files
- validation output
- commit hash
- push / PR status
- landing handoff
```

### 10.2 E → D

E 返回：

```text
- diff review result
- validation judgment
- required fixes
- pass/block verdict
```

### 10.3 E/D 闭环原则

```text
D 负责把内容落库。
E 负责证明落库是否合格。
D 不能自我批准。
E 不能直接代替 D 改库。
```

---

## 11. E 端验收标准

E 端本轮是否完成，看这 6 个结果：

```text
1. 是否明确 review scope。
2. 是否列出真实检查证据。
3. 是否检查 diff / validation / PR-CI。
4. 是否审查越权和证据边界。
5. 是否给出可执行 verdict。
6. 是否把需要 owner 决策的内容交给 F。
```

---

## 12. E 端输出文件建议

建议后续每轮固定输出：

```text
E端_Verification_Report_<date>.md
E端_PR_CI_Review_<date>.md
E端_Boundary_Overreach_Review_<date>.md
E端_Revision_Request_<date>.md
E端_Owner_Decision_Brief_<date>.md
```

---

## 13. 本版结论

```text
E 端的专业化路径已经明确：

E 端不是“再看一眼”，而是“独立验证门”。

如果 E 端没有独立证据、diff/CI 检查和明确 verdict，整个多端口流程就没有真正的 checker。
```
