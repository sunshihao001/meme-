# Full Meme Quant Trading System Gap Brief

> Feature / Project：mql5-fcz-reclaim-model  
> Stage：终局目标澄清 / Gap Analysis / Demand Grilling Brief  
> Status：v0.1，Owner 已明确最终目标  
> Source：`demand_grilling_brief.md`、`structural_observer_vs_quant_system_gate.md`、`资料吸收_GMGN作为meme市场数据源_v0.1.md`、GMGN MVP 知识库、Owner 最新确认  
> Purpose：明确最终目标是“meme 市场量化数据交易系统”，并把当前结构策略到完整自动交易系统之间缺少的层面写入需求控制面，防止当前阶段误跳到交易执行，同时保留长期终局方向。

---

## 1. Original Ask

Owner 最新明确：

```text
最终目标是做成 meme 市场量化数据交易系统，使用 gmgn-skill 作为数据源，以当前第一控盘区成本中枢回收模型作为结构策略，最终实现自动筛选条件、自动交易、自动下单、自动止盈止损。
```

Owner 同时要求：

```text
进行需求拷问澄清：距离完整的量化体系进行交易，还缺少哪些层面？
最终理论回填加入到需求文档里。
```

---

## 2. Improved Agent-Usable Question

```text
Given 当前项目已经确认短期仍是 GMGN-driven FCZ Structural Observer / Sample Labeling Framework / Risk Reviewer，且 GMGN 是 meme 市场优先数据源，

for Owner、AI Agent、未来 Codex worker、未来 checker / reviewer / risk gate，

clarify the gap between the current FCZ structural observer and the final target of a GMGN-powered meme-market quantitative trading system that can automatically screen tokens, generate strategy decisions, place orders, and manage take-profit / stop-loss,

while preserving the staged gate that current work must not jump directly into auto-trading until data, sample validation, falsification, ablation, backtesting, paper trading, execution risk, secrets/security, monitoring, and owner approval layers are complete.

Success means the project has a durable gap brief that lists missing layers, stage gates, forbidden shortcuts, owner decisions, and the next safe MVP: GMGN FCZ sample labeling / data foundation before trading execution.
```

---

## 3. Final Goal

最终目标：

```text
GMGN-powered meme-market quantitative data trading system
```

中文定义：

```text
以 GMGN Skill / GMGN OpenAPI 为核心数据源，以第一控盘区成本中枢回收模型作为结构策略核心，最终形成可自动筛选 meme token、自动生成候选交易决策、自动下单、自动止盈止损、可审计、可风控、可监控的量化交易系统。
```

终局能力包括：

```text
1. 自动发现候选 meme token。
2. 自动完成 token 尽调和风险过滤。
3. 自动计算 FCZ / 成本中枢 / 深洗 / 重新接受 / 二次启动结构字段。
4. 自动判断是否进入 candidate / watch / reject / no_trade。
5. 在满足完整风控和授权后，自动生成交易决策。
6. 自动下单。
7. 自动止盈止损。
8. 自动记录原始数据、特征、决策、订单、执行、失败原因和人工干预。
9. 能回测、纸上交易、实盘灰度、监控、回滚和复盘。
```

---

## 4. Current Reality

当前现实仍是：

```text
GMGN-driven FCZ Structural Observer
+ Sample Labeling Framework
+ Falsification Audit System
+ Risk Reviewer
```

当前还不是：

```text
完整量化交易系统
成熟自动交易策略
可实盘自动下单系统
稳定盈利模型
```

当前阶段的正确定位：

```text
最终目标可以是自动交易系统；
但当前阶段只能建设数据、样本、理论、反证、验证和观察器基础。
```

---

## 5. Missing Layers To Full Quant Trading System

### Layer 1：数据源与权限层

当前已有：

```text
GMGN Skill / GMGN OpenAPI 理论接入
GMGN market / token / portfolio / track / swap 能力认知
```

缺少：

```text
1. 当前项目专属 GMGN adapter 设计。
2. GMGN_API_KEY / GMGN_PRIVATE_KEY 权限分层策略。
3. 查询 key 与交易 key 隔离。
4. secrets 管理方案。
5. API rate limit、失败重试、缓存、熔断。
6. 数据源版本和响应 schema 追踪。
```

当前 gate：

```text
只允许查询侧理论设计，不允许交易 key / private key / swap 接入当前阶段。
```

---

### Layer 2：数据采集与原始数据层

缺少：

```text
1. Collector Layer：market / token / holders / traders / portfolio / track 查询任务。
2. Raw Layer：保存 GMGN 原始响应。
3. Snapshot Layer：保存 token / market / holders / wallet / tracking 快照。
4. fetch metadata：fetched_at、source_capability、request_hash、schema_version。
5. 数据缺失、接口失败、重复采集、时间窗口对齐处理。
```

