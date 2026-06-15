# Demand Grilling Brief

> Feature / Project：mql5-fcz-reclaim-model  
> Stage：需求拷问控制门 / Demand Control Gate  
> Status：v0.1，基于 Owner 最新 AI 方法轮确认  
> Source：`clarification.md`、`good_question_brief.md`、`decisions.md`  
> Purpose：把“第一控盘区成本中枢回收模型”的模糊研究需求，压缩成 agent 可执行、可批判、可验证、可进入后续 spec / issue / owner decision 的控制面输入。  
> Control-plane rule：本文件是需求拷问斗的统一输出，不展示内部 skill 混战，不等于实现任务。

---

## 1. Original Ask

用户希望继续推进“第一控盘区成本中枢回收模型”项目，并要求不要只把聊天结论整理成文件，而要按最新 AI 方法轮的需求拷问斗执行：

```text
需求拷问斗不是单个 skill，也不是问卷；
而是 dbs-good-question 作为主路由器，按需融合 brainstorming、grill-me、grill-with-docs、clarify、maintainer-orchestrator、codex-execution-loop、tdd-verification-loop、review-quality-gate、loop-orchestration-control-plane 等拷问能力；
最终输出 Demand Grilling Brief / Good Question Brief，决定能否进入 spec / issue / Codex / maintainer-orchestrator / owner decision。
```

---

## 2. Improved Agent-Usable Question

```text
Given 当前 MQL5_第一控盘区成本中枢回收模型_学习资料 项目已经具备策略知识库、反证样本库、状态机、样本 CSV 校验器、validate_all 质量门禁，以及初步 spec 四件套，

for Owner / 研究者本人 和 AI Agent / Codex / Claude，

clarify and control-gate the “第一控盘区成本中枢回收模型” so that it can first remain a research knowledge base + GMGN meme-market data-source mapping + sample labeling + falsification audit + observer-requirement source, and only later, after evidence gates, become a candidate backtestable / deployable trading system,

while preserving the constraints that it is not currently an auto-trading system, not a profit promise, not a buy/sell signal product, and Codex must not define strategy logic or exclude failures by itself.

Success means the project has a Demand Grilling Brief that defines goal, users, scope, assumptions, risks, acceptance criteria, verification plan, agent execution classification, maker/checker boundary, stop conditions, critique prompts, missing questions, and next stage.

Verify by checking that the brief exists, is indexed, logged in the change log, and `python scripts/validate_all.py` passes.

If blocked, ask Owner only for the highest-value missing decision, especially P0 definitions such as first-control-zone definition, cost-center priority, deep-washout/death-market boundary, or next-stage authorization.
```

---

## 3. Intent and Alternatives

### 3.1 True Goal

短中期目标：

```text
1 + 2：研究型目标 + 工具型目标
```

具体为：

```text
先把“第一控盘区成本中枢回收模型”从主观交易叙事，转化为可定义、可反证、可标注、可回测的研究对象；
同时沉淀为 GMGN 数据源映射 + MQL5 / 复盘观察器 / 状态标注器的需求来源，辅助人工识别第一控盘区、深洗、重新接受、二次启动和风险状态。
```

长期目标：

```text
3：GMGN 驱动的 meme 市场量化自动交易系统
```

具体为：

```text
最终在研究验证、样本标注、反证实验、消融实验、多源校验、回测、交易成本验证、paper trading、quote-only dry run、manual approval trading 和执行安全门通过后，再逐步升级为可回测、可部署、可执行的 meme 市场量化交易系统，终局能力包括自动筛选、自动交易、自动下单、自动止盈止损、监控审计和风控熔断。
```

### 3.2 Is Current Request a Goal or Implementation Idea?

当前不是单一功能实现想法，而是一个研究项目向循环代理工程化控制面迁移的需求。

### 3.3 Alternative Approaches

```text
方案 A：研究库优先
先完善 clarification、Demand Grilling Brief、定义、术语、反证、样本模板、Owner 决策。

方案 B：半自动标注器 / 观察器优先
在定义稳定后，再做 MQL5 / 脚本观察器或样本标注辅助工具。

方案 C：回测原型优先
等规则、样本、可执行性、反证框架较稳定后，再进入初版回测原型。
```

### 3.4 Recommended Default

Owner 已确认：

```text
先 A，再 B，最后 C。
```

Hard gate：

```text
未完成 A，不进入 B。
未完成 B 的观察与标注验证，不进入 C。
```

---

