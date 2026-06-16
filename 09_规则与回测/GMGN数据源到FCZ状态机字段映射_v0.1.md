# GMGN数据源到FCZ状态机字段映射 v0.1

> 分线：09_规则与回测 / GMGN 数据源 / 自建交易系统前置理论  
> 状态：v0.1 / 根系需求更正后的具体理论研究切片  
> 上游纠偏：`10_工程化交接/根系需求更正_GMGN自建交易系统_v0.1.md`  
> 目标：把第一控盘区成本中枢回收模型从 MQL5 观察器参考层，迁移到 GMGN 数据源 + 自建 meme 市场脚本的理论字段层。  
> 边界：本文件只定义数据与状态机映射，不定义实盘下单、不承诺收益、不跳过样本验证。

---

## 1. 本文件为什么存在

Owner 已明确：

```text
MQL5/MT5 不支持 meme 市场，不是最终交易系统的数据源或执行平台。
最终系统应是自建交易脚本，数据源提供者主要是 GMGN skill/data。
```

因此当前理论研究必须回答：

```text
如果不用 MQL5 作为数据源，GMGN 能提供哪些字段来支持 FCZ 状态机？
哪些 MQL5 观察器字段可以迁移？
哪些必须重写？
哪些仍然缺失，不能伪造？
```

---

## 2. GMGN 可用数据族

基于当前 `gmgn-market` skill，GMGN 可提供以下数据族。

### 2.1 market kline

命令形态：

```bash
gmgn-cli market kline --chain <sol|bsc|base|eth> --address <token_address> --resolution <1m|5m|15m|1h|4h|1d> --from <unix_ts> --to <unix_ts>
```

核心字段：

```text
time
open
high
low
close
volume   # USD 交易额
amount   # token 成交数量
```

用途：

```text
构建 FCZ / impulse / washout / reclaim / pullback / second push 的 OHLCV 基础序列。
```

### 2.2 market trending

核心字段族：

```text
price
market_cap
liquidity
volume
price_change_percent1m / 5m / 1h
swaps
buys / sells
holder_count
smart_degen_count
renowned_count
rug_ratio
top_10_holder_rate
is_wash_trading
creator_token_status
creator_close
dev_team_hold_rate
launchpad_platform
exchange
```

用途：

```text
结构候选筛选、流动性/风险过滤、meme 生命周期判断、市场热度与 smart money 辅助确认。
```

### 2.3 market trenches

核心字段族：

```text
new_creation
near_completion / data.pump
completed
created_timestamp
open_timestamp
complete_timestamp
swaps_1m / swaps_1h / swaps_24h
volume_1h / volume_24h
net_buy_24h
holder_count
liquidity
usd_market_cap
rug_ratio
top_10_holder_rate
rat_trader_amount_rate
bundler_trader_amount_rate
is_wash_trading
sniper_count
smart_degen_count
renowned_count
creator_token_status
```

用途：

```text
早期 token 发现、样本候选池、FCZ 是否处在 launchpad/毕业/开放市场不同阶段的上下文判定。
```

### 2.4 market signal

核心字段族：

```text
signal_type
trigger_at
trigger_mc
first_trigger_mc
market_cap
ath
signal_times
signal_times_by_type
cur_data.top_10_holder_rate
cur_data.holder_count
cur_data.liquidity
```

用途：

```text
smart money buy、价格 spike、ATH、CTO 等事件型观察，不直接等于买卖信号。
```

---

## 3. FCZ 状态机字段映射

### 3.1 FCZ 候选 / 锁定

