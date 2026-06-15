# Demand Theory Evolution Loop

> Feature / Project：mql5-fcz-reclaim-model  
> Stage：Long-running AI Demand Grilling → Theory Refinement Loop  
> Status：v0.1  
> Purpose：定义一个长期自动运行的循环代理需求拷问机制：AI 持续读取需求文档和研究知识库，自动发现理论缺口、拷问假设、提出最高价值问题，并在不越权的前提下把可落实的理论完善写入本地 Markdown 文件。  
> Important：本循环不是只生成巡检报告；它的目标是“拷问需求澄清后，落实并完善理论”。但它仍然不能自行确认 Owner 决策、不能进入交易执行、不能把观察模型升级为完整量化体系。

---

## 1. 为什么需要这个循环

之前的 `demand_control_loop.md` 更偏：

```text
需求审计
冲突检查
scope creep 检查
Owner 决策提示
```

这还不够。

Owner 当前真实需求是：

```text
AI 根据现有需求文档，长期、自动地进行需求拷问和判断推理；
不是只问问题，而是每次拷问后要把能落实的理论完善写进知识库；
持续把项目从模糊结构想法推进为更清晰、更可反证、更可标注、更可验证的理论体系。
```

因此需要升级为：

```text
Demand Theory Evolution Loop
= 需求拷问控制门
+ 理论缺口发现器
+ 反证审计器
+ 文档落实器
+ Owner 决策边界守卫
```

---

## 2. 与 Demand Control Loop 的区别

### 2.1 Demand Control Loop

主要回答：

```text
当前需求有没有冲突？
有没有越权？
能不能进入下一阶段？
需要 Owner 决策什么？
```

输出偏：

```text
巡检报告
blocker brief
next-stage classification
```

### 2.2 Demand Theory Evolution Loop

主要回答：

```text
当前理论哪里还不清楚？
哪个假设最弱？
哪个概念需要进一步定义？
哪个字段需要加入样本标注？
哪个反证条件还不够硬？
GMGN 数据如何补强或限制当前理论？
哪些内容可以直接写入知识库，哪些必须留给 Owner 决策？
```

输出偏：

```text
理论完善补丁
需求拷问报告
待决策问题
反证/样本/术语/数据源文档更新
索引与变更记录
validate_all 验证输出
```

---

## 2.1 Non-invasive Adoption Guard

Owner 最新修正：

```text
项目现实 > 方法轮。
方法轮是外部控制层 / 工作协议，不应反客为主。
```

因此本循环必须采用渐进式接入原则：

```text
1. 不为了方法论重构项目。
2. 不把所有 skill、模板、方法文件一次性塞进仓库。
3. 不回头强行补全所有历史 spec。
4. 不让项目从“交易策略研究项目”变成“方法论展示项目”。
5. 只把当前继续推进所必需的最小控制文件、理论补丁、样本字段、决策记录写入仓库。
6. 对半成品项目，先做 continuation brief / 当前状态对齐，再从下一个最小需求切片开始应用方法轮。
```

方法轮接入分三档：

```text
A 档：外部控制层，不进仓库。适合临时/小项目。
B 档：轻量接入。只加最小项目记忆和 QA/spec 骨架。默认推荐。
C 档：完整接入。只适合长期、多 Agent、多 PR、多 CI 的稳定项目。
```

当前项目已经有较多控制面文件，因此后续必须避免继续扩张方法论文件；优先把循环用于：

```text
GMGN 样本标注 MVP
FCZ 理论可标注性
反证样本字段
多源校验字段
观察器需求
```

而不是继续新增方法论层。

---

## 3. 核心原则

本循环每次运行必须遵守：

```text
1. 先拷问，再完善。
2. 只处理一个最高价值理论缺口，避免一次扩写太多。
3. 所有结论必须落到本地 Markdown 文件。
4. 明确区分 DECIDED / PROPOSED / UNKNOWN / REQUIRES_OWNER。
5. 可以完善理论、模板、映射、反证框架；不能确认策略有效。
6. 可以更新结构观察器、样本标注、风险审计、数据源理论；不能升级为完整量化体系。
7. 可以提出 GMGN 字段映射；不能启用 GMGN 交易执行能力。
8. 每次修改后必须更新索引 / 变更记录，并运行 validate_all.py。
```

---

## 4. Inputs

