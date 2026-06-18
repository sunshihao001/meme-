# A端核心合同模板 v0.1

> 分线：10_工程化交接 / A端正式化  
> 状态：v0.1 / 可复用模板  
> 用途：当 A 端接到任何新需求时，先用此模板把问题变成专业可执行的需求包，再路由给 B/C/D/E/F。  
> 适配对象：meme 多端口工作流、需求澄清、外部技能接入、概念解析、任务分发。

---

## 1. 模板填写规则

每次 A 端开始前，必须先填：

```text
- Goal
- Users / Operators
- Problem World
- Solution World
- Shared Phenomena
- Non-goals
- Assumptions
- Failure Modes
- Skill Invocation Plan
- Port Routing
- Acceptance Criteria
```

如果这些项无法填清楚，说明问题还没被专业化。

---

## 2. 核心模板

```md
# A端 Demand Grilling Brief

## 1. Goal

这次到底要把什么状态变成什么状态？

## 2. Users / Operators

谁使用、谁维护、谁审核、谁承担后果？

## 3. Problem World

现实世界里发生了什么？问题本体是什么？

## 4. Solution World

AI / repo / skill / CI / validator 能改变什么？

## 5. Shared Phenomena

问题世界与解决世界之间的接口是什么？

## 6. Surface Terms

用户用了哪些表层词？

## 7. Professional Concept Families

这些表层词对应什么专业概念族？

## 8. Non-goals

本轮明确不做什么？

## 9. Assumptions

哪些前提如果错了，输出会失效？

## 10. Failure Modes

它怎样会误导、空转、越权、制造假完成？

## 11. External Skill Candidates

有哪些单个技能模块或桥接技能可以作为处理工具？

## 12. Skill Invocation Plan

- skill
- role
- trigger_reason
- expected_output
- downstream_consumer
- execution_mode

## 13. Port Routing

下一步应该去 B / C / D / E / F 哪一端？为什么？

## 14. Recommended Default

如果要给一个保守默认，会是什么？

## 15. Acceptance Criteria

什么证据说明这轮拷问已经完成，可以交给下游？
```

---

## 3. A 端提问深度要求

A 端的提问必须满足：

```text
1. 不是重复用户原话。
2. 不是只追问一个结果。
3. 不是只问“哪个最重要”。
4. 要先问问题世界和概念族。
5. 要能导出可执行切片。
6. 要能决定下一端口。
```

### 3.1 推荐的提问顺序

```text
1. 你到底想解决什么。
2. 这属于哪个问题世界。
3. 里面哪些词是表层表达，哪些是专业概念。
4. 哪些地方不能混。
5. 需要哪些外部技能补深。
6. 下一步应该路由到哪一端。
```

### 3.2 需求拷问的目标不是“快”

```text
目标不是快速排序，而是专业化表达。
```

A 端如果过快收敛，就会重新退化成：

```text
最高价值问题排序器
```

这是要避免的。

---

## 4. A 端必须输出的三个层级

### Level 1：语义层

```text
把用户话术翻译成专业概念族。
```

### Level 2：结构层

```text
把专业概念放进问题世界 / 解决世界 / shared phenomena。
```

### Level 3：行动层

```text
把问题路由到 B / C / D / E / F，并给出技能调用计划。
```

---

## 5. A 端技能编排建议

### 5.1 必须区分三种来源

```text
- 本地主 skill
- 本地辅助 skill
- 外部技能桥接 / pattern only
```

### 5.2 A 端建议先查的技能

```text
meme-demand-control-port

dbs-good-question
dbs-deconstruct
dbs-goal
dbs-decision
ai-method-wheel
maintainer-orchestrator
github-pr-workflow
github-repo-management
intent-brainstorm-grill（bridge）
```

### 5.3 A 端技能计划输出要求

必须写成：

```yaml
skill_invocation_plan:
  - skill: <name>
    role: <router / clarifier / critic / gate / handoff / domain data>
    trigger_reason: <why this skill is needed>
    expected_output: <what artifact/state it should produce>
    downstream_consumer: <which next step consumes it>
    execution_mode: required / conditional / gated / forbidden / pattern_only / missing
```

---

## 6. A 端边界和禁区

### 6.1 允许

```text
- 概念解析
- 需求澄清
- 路由判断
- 技能编排建议
- Owner Decision Brief
```

### 6.2 禁止

```text
- 直接写最终理论结论
- 直接写 repo 落库内容
- 直接代替 B 端做证据压缩
- 直接代替 E 端做验证
- 把外部技能伪装成本地已执行 skill
```

### 6.3 A 端最常见失败模式

```text
- 太快收敛
- 只会排序不会解析
- 把模糊词当专业词
- 没有问题世界建模
- 没有路由到下游
- 没有 durable artifact
```

---

## 7. A 端与 B 端协作方式

### 7.1 A → B

A 给 B 的不是“再看一遍”，而是：

```text
- 需要什么证据
- 需要什么范围
- 证据的优先级
- 允许什么未知
- 要求什么格式
```

### 7.2 B → A

B 返回：

```text
- source pack
- coverage matrix
- gaps/conflicts/unknowns
- 需要 A 再澄清的概念点
```

### 7.3 A/B 闭环原则

```text
A 先定问题世界
B 再收证据
A 再决定是否足够进入下游
```

---

## 8. A 端验收标准

A 端本轮是否完成，不看“写了多少字”，看这 6 个结果：

```text
1. 用户意图是否被专业化。
2. 表层词是否被拆成概念族。
3. 问题世界是否被建模。
4. 外部技能是否被工具化。
5. 路由方向是否明确。
6. 是否留下可消费 artifact。
```

---

## 9. A 端输出文件建议

如果以后要让 A 端持续运行，建议固定输出：

```text
A端_Demand_Grilling_Brief_<date>.md
A端_Concept_Parsing_Brief_<date>.md
A端_Skill_Invocation_Plan_<date>.md
A端_Port_Routing_Brief_<date>.md
A端_Owner_Decision_Brief_<date>.md
```

---

## 10. 本模板结论

```text
A 端要先把表达专业化，再把路由和技能编排专业化。

A 端不是“问几个问题”，而是把需求翻译成专业工作包。

如果 A 端做不到概念解析，后续端口只能继续在模糊输入上工作。
```
