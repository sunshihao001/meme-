# Clarification

> Feature / Project：mql5-fcz-reclaim-model  
> Stage：需求拷问斗 / intent-brainstorm-grill  
> Status：v0.1，Owner 已确认  
> Purpose：把“第一控盘区成本中枢回收模型”的模糊研究目标，压缩成可进入 Good Question Brief / spec / issue / Codex 前的明确需求输入。  
> Hard gate：目标、用户、边界、假设、失败模式、方案路线、验收标准未写清楚前，不进入 spec / issue / Codex / 自动交易实现。

---

## 1. Method Wheel Position

当前文件位于 AI 方法轮第一关：

```text
需求拷问斗
→ Good Question Brief
→ Spec / PRD / ADR
→ 任务切片
→ GitHub Issue
→ Codex 执行
→ TDD / QA / 安全 / 可访问性 / CI
→ Code Review
→ Commit / PR
→ Owner Decision
```

本阶段使用的主能力是：

```text
intent-brainstorm-grill
```

该能力融合：

```text
Superpowers：brainstorming
Matt Pocock：grill-me
Matt Pocock：grill-with-docs
Spec Kit：clarify
```

核心不是调用一堆分散 skill，而是把“问清楚需求”的能力合并成一个前置关卡。

---

## 2. Goal

### 2.1 短中期目标

```text
1 + 2：研究型目标 + 工具型目标
```

具体表述：

```text
先把“第一控盘区成本中枢回收模型”从主观交易叙事，转化为可定义、可反证、可标注、可回测的研究对象；
同时沉淀为 GMGN 数据源映射 + MQL5 / 复盘观察器 / 状态标注器的需求来源，辅助人工识别第一控盘区、深洗、重新接受、二次启动和风险状态。
```

### 2.2 长期目标

```text
3：交易系统目标
```

具体表述：

```text
最终在研究验证、样本标注、反证实验、消融实验和可执行性评估通过后，再考虑升级为可回测、可部署、可执行的交易系统。
```

### 2.3 当前 hard gate

```text
没有完成研究定义、反证样本、标注体系、消融实验和观察器验证前，不进入自动交易系统。
```

---

## 3. Users

当前用户与操作者排序：

```text
1. Owner / 研究者本人
   用于人工复盘、策略研究、样本标注、反证审计、判断是否值得继续工程化。

2. AI Agent / Codex / Claude
   作为执行者读取项目上下文，生成模板、整理样本、写校验脚本、生成后续 spec / issue / handoff，但不得自行定义策略。

3. 未来自动交易系统
   作为长期目标中的机器消费对象，读取规则、状态机、风险过滤器和回测结果。

4. 未来普通交易者 / 客户
   作为更远期商业产品用户，使用观察器、风险审计器或信号辅助工具。
```

当前阶段的主要用户不是普通交易者，也不是自动交易系统；当前阶段首要用户是 Owner 和 AI Agent。

---

## 4. Non-goals

当前阶段明确不做：

```text
1. 不做自动下单系统。
2. 不承诺收益率。
3. 不把观察指标写成买卖信号神器。
4. 不直接进入 Codex 实现策略逻辑。
5. 不直接做正式回测结论。
6. 不把外部理论直接升级为核心规则。
7. 不因为失败样本而事后修改定义。
8. 不把图形成立等同于交易可执行。
```

当前 MVP 边界：

```text
研究定义 + 样本标注 + 反证审计 + 观察器需求源
```

不是：

```text
实盘系统 / 收益系统 / 自动交易 / 完整回测结论
```

---

## 5. Assumptions

当前核心假设：

```text
H1. 第一控盘区在一部分 meme / 高波动标的中确实存在，并能代表早期主要资金成本或价值共识。

H2. 成本中枢可以通过 POC / Value Area / AVWAP / 结构区间等方式在事前近似表达。

H3. 深洗和死亡盘虽然相似，但存在可观察差异，至少可以通过样本标注逐步区分。

H4. 重新接受成本中枢比普通反抽更有可能对应后续二次启动。

H5. 二次启动、诱多、失败反抽之间可以通过结构、成交、回撤和执行结果建立可标注差异。

H6. 该模型最终是否能进入交易系统，取决于反证样本、消融实验、可执行性和回测结果，而不是理论叙事本身。

H7. 即使策略最终不能自动交易，观察器 / 标注器 / 风险审计器仍可能有独立价值。
```