每次循环必须读取：

```text
specs/mql5-fcz-reclaim-model/demand_grilling_brief.md
specs/mql5-fcz-reclaim-model/demand_control_loop.md
specs/mql5-fcz-reclaim-model/structural_observer_vs_quant_system_gate.md
specs/mql5-fcz-reclaim-model/decisions.md
specs/mql5-fcz-reclaim-model/spec.md
specs/mql5-fcz-reclaim-model/plan.md
specs/mql5-fcz-reclaim-model/tasks.md
11_问题清单/待决策问题_v0.1.md
12_决策记录/决策记录_v0.1.md
00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md
00_知识库设计规范/05_索引与变更记录/设计规范变更记录.md
```

按本轮拷问主题追加读取：

```text
01_策略定义/策略成熟度定位与商业角色_v0.1.md
03_语义概念/核心术语表_v0.1.md
06_资料吸收/资料吸收_GMGN作为meme市场数据源_v0.1.md
07_样本标注/样本标注模板_v0.1.md
09_规则与回测/反证实验设计_v0.1.md
09_规则与回测/策略成熟度质疑审计与商业诊断_v0.1.md
C:/Users/Administrator/gmgn_requirement_knowledge_base/README.md
C:/Users/Administrator/gmgn_requirement_knowledge_base/09_指标与量化准备工作/01_GMGN指标字典.md
C:/Users/Administrator/gmgn_requirement_knowledge_base/09_指标与量化准备工作/02_GMGN数据仓库设计.md
C:/Users/Administrator/gmgn_requirement_knowledge_base/09_指标与量化准备工作/05_GMGN多源校验与补源清单.md
```

---

## 5. 每次循环的 9 步

### Step 1：读取控制面

读取需求控制门、决策、成熟度升级门、待决策问题和变更记录。

输出：

```text
current_stage
confirmed_decisions
open_decisions
last_change_stage
```

---

### Step 2：选择一个最高价值理论缺口

每次只选一个，不平均处理所有问题。

候选缺口类型：

```text
A. 概念定义缺口：如第一控盘区、深洗、重新接受仍不够可标注。
B. 数据源映射缺口：如 GMGN 字段如何映射到 FCZ/死亡盘/二次启动。
C. 样本字段缺口：如 CSV / Markdown 样本模板缺少 GMGN provenance 字段。
D. 反证缺口：如什么样本能推翻 GMGN-driven 结构观察器。
E. 成熟度缺口：如哪些证据允许进入回测。
F. 执行边界缺口：如 Codex / GMGN 权限是否越界。
```

选择标准：

```text
1. 是否阻塞下一阶段 GMGN 样本标注 MVP？
2. 是否能降低后视偏差？
3. 是否能让样本更可标注？
4. 是否能让理论更可反证？
5. 是否能减少 Codex / Agent 越权？
```

---

### Step 3：用 7 个拷问镜头推理

每个理论缺口用以下镜头拷问：

```text
1. 意图拷问：这个理论补丁解决什么真实问题？
2. 上下文拷问：现有文档怎么说？是否冲突？
3. 边界拷问：它能做什么，不能做什么？
4. 假设/风险拷问：它依赖哪些未证实前提？
5. 代理执行拷问：AI 能否自动落实？是否需要 Owner？
6. 验证拷问：怎样证明这个理论补丁写对了？
7. 停止条件拷问：何时必须停下来问 Owner？
```

---

### Step 4：分类本轮输出类型

每次运行只能选择一种主输出：

```text
TYPE_A_THEORY_PATCH：可直接写入理论/术语/资料吸收文档的完善。
TYPE_B_SAMPLE_SCHEMA_PATCH：可直接写入样本标注模板或 schema proposal 的完善。
TYPE_C_FALSIFICATION_PATCH：可直接写入反证实验设计的完善。
TYPE_D_OWNER_DECISION_BRIEF：需要 Owner 决策，不能自行写成已确认。
TYPE_E_BLOCKER_REPORT：存在阻塞，无法安全推进。
```

---

### Step 5：落实到文件

如果是 TYPE_A/B/C，可以写入或更新对应文件。

允许更新：

```text
03_语义概念/核心术语表_v0.1.md
06_资料吸收/*.md
07_样本标注/*.md
09_规则与回测/*.md
11_问题清单/待决策问题_v0.1.md
specs/mql5-fcz-reclaim-model/*.md
```

