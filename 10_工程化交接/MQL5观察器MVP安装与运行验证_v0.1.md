# MQL5观察器MVP安装与运行验证 v0.1

> 分线：10_工程化交接 / MQL5观察器MVP验证  
> 状态：v0.1 / 自动循环代理继续验证记录  
> 目标文件：`mql5/indicators/FCZ_Cost_Reclaim_Observer.mq5`  
> 验证时间：2026-06-15 04:10 PDT  
> 边界：观察器安装、编译、可挂载准备；不声明已完成人工图表视觉确认。

---

## 1. 本轮继续目标

从上轮真实停止点继续：

```text
代码已写
MetaEditor 已编译通过
CI 已通过
图表挂载运行验证：未完成，属于下一真实验证环节
```

本轮执行目标：

```text
1. 补齐 MVP 中尚未落地的可视元素和 CSV 字段缺口。
2. 重新真实编译。
3. 将 `.mq5` / `.ex5` 安装到当前 MT5 数据目录的 Indicators 路径。
4. 尝试推进 GUI / 图表挂载验证；若无法无头完成，记录 blocker 而不是伪造通过。
```

---

## 2. 源码补强内容

更新：

```text
mql5/indicators/FCZ_Cost_Reclaim_Observer.mq5
```

补强项：

```text
1. AVWAP ZoneStart 水平线绘制：FCZ_OBSERVER_AVWAP_ZONE_START
2. AVWAP ImpulseStart 水平线绘制：FCZ_OBSERVER_AVWAP_IMPULSE_START
3. retracement 参考线绘制：0.618 / 0.786 / 0.886
4. poc_relation 从二元 above/below 改为 below / touch / reclaimed
5. avwap_relation 从 above_zonestart/below_zonestart 改为 below / touch / reclaimed / not_available
6. CSV 增加 `fcz_bars` 字段，与 MVP 输出字段表对齐
```

仍然保持：

```text
无 CTrade
无 OrderSend
无自动下单
无买卖建议
allowed_mode = observe_only
```

---

## 3. 真实 MetaEditor 重新编译

命令：

```bash
'/c/Program Files/MetaTrader 5/MetaEditor64.exe' \
  /compile:'C:\Users\Administrator\Documents\MQL5_第一控盘区成本中枢回收模型_学习资料\mql5\indicators\FCZ_Cost_Reclaim_Observer.mq5' \
  /log:'C:\Users\Administrator\Documents\MQL5_第一控盘区成本中枢回收模型_学习资料\mql5\indicators\compile.log'
```

结果：

```text
Result: 0 errors, 0 warnings, 919 ms elapsed, cpu='X64 Regular'
```

编译产物：

```text
mql5/indicators/FCZ_Cost_Reclaim_Observer.ex5
```

注意：

```text
`.ex5` 和 compile.log 是本地验证产物，不进入 Git；项目 `.gitignore` 已覆盖 `*.ex5` / `*.log`。
```

---

## 4. 安装到当前 MT5 数据目录

发现当前 MT5 数据目录：

```text
C:/Users/Administrator/AppData/Roaming/MetaQuotes/Terminal/D0E8209F77C8CF37AD8BF550E51FF075/
```

已复制：

```text
源：mql5/indicators/FCZ_Cost_Reclaim_Observer.mq5
目标：C:/Users/Administrator/AppData/Roaming/MetaQuotes/Terminal/D0E8209F77C8CF37AD8BF550E51FF075/MQL5/Indicators/FCZ_Cost_Reclaim_Observer.mq5

源：mql5/indicators/FCZ_Cost_Reclaim_Observer.ex5
目标：C:/Users/Administrator/AppData/Roaming/MetaQuotes/Terminal/D0E8209F77C8CF37AD8BF550E51FF075/MQL5/Indicators/FCZ_Cost_Reclaim_Observer.ex5
```

文件存在证据：

