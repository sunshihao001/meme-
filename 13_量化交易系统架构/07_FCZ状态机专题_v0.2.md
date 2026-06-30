# FCZ 状态机专题 v0.2

> 分线：13_量化交易系统架构 / 策略状态机  
> 状态：v0.2 / C端 v0.2 深度理论第二切片落库  
> 上游入口：`13_量化交易系统架构/06_C端v0.2深度理论落库总纲.md`  
> 关联旧真源：`09_规则与回测/状态机规则整合_v0.1.md`、`09_规则与回测/GMGN数据源到FCZ状态机字段映射_v0.1.md`  
> 边界：本文只定义 observe-only / research-only 状态机，不定义自动下单、swap、止盈止损执行或仓位管理。

---

## 1. 本文要解决的问题

C端 v0.2 深度理论已经把 FCZ 状态机从 MQL5 观察器语境，推进到 GMGN 只读数据 + 自建 meme 市场脚本语境。第二切片需要把状态机单独落库，作为后续 mapper、样本库、counterexample、ablation、reason-code 与 validator 的共同依赖。

本文回答：

```text
1. FCZ 状态机在当前项目里是什么。
2. 状态机能输出什么、不能输出什么。
3. 每个状态的进入、退出、失效和审计字段是什么。
4. GMGN 数据何时只作为 evidence，而不是 truth。
5. 如何避免后验移动边界和把 candidate 误写成 can_trade。
```

---

## 2. 状态机不是交易信号

本文状态机不是：

```text
auto trading signal
GMGN swap trigger
private-key / wallet-custody workflow
position sizing engine
take-profit / stop-loss executor
profit promise
```

本文状态机是：

```text
observe-only structure mapper
sample labeling scaffold
falsification and ablation dependency
reason-code producer
manual review triage layer
future backtest input schema candidate
```

核心原则：

```text
FCZ state = hypothesis under evidence
GMGN field = observation / evidence candidate
score = triage value
sample outcome = validation source
Owner approval = later-stage gate, not current output
```

---

## 3. 状态集合 v0.2

当前 v0.2 状态集合采用 observe-only 命名，避免被误读为交易指令：

```text
S0_UNOBSERVED
S1_DISCOVERED
S2_DATA_PENDING
S3_DATA_READY
S4_FCZ_CANDIDATE
S5_FCZ_LOCKED
S6_FIRST_IMPULSE_OBSERVED
S7_DEEP_WASH_CANDIDATE
S8_RECOVERY_CANDIDATE
S9_SECOND_LAUNCH_WATCH
S10_RISK_REJECTED
S11_NEEDS_MANUAL_REVIEW
S12_ARCHIVED_NO_EDGE
S13_OBSERVE_ONLY_OUTPUT
```

禁止状态：

```text
CAN_TRADE
AUTO_BUY
AUTO_SELL
EXECUTE_SWAP
PLACE_ORDER
TAKE_PROFIT_ORDER
STOP_LOSS_ORDER
```

如果未来需要交易相关状态，必须通过 stage gates、Owner decision register、安全权限与人工确认层单独解锁，不能由本文状态机直接输出。

---

## 4. 全局转移规则

任何状态转移必须满足：

```text
1. transition_reason_code 非空。
2. evidence_refs 非空或标记 missing_evidence。
3. source_snapshot_id / request_hash / schema_version 可追溯。
4. state_entered_at 记录。
5. invalidation_rule 已定义或标记 unknown_missing。
6. 不允许使用 outcome window 之后的数据重写前序状态。
```

禁止跳转：

```text
S1_DISCOVERED -> S8_RECOVERY_CANDIDATE
S1_DISCOVERED -> S9_SECOND_LAUNCH_WATCH
S4_FCZ_CANDIDATE -> CAN_TRADE
S5_FCZ_LOCKED -> EXECUTE_SWAP
S9_SECOND_LAUNCH_WATCH -> AUTO_BUY
任何状态 -> private key / swap / order adapter
```

关键门禁：