如果是 TYPE_D/E，只写：

```text
reports / owner_decision_brief / blocker brief
```

不得把未确认内容写成 DECIDED。

---

### Step 6：写循环报告

每次运行生成：

```text
specs/mql5-fcz-reclaim-model/reports/theory_evolution_report_<YYYYMMDD_HHMM>.md
```

报告必须包含：

```text
本轮选择的最高价值理论缺口
使用的拷问镜头
本轮结论
更新了哪些文件
哪些内容是 PROPOSED
哪些内容需要 Owner
验证输出
下一轮建议
```

---

### Step 7：更新索引与变更记录

若新增正式文件，必须更新：

```text
00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md
00_知识库设计规范/05_索引与变更记录/设计规范变更记录.md
```

若只更新既有文件，也要在变更记录中记录阶段。

---

### Step 8：运行验证

必须运行：

```bash
cd '/c/Users/Administrator/Documents/MQL5_第一控盘区成本中枢回收模型_学习资料' && python scripts/validate_all.py
```

---

### Step 9：输出给 Owner

最终只汇报：

```text
1. 本轮拷问的理论缺口。
2. 已落实的文件。
3. 验证输出。
4. 下一个最高价值 Owner 问题。
```

不要输出大段文档正文。

---

## 5.1 DBS Method Wheel Overlay

每轮 Demand Theory Evolution Loop 内部叠加 DBS 方法轮，不是另开一套流程，而是作为本循环的“拷问 → 目标化 → 知识工程化 → 审查 → 决策 → 存档 → 报告”执行骨架。

```text
/dbs-good-question
→ /dbs-goal
→ /dbs-content-system
→ /dbs-chatroom
→ /dbs-slowisfast
→ /dbs-decision
→ /dbs-save
→ /dbs-report
```

### 5.1.1 /dbs-good-question：选择最高价值理论缺口

作用：

```text
把“继续完善理论”这种宽泛请求，压缩成本轮唯一最高价值问题。
```

在本项目中优先问：

```text
1. 哪个理论缺口最阻塞 GMGN 样本标注 MVP？
2. 哪个假设最容易造成后视偏差？
3. 哪个字段缺失会让样本不可反证？
4. 哪个未决问题最可能导致 Codex / Agent 越权？
```

输出：

```text
highest_value_theory_gap
improved_question
why_now
```

### 5.1.2 /dbs-goal：把缺口变成可验收交付物

作用：

```text
把理论问题改写成可检查的文件、字段、模板或报告。
```

示例：

```text
不是：完善 GMGN 样本标注。
而是：生成 GMGN 样本标注字段扩展，至少包含 data_source_primary、source_capabilities、gmgn_raw_refs、data_confidence_*、gmgn_conflict_flags、gmgn_multisource_required，并说明哪些字段进入 CSV、哪些只进入 Markdown 样本记录。
```

输出：

```text
deliverable_path
acceptance_criteria
verification_command
```

### 5.1.3 /dbs-content-system：把理论补丁落入知识库结构

作用：

```text
决定理论补丁应该进入哪个目录、是否新增文件、是否更新索引和变更记录。
```

归位规则：

```text
术语定义 → 03_语义概念/
GMGN 资料吸收 → 06_资料吸收/
样本字段 → 07_样本标注/
反证实验 → 09_规则与回测/
需求控制面 → specs/mql5-fcz-reclaim-model/
Owner 决策 → 12_决策记录/ 与 specs/.../decisions.md
```

输出：

```text
content_destination
files_to_update
index_changelog_required
```

### 5.1.4 /dbs-chatroom：多角色批评理论补丁

作用：

```text
在写入前模拟多角色审查，避免理论补丁只是顺着原假设继续深化。
```

建议角色：

```text
策略审计师：这个补丁是否只是增加解释能力？
量化研究员：这个补丁能否被样本验证？
数据工程师：字段是否能从 GMGN 稳定采集？
风控负责人：是否降低死亡盘 / 诱多误判？
产品负责人：是否符合当前结构观察器定位？
执行负责人：是否误触交易执行权限？
反证研究员：什么样本能推翻这个补丁？
```

输出：

```text
role_critiques
judge_summary
revision_needed
```

