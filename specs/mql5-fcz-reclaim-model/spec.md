# MQL5 FCZ Reclaim Model Spec

> Feature: mql5-fcz-reclaim-model  
> Status: ready-for-issue-draft / research-to-engineering bridge  
> Method source: AI Method Wheel control plane (`https://github.com/sunshihao001/ai-`)  
> Project: `MQL5_第一控盘区成本中枢回收模型_学习资料`

---

## 1. Background

> Demand control gate：本 spec 必须以后续新增的 `specs/mql5-fcz-reclaim-model/demand_grilling_brief.md` 为前置输入。Demand Grilling Brief 是需求拷问斗的统一控制面输出，用于决定本项目是否进入 owner decision、spec refinement、issue、Codex 或 maintainer-orchestrator；未通过该 gate 前，不得进入 Codex 实现或自动交易系统。

当前项目已经从交易概念整理推进到：

```text
策略研究知识库
+ MQL5 / MT5 资料吸收库
+ 第一控盘区状态机
+ 反证样本库设计
+ 消融实验模板
+ 样本字段表
+ 真实/模拟样本 CSV
+ Python 校验脚本与基础 CI 草案
```

项目核心主题是：

```text
meme 庄家第一控盘区深洗后，基于 POC / AVWAP 成本锚重新接受与二次拉升确认的保守型 re-accumulation / reclaim 观察模型。
```

但当前项目不能继续停留在聊天和零散文档推进。后续应接入既有 AI Method Wheel：

```text
需求拷问 → spec → plan → tasks → GitHub issue → Codex handoff → TDD/QA/review → PR → CI → owner decision
```

本 spec 的目的，是把当前项目本身编译成一个可被 GitHub issue、Codex、QA、CI 持续推进的工程化目标，而不是重新发明方法论。

---

## 2. Goal

建立 `mql5-fcz-reclaim-model` 这一项目级 feature 的标准 spec 四件套，使后续所有实际开发或标注工作都能从 repo 文件出发，而不是从聊天上下文出发。

第一阶段目标不是写新的交易逻辑，而是明确：

```text
1. 当前项目是什么、不是什么。
2. 当前可执行工程目标是什么。
3. 哪些任务可交给 Codex 作为 maker。
4. 哪些结果必须经过 tests / CI / review / owner decision。
5. 如何防止观察模型被误升级为自动交易 EA。
```

---

## 3. Non-goals

本 feature 不做：

```text
1. 不重新设计 AI 工作流。
2. 不复制完整 ai- 方法论研究材料到本项目。
3. 不直接开发实盘 EA。
4. 不把 MQL5 观察指标写成自动下单系统。
5. 不声称策略稳定、成熟、可商业化。
6. 不基于模拟样本计算胜率、盈亏比或商业结论。
7. 不获取、保存或提交 API key、token、私钥、交易所凭据。
8. 不让 Codex 作为最终 checker。
9. 不跳过 spec / tasks / issue / QA / owner decision。
```

---

## 4. Current Repo Assets

当前项目已有的关键资产包括：

```text
AGENTS.md
CLAUDE.md
SOURCE_OF_TRUTH.md
skills/mql5-fcz-reclaim-kb/SKILL.md
00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md
00_知识库设计规范/05_索引与变更记录/设计规范变更记录.md
07_样本标注/样本字段表_v0.1.md
07_样本标注/反证样本库_v0.1.csv
07_样本标注/模拟反证样本库_v0.1.csv
09_规则与回测/状态机规则整合_v0.1.md
09_规则与回测/策略成熟度质疑审计与商业诊断_v0.1.md
09_规则与回测/消融实验执行模板_v0.1.md
scripts/validate_sample_csv.py
scripts/validate_state_paths.py
scripts/validate_all.py
tests/test_validate_sample_csv.py
tests/test_validate_state_paths.py
tests/test_validate_all.py
.github/workflows/validate.yml
10_工程化交接/pr_templates/project_validation_pr_description.md
```

---

## 5. Product Role

当前模型的正确定位：

```text
结构性观察模型
+ 样本标注框架
+ 反证审计框架
+ MQL5 观察指标需求源
+ 后续策略研究 / 回测 / 消融实验输入层
```

当前模型不是：

```text
成熟自动交易策略
实盘仓位执行 bot
收益承诺模型
直接买卖信号库
```

第一版商业角色应保持为：

```text
MQL5 观察指标 + 样本标注器 + 风险审查器
```

---

## 6. User Stories

### Story 1: Owner wants repo-based project truth

作为 owner，我希望当前策略研究和工程化下一步都落到 repo 文件中，而不是依赖聊天记录。

验收标准：

```text
spec / plan / tasks / checklist 四件套存在，并引用当前真实项目资产。
```

### Story 2: Maintainer wants bounded next issues

作为 maintainer，我希望后续任务能拆成 GitHub issue，每个 issue 都是一个可验证垂直切片。

验收标准：

```text
tasks.md 至少列出 3 个可独立执行的 vertical slices，并给出推荐第一 issue。
```

### Story 3: Codex needs safe handoff

作为 Codex maker，我需要明确只做一个 issue，不扩展 scope，不处理实盘凭据，不自判策略成熟。

验收标准：

```text
checklist.md 包含 Codex handoff gate、stop conditions、verification evidence 要求。
```

