# Skill Invocation Audit + dbs-good-question Brief

> Feature / Project：mql5-fcz-reclaim-model  
> Stage：技能安装/调用审计 + 好问题生成器执行  
> Status：v0.1  
> Purpose：回应 Owner 对“技能到底有没有安装齐全、有没有正确调用、现在长期需求拷问循环是不是想要的东西”的疑问，并执行 `/dbs-good-question` / 好问题生成器，把当前模糊问题改写成 Agent 可推理、可批评、可验证的问题说明书。

---

## 1. Skill Installation Audit

### 1.1 当前 Hermes profile

当前会话运行在 Hermes profile：

```text
sunqbfemx
```

### 1.2 当前 profile 中实际可调用的相关 Hermes skills

当前 profile 的技能列表中，能直接通过 `skill_view()` 调用的相关技能包括：

```text
spec-first-ai-engineering
markdown-research-knowledge-bases
plan
test-driven-development
requesting-code-review
codex
hermes-agent
```

本轮实际已调用：

```text
skill_view(markdown-research-knowledge-bases)
skill_view(spec-first-ai-engineering)
```

### 1.3 `/dbs-good-question` 是否作为 Hermes skill 安装？

结论：

```text
当前 sunqbfemx profile 中没有发现名为 dbs-good-question 或 好问题好问题生成器 的 Hermes skill。
```

因此：

```text
/dbs-good-question 目前不是一个可直接 skill_view() 调用的本地 Hermes skill。
```

它当前存在的形式是：

```text
方法论知识库中的命令/方法轮概念
```

来源：

```text
C:/Users/Administrator/dbskill_claude_platform_design_kb/01_命令体系/01_命令矩阵.md
C:/Users/Administrator/dbskill_claude_platform_design_kb/01_命令体系/02_深度组合打法.md
C:/Users/Administrator/dbskill_claude_platform_design_kb/01_命令体系/03_需求拷问端演化.md
```

也就是说：

```text
/dbs-good-question 的方法论在；
但它还没有被安装成当前 profile 可直接调用的 Hermes skill。
```

### 1.4 GMGN skills 是否安装在当前 profile？

结论：

```text
GMGN skills 安装在 jiegou profile 中，不在当前 sunqbfemx profile 中。
```

已发现路径：

```text
C:/Users/Administrator/AppData/Local/hermes/profiles/jiegou/skills/gmgn/gmgn-market/SKILL.md
C:/Users/Administrator/AppData/Local/hermes/profiles/jiegou/skills/gmgn/gmgn-token/SKILL.md
C:/Users/Administrator/AppData/Local/hermes/profiles/jiegou/skills/gmgn/gmgn-portfolio/SKILL.md
C:/Users/Administrator/AppData/Local/hermes/profiles/jiegou/skills/gmgn/gmgn-track/SKILL.md
C:/Users/Administrator/AppData/Local/hermes/profiles/jiegou/skills/gmgn/gmgn-swap/SKILL.md
C:/Users/Administrator/AppData/Local/hermes/profiles/jiegou/skills/gmgn/gmgn-cooking/SKILL.md
```

当前 profile 的 `skills_list()` 没有列出 gmgn-* skills。

含义：

```text
当前对 GMGN 的处理主要是读取 gmgn_requirement_knowledge_base 和 jiegou 历史会话/文件；
不是在当前 profile 直接调用 gmgn-market / gmgn-token / gmgn-track skills。
```

### 1.5 当前调用是否“正确”？

分层判断：

```text
1. 作为需求澄清/理论研究：基本正确。已调用 spec-first-ai-engineering 与 markdown-research-knowledge-bases，并读取项目文档、GMGN 知识库和历史会话。

2. 作为真正的 /dbs-good-question 命令：不完全正确。因为 dbs-good-question 未安装成当前 profile 的 Hermes skill，只是按方法论知识库手工执行了其模式。

3. 作为 GMGN skill 执行：未在当前 profile 正式调用。GMGN skills 在 jiegou profile 中，当前只能读取其结果和本地知识库，不应声称已在当前 profile 调用 GMGN skill。
```

---

## 2. dbs-good-question / 好问题生成器执行结果

### 2.1 Original Ask

Owner 当前的真实问题：

```text
现在知道距离完整需求文档的差距了；希望使用长期循环进行长时间的需求拷问澄清，并不断完善、回填理论知识研究。
但 Owner 不确定：这个循环要怎么调用起来？调用是否正确？是否真的是自己想要的？里面的技能到底有没有被安装齐全、有没有正确调用起来？
```

### 2.2 Improved Agent-Usable Question

