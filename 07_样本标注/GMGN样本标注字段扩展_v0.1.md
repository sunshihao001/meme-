# GMGN 样本标注字段扩展 v0.1

> 位置：`07_样本标注/GMGN样本标注字段扩展_v0.1.md`  
> 分线：样本标注 / GMGN 数据源 / 反证审计 / 量化交易系统前置层  
> 状态：v0.1，字段扩展初版  
> 来源：`specs/mql5-fcz-reclaim-model/demand_theory_evolution_loop.md`、`full_meme_quant_trading_system_gap_brief.md`、`skill_runtime_solution_and_dbs_good_question_report.md`、GMGN skills 运行态验证、`gmgn_requirement_knowledge_base/09_指标与量化准备工作/01_GMGN指标字典.md`。  
> 本轮实际加载 skills：`dbs-good-question`、`dbs-goal`、`dbs-chatroom`、`dbs-slowisfast`、`dbs-decision`、`dbs-report`、`markdown-research-knowledge-bases`、`spec-first-ai-engineering`、`gmgn-market`、`gmgn-token`、`gmgn-portfolio`、`gmgn-track`。  
> 禁止边界：本文件不引入 `gmgn-swap`、`gmgn-cooking`、私钥、自动下单、自动止盈止损或交易执行。

---

## 1. 本文件目的

Owner 已明确终局目标：

```text
做成 meme 市场量化数据交易系统，使用 GMGN Skill / GMGN OpenAPI 作为主要数据源，使用当前第一控盘区成本中枢回收模型作为结构策略核心，最终支持自动筛选、自动交易、自动下单、自动止盈止损。
```

但当前阶段仍处在：

```text
GMGN 样本标注 MVP / 结构观察 / 反证审计 / 理论回填
```

所以本文件只解决一个问题：

```text
GMGN 样本标注 MVP 需要哪些最小字段，才能支持 FCZ 结构可标注、可反证、可重复观察，并为后续回测、风控、执行系统留下接口？
```

本文件不是：

```text
自动交易规格
下单规格
止盈止损规格
GMGN swap adapter 规格
完整回测系统规格
```

---

## 2. 字段设计原则

### 2.1 先只读，后评分，再执行

当前阶段只允许使用 GMGN 的只读能力：

```text
gmgn-market
gmgn-token
gmgn-portfolio
gmgn-track
```

暂不使用：

```text
gmgn-swap
gmgn-cooking
quote layer
swap
strategy create
自动下单
自动止盈止损
```

---

### 2.2 样本字段先服务可反证，不先服务交易

字段优先级：

```text
1. 能证明 FCZ 是否存在。
2. 能证明成本中枢是否可定义。
3. 能证明重新接受是否事前可见。
4. 能证明深洗 / 死亡盘 / 诱多能否区分。
5. 能记录 GMGN 数据来源、置信度、冲突和缺失。
6. 能为后续回测和执行成本层保留接口。
```

暂不优先：

```text
1. 自动买入。
2. 自动卖出。
3. 私钥签名。
4. 报价与滑点执行。
5. 实盘 PnL 优化。
```

---

### 2.3 GMGN 不是唯一真源

每条 GMGN 字段都必须保留：

```text
source_capabilities
raw_refs
fetched_at
confidence
conflict_flags
multisource_required
```

原因：

```text
GMGN 是核心数据源，但不是模型有效性的证明。
字段缺失、API 口径变化、钱包标签误判、榜单污染、KOL 噪声都可能误导策略。
```

---

## 3. GMGN 字段分层

本扩展把 GMGN 字段分成 9 层：

```text
L0 Provenance / 审计追溯字段
L1 Market Discovery / 市场发现字段
L2 Token Identity / Token 基础身份字段
L3 Security & Veto / 安全与硬拒绝字段
L4 Liquidity & Pool / 流动性与池子字段
L5 Holder & Trader Structure / 持仓与交易者结构字段
L6 Wallet / Smart Money / KOL 字段
L7 FCZ Derived Structure / FCZ 派生结构字段
L8 Sample Outcome / 反证与结果字段
L9 Future Execution Placeholder / 后续执行占位字段
```

---

## 4. L0：Provenance / 审计追溯字段

这些字段每个真实 GMGN 样本都必须有。