### Story 4: Reviewer needs evidence gates

作为 reviewer，我需要看到测试、CI、QA、风险审计证据，再决定是否进入下一阶段。

验收标准：

```text
checklist.md 包含 tests / CI / QA / security / owner decision gate。
```

---

## 7. Acceptance Criteria

本 feature 完成后必须满足：

```text
1. specs/mql5-fcz-reclaim-model/clarification.md 存在。
2. specs/mql5-fcz-reclaim-model/demand_grilling_brief.md 存在。
3. specs/mql5-fcz-reclaim-model/demand_control_loop.md 存在。
4. specs/mql5-fcz-reclaim-model/good_question_brief.md 存在。
5. specs/mql5-fcz-reclaim-model/decisions.md 存在。
6. specs/mql5-fcz-reclaim-model/spec.md 存在。
7. specs/mql5-fcz-reclaim-model/plan.md 存在。
8. specs/mql5-fcz-reclaim-model/tasks.md 存在。
9. specs/mql5-fcz-reclaim-model/checklist.md 存在。
10. clarification.md 明确 Goal / Users / Non-goals / Assumptions / Risks / Decisions / Open Questions / Acceptance Criteria。
11. demand_grilling_brief.md 明确 13 段控制门输出：Original Ask、Improved Agent-Usable Question、Intent、Context、Scope、Risks、Acceptance、Verification、Agent Execution、Loop Stop、Critique、Missing Questions、Next Stage。
12. demand_control_loop.md 定义长期需求审计循环、输入、步骤、报告模板、hard stops、blocker brief 和自动化边界。
13. good_question_brief.md 把模糊策略问题压缩成可验证研究问题。
14. decisions.md 明确 Owner 已确认决策和 Codex boundary。
15. spec / plan / tasks / checklist 明确复用 AI Method Wheel，不重新设计方法论。
16. 所有文件明确当前项目不是自动交易系统。
17. 所有文件明确 Codex 只作为 maker，不作为最终 checker。
18. tasks.md 给出后续 GitHub issue 拆分建议。
19. checklist.md 给出进入 GitHub issue / Codex / QA / owner decision 的门槛。
20. 知识库索引包含新增 spec 文件。
21. 设计规范变更记录包含本次阶段。
22. `python scripts/validate_all.py` 仍通过。
```

---

## 8. Edge Cases

```text
1. 当前目录还不是 git repo：不能假装已创建 GitHub issue / PR。
2. gh CLI 不可用：不能假装已使用 gh 创建 issue。
3. 用户要求“继续推进”：必须识别当前阶段是 spec、issue、Codex 还是 owner decision。
4. 样本仍然 pending：不能声称策略已经被真实样本验证。
5. 模拟样本存在：只能用于流程演练，不能作为策略有效性证据。
6. MQL5 指标需求存在：不能自动升级为下单 EA。
7. 文件路径含中文：脚本和文档必须兼容当前路径，不强制迁移。
```

---

## 9. Failure Modes

```text
1. 把方法论重新发明一遍，导致与 ai- control plane 分叉。
2. 把当前项目发散成新项目，例如误建“仓位执行bot”。
3. Codex 拿到过宽任务，开始重构整个知识库。
4. 未经真实样本和消融实验，就把观察模型写成交易策略。
5. 只生成聊天总结，没有落到 repo 文件。
6. 修改新增文件后不更新索引和变更记录。
7. 无测试输出却宣称已完成。
8. 将 GitHub / CI 状态说成已完成，但当前目录实际不是 repo 或 gh 不可用。
```

---

## 10. Security / Safety

```text
1. 不保存 API key、token、密码、私钥、交易所凭据。
2. 不自动下单。
3. 不接实盘交易 API。
4. 不把观察状态输出解释为交易建议。
5. 若后续涉及 GitHub token / CI secret / 交易平台 API，必须进入 owner decision。
6. Codex handoff 不得包含敏感凭据。
```

---

## 11. Testing Requirements

本 feature 的最小验证：

```text
python scripts/validate_all.py
```

期望现有项目级门禁通过：

```text
OK: all project validation checks passed
```

如果后续增加 spec 文件专用校验器，可另开 issue 实现：

```text
scripts/validate_specs.py
```

但本阶段不把它混入当前 feature，避免 scope creep。

---

## 12. QA Requirements

完成时必须报告：

```text
1. 新增文件列表。
2. 更新文件列表。
3. 实际运行的验证命令。
4. 实际验证输出。
5. 未完成的 GitHub / gh / PR 状态，不得假造。
6. 下一阶段推荐状态：Ready for GitHub issue / Ready for Codex / Ready for owner decision。
```

---

## 13. Human Decisions Needed

```text
1. GitHub repo URL / owner-repo：当前 UNKNOWN。
2. 是否允许当前目录 git init / push：需要 owner 明确确认。
3. 下一个真正可执行 issue 优先级：建议从“真实样本采集流程”或“MQL5观察指标MVP spec”中选择。
4. 是否创建 spec 文件校验器：可后置。
```

---

## 14. Current Stage

当前阶段：

```text
Ready for GitHub issue draft after this spec set is accepted.
```

推荐下一步：

```text
从 tasks.md 选择第一个 vertical slice，生成本地 GitHub issue 草案；如果 owner 提供 repo URL 与权限，再创建真实 GitHub issue。
```
