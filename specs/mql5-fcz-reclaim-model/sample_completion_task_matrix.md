# 样本任务清单与补全标准 v0.1

> 位置：`specs/mql5-fcz-reclaim-model/sample_completion_task_matrix.md`  
> 类型：任务清单 / 补全标准 / 一次性推进入口  
> 状态：v0.1

---

## 1. 这份表的用途

这份表的目标不是再发散新的规则，而是把当前所有需要补全的内容一次性列清楚：

```text
1. 哪些文件还没补完。
2. 每个文件还缺什么。
3. 每类字段补到什么程度算够。
4. 哪些字段必须是实值。
5. 哪些字段允许 unknown。
6. 哪些字段必须等证据补齐后再填。
```

这样后面就能直接按标准一次性推进，而不是边补边改。

---

## 2. 补全标准总则

### 2.1 三档标准

#### A 档：必须补成实值

这些字段一旦存在真实证据，就必须填实值，不能保留空白。

包括：

```text
sample_id
sample_class
sample_subclass
symbol
chain_or_market
exchange_or_dex
timeframe
sample_start_time
sample_end_time
sample_source
is_real_sample
source_chart_url
raw_data_path
reviewer
review_date
rule_version
candidate_source
candidate_token_symbol
candidate_token_address
gmgn_candidate_snapshot_source
gmgn_candidate_symbol
gmgn_candidate_address
gmgn_candidate_price
gmgn_candidate_price_change_1h
gmgn_candidate_liquidity_usd
gmgn_candidate_market_cap_usd
gmgn_candidate_holder_count
gmgn_candidate_top10_holder_rate
gmgn_candidate_smart_degen_count
gmgn_candidate_renowned_count
gmgn_candidate_bundler_rate
gmgn_candidate_is_wash_trading
gmgn_candidate_creator_token_status
gmgn_candidate_launchpad_platform
gmgn_candidate_exchange
gmgn_token_name
gmgn_token_logo
gmgn_open_timestamp
gmgn_creation_timestamp
gmgn_holder_count
gmgn_liquidity_usd
gmgn_circulating_supply
gmgn_total_supply
gmgn_max_supply
gmgn_market_price
gmgn_volume_1h_usd
gmgn_swaps_1h
gmgn_buys_1h
gmgn_sells_1h
gmgn_top10_holder_rate_security
gmgn_renounced_mint
gmgn_renounced_freeze_account
gmgn_burn_status
gmgn_buy_tax
gmgn_sell_tax
gmgn_creator_address
gmgn_creator_token_status
gmgn_creator_open_count
gmgn_creator_token_balance
gmgn_wallet_smart_wallets
gmgn_wallet_renowned_wallets
gmgn_wallet_sniper_wallets
gmgn_wallet_bundler_wallets
gmgn_wallet_fresh_wallets
gmgn_is_wash_trading
gmgn_cto_flag
gmgn_dexscr_update_link
gmgn_dexscr_boost_fee
```

#### B 档：允许 unknown，但必须有原因

这些字段当前没有足够结构证据，不应硬填。