| 字段 | 类型 | 必填 | 来源能力 | 说明 |
|---|---|---|---|---|
| `gmgn_sample_id` | string | 是 | internal | GMGN 样本唯一 ID，例如 `GMGN_FCZ_000001` |
| `gmgn_chain` | enum | 是 | all | `sol` / `bsc` / `base` / `eth` |
| `gmgn_token_address` | string | 是 | all | Token 合约地址 |
| `gmgn_primary_pair_or_pool` | string | 否 | `token pool` | 主池地址 |
| `gmgn_raw_refs` | list/string | 是 | all | 原始查询结果路径、JSON 文件、命令记录或截图引用 |
| `gmgn_source_capabilities` | list | 是 | all | 使用过的能力，如 `market.trending`、`token.security`、`token.holders` |
| `gmgn_fetched_at` | datetime | 是 | all | 数据抓取时间 |
| `gmgn_data_window` | string | 否 | market/token/track | 数据窗口，如 `1m/5m/1h/24h/all` |
| `gmgn_api_version_or_cli_version` | string | 否 | cli | gmgn-cli 或 API 版本 |
| `gmgn_data_confidence_overall` | number | 是 | derived | 0-1 总体数据置信度 |
| `gmgn_conflict_flags` | list | 否 | derived | 数据冲突，如 `holder_count_conflict`、`liquidity_conflict` |
| `gmgn_multisource_required` | bool | 是 | derived | 是否需要外部补源 |
| `gmgn_notes` | string | 否 | reviewer | 标注说明 |

硬规则：

```text
没有 gmgn_raw_refs / gmgn_fetched_at / gmgn_source_capabilities 的真实样本，不允许进入反证样本库。
```

---

## 5. L1：Market Discovery / 市场发现字段

用于记录这个 token 为什么进入观察池。

| 字段 | 类型 | 必填 | 来源能力 | 说明 |
|---|---|---|---|---|
| `candidate_source` | enum/list | 是 | `gmgn-market` | `trending` / `trenches` / `signal` / `kline_scan` / `manual` |
| `candidate_discovery_time` | datetime | 是 | market | 第一次进入候选池时间 |
| `market_rank_at_discovery` | integer | 否 | trending/trenches | 发现时榜单排名 |
| `launchpad_stage` | enum | 否 | trenches/token info | `new_creation` / `near_completion` / `completed` / `migrated` / `unknown` |
| `market_volume_growth_1m` | number | 否 | trending/kline | 1m 成交量增速 |
| `market_volume_growth_5m` | number | 否 | trending/kline | 5m 成交量增速 |
| `buy_sell_ratio_5m` | number | 否 | trending/token info | 5m 买卖笔数比 |
| `net_buy_volume_usd_5m` | number | 否 | trending/traders | 5m 净买入额 |
| `holder_growth_rate_1h` | number | 否 | token info snapshots | 1h 持有人增长 |
| `marketcap_momentum_1h` | number | 否 | trending/kline | 1h 市值动量 |
| `signal_density_30m` | number | 否 | market signal | 30m 信号密度 |
| `market_discovery_confidence` | number | 是 | derived | 0-1，发现信号可信度 |

标注原则：

```text
Market discovery 只能说明“值得观察”，不能说明“可以买”。
```

---

## 6. L2：Token Identity / Token 基础身份字段

| 字段 | 类型 | 必填 | 来源能力 | 说明 |
|---|---|---|---|---|
| `token_symbol` | string | 是 | token info | Token 符号 |
| `token_name` | string | 否 | token info | Token 名称 |
| `token_creation_timestamp` | datetime | 否 | token info | 创建时间 |
| `token_open_timestamp` | datetime | 否 | token info / track | 开盘/交易开放时间 |
| `token_age_minutes_at_discovery` | number | 否 | derived | 发现时 token 年龄 |
| `token_launchpad` | string | 否 | token info / track | pump / moonshot 等 |
| `token_launchpad_status` | string/integer | 否 | token info | launchpad 状态 |
| `token_social_twitter` | string | 否 | token info | Twitter/X |
| `token_social_website` | string | 否 | token info | 官网 |
| `token_social_telegram` | string | 否 | token info | Telegram |
| `token_social_quality_flag` | enum | 否 | derived | `none` / `weak` / `normal` / `strong` / `suspicious` |

---

## 7. L3：Security & Veto / 安全与硬拒绝字段

这些字段决定样本是否进入：

```text
candidate / watch / reject / needs_manual_review
```