| 当前状态机字段 | GMGN 数据来源 | 映射方式 | 状态 |
|---|---|---|---|
| `fcz_high` | kline.high | 候选窗口内最高价 | implementable |
| `fcz_low` | kline.low | 候选窗口内最低价 | implementable |
| `fcz_bars` | kline bars | 候选窗口 bar 数 | implementable |
| `fcz_range` | high-low | `fcz_high - fcz_low` | implementable |
| `zone_tick_volume_sum` | kline.volume / amount | 对窗口内 volume 或 amount 求和；优先 USD `volume` 做商业规模，`amount` 做 token 单位参考 | implementable |
| `profile_bin_count` | 自建脚本参数 | 类似 MQL5 `InpProfileBins` | implementable |
| `poc_level` | kline OHLCV 派生 | 需要用价格分箱 + volume/amount 近似 | implementable_with_approximation |
| `vah_level` / `val_level` | kline OHLCV 派生 | value area ratio 分箱派生 | implementable_with_approximation |
| `poc_position_ratio` | 派生 | `(poc_level - fcz_low) / (fcz_high - fcz_low)` | implementable |
| `first_control_zone_detected` | 派生 | 需要候选窗口规则，不由 GMGN 直接提供 | needs_rule_definition |
| `was_boundary_moved_after_outcome` | 样本记录 | 必须由脚本锁定时间戳和 hash/记录防止后验移动 | implementable_as_audit_field |

注意：

```text
GMGN kline 的 `volume` 是 USD 交易额，`amount` 是 token 数量，不能混用。
```

---

### 3.2 第一波拉升

| 当前状态机字段 | GMGN 数据来源 | 映射方式 | 状态 |
|---|---|---|---|
| `first_impulse_done` | kline OHLC | 突破 FCZ high 且涨幅满足候选阈值 | needs_validation |
| `first_impulse_high` | kline.high | FCZ 后 N bars 内最高点 | implementable |
| `first_impulse_return` | close/high 派生 | `(impulse_high - fcz_high or fcz_mid) / base` | needs_definition |
| `impulse_volume_expansion` | kline.volume | 第一波窗口 volume 与 FCZ 平均 volume 对比 | implementable |
| `price_change_percent1m/5m/1h` | trending | 可作为外部热度辅助，但不能替代 kline 结构 | observer_candidate |
| `smart_degen_count` | trending/trenches/signal | 只能作 smart money 上下文，不直接证明结构成立 | context_only |

---

### 3.3 深洗 / Sweep / Reclaim

| 当前状态机字段 | GMGN 数据来源 | 映射方式 | 状态 |
|---|---|---|---|
| `retracement_ratio` | kline OHLC | `(impulse_high - washout_low) / impulse_range` | implementable |
| `deep_washout_detected` | retracement 派生 | 阈值候选，需样本验证 | needs_validation |
| `sweep_detected` | kline low/high | 跌破 FCZ low / VAL / prior_low 后收回 | implementable |
| `sweep_reference_level` | FCZ/VAL/prior low | 自建脚本锁定参考水平 | implementable |
| `sweep_reclaim_bars` | kline close | 跌破后 N bars 内重新 close 回关键水平 | implementable |
| `value_area_reentered` | kline close + VAH/VAL | close 回到 VAL/VAH 内 | implementable |
| `poc_reclaimed` | kline close + POC | close > POC，连续 bars 另计 | implementable |
| `poc_above_bars` | kline close + POC | 从当前 bar 往回统计连续 close > POC | implementable |
| `poc_rejected_recently` | kline high/close + POC | lookback 内 high >= POC 且 close < POC，且当前 close < POC | observer_candidate |

---

### 3.4 AVWAP 成本锚

| 当前字段 | GMGN 数据来源 | 映射方式 | 状态 |
|---|---|---|---|
| `avwap_zonestart` | kline price + volume | 从 FCZ 起点到当前计算 `sum(price*volume)/sum(volume)` | implementable |
| `avwap_impulsestart` | kline price + volume | 从第一波启动点到当前计算 | implementable |
| `avwap_reclaim` | kline + reclaim event | 从 reclaim bar 到当前计算 | observer_candidate |
| `avwap_pullbacklow` | kline + washout low event | 从 washout low 到当前计算 | observer_candidate |
| `avwap_above_bars` | kline close + AVWAP | 连续 close > avwap_zonestart 或指定锚点 | implementable |
| `avwap_rejected_recently` | kline high/close + AVWAP | lookback 内触及后收回下方 | observer_candidate |
| `avwap_confluence_count` | 多 AVWAP | 多锚点距离/同向关系计数 | needs_sample_validation |

注意：

```text
GMGN 的 kline 有 volume/amount，但具体用 USD volume 还是 token amount 计算 AVWAP，必须作为可配置参数和实验变量，不能默认等价。
```

---

### 3.5 风险审查器映射