```text
-rw-r--r-- ... 22840 ... MQL5/Indicators/FCZ_Cost_Reclaim_Observer.ex5
-rw-r--r-- ...  9555 ... MQL5/Indicators/FCZ_Cost_Reclaim_Observer.mq5
```

---

## 5. GUI / 图表挂载验证状态

已检查：

```text
C:/Program Files/MetaTrader 5/terminal64.exe 存在
C:/Users/Administrator/AppData/Roaming/MetaQuotes/Terminal/D0E8209F77C8CF37AD8BF550E51FF075/MQL5/Profiles/Charts/Default/chart01.chr 存在
```

但当前未完成：

```text
1. 自动打开 MT5 GUI 图表并挂载指标。
2. 人工视觉确认 FCZ 矩形、POC/VAH/VAL、AVWAP、retracement 线、状态标签。
3. 运行后确认 MQL5/Files/FCZ_Observer_latest.csv 真实生成。
```

阻塞原因：

```text
当前 Hermes 工具可执行 MetaEditor 编译、文件安装和文件系统检查，但没有稳定的 MT5 GUI 图表挂载/视觉确认通道。
MT5 `.chr` 图表配置为 UTF-16 文本，但自动写入图表配置并强制加载自定义指标存在破坏用户现有图表模板的风险；本轮不通过篡改图表文件来伪造挂载成功。
```

因此本轮状态是：

```text
compiled: yes
installed_to_mt5_data_dir: yes
manual_chart_visual_confirmation: blocked_by_gui_access
csv_runtime_generation: pending_manual_chart_run
```

---

## 6. 手工验证步骤

Owner 或有桌面控制能力的 Agent 可执行：

```text
1. 打开 MetaTrader 5。
2. 在 Navigator / Indicators 中刷新或重启 MT5。
3. 找到 FCZ_Cost_Reclaim_Observer。
4. 将其挂载到任意有历史数据的图表。
5. 保持默认参数，确认图表上出现：
   - FCZ_OBSERVER_FCZ 矩形
   - POC / VAH / VAL 水平线
   - AVWAP_ZONE_START / AVWAP_IMPULSE_START 水平线
   - RETRACE_0618 / RETRACE_0786 / RETRACE_0886 水平线
   - 右上角状态标签
6. 检查：
   C:/Users/Administrator/AppData/Roaming/MetaQuotes/Terminal/D0E8209F77C8CF37AD8BF550E51FF075/MQL5/Files/FCZ_Observer_latest.csv
```

若 CSV 存在，应至少包含字段：

```text
symbol,timeframe,sample_time,fcz_high,fcz_low,fcz_bars,poc_level,vah_level,val_level,avwap_zonestart,avwap_impulsestart,retracement_ratio,poc_relation,avwap_relation,current_state,allowed_mode,positive_evidence,negative_evidence,missing_evidence
```

---

## 7. TP-013 Profile 质量字段补齐追加记录

追加时间：2026-06-15 06:29 PDT

本次源码追加：

```text
profile_bin_count
poc_position_ratio
zone_tick_volume_sum
```

追加原因：

```text
1. 三个字段只增强 Profile / FCZ 质量审计，不构成交易信号。
2. `poc_position_ratio` 可帮助识别 POC 是否贴近区间边缘。
3. `zone_tick_volume_sum` 可让样本记录知道 FCZ 区间内 tick volume 总量。
4. `profile_bin_count` 让 CSV 记录保留 Profile 计算参数。
```

真实重新编译结果：

```text
Result: 0 errors, 0 warnings, 1578 ms elapsed, cpu='X64 Regular'
```

重新安装到 MT5 数据目录：

```text
C:/Users/Administrator/AppData/Roaming/MetaQuotes/Terminal/D0E8209F77C8CF37AD8BF550E51FF075/MQL5/Indicators/FCZ_Cost_Reclaim_Observer.mq5
C:/Users/Administrator/AppData/Roaming/MetaQuotes/Terminal/D0E8209F77C8CF37AD8BF550E51FF075/MQL5/Indicators/FCZ_Cost_Reclaim_Observer.ex5
```

