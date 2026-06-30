# F端正式 Owner Decision / Risk Boundary 运行合同与模板 v0.1

> 分线：10_工程化交接 / F端正式化  
> 状态：v0.1 / F端运行合同 + 模板  
> 目标：把 F 端从“最后拍板”升级为“风险边界、路线选择、权限确认和最终 owner 决策门”。  
> 范围：路线裁定、风险接受、权限确认、长期方向选择、冲突仲裁、关键例外批准；不做需求澄清、不做证据压缩、不做理论生成、不做 repo 落库执行、不替代验证。

---

## 1. F 端定位

F 端不是：

```text
- 需求拷问器
- 证据压缩器
- 理论生成器
- Repo 修改执行器
- 验证审查器
```

F 端是：

```text
- Owner Decision 门
- Risk Boundary 门
- 路线裁定门
- 权限确认门
- 决策仲裁门
```

F 端一句话定义：

```text
F 端负责在 A/B/C/D/E 之后，对路线、风险、权限和长期方向做最终 owner 决策，并明确哪些内容可以继续、哪些必须停、哪些需要重做。
```

---

## 2. F 端单一核心职责

### 核心职责

```text
对路线、风险、权限和例外情况做最终 owner 决策，并给出可执行的批准/拒绝/暂停/重做/降级指令。
```

### F 端必须同时完成的 5 件事

```text
1. 判断路线选择是否成立。
2. 判断风险是否可接受。
3. 判断权限边界是否允许继续。
4. 对冲突意见做最终裁定。
5. 给出明确的 owner 决策结果。
```

### F 端绝不做的事

```text
1. 不替 A 端做需求澄清。
2. 不替 B 端做证据压缩。
3. 不替 C 端做理论生成。
4. 不替 D 端做 repo 落库。
5. 不替 E 端做独立验证。
```

---

## 3. F 端输入 / 输出合同

### 3.1 允许输入

```text
- A 端 Demand / Concept / Routing Brief
- B 端 Source Pack / Coverage Matrix
- C 端 Theory Package / Landing Plan
- D 端 Landing Handoff / Validation / PR 状态
- E 端 Verification Report / Verdict
- 当前项目目标、限制、owner 偏好、长期方向
```

### 3.2 必须输出

F 端每轮至少产出以下其中 2 类，理想情况全部产出：

```text
- Owner Decision Brief
- Risk Acceptance / Rejection Note
- Route Approval / Pause / Redo Instruction
- Exception Approval Note
- Priority Reordering Note
```

### 3.3 输出必须可消费

F 端输出必须能被下游消费：

```text
- A 端能据此重新澄清
- C 端能据此调路线
- D 端能据此决定是否落库
- E 端能据此决定是否放行
```

---

## 4. F 端决策模型

F 端必须走这条链：

```text
A/B/C/D/E 输入
→ 风险与路线比较
→ 权限边界检查
→ 例外/冲突判断
→ owner 决策
→ 指令发布
```

### 4.1 决策要回答的 7 个问题

```text
1. 这条路线是否符合当前目标？
2. 风险是否在可接受边界内？
3. 是否需要暂停、重做或降级？
4. 权限边界是否允许继续？
5. 是否有更优先的工作要先做？
6. 是否存在必须由 owner 决定的冲突？
7. 最终指令是什么？
```

### 4.2 不能犯的决策错误

```text
- 不能把信息不清楚的内容强行批准。
- 不能把风险外包给下游 agent。
- 不能把验证失败当成可接受。
- 不能把长期方向和临时便利混淆。
- 不能让 owner 决策变成纯口头附和。
```

---

## 5. F 端技能编排协议

F 端不是执行端，而是 decision / policy orchestration 门。

### 5.1 F 端默认技能编排顺序

```text
1. dbs-decision
2. ai-method-wheel
3. maintainer-orchestrator
4. github-pr-workflow（当需要确认 release / PR 状态时）
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
1. 先看 A/B/C/D/E 输入，再做决策。
2. 如果证据不足，必须暂停而不是硬批。
3. 如果风险不清，必须要求重做或补充。
4. 如果涉及权限/路线/资源分配，必须明确 owner 指令。
```

---

## 6. F 端的技能栈矩阵

### 6.1 主 skill

```text
meme-owner-decision-port
```

### 6.2 F 端固定辅助技能

```text
dbs-decision
ai-method-wheel
maintainer-orchestrator
github-pr-workflow
```

### 6.3 F 端可选外部模式

```text
decision memo / approval gate：pattern_only
risk acceptance checklist：pattern_only
priority arbitration：pattern_only
```

说明：

```text
F 端可以吸收外部决策模板，但不能把“我感觉可以”当成 owner 决策。
```

---

## 7. F 端输出模板

### 7.1 Owner Decision Brief 模板

```md
# Owner Decision Brief

## 1. Context

## 2. Inputs Reviewed

## 3. Options Compared

## 4. Risks / Constraints

## 5. Recommendation

## 6. Final Decision

## 7. Required Follow-up

## 8. Not Approved / Deferred Items
```

### 7.2 Risk Boundary Note 模板

```md
# Risk Boundary Note

## Allowed

## Not Allowed

## Requires Re-check

## Requires Owner Sign-off
```

### 7.3 Route Approval / Pause / Redo 模板

```md
# Route Instruction

## Route

## Status

## Reason

## Next Action
```

---

## 8. F 端决策类型

### APPROVE

```text
同意继续当前路线。
```

### APPROVE_WITH_CONSTRAINTS

```text
同意继续，但必须遵守约束或降级条件。
```

### PAUSE

```text
先停，等待补证据、补澄清或补验证。
```

### REDO

```text
当前路线不成立，需要重做前置端口。
```

### REJECT

```text
不批准当前路线。
```

### DEFER

```text
当前不处理，放入后续优先级队列。
```

---

## 9. F 端与其他端口的边界

F 端不做：

```text
- 需求澄清
- 证据压缩
- 理论生成
- repo 落库
- 独立验证
```

A/B/C/D/E 各自职责：

```text
A：把问题说清楚
B：把证据收干净
C：把方案写专业
D：把内容安全落库
E：把结果独立验证
F：把路线、风险、权限和优先级拍板
```

---

## 10. F 端与 E 端协作

### 10.1 E → F

E 必须给 F：

```text
- verdict
- boundary review
- remaining risks
- required fixes
- whether owner decision is needed
```

### 10.2 F → E

F 返回：

```text
- approve / pause / redo / reject / defer
- specific constraints
- priority changes
- scope boundaries
```

### 10.3 E/F 闭环原则

```text
E 负责证明结果是否合格。
F 负责决定是否继续、停下还是重做。
```

---

## 11. F 端验收标准

F 端本轮是否完成，看这 5 个结果：

```text
1. 路线是否明确。
2. 风险边界是否明确。
3. 权限边界是否明确。
4. 指令是否可执行。
5. 是否留下 Owner Decision Brief。
```

---

## 12. F 端输出文件建议

建议后续每轮固定输出：

```text
F端_Owner_Decision_Brief_<date>.md
F端_Risk_Boundary_Note_<date>.md
F端_Route_Instruction_<date>.md
F端_Approval_Log_<date>.md
```

---

## 13. 本版结论

```text
F 端的专业化路径已经明确：

F 端不是“最后一句同意”，而是“路线、风险、权限和优先级的最终 owner 门”。

如果 F 端不清楚，整个闭环就没有真正的决策终点。
```
