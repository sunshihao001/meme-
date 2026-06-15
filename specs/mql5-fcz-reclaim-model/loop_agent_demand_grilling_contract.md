# 循环代理需求拷问运行契约 v0.1

> Feature / Project：mql5-fcz-reclaim-model  
> Stage：Loop Agent Demand Grilling Runtime Contract  
> Status：v0.1 / PROPOSED  
> Purpose：把“循环代理的需求拷问”从方法描述升级为可执行、可审计、可停止、可验收的运行契约，避免 Agent 只是写方法论、无限追问或越权推进。  
> Related：`demand_control_loop.md`、`demand_theory_evolution_loop.md`、`skill_runtime_solution_and_dbs_good_question_report.md`

---

## 1. 本文件解决什么

Owner 当前要完善的不是普通需求文档，而是一个长期运行的循环代理机制：

```text
AI 反复读取项目上下文
→ 拷问当前最关键需求/理论缺口
→ 判断哪些能自动落实、哪些必须问 Owner
→ 把能落实的内容写入项目文件
→ 验证
→ 形成下一轮入口
```

之前已有：

```text
Demand Control Loop：偏审计 / 巡检 / 阻断越权
Demand Theory Evolution Loop：偏理论补丁 / 样本字段 / 反证回填
Skill Runtime Solution：证明 dbskill 和 GMGN 只读 skill 已安装并可调用
```

本文件补上缺口：

```text
1. 循环代理每轮到底如何启动。
2. 每轮必须实际加载哪些技能。
3. 每轮如何选“唯一最高价值问题”。
4. 什么情况下继续写文件，什么情况下必须停下来问 Owner。
5. 如何避免无限拷问、方法论膨胀、假装完成、越权交易化。
6. 每轮交付物、验证证据和 PR/Issue 关系是什么。
```

---

## 2. 与现有两个 loop 的关系

### 2.1 demand_control_loop.md

用途：

```text
巡检、审计、冲突检查、scope creep 检查、Owner 决策提示。
```

适用场景：

```text
“现在能不能进入下一阶段？”
“有没有越权？”
“spec/plan/tasks 是否冲突？”
```

### 2.2 demand_theory_evolution_loop.md

用途：

```text
需求拷问后，把可落实的理论补丁写入知识库。
```

适用场景：

```text
“哪个理论缺口最阻塞样本标注？”
“哪些字段能让 GMGN 样本可标注、可反证？”
“哪些失败模式要进入样本模板？”
```

### 2.3 本文件

用途：

```text
规定循环代理如何实际运行和汇报证据。
```

适用场景：

```text
“循环代理该怎么拷问需求？”
“怎么判断它不是只写方法论？”
“怎么防止无限循环或越权？”
“每轮交给 Agent 的 invocation contract 是什么？”
```

---

## 3. 循环代理总原则

```text
1. 项目现实 > 方法轮完整性。
2. 每轮只处理一个最高价值问题。
3. 先读真源，再拷问；不要凭聊天记忆推进。
4. 先判断是否可自动落实，再写文件。
5. 能写进业务文件，就不要只写报告。
6. 需要 Owner 决策时，只问一个最高价值问题。
7. 所有 PROPOSED / UNKNOWN / REQUIRES_OWNER 必须显式标注。
8. 每轮必须有验证证据，不能只说“已完成”。
9. 不调用交易执行能力，不引入私钥，不把观察器写成自动交易系统。
10. 不因为循环存在就自动创建 cron / issue / PR；除非 Owner 明确授权。
```

---

## 4. 每轮启动输入

每轮循环代理必须收到或自行生成以下输入：

```text
run_mode：manual / cron / issue / pr-review
loop_type：control_audit / theory_evolution / blocker_resolution / runtime_audit
owner_request：Owner 原始请求
current_branch：当前 git 分支，若涉及 PR
allowed_side_effects：read_only / write_files / commit_only / push_pr_allowed
forbidden_capabilities：交易执行、私钥、swap、自动下单、未授权 GitHub side effects
max_iterations：默认 2
```

