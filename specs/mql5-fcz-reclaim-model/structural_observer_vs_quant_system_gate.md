# Structural Observer vs Full Quant System Gate

> Feature / Project：mql5-fcz-reclaim-model  
> Stage：需求拷问控制门 / 成熟度升级门  
> Status：v0.1，Owner 已确认默认判断  
> Source：`demand_grilling_brief.md`、`demand_control_loop.md`、`01_策略定义/策略成熟度定位与商业角色_v0.1.md`、`09_规则与回测/策略成熟度质疑审计与商业诊断_v0.1.md`、`06_资料吸收/资料吸收_GMGN作为meme市场数据源_v0.1.md`  
> Purpose：结合最新 AI 方法轮，把“GMGN 加入后，当前项目到底仍是结构性观察策略，还是已经能升级为完整量化体系”的需求拷问固化为控制门。

---

## 1. Original Ask

Owner 认为当前需求拷问方向是对的，但需要结合最新 AI 方法轮进一步升级，并特别强调：

```text
之前不是说这个只能被称为结构策略吗？
不算完整的量化体系。
现在 GMGN 作为 meme 市场数据源加入后，需要从之前知识库重新思考。
```

本文件回答：

```text
GMGN 加入后，项目当前仍应定位为什么？
是否可以叫完整量化体系？
如果不可以，缺哪些证据门？
下一轮需求拷问应从哪个方向进行？
```

---

## 2. Improved Agent-Usable Question

```text
Given 当前项目已经具备第一控盘区结构定义、POC/AVWAP 成本锚、深洗/死亡盘、重新接受、二次启动、风险评分、样本标注模板、反证实验设计、Demand Grilling Brief、Demand Control Loop，并新增 GMGN 作为 meme 市场优先研究数据源，

for Owner、AI Agent、后续 Codex worker、checker / reviewer，

decide whether the project is still only a GMGN-driven FCZ structural observer / sample labeling framework / risk auditor, or whether it has enough evidence to be treated as a full quantitative trading system,

while preserving the constraints that GMGN is a data source but not a proof of edge, GMGN execution capabilities are out of scope, and current strategy maturity documents explicitly rate automatic trading maturity as low.

Success means the project has a clear maturity gate: what it is now, what it is not, what evidence is missing, what must be completed before upgrading from structural observer to candidate quant strategy, and what the next MVP should be.

Verify by checking this gate is written, indexed, logged, and `python scripts/validate_all.py` passes.
```

---

## 3. Current Maturity Snapshot

From `01_策略定义/策略成熟度定位与商业角色_v0.1.md`：

```text
当前策略不是成熟自动交易系统，而是：
围绕 meme 早期第一控盘区、深洗、成本锚重新接受与二次启动确认的结构性观察模型。
```

商业化定位：

```text
meme 早期结构候选筛选器
+ 反证样本标注框架
+ 风险审查器
```

成熟度：

```text
研究成熟度：中高
规则成熟度：中
样本验证成熟度：低
反证审计成熟度：中
商业定位成熟度：中
自动交易成熟度：低
观察器产品化成熟度：中高
```

当前评级：

```text
B-：值得验证，但不能宣称成熟。
```

---

## 4. Decision: Current Product Identity

### 4.1 Current Identity

GMGN 加入后，当前项目仍应定位为：

```text
GMGN-driven FCZ Structural Observer
+ Sample Labeling Framework
+ Falsification Audit System
+ Risk Reviewer
+ Observer / data-source requirement layer
```

中文：

```text
GMGN 驱动的第一控盘区结构观察器
+ 样本标注框架
+ 反证审计器
+ 风险审查器
+ 后续观察器 / 数据仓库 / 回测原型的需求源
```

### 4.2 Not Yet

当前不能称为：

```text
完整量化体系
成熟自动交易策略
可直接部署交易系统
可直接对外销售的交易信号产品
稳定盈利模型
```

### 4.3 Why GMGN Does Not Automatically Upgrade It

