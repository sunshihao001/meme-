# GMGN 真实样本采集执行清单 v0.1

> 位置：`07_样本标注/GMGN真实样本采集执行清单_v0.1.md`  
> 分线：样本标注线 / 反证审计线 / 状态机验证线 / GMGN 数据源线  
> 状态：v0.1，执行清单初版  
> 来源：`真实样本采集执行清单_v0.1.md`、`第一批20个反证对照样本采集计划_v0.1.md`、`GMGN样本标注字段扩展_v0.1.md`、`gmgn_requirement_knowledge_base/09_指标与量化准备工作/01_GMGN指标字典.md`。  
> 本轮实际加载 skills：`gmgn-market`、`gmgn-token`、`gmgn-portfolio`、`gmgn-track`、`dbs-good-question`、`dbs-goal`、`dbs-decision`、`dbs-report`。  
> 禁止边界：本文件不涉及 `gmgn-swap`、`gmgn-cooking`、自动下单、止盈止损、私钥或 Codex 实现。

---

## 1. 本文件目的

本文件解决的问题不是“再加一套规则”，而是：

```text
把 GMGN 样本标注 MVP 从字段设计推进到真实样本采集执行。
```

当前阶段需要的是：

```text
1. 能找到真实样本。
2. 能用 GMGN 只读能力拿到证据。
3. 能把样本放进现有状态机。
4. 能把样本同步进 CSV 和单样本记录。
5. 能输出一轮审计摘要。
```

本文件只面向第一批真实样本，不面向完整自动交易。

---

## 2. 第一批真实样本的目标顺序

第一批真实样本优先级：

```text
1. FCZ_B_0001：模型符合但失败
2. FCZ_C_0001：模型不完全符合但大涨
3. FCZ_D_0001：看似符合但死亡盘
```

原因：

```text
先验证最容易推翻模型的样本，再补成功样本。
```

这三类样本最能检验：

```text
- 当前 FCZ 定义是否过宽。
- 成本中枢/重新接受是否真能事前识别。
- deep washout / sweep / reclaim / second start 的组合是否真有价值。
- death market 风险能否提前过滤。
```

---

## 3. 样本来源标准

### 3.1 允许的 GMGN 数据来源

只读能力优先：

```text
gmgn-market
gmgn-token
gmgn-portfolio
gmgn-track
```

建议优先查询路径：

```text
market.trending
market.trenches
market.signal
market.kline
token.info
token.security
token.pool
token.holders
token.traders
track.smartmoney
track.kol
portfolio.stats
portfolio.created-tokens
```

### 3.2 允许的外部补源

如果 GMGN 直接无法给出关键字段，可用以下补源，但必须写入 provenance：

```text
Dexscreener
GeckoTerminal
TradingView 截图
交易所 K 线导出 CSV
MT5 历史数据
手工复盘图
```

### 3.3 禁止来源

```text
1. 事后拼接后变成“看起来像样本”的虚构图。
2. 没有原始 refs 的二手摘要。
3. 用执行层数据反推研究层结论。
4. 用自动交易结果倒推真实触发。
```

---

## 4. 第一批 20 个样本配额

沿用现有反证计划的配额：

```text
B 类：模型符合但失败        6 个
C 类：模型不完全符合但大涨  6 个
D 类：看似符合但死亡盘      4 个
A 类：模型符合且成功        2 个
E 类：定义争议样本          1 个
F 类：不可执行样本          1 个
```

其中，最先要找的是：

```text
FCZ_B_0001 / FCZ_C_0001 / FCZ_D_0001
```

如果短期找不到完整样本，可以先找“半成品样本”，但必须保留 `pending_real_sample` 状态，不能硬填成已完成。

---

## 5. 采集流程 v0.1

### Step 1：从 GMGN 建立候选池

先用 GMGN 找候选，不急着下结论。

操作顺序建议：

1. `gmgn-market trending` 找热度候选
2. `gmgn-market trenches` 找临近毕业 / 新创建候选
3. `gmgn-market signal` 找信号共振候选
4. `gmgn-token info/security/pool` 做基础尽调
5. `gmgn-token holders/traders` 做结构判断
6. `gmgn-track smartmoney/kol` 做跟踪印证

输出候选池字段：

```text
candidate_source
candidate_discovery_time
market_rank_at_discovery
launchpad_stage
market_discovery_confidence
```

---

### Step 2：建立样本是否值得继续的初筛

用 GMGN 只读结果做初筛：

```text
1. 有无硬拒绝（honeypot / 高 rug / 极端 holder 集中 / 可疑税 / 流动性过低）。
2. 有无明显 FCZ 候选。
3. 有无可追溯原始 refs。
4. 有无补源必要。
```

输出：

```text
reject / watch / candidate / needs_manual_review
```

若出现硬拒绝，直接进入 `reject`，不要继续浪费采集时间。

---