| 风险字段 | GMGN 数据来源 | 映射方式 | 状态 |
|---|---|---|---|
| `rug_ratio` | trending/trenches | >0.3 高风险参考 | integrated_candidate |
| `is_wash_trading` | trending/trenches | true 则快速排除或降级 | integrated_candidate |
| `top_10_holder_rate` | trending/trenches/signal.cur_data | 集中度风险 | integrated_candidate |
| `dev_team_hold_rate` | trending/trenches | dev 持仓风险 | integrated_candidate |
| `creator_token_status` | trending/trenches | creator_hold / creator_close 生命周期线索 | integrated_candidate |
| `smart_degen_count` | trending/trenches | smart money 上下文，不是直接买点 | context_only |
| `renowned_count` | trending/trenches | KOL/renowned 上下文，可能偏晚期 | context_only |
| `liquidity` | trending/trenches/signal.cur_data | 流动性门槛、滑点风险 | needs_execution_model |
| `swaps/buys/sells/net_buy` | trending/trenches | 活跃度和买卖压力 | observer_candidate |
| `rat_trader_amount_rate` / `bundler_rate` | trenches | 内部/捆绑交易风险 | integrated_candidate |

---

## 4. 从 MQL5 字段迁移到自建脚本的规则

### 4.1 可迁移字段

```text
fcz_high
fcz_low
fcz_bars
poc_level
vah_level
val_level
profile_bin_count
poc_position_ratio
zone_volume_sum / zone_tick_volume_sum
avwap_zonestart
avwap_impulsestart
retracement_ratio
poc_relation
avwap_relation
poc_above_bars
avwap_above_bars
poc_rejected_recently
avwap_rejected_recently
current_state
allowed_mode
positive_evidence
negative_evidence
missing_evidence
```

### 4.2 必须重命名或重新定义字段

```text
zone_tick_volume_sum → gmgn_zone_volume_usd_sum / gmgn_zone_amount_sum
InpUseTickVolume → gmgn_volume_basis = usd_volume | token_amount
MT5 timeframe → gmgn_resolution
MQL5 chart object → script visualization / report field / dashboard object
```

### 4.3 不可直接迁移的东西

```text
MT5 GUI 挂载状态
MQL5 Files 路径
MetaEditor 编译结果
EA / CTrade / OrderSend 概念
MT5 broker execution assumptions
```

---

## 5. 自建脚本前置模块建议

下一阶段工程 spec 不应从“交易执行”开始，而应从数据-状态映射开始：

```text
scripts/gmgn_fcz_state_mapper.py
```

最小职责：

```text
1. 输入：GMGN kline JSON + token metadata/risk snapshot。
2. 输出：FCZ 状态机候选字段 JSON/CSV。
3. 保留 provenance：chain、token_address、resolution、from/to、gmgn command、fetched_at。
4. 区分 usd_volume 与 token_amount。
5. 输出 current_state，但 allowed_mode 固定 observe_only / research_only。
6. 不下单，不调用 swap，不给买卖建议。
```

建议输出字段：

```text
chain
token_address
resolution
source_provider = gmgn
source_command
fetched_at
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
poc_above_bars
avwap_above_bars
poc_rejected_recently
avwap_rejected_recently
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
```

---

## 6. 仍然未知，禁止脑补

```text
1. GMGN kline 是否足以构建稳定 POC/VAH/VAL，需要样本验证。
2. USD volume 与 token amount 哪个更适合 meme AVWAP，需要消融实验。
3. smart_degen_count 对二次启动是否有预测价值，不得直接假定。
4. GMGN market/trending/trenches/signal 各接口的延迟和缺失率，还未进入工程验证。
5. 自建脚本最终是否执行交易、如何风控、如何路由订单，属于后续 owner decision，不在本文件直接决定。
```

---

## 7. 本版结论

```text
GMGN 可以成为最终自建 meme 交易/扫描/验证系统的数据源主线。

MQL5 观察器中的结构字段有迁移价值，但必须改造成 GMGN 数据字段与自建脚本字段，不能保留 MT5 平台假设。

下一步应创建最小工程切片：GMGN kline → FCZ 状态字段 mapper，而不是继续扩 MQL5 观察器。
```
