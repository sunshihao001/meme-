# MQL5观察器 POC/AVWAP 散乱知识点归并审计 v0.1

> 分线：08_指标需求 / 项目内散乱知识点归并 / MQL5观察器字段审计  
> 状态：v0.1 / TP-012 归并审计小切片  
> 生成时间：2026-06-15 06:25 PDT  
> 目标：把 POC / AVWAP / Market Profile / Volume Profile / VWAP 相关资料包，归并到当前 MQL5 观察器字段、绘制对象、CSV 输出与后续 P2/P3 候选中。  
> 边界：只做观察器字段和样本标注支撑；不新增自动下单、不输出买卖信号、不把未验证阈值升级为策略结论。

---

## 1. 本次主题包

### 1.1 旧/散乱来源

```text
文章库_中文Markdown/市场轮廓与POC价值区域识别.md
文章库_中文Markdown/VWAP成交量加权平均价与外部资金流.md
指标代码库_源码与说明/成交量分布VolumeProfile指标_说明.md
指标代码库_源码与说明/市场轮廓MarketProfile指标_说明.md
指标代码库_源码与说明/日内VWAP指标_说明.md
指标代码库_源码与说明/多日动态VWAP指标_说明.md
多语言关键词补充资料/EN_自定义TPO市场轮廓加入成交量POC价值区域VWAP.md
多语言关键词补充资料/EN_价格直方图市场轮廓MQL5实现.md
多语言关键词补充资料/ES_价格直方图市场轮廓MQL5实现.md
多语言关键词补充资料/RU_市场轮廓MarketProfile.md
```

### 1.2 当前已吸收真源

```text
06_资料吸收/资料吸收_MarketProfile_POC_价值区域_v0.1.md
06_资料吸收/资料吸收_VolumeProfile_HVN_POC_v0.1.md
06_资料吸收/资料吸收_VWAP成本锚与确认机制_v0.1.md
06_资料吸收/资料吸收_AVWAP锚点选择_v0.1.md
03_语义概念/POC与AVWAP重新接受定义_v0.1.md
08_指标需求/MQL5观察指标字段映射与模块优先级_v0.1.md
08_指标需求/MQL5观察指标MVP开发计划_v0.1.md
mql5/indicators/FCZ_Cost_Reclaim_Observer.mq5
```

---

## 2. 审计结论摘要

```text
1. POC / VAH / VAL / value_area_ratio 已进入 MVP，并已在源码中实现 Profile 分箱计算与水平线绘制。
2. AVWAP_ZoneStart / AVWAP_ImpulseStart 已进入 MVP，并已在源码中实现计算、绘制与 CSV 导出。
3. AVWAP_Reclaim / AVWAP_PullbackLow 暂未进入源码，当前应保持 P2/P3 observer_candidate，不应强行加入 P1。
4. HVN / LVN / poc_position_ratio / zone_volume_share 等字段已在资料吸收和字段映射中出现，但当前源码未实现；应作为下一轮候选字段，而不是当前成功项。
5. 当前源码中的 POC/AVWAP relation 只有 below / touch / reclaimed / not_available，尚未表达 rejected / accepted_medium / accepted_strong / pullback_hold。
6. 当前 CSV 输出已覆盖 MVP 最小字段，但尚未覆盖 profile 质量字段、AVWAP 多锚点共振字段和确认 bars 字段。
```

---

## 3. 字段归并矩阵

| 来源概念 | 当前项目含义 | 当前源码状态 | 建议归并状态 | 说明 |
|---|---|---|---|---|
| Market Profile | 价格接受区 / 价值区域 | 部分实现 | integrated | 通过 FCZ 区间内分箱近似计算 POC/VAH/VAL，但非完整 TPO profile |
| Value Area | 第一控盘区的价值接受范围 | 实现 | integrated | `InpValueAreaRatio` 默认 0.70，输出 `vah_level` / `val_level` |
| POC | FCZ 内核心成本锚 | 实现 | integrated | 输出 `poc_level`，绘制 POC 水平线 |
| VAH | 价值区域上边界 | 实现 | integrated | 输出 `vah_level`，绘制 VAH 水平线 |
| VAL | 价值区域下边界 | 实现 | integrated | 输出 `val_level`，绘制 VAL 水平线 |
| Volume Profile bins | 成交量分布分箱 | 实现 | integrated | `InpProfileBins` 默认 48；当前按 typical price + tick_volume 近似 |
| HVN count | 高成交节点数量 | 未实现 | observer_candidate | 已在字段映射中出现；需要更细 profile 算法，不进 P1 |
| LVN boundary | 低成交边界 / 快速穿越区 | 未实现 | observer_candidate / needs_sample_validation | 可服务深洗快速回收观察，但需样本验证 |
| zone_volume_share | FCZ 成交占比 | 未实现 | observer_candidate | 可作为 FCZ 质量字段；源码已有 `totalVol` 变量但未输出比例 |
| poc_position_ratio | POC 在区间内的位置 | 未实现 | observer_candidate | 用于判断 POC 是否贴边；建议下一轮低风险加入 |
| VWAP | 成交量加权平均价 | 公式实现为 AVWAP 子集 | partially_integrated | 当前使用从指定 shift 到当前的 anchored VWAP，不实现日内普通 VWAP |
| AVWAP_ZoneStart | FCZ 起点成本锚 | 实现 | integrated | `InpShowAVWAPZoneStart` 默认 true，绘制并导出 `avwap_zonestart` |
| AVWAP_ImpulseStart | 第一波启动成本锚 | 实现 | integrated | `InpShowAVWAPImpulseStart` 默认 true，绘制并导出 `avwap_impulsestart` |
| AVWAP_Reclaim | 回收后新资金成本 | 未实现 | observer_candidate / P2 | MVP 文档默认关闭；需要确认 reclaim bar，不宜 P1 自动化 |
| AVWAP_PullbackLow | 深洗低点反弹成本 | 未实现 | observer_candidate / P2 | MVP 文档默认关闭；需人工低点或后续检测支持 |
| AVWAP confluence | 多锚点共振 | 未实现 | needs_sample_validation | 可能有价值，但容易把视觉共振误判成规则结论 |
| VWAP confirmation bars | 连续站上确认 | 未实现 | needs_sample_validation | 旧文档中的 weak/medium bars 仍是候选阈值 |
| rejected relation | 站回失败/被压制 | 未实现 | recommended_next_slice | 当前 `RelationToLevel` 不能判断历史失败，只判断当前价位置 |
| accepted_medium/strong | 连续站上 + 回踩不破 | 未实现 | recommended_after_rejected | 需要 bars/history 逻辑；不建议先于 rejected 字段实现 |

