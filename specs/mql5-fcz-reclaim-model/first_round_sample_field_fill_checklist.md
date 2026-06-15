# 首轮样本待填字段清单 v0.1

> 位置：`specs/mql5-fcz-reclaim-model/first_round_sample_field_fill_checklist.md`  
> 类型：补值清单 / 采样推进入口  
> 状态：v0.1

---

## 1. FCZ_C_0001（TIRED）剩余待填字段

### 1.1 基础信息

```text
chain_or_market
exchange_or_dex
sample_start_time
sample_end_time
source_chart_url
raw_data_path
screenshot_path
reviewer
review_date
```

### 1.2 结构字段

```text
first_control_zone_detected
fcz_high
fcz_low
fcz_mid
fcz_start_time
fcz_end_time
fcz_bars
fcz_volume_share
poc_level
vah_level
val_level
first_impulse_done
first_impulse_high
first_impulse_return
retracement_ratio
deep_washout_detected
sweep_detected
sweep_grade
sweep_reclaim_bars
value_area_reentered
poc_reclaimed
avwap_reclaimed
avwap_confluence_count
best_respected_avwap_anchor
pullback_holds_anchor
first_bounce_detected
second_push_confirmed
bos_after_reclaim
fvg_after_reclaim_detected
order_block_retest_holds
```

### 1.3 结果 / 审计字段

```text
entry_rule_triggered
triggered_group
entry_time
entry_price
stop_price
max_favorable_excursion_R
max_adverse_excursion_R
gross_realized_R
net_realized_R_after_cost
win_loss
failure_reason
final_classification
death_market_score
bull_trap_score
failed_reclaim_score
would_rule_have_triggered_ex_ante
was_boundary_moved_after_outcome
was_anchor_changed_after_outcome
is_failure_explained_by_new_rule
new_rule_needed
can_simpler_rule_explain_it
commercial_actionability_score
notes
```

---

## 2. FCZ_D_0001（WORLDCUP）剩余待填字段

### 2.1 基础信息

```text
chain_or_market
exchange_or_dex
sample_start_time
sample_end_time
source_chart_url
raw_data_path
screenshot_path
reviewer
review_date
```

### 2.2 结构字段

```text
first_control_zone_detected
fcz_high
fcz_low
fcz_mid
fcz_start_time
fcz_end_time
fcz_bars
fcz_volume_share
poc_level
vah_level
val_level
first_impulse_done
first_impulse_high
first_impulse_return
retracement_ratio
deep_washout_detected
sweep_detected
sweep_grade
sweep_reclaim_bars
value_area_reentered
poc_reclaimed
avwap_reclaimed
avwap_confluence_count
best_respected_avwap_anchor
pullback_holds_anchor
first_bounce_detected
second_push_confirmed
bos_after_reclaim
fvg_after_reclaim_detected
order_block_retest_holds
```

### 2.3 结果 / 审计字段

```text
entry_rule_triggered
triggered_group
entry_time
entry_price
stop_price
max_favorable_excursion_R
max_adverse_excursion_R
gross_realized_R
net_realized_R_after_cost
win_loss
failure_reason
final_classification
death_market_score
bull_trap_score
failed_reclaim_score
would_rule_have_triggered_ex_ante
was_boundary_moved_after_outcome
was_anchor_changed_after_outcome
is_failure_explained_by_new_rule
new_rule_needed
can_simpler_rule_explain_it
commercial_actionability_score
notes
```

---

## 3. FCZ_B_0001 仍待搜的缺口

```text
1. 需要一个真实“模型符合但失败”的候选 token。
2. 需要先有对应图表 / refs，再进样本记录。
3. 目标是填成半成品真实样本，而不是逻辑上猜出来的样本。
```

---

## 4. 首轮采样操作建议

优先顺序：

```text
1. 把 FCZ_C_0001 的基础信息与结构字段尽量补齐。
2. 把 FCZ_D_0001 的基础信息与风险字段尽量补齐。
3. 继续搜 FCZ_B_0001 的失败候选。
```