### 5.1.5 /dbs-slowisfast：判断是否必须慢做

作用：

```text
判断本轮理论补丁是否可以自动落地，还是必须先停下来等 Owner 决策。
```

必须慢做的情况：

```text
1. 涉及策略硬阈值。
2. 涉及交易执行权限。
3. 涉及完整量化体系升级。
4. 会改变第一控盘区 / 成本中枢 / 深洗 / 重新接受核心定义。
5. 会影响样本成功 / 失败判定。
```

输出：

```text
fast_allowed: true / false
slow_reason
owner_decision_needed
```

### 5.1.6 /dbs-decision：记录 Owner 决策与未决问题

作用：

```text
把已确认内容写入决策记录，把未确认内容写入待决策问题。
```

输出：

```text
decisions_to_record
open_questions_to_add
status: DECIDED / PROPOSED / UNKNOWN / DEFERRED
```

### 5.1.7 /dbs-save：保存阶段状态

作用：

```text
把本轮理论演化状态写入变更记录和报告，方便后续 Agent 恢复。
```

输出：

```text
change_log_entry
report_path
validation_output
```

### 5.1.8 /dbs-report：输出本轮理论演化报告

作用：

```text
以简短报告形式告诉 Owner：本轮拷问了什么、完善了什么、还缺什么。
```

报告不得变成大段正文复制，只汇报：

```text
1. 本轮最高价值理论缺口。
2. 已更新文件。
3. 验证输出。
4. 下一个最高价值问题。
```

---

## 5.2 Concept Search Absorption Loop

当本轮理论缺口属于概念定义、外部成熟理论映射、MQL5/MQ5 实现方式、指标计算、论坛对标或失败案例时，必须进入 Concept Search Absorption Loop。

本循环用于恢复并正式纳入项目早期已经建立的研究方法：

```text
概念解析
→ 关键词拆解
→ MQL5 / MQ5 文章、论坛、代码库、Market 定向检索
→ 资料归类
→ 资料吸收
→ 理论回填
→ 样本字段 / 规则 / 指标需求更新
→ 决策记录 / 索引 / 变更记录
```

### 5.2.1 Step 1：Concept Deconstruction 概念解析

作用：

```text
把 Owner 的中文策略概念拆解成可检索、可对标、可吸收的交易术语。
```

示例：

```text
第一控盘区
→ Accumulation Range
→ Initial Balance
→ Value Area
→ HVN / POC
→ Base before Markup
```

```text
深洗
→ Liquidity Sweep
→ Spring
→ Stop Hunt
→ Deep Pullback
→ Shakeout
```

```text
重新接受
→ Reclaim
→ Value Area Re-entry
→ POC Reclaim
→ VWAP Reclaim
→ Acceptance
```

```text
二次启动
→ Second Leg
→ Second Push
→ SOS
→ LPS
→ BOS after Reclaim
```

输出：

```text
concept_map
search_terms_cn
search_terms_en
mql5_terms
external_theory_links
```

### 5.2.2 Step 2：Search Plan 关键词与检索计划

必须先读取或更新：

```text
05_关键词检索/第一控盘区_关键词与检索计划_v0.1.md
05_关键词检索/深洗与死亡盘_关键词与检索计划_v0.1.md
05_关键词检索/POC与AVWAP重新接受_关键词与检索计划_v0.1.md
05_关键词检索/诱多反抽与二次启动_关键词与检索计划_v0.1.md
05_关键词检索/基准策略对标_MQL5检索计划_v0.1.md
```

如果当前理论缺口没有对应检索计划，先创建：

```text
05_关键词检索/<主题>_关键词与检索计划_v0.1.md
```

检索计划必须包含：

```text
中文关键词
英文关键词
MQL5 中文站检索式
MQL5 英文站检索式
CodeBase 检索式
Forum 检索式
Market 产品检索式
优先检索目标
检索后应建立的资料吸收文件
```

### 5.2.3 Step 3：MQL5 / MQ5 Search 定向搜索

优先搜索范围：

```text
P1. MQL5 中文文章：https://www.mql5.com/zh/articles
P2. MQL5 中文代码库：https://www.mql5.com/zh/code/mt5
P3. MQL5 中文论坛：https://www.mql5.com/zh/forum
P4. MQL5 英文文章 / CodeBase / Forum
P5. MQL5 Market 产品描述，仅作功能对标，不作策略可信证据
P6. 俄文文章 / CodeBase，当英文中文资料不足时使用
```