包括：

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
would_rule_have_triggered_ex_ante
was_boundary_moved_after_outcome
was_anchor_changed_after_outcome
is_failure_explained_by_new_rule
new_rule_needed
can_simpler_rule_explain_it
commercial_actionability_score
```

#### C 档：证据不足，保持待搜

这些内容不是字段空白，而是**样本来源仍不充分**。

包括：

```text
FCZ_B_0001 的真实失败样本来源
FCZ_B_0001 的真实图表 / refs
更完整的结构边界证据
更完整的反证对照样本集
```

---

## 3. 当前样本任务总表

| 任务ID | 文件 | 当前状态 | 需要补到什么程度 | 补全标准 |
|---|---|---|---|---|
| T-001 | `07_样本标注/样本记录/FCZ_C_0001.md` | 当前标准已完成 | 已知 GMGN 事实、基础信息、风险初判、审计框架已补齐；结构字段以 unknown 收口，等待图表派生标注 | 只读事实齐全；结构字段按 unknown 记录；审计结论有初判 |
| T-002 | `07_样本标注/样本记录/FCZ_D_0001.md` | 当前标准已完成 | 已知 GMGN 事实、基础信息、风险初判、no_trade 初判、审计框架已补齐；结构字段以 unknown 收口 | 只读事实齐全；风险字段已定；no_trade 倾向明确 |
| T-003 | `07_样本标注/样本记录/FCZ_B_0001.md` | 待搜 | 找到真实“模型符合但失败”样本后再补 | 必须有真实图表 + GMGN refs + 事前可见证据 |
| T-004 | `07_样本标注/反证样本库_v0.1.csv` | 已同步 | CSV 已与 FCZ_C_0001 / FCZ_D_0001 当前样本记录同步；FCZ_B_0001 仍保持待搜 | 至少同步 sample_id、class、subclass、symbol、timeframe、rule_version、classification、risk、audit |
| T-005 | `07_样本标注/GMGN真实样本采集执行清单_v0.1.md` | 已有初版 | 只需后续根据样本修正，不再扩写 | 结构字段、步骤、审计规则保持稳定 |
| T-006 | `07_样本标注/GMGN反证样本库字段表_v0.1.md` | 已有初版 | 只需后续根据样本校准，不再扩写 | 字段不再泛增，进入清洗阶段 |
| T-007 | `specs/mql5-fcz-reclaim-model/first_round_sample_field_fill_checklist.md` | 已有初版 | 可以被任务执行入口直接消费 | 作为逐项补值清单 |
| T-008 | `specs/mql5-fcz-reclaim-model/gmgn_first_round_candidate_pool.md` | 已有初版 | 只需保留，不需要继续扩写 | 作为候选池快照 |

---

## 4. FCZ_C_0001 补全标准

### 必须完成到的程度

```text
1. 样本基础信息有实值。
2. GMGN 候选快照有实值。
3. GMGN 只读事实快照有实值。
4. raw refs 有实值路径。
5. 结构字段如果无法确定，统一写 unknown，并在备注解释。
6. 风险评分必须给出初判。
7. 审计结论必须给出初判。
```

### 当前允许 unknown

```text
fcz_high / fcz_low / fcz_mid / fcz_start_time / fcz_end_time / fcz_bars / fcz_volume_share
first_impulse_done 之后的结构字段
entry_rule_triggered 之后的交易触发字段
would_rule_have_triggered_ex_ante
```

### 当前必须实值

```text
sample_id
sample_class
sample_subclass
symbol
chain_or_market
exchange_or_dex
timeframe
sample_start_time
sample_end_time
sample_source
is_real_sample
source_chart_url
raw_data_path
candidate_source
candidate_token_symbol
candidate_token_address
gmgn_candidate_snapshot_source
gmgn_candidate_symbol
gmgn_candidate_address
gmgn_candidate_price
gmgn_candidate_price_change_1h
gmgn_candidate_liquidity_usd
gmgn_candidate_market_cap_usd
gmgn_candidate_holder_count
gmgn_candidate_top10_holder_rate
gmgn_candidate_smart_degen_count
gmgn_candidate_renowned_count
gmgn_candidate_bundler_rate
gmgn_candidate_is_wash_trading
gmgn_candidate_creator_token_status
gmgn_candidate_launchpad_platform
gmgn_candidate_exchange
gmgn_token_name
gmgn_token_logo
gmgn_open_timestamp
gmgn_creation_timestamp
gmgn_holder_count
gmgn_liquidity_usd
gmgn_market_price
gmgn_volume_1h_usd
gmgn_swaps_1h
gmgn_buys_1h
gmgn_sells_1h
gmgn_top10_holder_rate_security
gmgn_renounced_mint
gmgn_renounced_freeze_account
gmgn_burn_status
gmgn_buy_tax
gmgn_sell_tax
gmgn_creator_address
gmgn_creator_token_status
gmgn_creator_open_count
gmgn_creator_token_balance
gmgn_wallet_smart_wallets
gmgn_wallet_renowned_wallets
gmgn_wallet_sniper_wallets
gmgn_wallet_bundler_wallets
gmgn_wallet_fresh_wallets
gmgn_is_wash_trading
gmgn_cto_flag
gmgn_dexscr_update_link
gmgn_dexscr_boost_fee
```

---

## 5. FCZ_D_0001 补全标准

### 必须完成到的程度

```text
1. 样本基础信息有实值。
2. GMGN 候选快照有实值。
3. GMGN 只读事实快照有实值。
4. 原始 refs 路径完整。
5. 风险字段给出 no_trade 倾向。
6. 审计结论给出 no_trade / death-market 倾向。
```

### 当前允许 unknown

```text
fcz_* 结构字段
first_impulse_* 结构字段
value_area_reentered / poc_reclaimed / avwap_reclaimed
entry_rule_triggered 之后所有交易字段
would_rule_have_triggered_ex_ante
```

### 当前必须实值

```text
sample_id
sample_class
sample_subclass
symbol
chain_or_market
exchange_or_dex
timeframe
sample_start_time
sample_end_time
sample_source
is_real_sample
source_chart_url
raw_data_path
candidate_source
candidate_token_symbol
candidate_token_address
gmgn_candidate_snapshot_source
gmgn_candidate_symbol
gmgn_candidate_address
gmgn_candidate_price
gmgn_candidate_price_change_1h
gmgn_candidate_liquidity_usd
gmgn_candidate_market_cap_usd
gmgn_candidate_holder_count
gmgn_candidate_top10_holder_rate
gmgn_candidate_smart_degen_count
gmgn_candidate_renowned_count
gmgn_candidate_bundler_rate
gmgn_candidate_is_wash_trading
gmgn_candidate_creator_token_status
gmgn_candidate_launchpad_platform
gmgn_candidate_exchange
gmgn_token_name
gmgn_token_logo
gmgn_open_timestamp
gmgn_creation_timestamp
gmgn_holder_count
gmgn_liquidity_usd
gmgn_market_price
gmgn_volume_1h_usd
gmgn_swaps_1h
gmgn_buys_1h
gmgn_sells_1h
gmgn_top10_holder_rate_security
gmgn_renounced_mint
gmgn_renounced_freeze_account
gmgn_burn_status
gmgn_buy_tax
gmgn_sell_tax
gmgn_creator_address
gmgn_creator_token_status
gmgn_creator_open_count
gmgn_creator_token_balance
gmgn_wallet_smart_wallets
gmgn_wallet_renowned_wallets
gmgn_wallet_sniper_wallets
gmgn_wallet_bundler_wallets
gmgn_wallet_fresh_wallets
gmgn_is_wash_trading
gmgn_cto_flag
gmgn_dexscr_update_link
gmgn_dexscr_boost_fee
```

---

## 6. 一次性补全推进策略

要一次性推进，不要一点点推进，建议按这个顺序：

```text
1. 先补所有能由 GMGN 只读事实直接确定的字段。
2. 再把不能由现有证据确定的字段统一写 unknown。
3. 再补审计初判。
4. 最后同步 CSV。
5. 如果 FCZ_B_0001 仍无真实失败样本，就保持待搜。
```

这意味着：

```text
不能为了“看起来更完整”而瞎填结构字段。
但也不能让 pending 长期悬空。
统一用 unknown 收口，是当前最稳的补全方式。
```

---

## 7. 建议的任务执行顺序

1. 先完成 `FCZ_C_0001.md`
2. 再完成 `FCZ_D_0001.md`
3. 再同步 `反证样本库_v0.1.csv`
4. 再检查 `FCZ_B_0001` 是否能找到真实失败样本
5. 最后输出首轮审计摘要

---

## 8. 本版结论

```text
这份任务矩阵把“补什么、补到什么程度、哪些允许 unknown、哪些必须有实值”全部收口了。
后续可以直接按这个标准做一次性补全，而不再边补边改。
```