### Step 3：截图和原始数据落盘

每个样本至少保存：

```text
1. 触发前截图
2. 触发时截图
3. 触发后结果截图
4. 原始 CSV 或 JSON
5. 查询命令或来源说明
```

目录建议：

```text
07_样本标注/screenshots/FCZ_B_0001_before.png
07_样本标注/screenshots/FCZ_B_0001_trigger.png
07_样本标注/screenshots/FCZ_B_0001_after.png
07_样本标注/raw_data/FCZ_B_0001.csv
07_样本标注/raw_data/FCZ_B_0001_refs.txt
```

如果暂时没有真实文件，也可以先写路径占位，但必须在 notes 标记：

```text
pending_artifacts
```

---

### Step 4：按事前视角填写结构字段

必须先填：

```text
first_control_zone_detected
fcz_high
fcz_low
poc_level
vah_level
val_level
first_impulse_done
retracement_ratio
deep_washout_detected
sweep_detected
sweep_grade
sweep_reclaim_bars
value_area_reentered
poc_reclaimed
avwap_reclaimed
avwap_confluence_count
best_respected_avwap_anchor
pullback_holds_anchor
second_push_confirmed
bos_after_reclaim
death_market_score
bull_trap_score
failed_reclaim_score
```

然后再写：

```text
entry_rule_triggered
triggered_group
max_favorable_excursion_R
max_adverse_excursion_R
gross_realized_R
net_realized_R_after_cost
final_classification
```

---

### Step 5：反证审计

每个真实样本必须明确回答：

```text
1. 事前是否会触发？
2. 失败或大涨是否支持现有规则？
3. 是否事后移动边界或换锚点？
4. 是否说明模型过度保守？
5. 是否说明模型对死亡盘识别不足？
```

必须记录：

```text
would_rule_have_triggered_ex_ante
was_boundary_moved_after_outcome
was_anchor_changed_after_outcome
is_failure_explained_by_new_rule
```

---

### Step 6：同步 CSV 和单样本记录

真实样本不能只填 Markdown，不同步 CSV。

同步顺序：

1. 先写单样本记录 Markdown
2. 再更新 `反证样本库_v0.1.csv`
3. 再更新样本状态机路径
4. 再更新审计结论

如果 CSV 与 Markdown 冲突，以最新人工审核版本为准，但冲突必须写入 notes。

---

### Step 7：输出第一轮审计摘要

完成前三个样本后，生成：

```text
07_样本标注/前三个样本状态机试标注审计报告_v0.1.md
```

审计摘要至少回答：

```text
1. 状态机是否能应用到真实图表？
2. 哪些字段最难填？
3. 哪些定义争议最大？
4. B / C / D 类样本分别挑战哪个核心假设？
5. 是否需要修改状态机？
6. 是否可以继续填剩余 17 个样本？
```

---

## 6. 单样本执行清单

每个样本实际执行时按以下顺序：

```text
1. 选样本 ID。
2. 收集 GMGN 只读结果。
3. 保存 raw refs。
4. 保存截图。
5. 填写 provenance 字段。
6. 填写 market discovery 字段。
7. 填写 security / pool / holder / trader 字段。
8. 填写 FCZ / reclaim / second start / risk 字段。
9. 填写 outcome / audit 字段。
10. 更新 CSV。
11. 更新单样本记录。
12. 在 notes 中记录本样本挑战了什么假设。
```

---

## 7. 本轮默认优先采样策略

### 7.1 B 类优先

优先找：

```text
1. 有明显 FCZ。
2. 站回 POC/AVWAP。
3. 回撤不破或出现二次启动候选。
4. 但后续失败、跌破成本锚、或者进入死亡盘。
```

### 7.2 C 类优先

优先找：

```text
1. 不完全符合当前复合策略。
2. 但后续显著上涨。
3. 简单规则可能更早捕捉。
```

### 7.3 D 类优先

优先找：

```text
1. 早期看起来像第一控盘区。
2. 后续回收但高点下降或流动性枯竭。
3. 最终变成死亡盘。
```

---

## 8. 现阶段最低完成标准

真实样本采集执行清单 v0.1 的可用完成标准：

```text
1. FCZ_B_0001 / FCZ_C_0001 / FCZ_D_0001 至少能各填出一份半成品真实样本。
2. provenance 能追溯。
3. CSV 能同步。
4. 事前/事后边界差异能记录。
5. 至少能产出第一轮审计摘要。
```

---

## 9. 下一步

下一步不是扩规则，而是：

```text
1. 把 GMGN 真实样本采集执行清单接到实际图表。
2. 新建 GMGN 反证样本库字段表。
3. 拿真实样本先填 3 个启动样本。
```

---

## 10. 本版结论

```text
GMGN 真实样本采集的关键，不是“哪里还能多写字段”，而是先把第一批样本从候选池推进到可审计、可回填、可反证的真实状态。
```
