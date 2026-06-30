# 状态机 legacy 别名映射 v0.1

> 分线：09_规则与回测 / 状态机翻译层  
> 状态：v0.1 / TP-011 散乱知识点归并小切片  
> 来源：`策略完善_v0.2/策略状态机规则_v0.2.md`  
> 当前真源：`09_规则与回测/状态机规则整合_v0.1.md`  
> 目的：把历史阶段 S0-SX 状态翻译到当前 `STATE_*` 状态机，作为阅读项目内散乱知识点的别名层，而不是恢复旧状态机。  
> 边界：本文件服务观察器、样本标注、历史材料迁移；不是自动交易规则。

---

## 1. 本文件解决什么

项目历史阶段材料中曾使用：

```text
S0 / S1 / S2 / S3 / S4 / S5 / S6 / S7 / S8 / S9 / SX
```

当前主线已经升级为：

```text
STATE_IDLE
STATE_FCZ_CANDIDATE
STATE_FCZ_LOCKED
STATE_FIRST_IMPULSE
STATE_DEEP_WASHOUT_OR_SWEEP
STATE_RECLAIM_TEST
STATE_COST_ANCHOR_ACCEPTED
STATE_PULLBACK_TEST
STATE_SECOND_START_CANDIDATE
STATE_CONFIRMED_OBSERVATION
STATE_FAILED_RECLAIM
STATE_DEATH_MARKET_RISK
STATE_NO_TRADE
```

如果没有翻译层，后续 Agent 读取散乱知识点时容易出现：

```text
1. 把 S 状态当成当前主状态。
2. 把旧阈值当成已验证规则。
3. 在样本记录和状态机 validator 中混用两套命名。
4. 把 S9 “进入策略研究区”误读为交易信号。
```

所以本文件只做一件事：

```text
S0-SX → 当前 STATE_* 的 alias map。
```

---

## 2. 使用原则

```text
1. 当前主状态只使用 STATE_*。
2. S0-SX 只作为 historical_alias / reading aid。
3. 若一个 S 状态对应多个 STATE_*，必须标记 ambiguous / not_one_to_one。
4. 若旧状态带有阈值，只保留为 historical_reference，不自动写入当前规则。
5. 样本 CSV / Markdown 的 current_state_path 仍应使用 STATE_* 或 validator 允许的当前状态名。
```

---

## 3. Legacy alias map

| Legacy 状态 | 历史含义 | 当前推荐映射 | 映射类型 | 说明 |
|---|---|---|---|---|
| S0 | 无结构 | `STATE_IDLE` / `STATE_NO_TRADE` | not_one_to_one | 若只是尚未识别结构，为 `STATE_IDLE`；若明确质量弱或不应观察，为 `STATE_NO_TRADE` |
| S1 | 第一控盘区形成 | `STATE_FCZ_CANDIDATE` / `STATE_FCZ_LOCKED` | phase_split | 旧 S1 同时包含候选和锁定；当前必须区分是否已事前固定边界 |
| S2 | 第一波拉升完成 | `STATE_FIRST_IMPULSE` | direct_alias | 当前需记录 `first_impulse_done`、`first_impulse_high`、`first_impulse_return` |
| S3 | 深回撤测试 | `STATE_DEEP_WASHOUT_OR_SWEEP` | semantic_upgrade | 当前把深回撤、Sweep、Spring 类结构合并为观察状态，不直接给交易含义 |
| S4 | 重新接近 / 站回 POC | `STATE_RECLAIM_TEST` | direct_alias_with_grades | 旧 S4a-S4d 是 reclaim 强弱分级；当前不单独拆状态，进入 `poc_relation` / acceptance 字段 |
| S5 | 重新接受 AVWAP | `STATE_COST_ANCHOR_ACCEPTED` | semantic_merge | 当前把 POC / AVWAP / value area 的接受合并为成本锚接受状态 |
| S6 | 第一次拉起 | `STATE_COST_ANCHOR_ACCEPTED` → `STATE_PULLBACK_TEST` 前置反应 | transitional_alias | 当前没有独立 first_bounce 状态；它是进入 pullback/retest 前的反应事件 |
| S7 | 回撤不破关键成本锚 | `STATE_PULLBACK_TEST` | direct_alias | 当前重点是回撤测试是否守住 POC / AVWAP / VAL 等成本锚 |
| S8 | 二次拉升确认 | `STATE_SECOND_START_CANDIDATE` | direct_alias | 当前仍需后续确认，不等同最终成功 |
| S9 | 稳定小段观察区 | `STATE_CONFIRMED_OBSERVATION` | renamed_with_boundary | 当前明确为 confirmed observation，不是买入/自动交易许可 |
| SX | 失效 / 诱多 / 尾仓派发风险 | `STATE_FAILED_RECLAIM` / `STATE_DEATH_MARKET_RISK` / `STATE_NO_TRADE` | risk_branch | 需按失败来源细分：回收失败、死亡盘风险、直接不观察 |

