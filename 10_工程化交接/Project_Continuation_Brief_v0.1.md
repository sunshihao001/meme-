# Project Continuation Brief v0.1

> 分线：10_工程化交接 / 项目继续入口  
> 状态：v0.1 / 当前接手简报  
> 生成方式：按 V0.5 需求拷问端运行态执行，包含 Runtime Skill Audit、目标审计、慢方法判断与补全清单。  
> 目的：把当前项目“从哪里继续、哪些已完成、哪些未接入、哪些需要补全、哪些禁止推进”固定成一页可维护入口，减少 owner 反复口头提醒。

---

## 1. 本文件解决什么

当前项目的问题不是“没有文件”或“没有方法论”，而是：

```text
1. 文件和模块已经很多，但新 Agent 接手时缺一张当前状态图。
2. 已完善过的功能、字段、issue、validator、V0.5 loop 产物没有全部接入入口层。
3. README / ROADMAP 能看到大方向，但不能直接回答“现在从哪里继续”。
4. 旧资料、新结构、方法论上游、工程化验证、样本主线之间的边界不够显性。
```

因此，本文件不是再造方法论，也不是重构目录。它只做一件事：

```text
把当前项目继续推进所需的最小上下文、补全清单和下一步入口固定下来。
```

---

## 2. 本轮 V0.5 Runtime Skill Audit

### 2.1 loaded：本轮实际加载技能

```text
dbs-good-question
dbs-goal
dbs-content-system
dbs-chatroom
dbs-slowisfast
dbs-decision
dbs-save
dbs-report
spec-first-ai-engineering
github-pr-workflow
github-repo-management
```

### 2.2 referenced_only：只引用 / 读取的项目文件

```text
AGENTS.md
SOURCE_OF_TRUTH.md
skills/mql5-fcz-reclaim-kb/SKILL.md
README.md
ROADMAP.md
00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md
00_知识库设计规范/05_索引与变更记录/设计规范变更记录.md
10_工程化交接/项目整体梳理慢审计_v0.1.md
specs/mql5-fcz-reclaim-model/loop_agent_demand_grilling_contract.md
```

### 2.3 conditional_not_executed：已加载但按规则不继续执行

```text
dbs-chatroom：已加载，但未启动聊天室。原因：当前问题是项目继续入口和补全清单，不是多专家辩论；该 skill 要求先推荐专家并等待 owner 确认。
dbs-save：已加载，但未写入 ~/.dbs/sessions。原因：当前项目已有 repo 内 durable memory，应优先写入项目 Markdown、索引、变更记录和 Git。
dbs-report：已加载，但未生成 ~/.dbs/reports。原因：dbs-report 只能合并 dbs-save 存档，不应从聊天凭空生成报告。
```

### 2.4 forbidden：本轮明确禁止

```text
交易执行
私钥
swap
gmgn-swap
gmgn-cooking
自动下单
cron job
批量重构目录
批量移动历史文件
未经授权创建真实 GitHub issue
未经授权合并 PR
```

---

## 3. 目标审计：这轮目标是否清楚

用户目标原话：

```text
按照这个目标来进行 V0.5 需求拷问，并列出详细的需要补全的。
```

可检查目标改写：

```text
围绕“新增 Project Continuation Brief，让项目能回答从哪里继续”这一目标，执行一轮 V0.5 需求拷问，输出并落地一份包含详细补全清单、当前主线、边界、验收标准和下一步顺序的项目继续简报。
```

目标判定：

| 检查项 | 判定 | 说明 |
|---|---|---|
| 可指物性 | 通过 | 完成物是 `10_工程化交接/Project_Continuation_Brief_v0.1.md` |
| 可否证性 | 通过 | 如果仍无法回答“从哪里继续 / 需要补什么”，则未完成 |
| 有完成态 | 通过 | 文件落地、索引/变更记录更新、validate_all 通过 |
| 语法健全 | 通过 | Agent 写一个项目继续入口文件，并列出补全清单 |
| 嵌在上下文 | 通过 | 不重构目录，不复制完整方法论，只做轻量承接 |

---

## 4. Good Question Brief

### 4.1 Improved Agent-Usable Question

```text
在当前 meme- / MQL5 第一控盘区成本中枢回收模型知识库中，如何用一个非侵入式 Project Continuation Brief，固定“当前从哪里继续、哪些模块已完成但未接入、哪些补全项优先、哪些需要 owner 决策、哪些禁止推进”，从而减少新 Agent 接手时依赖 owner 口头提醒？
```

### 4.2 当前现象

```text
README / ROADMAP / 索引 / 变更记录 / specs / issues 都存在，但它们分别回答不同问题：
- README 回答项目是什么。
- ROADMAP 回答阶段路线。
- 索引回答文件在哪里。
- 变更记录回答过去改了什么。
- specs / issues 回答局部任务怎么做。

缺口是：没有一个文件直接回答“现在接手，第一眼应该做什么、别做什么、先补什么”。
```

