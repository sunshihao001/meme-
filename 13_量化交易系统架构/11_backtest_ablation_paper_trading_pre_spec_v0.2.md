# Backtest / ablation / paper-trading 前置规格 v0.2

> 分线：13_量化交易系统架构 / 回测消融与 paper 前置  
> 状态：v0.2 / C端 v0.2 深度理论第六切片落库  
> 上游入口：`13_量化交易系统架构/03_缺口清单与阶段门.md`、`13_量化交易系统架构/04_MVP闭环定义.md`、`13_量化交易系统架构/05_从研究库到交易系统的迁移路线.md`、`13_量化交易系统架构/09_样本反证与anti_hindsight_schema_v0.2.md`、`13_量化交易系统架构/10_reason_code_taxonomy_v0.2.md`  
> 边界：本文只定义回测、消融和 paper/quote-only 的前置规格；不接入 private key，不做 swap，不提交订单，不定义实盘仓位。

---

## 1. 本文要解决的问题

当前系统已经定义 observe-only MVP，但从 observe-only 到交易系统之间仍有巨大缺口：

```text
样本状态字段 ≠ 策略有效
策略有效 ≠ 可交易
可交易 ≠ 可自动执行
```

本文定义三个后续阶段的前置规格：

```text
1. Backtest reconstruction：历史数据如何重建，如何避免偏差。
2. Ablation：复合策略是否真的比简单规则有增益。
3. Paper / quote-only：不 swap，只验证报价、滑点、延迟、失败处理和审计。
```

---

## 2. 当前 gate 对应关系

来自 `03_缺口清单与阶段门.md`：

```text
Gate 5：回测与消融
Gate 6：Paper Trading / Quote-only Dry Run
Gate 7：Manual Approval Trading
Gate 8：Limited Auto Trading
Gate 9：Production Auto Trading
```

本文只覆盖 Gate 5 和 Gate 6 的前置规格。

禁止推进：

```text
Manual approval trading
Limited auto trading
Production auto trading
```

---

## 3. Backtest reconstruction spec

回测前必须先定义历史数据重建规则：

```text
backtest_case_id
sample_ids
chain
token_address
historical_data_refs
raw_snapshot_refs
reconstruction_window_start
reconstruction_window_end
data_cutoff_policy
kline_resolution
volume_unit_policy
missing_data_policy
source_priority_policy
schema_version
feature_set_version
rule_set_version
```

必须回答：

```text
1. 历史 kline 从哪里来？
2. 是否能拿到当时可见的 security / holder / liquidity 字段？
3. 如果只能拿到当前快照，哪些字段不能进入历史回测？
4. 如何避免 survivorship bias？
5. 如何避免只选择已经暴涨的 token？
6. 如何处理缺失和冲突数据？
```

---

## 4. Bias checklist

任何 backtest 之前必须检查：

```text
lookahead_bias
survivorship_bias
selection_bias
post_outcome_boundary_shift
post_outcome_poc_recalculation
future_liquidity_used
future_holder_distribution_used
winner_only_sample_set
manual_curated_only_success_cases
missing_failed_tokens
```

如果任一项为 true：

```text
1. backtest_result 不得用于策略有效性结论。
2. 只能作为 exploratory analysis。
3. 必须进入 missing / risk report。
```

---

## 5. Baseline strategies

复合 FCZ 策略必须至少与简单基准对比。

最低基准：

```text
BASELINE_POC_ONLY
  只看 POC reclaim。

BASELINE_AVWAP_ONLY
  只看 AVWAP reclaim。

BASELINE_SWEEP_ONLY
  只看 sweep + reclaim。

BASELINE_VOLUME_SPIKE_ONLY
  只看成交/amount 放大。

BASELINE_RISK_FILTER_ONLY
  只用风险过滤，不用结构。

BASELINE_RANDOM_WATCHLIST
  同等候选池内随机 watch。
```

Gate 5 通过条件仍是：

```text
复合策略必须优于至少 2 个简单基准，且扣除成本后仍有正期望，才可讨论交易候选阶段。
```

---

## 6. Ablation plan

每次 ablation 至少拆：

```text
FCZ range compression on/off
POC reclaim on/off
AVWAP reclaim on/off
deep wash threshold on/off
second launch watch on/off
risk filter on/off
holder concentration filter on/off
liquidity filter on/off
anti-hindsight lock on/off（仅用于证明 lock 重要，不可作为实盘策略）
```

输出字段：

```text
ablation_run_id
baseline_name
feature_set_version
rule_set_version
sample_set_id
included_sample_ids
excluded_sample_ids
metric_set
gross_result
cost_adjusted_result
failure_modes
false_positive_count
false_negative_count
manual_review_count
notes
```

---

## 7. Metrics

当前阶段不只看收益，必须同时看：

```text
false_positive_rate
false_negative_rate
manual_review_rate
risk_reject_precision
candidate_to_watch_ratio
watch_to_success_ratio
failure_after_valid_setup_count
missed_run_count
death_pool_misclassified_count
unexecutable_liquidity_count
avg_slippage_estimate
gas_or_fee_estimate
net_expectancy_R_after_cost
max_drawdown_simulated
sample_coverage
```

若没有成本模型：

```text
不能输出 net profitability 结论。
```

---

## 8. Cost and execution feasibility model

进入 Gate 6 前，至少要有：

```text
quote_source
quote_timestamp
expected_slippage
max_slippage_assumption
liquidity_depth_estimate
gas_or_fee_estimate
failed_transaction_assumption
latency_assumption
min_position_size_feasible
max_position_size_feasible_later
```

边界：

```text
这些字段只用于 feasibility，不生成 position_size。
```

---

## 9. Paper / quote-only dry run spec

Gate 6 只能做：

```text
quote request
quote response
latency measurement
slippage estimate
failure handling
paper ledger event
no-swap proof
```

最小 paper event：

```text
paper_event_id
sample_id_or_candidate_id
state_snapshot_ref
quote_request_ref
quote_response_ref
quote_timestamp
expected_entry_price
expected_exit_rule_description
no_swap_submitted = true
no_private_key_loaded = true
latency_ms
slippage_estimate
fee_estimate
failure_mode_if_any
review_note
```

禁止字段：

```text
private_key
signed_transaction
swap_tx_hash
real_position_size
actual_order_id
auto_take_profit
auto_stop_loss
```

---

## 10. Manual approval trading 之前的 Owner gate

如果未来要从 Gate 6 进入 Gate 7，必须先生成 Owner Decision Brief：

```text
Decision needed:
是否允许从 quote-only dry run 进入 manual approval trading？

Evidence required:
1. backtest / ablation report。
2. cost-adjusted feasibility report。
3. paper ledger no-swap proof。
4. risk and failure report。
5. security boundary plan。
6. rollback / kill switch plan。

Recommended default:
默认不进入，除非证据满足阶段门。
```

---

## 11. 本版结论

```text
回测、消融和 paper/quote-only 是 observe-only 之后、交易执行之前的必要隔离层。

没有可复核历史重建和反证样本，不能说策略有效。

没有成本、滑点、失败交易和安全边界，不能进入 manual approval trading。

当前阶段仍然禁止 swap、private key、自动下单和实盘仓位。
```