如果这些输入缺失，使用默认值：

```text
run_mode：manual
loop_type：theory_evolution
allowed_side_effects：write_files
forbidden_capabilities：交易执行、私钥、swap、自动下单、未授权 GitHub side effects
max_iterations：2
```

---

## 5. 每轮必须实际加载的技能

本循环要求区分：

```text
1. installed：技能存在于当前 profile。
2. loaded：本轮通过 skill_view 实际加载。
3. referenced：只作为方法参考，没有实际加载。
4. forbidden：本轮明确不能调用。
```

### 5.1 基础必载

```text
dbs-good-question
spec-first-ai-engineering
```

用途：

```text
dbs-good-question：钉住本轮唯一最高价值问题。
spec-first-ai-engineering：把问题转成可执行、可验证、可交接的工程/研究任务。
```

### 5.2 V0.5 DBS Overlay 完整运行态

当 Owner 明确要求“按 V0.5 需求拷问端 / DBS Overlay 全链条执行”，或质疑“技能是否真的调用起来”时，不能只加载基础必载技能；必须进入 Runtime Skill Audit 模式。

此时必须实际加载并报告：

```text
dbs-good-question：钉住运行时好问题，并加载 runtime audit reference。
dbs-goal：检查本轮目标是否空转，改写为可检查交付物。
dbs-content-system：判断是否属于内容/知识结构化工程，避免方法论全量塞进业务仓库。
dbs-chatroom：判断是否需要多角色批评；若未启动聊天室，必须说明原因。
dbs-slowisfast：判断哪些环节值得慢做，哪些不应伪慢。
dbs-decision：判断是否涉及 Owner 决策、长期状态或待回填结果。
dbs-save：判断是否需要写入 ~/.dbs/sessions；若项目已有 durable memory，说明为何不用。
dbs-report：判断是否存在可合并存档；没有存档时不得凭空生成报告。
spec-first-ai-engineering：把需求拷问转成工程/研究可验证交付。
```

报告中必须区分：

```text
1. loaded：本轮通过 skill_view 实际加载。
2. referenced_only：只阅读或引用的方法文档 / 项目文件。
3. conditional_not_executed：已加载但按 skill 规则不执行下一步，并说明原因。
4. forbidden：本轮明确禁止调用。
```

禁止使用以下模糊表述：

```text
“按 V0.5 执行了”但不列 loaded 技能。
“调用了 DBS Overlay”但只加载了 dbs-good-question / dbs-decision。
“dbs-report 已使用”但没有读取 ~/.dbs/sessions 或没有说明为何不生成报告。
“dbs-chatroom 已使用”但没有进入推荐专家 / 等待确认 / 多 Agent 对话协议。
```

### 5.3 按需加载

```text
gmgn-market / gmgn-token / gmgn-portfolio / gmgn-track：只读 GMGN 数据和样本候选。
github-pr-workflow / github-issues / github-repo-management：涉及 PR / issue / CI / 上传。
```

### 5.4 明确禁止

```text
gmgn-swap
gmgn-cooking
GMGN_PRIVATE_KEY
自动下单脚本
未经授权创建 cron job
未经授权创建/合并 PR
把观察器升级成交易执行系统
```

---

## 6. 每轮 10 步运行协议

### Step 1：读取真源

必须读取：

```text
AGENTS.md
SOURCE_OF_TRUTH.md
skills/mql5-fcz-reclaim-kb/SKILL.md
00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md
00_知识库设计规范/05_索引与变更记录/设计规范变更记录.md
```

若涉及需求拷问，追加读取：

```text
specs/mql5-fcz-reclaim-model/demand_grilling_brief.md
specs/mql5-fcz-reclaim-model/demand_control_loop.md
specs/mql5-fcz-reclaim-model/demand_theory_evolution_loop.md
specs/mql5-fcz-reclaim-model/decisions.md
11_问题清单/待决策问题_v0.1.md
12_决策记录/决策记录_v0.1.md
```