| 字段 | 类型 | 必填 | 来源能力 | 说明 |
|---|---|---|---|---|
| `security_veto_flags` | list | 是 | token security | 硬拒绝原因列表 |
| `is_honeypot` | bool/string | 条件必填 | token security | EVM 重点字段，SOL 可为空 |
| `open_source` | enum | 否 | token security | `yes/no/unknown` |
| `owner_renounced` | enum | 否 | token security | `yes/no/unknown` |
| `renounced_mint` | bool | 条件必填 | token security | SOL mint 权限是否放弃 |
| `renounced_freeze_account` | bool | 条件必填 | token security | SOL freeze 权限是否放弃 |
| `buy_tax` | number | 否 | token security | 买税 |
| `sell_tax` | number | 否 | token security | 卖税 |
| `rug_probability` | number | 是 | token security / trenches | rug 风险分数 |
| `is_wash_trading` | bool | 否 | token security | 是否疑似刷量 |
| `sniper_count` | integer | 否 | token security | 狙击钱包数 |
| `burn_status` | string | 否 | token security | LP burn/lock 状态 |
| `token_risk_score` | number | 是 | derived | 0-100，越高越危险 |
| `security_decision` | enum | 是 | derived | `pass` / `reject` / `needs_manual_review` |

硬拒绝建议：

```text
is_honeypot = yes
rug_probability > 0.30
top10_holder_rate > 0.50 且无解释
renounced_mint = false 且无法解释
renounced_freeze_account = false 且无法解释
sell_tax > 0.10
```

这些不是永久规则，只是 v0.1 标注门槛；后续必须用真实样本校准。

---

## 8. L4：Liquidity & Pool / 流动性与池子字段

| 字段 | 类型 | 必填 | 来源能力 | 说明 |
|---|---|---|---|---|
| `liquidity_usd` | number | 是 | token pool / token info | 主池流动性 USD |
| `pool_exchange` | string | 否 | token pool | DEX，如 Raydium / Pump AMM / Uniswap |
| `pool_creation_timestamp` | datetime | 否 | token pool | 池子创建时间 |
| `quote_symbol` | string | 否 | token pool | SOL / USDC / WETH 等 |
| `base_reserve_value_usd` | number | 否 | token pool | base reserve 美元价值 |
| `quote_reserve_value_usd` | number | 否 | token pool | quote reserve 美元价值 |
| `liquidity_growth_rate_1h` | number | 否 | pool snapshots | 1h 流动性增长率 |
| `liquidity_safety_score` | number | 是 | derived | 0-100，越高越安全 |
| `pool_depth_sufficient_for_sample` | bool | 是 | derived | 当前样本是否有可执行流动性 |
| `pool_risk_notes` | string | 否 | reviewer | 流动性风险说明 |

当前阶段不计算真实 quote price impact；只保留池深和可执行性判断。

---

## 9. L5：Holder & Trader Structure / 持仓与交易者结构字段

这些字段最接近“庄家结构”。

| 字段 | 类型 | 必填 | 来源能力 | 说明 |
|---|---|---|---|---|
| `holder_count` | integer | 是 | token info | 当前持有人数 |
| `top10_holder_rate` | number | 是 | token info/security/holders | Top10 持仓占比 |
| `dev_holding_rate` | number | 否 | token info/security/holders | dev/team 持仓占比 |
| `creator_hold_rate` | number | 否 | token info/security | 创建者持仓占比 |
| `suspected_insider_hold_rate` | number | 否 | token security/holders | 疑似 insider 持仓占比 |
| `insider_ratio` | number | 否 | token holders/traders | 老鼠仓 / 内部分发比例 |
| `sniper_ratio` | number | 否 | token holders/traders | sniper 占比 |
| `bundler_rate` | number | 否 | token info/security/holders | bundler bot 占比 |
| `rat_trader_rate` | number | 否 | token info/security/holders | rat trader 占比 |
| `fresh_wallet_rate` | number | 否 | token info/security | 新钱包占比 |
| `private_vault_hold_rate` | number | 否 | token info | vanish/private vault 占比 |
| `top10_holder_change_rate` | number | 否 | holders snapshots | Top10 持仓变化率 |
| `early_buyer_concentration` | number | 否 | holders/traders/activity | 早期买家当前持仓集中度 |
| `first70_current_holding_ratio` | number | 否 | holders/traders/external | 首 70 买家当前持有比例，若无法从 GMGN 直接得出则标记需补源 |
| `holder_structure_confidence` | number | 是 | derived | 0-1，持仓结构置信度 |

关键解释：