```text
没有 S3_DATA_READY，不进入 S4_FCZ_CANDIDATE。
没有 S5_FCZ_LOCKED，不进入 S7_DEEP_WASH_CANDIDATE。
没有 S7_DEEP_WASH_CANDIDATE，不进入 S8_RECOVERY_CANDIDATE。
没有 S8_RECOVERY_CANDIDATE，不进入 S9_SECOND_LAUNCH_WATCH。
S9 也只能输出 watch / candidate / needs_manual_review，不能输出 can_trade。
```

---

## 5. 状态定义

### 5.1 S0_UNOBSERVED

含义：

```text
系统尚未发现或尚未接收 token 候选。
```

进入条件：

```text
默认初始状态。
```

可转移到：

```text
S1_DISCOVERED：token 被 GMGN trending / trenches / signal / watchlist / manual input 发现。
```

输出边界：

```text
no_output / observe_idle
```

---

### 5.2 S1_DISCOVERED

含义：

```text
token 已被发现，但还没有足够只读数据可用于 FCZ 结构判断。
```

允许 evidence：

```text
GMGN trending
GMGN trenches
GMGN signal
manual watchlist
external discovery note
```

转移到 `S2_DATA_PENDING`：

```text
已创建 data request 或 snapshot request，但数据尚未完整返回。
```

降级 / 归档：

```text
发现来源不可追溯、token address 不明确、chain 不明确 -> S12_ARCHIVED_NO_EDGE 或 S11_NEEDS_MANUAL_REVIEW。
```

边界：

```text
发现不等于候选。
trending / signal 不等于买点。
```

---

### 5.3 S2_DATA_PENDING

含义：

```text
正在等待 kline / pool / security / holder / signal 等只读数据补齐。
```

必要审计字段：

```text
request_id
source_command
request_hash
requested_at
data_family_requested
```

转移到：

```text
S3_DATA_READY：最低数据集齐备。
S11_NEEDS_MANUAL_REVIEW：关键字段缺失但仍值得人工判断。
S12_ARCHIVED_NO_EDGE：数据长期不可得或 token 不可复核。
```

边界：

```text
missing critical risk fields 不能 default safe。
```

---

### 5.4 S3_DATA_READY

含义：

```text
状态机已有足够只读数据，可以开始 FCZ 候选判断。
```

最低数据要求：

```text
chain
token_address
kline time / open / high / low / close / volume 或 amount
snapshot fetched_at
schema_version
basic liquidity / holder / risk fields 或 missing 标记
```

可转移到：

```text
S4_FCZ_CANDIDATE：满足早期区间候选条件。
S10_RISK_REJECTED：硬风险字段触发。
S11_NEEDS_MANUAL_REVIEW：数据冲突或缺失。
S12_ARCHIVED_NO_EDGE：无可研究结构。
```

---

### 5.5 S4_FCZ_CANDIDATE

含义：

```text
出现疑似第一控盘区，但尚未锁定。
```

候选 evidence：

```text
早期横盘窗口
kline range compression
volume / amount concentration
初步 POC / VAH / VAL
holder / liquidity 风险未硬拒绝
```

必要字段：

```text
fcz_candidate_window_start
fcz_candidate_window_end
fcz_high_candidate
fcz_low_candidate
fcz_bars
poc_candidate
profile_bin_count
candidate_rule_version
```

转移到 `S5_FCZ_LOCKED`：

```text
边界、POC、样本锁定时间和 rule_version 可事前固定。
```

失效：

```text
窗口过短、边界不可复现、成交量无聚集、后验移动风险过高 -> S12_ARCHIVED_NO_EDGE 或 S11_NEEDS_MANUAL_REVIEW。
```

---

### 5.6 S5_FCZ_LOCKED

含义：

```text
第一控盘区已锁定，后续状态不得移动 FCZ 边界解释结果。
```

必要字段：

```text
fcz_lock_timestamp
fcz_high
fcz_low
fcz_mid
poc_level
vah_level
val_level
fcz_snapshot_hash
rule_version
anti_hindsight_lock = true
was_boundary_moved_after_outcome = false
```