安装文件存在证据：

```text
FCZ_Cost_Reclaim_Observer.ex5 size=23990
FCZ_Cost_Reclaim_Observer.mq5 size=10068
```

边界不变：

```text
compiled: yes
installed_to_mt5_data_dir: yes
manual_chart_visual_confirmation: blocked_by_gui_access
csv_runtime_generation: pending_manual_chart_run
```

追加后的 CSV 字段应至少包含：

```text
symbol,timeframe,sample_time,fcz_high,fcz_low,fcz_bars,poc_level,vah_level,val_level,profile_bin_count,poc_position_ratio,zone_tick_volume_sum,avwap_zonestart,avwap_impulsestart,retracement_ratio,poc_relation,avwap_relation,current_state,allowed_mode,positive_evidence,negative_evidence,missing_evidence
```

---

## 8. TP-014 POC/AVWAP 只读历史关系字段追加记录

追加时间：2026-06-15 06:35 PDT

本次源码追加：

```text
InpRelationLookbackBars = 10
poc_above_bars
avwap_above_bars
poc_rejected_recently
avwap_rejected_recently
```

追加原因：

```text
1. 让观察器能导出最小历史关系字段，区分“当前在水平线上方”与“最近是否被该水平压回”。
2. 字段保持只读观察性质，不输出 accepted_strong / entry_signal。
3. rejected_recently 只代表 lookback 范围内曾经 high >= level 且 close < level，并且当前 close < level；不是交易结论。
4. above_bars 只统计从当前 K 开始连续收在水平线上的 bar 数，不做阈值判定。
```

真实重新编译结果：

```text
Result: 0 errors, 0 warnings, 753 ms elapsed, cpu='X64 Regular'
```

重新安装到 MT5 数据目录：

```text
C:/Users/Administrator/AppData/Roaming/MetaQuotes/Terminal/D0E8209F77C8CF37AD8BF550E51FF075/MQL5/Indicators/FCZ_Cost_Reclaim_Observer.mq5
C:/Users/Administrator/AppData/Roaming/MetaQuotes/Terminal/D0E8209F77C8CF37AD8BF550E51FF075/MQL5/Indicators/FCZ_Cost_Reclaim_Observer.ex5
```

安装文件存在证据：

```text
FCZ_Cost_Reclaim_Observer.ex5 size=26722
FCZ_Cost_Reclaim_Observer.mq5 size=12278
```

边界不变：

```text
compiled: yes
installed_to_mt5_data_dir: yes
manual_chart_visual_confirmation: blocked_by_gui_access
csv_runtime_generation: pending_manual_chart_run
```

追加后的 CSV 字段应至少包含：

```text
symbol,timeframe,sample_time,fcz_high,fcz_low,fcz_bars,poc_level,vah_level,val_level,profile_bin_count,poc_position_ratio,zone_tick_volume_sum,poc_above_bars,avwap_above_bars,poc_rejected_recently,avwap_rejected_recently,avwap_zonestart,avwap_impulsestart,retracement_ratio,poc_relation,avwap_relation,current_state,allowed_mode,positive_evidence,negative_evidence,missing_evidence
```

---

## 9. 本版结论

本轮把 MQL5 观察器 MVP 从“只编译通过”推进到：

```text
源码补强 → 重新编译 0 errors / 0 warnings → 安装到当前 MT5 数据目录 → 明确 GUI 挂载 blocker
```

没有把 GUI 视觉确认伪报为完成。

下一步若继续自动循环代理，推荐转入：

```text
TP-003 index reference validator
```

原因：MQL5 GUI 挂载需要人工/桌面能力；在此 blocker 未解除前，继续做工程质量门比继续堆观察器功能更可验证。
