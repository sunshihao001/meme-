# Reason-code taxonomy v0.2

> 分线：13_量化交易系统架构 / reason-code  
> 状态：v0.2 / C端 v0.2 深度理论第五切片落库  
> 上游入口：`13_量化交易系统架构/07_FCZ状态机专题_v0.2.md`、`13_量化交易系统架构/08_GMGN_data_to_state_mapper_v0.2.md`、`13_量化交易系统架构/09_样本反证与anti_hindsight_schema_v0.2.md`  
> 边界：reason-code 只解释观察状态和审计原因，不是买入理由、卖出理由、仓位理由或自动交易理由。

---

## 1. 本文要解决的问题

状态机和 mapper 已经列出 reason-code candidates，但如果不单独定义 taxonomy，后续样本、validator、回测、人工复盘会出现：

```text
1. 同一原因多个名字。
2. 买入理由和观察理由混写。
3. 风险拒绝与结构确认混写。
4. 缺失字段被忽略。
5. reason-code 无法追溯 evidence_refs。
```

本文把 reason-code 固化为可审计分类。

---

## 2. 总原则

```text
reason-code = why the observe-only system changed state or assigned a review label.
```

它不是：

```text
trade_reason
buy_reason
sell_reason
position_reason
profit_reason
```

硬规则：

```text
1. 每个 reason-code 必须属于一个 category。
2. 每个 reason-code 必须绑定 evidence_refs 或 explicit missing_evidence。
3. reason-code 可以提高人工复盘优先级，但不能输出 can_trade。
4. risk / data quality reason 优先级高于 structure reason。
5. context reason 不能直接升级为 candidate。
```

---

## 3. 分类总览

```text
DISCOVERY_*       发现来源
DATA_*            数据完整性与数据质量
STRUCTURE_*       FCZ / POC / AVWAP / deep wash / recovery 结构证据
RISK_*            安全、流动性、holder、wash trading 等风险
CONTEXT_*         smart money / KOL / trending / trenches 等上下文
MANUAL_*          人工复盘与人工标注
COUNTEREXAMPLE_*  反证、失败、漏判、不可执行
HINDSIGHT_*       后验污染与边界移动
GATE_*            阶段门、禁止输出、权限边界
UNKNOWN_*         未知、缺失、冲突、不可判定
```

---

## 4. DISCOVERY reason-codes

```text
DISCOVERY_TRENDING
DISCOVERY_TRENCHES
DISCOVERY_GMGN_SIGNAL
DISCOVERY_MANUAL_WATCH
DISCOVERY_EXTERNAL_NOTE
DISCOVERY_SOURCE_UNCLEAR
```

允许影响：

```text
S0_UNOBSERVED -> S1_DISCOVERED
context_features.discovery_source
manual_review_priority
```

禁止影响：

```text
不能直接触发 FCZ candidate。
不能直接触发 second_launch_watch。
不能作为 can_trade。
```

---

## 5. DATA reason-codes

```text
DATA_REQUEST_CREATED
DATA_READY_MINIMUM_SET
DATA_KLINE_READY
DATA_POOL_READY
DATA_SECURITY_READY
DATA_HOLDER_READY
DATA_RAW_REF_SAVED
DATA_PROVENANCE_READY
DATA_FIELD_MISSING
DATA_FIELD_NULL
DATA_FIELD_TYPE_MISMATCH
DATA_FIELD_UNIT_UNKNOWN
DATA_TIMESTAMP_MISSING
DATA_SNAPSHOT_STALE
DATA_SOURCE_CONFLICT
DATA_INSUFFICIENT_HISTORY
DATA_INSUFFICIENT_BARS
DATA_SCHEMA_UNKNOWN
```

优先级规则：

```text
DATA_SCHEMA_UNKNOWN -> stop automatic classification / manual review。
DATA_SOURCE_CONFLICT -> manual review unless conflict resolution exists。
DATA_FIELD_UNIT_UNKNOWN -> 不得计算 POC/AVWAP/volume confidence。
DATA_INSUFFICIENT_HISTORY -> 不得进入 FCZ_LOCKED。
```

---

## 6. STRUCTURE reason-codes

```text
STRUCTURE_FCZ_RANGE_COMPRESSION
STRUCTURE_FCZ_VOLUME_CONCENTRATION
STRUCTURE_FCZ_POC_CANDIDATE
STRUCTURE_FCZ_LOCKED_ANTI_HINDSIGHT
STRUCTURE_FIRST_IMPULSE_OBSERVED
STRUCTURE_DEEP_WASH_RETRACEMENT
STRUCTURE_SWEEP_AND_RECLAIM
STRUCTURE_POC_RECLAIMED
STRUCTURE_AVWAP_RECLAIMED
STRUCTURE_VALUE_AREA_REENTERED
STRUCTURE_SECOND_LAUNCH_WATCH
STRUCTURE_INVALIDATED_BY_NEW_LOW
STRUCTURE_INVALIDATED_BY_FAILED_RECLAIM
STRUCTURE_INVALIDATED_BY_RANGE_EXPANSION
```

边界：

```text
STRUCTURE_* 只能解释状态机观察，不解释交易执行。
STRUCTURE_SECOND_LAUNCH_WATCH 也只能输出 watch / candidate / needs_manual_review。
```

---

## 7. RISK reason-codes

```text
RISK_RUG_RATIO_HIGH
RISK_WASH_TRADING
RISK_HOLDER_CONCENTRATION
RISK_DEV_TEAM_HOLD_RATE_HIGH
RISK_CREATOR_STATUS_BAD
RISK_CREATOR_CLOSE_RISK
RISK_RAT_TRADER
RISK_BUNDLER
RISK_LIQUIDITY_LOW
RISK_LIQUIDITY_MISSING
RISK_POOL_TOO_NEW
RISK_HONEYPOT_OR_BLACKLIST
RISK_SECURITY_FIELD_MISSING
RISK_SOURCE_CONFLICT
```

