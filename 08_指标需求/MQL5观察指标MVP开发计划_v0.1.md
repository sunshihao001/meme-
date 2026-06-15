# MQL5观察指标MVP开发计划 v0.1

> 分线：08_指标需求 / MQL5观察器MVP  
> 状态：v0.1 / TP-010-B 自动切片产物  
> 来源：`08_指标需求/MQL5观察指标需求_v0.2.md`、`08_指标需求/MQL5观察指标字段映射与模块优先级_v0.1.md`、`10_工程化交接/策略完善旧版字段状态机吸收审计_v0.1.md`、旧版 `策略完善_v0.2/MQL5观察指标需求文档_v0.1.md`  
> 目的：把 MQL5 观察器从“完整需求”收敛为一个可交给实现 Agent 的最小可行版本，同时恢复旧版 input 参数表中仍有价值的部分。  
> 边界：观察器 / 状态标注器 / 人工复盘辅助工具；不是自动下单 EA。

---

## 1. MVP 目标

```text
构建一个最小 MQL5 观察指标，用于人工框选第一控盘区，自动计算 POC/VAH/VAL 与基础 AVWAP，显示当前成本锚关系和简化状态，导出 CSV/JSON 给样本标注与后续 Agent 审查。
```

MVP 不追求：

```text
1. 自动识别所有第一控盘区。
2. 自动下单。
3. 自动给买卖信号。
4. 多标的批量扫描。
5. 完整风险评分自动化。
6. 链上数据接入。
```

---

## 2. MVP 模块范围

### P1 必做

```text
1. 手动第一控盘区输入 / 框选。
2. Profile 分箱计算 POC / VAH / VAL。
3. 绘制 POC / VAH / VAL。
4. 绘制 AVWAP_ZoneStart / AVWAP_ImpulseStart。
5. 手动标记第一波高点和深洗低点。
6. 显示 retracement_ratio。
7. 显示 POC/AVWAP 当前关系：below / touch / reclaimed / rejected。
8. 显示简化 current_state。
9. 导出基础 CSV。
```

### P2 后续

```text
1. Sweep/Reclaim 半自动检测。
2. 二次启动结构确认。
3. 风险评分面板。
4. JSON 导出。
5. sample markdown 辅助生成。
```

### P3 暂缓

```text
1. 半自动 FCZ 识别。
2. 多周期 / 多标的批量扫描。
3. 完整状态自动转移。
4. 回测器。
```

---

## 3. MVP 输入参数表

本表恢复旧版 v0.1 中仍有价值的 input 参数，但全部标记为初始观察参数，不作为已验证策略阈值。

### 3.1 基础参数

```mql5
input int    InpLookbackBars = 300;
input int    InpATRPeriod = 14;
input bool   InpUseTickVolume = true;
input bool   InpShowDebugText = true;
input bool   InpExportCSV = true;
```

### 3.2 控盘区 / Profile 参数

```mql5
input int    InpMinControlZoneBars = 10;
input double InpMaxControlZoneATR = 2.5;
input double InpMinZoneVolumeRatio = 0.30;
input int    InpProfileBins = 48;
input double InpValueAreaRatio = 0.70;
```

状态：

```text
absorbed_candidate / needs_sample_validation
```

说明：这些参数来自旧版观察器需求和字段表，只能作为初始默认值；后续必须通过样本和反证校准。

### 3.3 第一波参数

```mql5
input double InpMinImpulseZoneMultiple = 1.5;
input double InpMinImpulseVolumeRatio = 1.2;
```

状态：

```text
needs_validation
```

### 3.4 深回撤参数

```mql5
input double InpDeepRetracementMin = 0.618;
input double InpDeepRetracementMax = 0.786;
input double InpDangerRetracement = 0.886;
```

状态：

```text
semantic_reference_only / not_validated_threshold
```

说明：只用于图表标注和人工复盘，不可直接作为交易触发。

### 3.5 POC / AVWAP 接受参数

```mql5
input int    InpWeakAcceptanceBars = 1;
input int    InpMediumAcceptanceBars = 3;
input int    InpReclaimTimeoutBars = 3;
input bool   InpShowAVWAPZoneStart = true;
input bool   InpShowAVWAPImpulseStart = true;
input bool   InpShowAVWAPReclaim = false;
input bool   InpShowAVWAPPullbackLow = false;
```