### 4.3 核心冲突

```text
项目已经越来越工程化，但接手入口仍然依赖 owner 记忆。
```

### 4.4 约束

```text
1. 不重构目录。
2. 不批量搬迁旧文件。
3. 不把 V0.5 / DBS skill 全文复制进业务仓库。
4. 不把研究观察推进成自动交易。
5. 不制造新的大而全方法论文件。
6. 只做能减少后续接手摩擦的最小导航层。
```

### 4.5 反馈入口

```text
1. 新 Agent 能否只读 README + 本文件，就知道下一步做什么。
2. Owner 是否还需要口头提醒“之前完善过的那套在哪里”。
3. 后续 issue / validator / 样本任务是否能从本文件直接定位。
4. validate_all 是否通过。
```

---

## 5. 当前项目状态一句话

```text
项目已从本地策略研究知识库，升级到 GitHub 可协作知识库雏形；当前最缺的不是继续扩理论，而是把已有样本、V0.5 loop、validator、旧资料、新结构和下一步任务接成稳定导航层。
```

---

## 6. 当前应该先读什么

新 Agent 接手本项目时，推荐顺序：

```text
1. README.md
2. AGENTS.md
3. SOURCE_OF_TRUTH.md
4. 10_工程化交接/Project_Continuation_Brief_v0.1.md
5. 00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md
6. 00_知识库设计规范/05_索引与变更记录/设计规范变更记录.md
7. ROADMAP.md
8. skills/mql5-fcz-reclaim-kb/SKILL.md
```

如果本轮涉及 V0.5 需求拷问，还要读：

```text
specs/mql5-fcz-reclaim-model/loop_agent_demand_grilling_contract.md
specs/mql5-fcz-reclaim-model/demand_theory_evolution_loop.md
10_工程化交接/V0.5需求拷问理论补全体系承接清单_v0.1.md
10_工程化交接/项目整体梳理慢审计_v0.1.md
```

---

## 7. 当前主线地图

| 主线 | 当前状态 | 主要文件 | 现在缺什么 |
|---|---|---|---|
| GitHub 项目治理层 | 已建立并在 PR 分支中 | README、ROADMAP、.github、PR 模板、issue 草案 | 需合并到 main；真实 issue 尚未创建 |
| V0.5 需求拷问运行态 | 已补运行契约与一次 runtime audit | loop_agent_demand_grilling_contract、runtime report、V0.5 承接清单 | 需做 loop report validator |
| 项目继续入口 | 本文件新增 | Project_Continuation_Brief_v0.1.md | 后续 README/ROADMAP 应引用 |
| 样本标注主线 | 已启动 | 07_样本标注、FCZ_B/C/D、CSV、raw_refs | FCZ_B 待补真实失败样本；C/D 待图表派生结构 |
| GMGN 字段扩展 | 已产出 | GMGN样本标注字段扩展、字段表、采集清单 | 需接入样本 validator 和 ROADMAP |
| Validator / CI | 基础已建立 | scripts、tests、validate_all、GitHub Actions | 缺 sample record、index、loop report validators |
| Concept Search Absorption Loop | 方法存在，入口弱 | 05_关键词检索、06_资料吸收、demand_theory_evolution_loop | 缺 issue 模板 / 质量门 |
| MQL5 观察器 MVP | 需求 v0.2 已有 | 08_指标需求 | 缺 MVP 开发计划 |
| 旧资料与新结构桥接 | 旧资料保留，新结构已建 | 策略完善_v0.2、知识库迭代机制_v0.1、文章库、代码库 | 缺“哪些只读 / 哪些可吸收 / 哪些当前主线”的标注 |

---

## 8. 详细需要补全清单

### P0-A：入口层补全

| ID | 补全项 | 为什么重要 | 建议动作 | 验收标准 |
|---|---|---|---|---|
| P0-A1 | README 引用 Project Continuation Brief | README 目前没有“从哪里继续”的入口 | 在 README 快速入口增加本文件 | 新 Agent 能从 README 找到本文件 |
| P0-A2 | ROADMAP 增加 V0.5 / Project Continuation Brief 位置 | ROADMAP 目前仍按 P0-P5，但未纳入 P60/P61 产物 | 在 ROADMAP P0/P2 加入 V0.5 接入与 continuation brief | ROADMAP 能解释为什么先补导航层 |
| P0-A3 | SOURCE_OF_TRUTH 增加项目继续入口 | 真源地图未列本文件 | 在当前下一步入口或工程化交接处引用本文件 | 真源入口能指向本文件 |
| P0-A4 | AGENTS.md 启动阅读顺序加入本文件 | Agent 启动规则未包含 continuation brief | 在启动阅读顺序中加入本文件 | Agent 规则层强制读取 |