优先级：

```text
confirmed severe RISK_* -> S10_RISK_REJECTED。
missing critical RISK_* -> S11_NEEDS_MANUAL_REVIEW。
RISK_* 优先级高于 STRUCTURE_*。
```

禁止：

```text
风险字段不能生成 can_trade。
低风险不是买入理由。
```

---

## 8. CONTEXT reason-codes

```text
CONTEXT_SMART_DEGEN_PRESENT
CONTEXT_RENOWNED_COUNT_PRESENT
CONTEXT_KOL_MENTION
CONTEXT_TRENDING_RANK_HIGH
CONTEXT_ACTIVITY_INCREASING
CONTEXT_NET_BUY_POSITIVE
CONTEXT_LARGE_TRADE_ACTIVITY
CONTEXT_HOLDER_GROWTH
```

边界：

```text
CONTEXT_* 只能影响 context_features、manual_review_priority 或 reason-code candidates。
CONTEXT_* 不能直接进入 S4_FCZ_CANDIDATE。
CONTEXT_* 不能直接输出 candidate / can_trade / position_size。
```

---

## 9. MANUAL reason-codes

```text
MANUAL_REVIEW_REQUIRED
MANUAL_WATCHLIST_ENTRY
MANUAL_SOURCE_NOTE_ADDED
MANUAL_CHART_ANNOTATION_ADDED
MANUAL_CONFLICT_REVIEW_REQUIRED
MANUAL_OWNER_DECISION_REQUIRED
```

用途：

```text
把机器无法自动判断的点转为人工复盘入口。
```

边界：

```text
MANUAL_* 不是人工批准交易。
Owner approval for trading 属于后期 stage gate，不属于当前 observe-only 输出。
```

---

## 10. COUNTEREXAMPLE reason-codes

```text
COUNTEREXAMPLE_FAILURE_AFTER_VALID_SETUP
COUNTEREXAMPLE_FALSE_POSITIVE_RISK
COUNTEREXAMPLE_MISSED_RUN
COUNTEREXAMPLE_DEATH_POOL_MISCLASSIFIED
COUNTEREXAMPLE_UNEXECUTABLE_LIQUIDITY
COUNTEREXAMPLE_DATA_INSUFFICIENT
COUNTEREXAMPLE_SOURCE_CONFLICT
COUNTEREXAMPLE_ACCEPTED
COUNTEREXAMPLE_REJECTED_DATA_QUALITY
```

用途：

```text
进入规则修正、ablation、sample review 和 validator 改进。
```

优先级：

```text
COUNTEREXAMPLE_* 的权重高于单个 SUCCESS 样本。
```

---

## 11. HINDSIGHT reason-codes

```text
HINDSIGHT_OUTCOME_LEAKAGE_RISK
HINDSIGHT_BOUNDARY_MOVED_AFTER_OUTCOME
HINDSIGHT_POST_OUTCOME_POC_USED
HINDSIGHT_FUTURE_LOW_USED_FOR_WASHOUT
HINDSIGHT_FUTURE_PUMP_USED_FOR_RECOVERY
HINDSIGHT_LOCK_MISSING
HINDSIGHT_CONTAMINATED_SAMPLE
```

硬规则：

```text
任何 HINDSIGHT_* 命中，都必须 manual_review_required = true。
严重命中时，样本不得用于证明策略有效。
```

---

## 12. GATE reason-codes

```text
GATE_OBSERVE_ONLY_ENFORCED
GATE_RESEARCH_ONLY_ENFORCED
GATE_FORBIDDEN_OUTPUT_BLOCKED
GATE_PRIVATE_KEY_FORBIDDEN
GATE_SWAP_FORBIDDEN
GATE_ORDER_FORBIDDEN
GATE_POSITION_SIZE_FORBIDDEN
GATE_OWNER_APPROVAL_REQUIRED_LATER
GATE_STAGE_NOT_UNLOCKED
```

用途：

```text
记录系统为什么没有进入交易执行。
```

边界：

```text
GATE_* 是保护机制，不是功能缺陷。
```

---

## 13. UNKNOWN reason-codes

```text
UNKNOWN_GMGN_SCHEMA_STABILITY
UNKNOWN_RATE_LIMIT
UNKNOWN_HISTORICAL_DEPTH
UNKNOWN_VOLUME_UNIT
UNKNOWN_POC_BINNING_METHOD
UNKNOWN_AVWAP_ANCHOR
UNKNOWN_LIQUIDITY_FRESHNESS
UNKNOWN_HOLDER_THRESHOLD
UNKNOWN_WASH_TRADING_RELIABILITY
UNKNOWN_SMART_MONEY_SEMANTICS
UNKNOWN_MULTI_SOURCE_PRIORITY
```

规则：

```text
UNKNOWN_* 不得写成 confirmed。
UNKNOWN_* 应进入 Unknown / Missing registry。
UNKNOWN_* 可以阻断自动分类或触发 manual review。
```

---

## 14. 最小 reason-code record

后续 mapper / sample / state record 应至少能记录：

```text
reason_code
category
severity: info | warning | reject | manual_review | blocker
source_state
next_state
triggered_at
evidence_refs
missing_evidence
notes
```

---

## 15. 本版结论

```text
reason-code taxonomy 的作用是让 FCZ + GMGN 系统的每个观察结论都能被解释、审计、反证和回放。

reason-code 不是交易理由。当前阶段所有 reason-code 都必须停留在 observe_only / research_only 边界内。
```