---

## 6. Risks / Failure Modes

以下失败情况一旦出现，模型不能继续被当作“准交易系统”推进，只能降级为研究 / 观察 / 标注 / 风险审计工具：

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

---

## 7. Options Compared

### 7.1 方案 A：研究库优先

```text
先完善 clarification、Good Question Brief、定义、术语、反证、样本模板、Owner 决策。
```

优点：

```text
基础稳，后续少返工。
```

缺点：

```text
短期没有可运行工具。
```

### 7.2 方案 B：半自动标注器 / 观察器优先

```text
先做 MQL5 / 脚本观察器或样本标注辅助工具，把第一控盘区、POC / AVWAP、深洗、重新接受等字段半自动标出来。
```

优点：

```text
能快速把理论变成可观察字段。
```

缺点：

```text
如果定义没定清，工具会固化错误规则。
```

### 7.3 方案 C：回测原型优先

```text
直接把当前模型写成初版规则，跑样本或历史数据。
```

优点：

```text
最快看到数字反馈。
```

缺点：

```text
规则不稳定时回测容易变成伪精确，甚至误导方向。
```

### 7.4 Owner 确认路线

```text
先 A，再 B，最后 C。
```

即：

```text
A. 研究库优先
→ B. 半自动标注器 / 观察器优先
→ C. 回测原型优先
```

当前 hard gate：

```text
未完成 A，不进入 B。
未完成 B 的观察与标注验证，不进入 C。
```

---

## 8. Decisions

已确认决策：

```text
D1. 当前目标是 1 + 2，最终目标是 3。
D2. 当前用户排序为：Owner / AI Agent / 未来自动交易系统 / 未来普通用户。
D3. 当前阶段 Non-goals 已确认，不做自动下单、不承诺收益、不直接进入 Codex、不直接做正式回测结论。
D4. H1-H7 核心假设已确认。
D5. F1-F8 失败模式已确认。
D6. 路线确认：先研究库，再半自动标注器 / 观察器，最后回测原型。
D7. 当前 clarification 阶段验收标准 AC1-AC10 已确认。
```

---

## 9. Open Questions

以下问题仍需在后续 Owner Decision Brief 或 spec 阶段继续确认：

```text
1. 第一控盘区的最终默认量化定义。
2. 成本中枢默认优先级：POC / Value Area / AVWAP / 结构区间。
3. 深洗和死亡盘的硬边界。
4. 重新接受的最低确认标准。
5. 二次启动是否必须突破前高 / BOS / 放量。
6. 首批样本市场、周期、数量。
7. 成功 / 失败 / 不可执行的阈值。
8. 半自动观察器的第一版字段范围。
9. 回测原型的最小可行规则集。
```

---

## 10. Acceptance Criteria

当前“需求拷问斗 / clarification 阶段”完成标准：

```text
AC1. 已生成 clarification.md，明确 Goal、Users、Non-goals、Assumptions、Risks、Decisions、Open Questions、Acceptance Criteria。

AC2. 已生成 Good Question Brief，把模糊策略问题压缩成一个可验证的研究问题。

AC3. 已列出核心用户排序：Owner / AI Agent / 未来自动交易系统 / 未来普通用户。

AC4. 已明确当前阶段不做自动下单、不承诺收益、不直接进入 Codex 实现、不直接做正式回测结论。

AC5. 已列出 H1-H7 核心假设，并说明哪些假设需要反证样本和消融实验验证。

AC6. 已列出 F1-F8 失败模式，并说明何时模型必须降级为研究 / 观察 / 风险审计工具。

AC7. 已确认下一阶段路线：先研究库，再半自动标注器 / 观察器，最后回测原型。

AC8. 已更新项目索引与变更记录。

AC9. 已运行 python scripts/validate_all.py 并通过。

AC10. 在上述内容完成前，不进入 spec / issue / Codex / 自动交易实现。
```

---

## 11. Next Artifact

本文件完成后，下一步应生成或更新：

```text
specs/mql5-fcz-reclaim-model/good_question_brief.md
specs/mql5-fcz-reclaim-model/decisions.md
specs/mql5-fcz-reclaim-model/checklist.md
```

之后才能评估是否进入：

```text
spec.md
plan.md
tasks.md
issue draft
Codex handoff
```