### Step 2：运行态技能审计

输出并写入报告：

```text
skills_loaded_this_turn
skills_referenced_only
skills_forbidden_this_turn
missing_skills_if_any
```

### Step 3：语义发散与问题空间建模

用 `dbs-good-question` + `dbs-deconstruct` 先形成问题空间，而不是直接钉住唯一最高价值问题：

```text
observed_symptom
problem_world
solution_world
shared_phenomena
concept_map_seed
issue_tree_seed
owner_surface_terms：Owner 原始表层词，不直接当作唯一搜索词
interpreted_information_need：Agent 理解的真实信息需求
professional_concept_family：可搜索的专业概念族 / 上位概念 / 相邻概念
query_transformation_strategy：rewrite / expansion / decomposition / step-back / HyDE / multilingual
external_search_terms
search_query_variants：至少 5 条查询，覆盖中文、英文、领域术语、论坛语、论文/工程语
query_drift_risk：扩展后可能偏离 Owner 原意的风险
retrieval_failure_mode：词汇不匹配 / 过窄查询 / 过宽查询 / 语言不匹配 / 多问题混合
external_search_sources：至少列出本轮应检索/应说明不适用的来源；MQL5/策略实现类主题必须包含 https://www.mql5.com/zh/articles
constraints
feedback_entry
```

规则：

```text
1. 如果概念未拆清，不得直接收敛到执行任务。
2. 如果问题可能有多个 frame，至少保留 3 个候选框架。
3. 如果涉及理论升级，必须检索外部相似概念或论坛/文章来源。
4. 收敛对象改称 current_convergence_slice，不再称“唯一最高价值问题”。
5. 必须记录 unchosen_branches 和 revisit_trigger。
```

### Step 4：判断输出类型

只能选择一种主输出：

```text
TYPE_A_THEORY_PATCH
TYPE_B_SAMPLE_SCHEMA_PATCH
TYPE_C_VALIDATOR_OR_QUALITY_GATE
TYPE_D_OWNER_DECISION_BRIEF
TYPE_E_BLOCKER_REPORT
TYPE_F_RUNTIME_CONTRACT_PATCH
TYPE_G_CONCEPT_SEMANTIC_MAP
TYPE_H_EXTERNAL_CONCEPT_ABSORPTION
TYPE_I_LOOP_SELF_PATCH
```

### Step 5：权限分类

```text
Autonomous：可以写文件 + 验证。
Needs owner：只能写 Owner Decision Brief，不能确认结论。
Blocked：只能写 blocker report。
Read-only：只输出报告，不改文件。
```

判断规则：

```text
涉及核心策略定义 / 硬阈值 / 成功失败判定 / 交易执行 / 私钥 / 资金 / 合并发布 → Needs owner 或 Blocked。
涉及文档入口 / issue 草案 / validator spec / 非决策性字段提案 → Autonomous。
```

### Step 6：执行文件落地

根据输出类型写入对应位置：

```text
理论补丁 → 03_语义概念 / 04_风险管理 / 09_规则与回测
样本 schema → 07_样本标注 / specs/<feature>
validator → scripts / tests / specs / 10_工程化交接/issues
运行契约 → specs/mql5-fcz-reclaim-model
Owner 决策 → 11_问题清单 / 12_决策记录 / specs/.../decisions.md
报告 → specs/mql5-fcz-reclaim-model/reports
```

### Step 7：写循环报告

报告路径：

```text
specs/mql5-fcz-reclaim-model/reports/loop_agent_demand_grilling_report_<YYYYMMDD_HHMM>.md
```

报告必须包含：

