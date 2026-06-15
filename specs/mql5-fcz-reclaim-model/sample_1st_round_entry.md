# FCZ_B_0001 / FCZ_C_0001 / FCZ_D_0001 样本首轮采样入口

> 位置：`specs/mql5-fcz-reclaim-model/sample_1st_round_entry.md`  
> 类型：样本采样入口 / 调度说明  
> 状态：v0.1

---

## 1. 这份入口做什么

用于把前三个样本从“有骨架”推进到“可接真实图表 / GMGN refs 的首轮采样状态”。

优先级不变：

```text
FCZ_B_0001 > FCZ_C_0001 > FCZ_D_0001
```

---

## 2. 每个样本的首轮填充顺序

### 2.1 FCZ_B_0001

```text
1. 找真实图表或历史复盘图。
2. 填 symbol / chain_or_market / timeframe / sample_start_time / sample_end_time。
3. 保存 GMGN raw refs。
4. 填 first_control_zone_detected / fcz_high / fcz_low / poc_level / vah_level / val_level。
5. 填 first_impulse_done / retracement_ratio / deep_washout_detected / sweep_detected。
6. 填 value_area_reentered / poc_reclaimed / avwap_reclaimed / second_push_confirmed。
7. 填 death_market_score / bull_trap_score / failed_reclaim_score。
8. 填 would_rule_have_triggered_ex_ante / was_boundary_moved_after_outcome / was_anchor_changed_after_outcome。
9. 同步 CSV。
```

### 2.2 FCZ_C_0001

```text
1. 找真实图表或历史复盘图。
2. 填基础信息。
3. 填 GMGN raw refs。
4. 填结构字段，重点标注“未完全符合但大涨”的缺口。
5. 填风险与结果字段。
6. 记录为什么更简单规则可能更早捕捉。
7. 同步 CSV。
```

### 2.3 FCZ_D_0001

```text
1. 找真实图表或历史复盘图。
2. 填基础信息。
3. 填 GMGN raw refs。
4. 填结构字段，重点标注死亡盘 / 派发风险。
5. 填 death_market_score / distribution_score / narrative_decay_score。
6. 记录可疑的二次回收或流动性衰退。
7. 同步 CSV。
```

---

## 3. 每个样本的必填交付物

每个样本至少要有：

```text
1. 一张触发前图。
2. 一张触发时图。
3. 一张触发后结果图。
4. 一份 GMGN 原始 refs 记录。
5. 一份样本记录 Markdown。
6. 一份 CSV 同步记录。
```

如果暂时没有完整材料，允许半成品，但必须在样本记录里写：

```text
sample_source: real_pending
相关截图: pending
```

---

## 4. 首轮采样入口对应的实际文件

```text
07_样本标注/样本记录/FCZ_B_0001.md
07_样本标注/样本记录/FCZ_C_0001.md
07_样本标注/样本记录/FCZ_D_0001.md
```

---

## 5. 本轮建议

先按这个顺序操作：

```text
1. 找 FCZ_B_0001 的真实图表。
2. 再找 FCZ_C_0001。
3. 最后找 FCZ_D_0001。
```

原因：

```text
B 类最能暴露“模型符合但失败”的问题，优先级最高。
```