MVP 只默认开启：

```text
ZoneStart
ImpulseStart
```

原因：减少图表噪音，先让人工复盘能用。

### 3.6 二次确认参数

```mql5
input double InpSecondPushTolerance = 0.995;
input double InpMinSecondPushVolumeRatio = 1.0;
input double InpStrongSecondPushVolumeRatio = 1.2;
```

状态：

```text
P2 / needs_validation
```

MVP 不自动判定二次启动，只显示必要字段。

### 3.7 风险参数

```mql5
input int InpMaxDistributionScore = 60;
input int InpExtremeDistributionScore = 70;
```

状态：

```text
superseded_by_0_to_3_risk_scores
```

说明：当前项目风险评分已经转为 0-3 结构评分；旧版 0-100 分只作为历史参考，不进入 MVP 默认实现。

---

## 4. MVP 输出字段

CSV 最小字段：

```text
symbol
timeframe
sample_time
fcz_high
fcz_low
fcz_bars
poc_level
vah_level
val_level
avwap_zonestart
avwap_impulsestart
retracement_ratio
poc_relation
avwap_relation
current_state
allowed_mode
positive_evidence
negative_evidence
missing_evidence
```

字段来源：

```text
07_样本标注/样本字段表_v0.1.md
08_指标需求/MQL5观察指标字段映射与模块优先级_v0.1.md
09_规则与回测/状态机规则整合_v0.1.md
```

---

## 5. 简化状态输出

MVP 只输出简化状态，不做完整自动状态机：

```text
STATE_IDLE
STATE_FCZ_MANUAL_MARKED
STATE_PROFILE_READY
STATE_IMPULSE_MARKED
STATE_RETRACEMENT_MARKED
STATE_RECLAIM_OBSERVE
STATE_COST_ANCHOR_ACCEPTED_MANUAL_REVIEW
STATE_NO_TRADE_MANUAL_REVIEW
```

映射原则：

```text
完整 STATE_* 仍以 09_规则与回测/状态机规则整合_v0.1.md 为真源。
MVP 简化状态只为人工复盘和导出服务。
```

---

## 6. 实现切片建议

### Slice 1：手动 FCZ + Profile + POC/VAH/VAL

验收：

```text
用户能在图表上手动指定 FCZ 起止和上下沿。
指标能在该区域内分箱计算 POC/VAH/VAL。
图表能绘制三条水平线。
```

### Slice 2：AVWAP ZoneStart / ImpulseStart

验收：

```text
用户能指定 ZoneStart 和 ImpulseStart。
指标能绘制两条 AVWAP。
```

### Slice 3：深回撤标注

验收：

```text
用户能指定第一波高点和深洗低点。
指标显示 retracement_ratio，并绘制 0.618-0.786 / 0.886 参考区。
```

### Slice 4：关系状态 + CSV 导出

验收：

```text
指标显示 poc_relation、avwap_relation、current_state、allowed_mode。
CSV 文件能导出最小字段。
```

---

## 7. 实现 Agent Handoff 要求

给实现 Agent / Codex 的边界：

```text
1. 只实现观察指标，不实现 EA，不调用交易函数。
2. 禁止 OrderSend / CTrade / 自动下单相关逻辑。
3. 参数默认值是观察默认值，不是交易阈值。
4. CSV 导出仅服务样本标注。
5. 若 MQL5 平台限制导致无法自动绘制/导出，必须写 blocker brief，不得伪造运行结果。
```

---

## 8. 当前下一步

如果继续自动循环代理，下一切片应生成：

```text
10_工程化交接/Codex_handoff_mql5_observer_mvp.md
specs/mql5-observer-mvp/spec.md
specs/mql5-observer-mvp/plan.md
specs/mql5-observer-mvp/tasks.md
specs/mql5-observer-mvp/checklist.md
```

但实际实现前建议先执行：

```text
TP-003 index reference validator
TP-004 sample record markdown validator
```

因为 MVP 依赖索引和样本字段不漂移。