### P0-B：V0.5 运行态补全

| ID | 补全项 | 为什么重要 | 建议动作 | 验收标准 |
|---|---|---|---|---|
| P0-B1 | loop report validator | 目前报告靠人工遵守契约 | 执行 issue-007，检查 report 必填字段 | validate_all 能检查报告 schema |
| P0-B2 | V0.5 runtime report 命名规范 | 现在已有一份报告，但目录规范刚开始 | 明确 reports 目录和命名格式 | 新报告可被 validator 发现 |
| P0-B3 | DBS Overlay 调用分层固化 | 已写入契约，但还未被自动检查 | validator 检查 loaded / referenced / forbidden 字段 | 不能再误报“全链条调用” |
| P0-B4 | 上游方法论引用规则 | 业务仓库不应复制完整方法论 | README/ROADMAP 只引用上游位置，不复制全文 | 业务项目保持轻量 |

### P1：样本标注补全

| ID | 补全项 | 为什么重要 | 建议动作 | 验收标准 |
|---|---|---|---|---|
| P1-1 | FCZ_B_0001 真实失败样本 | 当前是最关键反证空缺 | 搜索并补齐真实“模型符合但失败”样本 | 样本记录不再是待搜空壳 |
| P1-2 | FCZ_C_0001 图表派生结构 | C 样本已补基础字段，但结构派生不足 | 补 chart-derived fields | 能复核为何是 deeper review candidate |
| P1-3 | FCZ_D_0001 图表派生结构 | D 样本已归 no_trade，但需要结构证据 | 补 chart-derived fields | 能复核为何 no_trade |
| P1-4 | 样本记录 Markdown 字段完整性 validator | 单样本记录目前靠人工维护 | 执行 issue-004 | 缺字段时 CI 失败 |
| P1-5 | CSV / Markdown 同步规则 | CSV 和单样本记录可能漂移 | 扩展 validator 或写同步检查 | 关键字段不一致会被发现 |
| P1-6 | GMGN 字段扩展接入样本模板 | 字段扩展已产出但未完全绑定 | 更新样本模板 / validator 草案 | 新样本默认包含 GMGN 关键字段 |

### P2：知识库工程化补全

| ID | 补全项 | 为什么重要 | 建议动作 | 验收标准 |
|---|---|---|---|---|
| P2-1 | index reference validator | 索引越长越容易漂移 | 执行 issue-005 | 索引引用不存在时 CI 失败 |
| P2-2 | changelog format validator | 变更记录是长期审计线 | 新增 validator 检查阶段格式 | 新变更记录格式错误会失败 |
| P2-3 | specs / plan / tasks 一致性检查 | specs 目录越来越多 | validator 检查基本文件组合 | 缺 spec/plan/tasks/checklist 时提示 |
| P2-4 | Project Continuation Brief 自身维护规则 | 本文件可能过期 | 在 changelog 中要求重大阶段更新本文件 | 后续大阶段不丢状态 |

### P3：资料吸收与旧资料桥接补全

| ID | 补全项 | 为什么重要 | 建议动作 | 验收标准 |
|---|---|---|---|---|
| P3-1 | 旧资料只读 / 可吸收 / 当前主线分类 | 旧资料价值高但入口弱 | 新增轻量旧资料桥接表，不移动文件 | 新 Agent 知道哪些能读、哪些别改 |
| P3-2 | Concept Search Absorption issue 模板 | 遇到新概念容易直接脑补 | 新增 issue 草案或模板 | 新概念必须走检索→吸收→回填 |
| P3-3 | 资料吸收质量门 | 06_资料吸收已有很多文件，但缺检查 | 设计资料吸收 checklist / validator | 资料来源、不可照搬、影响字段齐全 |
| P3-4 | MQL5 / 论坛资料与策略结论边界 | 论坛观点不能直接升级结论 | 在入口层显性提醒 | 新资料不会直接覆盖策略定义 |

### P4：MQL5 观察器 MVP 补全

| ID | 补全项 | 为什么重要 | 建议动作 | 验收标准 |
|---|---|---|---|---|
| P4-1 | MQL5观察指标MVP开发计划_v0.1.md | ROADMAP 已列，但文件未写 | 执行 issue-006 | 明确 MVP 输入/输出/非目标/模块顺序 |
| P4-2 | 观察器 vs 自动交易边界 | 防止研究仓库滑向自动下单 | 在 MVP 计划中强制 non-goals | 明确不含 EA 下单 |
| P4-3 | 字段映射到模块优先级 | 需求已有，开发顺序未固化 | 从字段映射派生 MVP module list | Codex 可接小任务 |
| P4-4 | 人工复盘导出格式 | 观察器应服务样本复核 | 设计 CSV / Markdown 输出草案 | 可接入样本标注流程 |

