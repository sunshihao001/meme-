# GMGN Real Sample Collection Plan

> 位置：`specs/mql5-fcz-reclaim-model/gmgn_real_sample_collection_plan.md`  
> 类型：采集计划 / 调度入口  
> 状态：v0.1  
> 关联：`07_样本标注/GMGN真实样本采集执行清单_v0.1.md`、`07_样本标注/GMGN反证样本库字段表_v0.1.md`、`07_样本标注/GMGN样本标注字段扩展_v0.1.md`。

---

## 1. Purpose

This plan exists to bridge the gap between field design and actual sample collection.

Current goal:

```text
Get the first three real GMGN samples into a semi-complete, auditable state.
```

Priority order:

```text
1. FCZ_B_0001
2. FCZ_C_0001
3. FCZ_D_0001
```

If a sample is not yet fully available, keep it in `pending_real_sample` rather than inventing evidence.

---

## 2. Inputs

Use these files as source of truth:

```text
07_样本标注/GMGN真实样本采集执行清单_v0.1.md
07_样本标注/GMGN反证样本库字段表_v0.1.md
07_样本标注/GMGN样本标注字段扩展_v0.1.md
07_样本标注/样本字段表_v0.1.md
07_样本标注/第一批20个反证对照样本采集计划_v0.1.md
```

---

## 3. Execution Contract

Each loop should:

```text
1. Identify one sample target.
2. Pull GMGN read-only evidence.
3. Save provenance refs.
4. Fill structure fields.
5. Fill risk / veto fields.
6. Fill outcome / audit fields.
7. Sync CSV + markdown.
8. Update the next observation.
```

Allowed skills for this plan:

```text
gmgn-market
gmgn-token
gmgn-portfolio
gmgn-track
dbs-good-question
dbs-goal
dbs-decision
dbs-report
```

Forbidden:

```text
gmgn-swap
gmgn-cooking
private keys
auto-trading
execution coding
GitHub side effects
```

---

## 4. Exit Criteria

This plan is considered successful when:

```text
1. The first 3 samples reach semi-complete audit state.
2. The CSV schema accepts the new fields.
3. The team can distinguish model failure, over-conservatism, and execution infeasibility.
4. The first audit summary is generated.
```