---

## 4. 当前源码对照

### 4.1 已实现的绘制对象

源码：`mql5/indicators/FCZ_Cost_Reclaim_Observer.mq5`

```text
FCZ rectangle：`FCZ_OBSERVER_FCZ`
POC：`FCZ_OBSERVER_POC`
VAH：`FCZ_OBSERVER_VAH`
VAL：`FCZ_OBSERVER_VAL`
AVWAP ZoneStart：`FCZ_OBSERVER_AVWAP_ZONE_START`
AVWAP ImpulseStart：`FCZ_OBSERVER_AVWAP_IMPULSE_START`
Retracement 0.618：`FCZ_OBSERVER_RETRACE_0618`
Retracement 0.786：`FCZ_OBSERVER_RETRACE_0786`
Retracement 0.886：`FCZ_OBSERVER_RETRACE_0886`
Status label：`FCZ_OBSERVER_STATUS`
```

### 4.2 已实现的 CSV 字段

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

### 4.3 当前 relation 逻辑边界

当前源码：

```text
RelationToLevel(price, level, tolerance)
→ touch / reclaimed / below / not_available
```

它不能表达：

```text
rejected：曾经触碰或站上后被压回
accepted_medium：连续站上 N 根
accepted_strong：站上后回踩不破
failed_reclaim：N 根内无法收回
```

所以当前 `poc_relation` / `avwap_relation` 更准确叫：

```text
current_price_relation_to_level
```

而不是完整的“重新接受判断”。

---

## 5. 不应吸收 / 暂缓吸收项

### 5.1 不应进入当前 MVP 的内容

```text
自动下单逻辑
买卖信号文字
收益评分
多标的扫描
完整自动 FCZ 识别
自动判断最受尊重 AVWAP
把 HVN/LVN 直接转成交易触发
```

原因：

```text
当前项目定位仍是观察器 / 样本标注器 / 反证工具；不是 EA 或自动交易系统。
```

### 5.2 暂缓吸收项

```text
AVWAP_Reclaim
AVWAP_PullbackLow
AVWAP confluence_count
hvn_count
lvn_boundary_detected
poc_reaction_count
retest_volume_response
accepted_medium / accepted_strong
```

暂缓原因：

```text
1. 需要更多历史 bars 或人工事件点。
2. 需要真实样本验证阈值。
3. 过早加入会让 MVP 从观察器膨胀成伪信号器。
```

---

## 6. 推荐下一最小工程切片

优先级最高的下一步不是继续加复杂自动识别，而是补一个低风险、可验证、不会变成交易信号的小字段包：

```text
TP-013：MQL5观察器 Profile 质量字段补齐
```

建议只新增：

```text
profile_bin_count
poc_position_ratio
zone_tick_volume_sum
```

不新增：

```text
hvn_count
lvn_boundary_detected
accepted_medium
accepted_strong
automatic_entry_signal
```

原因：

```text
1. `profile_bin_count` 已由 InpProfileBins 直接得到。
2. `poc_position_ratio = (poc_level - fcz_low) / (fcz_high - fcz_low)`，低风险、可解释。
3. `zone_tick_volume_sum` 源码已有 totalVol，可直接导出，服务样本审计。
4. 三者都不构成买卖信号，只增强样本质量。
```

### 6.1 TP-013 验收标准

```text
1. 源码编译 0 errors / 0 warnings。
2. CSV header 增加 profile_bin_count / poc_position_ratio / zone_tick_volume_sum。
3. 状态标签可选显示 poc_position_ratio，但不改变 allowed_mode。
4. 项目 validate_all 通过。
5. 若安装到 MT5 数据目录，仍明确 GUI chart confirmation 需要人工确认。
```

---

## 7. 本版结论

```text
POC / AVWAP / Market Profile / VWAP 资料包不是没有吸收；它们已经进入概念层、MVP需求和当前源码的 P1 观察器核心。

当前缺口主要是 profile 质量字段和更细的接受/拒绝历史关系，而不是更多交易逻辑。

下一步应以 TP-013 小切片补齐 profile 质量字段，继续保持观察器边界。
```
