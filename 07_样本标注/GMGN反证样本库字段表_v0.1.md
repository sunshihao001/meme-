# GMGN 反证样本库字段表 v0.1

> 位置：`07_样本标注/GMGN反证样本库字段表_v0.1.md`  
> 分线：样本标注线 / 反证审计线 / 规则与回测线 / GMGN 数据源线  
> 状态：v0.1，字段表初版  
> 来源：`反证样本库_v0.1.csv`、`样本字段表_v0.1.md`、`GMGN样本标注字段扩展_v0.1.md`、`第一批20个反证对照样本采集计划_v0.1.md`。  
> 本轮实际加载 skills：`dbs-good-question`、`dbs-goal`、`dbs-decision`、`gmgn-market`、`gmgn-token`、`gmgn-portfolio`、`gmgn-track`、`dbs-report`。  
> 禁止边界：不引入交易执行字段到当前反证库，不写 `gmgn-swap` / `gmgn-cooking` / 私钥 / 自动交易字段。

---

## 1. 本文件目的

本文件定义：

```text
反证样本库_v0.1.csv 里，第一批真实样本与半成品样本需要哪些字段，才能专门用于挑战 FCZ 模型，而不是继续堆业务描述。
```

本文件的核心目标不是多记一些信息，而是：

```text
1. 能看出模型哪里错。
2. 能看出是规则错、执行错、还是市场环境错。
3. 能防止后视偏差。
4. 能区分真实失败与不可执行。
5. 能支持后续消融实验和回测。
```

---

## 2. 反证样本库的定位

反证样本库不是成功案例库，也不是漂亮图形库。

它专门放：

```text
B 类：模型符合但失败
C 类：模型不完全符合但大涨
D 类：看似符合但死亡盘
E 类：定义争议样本
F 类：不可执行样本
```

少量 A 类样本可以保留，但不是主角。

---

## 3. 反证样本库字段分层

本字段表分 8 层：

```text
L0 基础身份层
L1 GMGN 来源与追溯层
L2 结构与成本锚层
L3 风险与拒绝层
L4 触发与执行层
L5 结果与收益层
L6 反证审计层
L7 备注与争议层
```

---

## 4. L0：基础身份层

| 字段 | 类型 | 必填 | 说明 |
|---|---|---|---|
| `sample_id` | string | 是 | 例如 `FCZ_B_0001` |
| `sample_class` | enum | 是 | A / B / C / D / E / F |
| `sample_subclass` | string/enum | 是 | 例如 `B1`、`C4`、`D3` |
| `symbol` | string | 是 | 标的代码或 token 名称 |
| `chain_or_market` | string | 是 | Solana / ETH / Base / BSC / MT5 / 其他 |
| `exchange_or_dex` | string | 否 | 所属交易所 / DEX |
| `timeframe` | string | 是 | 1m / 5m / 15m / 1h / 4h / 1d |
| `sample_start_time` | datetime | 是 | 样本起始时间 |
| `sample_end_time` | datetime | 是 | 样本结束时间 |
| `reviewer` | string | 是 | 标注者 |
| `review_date` | date | 是 | 标注日期 |
| `rule_version` | string | 是 | 使用的规则版本 |
| `sample_source` | enum | 是 | real / synthetic / imported / manual |
| `is_real_sample` | bool | 是 | 是否真实样本 |

---

## 5. L1：GMGN 来源与追溯层

| 字段 | 类型 | 必填 | 说明 |
|---|---|---|---|
| `gmgn_sample_id` | string | 是 | GMGN 视角样本 ID |
| `gmgn_chain` | enum | 是 | sol / bsc / base / eth |
| `gmgn_token_address` | string | 是 | Token 合约地址 |
| `gmgn_primary_pair_or_pool` | string | 否 | 主池地址 |
| `gmgn_raw_refs` | list/string | 是 | 原始查询结果、截图、JSON、命令引用 |
| `gmgn_source_capabilities` | list | 是 | 使用过的 GMGN 能力，如 market/trending/token/security |
| `gmgn_fetched_at` | datetime | 是 | 数据抓取时间 |
| `gmgn_data_window` | string | 否 | 1m / 5m / 1h / 24h / all |
| `gmgn_api_version_or_cli_version` | string | 否 | 版本记录 |
| `gmgn_data_confidence_overall` | number | 是 | 0-1 总体置信度 |
| `gmgn_conflict_flags` | list | 否 | 数据冲突列表 |
| `gmgn_multisource_required` | bool | 是 | 是否需要多源校验 |
| `gmgn_notes` | string | 否 | GMGN 采集备注 |

硬规则：

```text
没有 gmgn_raw_refs / gmgn_fetched_at / gmgn_source_capabilities 的样本，不允许进入反证样本库主表。
```

---

## 6. L2：结构与成本锚层

