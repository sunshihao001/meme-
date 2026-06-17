# GMGN data-to-state mapper v0.2

> 分线：13_量化交易系统架构 / GMGN mapper  
> 状态：v0.2 / C端 v0.2 深度理论第三切片落库  
> 上游入口：`13_量化交易系统架构/06_C端v0.2深度理论落库总纲.md`、`13_量化交易系统架构/07_FCZ状态机专题_v0.2.md`  
> 关联旧真源：`09_规则与回测/GMGN数据源到FCZ状态机字段映射_v0.1.md`  
> 边界：本文只定义 GMGN 只读数据到 observe-only 状态机的映射；不调用交易 API，不接 API key/private key，不做 swap，不输出可执行订单。

---

## 1. 本文要解决的问题

C端 v0.2 深度理论已明确：GMGN 是 meme 市场主数据源候选，但 GMGN 字段不是事实本身，更不是买入信号。第三切片需要把 GMGN 只读数据如何进入 FCZ 状态机单独落库，作为后续样本 schema、counterexample、ablation、reason-code 和 validator 的输入层规范。

本文回答：

```text
1. GMGN 哪些数据族可进入状态机。
2. 每类数据只允许影响哪些状态或审计字段。
3. 哪些字段只能作为 context，不能直接触发 candidate。
4. missing / unknown / conflict 如何处理。
5. mapper 输出什么，不输出什么。
```

---

## 2. 总原则

```text
GMGN fields are observations, not truth.
GMGN signals are context, not buy signals.
Derived FCZ fields are versioned hypotheses.
Missing critical risk fields do not default safe.
Mapper outputs observe-only state inputs, not executable states.
```

中文原则：

```text
GMGN 字段只能作为观测证据；GMGN signal / smart money / trending 只能作为发现与上下文；FCZ 派生字段必须带 rule_version；关键风险字段缺失不能默认安全；mapper 不输出 can_trade / auto_buy / swap / order。
```

---

## 3. Mapper 输入数据族

当前 v0.2 只允许只读数据族：

```text
gmgn_discovery_snapshot
gmgn_kline_snapshot
gmgn_pool_snapshot
gmgn_security_snapshot
gmgn_holder_snapshot
gmgn_activity_snapshot
gmgn_signal_context_snapshot
gmgn_smart_money_context_snapshot
data_quality_report
risk_snapshot
manual_review_note
```

禁止输入：

```text
private_key
wallet_seed
wallet_custody
trading_api_key
swap_request
multi_swap_request
signed_transaction
order_instruction
position_size_instruction
take_profit_instruction
stop_loss_instruction
```

---

## 4. Mapper 输出对象

Mapper 只输出状态机可读的 observe-only 对象：

```text
mapper_run_id
chain
token_address
source_snapshot_refs
schema_version
mapper_version
rule_version
data_quality_flags
risk_flags
fcz_candidate_features
fcz_locked_features
washout_features
recovery_features
second_launch_watch_features
context_features
reason_code_candidates
state_transition_evidence
unknown_missing_fields
manual_review_required
```

禁止输出：

```text
can_trade
auto_buy
auto_sell
execute_swap
place_order
position_size
take_profit
stop_loss
```

---

## 5. 数据族到状态机的映射

### 5.1 Discovery 数据族

来源示例：

```text
GMGN trending
GMGN trenches
GMGN signal discovery
manual watchlist
external watch note
```

允许影响：

```text
S0_UNOBSERVED -> S1_DISCOVERED
context_features.discovery_source
reason_code_candidates.discovery_reason
```

禁止影响：

```text
不能直接进入 S4_FCZ_CANDIDATE
不能直接进入 S9_SECOND_LAUNCH_WATCH
不能生成 candidate / can_trade
```

规则：

```text
trending / trenches / signal 是发现入口，不是结构确认。
manual watchlist 是人工观察入口，不是人工买入建议。
```

---

### 5.2 K-line / OHLCV 数据族

字段示例：

```text
time
open
high
low
close
volume
amount
turnover
bar_count
interval
```

允许影响：

```text
S2_DATA_PENDING -> S3_DATA_READY
S3_DATA_READY -> S4_FCZ_CANDIDATE
S4_FCZ_CANDIDATE -> S5_FCZ_LOCKED
S5_FCZ_LOCKED -> S6_FIRST_IMPULSE_OBSERVED
S6_FIRST_IMPULSE_OBSERVED -> S7_DEEP_WASH_CANDIDATE
S7_DEEP_WASH_CANDIDATE -> S8_RECOVERY_CANDIDATE
S8_RECOVERY_CANDIDATE -> S9_SECOND_LAUNCH_WATCH
```