GMGN 补强的是：

```text
数据源层
候选标的发现层
链上结构字段层
样本标注字段层
风控和钱包画像输入层
```

GMGN 没有自动补齐：

```text
稳定策略规则
正期望证明
样本外验证
交易成本后净期望
执行风控
自动下单授权
```

因此：

```text
GMGN 是更好的数据源，不是策略成熟证明。
```

---

## 5. What A Full Quant System Would Require

完整量化体系至少需要以下层：

```text
1. 数据源与数据质量层
2. 数据清洗与补源层
3. 特征工程层
4. 信号生成规则层
5. 入场 / 出场 / 止损 / 仓位规则层
6. 交易成本 / 滑点 / 冲击成本模型
7. 回测框架
8. 基准策略对照
9. 消融实验
10. 样本外 / walk-forward 验证
11. 风险控制与熔断
12. 执行系统与审计日志
13. Maker / checker / owner decision loop
```

当前已有：

```text
1. 初步数据源：GMGN
2. 结构概念：FCZ、成本中枢、深洗、重新接受、二次启动
3. 样本标注框架
4. 反证实验设计
5. 状态机校验器
6. validate_all 质量门禁
7. Demand Grilling Brief / Demand Control Loop
```

当前缺少：

```text
1. GMGN 真实样本采集流程
2. GMGN 字段进入样本 schema 的正式版本
3. 真实 A/B/C/D/E/F 样本库
4. 简单基准对照结果
5. 消融实验结果
6. 样本外验证
7. 成本 / 滑点 / 流动性冲击验证
8. 入场 / 出场 / 仓位完整规则
9. 自动执行风控
10. 非发明者标注一致性验证
```

结论：

```text
当前只能称为结构性观察策略 / 结构研究框架。
不能称为完整量化体系。
```

---

## 6. Demand Grilling Lenses For Next Stage

下一轮需求拷问不应从“写功能”开始，而应从“资格审查”开始。

### Lens 1：成熟度定位拷问

```text
GMGN 加入后，当前项目是否仍是结构性观察策略？
是否允许称为量化体系？
如果不允许，缺哪些层？
```

Recommended default：

```text
仍是结构性观察策略，不是完整量化体系。
```

### Lens 2：GMGN 能力边界拷问

```text
GMGN 哪些能力用于研究？
哪些用于样本标注？
哪些用于风控？
哪些必须多源校验？
哪些禁止进入当前阶段？
```

Recommended default：

```text
查询侧能力进入研究和标注；执行侧能力当前禁止。
```

### Lens 3：数据到结构映射拷问

```text
GMGN market / token / holders / traders / track 数据，如何映射到 FCZ、深洗、重新接受、二次启动、死亡盘？
哪些字段只是辅助，哪些字段可以成为核心标注字段？
```

Recommended default：

```text
先做字段映射和样本标注，不直接做信号规则。
```

### Lens 4：验证门槛拷问

```text
哪些样本、基准、消融和成本验证完成后，才允许从观察器升级为候选量化策略？
```

Recommended default：

```text
必须通过 80 样本反证库、简单基准对照、消融实验、成本后正期望、样本外验证和标注一致性。
```

### Lens 5：MVP 拷问

```text
第一阶段到底做 GMGN 样本标注 MVP，还是 GMGN 回测 MVP？
```

Recommended default：

```text
先做 GMGN 样本标注 MVP，不直接做回测 MVP。
```

---

## 7. Upgrade Gates

只有满足以下条件，才允许从结构观察器升级为候选量化策略：

```text
Gate 1：第一控盘区边界和 AVWAP / POC 锚点可事前确定。
Gate 2：真实样本库 ≥ 80，包括 A/B/C/D/E/F 类，不只成功样本。
Gate 3：复合策略优于至少 2 个简单基准，例如 POC-only、AVWAP-only、Sweep-only。
Gate 4：消融实验显示核心条件确实贡献边际收益。
Gate 5：net_expectancy_R_after_cost > 0。
Gate 6：样本外或 walk-forward 验证仍稳定。
Gate 7：参数小幅扰动不崩溃。
Gate 8：非发明者标注一致率达到最低标准。
Gate 9：GMGN 关键安全、价格、流动性、钱包标签字段完成多源校验。
Gate 10：执行可行性通过滑点、池深、gas、冲击成本验证。
```