必须先完成：

```text
GMGN raw refs + snapshot + provenance。
```

---

### Layer 3：数据质量与多源校验层

缺少：

```text
1. data_confidence_price。
2. data_confidence_liquidity。
3. data_confidence_security。
4. data_confidence_holder_structure。
5. GMGN 与 Dexscreener / Birdeye / GeckoTerminal / RPC / GoPlus / RugCheck 的冲突处理。
6. 安全字段冲突时取更保守结果。
7. 钱包标签冲突时保留多标签，不硬覆盖。
```

重要原则：

```text
GMGN 是优先数据源，不是唯一真源。
```

---

### Layer 4：样本标注与反证层

缺少：

```text
1. GMGN 样本标注字段扩展。
2. A/B/C/D/E/F 样本分类与 GMGN 字段绑定。
3. 成功样本、失败样本、错过大涨样本、死亡盘误判样本、不可执行样本。
4. 样本 provenance：is_real_sample、sample_source、gmgn_raw_refs。
5. 非发明者标注一致性。
6. 防止成功样本倒推 FCZ 边界。
```

这是当前第一优先级。

---

### Layer 5：结构策略形式化层

当前已有：

```text
第一控盘区
成本中枢
深洗
重新接受
二次启动
诱多 / 死亡盘
风险评分
```

缺少：

```text
1. 每个结构状态的可计算定义。
2. FCZ 事前边界规则。
3. POC / Value Area / AVWAP 优先级。
4. 深洗 vs 死亡盘硬边界。
5. 重新接受最低确认标准。
6. 二次启动确认规则。
7. no_trade / observe_only / candidate / second_start_candidate 的状态转移标准。
```

这些不能由 AI 自动最终确认，必须经过样本验证和 Owner 决策。

---

### Layer 6：特征工程层

缺少：

```text
1. GMGN market features。
2. token security features。
3. holder / trader structure features。
4. smart money / KOL / wallet behavior features。
5. FCZ structural features。
6. risk features。
7. execution feasibility features。
8. feature_set_version 管理。
```

示例：

```text
volume_growth_5m
buy_sell_ratio_5m
holder_growth_rate
top10_holder_change_rate
early_buyer_concentration
synchronized_buy_score
smart_money_buy_count_10m
liquidity_decay_rate
death_market_score
failed_reclaim_score
second_start_score
```

---

### Layer 7：信号与决策策略层

缺少：

```text
1. reject / watch / candidate / needs_manual_review / no_trade / can_trade 的明确定义。
2. 自动交易候选条件。
3. 禁止交易条件。
4. 风险 veto 条件。
5. 机会评分与风险评分的组合方式。
6. confidence score。
7. 决策 explainability：reason_codes。
```

当前允许：

```text
candidate / watch / reject / needs_manual_review
```

当前不允许：

```text
can_trade / auto_buy / auto_sell
```

---

### Layer 8：回测与消融验证层

缺少：

```text
1. GMGN 历史数据可用性确认。
2. 回测数据重建规则。
3. POC-only / AVWAP-only / Sweep-only 基准。
4. 复合策略消融实验。
5. 时间排序样本外验证。
6. walk-forward 验证。
7. 参数扰动稳定性。
8. survivorship bias / look-ahead bias 检查。
```

硬门槛：

```text
复合策略必须优于至少 2 个简单基准，才可进入候选量化策略阶段。
```

---

### Layer 9：交易成本与执行可行性层

缺少：

```text
1. slippage model。
2. gas / fee model。
3. liquidity impact model。
4. pool depth check。
5. max position size。
6. failed transaction handling。
7. partial fill / price moved / quote expired 处理。
8. MEV / sandwich / rug / liquidity removal 风险。
```

进入自动交易前必须证明：

```text
net_expectancy_R_after_cost > 0
```

---

### Layer 10：仓位、止盈止损与资金管理层

缺少：

```text
1. position sizing。
2. max risk per trade。
3. max daily loss。
4. max open positions。
5. stop-loss rule。
6. take-profit rule。
7. trailing stop / time stop。
8. emergency exit。
9. no-trade cooldown。
10. risk-of-ruin 评估。
```

这是自动交易核心，不得在当前样本标注阶段提前实现。

---

### Layer 11：执行系统层

缺少：

```text
1. GMGN quote / swap adapter。
2. order validation。
3. pre-trade risk check。
4. transaction signing。
5. private key / wallet custody。
6. order audit log。
7. cancel / retry / timeout。
8. post-trade reconciliation。
9. kill switch。
```

