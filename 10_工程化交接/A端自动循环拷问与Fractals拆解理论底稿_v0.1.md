# A端自动循环拷问与 Fractals 拆解理论底稿 v0.1

> 分线：10_工程化交接 / A端理论收束升级  
> 状态：v0.1 / 自动循环拷问 + Fractals 拆解桥接底稿  
> 目标：把 A 端的自动技能组合拷问、概念收束、边界设定、循环推理，与 Fractals 的递归拆解/benchmark 机制接成一个可复用的前置理论层。  
> 适用范围：当前 meme 研究知识库的 A 端控制面，以及后续 Fractals 递归拆解任务的输入契约。  
> 边界：本文件只负责 A 端认知循环与 Fractals 拆解前置契约，不直接执行 B/C/D/E/F，不直接运行 Fractals 仓库代码，不伪造拆解结果。

---

## 1. 当前想法的升级版

当前想法不是单纯“问清楚再做”，而是：

```text
A 端用技能组合自动循环拷问
→ 把自然语言收束成专业问题世界
→ 定义边界、非目标、证据缺口、停机门
→ 生成 Fractals 可消费的拆解契约
→ 再交给 Fractals 做递归拆解 / 层次分解
```

### 本轮想达成的变化

```text
1. 把 A 端从一次性澄清器升级为循环收束器。
2. 把技能调用从“列表”升级为“按缺口自动触发的路由链”。
3. 把 Fractals 从“一个工具”升级为“后续执行型递归拆解层”。
4. 把研究目标从“把问题问清楚”升级为“把问题问清楚并产出可拆解契约”。
```

---

## 2. A 端的当前任务

A 端当前不是要回答全部问题，而是要把下面这件事做完整：

```text
把当前阶段的 observe-only 系统母库目标，稳定地拆成：治理入口、validator、样本反证、只读数据、FCZ 状态机、风险分诊、observe-only MVP。
```

### A 端现在最重要的约束

```text
- 不把交易执行当作当前目标。
- 不把自动化能力扩张到 private key / swap / order。
- 不把“有理论草案”误写成“已可执行”。
- 不把“能拆解”误写成“已经验证”。
```

---

## 3. A 端的自动技能组合

A 端的自动拷问不是单个 skill，而是一个按缺口切换的组合栈。

### 3.1 主栈

```text
- dbs-good-question
- dbs-deconstruct
- dbs-goal
- dbs-decision
- dbs-slowisfast
```

### 3.2 条件栈

当需要外部背景时：

```text
- Agent Reach
- dbs-learning
- dbs-content-system
- dbs-report
- dbs-save
- dbs-restore
```

当需要进入执行前的结构化方案时：

```text
- to-prd
- writing-plans
- to-issues
- triage
- improve-codebase-architecture
- executing-plans
```

### 3.3 路由栈

当要判断是否继续、转端、停机时：

```text
- dbs-decision
- dbs-slowisfast
- dbs-report
- maintainer-orchestrator
- github-pr-workflow
```

---

## 4. 自动循环拷问的内部链路

A 端应该按下面的链路循环，而不是只问一轮。

```text
INTAKE
→ Concept Parsing
→ Problem World Modeling
→ Boundary Setting
→ Skill Invocation
→ Evidence Absorption
→ Re-evaluation
→ Loop Back / Transfer
```

### 4.1 INTAKE

接收自然语言输入，判断它属于：

```text
- 新想法
- 续接
- 执行
- 验证
- 决策
```

### 4.2 Concept Parsing

把表层词翻译成专业概念族。

示例：

```text
“治理入口” → 真源 / 索引 / 变更记录 / continuation brief
“validator” → schema / reference check / sample completeness / loop report
“只读数据” → snapshot / provenance / request_hash / schema_version
“FCZ 状态机” → hypothesis state / invalidation / candidate / watch / reject
```

### 4.3 Problem World Modeling

A 端必须先识别问题世界：

```text
- 现实世界里到底卡住了什么？
- 哪些是知识问题？
- 哪些是工程问题？
- 哪些是边界问题？
- 哪些是时机问题？
```

### 4.4 Boundary Setting

A 端当前边界必须锁住：

```text
observe-only / research-only
```

并明确：

```text
- 不进入交易执行
- 不进入资金操作
- 不进入 swap / private key / wallet custody
```

### 4.5 Skill Invocation

按缺口自动调用合适 skill，不把技能列表当最终答案。

### 4.6 Evidence Absorption

把技能返回的信息吸收成：

```text
- 增量知识
- 缺口清单
- 风险点
- 下一轮提问点
- 是否转端的判断依据
```

