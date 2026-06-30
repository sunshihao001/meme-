# A/B 端核心合同与技能栈矩阵 v0.2

> 分线：10_工程化交接 / A+B 端口合同
> 状态：v0.2 / A+B 端口合同（提速版）
> 目的：把 A 端与 B 端的职责、输入、输出、禁区、验收标准和技能栈矩阵明确下来，作为后续端口重分配的基线。
> 前提：先把 A 端做成概念语义闸门，把 B 端做成证据压缩闸门，再谈 C/D/E/F。
> 速度原则：A/B 端默认 fast_path；先做最小可消费产物，再决定是否进入深度循环。

---

## 1. 设计目标

用户的需求可以压缩成一句话：

```text
先把整体工作流各个端口分清楚职责，补全内部能力，并把外部技能作为处理工具接入；其中最先要做的是需求澄清端与概念解析，因为表达充实、专业之后，后续端口才可能专业化。
```

因此，A/B 端的设计目标不是“让 AI 多做点事”，而是：

```text
1. 将需求输入专业化。
2. 将证据输入干净化。
3. 将外部技能工具化。
4. 将端口职责合同化。
5. 让后续端口在更稳定的前提下工作。
```

---

## 2. A/B 端的关系

### 2.1 A 端与 B 端的分工

```text
A 端：决定这件事是什么、为什么、边界在哪、先路由到谁。
B 端：决定这件事基于什么证据、哪些资料、哪些上下文。
```

### 2.2 A/B 的上下游

```text
用户自然语言
→ A 端（概念解析 / 需求澄清 / 路由）
→ B 端（资料压缩 / Source Pack / 证据收敛）
→ C 端（理论生成 / 方案）
→ D 端（落库）
→ E 端（验证）
→ F 端（owner 决策）
```

### 2.3 为什么先锁 A/B

因为：

```text
- A 不清，后面都在做错题。
- B 不干净，后面都在吃脏上下文。
- A/B 是整个工作流的语义入口和证据入口。
```

---

## 3. A 端核心合同

### 3.1 A 端一句话定义

```text
A 端 = 需求澄清 / 概念解析 / 控制路由 / 决策前置门。
```

### 3.2 A 端职责

A 端只负责以下四件事：

```text
1. 把用户表层表达转成专业概念族。
2. 把问题空间拆成可执行、可验证的切片。
3. 判断接下来应该路由到 B / C / D / E / F 哪一端。
4. 给出本轮是否已经足够进入下一个端口的依据。
```

### 3.3 A 端主要输入

```text
- 用户自然语言需求
- 当前项目上下文
- 真源文件
- 外部技能候选
- 已有任务/问题/PR 状态
```

### 3.4 A 端主要输出

```text
- Demand Grilling Brief
- Concept Parsing Brief
- Port Routing Brief
- Skill Invocation Plan
- Owner Decision Brief（必要时）
```

### 3.5 A 端允许做什么

```text
- 需求拷问
- 概念拆解
- 目标澄清
- 风险识别
- 端口路由
- 外部技能候选判断
```

### 3.6 A 端禁止做什么

```text
- 不直接写最终理论结论。
- 不替 B 端压缩证据。
- 不替 C 端写完整方案。
- 不替 D 端落库修改 repo。
- 不替 E 端做独立验证。
```

### 3.7 A 端验收标准

```text
1. 概念解析达到专业表达。
2. 问题世界建模清楚。
3. 路由明确且有理由。
4. 技能计划可审计。
5. 产物可以被后续端口消费。
```

---

## 4. B 端核心合同

### 4.1 B 端一句话定义

```text
B 端 = 资料压缩 / Source Pack / 证据收敛门。
```

### 4.2 B 端职责

B 端只负责以下四件事：

```text
1. 读取相关文件、样本、旧知识、外部来源。
2. 压缩成干净的 Source Pack。
3. 明确 gap / conflict / unknown。
4. 给 C 端或 A 端提供可消费上下文。
```

### 4.3 B 端主要输入

```text
- 项目文件
- 原始资料
- 样本记录
- 旧知识库
- 外部文章 / 外部 skill source
```

### 4.4 B 端主要输出

```text
- Source Pack
- Coverage Matrix
- Evidence Index
- Gaps / Conflicts / Unknowns
```

### 4.5 B 端允许做什么

```text
- 只读阅读
- 证据压缩
- 资料归类
- 缺口标记
- 上下文整理
```

### 4.6 B 端禁止做什么

```text
- 不直接下最终理论判断。
- 不修改 repo 真源。
- 不替代 C 端做方案。
- 不把 unknown 写成结论。
```

### 4.7 B 端验收标准

```text
1. 证据包低噪音、可消费。
2. gap/conflict/unknown 清晰。
3. 下游可以据此继续。
4. 不混入最终结论。
```

---

## 5. A/B 技能栈矩阵

### 5.1 A 端技能栈

