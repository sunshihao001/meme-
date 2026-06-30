# A端当前阶段理论边界与循环推理 v0.1

> 分线：10_工程化交接 / A端理论收束  
> 状态：v0.1 / 当前阶段 A 端理论底稿  
> 目标：把“治理入口、validator、样本反证、只读数据、FCZ 状态机”收束成可执行的 A 端问题定义、概念边界、问题世界模型与路由建议。  
> 适用范围：meme 研究知识库 → 可验证协作仓库 → GMGN observe-only 系统母库。  
> 边界：本文件只做 A 端认知收敛与路由，不直接做证据压缩、长理论生成、repo 落库、验证审查或交易执行。

---

## 1. 当前阶段的真实目标

当前阶段不是“把系统做成能交易”，而是先把项目收束成一个可验证、可协作、可继续工程化的观察闭环。

### 当前阶段目标句

```text
以治理入口、validator、样本反证、只读数据和 FCZ 状态机为核心，把 meme 研究知识库收束成一个可验证、可协作、可继续工程化的 observe-only 系统母库。
```

### 这个目标要达成的状态

```text
1. 入口层清楚：新 Agent 知道先读什么、先看什么、先改什么。
2. 规则层清楚：真源、索引、变更记录、运行合同彼此一致。
3. 事实层清楚：样本、反证、raw refs、provenance 可追溯。
4. 结构层清楚：FCZ / 状态机 / mapper / reason-code / 风险分诊可落库。
5. 质量层清楚：validator 能抓到漂移、缺字段、假完成。
6. 安全层清楚：当前只允许 observe-only / research-only。
```

---

## 2. A 端要先定义的问题世界

A 端不能直接问“下一步做什么”，必须先识别问题世界。

### 2.1 problem world

现实里的问题不是“没有文件”，而是：

```text
1. 文件很多，但没有统一入口优先级。
2. 主线已经形成，但还没有完全收束成稳定导航层。
3. 样本、指标、回测、架构、交接之间仍有边界需要显式化。
4. 新 Agent 容易把“理论草案”“工程交接”“系统架构”混为一谈。
5. 没有 validator 时，文档会自然漂移。
```

### 2.2 solution world

解决世界里能改变的东西是：

```text
1. 入口文件与真源地图。
2. 索引与变更记录。
3. 样本记录、CSV、raw refs、反证样本。
4. 只读数据 / snapshot / provenance schema。
5. FCZ 状态机与 GMGN mapper。
6. 风险分诊与 reason-code。
7. validator / CI / 接口契约。
```

### 2.3 shared phenomena

问题世界和解决世界之间的接口是：

```text
- 文档真源
- 样本真相
- 状态字段
- 校验规则
- 路由规则
- 阶段门
```

### 2.4 required effect

A 端希望产生的变化不是“多写一点”，而是：

```text
把模糊想法压成专业概念族、边界、缺口、可执行切片和下一端口路由建议。
```

---

## 3. A 端当前应优先扩展的概念族

A 端在当前阶段，重点不是扩张到所有主题，而是先把下面几组概念稳定下来。

### 3.1 治理入口概念族

```text
- 真源
- 索引
- 变更记录
- continuation brief
- 入口优先级
- 继承顺序
```

### 3.2 质量门概念族

```text
- validator
- schema
- reference existence
- sample completeness
- loop report validity
- stale / drift detection
```

### 3.3 事实层概念族

```text
- sample
- raw refs
- provenance
- reflection / falsification
- success / failure / ambiguous / missed
```

### 3.4 只读数据概念族

```text
- gmgn raw response
- snapshot
- request_hash
- schema_version
- fetched_at
- source_command
```

### 3.5 状态结构概念族

```text
- FCZ state
- observe-only output
- state transition
- invalidation rule
- candidate / watch / reject / needs_manual_review
- reason_code
```

### 3.6 系统边界概念族

```text
- research_only
- observe_only
- no_trade
- no swap
- no private key
- no wallet custody
- no auto execution
```

---

## 4. A 端的循环推理方式

A 端不是一轮问完，而是循环收敛。

### 4.1 标准循环

```text
输入想法
→ 解析表层词
→ 映射专业概念族
→ 建立问题世界
→ 识别缺口
→ 设定边界
→ 决定路由
→ 回收验证
→ 进入下一轮
```

### 4.2 每轮必须回答的 7 个问题

