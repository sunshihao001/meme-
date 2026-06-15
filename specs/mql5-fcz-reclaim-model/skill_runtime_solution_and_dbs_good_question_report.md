# Skill Runtime Solution + dbs-good-question Execution Report

> Feature / Project：mql5-fcz-reclaim-model  
> Stage：技能运行态修复 / dbs-good-question 实际调用 / 长期循环可执行方案  
> Status：v0.1，已安装核心 dbskill 与 GMGN 只读 skills 到当前 profile  
> Purpose：解决 Owner 对“长期循环所需技能是否安装齐全、是否只是空有方法、是否真正可调用运行”的疑问，并给出可执行解决方案。

---

## 1. Owner 当前问题

Owner 认为：

```text
一点点推进太慢，不符合专业 AI 做法。
现在最需要的是把长期循环所需技能先检测清楚：
- 哪些技能没安装齐全？
- 哪些安装了但只是空有方法，没有实际调用？
- 现在需要一个解决方案。
```

Owner 要求执行：

```text
/dbs-good-question 或 /好问题好问题生成器
把模糊问题改成 Agent 可推理、可批评、可验证的问题说明书。
```

---

## 2. Immediate Fix Performed

### 2.1 已安装 dbskill 核心技能到当前 profile

目标 profile：

```text
sunqbfemx
```

安装位置：

```text
C:/Users/Administrator/AppData/Local/hermes/profiles/sunqbfemx/skills/dbskill/
```

已安装：

```text
dbs
dbs-good-question
dbs-goal
dbs-content-system
dbs-chatroom
dbs-slowisfast
dbs-decision
dbs-save
dbs-report
dbs-agent-migration
dbs-benchmark
dbs-deconstruct
```

验证方式：

```text
skill_view(dbs-good-question)
skill_view(dbs-goal)
skill_view(dbs-content-system)
```

验证结论：

```text
dbs-good-question 已经可以在当前 session 中通过 skill_view() 实际加载。
```

### 2.2 已安装 GMGN 只读 skills 到当前 profile

安装位置：

```text
C:/Users/Administrator/AppData/Local/hermes/profiles/sunqbfemx/skills/gmgn/
```

已安装只读/研究相关 skills：

```text
gmgn-market
gmgn-token
gmgn-portfolio
gmgn-track
```

验证方式：

```text
skill_view(gmgn-market)
skill_view(gmgn-token)
```

验证结论：

```text
gmgn-market / gmgn-token 已经可以在当前 session 中通过 skill_view() 实际加载。
```

### 2.3 暂未安装 GMGN 执行类 skills

根据 Owner 当前阶段边界，暂未安装：

```text
gmgn-swap
gmgn-cooking
```

原因：

```text
当前阶段仍在 GMGN 样本标注、理论回填、需求澄清和只读数据研究阶段，不应引入 swap / cooking / strategy create 等交易执行能力。
```

---

## 3. 当前技能矩阵

### 3.1 已安装且可直接调用

| 能力 | Skill | 状态 | 用途 |
|---|---|---|---|
| 好问题生成器 | dbs-good-question | 已安装 / 已验证 | 把模糊问题改写成 Agent 可推理、可批评、可验证的问题说明书 |
| 目标清晰化 | dbs-goal | 已安装 / 已验证 | 把模糊目标转成可检查交付物 |
| 内容/知识工程 | dbs-content-system | 已安装 / 已验证 | 把本地资料变成可持续知识工程 |
| 多角色审查 | dbs-chatroom | 已安装 | 多视角批评需求、方案、理论补丁 |
| 慢变量判断 | dbs-slowisfast | 已安装 | 判断哪些环节必须慢做 |
| 决策记录 | dbs-decision | 已安装 | 记录 Owner 决策与待决策问题 |
| 阶段保存 | dbs-save | 已安装 | 阶段状态沉淀 |
| 报告输出 | dbs-report | 已安装 | 阶段报告 |
| 项目迁移 | dbs-agent-migration | 已安装 | Agent 工作台迁移与规则层建设 |
| 对标分析 | dbs-benchmark | 已安装 | MQL5/论坛/外部基准对标 |
| 概念拆解 | dbs-deconstruct | 已安装 | 拆解模糊概念与术语 |
| GMGN 行情/发现 | gmgn-market | 已安装 / 已验证 | trending/trenches/signal/kline 只读查询 |
| GMGN Token 尽调 | gmgn-token | 已安装 / 已验证 | info/security/pool/holders/traders 只读查询 |
| GMGN 钱包/组合 | gmgn-portfolio | 已安装 | wallet holdings/activity/stats 等只读查询 |
| GMGN 追踪 | gmgn-track | 已安装 | smartmoney/KOL/wallet/token track 查询 |