搜索原则：

```text
1. 不泛搜“高胜率 EA”“稳定策略”“智能交易”等宽词。
2. 每次搜索必须围绕本轮理论缺口。
3. 每条资料必须能回答规则定义、实现方式或失败条件之一。
4. Market 页面只能作为模块常见度和功能对标，不作为策略有效性证据。
5. Forum 观点只能作为假设来源，不作为结论。
6. CodeBase 源码可作为实现参考，但不能证明策略有效。
```

### 5.2.4 Step 4：Source Classification 资料归类

每条资料必须归入一个类别：

```text
POC 基准
AVWAP 基准
Liquidity Sweep 基准
复合策略基准
GMGN 数据源字段映射
回测 / 优化 / 过拟合纪律
失败案例 / 反例
MQL5 实现参考
```

无法归类的资料默认不吸收。

记录字段：

```text
source_title
url
source_type
benchmark_group
relevance
source_code_available
backtest_or_empirical_evidence
failure_discussion
what_to_absorb
what_not_to_overclaim
impact_on_current_project
```

### 5.2.5 Step 5：Absorption Note 资料吸收笔记

资料吸收写入：

```text
06_资料吸收/资料吸收_<主题>_v0.1.md
```

吸收时只吸收三类内容：

```text
1. 规则定义：它到底怎么触发？
2. 实现方式：MQL5 里怎么计算、绘制、导出、回测？
3. 失败条件：它什么时候失效、过拟合、诱多、回撤过大？
```

不得只复制网页内容。

必须回答：

```text
1. 这条资料对当前模型有什么帮助？
2. 它证明了什么？没有证明什么？
3. 哪些内容能迁移到 FCZ 结构观察器？
4. 哪些内容不能迁移？
5. 是否说明当前策略只是成熟策略的一部分？
6. 是否需要新增反证样本或样本字段？
7. 是否需要更新 MQL5 观察器需求？
```

### 5.2.6 Step 6：Theory Patch 理论回填

资料吸收后，根据影响回填到对应目录：

```text
03_语义概念/        → 概念定义、边界、术语映射
04_风险管理/        → 诱多、死亡盘、失败回收、风险评分
07_样本标注/        → 样本字段、样本分类、标注模板
08_指标需求/        → MQL5 观察器字段、绘图、导出、状态机
09_规则与回测/      → 基准策略、消融实验、反证实验、回测纪律
specs/              → 需求控制面、MVP spec、agent handoff 边界
11_问题清单/        → 未决问题
12_决策记录/        → Owner 已确认决策
```

如果理论回填会改变核心定义或硬阈值，必须停下写 Owner Decision Brief，不得自动确认。

### 5.2.7 Step 7：Decision / Open Question 决策记录

已确认内容写入：

```text
12_决策记录/决策记录_v0.1.md
specs/mql5-fcz-reclaim-model/decisions.md
```

未确认内容写入：

```text
11_问题清单/待决策问题_v0.1.md
```

状态必须标注：

```text
DECIDED
PROPOSED
UNKNOWN
REQUIRES_OWNER
DEFERRED
```

### 5.2.8 Step 8：Index / Changelog / Verification

每次新增或更新后必须：

```text
1. 更新 00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md。
2. 更新 00_知识库设计规范/05_索引与变更记录/设计规范变更记录.md。
3. 运行 python scripts/validate_all.py。
4. 在本轮 theory_evolution_report 中记录验证输出。
```

### 5.2.9 当前已存在的本循环文件

关键词检索层：

```text
05_关键词检索/第一控盘区_关键词与检索计划_v0.1.md
05_关键词检索/深洗与死亡盘_关键词与检索计划_v0.1.md
05_关键词检索/POC与AVWAP重新接受_关键词与检索计划_v0.1.md
05_关键词检索/诱多反抽与二次启动_关键词与检索计划_v0.1.md
05_关键词检索/基准策略对标_MQL5检索计划_v0.1.md
```

资料吸收层：