```text
early_buyer_concentration / first70_current_holding_ratio 是 FCZ 理论的核心桥梁字段。
它们不是 GMGN 单一接口的现成结论，通常需要 holders、traders、activity 快照和外部补源组合推导。
```

---

## 10. L6：Wallet / Smart Money / KOL 字段

这些字段用于观察资金质量，但不能直接等同于 edge。

| 字段 | 类型 | 必填 | 来源能力 | 说明 |
|---|---|---|---|---|
| `smart_wallets_count` | integer | 否 | token info / track smartmoney | 当前 smart money 钱包数 |
| `renowned_wallets_count` | integer | 否 | token info / track kol | KOL / renowned 钱包数 |
| `smart_money_buy_count_30m` | integer | 否 | track smartmoney | 30m smart money 买入数 |
| `smart_money_sell_count_30m` | integer | 否 | track smartmoney | 30m smart money 卖出数 |
| `kol_buy_count_30m` | integer | 否 | track kol | 30m KOL 买入数 |
| `kol_sell_count_30m` | integer | 否 | track kol | 30m KOL 卖出数 |
| `smart_money_cluster_buy_score` | number | 否 | track smartmoney | 同 token 短窗口聚合买入强度 |
| `smart_money_cluster_sell_score` | number | 否 | track smartmoney | 同 token 短窗口聚合卖出强度 |
| `kol_exit_liquidity_risk` | number | 否 | track kol / holders | KOL 进场后大户/聪明钱出货风险 |
| `wallet_quality_score` | number | 否 | portfolio stats | 参与钱包质量评分 |
| `dev_created_tokens_count` | integer | 否 | portfolio created-tokens | dev 历史发币数量 |
| `dev_success_ratio` | number | 否 | portfolio created-tokens | dev 历史毕业/ATH 达标比例 |
| `dev_split_wallet_pattern` | enum | 否 | portfolio/holders/external | `none` / `suspected` / `strong` / `unknown` |

硬规则：

```text
Smart Money / KOL 只作为辅助观察与风险提示，不作为当前版本的单独买入条件。
```

---

## 11. L7：FCZ Derived Structure / FCZ 派生结构字段

这些字段把 GMGN 数据接回当前第一控盘区成本中枢回收模型。

| 字段 | 类型 | 必填 | 来源能力 | 说明 |
|---|---|---|---|---|
| `gmgn_fcz_candidate_detected` | bool | 是 | derived | 是否从 GMGN 数据中发现 FCZ 候选 |
| `gmgn_fcz_start_time` | datetime | 否 | derived/kline | GMGN 视角 FCZ 起点 |
| `gmgn_fcz_end_time` | datetime | 否 | derived/kline | GMGN 视角 FCZ 终点 |
| `gmgn_fcz_high` | number | 否 | kline/derived | FCZ 上沿 |
| `gmgn_fcz_low` | number | 否 | kline/derived | FCZ 下沿 |
| `gmgn_fcz_width_pct` | number | 否 | derived | 区间宽度 |
| `gmgn_fcz_volume_share` | number | 否 | kline/derived | FCZ 成交量占比 |
| `gmgn_cost_center_method` | enum | 是 | derived | `POC` / `AVWAP` / `HVN` / `RangeMid` / `Mixed` / `Unknown` |
| `gmgn_cost_center_price` | number | 否 | derived | 成本中枢主价格 |
| `gmgn_cost_center_confidence` | number | 是 | derived | 0-1 成本中枢置信度 |
| `gmgn_deep_washout_detected` | bool | 是 | derived | 是否出现深洗 |
| `gmgn_sweep_detected` | bool | 是 | derived/kline | 是否出现 sweep |
| `gmgn_reclaim_detected` | bool | 是 | derived/kline | 是否重新接受成本区 |
| `gmgn_reclaim_time` | datetime | 否 | derived | 重新接受时间 |
| `gmgn_reclaim_ex_ante_visible` | bool | 是 | derived | 当时是否事前可见 |
| `gmgn_second_start_candidate` | bool | 是 | derived | 是否为二次启动候选 |
| `gmgn_bull_trap_warning` | bool | 是 | derived | 是否有诱多风险 |
| `gmgn_death_market_warning` | bool | 是 | derived | 是否有死亡盘风险 |
| `gmgn_structure_state_path` | string | 是 | derived | 状态路径，如 `GMGN_DISCOVERED>FCZ_CANDIDATE>RECLAIMED>WATCH` |
| `gmgn_structure_confidence` | number | 是 | derived | 0-1 结构置信度 |

