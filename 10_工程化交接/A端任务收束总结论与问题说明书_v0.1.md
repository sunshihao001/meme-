# A端任务收束总结论与问题说明书 v0.1

> 分线：10_工程化交接 / A端问题说明书  
> 状态：v0.1 / 任务树收束版  
> 目的：把当前这一串任务收束成一个“根本问题 → 任务树 → 优先级 → 边界 → 可验证问题说明书”的 A 端总稿，供 `/dbs-good-question` 或 `/好问题好问题生成器` 继续拷问与路由。  
> 适用对象：meme 研究知识库、observe-only 系统母库、Fractals 拆解前置输入。  
> 边界：本文件只负责 A 端收束、问题建模、任务树总结论与路由，不直接做代码实现、不替代 B/C/D/E/F。

---

## 1. 根本问题（本质）

当前这一串任务表面上看很多：

```text
入口、validator、样本反证、只读数据、FCZ 状态机、风险分诊、回测、observe-only MVP、A 端自动拷问、Fractals 拆解
```

但本质上只有一个根问题：

```text
如何把一个已经有很多资料与结构草案的 meme 研究知识库，收束成一个可验证、可协作、可继续工程化的 observe-only 系统母库，而不让它继续扩散成“看起来很完整、实际上不可验证”的文档堆？
```

### 根问题的结构

```text
现象：文件很多、主线很多、版本很多

风险：入口漂移、样本漂移、状态漂移、验证漂移、结论漂移

目标：把研究知识库变成可验证协作仓库

底线：不进入交易执行、不碰 private key / swap / wallet custody
```

---

## 2. 任务树总结论

这不是一棵“无限扩张树”，而是一棵“先收束后工程化”的树。

### 总树

```text
P0  入口 / 真源 / 主线收束
P1  validator / 质量门
P2  样本反证 / 事实层
P3  只读数据 / provenance / snapshot
P4  FCZ 状态机 / mapper
P5  风险分诊 / reason-code
P6  回测 / 消融 / 成本模型
P7  observe-only MVP
P8  后续执行层（暂缓）
```

### 任务树的根本调整

```text
不是“把所有问题都做完”，
而是“先把最容易漂移、最影响事实、最影响结构的层固定住”。
```

---

## 3. 调整后的优先级结论

### P0：入口与真源

```text
1. README / AGENTS / SOURCE_OF_TRUTH / ROADMAP / Continuation Brief 对齐
2. A 端理论底稿进入索引与变更记录
3. 新 Agent 阅读顺序固定
```

### P1：validator

```text
1. 索引引用存在性 validator
2. 样本记录 Markdown 完整性 validator
3. loop report validator
4. 变更记录格式 validator
```

### P2：样本反证

```text
1. 真实失败样本
2. 反证样本
3. 漏掉大涨样本
4. 死亡盘误判样本
```

### P3：只读数据

```text
1. GMGN raw response
2. snapshot
3. provenance / request_hash / schema_version
4. data quality report
```

### P4：FCZ 状态机 / mapper

```text
1. 状态集合固定
2. 状态转移固定
3. mapper 输入输出固定
4. invalidation rule 固定
```

### P5：风险分诊

```text
1. candidate / watch / reject / needs_manual_review
2. reason-code taxonomy
3. confidence / evidence 关系
```

### P6：回测 / 消融

```text
1. 简单基准
2. 样本外验证
3. 成本模型
4. 反证 / 消融
```

### P7：observe-only MVP

```text
1. 可读
2. 可验
3. 可追溯
4. 不输出交易执行指令
```

---

## 4. A 端要怎么把问题改写成 Agent 可推理 / 可批评 / 可验证的问题说明书

### 4.1 问题说明书必须包含的字段

```text
1. Goal
2. Problem World
3. Solution World
4. Shared Phenomena
5. Non-goals
6. Assumptions
7. Failure Modes
8. Evidence Gaps
9. Port Routing
10. Acceptance Criteria
11. Stop Conditions
```

### 4.2 A 端的核心动作

A 端不是简单问“你要什么”，而是要把输入改写成：

```text
- 可推理：能拆成目标、边界、缺口、依赖、停机门
- 可批评：能指出哪里可能错、哪里会漂移、哪里是伪完整
- 可验证：每一项都能被 validator / 样本 / provenance / 状态机检查
```

### 4.3 推荐的问题说明书句式

```text
当前阶段，我们要把 meme 研究知识库收束成一个 observe-only 系统母库。

请判断：
1. 当前最大的根本问题是什么？
2. 任务树应该如何按入口 / validator / 样本 / 只读数据 / 状态机 / 风险分诊 / 回测 / MVP 分层？
3. 哪些层必须先做，哪些层必须后做？
4. 哪些层绝不能进入交易执行？
5. 哪些边界一旦错了，整个系统会失真？
6. 当前最应该先补的 5 个子任务是什么？
7. 哪些子任务现在不该做？
```

---

## 5. `/dbs-good-question` 的作用定位

`/dbs-good-question` 或 `/好问题好问题生成器` 在当前项目里的职责是：

```text
把模糊问题改成 Agent 可推理、可批评、可验证的问题说明书。
```

### 它要做的事情

```text
- 把表层词翻译成专业概念族
- 把问题从“任务列表”提升到“问题世界”
- 把散任务收束成 bounded contract
- 把路由前置给 B/C/D/E/F
- 把停机门说清楚
```

### 它不该做的事情

```text
- 不直接输出最终理论
- 不直接跑执行层
- 不直接替代 B/C/D/E/F
- 不把未验证想法写成结论
```

---

## 6. 任务树总结后的最终判断

### 根本判断

```text
当前项目的本质问题不是“内容太少”，而是“主线还需要收束成可验证结构”。
```

### 结构判断

```text
1. 入口层是骨架。
2. validator 是防漂移骨架。
3. 样本反证是真相骨架。
4. 只读数据是真实骨架。
5. FCZ 状态机是结构骨架。
6. 风险分诊是边界骨架。
7. 回测 / MVP 是工程化骨架。
```

### 方向判断

```text
先收束，再扩展。
先验证，再深化。
先事实，再结构。
先边界，再执行。
```

---

## 7. 本轮结论

```text
把任务收束成树之后，项目的根本问题已经从“要不要再写更多”变成“如何把已有的入口、质量门、样本、只读数据、状态机收成一个稳定的 observe-only 母库”。
```

### 最终一句话

```text
A 端现在要做的不是继续扩散任务，而是把任务改写成可推理、可批评、可验证的问题说明书，然后按优先级收束到入口、validator、样本、只读数据和 FCZ 状态机。
```