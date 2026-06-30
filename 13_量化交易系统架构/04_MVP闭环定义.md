# MVP 闭环定义 v0.1

> 分线：13_量化交易系统架构 / MVP  
> 状态：v0.1 / 已审查理论草案落库  
> 目标：定义当前阶段最小安全闭环，避免误进入交易执行。  
> 边界：MVP 不接入 API key/private key，不 swap，不自动下单。

---

## 1. MVP 名称

```text
GMGN FCZ Observe-only Research MVP
```

中文：

```text
GMGN 数据驱动的第一控盘区成本中枢回收模型只读观察与样本反证 MVP
```

---

## 2. MVP 目标

MVP 只验证一件事：

```text
GMGN 只读数据是否足以把 FCZ 结构策略转成可标注、可反证、可审计的状态字段。
```

MVP 不验证：

```text
1. 是否能稳定盈利。
2. 是否应该实盘买入。
3. 是否可以自动下单。
4. 是否可以自动止盈止损。
5. 是否可以接入 private key。
```

---

## 3. MVP 输入

```text
1. GMGN kline JSON：time / open / high / low / close / volume / amount。
2. GMGN token / market / risk snapshot：liquidity、holder_count、top_10_holder_rate、rug_ratio、is_wash_trading、creator_token_status 等。
3. 样本记录：sample_id、chain、token_address、time window、raw refs。
4. 结构参数：FCZ 候选窗口、profile bins、volume basis、reclaim lookback。
```

输入约束：

```text
1. 所有输入必须可追溯到 raw refs 或手工标注。
2. USD volume 与 token amount 必须区分。
3. 不允许用结果倒推 FCZ 边界。
```

---

## 4. MVP 处理步骤

```text
1. 读取 GMGN 只读数据与样本上下文。
2. 保存 raw refs / snapshot / provenance。
3. 计算 FCZ high / low / bars / range。
4. 计算近似 POC / VAH / VAL。
5. 计算 AVWAP zonestart / impulsestart。
6. 计算 retracement / sweep / reclaim / poc_above_bars / avwap_above_bars。
7. 合并风险上下文字段。
8. 输出 current_state 与 reason_codes。
9. 输出 allowed_mode = observe_only / research_only。
10. 写入样本记录或状态字段报告，供人工复盘与反证。
```

---

## 5. MVP 输出

最小输出字段：

```text
chain
token_address
resolution
source_provider = gmgn
source_command
fetched_at
request_hash
schema_version
fcz_high
fcz_low
fcz_bars
gmgn_zone_volume_usd_sum
gmgn_zone_amount_sum
poc_level
vah_level
val_level
poc_position_ratio
avwap_zonestart
avwap_impulsestart
retracement_ratio
sweep_detected
poc_reclaimed
value_area_reentered
poc_above_bars
avwap_above_bars
rug_ratio
is_wash_trading
top_10_holder_rate
smart_degen_count
creator_token_status
liquidity
current_state
allowed_mode
positive_evidence
negative_evidence
missing_evidence
reason_codes
```

---

## 6. MVP 状态机边界

允许输出：

```text
reject
watch
candidate
needs_manual_review
no_trade
observe_only
research_only
```

禁止输出：

```text
can_trade
auto_buy
auto_sell
execute_swap
place_order
take_profit_order
stop_loss_order
```

---

## 7. MVP 验收标准

MVP 完成必须满足：

```text
1. 至少能处理一批 GMGN 样本记录。
2. 每个输出字段能追溯到 raw refs、派生公式或人工标注。
3. FCZ 边界锁定时间和防后验移动字段存在。
4. allowed_mode 永远是 observe_only / research_only。
5. validate_all 通过。
6. 文档索引与变更记录同步更新。
```

MVP 不合格条件：

```text
1. 输出买卖建议。
2. 接入 private key。
3. 调用 swap。
4. 缺少 raw refs。
5. 无法解释字段来源。
6. 将单个成功样本升级为策略有效结论。
```

---

## 8. 本版结论

```text
当前 MVP 是研究闭环，不是交易闭环。

它的成功标志不是赚钱，而是让 GMGN 数据 → FCZ 状态字段 → 样本反证 → 观察结论 变得可复核、可审计、可继续工程化。
```