### P5：GitHub / Agent 协作补全

| ID | 补全项 | 为什么重要 | 建议动作 | 验收标准 |
|---|---|---|---|---|
| P5-1 | 真实 GitHub issues 创建 | 当前是本地 issue 草案 | owner 授权后用 gh/API 创建 | issue 编号可追踪 |
| P5-2 | PR 分支合并策略 | main 是否强制 PR + CI 尚未决策 | Owner decision brief | main 保护策略明确 |
| P5-3 | Codex handoff 与实际 issue 绑定 | 目前 handoff 多为本地草案 | 每个可执行 issue 配对应 handoff | Codex 不从聊天接任务 |
| P5-4 | 项目 skill 更新 | 项目 skill 仍偏早期主线 | 把 V0.5 / GitHub / validator 入口补进去 | `skills/mql5-fcz-reclaim-kb/SKILL.md` 反映当前工作流 |

---

## 9. 当前最高优先级排序

按“减少 owner 口头提醒 + 提升后续可执行性”排序：

```text
1. P0-A1 / P0-A2 / P0-A3 / P0-A4：把 Project Continuation Brief 接入 README / ROADMAP / SOURCE_OF_TRUTH / AGENTS。
2. P0-B1：做 loop report validator，防止 V0.5 再次变成口头方法论。
3. P2-1：做 index reference validator，防止索引漂移。
4. P1-4：做 sample record markdown validator，保护样本主线。
5. P1-1：补 FCZ_B_0001 真实失败样本。
6. P1-2 / P1-3：补 C/D 图表派生结构。
7. P4-1：写 MQL5 观察器 MVP 计划。
```

推荐下一轮只做第 1 项：

```text
把 Project Continuation Brief 接入 README / ROADMAP / SOURCE_OF_TRUTH / AGENTS。
```

原因：

```text
本文件虽然已经存在，但如果入口文件不引用它，新 Agent 仍可能找不到它。先接入口层，再做 validator。
```

---

## 10. 不建议现在做的事

```text
1. 不要重构目录。
2. 不要批量移动旧资料。
3. 不要复制 V0.5 / DBS skill 全文进业务项目。
4. 不要创建 cron 自动巡检。
5. 不要进入自动交易、私钥、swap、自动下单。
6. 不要一口气创建所有 GitHub issues，先把本地 brief 和入口层稳定下来。
7. 不要继续扩写策略理论，除非样本或反证验证需要。
```

---

## 11. Owner 需要决策的问题

当前不阻塞本文件落地，但后续需要 owner 决策：

```text
1. 是否允许把本地 issue 草案批量创建为真实 GitHub Issues？
2. 是否把 main 分支设置为必须 PR + CI 通过后才能合并？
3. 下一阶段优先 P1 样本，还是 P2 validators？
4. 是否接受 dbs-chatroom 只作为按需技能，而不是每轮 V0.5 强制环节？
5. 是否把 dbs-save / dbs-report 的存档体系与当前 repo 内报告体系打通？
```

推荐默认：

```text
1. 暂不批量创建真实 issue，先完成入口层补全。
2. main 建议设置 PR + CI 保护，但需要 owner 在 GitHub 设置层确认。
3. 先 P2 validators，再 P1 样本补全；因为 validator 能保护后续样本质量。
4. dbs-chatroom 保持按需。
5. 暂不打通 dbs-save / dbs-report，当前项目优先使用 repo 内 Markdown + Git 作为 durable memory。
```

---

## 12. 本文件验收标准

本文件完成不等于所有补全项完成。它只完成“项目继续入口”。验收标准是：

```text
1. 文件存在：10_工程化交接/Project_Continuation_Brief_v0.1.md。
2. 包含本轮 V0.5 Runtime Skill Audit。
3. 明确当前主线地图。
4. 列出详细补全清单。
5. 明确下一轮最高优先级。
6. 更新知识库索引与变更记录。
7. python scripts/validate_all.py 通过。
```

---

## 13. 下一轮 invocation 建议

```text
读取 10_工程化交接/Project_Continuation_Brief_v0.1.md，执行 P0-A 入口层补全。

本轮只做：
1. README.md 引用 Project Continuation Brief。
2. ROADMAP.md 加入 V0.5 / Project Continuation Brief 位置。
3. SOURCE_OF_TRUTH.md 加入项目继续入口。
4. AGENTS.md 启动阅读顺序加入本文件。
5. 更新索引和变更记录。
6. 运行 python scripts/validate_all.py。

不要做：目录重构、旧资料搬迁、真实 GitHub issue 创建、自动交易、cron。
```
