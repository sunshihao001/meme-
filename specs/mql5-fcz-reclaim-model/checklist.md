# Checklist

> Feature / Project：mql5-fcz-reclaim-model  
> Stage：需求拷问斗 / clarification hard gate  
> Status：v0.1  
> Purpose：检查当前需求拷问斗是否满足进入后续 Good Question Brief / spec 的最低条件。

---

## 1. Clarification Artifacts

```text
[x] clarification.md 已生成。
[x] demand_grilling_brief.md 已生成。
[x] demand_control_loop.md 已生成。
[x] good_question_brief.md 已生成。
[x] decisions.md 已生成。
```

---

## 2. Goal / Users / Non-goals

```text
[x] Goal 已明确：短中期 1 + 2，长期 3。
[x] Users 已排序：Owner / AI Agent / 未来自动交易系统 / 未来普通用户。
[x] Non-goals 已明确：不做自动下单、不承诺收益、不直接进入 Codex、不直接正式回测。
```

---

## 3. Assumptions / Risks

```text
[x] H1-H7 核心假设已列出。
[x] F1-F8 失败模式已列出。
[x] 明确模型必须接受反证、消融、可执行性和回测结果检验。
```

---

## 4. Route Decision

```text
[x] 方案比较已完成。
[x] Owner 已确认路线：先 A 研究库，再 B 观察器，最后 C 回测原型。
[x] Hard gate 已写明：未完成 A 不进入 B，未完成 B 不进入 C。
```

---

## 5. Codex / Spec Gate

```text
[x] 当前不进入 Codex。
[x] 当前不写自动交易实现。
[x] 当前不把未决策略定义写成执行规则。
[x] Codex 边界已写入 decisions.md。
```

---

## 6. Repository Maintenance

```text
[x] 知识库索引已更新。
[x] 设计规范变更记录已更新。
[x] python scripts/validate_all.py 已通过。
```

验证输出：

```text
Ran 15 tests in 0.068s
OK
OK: sample CSV schema valid (58 columns; real=反证样本库_v0.1.csv; simulated=模拟反证样本库_v0.1.csv)
OK: sample CSV state paths valid
OK: all project validation checks passed
```

---

## 7. Completion Rule

本 checklist 只有在以下全部满足后，才算完成：

```text
1. clarification.md 存在。
2. demand_grilling_brief.md 存在。
3. demand_control_loop.md 存在。
4. good_question_brief.md 存在。
5. decisions.md 存在。
6. 索引引用新增文件。
7. 变更记录记录本阶段。
8. validate_all.py 通过。
```
