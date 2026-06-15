# Issue Draft: 补齐 FCZ_B_0001 真实失败样本

> 状态：draft  
> 类型：sample-labeling / research  
> 建议标签：sample-labeling, research, needs-evidence  
> Agent 执行分类：Research first

---

## 1. Goal

补齐 `FCZ_B_0001` 的真实“模型符合但失败”样本，使其不再停留在空壳或待搜状态。

---

## 2. Background

当前样本主线状态：

```text
FCZ_C_0001：当前标准已完成
FCZ_D_0001：当前标准已完成
FCZ_B_0001：继续待搜真实失败样本
```

`FCZ_B_0001` 应服务于反证：即寻找看起来符合第一控盘区 / 深洗 / 成本锚回收条件，但后续失败、诱多或死亡盘的样本。

---

## 3. Scope

```text
1. 搜索并确认一个真实 meme token / chart / GMGN 或其他可复核来源。
2. 写入 FCZ_B_0001 单样本记录。
3. 更新 07_样本标注/反证样本库_v0.1.csv。
4. 保留 source_chart_url / raw_refs / token address / timeframe 等证据。
5. 明确哪些字段仍为 unknown 及原因。
6. 更新索引与变更记录。
7. 运行 validate_all。
```

---

## 4. Non-goals

```text
1. 不自动下单。
2. 不把单一样本推导成策略失败或成功结论。
3. 不伪造缺失图表字段。
4. 不建立全自动样本抓取系统。
```

---

## 5. Acceptance Criteria

```text
- [ ] `07_样本标注/样本记录/FCZ_B_0001.md` 有真实来源和证据链。
- [ ] CSV 中 `FCZ_B_0001` 行已同步关键字段。
- [ ] final_classification 明确，或保留为 candidate_for_deeper_review 并说明原因。
- [ ] 风险评分字段不空漂；无法判断时写 unknown 原因。
- [ ] 索引与变更记录更新。
- [ ] `python scripts/validate_all.py` 通过。
```

---

## 6. Verification Plan

```bash
python scripts/validate_all.py
```

人工检查：

```text
1. source_chart_url 可打开或 raw_refs 可复核。
2. 样本记录中的事实、判断、评分分区清晰。
3. CSV 与单样本记录无明显冲突。
```

---

## 7. Owner Decisions

```text
1. 是否接受该样本作为第一批真实失败样本。
2. 是否允许使用非 GMGN 来源作为辅助证据。
3. 是否进入后续图表派生结构标注。
```