任何 Gate 未满足时，项目只能保持：

```text
观察器 / 样本框架 / 风险审查器 / 研究模型
```

---

## 8. MVP Recommendation

下一阶段推荐 MVP：

```text
GMGN-driven FCZ Sample Labeling MVP
```

不是：

```text
GMGN Backtest MVP
GMGN Auto-trading MVP
```

MVP 流程：

```text
GMGN 数据源
→ 候选 meme token 池
→ kline / holders / traders / security / pool / smartmoney 快照
→ FCZ 结构字段
→ A/B/C/D/E/F 样本标注
→ 反证审计
→ 导出观察器 / 回测准备数据
```

MVP 目标：

```text
验证 GMGN 数据是否足以支持第一控盘区结构的可标注、可反证、可重复观察。
```

MVP 非目标：

```text
不输出买卖信号。
不自动下单。
不宣称策略有效。
不做完整收益回测。
```

---

## 9. Agent Execution Classification

Classification：

```text
Needs-owner for maturity upgrade and strategy/quant-system identity.
Autonomous for documentation consolidation, GMGN field mapping draft, sample schema draft, and validation commands.
Not Codex-ready for trading logic.
```

Maker：

```text
Hermes / documentation agent for control-plane and schema/spec drafting.
```

Checker：

```text
Owner + validate_all.py + future sample schema validator + reviewer / risk auditor.
```

Authority Boundary：

```text
Agent may draft GMGN sample labeling MVP spec.
Agent may draft schema extension.
Agent may update docs/index/changelog.
Agent may not authorize GMGN execution functions.
Agent may not define final trading rules.
Agent may not start Codex implementation of trading system.
```

---

## 10. False-Success Traps

必须防止：

```text
1. 把 GMGN trending 当成 edge。
2. 把 smartmoney 标签当成真聪明钱证明。
3. 把 signal_density 当成买点。
4. 把 GMGN 安全结果当成无需补源的真源。
5. 把结构图形成立当成可执行交易。
6. 用成功样本反推 FCZ 边界。
7. 用 mock / simulated sample 宣称策略有效。
8. 用回测前定义不稳定的规则跑出伪精确结果。
```

---

## 11. Missing Questions

当前最高价值问题：

```text
1. 是否确认：GMGN 加入后，当前项目仍定位为 GMGN 驱动的 FCZ 结构观察器 / 样本标注框架 / 风险审查器，暂不升级为完整量化体系？
2. 是否确认下一阶段优先做 GMGN 样本标注 MVP，而不是回测 MVP？
3. 首批 GMGN 查询能力范围是否采用 market.kline + market.trending + market.trenches + token.security + token.holders + token.traders + track.smartmoney？
```

Recommended default：

```text
确认 1 和 2；第三项作为 P1 决策进入 sample labeling MVP spec。
```

---

## 12. Next Stage

如果 Owner 确认本文件，则下一阶段应进入：

```text
GMGN Sample Labeling MVP Demand Grilling Brief / Spec
```

而不是：

```text
Backtest MVP
Codex trading implementation
Auto-trading system
```

推荐下一文件：

```text
specs/gmgn-fcz-sample-labeling-mvp/spec.md
```

或先建立：

```text
specs/gmgn-fcz-sample-labeling-mvp/clarification.md
```

---

## 13. Current Recommended Owner Answer

```text
确认：GMGN 加入后，当前项目仍然只定位为 GMGN 驱动的第一控盘区结构观察器 / 样本标注框架 / 风险审查器，暂不升级为完整量化体系。

下一步先做 GMGN 样本标注 MVP，不做回测 MVP，不做自动交易。
```