## 4. Context and Constraints

### 4.1 Repo / System

```text
C:/Users/Administrator/Documents/MQL5_第一控盘区成本中枢回收模型_学习资料
```

### 4.2 Current State

当前项目已有：

```text
AGENTS.md
SOURCE_OF_TRUTH.md
skills/mql5-fcz-reclaim-kb/SKILL.md
00_知识库设计规范/...
03_语义概念/核心术语表_v0.1.md
07_样本标注/样本标注模板_v0.1.md
09_规则与回测/反证实验设计_v0.1.md
11_问题清单/待决策问题_v0.1.md
12_决策记录/决策记录_v0.1.md
specs/mql5-fcz-reclaim-model/clarification.md
specs/mql5-fcz-reclaim-model/demand_grilling_brief.md
specs/mql5-fcz-reclaim-model/demand_control_loop.md
specs/mql5-fcz-reclaim-model/good_question_brief.md
specs/mql5-fcz-reclaim-model/decisions.md
specs/mql5-fcz-reclaim-model/spec.md
specs/mql5-fcz-reclaim-model/plan.md
specs/mql5-fcz-reclaim-model/tasks.md
06_资料吸收/资料吸收_GMGN作为meme市场数据源_v0.1.md
C:/Users/Administrator/gmgn_requirement_knowledge_base
C:/Users/Administrator/source_repos/gmgn-skills
scripts/validate_all.py
```

### 4.3 Existing Constraints

来自项目规则：

```text
1. 所有重要结论必须落到本地 Markdown 文件，不只停留在聊天上下文。
2. 不把推测写成已确认结论。
3. 不把观察指标写成自动交易建议。
4. 不破坏已有目录结构与历史版本。
5. 新增文件必须更新索引与变更记录。
6. 策略、指标、评分、样本标注四层必须分开，不混写。
```

### 4.4 Risky Areas

```text
1. 将观察模型误升级为自动交易系统。
2. 让 Codex 代替 Owner 定义策略概念。
3. 用成功样本事后重画第一控盘区或 AVWAP 锚点。
4. 用模拟样本或理论叙事宣称策略有效。
5. 直接进入回测导致伪精确。
6. 未更新索引 / 变更记录导致项目真源失效。
7. 把 GMGN signal / trending / smartmoney 数据直接解释为买卖建议。
8. 未做多源校验就把 GMGN 安全、流动性、持仓、钱包标签视为唯一真源。
9. 在当前阶段引入 GMGN_PRIVATE_KEY、swap、strategy create 等交易执行权限。
```

---

## 5. Scope and Non-Goals

### 5.1 In Scope

```text
1. 建立 Demand Grilling Brief 控制面输出。
2. 明确目标、用户、边界、假设、风险、验收、验证、代理执行分类和停止条件。
3. 更新 spec/checklist，使其承认需求拷问控制门是进入 spec / issue / Codex 前置 gate。
4. 更新索引与变更记录。
5. 运行 validate_all.py 验证项目未破坏。
```

### 5.2 Non-Goals

Owner 已确认当前阶段不做：

```text
1. 不做自动下单系统。
2. 不承诺收益率。
3. 不把观察指标写成买卖信号神器。
4. 不直接进入 Codex 实现策略逻辑。
5. 不直接做正式回测结论。
6. 不把外部理论直接升级为核心规则。
7. 不因为失败样本而事后修改定义。
8. 不把图形成立等同于交易可执行。
9. 不把 GMGN signal / trending / smartmoney 数据直接写成买卖建议。
10. 不在当前阶段使用 GMGN_PRIVATE_KEY、swap、multi-swap、strategy create 等交易执行能力。
```

### 5.3 Do Not Casually Change

```text
1. 不移动或删除历史资料。
2. 不重写已有 spec/plan/tasks 的核心定位，除非为接入 Demand Grilling Brief gate 做最小更新。
3. 不新增交易执行代码。
4. 不修改样本 CSV 数据来适配理论。
```

---

## 6. Assumptions and Risks

### 6.1 Confirmed Assumptions

```text
H1. 第一控盘区在一部分 meme / 高波动标的中确实存在，并能代表早期主要资金成本或价值共识。

H2. 成本中枢可以通过 POC / Value Area / AVWAP / 结构区间等方式在事前近似表达。

H3. 深洗和死亡盘虽然相似，但存在可观察差异，至少可以通过样本标注逐步区分。

H4. 重新接受成本中枢比普通反抽更有可能对应后续二次启动。

H5. 二次启动、诱多、失败反抽之间可以通过结构、成交、回撤和执行结果建立可标注差异。

H6. 该模型最终是否能进入交易系统，取决于反证样本、消融实验、可执行性和回测结果，而不是理论叙事本身。

H7. 即使策略最终不能自动交易，观察器 / 标注器 / 风险审计器仍可能有独立价值。
```

