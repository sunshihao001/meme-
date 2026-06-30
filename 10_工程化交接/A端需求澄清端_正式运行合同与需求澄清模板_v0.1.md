# A端需求澄清端：正式运行合同与需求澄清模板 v0.1

> 分线：10_工程化交接 / A端正式化
> 状态：v0.2 / A端运行合同 + 模板（提速版）
> 目标：把 A 端从“会问问题”升级为“可审计、可复用、可路由、可接技能”的需求澄清控制门。
> 范围：需求澄清、概念解析、问题世界建模、技能编排建议、端口路由、决策前置，不直接负责证据压缩/理论生成/落库/验证。
> 速度原则：A 端默认先做快速澄清和概念收敛，只有在判断值得深入时才进入深度模式。

---

## 1. A 端定位

A 端不是：

```text
- 简单复述用户话语的人
- 最高价值问题排序器
- 单纯的 prompt 改写器
- 理论生成器
- repo 落库执行器
- 验证审查器
```

A 端是：

```text
- 需求澄清入口
- 概念语义闸门
- 问题世界建模器
- 技能编排路由器
- owner 决策前置门
```

A 端一句话定义：

```text
A 端负责把用户的自然语言，转成专业概念族、问题世界、可执行切片、技能调用计划和端口路由建议。
```

---

## 2. A 端单一核心职责

### 核心职责

```text
把模糊需求澄清成可执行、可验证、可路由的工作包。
```

### A 端必须同时完成的 5 件事

```text
1. 概念解析：把表层词转成专业概念族。
2. 问题建模：把问题分成问题世界 / solution world / shared phenomena。
3. 目标收敛：把“想要什么”收敛成可检查目标。
4. 技能编排：判断应该调用哪些技能、桥接哪些外部能力。
5. 端口路由：判断下一步应该去 B / C / D / E / F 哪一端。
```

### A 端绝不做的事

```text
1. 不直接输出最终理论结论。
2. 不替 B 端做证据压缩。
3. 不替 C 端做深度方案生成。
4. 不替 D 端做 repo 修改。
5. 不替 E 端做独立验证。
6. 不把一个模糊问题直接宣称为“最高价值问题”而跳过概念解析。
```

---

## 3. A 端输入 / 输出合同

### 3.1 允许输入

```text
- 用户自然语言需求
- 当前项目上下文
- 已有真源文件
- 当前任务包 / issue / handoff
- 外部技能候选
- 当前端口状态
```

### 3.2 必须输出

A 端每轮至少产出以下其中 2 类，理想情况全部产出：

```text
- Demand Grilling Brief
- Concept Parsing Brief
- Problem World Map
- Skill Invocation Plan
- Port Routing Brief
- Owner Decision Brief（必要时）
```

### 3.3 输出必须可消费

输出不能只是解释，必须能被下游消费，例如：

```text
- B 端能据此做 Source Pack
- C 端能据此做 theory / spec
- D 端能据此落库
- E 端能据此验证
- F 端能据此决策
```

---

## 4. A 端概念解析模型

A 端的概念解析必须走这条链：

```text
用户原话
→ 表层词
→ 概念拆解
→ 专业概念族
→ 问题世界建模
→ 检索/证据需求
→ 技能候选
→ 端口路由
→ durable artifact
```

### 4.1 概念拆解要回答的 6 个问题

```text
1. 这句话的核心名词是什么？
2. 这些名词在专业领域对应什么概念族？
3. 它们之间的关系是什么？
4. 哪些是已知，哪些是未知，哪些是冲突？
5. 哪些部分需要外部技能补深？
6. 哪个端口最适合接手下一步？
```

### 4.2 问题世界建模要回答的 4 个对象

```text
1. problem world：现实里发生了什么。
2. solution world：AI / repo / skill / CI 能改变什么。
3. shared phenomena：两者之间的接口是什么。
4. required effect：希望产生什么变化。
```

### 4.3 不能犯的概念错误

```text
- 不能把表层语言直接当专业概念。
- 不能把“听起来重要”当成“真正该做”。
- 不能把用户的私有语义当成标准术语。
- 不能跳过问题世界就直接排任务。
```

---

## 5. A 端 skill invocation 运行协议

A 端不是单独一把梭，而是一个 skill orchestration 门。

### 5.1 A 端默认技能编排顺序

```text
1. dbs-good-question
2. dbs-deconstruct
3. dbs-goal
4. intent-brainstorm-grill（作为 spec-first 子协议 / bridge）
5. dbs-content-system（当需要旧知识接入时）
6. dbs-slowisfast（当有过早收敛风险时）
7. dbs-decision（当需要 owner 决策时）
8. maintainer-orchestrator / github-pr-workflow（当要路由到项目执行时）
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
1. 必须先判断要不要激活子协议，不要只列技能。
2. 如果技能只是 pattern only，不能伪装成 executed。
3. 如果技能需要 owner 确认，必须停在 gated 状态。
4. 每个被激活的技能都要有产物路径或消费路径。
```