派生字段：

```text
fcz_candidate_window_start
fcz_candidate_window_end
fcz_high_candidate
fcz_low_candidate
fcz_mid_candidate
poc_candidate
vah_candidate
val_candidate
range_compression_score
volume_concentration_score
first_impulse_return
retracement_ratio
washout_low
poc_reclaimed
avwap_reclaimed
value_area_reentered
second_launch_watch_time
```

审计要求：

```text
kline_source_ref
interval
fetched_at
schema_version
profile_bin_count
calculation_rule_version
anti_hindsight_lock_inputs
```

边界：

```text
不能使用 outcome window 之后的 high/low 反推 FCZ。
不能使用 post-outcome POC 锁定早期 FCZ。
不能为了匹配成功样本移动 fcz_high / fcz_low。
```

---

### 5.3 Pool / Liquidity 数据族

字段示例：

```text
liquidity
pool_address
pair_address
base_token
quote_token
pool_created_at
price_usd
fdv / market_cap（如有）
```

允许影响：

```text
S2_DATA_PENDING -> S3_DATA_READY
S3_DATA_READY -> S10_RISK_REJECTED
S3_DATA_READY -> S11_NEEDS_MANUAL_REVIEW
risk_snapshot
execution_feasibility_note（仅后期纸上/quote-only，不是当前执行）
```

规则：

```text
liquidity too low -> risk flag / reject candidate
liquidity missing -> data_quality_flags + manual review
liquidity conflict across sources -> S11_NEEDS_MANUAL_REVIEW
```

边界：

```text
流动性足够不等于可以买。
price_usd 可用于估算观察字段，不生成订单。
```

---

### 5.4 Security / Risk 数据族

字段示例：

```text
rug_ratio
is_wash_trading
creator_token_status
creator_close
dev_team_hold_rate
top_10_holder_rate
rat_trader
bundler
honeypot / blacklist / mint / freeze（如 GMGN 或多源提供）
```

允许影响：

```text
任意 pre-output 状态 -> S10_RISK_REJECTED
任意 pre-output 状态 -> S11_NEEDS_MANUAL_REVIEW
risk_flags
risk_reason_codes
unknown_missing_fields
```

硬拒绝候选：

```text
confirmed rug / honeypot / blacklist risk
is_wash_trading = true 且无反证
creator / dev / holder concentration 超过未定阈值并缺少解释
关键 security 字段缺失但结构判断需要依赖该字段
```

边界：

```text
风险拒绝优先于结构漂亮。
缺失风险字段不能 default safe。
security field 不能用来生成 can_trade，只能 reject / warn / manual_review。
```

---

### 5.5 Holder 数据族

字段示例：

```text
holder_count
top_10_holder_rate
dev_team_hold_rate
renowned_count
smart_degen_count（如有）
holder_growth_rate（如可派生）
```

允许影响：

```text
risk_snapshot
context_features
S3_DATA_READY -> S10_RISK_REJECTED
S3_DATA_READY -> S11_NEEDS_MANUAL_REVIEW
reason_code_candidates.holder_context
```

边界：

```text
holder_count 增加不是买入信号。
renowned_count / smart_degen_count 只能作为 context。
top holder concentration 风险优先于结构形态。
```

---

### 5.6 Activity / Buy-Sell 数据族

字段示例：

```text
buy_count
sell_count
buy_volume
sell_volume
net_buy_amount
swap_count
unique_buyers
unique_sellers
large_trade_activity
```

允许影响：

```text
context_features.activity_context
volume_confirmation_features
recovery_features
second_launch_watch_features
risk_flags（wash trading / manipulation context）
```

边界：

```text
buy_count 增加不是 auto_buy。
net_buy 为正不是 can_trade。
large trade 只能作为 context 或 manual review trigger。
```

---

### 5.7 Signal / Smart Money / KOL Context 数据族

字段示例：

```text
signal tag
smart_degen
renowned_count
KOL / social context（如有）
trenches label
trending rank
```

允许影响：

```text
S0_UNOBSERVED -> S1_DISCOVERED
context_features
manual_review_priority
reason_code_candidates.context_reason
```

禁止影响：

```text
不能直接触发 S4_FCZ_CANDIDATE
不能直接触发 S9_SECOND_LAUNCH_WATCH
不能生成 candidate / can_trade / position_size
```