| 层级 | 技能 | 作用 | 状态 |
|---|---|---|---|
| 主 skill | `meme-demand-control-port` | 定义 A 端身份、边界、路由、决策前置门 | 必须 |
| 辅助 skill | `dbs-good-question` | 把模糊问题变成可拷问问题 | 必须 |
| 辅助 skill | `ai-method-wheel` | 维持 repo-backed loop、maker-checker、GitHub 语义 | 必须 |
| 辅助 skill | `maintainer-orchestrator` | 帮 A 端做任务路由、owner gate、流程分发 | 推荐 |
| 辅助 skill | `github-pr-workflow` | 判断 PR / CI / 分支状态，避免过度口头化 | 推荐 |
| 辅助 skill | `github-repo-management` | 读取/确认 repo 状态和路径 | 推荐 |
| 外部桥接 | `intent-brainstorm-grill` | 作为概念解析/澄清子协议，不是独立身份 | bridge |
| 外部桥接 | `dbs-deconstruct` | 概念拆解补深 | bridge |
| 外部桥接 | `dbs-goal` | 目标澄清补深 | bridge |
| 外部桥接 | `dbs-decision` | 长周期决策、owner brief | bridge |
| pattern only | Superpowers brainstorming | 仅作为模式参考，未安装不写成 executed | pattern_only |

### 5.2 B 端技能栈

| 层级 | 技能 | 作用 | 状态 |
|---|---|---|---|
| 主 skill | `meme-source-pack-port` | 定义 B 端身份、证据压缩、上下文清洗 | 必须 |
| 辅助 skill | `codebase-inspection` | 检查仓库结构、文件存在性、文件关联 | 必须 |
| 辅助 skill | `ai-method-wheel` | 保持 A/B 与后续 loop 的契约一致 | 必须 |
| 辅助 skill | `github-repo-management` | 确认仓库路径、分支、PR 状态、文件位置 | 推荐 |
| 外部桥接 | `dbs-content-system` | 结构化旧知识和内容索引 | bridge |
| 外部桥接 | `dbs-learning` | 将主题切成可吸收主题包 | bridge |
| 外部桥接 | `dbs-deconstruct` | 对复杂资料做概念拆分 | bridge |
| 外部桥接 | `ocr-and-documents` | 仅在 PDF/扫描件出现时启用 | conditional bridge |

---

## 6. 外部技能接入规则

### 6.1 接入级别

#### Level 1：Pattern Only

```text
只吸收方法模式，不安装、不执行、不伪装成本地 skill。
```

适合：

```text
外部文章、外部框架理念、参考工作流
```

#### Level 2：Bridge Skill

```text
把外部方法包装成项目内桥接 skill，形成可复用接口。
```

适合：

```text
概念拆解、资料压缩、需求拷问、验证审查、决策 brief
```

#### Level 3：Core Stack Skill

```text
被验证长期有效、会频繁使用的能力，才升级为端口主 skill 或稳定辅助 skill。
```

### 6.2 接入原则

```text
1. 单个技能优先，不要一次吞整套框架。
2. 先作为工具，再考虑是否升级为本地 skill。
3. 必须可审计、可回退、可替换。
4. 不能把外部框架直接当成端口身份。
```

---

## 7. A/B 运行协议

### 7.1 A → B

A 端输出的不是大段空话，而是：

```text
- 需要 B 端补什么证据
- 需要哪些外部 skill / 外部来源
- B 端输出应以什么格式返回
- 哪些字段暂时允许 UNKNOWN
```

### 7.2 B → A

B 端返回：

```text
- Source Pack
- 证据清单
- 已知 / 未知 / 冲突
- 需要 A 端重新澄清的概念点
```

### 7.3 A/B 闭环

```text
A 端先定问题世界
→ B 端补证据包
→ A 端决定是否足够进入 C/D/E/F
```

---

## 8. 最小交付物

### 8.1 A 端最低交付

```text
A端 Demand Grilling Brief
A端 Concept Parsing Brief
A端 Port Routing Brief
A端 Skill Invocation Plan
```

### 8.2 B 端最低交付

```text
B端 Source Pack
B端 Coverage Matrix
B端 Evidence Index
B端 Gaps / Conflicts / Unknowns
```

---

## 9. A/B 端边界总结

```text
A：定什么、为什么、边界、去哪里。
B：基于什么、哪些资料、哪些证据、哪些缺口。
```

只要这两个边界没立住，后面的端口就会继续互相偷工。

---

## 10. 当前建议

下一步建议不是立刻扩 C/D/E/F，而是：

```text
1. 将 A 端需求澄清端的概念解析链固化成模板。
2. 将 B 端 Source Pack 格式固化成模板。
3. 再把 C/D/E/F 的职责按同一套“核心合同”重画。
```

---

## 11. 本版结论

```text
A/B 端要先专业化，后面的端口才能专业化。

A 端的核心是概念语义闸门。
B 端的核心是证据压缩闸门。

外部技能必须被工具化、桥接化、可审计化，不能只列名称。
```
