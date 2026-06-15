# Demand Control Loop

> Feature / Project：mql5-fcz-reclaim-model  
> Stage：Long-running Demand Control Plane  
> Status：v0.1  
> Purpose：定义一个长期、受控、可重复运行的需求拷问审计循环，用于持续检查需求文档、Owner 决策、spec/plan/tasks、agent 执行边界和验证证据，防止项目在进入 Codex / 回测 / 自动交易前发生需求漂移或越权推进。  
> Source：`demand_grilling_brief.md`  
> Important：本循环只能审计、提示、生成报告；不能自行确认 Owner 决策，不能自行进入 Codex，不能自行创建真实 GitHub issue / PR，不能自行修改交易策略硬规则。

---

## 1. Why This Exists

当前项目已经建立 Demand Grilling Brief 控制门，但需求不是一次性澄清完就永久稳定。

随着后续继续补充术语、样本、反证实验、观察器需求、spec、issue 和 Codex handoff，项目可能出现：

```text
1. 未决 P0 问题被跳过。
2. 观察器需求被误写成交易系统。
3. Codex 被赋予策略定义权。
4. 失败样本被解释掉或排除。
5. spec / plan / tasks 与 Demand Grilling Brief 冲突。
6. 验证证据不足却进入下一阶段。
7. maker/checker/owner 权限边界不清。
8. 文档越写越多，但没有收敛为 Owner 决策。
```

因此需要一个长期运行的需求控制循环：

```text
定期读取控制面文档
→ 检查缺口、冲突、风险、越权和下一阶段资格
→ 生成需求拷问巡检报告
→ 只提出最高价值 Owner 问题或推荐默认动作
```

---

## 2. Loop Principle

> Note：如果目标不是只做巡检，而是“拷问需求澄清后落实并完善理论”，应优先使用 `specs/mql5-fcz-reclaim-model/demand_theory_evolution_loop.md`。本文件保留为偏审计/巡检的控制循环。

本循环不是自动推进实现。

它是：

```text
control-plane reviewer
```

用于长期执行：

```text
需求拷问
需求审计
Owner 决策提示
spec readiness 检查
Codex readiness 检查
maker/checker/stop condition 检查
```

本循环不得：

```text
1. 自行确认 Owner 决策。
2. 自行修改策略硬规则。
3. 自行创建真实 GitHub issue / PR。
4. 自行让 Codex 开始实现。
5. 自行把观察器升级为交易系统。
6. 自行删除或排除失败样本。
7. 无限扩写需求文档。
```

---

## 3. Inputs

每次循环必须读取以下控制面文件：

```text
specs/mql5-fcz-reclaim-model/demand_grilling_brief.md
specs/mql5-fcz-reclaim-model/clarification.md
specs/mql5-fcz-reclaim-model/good_question_brief.md
specs/mql5-fcz-reclaim-model/structural_observer_vs_quant_system_gate.md
specs/mql5-fcz-reclaim-model/decisions.md
specs/mql5-fcz-reclaim-model/spec.md
specs/mql5-fcz-reclaim-model/plan.md
specs/mql5-fcz-reclaim-model/tasks.md
specs/mql5-fcz-reclaim-model/checklist.md
11_问题清单/待决策问题_v0.1.md
12_决策记录/决策记录_v0.1.md
00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md
00_知识库设计规范/05_索引与变更记录/设计规范变更记录.md
```

按需要读取：

```text
03_语义概念/核心术语表_v0.1.md
06_资料吸收/资料吸收_GMGN作为meme市场数据源_v0.1.md
07_样本标注/样本标注模板_v0.1.md
09_规则与回测/反证实验设计_v0.1.md
09_规则与回测/状态机规则整合_v0.1.md
07_样本标注/反证样本库_v0.1.csv
07_样本标注/模拟反证样本库_v0.1.csv
C:/Users/Administrator/gmgn_requirement_knowledge_base/README.md
C:/Users/Administrator/gmgn_requirement_knowledge_base/09_指标与量化准备工作/01_GMGN指标字典.md
C:/Users/Administrator/gmgn_requirement_knowledge_base/09_指标与量化准备工作/02_GMGN数据仓库设计.md
C:/Users/Administrator/gmgn_requirement_knowledge_base/09_指标与量化准备工作/05_GMGN多源校验与补源清单.md
```