边界：

```text
KOL / smart money / signal 不是结构确认，更不是买入依据。
```

---

## 6. Data quality flags

Mapper 必须显式输出数据质量标记：

```text
schema_unknown
field_missing
field_null
field_type_mismatch
field_unit_unknown
timestamp_missing
snapshot_stale
source_conflict
insufficient_history
insufficient_bars
risk_field_missing
liquidity_field_missing
kline_gap
outcome_leakage_risk
```

处理规则：

```text
critical missing -> S11_NEEDS_MANUAL_REVIEW 或 S10_RISK_REJECTED
non-critical missing -> data_quality_flags + lower confidence
schema_unknown -> stop automatic classification, require manual review
source_conflict -> manual review unless conflict is explicitly resolvable
```

---

## 7. Reason-code candidates

Mapper 可生成 reason-code 候选，但不得生成交易指令：

```text
DISCOVERY_TRENDING
DISCOVERY_MANUAL_WATCH
DATA_READY_MINIMUM_SET
FCZ_RANGE_COMPRESSION
FCZ_VOLUME_CONCENTRATION
FCZ_POC_CANDIDATE
FCZ_LOCKED_ANTI_HINDSIGHT
IMPULSE_OBSERVED
DEEP_WASH_RETRACEMENT
SWEEP_AND_RECLAIM
POC_RECLAIMED
AVWAP_RECLAIMED
VALUE_AREA_REENTERED
SECOND_LAUNCH_WATCH_CONTEXT
RISK_RUG_RATIO_HIGH
RISK_WASH_TRADING
RISK_HOLDER_CONCENTRATION
RISK_LIQUIDITY_LOW
DATA_QUALITY_MISSING_CRITICAL_FIELD
MANUAL_REVIEW_SOURCE_CONFLICT
```

reason-code 规则：

```text
1. 每个 state transition 至少要有一个 reason-code 或 explicit unknown。
2. reason-code 必须能回溯 evidence_refs。
3. reason-code 不是交易原因，只是审计原因。
```

---

## 8. Anti-hindsight mapper 规则

为了保护样本真实性，mapper 必须支持：

```text
fcz_lock_timestamp
features_computed_at
data_cutoff_at
outcome_window_start
outcome_window_end
anti_hindsight_lock
was_boundary_moved_after_outcome
```

禁止：

```text
使用 outcome window 后的数据计算 FCZ 边界。
使用未来高低点确定 deep wash。
用 post-outcome POC 解释早期结构。
为了让样本成功而重算 fcz_high / fcz_low。
```

如果检测到后验风险：

```text
outcome_leakage_risk = true
manual_review_required = true
state_transition_blocked = true
```

---

## 9. Unknown / Missing registry

当前未定内容：

```text
GMGN live schema stability
GMGN endpoint rate limits
historical kline depth
字段单位：token volume / quote amount / USD amount
POC volume profile binning method
AVWAP anchor selection
liquidity freshness threshold
holder concentration hard reject threshold
wash trading field reliability
smart money / renowned_count 语义可靠性
multi-source conflict resolution priority
```

这些不得写成已验证结论。后续应由样本、反证、ablation、回测和 Owner decision register 逐步锁定。

---

## 10. Mapper 到状态机的最小伪接口

当前只是规格，不是实现：

```text
Input:
  gmgn read-only snapshots
  mapper_version
  rule_version
  data_cutoff_at

Process:
  normalize fields
  validate schema
  compute data_quality_flags
  compute context/risk/structure features
  generate reason-code candidates
  block forbidden outputs

Output:
  observe-only mapper object
  state_transition_evidence
  manual_review_required
```

禁止在该接口中出现：

```text
wallet
private_key
api_key
swap
order
position_size
take_profit
stop_loss
```

---

## 11. 本版结论

```text
GMGN data-to-state mapper v0.2 的职责是把 GMGN 只读观测数据转换为 FCZ observe-only 状态机可审计输入。

它不能把 GMGN 单字段升级成买入信号，不能把 context 升级成 candidate，不能把 candidate 升级成 can_trade，更不能输出 swap、order、仓位、止盈止损或任何实盘执行指令。
```

下一步建议：

```text
1. D端继续拆样本库 / counterexample / anti-hindsight schema。
2. 将 reason-code candidates 拆成独立 taxonomy。
3. 后续 validator 可检查 mapper 输出是否包含 forbidden fields。
```