```text
1. 现在到底要收束什么状态？
2. 这个状态属于哪个问题世界？
3. 哪些词是表层词，哪些是专业概念？
4. 哪些东西现在不能碰？
5. 当前最缺哪类证据？
6. 下一步应该路由到 B / C / D / E / F 哪一端？
7. 什么证据说明本轮 A 已经足够成熟？
```

### 4.3 A 端的回炉规则

```text
- 概念没定准 → 回 A
- 边界太宽 → 回 A
- 目标不清 → 回 A
- 证据缺口未识别 → 回 A
- 需要证据压缩 → 路由 B
- 需要长理论 → 路由 C
- 需要落库 → 路由 D
- 需要验证 → 路由 E
- 需要阶段门决策 → 路由 F
```

---

## 5. 当前阶段 A 端的明确边界

### 5.1 允许

```text
- 需求澄清
- 概念解析
- 问题世界建模
- 缺口识别
- 路由建议
- 边界收束
- 运行合同草拟
- 产物契约定义
```

### 5.2 不允许

```text
- 直接写最终理论结论
- 直接替 B 做证据压缩
- 直接替 C 写长理论
- 直接替 D 改 repo
- 直接替 E 做验证
- 直接进入交易执行
- 把观察结论写成买卖建议
```

### 5.3 当前阶段的隐性禁区

```text
- 自动交易
- private key
- wallet custody
- swap
- 实盘执行
- 把成功样本当成策略证明
- 把系统架构图当成执行能力
```

---

## 6. A 端输出合同

A 端每轮至少输出以下之一，理想上输出全部：

```text
- Demand Grilling Brief
- Concept Parsing Brief
- Problem World Map
- Boundary Brief
- Skill Invocation Plan
- Port Routing Brief
- Owner Decision Brief（必要时）
```

### 输出必须满足的条件

```text
1. 能被 B 端继续做 Source Pack。
2. 能被 C 端继续做长理论。
3. 能被 D 端落库。
4. 能被 E 端验证。
5. 能被 F 端决策。
```

---

## 7. A 端当前推荐的理论扩展方向

A 端现在最应该扩展的，不是更宽的理论，而是更稳的“当前阶段理论”。

### 7.1 主方向

```text
治理入口
→ validator
→ 样本反证
→ 只读数据
→ FCZ 状态机
→ 风险分诊
→ observe-only MVP
```

### 7.2 理论扩展时要坚持的原则

```text
1. 先定义，再搜索。
2. 先边界，再扩展。
3. 先问题世界，再解决世界。
4. 先事实层，再结构层。
5. 先验证，再结论。
```

### 7.3 不应该优先扩展的方向

```text
- 自动交易细节
- 资金执行细节
- 订单系统设计
- 私钥管理
- swap adapter
- 实盘风控细化
```

---

## 8. A 端与 B / C / D / E / F 的协作规则

### 8.1 A → B

A 给 B 的不是“再搜一下”，而是：

```text
- 证据缺口
- 搜索范围
- 允许的来源类型
- 排除范围
- 返回格式
```

### 8.2 A → C

A 给 C 的不是“写一篇理论”，而是：

```text
- 已定的概念族
- 已定的问题世界
- 已知边界
- 必须回答的结构问题
- 不能越过的禁区
```

### 8.3 A → D

A 给 D 的是：

```text
- 哪些理论已稳定
- 哪些文件应进入真源
- 哪些需要索引更新
- 哪些需要变更记录
```

### 8.4 A → E

A 给 E 的是：

```text
- 验证点
- 失败模式
- 预期的证据
- 不可接受的漂移
```

### 8.5 A → F

A 给 F 的是：

```text
- 当前阶段是否可继续
- 哪些风险需要 Owner 裁定
- 哪些门不能跳过
```

---

## 9. A 端的当前阶段验收标准

A 端本轮足够成熟，至少要满足以下条件：

```text
1. 用户的自然语言已经被翻译成专业概念族。
2. 已明确当前阶段的边界与非目标。
3. 已建立 problem world / solution world / shared phenomena。
4. 已识别当前最关键缺口。
5. 已给出明确路由到 B / C / D / E / F 的建议。
6. 不会把观察闭环误写成交易闭环。
7. 不会把暂时结论写成最终真理。
```

---

## 10. 本轮 A 端结论

```text
当前阶段的 A 端任务，不是扩展到更宽的交易系统，而是先把项目收束成一个 observe-only 的可验证系统母库。

A 端应该优先固化：治理入口、validator、样本反证、只读数据、FCZ 状态机与路由边界。
```

### 一句话版

```text
A 端当前的工作，是把“要做什么”变成“为什么要这么做、能做什么、不能做什么、下一步该路由到哪”。
```