### 3.2 已有但不直接等同于 dbskill 的 Hermes 原生 skills

| Skill | 状态 | 用途 |
|---|---|---|
| spec-first-ai-engineering | 已安装 / 已调用 | Demand Grilling Brief / spec / plan / tasks / Codex handoff |
| markdown-research-knowledge-bases | 已安装 / 已调用 | Markdown 知识库维护、索引、变更记录、资料吸收 |
| test-driven-development | 已安装 | 后续代码/validator TDD |
| requesting-code-review | 已安装 | 后续代码审查 |
| codex | 已安装 | 后续执行实现，但当前不进入交易实现 |
| hermes-agent-skill-authoring | 已安装 / 已调用 | 技能安装、创建、验证方法 |

---

## 4. dbs-good-question 实际执行结果

### 4.1 当前断点

```text
项目已经形成长期需求拷问循环、DBS Overlay、Concept Search Absorption Loop、GMGN 终局量化交易目标和完整 gap brief。
但 Owner 对运行态不放心：这些流程到底是“真的安装并调用了 skill”，还是只是写在文档里的方法论？
```

当前清晰度：中高。

最大缺口：

```text
缺少一个运行态技能矩阵和调用契约，明确哪些 skill 已安装、哪些已验证、哪些禁止调用、每轮长期循环到底按什么顺序实际执行。
```

### 4.2 Agent 可推理、可批评、可验证的问题说明书

```text
我要分析的问题：
当前 GMGN-powered FCZ meme quant trading system 项目的长期需求拷问循环，是否具备真实可调用的 skill 运行态；如果不具备，应该如何补齐技能安装、调用契约、验证方式和禁止边界，使其从“文档化方法论”升级为“可实际运行的长期需求拷问与理论回填系统”？

现象：
项目里已经有 Demand Theory Evolution Loop、DBS Method Wheel Overlay、Concept Search Absorption Loop、full_meme_quant_trading_system_gap_brief 等文档，但 Owner 仍感觉技能没有被真正调用，担心只是空有方法，没有运行态。

目标：
改进 / 决策 / 自动化准备。

核心冲突：
文档层已经很完整，但运行层不透明；Owner 需要确认技能是否安装、是否可调用、是否按正确顺序执行、是否不会越权进入交易执行。

背景事实：
- 当前 profile 是 sunqbfemx。
- 原先 dbs-good-question 不是当前 profile 可调用 skill。
- GMGN skills 原先主要在 jiegou profile。
- 本轮已把核心 dbskill skills 安装到 sunqbfemx。
- 本轮已把 GMGN 只读 skills 安装到 sunqbfemx。
- 本轮已验证 dbs-good-question、dbs-goal、dbs-content-system、gmgn-market、gmgn-token 可通过 skill_view() 加载。

约束：
- 不安装/调用 gmgn-swap、gmgn-cooking 等交易执行类 skill。
- 不引入 GMGN_PRIVATE_KEY。
- 不进入 Codex 实现。
- 不创建 GitHub issue / PR。
- 不自动交易。
- 不让方法论继续压过项目。

反馈入口：
- skills_list / skill_view 是否能发现 skill。
- 本地 SKILL.md 是否存在。
- 运行 validate_all.py 是否通过。
- 每次循环是否产出 theory_evolution_report。
- 每次循环是否真实更新业务理论文件，而不是只写方法论。
```

### 4.3 Agent 可解性判断

结论：

```text
A/B 档之间：技能安装与调用契约可以高度自动化；理论判断和交易执行升级仍需要 Owner 决策。
```

可自动化部分：

```text
1. 检查技能安装。
2. 安装/复制只读技能。
3. 通过 skill_view 验证可加载。
4. 生成运行态矩阵。
5. 按固定调用契约执行 Demand Theory Evolution Loop。
6. 产出 GMGN 样本标注字段扩展。
7. 更新索引/变更记录。
8. 运行 validate_all.py。
```

