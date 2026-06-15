# 第一控盘区成本中枢回收模型：MQL5观察指标需求文档 v0.1

> 目的：定义一个“观察指标/状态标注器”，不是自动下单EA。  
> 核心任务：在图表上辅助识别第一控盘区、POC、VAH/VAL、AVWAP、深回撤区、二次确认状态和风险提示。  

---

## 1. 指标名称建议

```text
FCZ_Cost_Reclaim_Observer.mq5
```

中文名：

```text
第一控盘区成本中枢回收观察器
```

---

## 2. 指标定位

该指标不是：

```text
自动下单EA
买卖信号神器
单一指标策略
```

该指标是：

```text
结构观察器
状态标注器
成本锚辅助工具
人工复盘工具
多机器人审查输入工具
```

---

## 3. 核心功能模块

```text
1. 第一控盘区识别模块
2. Market Profile / Volume Profile 模块
3. POC / VAH / VAL 绘制模块
4. AVWAP 多锚点模块
5. Fib 深回撤区模块
6. 第一波与回撤结构模块
7. POC / AVWAP 接受判断模块
8. 第一次拉起 / 回撤不破 / 二次拉升模块
9. 成交量确认模块
10. 风险审查模块
11. 状态机显示模块
12. 数据导出模块
```

---

## 4. 输入参数设计

### 4.1 基础参数

```mql5
input int    InpLookbackBars = 300;
input int    InpATRPeriod = 14;
input bool   InpUseTickVolume = true;
input bool   InpShowDebugText = true;
```

### 4.2 控盘区参数

```mql5
input int    InpMinControlZoneBars = 10;
input double InpMaxControlZoneATR = 2.5;
input double InpMinZoneVolumeRatio = 0.30;
input int    InpProfileBins = 48;
input double InpValueAreaRatio = 0.70;
```

### 4.3 第一波参数

```mql5
input double InpMinImpulseZoneMultiple = 1.5;
input double InpMinImpulseVolumeRatio = 1.2;
```

### 4.4 深回撤参数

```mql5
input double InpDeepRetracementMin = 0.618;
input double InpDeepRetracementMax = 0.786;
input double InpDangerRetracement = 0.886;
```

### 4.5 POC / AVWAP 接受参数

```mql5
input int    InpWeakAcceptanceBars = 1;
input int    InpMediumAcceptanceBars = 3;
input int    InpReclaimTimeoutBars = 3;
input bool   InpShowAVWAPZoneStart = true;
input bool   InpShowAVWAPImpulseStart = true;
input bool   InpShowAVWAPReclaim = true;
```

### 4.6 二次确认参数

```mql5
input double InpSecondPushTolerance = 0.995;
input double InpMinSecondPushVolumeRatio = 1.0;
input double InpStrongSecondPushVolumeRatio = 1.2;
```

### 4.7 风险参数

```mql5
input int InpMaxDistributionScore = 60;
input int InpExtremeDistributionScore = 70;
```

---

## 5. 图表绘制需求

### 5.1 第一控盘区

绘制：

```text
矩形区域：control_zone_high 到 control_zone_low
颜色：浅蓝 / 半透明
标签：FCZ 第一控盘区
```

### 5.2 POC / VAH / VAL

绘制：

```text
POC：粗黄色水平线
VAH：绿色虚线
VAL：红色虚线
```

标签：

```text
POC: price
VAH: price
VAL: price
```

### 5.3 AVWAP

绘制：

```text
AVWAP_ZoneStart：白色线
AVWAP_ImpulseStart：紫色线
AVWAP_Reclaim：橙色线
```

### 5.4 Fib 深回撤区

绘制：

```text
0.618 - 0.786 区间：淡黄色矩形
0.886 风险线：红色虚线
```

### 5.5 状态标签

图表右上角显示：

```text
Stage: S7 回撤不破
Branch: healthy_pullback / distribution_retest / bull_trap
Risk: low / medium / high
Confidence: 65
Allowed: observe_only
```

---

## 6. 计算逻辑草案

### 6.1 Profile 计算

```text
1. 在控制区范围内按价格分箱；
2. 将每根K线的 tick_volume 按 high-low 范围分配到价格桶；
3. 找出成交量最高桶作为 POC；
4. 从POC向上下扩展，直到覆盖70%成交量，得到VAH/VAL；
5. 输出 distribution_shape。
```

### 6.2 AVWAP 计算

公式：

```text
TypicalPrice = (High + Low + Close) / 3
AVWAP = Σ(TypicalPrice * Volume) / Σ(Volume)
```

从指定锚点开始累计：

```text
ZoneStart
ImpulseStart
Reclaim
```

### 6.3 回撤比例

```text
retracement_ratio = (impulse_high - pullback_low) / (impulse_high - impulse_start)
```

### 6.4 接受判断

```text
POC weak acceptance: close_above_poc_bars >= 1
POC medium acceptance: close_above_poc_bars >= 3
POC strong acceptance: close_above_poc_bars >= 3 and retest_holds_poc
```

AVWAP 同理。

---

## 7. 状态机输出

指标每根K线更新：

```text
S0 无结构
S1 第一控盘区形成
S2 第一波拉升完成
S3 深回撤测试
S4 POC回收
S5 AVWAP接受
S6 第一次拉起
S7 回撤不破成本锚
S8 二次拉升确认
S9 稳定小段观察区
SX 失效/诱多/派发风险
```

---

## 8. 风险评分草案

```text
distribution_score = 
  upper_wick_score
+ climax_volume_score
+ failed_reclaim_score
+ avwap_lost_score
+ second_push_failure_score
```

初始解释：

```text
0-30：低风险
31-60：中风险
61-70：高风险
70+：极高风险，直接 SX
```

---

## 9. 数据导出需求

导出 CSV 文件到：

```text
MQL5\Files\FCZ_Cost_Reclaim_Observer\
```

每个样本输出：

```text
symbol,timeframe,time,stage,poc,vah,val,avwap_zone,avwap_impulse,avwap_reclaim,retracement_ratio,risk_level,confidence_score
```

同时输出 JSON 快照：

```json
{
  "symbol": "BTCUSDT",
  "timeframe": "M15",
  "stage": "S7",
  "poc": 100.0,
  "vah": 103.0,
  "val": 97.0,
  "avwap_zone": 99.5,
  "retracement_ratio": 0.68,
  "risk_level": "medium",
  "allowed_mode": "observe_only"
}
```

---

## 10. 开发阶段规划

### Phase 1：纯绘图版

```text
手动选择控制区
自动计算POC/VAH/VAL
手动选择AVWAP锚点
显示Fib回撤区
```

### Phase 2：半自动识别版

```text
自动扫描第一控盘区
自动识别第一波和深回撤
自动显示状态 S0-S9
```

### Phase 3：样本导出版

```text
导出CSV/JSON
支持人工标注
用于回测前数据集建设
```

### Phase 4：回测前置版

```text
输出信号事件，但不下单
统计S8/S9后续表现
分析成功/失败样本
```

---

## 11. 暂不开发的内容

当前不做：

```text
自动开仓
自动平仓
资金管理
复杂优化器
机器学习预测
```

原因：

```text
策略语义和状态机还未完全成熟，先做观察和标注更符合保守风格。
```