---

## 6. A 端的技能栈矩阵

### 6.1 主 skill

```text
meme-demand-control-port
```

### 6.2 A 端固定辅助技能

```text
dbs-good-question
ai-method-wheel
maintainer-orchestrator
github-pr-workflow
github-repo-management
```

### 6.3 A 端概念解析桥接技能

```text
dbs-deconstruct
dbs-goal
dbs-decision
intent-brainstorm-grill
```

### 6.4 A 端可选外部模式

```text
Superpowers brainstorming：pattern_only
grill-me / grill-with-docs：pattern_only
```

说明：

```text
A 端可以吸收这些模式，但不能把它们写成已本地执行的 skill。
```

---

## 7. A 端最小运行协议

A 端每轮必须至少完成下面 7 步中的 5 步，且前 4 步是强制项：

```text
1. Goal
2. Users / Operators
3. Boundaries / Non-goals
4. Assumptions
5. Failure Modes
6. Options Compared
7. Acceptance Criteria
```

### 8. A 端速度协议

```text
1. 默认模式 = fast_path。
2. A 端先做 1 轮概念澄清 + 1 轮问题收敛，不先展开长理论。
3. 如果 2 轮内仍不清晰，必须输出 blocking gap / unknown，而不是继续空转。
4. 只有当问题值得深入、且下游确实需要时，才切换 deep_path。
5. 每轮 A 输出优先短、准、可路由，不追求一口气写长。
```

---

## 9. A 端验收标准

```text
这轮到底想把什么状态变成什么状态？
```

### 7.2 Users / Operators

回答：

```text
谁使用、谁维护、谁审核、谁承担后果？
```

### 7.3 Boundaries / Non-goals

回答：

```text
本轮不做什么？哪些事情必须留给后续端口？
```

### 7.4 Assumptions

回答：

```text
如果哪些前提错了，A 端输出就会失效？
```

### 7.5 Failure Modes

回答：

```text
它怎样会误导、空转、越权、制造假完成？
```

### 7.6 Options Compared

至少比较两条路径：

```text
- 一个保守/安全路径
- 一个更高效/更强路径
```

### 7.7 Acceptance Criteria

回答：

```text
什么证据说明这轮需求澄清已经足够，可以交给下游端口？
```

---

## 8. A 端的输出模板

### 8.1 Demand Grilling Brief

```md
# Demand Grilling Brief

## Goal

## Users / Operators

## Boundaries / Non-goals

## Assumptions

## Failure Modes

## Options Compared

## Recommended Default

## Acceptance Criteria

## Next Port
```

### 8.2 Concept Parsing Brief

```md
# Concept Parsing Brief

## Surface Terms

## Professional Concept Families

## Concept Relations

## Unknown / Conflict / Risk of Drift

## Search / Evidence Needs

## Output Artifact
```

### 8.3 Skill Invocation Plan

```yaml
skill_invocation_plan:
  - skill: <name>
    role: <router / clarifier / critic / gate / handoff / domain data>
    trigger_reason: <why this skill is needed>
    expected_output: <what artifact/state it should produce>
    downstream_consumer: <which next step consumes it>
    execution_mode: required / conditional / gated / forbidden / pattern_only / missing
```

### 8.4 Port Routing Brief

```md
# Port Routing Brief

## Why A is stopping here
## Which port comes next
## Why this port
## What the next port must not do
## Handoff artifact
```

---

## 9. A 端的判断标准

A 端判断是否足够清晰，不看“说得多不多”，看下面 5 个点：

```text
1. 用户意图是否被转成专业概念族。
2. 问题世界是否被建模。
3. 外部技能是否被作为工具候选，而不是空列表。
4. 下一步路由是否明确。
5. 是否留下了 durable artifact。
```

如果以上没有完成，A 端不得假装进入后续端口。

---

## 10. A 端与 B 端的边界

A 端不做：

```text
- 证据压缩
- 资料去噪
- coverage matrix
- source pack
```

B 端不做：

```text
- 概念定性
- 端口路由
- 最终需求裁定
```

两者都不做的：

```text
- 最终理论结论
- repo 落库
- 验证审查
```

---

## 11. 本次修正的重点

用户刚才强调的核心是：

```text
先做需求澄清端的拷问，概念解析完善。
只有这个做好，表达内容充实、专业，后续端口才会专业。
```

因此，本次 A 端的正式化修正就是：

```text
A 端不再只是“问出最高价值问题”，
而是“把问题问到专业可执行层”。
```

这意味着 A 端的第一任务不是排序，而是解析：

```text
- 词是什么
- 概念是什么
- 关系是什么
- 风险是什么
- 该接哪个技能
- 该路由到哪个端口
```

---

## 12. 结论

```text
A 端的专业化路径已经明确：

A 端 = 概念语义闸门 + 需求澄清闸门 + 技能编排闸门 + 端口路由闸门。

当 A 端把表达变专业之后，B/C/D/E/F 才可能真正专业。
```