需要 Owner 决策部分：

```text
1. 是否安装交易执行类 GMGN skills。
2. 是否配置私钥。
3. 是否进入自动交易阶段。
4. 是否把长期循环做成 cronjob。
5. 是否创建 GitHub issue / PR。
```

---

## 5. Correct Long-loop Invocation Contract

后续不要只说“按方法论执行”。必须按以下调用契约执行。

### 5.1 每轮必须加载 / 执行的技能顺序

```text
1. dbs-good-question
   - 钉住本轮最高价值理论缺口。

2. dbs-goal
   - 把理论缺口转成可验收交付物。

3. markdown-research-knowledge-bases
   - 确保文件落地、索引、变更记录、资料吸收。

4. spec-first-ai-engineering
   - 如果本轮涉及需求文档/spec/agent handoff，生成规范化需求控制面。

5. dbs-content-system
   - 如果本轮涉及大量资料、跨知识库、GMGN/MQL5 文档吸收，进行知识工程化归位。

6. dbs-chatroom
   - 多角色批评理论补丁。

7. dbs-slowisfast
   - 判断是否必须慢做、是否需要 Owner 决策。

8. dbs-decision
   - 记录已确认与待确认。

9. gmgn-market / gmgn-token / gmgn-portfolio / gmgn-track
   - 只有当本轮需要 GMGN 只读数据或字段定义时才调用。

10. dbs-save / dbs-report
   - 保存阶段状态，输出本轮报告。
```

### 5.2 每轮禁止调用

```text
gmgn-swap
gmgn-cooking
GMGN_PRIVATE_KEY
Codex trading implementation
GitHub PR/issue side effects
auto-trading scripts
```

### 5.3 每轮必须验证

```text
1. 记录本轮实际加载了哪些 skill。
2. 写入 theory_evolution_report_<timestamp>.md。
3. 更新业务理论文件。
4. 更新索引和变更记录。
5. 运行 python scripts/validate_all.py。
6. final report 中明确：哪些 skill 实际调用、哪些只是方法参考。
```

---

## 6. Missing Skill / Capability Plan

### 6.1 现在已补齐的最小技能集

```text
DBS demand/control skills：已补齐核心 12 个。
GMGN read-only skills：已补齐 4 个。
Hermes 原生 spec/research skills：已存在。
```

### 6.2 暂不补齐的技能

```text
gmgn-swap
gmgn-cooking
```

原因：

```text
当前阶段不进入交易执行。
```

### 6.3 后续可能需要创建的项目级技能

如果第一轮 GMGN 样本标注 MVP 跑通，可以考虑创建：

```text
gmgn-fcz-sample-labeling-loop
```

用途：

```text
把当前项目的 Demand Theory Evolution Loop、DBS Overlay、Concept Search Absorption、GMGN 只读技能调用契约打包成一个项目级 skill。
```

但当前不建议马上做，避免方法论继续膨胀。

---

## 7. Recommended Solution

现在的解决方案不是继续讨论方法，而是：

```text
1. 已把核心 dbskill 安装到当前 profile。
2. 已把 GMGN 只读 skills 安装到当前 profile。
3. 已验证关键 skills 可通过 skill_view() 加载。
4. 已明确禁止安装/调用交易执行类 GMGN skills。
5. 下一步直接执行第一轮长期循环，产出 GMGN 样本标注字段扩展。
```

第一轮命令：

```text
执行 Demand Theory Evolution Loop。
本轮理论缺口：GMGN 样本标注 MVP 需要哪些最小字段，才能支持 FCZ 结构可标注、可反证、可重复观察。
必须实际加载 dbs-good-question、dbs-goal、markdown-research-knowledge-bases、spec-first-ai-engineering、dbs-content-system、dbs-chatroom、dbs-slowisfast、dbs-decision，以及需要时的 gmgn-market / gmgn-token / gmgn-portfolio / gmgn-track。
输出 GMGN样本标注字段扩展_v0.1.md、theory_evolution_report，并运行 validate_all.py。
禁止调用 gmgn-swap / gmgn-cooking / Codex / GitHub side effects。
```