注意：

```text
GMGN 派生 FCZ 字段不得覆盖原有样本字段，而是作为 GMGN 数据源视角的补充字段。
原有样本字段仍是策略知识库的主字段。
```

---

## 12. L8：Sample Outcome / 反证与结果字段

| 字段 | 类型 | 必填 | 来源能力 | 说明 |
|---|---|---|---|---|
| `gmgn_entry_rule_triggered` | bool | 是 | derived | GMGN 字段是否触发观察规则 |
| `gmgn_candidate_decision` | enum | 是 | derived | `candidate` / `watch` / `reject` / `needs_manual_review` |
| `gmgn_reject_reasons` | list | 否 | derived | 拒绝原因 |
| `gmgn_manual_review_reasons` | list | 否 | derived | 需要人工审查原因 |
| `gmgn_would_trigger_ex_ante` | bool | 是 | derived | 当时是否会触发，防止后视偏差 |
| `gmgn_rule_version` | string | 是 | internal | GMGN 字段规则版本 |
| `gmgn_boundary_moved_after_outcome` | bool | 是 | reviewer | 是否事后移动 FCZ 边界 |
| `gmgn_anchor_changed_after_outcome` | bool | 是 | reviewer | 是否事后换成本锚 |
| `gmgn_failure_explained_by_new_rule` | bool | 是 | reviewer | 失败后是否新增规则解释 |
| `gmgn_falsification_class` | enum | 否 | reviewer | `model_fail` / `data_fail` / `execution_fail` / `external_event` / `unclear` |
| `gmgn_outcome_max_favorable_R` | number | 否 | result | 最大有利浮盈 R |
| `gmgn_outcome_max_adverse_R` | number | 否 | result | 最大不利浮亏 R |
| `gmgn_outcome_after_24h` | enum | 否 | result | `up` / `down` / `sideways` / `rug` / `unknown` |
| `gmgn_outcome_notes` | string | 否 | reviewer | 结果备注 |

硬规则：

```text
只要 gmgn_would_trigger_ex_ante = true，后续失败必须作为失败样本保留，不能因为结果不好改成“不符合”。
```

---

## 13. L9：Future Execution Placeholder / 后续执行占位字段

这些字段只为终局系统预留，不在当前阶段计算或执行。

| 字段 | 类型 | 当前阶段 | 说明 |
|---|---|---|---|
| `future_quote_price_impact` | number | 禁用 | 后续 quote 层计算 |
| `future_expected_slippage_bps` | number | 禁用 | 后续执行成本层计算 |
| `future_order_failure_reason` | string | 禁用 | 后续执行失败分析 |
| `future_execution_latency_ms` | number | 禁用 | 后续执行质量评估 |
| `future_stop_loss_rule_id` | string | 禁用 | 后续止损规则 ID |
| `future_take_profit_rule_id` | string | 禁用 | 后续止盈规则 ID |
| `future_position_sizing_rule_id` | string | 禁用 | 后续仓位规则 ID |

当前阶段使用要求：

```text
这些字段可以出现在 schema 规划里，但真实样本中必须为空或 `disabled_current_stage`。
```

---

## 14. GMGN 样本最小必填字段集

第一批真实样本标注 MVP 只强制以下最小字段：

```text
gmgn_sample_id
gmgn_chain
gmgn_token_address
gmgn_raw_refs
gmgn_source_capabilities
gmgn_fetched_at
gmgn_data_confidence_overall
gmgn_multisource_required
candidate_source
candidate_discovery_time
token_symbol
token_creation_timestamp
token_age_minutes_at_discovery
security_veto_flags
rug_probability
token_risk_score
security_decision
liquidity_usd
liquidity_safety_score
pool_depth_sufficient_for_sample
holder_count
top10_holder_rate
holder_structure_confidence
gmgn_fcz_candidate_detected
gmgn_cost_center_method
gmgn_cost_center_confidence
gmgn_deep_washout_detected
gmgn_sweep_detected
gmgn_reclaim_detected
gmgn_reclaim_ex_ante_visible
gmgn_second_start_candidate
gmgn_bull_trap_warning
gmgn_death_market_warning
gmgn_structure_state_path
gmgn_structure_confidence
gmgn_candidate_decision
gmgn_would_trigger_ex_ante
gmgn_rule_version
gmgn_boundary_moved_after_outcome
gmgn_anchor_changed_after_outcome
gmgn_failure_explained_by_new_rule
```