### 6.2 Risky / Falsifying Conditions

```text
F1. 符合第一控盘区 + 深洗 + 重新接受 + 二次启动的样本，后续大量失败。

F2. 所谓成功样本主要依赖事后重画第一控盘区、移动 AVWAP 锚点或修改成本中枢。

F3. 去掉深洗、重新接受或二次启动等核心条件后，表现没有明显变差，说明核心条件只是叙事。

F4. 大量大涨样本不符合该模型，却能被更简单规则捕获，说明模型过度复杂或覆盖率不足。

F5. 图形上成立的信号在真实交易中不可执行，例如滑点过大、买不到、止损过远、流动性不足。

F6. 模型需要不断新增过滤条件才能解释失败，且新增条件不能事前识别。

F7. AI Agent / Codex 无法在不自行解释策略的情况下稳定标注样本，说明定义仍不够清晰。

F8. 回测或样本验证显示收益主要来自市场 beta / 暴涨行情，而非模型条件本身。
```

### 6.3 Security / Ops / Permission Concerns

```text
1. 当前不接实盘交易 API。
2. 当前不保存 API key、token、私钥、交易所凭据。
3. 当前不创建真实 GitHub issue / PR，除非 Owner 提供 repo 与授权。
4. 当前不允许 Codex merge / release / push。
5. 当前所有新增结论必须进入文件、索引、变更记录。
```

---

## 7. Acceptance Criteria

```text
AC1. demand_grilling_brief.md 已生成，并包含 13 个标准段落。

AC2. Improved Agent-Usable Question 已明确当前上下文、用户、目标、约束、成功标准、验证方式和 blocker 问法。

AC3. 已明确 Owner 确认目标：短中期 1 + 2，长期 3。

AC4. 已明确用户排序：Owner / AI Agent / 未来自动交易系统 / 未来普通用户。

AC5. 已明确当前 Non-goals，不进入自动下单、收益承诺、Codex 策略实现或正式回测结论。

AC6. 已明确 H1-H7 核心假设和 F1-F8 失败模式。

AC7. 已明确 Agent Execution Classification、Maker、Checker、Authority Boundary。

AC8. 已明确 Verification Plan 和 False-success traps。

AC9. 已明确 Loop Stop Conditions 和 Blocker Brief Format。

AC10. spec.md / checklist.md 已更新以引用 Demand Grilling Brief gate。

AC11. 知识库索引与设计规范变更记录已更新。

AC12. `python scripts/validate_all.py` 通过。
```

---

## 8. Verification Plan

### Unit

```text
当前无新增代码，不需要新增 unit test。
```

### Integration

```text
python scripts/validate_all.py
```

### E2E / Playwright

```text
不适用。当前无 UI。
```

### Manual QA

检查：

```text
1. demand_grilling_brief.md 是否包含 13 个标准段落。
2. 是否清楚说明 maker / checker / authority / stop condition。
3. 是否未把策略写成自动交易建议。
4. 是否未绕过 Owner 决策。
5. 是否更新索引与变更记录。
```

### Security

```text
无凭据、无 API key、无交易接口、无外部写操作。
```

### Accessibility

```text
不适用。当前为 Markdown 文档。
```

### CI / Live Proof

```text
python scripts/validate_all.py 输出 OK: all project validation checks passed。
```

---

## 9. Agent Execution Classification

### Classification

```text
Needs owner for strategy-definition decisions.
Autonomous for documentation consolidation, index/change-log updates, and validation commands.
```

### Handoff Target

当前阶段：

```text
Demand Grilling Brief / owner decision / spec refinement
```

不是：

```text
Codex implementation
```

### Maker

```text
Hermes agent as documentation/control-plane maintainer.
```

后续可选：

```text
Codex as bounded maker only after spec / issue / handoff is explicit。
```

### Checker

当前 checker：

```text
Owner + scripts/validate_all.py + project index/change-log checks。
```

后续 checker：

```text
tests / CI / QA reviewer / owner decision。
```

### Authority Boundary

Agent 可以自主执行：