可转移到：

```text
S6_FIRST_IMPULSE_OBSERVED
S10_RISK_REJECTED
S11_NEEDS_MANUAL_REVIEW
S12_ARCHIVED_NO_EDGE
```

失效规则：

```text
后续为了匹配 outcome 移动 fcz_high / fcz_low / poc_level，应标记为 invalidated 或 manual_review，不得继续作为成功样本。
```

---

### 5.7 S6_FIRST_IMPULSE_OBSERVED

含义：

```text
FCZ 锁定后出现第一波离开成本区的结构表现。
```

候选字段：

```text
first_impulse_start_time
first_impulse_high
first_impulse_return
impulse_volume_expansion
impulse_duration_bars
```

转移到：

```text
S7_DEEP_WASH_CANDIDATE：出现深洗 / sweep / retracement。
S12_ARCHIVED_NO_EDGE：第一波失败后无可研究回收结构。
S10_RISK_REJECTED：风险字段恶化。
```

边界：

```text
第一波拉升只能证明可能存在结构，不证明可交易。
```

---

### 5.8 S7_DEEP_WASH_CANDIDATE

含义：

```text
第一波后出现深洗、扫流动性或回撤候选。
```

候选字段：

```text
washout_low
retracement_ratio
sweep_reference_level
sweep_detected
sweep_reclaim_bars
value_area_reentered
```

转移到：

```text
S8_RECOVERY_CANDIDATE：价格重新接受 POC / AVWAP / value area。
S10_RISK_REJECTED：深洗伴随硬风险或死亡盘风险。
S12_ARCHIVED_NO_EDGE：深洗后无回收。
S11_NEEDS_MANUAL_REVIEW：结构与风险冲突。
```

边界：

```text
深洗不是自动低吸理由。
跌深不是价值。
```

---

### 5.9 S8_RECOVERY_CANDIDATE

含义：

```text
深洗后出现成本锚或价值区重新接受的候选。
```

候选字段：

```text
poc_reclaimed
poc_above_bars
avwap_zonestart_reclaimed
avwap_above_bars
value_area_reentered
recovery_reason_codes
```

转移到：

```text
S9_SECOND_LAUNCH_WATCH：回收后出现二次启动观察条件。
S11_NEEDS_MANUAL_REVIEW：回收证据冲突。
S12_ARCHIVED_NO_EDGE：回收失败或再次跌破。
S10_RISK_REJECTED：风险硬拒绝。
```

边界：

```text
recovery_candidate 仍不是 can_trade。
```

---

### 5.10 S9_SECOND_LAUNCH_WATCH

含义：

```text
结构进入二次启动观察区，可进入人工复盘、样本记录或 paper/backtest 候选。
```

候选字段：

```text
second_launch_watch_time
pullback_holds_poc
pullback_holds_avwap
higher_low_after_recovery
volume_reexpansion
risk_score_snapshot
reason_codes
```

允许输出：

```text
watch
candidate
needs_manual_review
observe_only_output
```

禁止输出：

```text
can_trade
auto_buy
execute_swap
position_size
take_profit
stop_loss
```

---

### 5.11 S10_RISK_REJECTED

含义：

```text
风险字段触发硬拒绝或强降级。
```

候选风险：

```text
rug_ratio 高风险
is_wash_trading = true
top_10_holder_rate 过高
creator_close / creator_token_status 异常
dev_team_hold_rate 异常
rat_trader / bundler 高风险
liquidity 不足或冲突
critical risk fields missing
```

输出：

```text
reject
risk_rejected
manual_review_if_conflict
```

边界：

```text
风险拒绝优先于结构漂亮。
```

---

### 5.12 S11_NEEDS_MANUAL_REVIEW

含义：

```text
数据、结构、风险、样本或规则版本存在冲突，不能自动分类。
```

触发条件：

```text
关键字段缺失
GMGN 多源字段冲突
FCZ 边界可争议
risk 与 structure 结论冲突
schema_version 变化
规则版本迁移
```

输出：

```text
needs_manual_review
```

