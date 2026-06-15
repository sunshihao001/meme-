# MQL5观察指标需求 v0.2

> 分线：H指标规则 / D风险管理 / G样本标注  
> 版本：v0.2  
> 状态：需求升级版 / 观察器需求 / 非自动交易EA  
> 目的：把已完成的策略语义、结构风险评分、POC/AVWAP接受定义、二次启动确认逻辑接入 MQL5 观察指标需求。  

---

## 1. 指标定位

指标名称建议：

```text
FCZ_Cost_Reclaim_Observer.mq5
```

中文名：

```text
第一控盘区成本中枢回收观察器
```

该指标不是：

```text
自动下单EA
买卖信号神器
收益率回测系统
meme链上分析工具
```

该指标是：

```text
结构观察器
状态标注器
成本锚辅助工具
风险评分可视化工具
人工复盘辅助工具
多机器人审查输入工具
```

---

## 2. v0.2相对v0.1的升级

v0.1 主要定义基础绘图和状态观察。

v0.2 新增：

```text
1. 第一控盘区定义接入
2. 深洗 vs 死亡盘判断接入
3. POC / AVWAP 重新接受分级接入
4. 诱多反抽 vs 二次启动区分接入
5. 结构风险评分模型接入
6. JSON/CSV导出字段接入
7. no_trade / observe_only / candidate / second_start_candidate 输出接入
```

---

## 3. 核心模块规划

### Module 1：第一控盘区观察模块

目标：

```text
辅助识别早期成本中枢，而不是自动武断判定。
```

功能：

```text
绘制候选控盘区矩形
计算区间高低点
统计区间K线数量
统计区间成交量占比
计算POC/HVN/VAH/VAL
标注第一波拉升起点
```

输出字段：

```text
first_control_zone_detected
control_zone_high
control_zone_low
control_zone_bars
zone_volume_share
poc_level
vah_level
val_level
first_control_zone_score
```

---

### Module 2：Market Profile / Volume Profile 模块

目标：

```text
把第一控盘区从主观箱体变成可观察的价值区域。
```

功能：

```text
Profile Bins 分箱
计算POC
计算Value Area 70%
标记HVN/LVN
绘制POC/VAH/VAL
```

输出字段：

```text
poc_level
vah_level
val_level
hvn_count
lvn_boundary_detected
poc_position_ratio
profile_bin_count
```

---

### Module 3：AVWAP多锚点模块

目标：

```text
绘制多条结构成本线，辅助判断成本锚重新接受。
```

锚点：

```text
AVWAP_ZoneStart
AVWAP_ImpulseStart
AVWAP_Reclaim
AVWAP_PullbackLow
```

输出字段：

```text
avwap_zonestart
avwap_impulsestart
avwap_reclaim
avwap_pullbacklow
avwap_zonestart_reclaimed
avwap_impulsestart_reclaimed
avwap_confluence_count
best_respected_avwap_anchor
```

---

### Module 4：深洗 / 死亡盘观察模块

目标：

```text
辅助区分健康深洗与死亡盘。
```

功能：

```text
计算第一波回撤比例
标记0.618-0.786深回撤区
标记0.886危险回撤
检测是否跌破VAL/前低
检测Sweep -> Reclaim
检测是否长期无法回收成本区
```

输出字段：

```text
retracement_ratio
deep_washout_detected
sweep_detected
sweep_reclaimed
deep_washout_reclaim_score
death_market_score
```

---

### Module 5：POC / AVWAP重新接受模块

目标：

```text
区分触碰、站回、重新接受、拒绝。
```

状态：

```text
TOUCH_ONLY
RECLAIMED_WEAK
RECLAIMED_MEDIUM
ACCEPTED_STRONG
REJECTED
FAILED_RECLAIM
```

输出字段：

```text
value_area_reentered
poc_reclaimed
avwap_reclaimed
poc_rejected
avwap_rejected
pullback_holds_anchor
cost_anchor_acceptance_score
failed_reclaim_score
```

---

### Module 6：诱多反抽 / 二次启动模块

目标：

```text
判断第一次拉起后，是诱多反抽还是二次启动候选。
```

功能：

```text
标记第一次拉起
标记第一次拉起高点
标记回撤低点
判断回撤是否不破成本锚
判断是否形成higher low
判断是否二次拉升
判断是否BOS
```

输出字段：

```text
first_bounce_detected
first_bounce_failed
higher_low_after_reclaim
second_push_confirmed
bos_after_reclaim
bull_trap_score
second_start_score
structure_confirmation_score
```

---

### Module 7：结构风险评分模块

目标：

```text
把结构审查结果输出为风险分和确认分。
```