```text
1. problem_world / solution_world / shared_phenomena。
2. concept_map_seed / issue_tree_seed。
3. external_sources_absorbed，若本轮涉及理论升级。
4. 当前收敛切片 current_convergence_slice。
5. 未选分支 unchosen_branches 与 revisit_trigger。
6. 实际加载技能。
7. 禁止调用技能。
8. 输出类型。
9. 权限分类。
10. 更新文件。
11. PROPOSED / UNKNOWN / REQUIRES_OWNER 项。
12. 验证输出。
13. 下一轮建议。
```

### Step 8：更新索引和变更记录

新增正式文件必须更新索引。

每轮有实质更新必须更新变更记录。

### Step 9：运行验证

默认验证：

```bash
python scripts/validate_all.py
```

如果本轮新增 validator，还要运行对应 validator 和 tests。

### Step 10：Owner 汇报

最终回复只汇报：

```text
1. 本轮拷问的问题。
2. 写入了哪些文件。
3. 验证是否通过。
4. PR / branch / commit / CI 状态，若适用。
5. 下一个最高价值 Owner 问题。
```

不要把大段报告正文复制进聊天。

---

## 7. 停止条件

以下任一条件触发，循环必须停止：

```text
1. 需要 Owner 确认策略核心定义。
2. 需要设置硬阈值。
3. 需要判断样本成功/失败最终归类且证据不足。
4. 需要使用交易执行能力或私钥。
5. validate_all 失败且无法在本轮自动修复。
6. 同一问题两轮仍未收敛。
7. 本轮没有新增信息，只会重复生成报告。
8. Agent 正在继续扩写方法论但没有落到业务文件、validator、issue 或决策。
9. 当前 PR 已经超出原 scope，需要另开 issue / PR。
```

停止后只能输出：

```text
Blocker
Why it matters
Evidence
Options
Recommended default
Exact owner question
```

---

## 8. 防假完成检查

每轮结束前必须自检：

```text
1. 是否真的读取了项目真源？
2. 是否真的加载了相关技能？
3. 是否只处理了一个最高价值问题？
4. 是否写入了文件，而不是只在聊天里总结？
5. 是否更新索引和变更记录？
6. 是否运行了 validate_all？
7. 是否把 PROPOSED 写成 DECIDED？
8. 是否误触交易执行边界？
9. 是否产生了下一轮明确入口？
10. 是否能用 git diff / CI / 报告路径验证？
```

如果任一答案为否，不能汇报“完成”。

---

## 9. 循环代理最小 Invocation Prompt

手动运行时使用：

```text
读取 specs/mql5-fcz-reclaim-model/loop_agent_demand_grilling_contract.md，执行一轮循环代理需求拷问。

本轮只选择一个最高价值问题。
必须实际加载并报告 dbs-good-question 与 spec-first-ai-engineering；按需加载 dbs-decision / dbs-content-system / dbs-chatroom / dbs-slowisfast / GMGN 只读 skills / GitHub skills。
必须读取 AGENTS.md、SOURCE_OF_TRUTH.md、项目 skill、索引、变更记录和相关 specs。

根据问题分类为：theory patch / sample schema patch / validator gate / owner decision / blocker / runtime contract patch。
能自动落实就写入项目文件；需要 Owner 决策就只写 Owner Decision Brief。
生成 loop_agent_demand_grilling_report_<timestamp>.md。
更新索引和变更记录。
运行 python scripts/validate_all.py。
禁止调用交易执行能力、私钥、swap、自动下单、未授权 cron、未授权 GitHub side effects。
最终只汇报文件路径、验证输出、下一个最高价值 Owner 问题。
```

---

## 10. 当前推荐下一轮

```text
本轮类型：TYPE_C_VALIDATOR_OR_QUALITY_GATE
最高价值问题：如何把“循环代理需求拷问是否真的按契约运行”转成可验证的项目质量门？
推荐交付物：loop-agent report schema / checklist validator 草案。
原因：当前已经有运行契约，但还缺自动检查循环报告是否包含 required evidence 的 validator。
```