---

## 4. 分状态说明

### 4.1 S0 → STATE_IDLE / STATE_NO_TRADE

历史定义：

```text
未识别到第一控盘区；或控盘区质量 weak；或没有后续第一波拉升。
```

当前拆分：

```text
STATE_IDLE：还没有可研究结构。
STATE_NO_TRADE：已经有足够理由不观察 / 不进入样本主路径。
```

迁移规则：

```text
如果历史材料只是说“无结构”，映射为 STATE_IDLE。
如果同时说 weak / no_trade / model_valid=false，映射为 STATE_NO_TRADE。
```

---

### 4.2 S1 → STATE_FCZ_CANDIDATE / STATE_FCZ_LOCKED

历史定义：

```text
第一控盘区形成，control_zone_detected = true，满足 bars/range/POC 条件。
```

当前拆分：

```text
STATE_FCZ_CANDIDATE：疑似 FCZ，边界尚未最终事前固定。
STATE_FCZ_LOCKED：FCZ 高低点、POC、AVWAP_ZoneStart 已锁定，后续不得移动。
```

关键差异：

```text
历史 S1 更像“形成”；当前必须追问是否 locked。
```

迁移规则：

```text
若历史记录没有明确固定边界，先映射为 STATE_FCZ_CANDIDATE。
只有当 fcz_high/fcz_low/poc_level/rule_version 已记录，才映射为 STATE_FCZ_LOCKED。
```

---

### 4.3 S2 → STATE_FIRST_IMPULSE

历史定义：

```text
第一波拉升完成，impulse_detected = true，突破 control_zone_high。
```

当前映射：

```text
STATE_FIRST_IMPULSE
```

保留但降级为待验证的历史阈值：

```text
impulse_range >= 1.5 * control_zone_range
impulse_volume_expansion >= 1.2
```

迁移规则：

```text
这些阈值可作为 initial_observation_threshold，不作为已验证策略阈值。
```

---

### 4.4 S3 → STATE_DEEP_WASHOUT_OR_SWEEP

历史定义：

```text
深回撤测试，0.618 <= retracement_ratio <= 0.786。
```

当前映射：

```text
STATE_DEEP_WASHOUT_OR_SWEEP
```

语义升级：

```text
当前不仅看 Fib 深回撤，还纳入 sweep_detected、跌破后收回、Spring 类结构。
```

保留但降级为观察参考：

```text
0.618-0.786：深回撤观察区
0.786-0.886：偏深风险区
>0.886：结构破坏风险
```

---

### 4.5 S4 → STATE_RECLAIM_TEST

历史定义：

```text
重新接近 / 站回 POC，分 S4a-S4d。
```

当前映射：

```text
STATE_RECLAIM_TEST
```

旧分级归并为字段：

```text
S4a 接近 POC，但未站回 → poc_relation = touch / rejected
S4b 单根收盘站回 POC → poc_relation = reclaimed_weak
S4c 连续站上 POC >= 3 根 → poc_relation = reclaimed_medium
S4d 站上后回踩 POC 不破 → poc_relation = accepted_or_respected
```

注意：

```text
这些字段名是建议性归并，不要求当前 validator 立即支持。
```

---

### 4.6 S5 → STATE_COST_ANCHOR_ACCEPTED

历史定义：

```text
重新接受 AVWAP，分 S5a-S5d。
```

当前映射：

```text
STATE_COST_ANCHOR_ACCEPTED
```

旧分级归并为字段：

```text
S5a 单根站上 AVWAP → avwap_relation = reclaimed_weak
S5b 连续站上 AVWAP >= 3 根 → avwap_relation = reclaimed_medium
S5c 回踩 AVWAP 不破 → avwap_relation = accepted_or_respected
S5d AVWAP + POC 同时被接受 → cost_anchor_confluence = true
```

边界：

```text
成本锚接受仍是观察状态，不是自动交易许可。
```

---

### 4.7 S6 → first_bounce event / STATE_PULLBACK_TEST 前置反应

历史定义：

```text
第一次拉起，first_bounce_detected = true。
```

当前处理：

```text
不建议新增独立 STATE_FIRST_BOUNCE。
```

原因：

```text
第一次拉起更像事件字段，而不是稳定状态；当前状态机可用 STATE_COST_ANCHOR_ACCEPTED 后的 reaction event 表达。
```

建议字段：

