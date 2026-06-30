# A+B+C知识循环接入 Skill 治理体系 v0.1

> 分线：10_工程化交接 / 技能治理
> 目的：把当前 AI 工作流里的 A+B+C 知识循环，接入对应的 skill 组合，形成可治理、可复用、可扩展的技能体系。
> 核心原则：不是把 skill 堆满，而是把 skill 编成层级化能力包，用于治理知识循环。

---

## 1. 先拉齐当前工作流

当前工作流不是单点 skill，而是一个分层循环：

```text
用户自然语言输入
→ dbs 路由
→ A 端最小澄清 / 概念拷问
→ B 端 Source Pack / 证据压缩
→ A 端吸收判断
→ C 端理论深化 / 方案生成
→ D 端落库
→ E 端验证
→ F 端 Owner 决策
```

其中，你当前最关键的是前半段：

```text
A + B + C = 知识循环
```

它的职责不是执行，而是：

```text
把自然语言想法变成：
- 可研究
- 可搜索
- 可判断
- 可吸收
- 可升级为理论 / 方案 / skill 体系
```

---

## 2. 治理目标

A+B+C 的治理目标不是“让 AI 多做事”，而是：

```text
1. 让每一轮输入都有明确入口。
2. 让每一轮搜索都有明确依据。
3. 让每一轮理论生成都有明确证据边界。
4. 让每一轮输出都能回到仓库，变成可复用资产。
5. 让 skill 不是孤立工具，而是循环中的能力组件。
```

换句话说：

```text
知识循环 = 运行机制
skill 组合 = 运行零件
治理体系 = 让零件按阶段正确启用
```

---

## 3. A 层：需求拷问 / 概念治理 / 路由控制

A 层的任务不是“回答问题”，而是先把问题变成可研究任务。

### A 层默认 skill 组合

- `dbs-good-question`
- `brainstorming`
- `grill-with-docs`
- `grill-me`
- `dbs-deconstruct`
- `dbs-goal`
- `dbs-decision`

### A 层职责

- 把模糊表达压成明确问题
- 判断这次是研究、设计、验证、还是决策
- 给 B 层生成搜索依据
- 给 C 层生成可接受的理论边界
- 决定是否进入深度模式或先停下来澄清

### A 层产物

```text
A Brief
- 当前想法
- 初步定义
- 知识缺口
- 搜索目标
- 搜索关键词
- 排除范围
- 推荐端口
- 是否允许进入 B/C
```

### A 层禁止事项

- 不直接写长理论
- 不直接搜到哪算哪
- 不直接跳过 B
- 不把问题一次性展开成所有技能都用

---

## 4. B 层：Source Pack / 外部知识储备 / 证据压缩

B 层的任务是把外部来源变成可消费的研究输入，而不是贴链接。

### B 层默认 skill 组合

- `Agent Reach` / `opencli twitter article`（外部来源读取连接器）
- `dbs-learning`
- `dbs-content-system`
- `dbs-report`
- `dbs-save`
- `dbs-restore`
- `dbs-deconstruct`（概念噪声较大时）

### B 层职责

- 执行定向搜索或资料读取
- 把来源压缩成 Source Pack
- 标出核心观点、可吸收点、不可直接照搬点
- 标出冲突、噪声、缺口、风险
- 判断资料是否足以喂给 C 层

### B 层产物

```text
Source Pack
- 来源清单
- 核心观点
- 对当前 A 问题的关系
- 可吸收点
- 不可照搬点
- 缺口 / 冲突 / unknown
- 是否值得进入 C
```

### B 层禁止事项

- 不直接做最终理论结论
- 不替 C 层生成长理论
- 不把原始链接当知识库
- 不把未验证来源直接抬升为结论

---

## 5. C 层：理论深化 / 方案治理 / skill 体系生成

C 层不是“再解释一遍”，而是把 A+B 收束成理论、方案、和可治理的 skill 体系。

### C 层默认 skill 组合

- `to-prd`
- `writing-plans`
- `to-issues`
- `triage`
- `improve-codebase-architecture`
- `executing-plans`（当需要把方案变成执行计划时）

### C 层职责

- 把 A+B 的结果压成稳定理论
- 生成方案、治理规则、技能分组建议
- 产出 skill 组合建议：主入口、辅助入口、条件触发、禁用项
- 把“外部仓库 / 外部观点 / 外部方法”转成仓库内可维护的治理文件

### C 层产物

```text
Theory / Governance Package
- 理论收束
- skill 编组建议
- 主入口 / 辅入口 / 条件触发
- ADOPT / BRIDGE / MERGE / REJECT / PATTERN_ONLY
- 验证方式
- 下一步落库建议
```

### C 层禁止事项