### 4.7 Re-evaluation

每轮都重新判断：

```text
- 现在更像澄清 / 研究 / 搜索 / 理论 / 执行 / 验证 / 决策 的哪一种？
- 新信息有没有改变路线？
- 是继续 A，还是转 B/C/D/E/F？
```

---

## 5. A 端当前要拷问的核心问题

A 端在当前阶段要把下面的问题拷问到足够成熟。

### 5.1 入口与治理

```text
1. 这个项目当前主线到底是什么？
2. 哪些文件是入口真源？
3. 哪些文件只是参考？
4. 新 Agent 应该先读什么？
5. 哪些内容必须进索引和变更记录？
```

### 5.2 质量与验证

```text
1. validator 应该优先校验什么？
2. 哪些字段最容易漂移？
3. 什么叫假完成？
4. 哪些样本记录必须被视为事实层？
5. 哪些报告必须可机检？
```

### 5.3 事实与样本

```text
1. 哪些样本是真实失败样本？
2. 哪些样本只是候选？
3. 哪些样本能支撑反证？
4. 哪些字段必须保留 provenance？
```

### 5.4 只读数据

```text
1. GMGN 哪些字段进入只读 intake？
2. 哪些字段只能做 context，不能做 truth？
3. 哪些数据必须带 request_hash / schema_version / fetched_at？
```

### 5.5 FCZ 状态机

```text
1. FCZ 是 hypothesis 还是 signal？
2. 哪些状态允许输出？
3. 哪些状态是禁止状态？
4. 哪些转移不能跳？
5. 哪些 invalidation rule 必须先定义？
```

---

## 6. A 端输出给 Fractals 的拆解契约

A 端循环拷问的终点，不是“我问明白了”，而是要能产出 Fractals 可直接消费的契约。

### 6.1 Fractals 拆解输入应该包含

```text
- real_objective
- problem_world
- output_contract
- verifier_gate
- allowed_ports
- forbidden_ports
- max_depth
- stop_conditions
- evidence_requirements
```

### 6.2 Fractals 要做的事情

Fractals 接到 A 端契约后，应该只做：

```text
- 递归拆解
- 层次分解
- 端口分流
- 叶子任务标记
- 输出树和 artifact path
```

Fractals 不应该替 A 端重新定义问题。

### 6.3 A 端与 Fractals 的分工

```text
A 端：把问题专业化、边界化、契约化
Fractals：把契约递归拆解成树状执行包
```

---

## 7. Fractals 拆解前的 A 端最小工作包

在交给 Fractals 之前，A 端至少要确认下面这些项：

```text
1. 当前阶段的真实目标
2. 当前问题世界
3. 非目标
4. 必须保留的边界
5. 需要验证的证据
6. 允许的端口
7. 禁止的端口
8. max_depth
9. stop conditions
10. 递归产物的消费方
```

### 7.1 推荐默认值

```text
allowed_ports: A / B / C / Bridge / E
forbidden_ports: trade / swap / private_key / wallet / auto_execution
max_depth: 2~3
stop_conditions:
- 连续两轮无有效增量
- 目标/边界/方案/验证至少 3 项达到可执行级别
- 用户明确说满意或先停
```

---

## 8. A 端自动循环拷问的停机条件

A 端必须有停机门，不然会无限问下去。

### 满足任一条就停

```text
1. 目标、边界、方案、验证四项中至少 3 项达到可执行级别。
2. 连续 2 轮没有新增有效信息。
3. 继续追问只会改细节，不会改路线。
4. 用户明确说“满意”或“先停”。
5. 已经可以输出 Fractals 拆解契约。
```

---

## 9. 当前阶段的 A 端边界

### 允许

```text
- 自动提问
- 自动概念解析
- 自动问题世界建模
- 自动 skill 路由建议
- 自动证据吸收
- 自动判断是否转端
- 自动生成 Fractals 拆解契约
```

### 不允许

```text
- 直接替代 B/C/D/E/F
- 直接生成最终交易理论
- 直接进入交易执行
- 伪装已验证事实
- 伪装已执行 skill
- 伪装 Fractals 已经跑完
```

---

## 10. 本轮结论

当前阶段最合理的 A 端动作是：

```text
用技能组合做自动循环拷问，先把想法收束成专业问题世界，再把收束结果交给 Fractals 做递归拆解。
```

### 一句话版

```text
A 端负责把“想做什么”问成“这是什么问题、边界是什么、缺什么证据、下一步怎么拆”，Fractals 负责把这个契约拆成树。
```