| 字段 | 类型 | 必填 | 说明 |
|---|---|---|---|
| `first_control_zone_detected` | bool | 是 | 是否识别第一控盘区 |
| `fcz_high` | number | 是 | FCZ 上沿 |
| `fcz_low` | number | 是 | FCZ 下沿 |
| `fcz_mid` | number | 否 | FCZ 中轴 |
| `fcz_start_time` | datetime | 是 | FCZ 开始时间 |
| `fcz_end_time` | datetime | 是 | FCZ 结束时间 |
| `fcz_bars` | integer | 是 | K 线数 |
| `fcz_volume_share` | number | 否 | 成交量占比 |
| `poc_level` | number | 是 | POC 价格 |
| `vah_level` | number | 否 | Value Area High |
| `val_level` | number | 否 | Value Area Low |
| `hvn_zone` | string | 否 | HVN 区域 |
| `cost_center_method` | enum | 是 | POC / ValueArea / AVWAP / HVN / StructureRange / Mixed / Unknown |
| `cost_center_confidence` | number | 是 | 成本中枢置信度 |
| `avwap_reclaimed` | bool | 是 | 是否站回至少一个关键 AVWAP |
| `avwap_confluence_count` | integer | 否 | AVWAP 共振数量 |
| `best_respected_avwap_anchor` | string/enum | 否 | 最受尊重锚点 |

---

## 7. L3：风险与拒绝层

| 字段 | 类型 | 必填 | 说明 |
|---|---|---|---|
| `security_veto_flags` | list | 是 | 硬拒绝原因 |
| `is_honeypot` | enum/bool | 条件必填 | 潜在 honeypot 风险 |
| `open_source` | enum | 否 | yes / no / unknown |
| `owner_renounced` | enum | 否 | yes / no / unknown |
| `renounced_mint` | bool | 条件必填 | SOL mint 是否放弃 |
| `renounced_freeze_account` | bool | 条件必填 | SOL freeze 是否放弃 |
| `buy_tax` | number | 否 | 买税 |
| `sell_tax` | number | 否 | 卖税 |
| `rug_probability` | number | 是 | rug 风险分数 |
| `death_market_score` | integer | 是 | 死亡盘风险评分 |
| `bull_trap_score` | integer | 是 | 诱多风险评分 |
| `failed_reclaim_score` | integer | 否 | 失败回收评分 |
| `distribution_score` | integer | 否 | 派发风险评分 |
| `liquidity_trap_score` | integer | 否 | 流动性陷阱评分 |
| `narrative_decay_score` | integer | 否 | 叙事衰退评分 |
| `token_risk_score` | number | 是 | 综合风险分 |
| `security_decision` | enum | 是 | pass / reject / needs_manual_review |

硬拒绝建议：

```text
is_honeypot = yes
rug_probability > 0.30
sell_tax > 0.10
top10_holder_rate > 0.50 且无解释
death_market_score >= 3 且没有可信反证
```

---

## 8. L4：触发与执行层

当前阶段只记录，不执行。

| 字段 | 类型 | 必填 | 说明 |
|---|---|---|---|
| `entry_rule_triggered` | bool | 是 | 是否触发观察规则 |
| `triggered_group` | enum/string | 是 | 结构触发 / 回收触发 / 二次启动触发 / 风险过滤 / 其他 |
| `entry_time` | datetime | 否 | 入场/触发时间 |
| `entry_price` | number | 否 | 触发价 |
| `stop_price` | number | 否 | 止损价（若已定义） |
| `initial_risk_pct` | number | 否 | 初始风险 |
| `slippage_estimate_pct` | number | 否 | 预估滑点 |
| `liquidity_depth_at_entry` | number | 否 | 入场流动性深度 |
| `is_actionable_entry` | bool | 否 | 当前样本是否可执行 |
| `non_actionable_reason` | string | 否 | 不可执行原因 |
| `entry_execution_quality` | enum | 否 | good / medium / poor / impossible |
| `bar_backtest_fill_possible` | bool | 否 | K 线价是否可能成交 |
| `live_fill_risk_level` | enum | 否 | low / medium / high |

当前规则：

```text
如果 sample 是 E/F 类，必须优先记录不可执行字段，不要强行写成成功交易样本。
```

---

## 9. L5：结果与收益层

| 字段 | 类型 | 必填 | 说明 |
|---|---|---|---|
| `max_favorable_excursion_R` | number | 否 | 最大有利波动 R |
| `max_adverse_excursion_R` | number | 否 | 最大不利波动 R |
| `gross_realized_R` | number | 否 | 毛收益 R |
| `net_realized_R_after_cost` | number | 否 | 扣成本后净收益 R |
| `max_drawdown_after_entry_R` | number | 否 | 入场后最大回撤 R |
| `holding_period_bars` | integer | 否 | 持仓 K 线数 |
| `win_loss` | enum | 否 | win / loss / breakeven / no_trade / unknown |
| `failure_reason` | string | 否 | 失败原因 |
| `final_classification` | enum | 是 | no_trade / observe_only / candidate_for_deeper_review / second_start_candidate |