---

## 4. Loop Steps

### Step 1：Load Control Plane

读取 Demand Grilling Brief、decisions、待决策问题、spec/plan/tasks/checklist。

检查：

```text
1. Demand Grilling Brief 是否存在。
2. 是否仍是当前控制面真源。
3. decisions.md 是否记录最新 Owner 决策。
4. 待决策问题是否有 P0 未处理。
```

---

### Step 2：Detect Unresolved P0 / P1 Decisions

扫描 `11_问题清单/待决策问题_v0.1.md`：

```text
P0：进入下一阶段前必须决策。
P1：可暂定推进，但后续必须确认。
P2：可延后。
```

输出：

```text
highest_value_owner_question
recommended_default
why_it_matters
blocked_stage
```

---

### Step 3：Detect Contradictions

检查以下冲突：

```text
1. Demand Grilling Brief 与 spec/plan/tasks 冲突。
2. decisions.md 与待决策问题冲突。
3. Non-goals 与新增任务冲突。
4. Codex boundary 与 tasks 冲突。
5. 观察器 / 标注器定位与自动交易语言冲突。
6. 反证原则与样本处理方式冲突。
```

冲突必须进入巡检报告，不得静默修正。

---

### Step 4：Detect Scope Creep

检查是否出现以下 scope creep：

```text
1. 从研究库直接跳到自动交易。
2. 从观察器直接跳到买卖信号。
3. 从样本模板直接跳到收益结论。
4. 从 Codex 文档任务跳到策略定义任务。
5. 从模拟样本演练跳到有效性证明。
6. 从本地 draft 跳到真实 GitHub / PR side effects。
```

---

### Step 5：Detect Missing Verification Evidence

检查：

```text
1. 是否运行 validate_all.py。
2. 是否有真实输出记录。
3. 是否存在未更新索引的新文件。
4. 是否存在未更新变更记录的新阶段。
5. 是否有 checklist 仍未完成。
6. 是否把“文件生成”误写成“策略验证”。
```

---

### Step 6：Classify Next Stage

每次循环必须给出下一阶段分类：

```text
more_questions
owner_decision
spec_refinement
issue_draft
codex_ready
maintainer_orchestrator_ready
blocked
```

分类规则：

```text
1. 存在 P0 未决策略定义 → owner_decision。
2. spec 与 Demand Brief 冲突 → spec_refinement。
3. 没有明确 maker/checker/authority → more_questions。
4. 已有明确 issue scope + tests + authority boundary → issue_draft。
5. 有明确 issue + Codex handoff + verification plan + no owner blocker → codex_ready。
6. 多 issue / 多 worker / 多 checker → maintainer_orchestrator_ready。
7. 验证失败或权限不足 → blocked。
```

---

### Step 7：Generate Report

每次循环输出一个报告，可写入：

```text
specs/mql5-fcz-reclaim-model/reports/demand_control_loop_report_<YYYYMMDD_HHMM>.md
```

如果是 cron 自动运行，建议只在发现变化、风险或 Owner 决策点时生成报告，避免噪音。

---

## 5. Report Template

