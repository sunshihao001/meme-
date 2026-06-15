# Issue Draft: 为 FCZ_C_0001 / FCZ_D_0001 增加图表派生结构标注

> 状态：draft  
> 类型：sample-labeling / structure-review  
> 建议标签：sample-labeling, structure-review, research  
> Agent 执行分类：Research first

---

## 1. Goal

在 `FCZ_C_0001` 与 `FCZ_D_0001` 已完成当前标准字段补齐的基础上，进一步补充可复核的图表派生结构字段。

---

## 2. Background

当前两个样本已经具备基础分类和 CSV 同步状态，但部分结构判断仍停留在低粒度描述。下一步需要把图表观察转化为更稳定的结构字段，服务后续状态机、反证和 validator。

---

## 3. Scope

```text
1. 复核 FCZ_C_0001 / FCZ_D_0001 的 source_chart_url 与 raw_refs。
2. 补充第一控盘区、深洗、回收、二次启动/诱多、死亡盘迹象等图表派生字段。
3. 明确每个派生字段的证据来源与不确定性。
4. 必要时同步 CSV notes / risk 字段。
5. 更新索引与变更记录。
6. 运行 validate_all。
```

---

## 4. Non-goals

```text
1. 不新增交易建议。
2. 不改变已有事实字段，除非发现明确错误。
3. 不把图表主观判断写成自动化信号。
4. 不扩大到所有样本。
```

---

## 5. Acceptance Criteria

```text
- [ ] FCZ_C_0001 结构字段补充完成，并保留 evidence / uncertainty。
- [ ] FCZ_D_0001 结构字段补充完成，并保留 evidence / uncertainty。
- [ ] CSV 如有同步字段已更新。
- [ ] 变更记录更新。
- [ ] `python scripts/validate_all.py` 通过。
```

---

## 6. Verification Plan

```bash
python scripts/validate_all.py
```

人工检查：

```text
1. 图表派生字段没有脱离来源证据。
2. C/D 两类样本的分类逻辑能相互对照。
3. 不确定字段没有被强行确定。
```