- 不把未经 A/B 确认的观点写成定论
- 不直接跳到 D 落库，除非 F 或 Owner 已允许
- 不把 skill 当单点工具，而要当组合治理对象

---

## 6. Skill 治理的分层方式

不是每个 skill 都是同一层。

### 第一层：入口型

负责让输入进入正确的知识循环。

- `dbs-good-question`
- `grill-with-docs`
- `grill-me`
- `brainstorming`

### 第二层：收束型

负责把输入压成可执行规格或理论结构。

- `dbs-deconstruct`
- `dbs-goal`
- `dbs-decision`
- `to-prd`
- `writing-plans`

### 第三层：外部知识型

负责抓来源、压证据、整理知识。

- `Agent Reach`
- `dbs-learning`
- `dbs-content-system`
- `dbs-report`
- `dbs-save`
- `dbs-restore`

### 第四层：治理型

负责把 skill 体系本身治理成可维护结构。

- `triage`
- `to-issues`
- `improve-codebase-architecture`
- `verification-before-completion`
- `finishing-a-development-branch`

---

## 7. A+B+C 的默认治理链

### 一次完整的知识循环应该长这样：

```text
A：把问题拷问清楚
→ B：找来源、压 Source Pack
→ A：判断是否吸收
→ C：把 A+B 收束成理论 / 方案 / skill 编组
→ D：落库
→ E：验证
→ F：Owner 决策
```

### 对应 skill 链

```text
A: dbs-good-question + brainstorming + grill-with-docs + grill-me + dbs-deconstruct
B: Agent Reach + dbs-learning + dbs-content-system + dbs-report + dbs-save/restore
C: to-prd + writing-plans + to-issues + triage + improve-codebase-architecture
```

### A/B/C 停机规则

A/B/C 不是无限循环，成熟度达到可执行级别时就应停止，避免把细节追问误当作路线判断。

推荐停机标准：

```text
1. 目标、边界、方案、验证四项中至少 3 项达到可执行级别。
2. 连续 2 轮没有新增有效信息。
3. 最多循环 2~3 轮后，强制复盘是否该转端。
4. 如果继续追问只会改细节，不会改路线，则进入停机/转端判断。
```

停机后的默认动作不是直接结束，而是转入下一阶段：

```text
- 写 spec
- 拆 task / issue
- 做方案比较
- 进入 C 端执行版方案
- 进入 Owner 决策
```

### A 端职责

A 端在这套口径里负责：

- 自动提问
- 自动判断当前缺口
- 自动调用相关 skill
- 自动吸收新增信息
- 判断是否满足收束标准

### B/C 端职责

- B 端负责来源与证据压缩
- C 端负责理论与方案收束
- 二者都不应把尚未收束的细节当最终结论

---

## 8. 治理规则：什么时候用整组，什么时候用单个

### 用整组

当问题属于以下类型时，用整组 skill 编组：

- 复杂想法需要拆解
- 外部知识要吸收进方法轮
- 外部仓库要转成内部治理文件
- 你要把一个技能包变成可复用体系

### 用单个

当问题足够明确、只缺一个动作时，用单个 skill：

- 只要问透一个需求 → `grill-me`
- 只要整理术语 → `grill-with-docs`
- 只要生成 PRD → `to-prd`
- 只要拆 issue → `to-issues`
- 只要看局部架构 → `improve-codebase-architecture`

### 不要全量堆叠

不要为了“完整”而把所有 skill 都打开。

```text
不是技能越多越好，
而是这个阶段需要哪些能力，
就启用哪些能力。
```

---

## 9. 适合你的默认治理图

你不是专业团队自建平台，而是非专业 Owner 需要一个稳定可控的 AI 工作台。

所以默认治理图应该是：

```text
入口（dbs）
→ 需求拷问（A）
→ 外部知识储备（B）
→ 理论与治理收束（C）
→ 落库/验证/决策（D/E/F）
```

这意味着：

- skill 不应代替端口
- 端口不应丢掉 skill 编组
- 知识循环要被 skill 体系治理
- skill 体系要被仓库文档治理

---

## 10. 建议的治理产物

接下来最好补 4 类文件：

1. `A_B_C知识循环接入Skill治理体系_v0.1.md`（本文件）
2. `A_B_C技能编组映射表_v0.1.md`
3. `A_B_C知识循环_运行卡_v0.1.md`
4. `A_B_C技能治理决策记录_v0.1.md`

这样以后每次新增 skill，先过治理图，再决定：

- ADOPT
- BRIDGE
- MERGE
- PATTERN_ONLY
- REJECT

---

## 11. 一句话结论

```text
A+B+C 是知识循环；skill 组合是知识循环的治理零件；治理体系要先定义入口、证据、收束、再决定如何进入执行。
```