边界：

```text
manual review 不是人工买入建议，而是人工审计入口。
```

---

### 5.13 S12_ARCHIVED_NO_EDGE

含义：

```text
样本或 token 没有足够结构边际，进入归档或对照样本。
```

用途：

```text
negative sample
random/control sample
missed / no-edge sample
future ablation control
```

---

### 5.14 S13_OBSERVE_ONLY_OUTPUT

含义：

```text
状态机本轮只输出观察分类和审计字段。
```

允许输出：

```text
reject
watch
candidate
needs_manual_review
archive
```

必须同时输出：

```text
state_sequence
reason_codes
evidence_refs
risk_snapshot
data_quality_flags
rule_version
review_status
```

---

## 6. 审计字段最小集合

每次状态转移至少记录：

```text
sample_id 或 token_run_id
chain
token_address
previous_state
current_state
state_entered_at
transition_reason_code
evidence_refs
source_snapshot_id
request_hash
schema_version
rule_version
data_quality_flags
risk_flags
invalidation_rule
review_status
```

FCZ 锁定后额外记录：

```text
fcz_lock_timestamp
fcz_high
fcz_low
poc_level
vah_level
val_level
anti_hindsight_lock
was_boundary_moved_after_outcome
```

---

## 7. 与 GMGN mapper 的接口

状态机不直接调用 GMGN swap 或交易接口，只接受只读 mapper 产物：

```text
gmgn_kline_snapshot
gmgn_trending_snapshot
gmgn_trenches_snapshot
gmgn_signal_snapshot
gmgn_security_snapshot
data_quality_report
risk_snapshot
```

mapper 到状态机的原则：

```text
1. GMGN fields are observations, not truth.
2. smart_degen / renowned / signal 只能作 context，不直接触发 S9。
3. Missing risk fields 必须进入 data_quality_flags 或 S11。
4. Derived FCZ fields 必须带 rule_version。
5. Mapper 不输出 executable state。
```

---

## 8. 与样本库 / 反证 / ablation 的接口

状态机输出应能进入样本库：

```text
state_sequence
state_timestamps
reason_codes
evidence_refs
outcome_window_start
outcome_window_end
counterexample_type
anti_hindsight_lock
review_status
```

反证重点：

```text
1. S5_FCZ_LOCKED 后的边界是否被移动。
2. S7 深洗是否只是死亡盘下跌。
3. S8 recovery 是否只是假回收。
4. S9 watch 是否在 out-of-sample 中失效。
5. risk_rejected 是否过滤掉大量真机会或错放死亡盘。
```

ablation 重点：

```text
去掉 POC reclaim
去掉 AVWAP reclaim
去掉 holder / rug / wash-trading 风险字段
去掉 smart money context
去掉 anti-hindsight lock
调整 FCZ window / profile_bin_count / reclaim_bars
```

---

## 9. Unknown / Missing

当前仍未定稿：

```text
GMGN live schema 与字段稳定性
kline historical depth
rate limit 与 snapshot cadence
USD volume 与 token amount 在 POC/AVWAP 中的权重选择
risk hard reject 阈值
S4/S5 FCZ lock 最小 bars 与 volume concentration 阈值
S7 deep wash retracement 阈值
S8 recovery 连续 bars 阈值
S9 second launch watch 最小条件
```

这些不得被写成已验证结论，后续应由样本、反证、回测和 Owner decision register 逐步锁定。

---

## 10. 本版结论

```text
FCZ 状态机 v0.2 的职责是把 GMGN 只读数据和第一控盘区成本中枢回收理论连接成可审计、可标注、可反证的 observe-only 状态序列。

它最多输出 reject / watch / candidate / needs_manual_review / archive，不输出 can_trade、auto_buy、swap、仓位、止盈止损或任何实盘执行指令。
```

下一步建议：

```text
1. D端继续拆 GMGN data-to-state mapper v0.2。
2. 将本文状态集合映射到样本库字段与 reason-code taxonomy。
3. 后续 validator 可检查状态跳转合法性和 forbidden output。
```