风险分：

```text
death_market_score
bull_trap_score
failed_reclaim_score
distribution_score
liquidity_trap_score
narrative_decay_score
```

确认分：

```text
first_control_zone_score
deep_washout_reclaim_score
cost_anchor_acceptance_score
second_start_score
structure_confirmation_score
```

输出分类：

```text
no_trade
observe_only
candidate_for_deeper_review
second_start_candidate
```

---

## 4. 状态机 v0.2

建议状态：

```text
S0_NO_STRUCTURE
S1_FCZ_CANDIDATE
S2_FCZ_CONFIRMED
S3_FIRST_IMPULSE_DONE
S4_DEEP_WASHOUT
S5_SWEEP_RECLAIM
S6_VALUE_AREA_REENTERED
S7_POC_AVWAP_RECLAIMED
S8_FIRST_BOUNCE
S9_PULLBACK_HOLDS_ANCHOR
S10_SECOND_PUSH_CONFIRMED
SX_FAILED_RECLAIM
SX_BULL_TRAP
SX_DEATH_MARKET
SX_DISTRIBUTION_RISK
```

---

## 5. 图表绘制需求

### 5.1 区域绘制

```text
第一控盘区矩形：浅蓝半透明
深回撤区：橙色半透明
危险回撤区：红色半透明
Value Area：淡紫半透明
```

### 5.2 线条绘制

```text
POC：黄色粗线
VAH：绿色虚线
VAL：红色虚线
AVWAP_ZoneStart：蓝色线
AVWAP_ImpulseStart：紫色线
AVWAP_Reclaim：青色线
AVWAP_PullbackLow：灰色线
```

### 5.3 标签绘制

```text
FCZ
POC Reclaimed
AVWAP Reclaimed
Weak Acceptance
Strong Acceptance
Failed Reclaim
Bull Trap Risk
Second Push Candidate
No Trade
```

---

## 6. 输入参数建议

```mql5
input int    InpLookbackBars = 500;
input int    InpATRPeriod = 14;
input bool   InpUseTickVolume = true;
input int    InpProfileBins = 64;
input double InpValueAreaRatio = 0.70;

input int    InpMinControlZoneBars = 10;
input double InpMaxControlZoneATR = 2.5;
input double InpMinZoneVolumeRatio = 0.30;
input double InpMinImpulseZoneMultiple = 1.5;

input double InpDeepRetracementMin = 0.618;
input double InpDeepRetracementMax = 0.786;
input double InpDangerRetracement = 0.886;

input int    InpWeakAcceptanceBars = 1;
input int    InpMediumAcceptanceBars = 3;
input int    InpReclaimTimeoutBars = 3;
input bool   InpShowAVWAPZoneStart = true;
input bool   InpShowAVWAPImpulseStart = true;
input bool   InpShowAVWAPReclaim = true;
input bool   InpShowAVWAPPullbackLow = false;

input double InpSecondPushTolerance = 0.995;
input double InpMinSecondPushVolumeRatio = 1.0;
input bool   InpExportCSV = true;
input bool   InpExportJSON = false;
```

---

## 7. 导出需求

CSV导出字段至少包括：

```text
symbol,timeframe,time,poc_level,vah_level,val_level,
avwap_zonestart,avwap_impulsestart,current_stage,
death_market_score,bull_trap_score,failed_reclaim_score,distribution_score,liquidity_trap_score,
first_control_zone_score,deep_washout_reclaim_score,cost_anchor_acceptance_score,second_start_score,
final_classification,allowed_mode,primary_risk,next_observation
```

---

## 8. 开发阶段规划

### Phase 1：手动辅助绘图版

```text
手动选择第一控盘区
自动计算POC/VAH/VAL
手动选择AVWAP锚点
显示深回撤区
无自动评分
```

### Phase 2：半自动状态标注版

```text
自动识别候选FCZ
自动识别回撤比例
自动判断POC/AVWAP弱/中/强接受
输出当前状态
```

### Phase 3：结构评分导出版

```text
接入风险评分
接入确认评分
导出CSV/JSON
供样本标注和多机器人审查使用
```

### Phase 4：复盘仪表盘版

```text
图表标签 + 评分面板 + 样本导出 + 多周期对比
```

---

## 9. 明确不做

v0.2 不做：

```text
不自动下单
不自动止损止盈
不直接给买卖建议
不接入链上数据
不替代人工确认
```

---

## 10. 本版结论

```text
MQL5观察指标 v0.2 的核心目标，是把策略语义转为可视化结构状态和可导出评分字段，为人工复盘、样本标注、多机器人审查提供统一输入。
```