```text
Given 当前项目已经形成 GMGN-powered meme-market quant trading system 的终局目标、Demand Theory Evolution Loop、Concept Search Absorption Loop、GMGN 数据源理论、结构观察器定位、full_meme_quant_trading_system_gap_brief，以及本地 gmgn_requirement_knowledge_base 和 jiegou profile 中的 GMGN skill 安装记录，

for Owner、Hermes agent、未来 Codex worker、未来 checker/reviewer，

verify whether the intended demand-grilling system is actually callable and correctly wired: which skills are installed in the current Hermes profile, which skills are only present as external method-wheel documents, which GMGN skills live in another profile, which workflows have only been simulated manually, and what the correct invocation contract should be for running long-term demand grilling that clarifies requirements and writes theory patches back into the project,

while preserving the boundary that no GMGN trading execution, private key, swap, strategy create, GitHub side effects, or Codex implementation should occur during this verification.

Success means the project has a clear Skill Invocation Audit and a corrected invocation contract: what command to run, which files to read, what output to write, how to verify, what is currently missing, and what must be installed or bridged if Owner wants true direct skill invocation.
```

### 2.3 Why This Is The Right Question

这个问题比“继续完善理论”更优先，因为：

```text
1. Owner 对技能是否真的调用有疑问。
2. 当前 /dbs-good-question 不是安装好的 Hermes skill，而是方法论知识库里的命令模式。
3. GMGN skills 不在当前 profile，直接说“已调用 GMGN skill”会造成误导。
4. 长期自动需求拷问如果没有清楚调用契约，会继续让 Owner 感觉不透明。
5. 在继续产出 GMGN 样本字段前，应先明确谁在执行、执行了什么、凭什么说执行正确。
```

---

## 3. Current Gap

### 3.1 缺少真正可调用的 dbs-good-question skill

当前状态：

```text
/dbs-good-question = 方法论概念 / 文档化命令
不是当前 profile 中可直接调用的 Hermes skill
```

如果 Owner 想要“真正调用起来”，需要后续选择：

```text
A. 保持为文档化命令，由 Hermes 按固定 prompt 执行。
B. 在当前 profile 创建一个真正的 dbs-good-question Hermes skill。
C. 从 dbskill 知识库或其他 profile 迁移/桥接该 skill。
```

推荐默认：

```text
先用 A：文档化命令 + 固定调用契约。
等稳定后再创建真正 Hermes skill，避免继续方法论膨胀。
```

### 3.2 GMGN skills 处于另一个 profile

当前状态：

```text
jiegou profile：已安装 gmgn skills。
sunqbfemx profile：未列出 gmgn skills。
```

当前项目可安全使用：

```text
GMGN 知识库
jiegou 历史会话
GMGN skill 文档
GMGN 理论字段
```

当前项目不应声称：

```text
已在 sunqbfemx profile 直接调用 gmgn-market / gmgn-token / gmgn-track。
```

---

## 4. Correct Invocation Contract

### 4.1 手动调用方式

Owner 可以这样触发：

```text
执行 /dbs-good-question：围绕当前项目的长期需求拷问系统，检查技能安装和调用是否正确，并把模糊问题改成 Agent 可推理、可批评、可验证的问题说明书。
```

Hermes 应执行：

```text
1. 调用 skills_list() 检查当前 profile 可用 skill。
2. 调用 skill_view(spec-first-ai-engineering) 和 skill_view(markdown-research-knowledge-bases)。
3. 检查 dbskill_claude_platform_design_kb 中的 /dbs-good-question 方法论文件。
4. 检查 jiegou profile 是否有 gmgn skills。
5. 读取当前项目需求控制面文件。
6. 写 Skill Invocation Audit + dbs-good-question Brief。
7. 更新索引和变更记录。
8. 运行 validate_all.py。
```

### 4.2 长期循环调用方式

Owner 后续可以这样触发：

```text
执行 Demand Theory Evolution Loop：读取需求文档，每次只选择一个最高价值理论缺口，用 DBS Method Wheel Overlay 和 Concept Search Absorption Loop 拷问，能自动落实的写入知识库，不能自动确认的写 Owner Decision Brief，最后运行 validate_all.py。
```

第一轮建议理论缺口：

```text
GMGN 样本标注 MVP 需要哪些最小字段，才能支持 FCZ 结构可标注、可反证、可重复观察？
```

---

## 5. Acceptance Criteria

```text
AC1. 已检查当前 profile skills_list。
AC2. 已明确 dbs-good-question 不是当前 profile 里已安装的 Hermes skill。
AC3. 已明确 dbs-good-question 当前可作为方法论命令/固定调用契约执行。
AC4. 已明确 GMGN skills 安装在 jiegou profile，不在当前 sunqbfemx profile。
AC5. 已执行一次 dbs-good-question 模式，生成 Improved Agent-Usable Question。
AC6. 已写入本审计文件。
AC7. 后续如果 Owner 要“真正技能调用”，需创建或迁移 dbs-good-question skill，并/或把 gmgn skills 桥接到当前 profile。
```

---

## 6. Missing Questions

当前最高价值 Owner 问题：

```text
你是否希望把 /dbs-good-question 从“方法论知识库里的命令模式”升级为当前 sunqbfemx profile 中真正可通过 skill_view() 调用的 Hermes skill？
```

推荐默认：

```text
暂时不升级。先用固定调用契约执行，避免继续方法论膨胀；等第一轮 GMGN 样本标注 MVP 跑通后，再决定是否创建真正 skill。
```