---

## 10. L6：反证审计层

| 字段 | 类型 | 必填 | 说明 |
|---|---|---|---|
| `challenged_hypothesis` | string/list | 是 | 挑战的假设，如 H1-H7 |
| `would_rule_have_triggered_ex_ante` | bool | 是 | 事前是否触发 |
| `was_boundary_moved_after_outcome` | bool | 是 | 是否事后移动边界 |
| `was_anchor_changed_after_outcome` | bool | 是 | 是否事后改锚点 |
| `is_failure_explained_by_new_rule` | bool | 否 | 是否用新规则解释失败 |
| `new_rule_needed` | bool | 否 | 是否需要新规则 |
| `new_rule_side_effect` | enum/string | 否 | low / medium / high / unknown |
| `can_simpler_rule_explain_it` | bool | 否 | 是否可由更简单规则解释 |
| `commercial_actionability_score` | integer | 否 | 0-3 商业可执行性 |
| `invalidate_reason` | string | 否 | 否决原因 |
| `positive_evidence` | list/string | 否 | 正向证据 |
| `negative_evidence` | list/string | 否 | 风险证据 |
| `missing_evidence` | list/string | 否 | 缺失证据 |
| `next_observation` | string | 否 | 下一步观察 |
| `audit_conclusion` | enum | 否 | 规则缺陷 / 执行缺陷 / 市场环境缺陷 / 不可避免亏损 / 过度保守 / 标注争议 |
| `next_action` | enum | 否 | 保留规则 / 降级规则 / 新增观察字段 / 暂停深化 / 进入消融实验 |

核心原则：

```text
如果 would_rule_have_triggered_ex_ante = true，则后续失败必须保留为失败样本，不能因为结果不好改成“不符合”。
```

---

## 11. L7：备注与争议层

| 字段 | 类型 | 必填 | 说明 |
|---|---|---|---|
| `notes` | string | 否 | 备注 |
| `origin_of_dispute` | string | 否 | 争议来源 |
| `manual_review_notes` | string | 否 | 人工审查说明 |
| `sample_artifact_status` | enum | 否 | pending / partial / complete |
| `sample_artifact_refs` | list/string | 否 | 截图、CSV、原始 refs |

---

## 12. 反证样本库最小 CSV 字段集

建议第一版 CSV 至少保留以下字段：

```text
sample_id,sample_class,sample_subclass,symbol,chain_or_market,exchange_or_dex,timeframe,sample_start_time,sample_end_time,reviewer,review_date,rule_version,sample_source,is_real_sample,gmgn_sample_id,gmgn_chain,gmgn_token_address,gmgn_raw_refs,gmgn_source_capabilities,gmgn_fetched_at,gmgn_data_confidence_overall,gmgn_multisource_required,first_control_zone_detected,fcz_high,fcz_low,poc_level,vah_level,val_level,first_impulse_done,retracement_ratio,deep_washout_detected,sweep_detected,sweep_grade,sweep_reclaim_bars,value_area_reentered,poc_reclaimed,avwap_reclaimed,avwap_confluence_count,best_respected_avwap_anchor,pullback_holds_anchor,second_push_confirmed,bos_after_reclaim,death_market_score,bull_trap_score,failed_reclaim_score,entry_rule_triggered,triggered_group,entry_time,entry_price,stop_price,liquidity_depth_at_entry,is_actionable_entry,max_favorable_excursion_R,max_adverse_excursion_R,gross_realized_R,net_realized_R_after_cost,win_loss,failure_reason,final_classification,would_rule_have_triggered_ex_ante,was_boundary_moved_after_outcome,was_anchor_changed_after_outcome,commercial_actionability_score,notes
```

这套字段集偏向：

```text
第一批真实样本、反证样本、可执行性审计。
```

---

## 13. 字段维护规则

新增字段前必须回答：

```text
1. 它解决的是什么已知失败？
2. 它能否事前标注？
3. 它能否被不同标注者一致判断？
4. 它应进入 CSV 主表还是扩展字段？
5. 它是否会让样本更容易被事后解释？
```

未通过审计的字段只能进入：

```text
观察字段
```

不能直接进入核心规则。

---

## 14. 本版结论

这版字段表把反证样本库从“记录失败”的表，升级为：

```text
能够挑战 FCZ 结构、识别执行不可行、记录事前/事后差异、并支撑后续消融实验的研究资产。
```

---

## 15. 下一步

下一步直接推进：

```text
1. 三个真实样本的半成品填充。
2. 反证样本库 CSV 结构对齐。
3. 第一轮审计摘要。
```