```md
# Demand Control Loop Report <timestamp>

## 1. Summary

```text
Stage classification：
Highest-value issue：
Recommended default：
Blocked：yes / no
```

## 2. Files Inspected

```text
...
```

## 3. P0 / P1 Decision Status

```text
P0 unresolved：
P1 unresolved：
```

## 4. Contradictions Detected

```text
None / list
```

## 5. Scope Creep Detected

```text
None / list
```

## 6. Verification Evidence

```text
Command：
Output：
```

## 7. Agent Execution Classification

```text
Classification：Autonomous / Needs owner / Blocked
Maker：
Checker：
Authority boundary：
Cannot proceed without：
```

## 8. Loop Stop Condition Check

```text
Success condition met：yes / no
Stop condition triggered：yes / no
Reason：
```

## 9. Critique Prompts

```text
Weakest assumption：
Most likely false-success trap：
Highest-risk module / document：
Simpler alternative：
Owner-only decision：
```

## 10. Missing Questions

```text
1.
2.
3.
```

## 11. Recommended Next Action

```text
...
```

## 12. Exact Owner Question

```text
只问一个最高价值问题。
```
```

---

## 6. Hard Stops

循环必须停止并生成 blocker brief 的情况：

```text
1. 需要 Owner 决定 P0 策略定义。
2. 需要授权 GitHub / Codex / PR / push。
3. 需要修改交易系统边界。
4. 需要引入真实资金、凭据、交易 API。
5. validate_all.py 失败且不是纯文档索引问题。
6. maker/checker 循环超过 2 轮仍未收敛。
7. 发现 Codex 或 Agent 被赋予策略定义权。
8. 发现观察器被误写为自动交易系统。
```

---

## 7. Blocker Brief Format

```text
Blocker：一句话说明卡点。
Why it matters：为什么影响下一阶段。
Evidence：文件 / 命令 / 输出。
Options：A/B/C。
Recommended default：建议默认选择。
Exact owner question：只问一个最高价值问题。
```

---

## 8. Cron / Automation Policy

### 8.1 Recommended Frequency

当前阶段建议：

```text
manual run 或 daily run。
```

不建议：

```text
hourly run
```

原因：需求文档变化频率不高，过度自动化会产生噪音。

### 8.2 Cron Job Must Not

```text
1. 不递归创建新的 cron job。
2. 不自动进入 Codex。
3. 不自动创建 GitHub issue / PR。
4. 不自动修改策略规则。
5. 不自动确认 Owner 决策。
6. 不在没有变化时反复发送冗余报告。
```

### 8.3 Cron Job May

```text
1. 读取控制面文档。
2. 检查未决问题、冲突、scope creep、验证证据。
3. 运行 validate_all.py。
4. 生成简短巡检报告。
5. 如果发现 P0 blocker，向 Owner 汇报一个最高价值问题。
```

---

## 9. Manual Run Prompt

手动触发需求控制循环时，可以使用：

```text
读取 specs/mql5-fcz-reclaim-model/demand_control_loop.md，执行一次 Demand Control Loop。
必须读取 demand_grilling_brief.md、decisions.md、待决策问题、spec/plan/tasks/checklist、索引、变更记录。
检查 P0/P1 未决问题、冲突、scope creep、验证证据、下一阶段分类。
运行 python scripts/validate_all.py。
生成 demand_control_loop_report_<timestamp>.md。
不要进入 Codex，不要创建 GitHub issue/PR，不要确认 Owner 决策。
最后只汇报报告路径、验证输出和一个最高价值 Owner 问题。
```

---

## 10. Current Default Next Question

若立即执行本循环，当前最高价值 Owner 问题预计是：

```text
第一控盘区的最终默认量化定义是什么，或者是否允许先用 PROPOSED 默认定义进入样本标注试运行？
```

推荐默认：

```text
先用 PROPOSED 默认定义进入样本标注试运行，但标记为待验证，不进入交易规则。
```

---

## 11. Completion Criteria For This Loop Definition

```text
1. demand_control_loop.md 存在。
2. demand_grilling_brief.md 已引用长期控制门。
3. spec/checklist/索引/变更记录已更新。
4. validate_all.py 通过。
5. 未自动创建 cron job，除非 Owner 另行明确授权。
```
