# MQL5观察指标字段映射与模块优先级 v0.1

> 分线：H指标规则 / D风险管理  
> 版本：v0.1  
> 状态：字段映射初版  
> 目的：把结构评分字段映射到 MQL5 观察指标模块，并确定开发优先级。  

---

## 1. 模块优先级

| 优先级 | 模块 | 原因 |
|---|---|---|
| P1 | 手动第一控盘区 + POC/VAH/VAL | 策略根基，先保证人工可用 |
| P1 | AVWAP多锚点绘制 | 成本锚观察核心 |
| P1 | POC/AVWAP接受状态 | 策略核心判断 |
| P1 | 状态机显示 | 复盘必须知道当前阶段 |
| P2 | 深洗/Sweep/Reclaim检测 | 用于区分深洗与死亡盘 |
| P2 | 二次启动结构确认 | 判断回撤不破与二次拉升 |
| P2 | 风险评分面板 | 接入结构审查框架 |
| P3 | CSV/JSON导出 | 后续样本标注和机器人审查 |
| P3 | 半自动FCZ识别 | 较难，需样本校准 |
| P4 | 多周期/多标的批量扫描 | 后续扩展 |

---

## 2. 字段到模块映射

### 第一控盘区模块

```text
first_control_zone_detected
control_zone_high
control_zone_low
control_zone_bars
zone_volume_share
first_control_zone_score
```

### Profile模块

```text
poc_level
vah_level
val_level
hvn_count
lvn_boundary_detected
poc_position_ratio
profile_bin_count
```

### AVWAP模块

```text
avwap_zonestart
avwap_impulsestart
avwap_reclaim
avwap_pullbacklow
avwap_zonestart_reclaimed
avwap_impulsestart_reclaimed
avwap_confluence_count
```

### 深洗模块

```text
retracement_ratio
deep_washout_detected
sweep_detected
sweep_reclaimed
deep_washout_reclaim_score
death_market_score
liquidity_trap_score
```

### 成本锚接受模块

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

### 二次启动模块

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

### 输出模块

```text
final_classification
allowed_mode
confidence_level
primary_risk
primary_confirmation
positive_evidence
negative_evidence
missing_evidence
next_observation
```

---

## 3. 评分到颜色映射

### 风险分颜色

```text
0：灰色 / 无明显风险
1：浅黄 / 轻微风险
2：橙色 / 中等风险
3：红色 / 高风险
```

### 确认分颜色

```text
0：灰色 / 无确认
1：浅蓝 / 弱确认
2：蓝色 / 中等确认
3：绿色 / 强确认
```

### 输出分类颜色

```text
no_trade：红色
observe_only：灰色
candidate_for_deeper_review：黄色
second_start_candidate：绿色
```

---

## 4. 第一阶段最小可用版本 MVP

MVP 只做：

```text
1. 手动框选第一控盘区
2. 自动计算 POC / VAH / VAL
3. 绘制 AVWAP_ZoneStart / AVWAP_ImpulseStart
4. 手动标记第一波高点和深洗低点
5. 显示回撤比例
6. 显示 POC/AVWAP 当前关系：below / touch / reclaimed / rejected
7. 手动/半自动输出 current_stage
8. 导出基础CSV
```

MVP 不做：

```text
自动识别所有阶段
自动给出交易建议
自动评分全部风险
链上数据接入
```

---

## 5. 后续接入评分的顺序

```text
Step 1：first_control_zone_score
Step 2：cost_anchor_acceptance_score
Step 3：failed_reclaim_score
Step 4：death_market_score
Step 5：bull_trap_score
Step 6：second_start_score
Step 7：final_classification
```

---

## 6. 导出文件建议

```text
MQL5/Files/FCZ_Observer/samples.csv
MQL5/Files/FCZ_Observer/latest_signal.json
MQL5/Files/FCZ_Observer/debug_log.txt
```

---

## 7. 当前结论

```text
观察指标应先服务人工复盘和样本标注，不应一开始追求完全自动识别。先手动+半自动，把字段和状态跑通，再逐步自动化。
```