最小字段数量：45 个左右，足够支持：

```text
候选发现
安全拒绝
结构观察
事前可见性
反证保留
后续回测接口
```

---

## 15. 当前阶段候选决策规则 v0.1

### 15.1 `reject`

满足任一：

```text
security_decision = reject
security_veto_flags 非空且包含 hard veto
gmgn_data_confidence_overall < 0.4
liquidity_usd 低于当前样本最小流动性门槛
gmgn_death_market_warning = true 且 gmgn_structure_confidence < 0.5
```

### 15.2 `needs_manual_review`

满足任一：

```text
gmgn_multisource_required = true
holder_structure_confidence < 0.6
gmgn_conflict_flags 非空
smart money 买入与 top holder / KOL 出货冲突
first70_current_holding_ratio 无法计算但 FCZ 判断高度依赖它
gmgn_reclaim_ex_ante_visible = unknown
```

### 15.3 `watch`

满足：

```text
无 hard veto
market discovery 有效
数据置信度可接受
但 FCZ / reclaim / second start 条件尚未形成
```

### 15.4 `candidate`

满足：

```text
无 hard veto
pool_depth_sufficient_for_sample = true
gmgn_fcz_candidate_detected = true
gmgn_cost_center_confidence >= 0.6
gmgn_reclaim_detected = true
gmgn_reclaim_ex_ante_visible = true
gmgn_structure_confidence >= 0.6
```

注意：

```text
candidate 不是 buy signal，只是进入样本重点观察。
```

---

## 16. 本轮多角色审查结论

### 16.1 量化研究员视角

本扩展的价值在于把 GMGN 从“看榜单、看聪明钱”降级为可审计字段源。真正重要的是 `gmgn_would_trigger_ex_ante`、`gmgn_boundary_moved_after_outcome`、`gmgn_anchor_changed_after_outcome`，因为它们阻止策略在失败后重写历史。

### 16.2 交易风控视角

当前不应该接入 swap。字段必须先能识别 hard veto、流动性不足、holder 集中、rug、KOL 出货、smart money 分歧。没有这些，自动交易只会加速亏损。

### 16.3 数据工程视角

每条字段都需要 source capability、raw ref、fetched_at、confidence。否则后续无法复现样本，也无法知道字段来自哪次 GMGN 查询。

### 16.4 Owner 决策视角

当前可自动落实：字段扩展、样本模板、最小必填集、候选决策规则。仍需 Owner 后续确认：第一批真实 token 样本来源、最小流动性门槛、是否允许使用外部补源。

---

## 17. 待决策问题

需要后续写入或同步到 `11_问题清单/待决策问题_v0.1.md`：

```text
1. 第一批 GMGN 真实样本选取范围：只做 Solana meme，还是同时包含 Base / BSC / ETH？
2. 第一批样本数量：20 个、50 个还是 100 个？
3. 最小流动性门槛是多少？例如 10k / 30k / 50k USD。
4. 是否允许使用 GMGN 外部补源来补 first70_current_holding_ratio？
5. `candidate` 是否只代表样本观察，还是后续 paper trading 阶段可升级为 paper signal？
6. 是否需要单独建立 `gmgn-fcz-sample-labeling-mvp` spec 目录？
```

---

## 18. 与现有文件的关系

本文件补充：

```text
07_样本标注/样本字段表_v0.1.md
07_样本标注/样本标注模板_v0.1.md
```

不替代：

```text
03_语义概念/第一控盘区定义_v0.1.md
04_风险管理/结构风险评分模型_v0.1.md
09_规则与回测/反证实验设计_v0.1.md
```

后续如果进入真实样本，应新建或更新：

```text
07_样本标注/GMGN真实样本采集执行清单_v0.1.md
07_样本标注/GMGN反证样本库_v0.1.csv
specs/gmgn-fcz-sample-labeling-mvp/clarification.md
```

---

## 19. 本轮结论

本轮理论回填结论：

```text
GMGN 样本标注 MVP 的第一任务，不是寻找买点，而是建立“可追溯、可反证、可重复观察”的数据结构。
```

因此当前应推进：

```text
GMGN 真实样本采集执行清单
GMGN 样本 CSV schema
第一批 20 个真实样本
```

而不是直接推进：

```text
自动下单
自动止盈止损
swap adapter
完整实盘交易系统
```