```text
1. 生成或更新 Markdown 文档。
2. 更新知识库索引。
3. 更新设计规范变更记录。
4. 运行本地验证脚本。
```

Agent 不可自主执行：

```text
1. 定义最终交易规则。
2. 选择最终成本中枢优先级。
3. 设定深洗 / 死亡盘硬阈值。
4. 删除失败样本。
5. 创建真实 GitHub issue / PR，除非 Owner 授权。
6. 让 Codex 写自动交易系统。
7. merge / release / deploy。
```

### Cannot Do Without Owner Approval

```text
1. 进入 Codex 实现阶段。
2. 创建真实 GitHub issue / PR。
3. 初始化或推送 git repo。
4. 把观察器升级为交易系统。
5. 确认 P0 策略定义问题。
```

---

## 10. Loop Stop Conditions

### Max Maker / Checker Loops

当前文档控制门阶段：

```text
最多 2 轮 maker/checker 修订。
```

若 2 轮后仍无法收敛，必须输出 blocker brief，而不是继续扩写。

### Success Condition

```text
1. demand_grilling_brief.md 存在。
2. spec/checklist 承认 Demand Grilling Brief gate。
3. 索引和变更记录更新。
4. validate_all.py 通过。
5. Owner 没有指出核心 gate 方向错误。
```

### Stop Condition

必须停止并返回 Owner 的情况：

```text
1. 需要 Owner 决定 P0 策略定义。
2. 需要授权 GitHub / Codex / PR / push。
3. 需要修改交易系统边界。
4. 需要引入真实资金、凭据、交易 API。
5. 验证脚本失败且无法在文档层修复。
```

### Blocker Brief Format

如果阻塞，输出：

```text
Blocker：一句话说明卡点。
Why it matters：为什么影响下一阶段。
Evidence：文件 / 命令 / 输出。
Options：A/B/C。
Recommended default：建议默认选择。
Exact owner question：只问一个最高价值问题。
```

### Owner Decision Rule

```text
产品定义、交易风险、权限、GitHub side effects、Codex 执行、merge/release/deploy 必须 Owner 决策。
```

---

## 11. Critique Prompts

后续 reviewer / checker 应持续攻击以下问题：

```text
1. 哪个假设最弱？
2. 哪种情况会让 agent 假成功？
3. 是否只是把成功样本叙事化？
4. 是否有更简单的 baseline 能做到同样效果？
5. 是否把观察器误写成交易系统？
6. Codex 是否被赋予了策略定义权？
7. 样本是否存在后视偏差？
8. 回测是否会被不稳定规则污染？
9. 是否缺少真实样本、失败样本、不可执行样本？
10. 哪个决策必须 Owner 亲自做？
```

---

## 12. Missing Questions

当前最高价值未决问题：

```text
1. 第一控盘区的最终默认量化定义是什么？
2. 成本中枢默认优先级是什么：POC / Value Area / AVWAP / 结构区间？
3. 深洗与死亡盘的硬边界是什么？
```

这些问题进入下一轮 owner decision，不应由 Codex 或 worker 自行决定。

---

## 13. Next Stage

当前状态：

```text
Ready for owner decision or spec refinement.
Not ready for Codex implementation.
Not ready for auto-trading system.
```

可选下一步：

```text
A. 处理 P0 Owner 决策问题。
B. 将 Demand Grilling Brief 同步进 spec / plan / tasks 的前置 gate。
C. 生成下一阶段 issue draft，但仅限文档 / 样本标注 / 观察器需求，不进入交易执行。
D. 按 specs/mql5-fcz-reclaim-model/demand_theory_evolution_loop.md 执行长期“需求拷问 → 理论完善 → 文件落实”循环，每次只处理一个最高价值理论缺口。
E. 按 specs/mql5-fcz-reclaim-model/demand_control_loop.md 手动或定期执行 Demand Control Loop，仅做需求审计、冲突检查、Owner 问题提示，不自动进入 Codex。
F. 按 structural_observer_vs_quant_system_gate.md 先完成“结构观察器 vs 完整量化体系”的成熟度升级门判断：当前默认仍是结构观察器，下一步优先 GMGN 样本标注 MVP，不直接进入回测/自动交易。
```

推荐默认：

```text
先使用 demand_theory_evolution_loop.md 执行长期“需求拷问 → 理论完善 → 文件落实”循环；第一轮最高价值理论缺口是：GMGN 样本标注 MVP 需要哪些最小字段，才能支持 FCZ 结构可标注、可反证、可重复观察。
```