```text
first_bounce_detected
first_bounce_high
first_bounce_volume_ratio
```

当前映射：

```text
STATE_COST_ANCHOR_ACCEPTED + first_bounce_detected=true
→ 等待 STATE_PULLBACK_TEST
```

---

### 4.8 S7 → STATE_PULLBACK_TEST

历史定义：

```text
回撤不破关键成本锚。
```

当前映射：

```text
STATE_PULLBACK_TEST
```

旧分级归并为字段：

```text
S7弱：不破前低
S7中：不破 POC
S7强：不破 POC + AVWAP
S7很强：不破 POC + AVWAP + VAL，且回撤缩量
```

建议未来字段：

```text
pullback_hold_grade = weak / medium / strong / very_strong
```

状态：

```text
observer_candidate / needs_sample_validation
```

---

### 4.9 S8 → STATE_SECOND_START_CANDIDATE

历史定义：

```text
二次拉升确认。
```

当前映射：

```text
STATE_SECOND_START_CANDIDATE
```

注意：

```text
当前命名故意使用 candidate，因为二次拉升仍需观察是否真正进入 CONFIRMED_OBSERVATION。
```

保留但降级为待验证的旧阈值：

```text
tolerance = 0.995
min_second_push_volume_ratio = 1.0
strong_second_push_volume_ratio = 1.2
```

---

### 4.10 S9 → STATE_CONFIRMED_OBSERVATION

历史定义：

```text
稳定小段观察区；进入策略研究区。
```

当前映射：

```text
STATE_CONFIRMED_OBSERVATION
```

边界修正：

```text
confirmed observation 只表示“结构观察成立”，不表示交易可执行，不表示收益预期。
```

必须继续经过：

```text
风险评分
样本反证
执行成本
商业可行性
owner decision
```

---

### 4.11 SX → STATE_FAILED_RECLAIM / STATE_DEATH_MARKET_RISK / STATE_NO_TRADE

历史定义：

```text
失效 / 诱多 / 尾仓派发风险。
```

当前拆分：

```text
STATE_FAILED_RECLAIM：POC / AVWAP / value area 回收失败。
STATE_DEATH_MARKET_RISK：死亡盘、派发、流动性衰退风险升高。
STATE_NO_TRADE：直接不进入观察 / 不可执行。
```

迁移规则：

```text
POC 多次回收失败 → STATE_FAILED_RECLAIM
AVWAP 变成压力 → STATE_FAILED_RECLAIM 或 STATE_DEATH_MARKET_RISK
第一波高点派发严重 → STATE_DEATH_MARKET_RISK
反抽继续放量卖出 → STATE_DEATH_MARKET_RISK
二次拉升失败 → STATE_FAILED_RECLAIM
distribution_score >= 70 → STATE_DEATH_MARKET_RISK / STATE_NO_TRADE
```

---

## 5. 旧阈值处理规则

历史阶段材料中包含一些初始阈值：

```text
min_control_zone_bars = 10
max_control_zone_range_atr = 2.5
impulse_range >= 1.5 * control_zone_range
impulse_volume_expansion >= 1.2
0.618 <= retracement_ratio <= 0.786
reclaim_timeout_bars = 3
second_push_tolerance = 0.995
min_second_push_volume_ratio = 1.0
strong_second_push_volume_ratio = 1.2
max_distribution_score = 60 / 70
```

处理规则：

```text
1. 可进入 MQL5 观察器 input 默认值。
2. 可进入样本记录的 observation note。
3. 不可直接作为已验证交易阈值。
4. 不可作为自动下单条件。
5. 必须通过 FCZ_B/C/D 真实样本、消融实验和反证样本校准后，才能升级为 validated_threshold。
```

---

## 6. 对 validator / 样本的影响

当前不立即修改：

```text
scripts/validate_state_paths.py
07_样本标注/反证样本库_v0.1.csv
07_样本标注/样本记录/*.md
```

原因：

```text
当前样本主线应继续使用 STATE_*；S0-SX 只是历史材料翻译层。
```

未来如需要读取历史记录，可增加一个独立 validator 或 parser：

```text
scripts/normalize_legacy_state_aliases.py
```

但当前不建议做，避免过早扩大工程面。

---

## 7. 本版结论

```text
1. S0-SX 不应恢复为当前主状态机。
2. S0-SX 应作为 historical_alias，用来翻译项目内散乱知识点。
3. 当前 STATE_* 状态机比旧 S 状态更适合样本、validator 和 MQL5 观察器。
4. 旧阈值只能作为观察默认值或待验证候选，不能变成交易规则。
5. 下一步更适合归并 POC / AVWAP / Market Profile / VWAP 资料包到观察器字段，而不是继续扩状态机。
```