```text
06_资料吸收/资料吸收_MarketProfile_POC_价值区域_v0.1.md
06_资料吸收/资料吸收_VolumeProfile_HVN_POC_v0.1.md
06_资料吸收/资料吸收_AccumulationRange_第一控盘区_v0.1.md
06_资料吸收/资料吸收_VWAP成本锚与确认机制_v0.1.md
06_资料吸收/资料吸收_POC价值区域回收_v0.1.md
06_资料吸收/资料吸收_AVWAP锚点选择_v0.1.md
06_资料吸收/资料吸收_Liquidity_Sweep_Reclaim_v0.1.md
06_资料吸收/资料吸收_Wyckoff_Spring_Test_LPS_v0.1.md
06_资料吸收/资料吸收_OrderBlock_Inducement_BOS_v0.1.md
06_资料吸收/资料吸收_假突破过滤与失败反抽_v0.1.md
06_资料吸收/资料吸收_二次启动结构确认_v0.1.md
06_资料吸收/资料吸收_基准策略对标总结_v0.1.md
06_资料吸收/资料吸收_GMGN作为meme市场数据源_v0.1.md
```

---

## 6. 自动完善理论的权限边界

### 可以自动完善

```text
1. 将已确认目标转化为更清晰的理论结构。
2. 把 GMGN 字段映射到样本标注字段草案。
3. 增加反证样本类型和失败模式。
4. 增加样本 provenance / data_confidence / gmgn_raw_refs 字段提案。
5. 增加观察器/标注器的非交易边界。
6. 将旧知识库结论归并到当前控制面。
7. 将未决问题写入待决策问题。
```

### 不能自动确认

```text
1. 第一控盘区最终量化定义。
2. 成本中枢最终优先级。
3. 深洗 / 死亡盘硬阈值。
4. 成功 / 失败 / 不可执行阈值。
5. 回测结果是否合格。
6. 是否进入 Codex 实现。
7. 是否使用 GMGN 执行能力。
8. 是否创建真实 GitHub issue / PR。
9. 是否升级为完整量化体系。
```

---

## 7. Hard Stops

以下情况必须停止并只输出 Owner Decision Brief：

```text
1. 本轮理论完善会改变策略核心定义。
2. 本轮需要设定硬阈值。
3. 本轮涉及交易执行、私钥、API key、swap、strategy create。
4. 本轮会把观察模型升级为量化体系。
5. 本轮验证失败且无法自动修复。
6. 同一问题连续两轮无法收敛。
```

---

## 8. Cron / Long-running Automation Policy

推荐频率：

```text
daily
```

每次运行最多处理：

```text
1 个最高价值理论缺口
```

不得：

```text
1. 自动递归创建 cron job。
2. 自动进入 Codex。
3. 自动创建 GitHub issue / PR。
4. 自动确认 Owner 决策。
5. 自动使用交易执行能力。
6. 因没有新信息而重复生成空报告。
```

可以：

```text
1. 自动读取需求文档。
2. 自动推理理论缺口。
3. 自动完善非决策性理论文档。
4. 自动生成报告。
5. 自动更新索引 / 变更记录。
6. 自动运行 validate_all.py。
```

---

## 9. First Recommended Loop Target

下一次自动/手动循环的最高价值理论缺口建议是：

```text
GMGN 样本标注 MVP 需要哪些最小字段，才能支持 FCZ 结构可标注、可反证、可重复观察？
```

推荐输出类型：

```text
TYPE_B_SAMPLE_SCHEMA_PATCH
```

推荐落实文件：

```text
07_样本标注/GMGN样本标注字段扩展_v0.1.md
specs/gmgn-fcz-sample-labeling-mvp/clarification.md
```

---

## 10. Manual Run Prompt

手动执行时使用：

```text
读取 specs/mql5-fcz-reclaim-model/demand_theory_evolution_loop.md，执行一次 Demand Theory Evolution Loop。
每次只选择一个最高价值理论缺口。
读取 demand_grilling_brief、structural_observer_vs_quant_system_gate、decisions、待决策问题、GMGN 数据源吸收文档、样本标注模板、反证实验设计。
用 7 个拷问镜头推理。
如果能自动落实，就更新对应理论/样本/反证文件；如果需要 Owner 决策，就只写 Owner Decision Brief。
生成 theory_evolution_report_<timestamp>.md。
更新索引和变更记录。
运行 validate_all.py。
不要进入 Codex，不要创建 GitHub issue/PR，不要确认 Owner 决策，不要使用 GMGN 执行能力。
```