当前禁止：

```text
GMGN_PRIVATE_KEY
swap
multi-swap
strategy create
自动下单
```

---

### Layer 12：纸上交易与灰度实盘层

缺少：

```text
1. paper trading。
2. shadow mode。
3. quote-only dry run。
4. small-cap sandbox。
5. limited wallet exposure。
6. manual approval mode。
7. auto mode gradual unlock。
```

上线顺序必须是：

```text
样本标注
→ 回测
→ paper trading
→ quote-only dry run
→ manual approval trading
→ limited auto trading
→ production auto trading
```

---

### Layer 13：监控、审计与告警层

缺少：

```text
1. data pipeline health。
2. API failure alert。
3. strategy decision audit。
4. order execution audit。
5. PnL / drawdown monitor。
6. risk limit alert。
7. kill switch alert。
8. incident report。
```

---

### Layer 14：安全、权限与合规边界层

缺少：

```text
1. secrets vault。
2. least-privilege API keys。
3. trading wallet isolation。
4. max loss guard。
5. human approval gates。
6. audit retention。
7. disaster recovery。
```

任何涉及：

```text
private key
资金
实盘交易
自动执行
```

都必须 Owner 决策。

---

### Layer 15：工程化与质量门禁层

缺少：

```text
1. schema validators。
2. collector tests。
3. normalizer tests。
4. feature engine tests。
5. backtest reproducibility tests。
6. risk rule tests。
7. execution adapter tests。
8. CI。
9. code review。
10. release gate。
```

---

## 6. Stage Plan

### Stage 0：需求控制面与理论边界

状态：进行中。

目标：

```text
明确最终目标是完整 meme 量化交易系统，但当前阶段仍不能自动交易。
```

### Stage 1：GMGN 样本标注 MVP

目标：

```text
GMGN 数据 → FCZ 样本字段 → 可标注 / 可反证 / 可追溯。
```

输出：

```text
07_样本标注/GMGN样本标注字段扩展_v0.1.md
specs/gmgn-fcz-sample-labeling-mvp/clarification.md
```

### Stage 2：GMGN 数据仓库 / Collector / Normalizer Spec

目标：

```text
定义 raw / snapshot / feature schema，不实现交易。
```

### Stage 3：结构特征与风险评分

目标：

```text
把 FCZ 结构策略转成 feature + score + state machine。
```

### Stage 4：基准、反证、消融、回测

目标：

```text
证明复合策略是否优于简单基准，避免自嗨。
```

### Stage 5：Paper Trading / Quote-only Dry Run

目标：

```text
只验证报价、滑点、延迟、成本，不提交 swap。
```

### Stage 6：Manual Approval Trading

目标：

```text
AI 生成交易建议与订单草案，Owner 人工确认后执行。
```

### Stage 7：Limited Auto Trading

目标：

```text
小额度、限频、强风控、kill switch 自动交易。
```

### Stage 8：Production Auto Trading

目标：

```text
完整自动筛选、下单、止盈止损、监控、审计和回滚。
```

---

## 7. Immediate Next Step

尽管最终目标是自动交易系统，当前下一步仍然是：

```text
Stage 1：GMGN 样本标注 MVP
```

不是：

```text
自动下单
止盈止损实现
GMGN swap adapter
完整回测系统
```

原因：

```text
没有可标注、可反证、可追溯样本，就无法证明结构策略是否值得交易。
```

---

## 8. Owner Decisions Added

Owner 已确认：

```text
最终目标是 meme 市场量化数据交易系统。
数据源肯定是 GMGN Skill / GMGN OpenAPI。
结构策略核心是当前第一控盘区成本中枢回收模型。
终局包含自动筛选、自动交易、自动下单、自动止盈止损。
```

但当前仍需确认：

```text
1. Stage 1 首批 GMGN 查询能力范围。
2. 首批样本链：Solana / BSC / Base / Ethereum？
3. 首批样本数量。
4. 是否先只做 single-chain / single-domain。
5. GMGN 样本字段是否进入 CSV schema，还是先作为 Markdown sample record。
```

---

## 9. Updated Product Identity

更新后的身份不是否定长期自动交易，而是分阶段表达：

```text
Current Identity：GMGN-driven FCZ Structural Observer + Sample Labeling Framework + Risk Reviewer。
Final Identity：GMGN-powered meme-market quantitative trading system with automated screening, trading, order execution, take-profit and stop-loss。
```

关键原则：

```text
终局可以是完整自动交易系统；
当前阶段不能跳过数据、样本、反证、回测、成本、执行、安全和风控门槛。
```
