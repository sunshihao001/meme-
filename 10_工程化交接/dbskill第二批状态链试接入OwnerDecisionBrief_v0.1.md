# dbskill 第二批状态链试接入 Owner Decision Brief v0.1

> 分线：10_工程化交接 / F端 Owner Decision / dbskill  
> 状态：v0.1 / A-F workflow loop task-004 已执行  
> 输入：dbskill第一批三样例效果验证报告_v0.1.md  
> 目的：给 Owner 一个可拍板的决策简报，判断是否允许 dbskill 第二批状态链能力小范围试接入。

---

## 1. Decision needed

```text
是否允许 dbskill 第二批状态链能力进入小范围试接入？
```

第二批包括：

```text
dbs-decision
dbs-save
dbs-restore
dbs-report
```

---

## 2. Recommended default

```text
PARTIAL_ACCEPT_SMALL_SCOPE_BATCH_2_TRIAL
```

含义：

```text
允许小范围试接入，
但只围绕 workflow_loop_state / workflow_loop_queue / Owner Decision Brief / E端汇总报告，
不做全局 runtime，不做整仓安装，不替代正式索引和变更记录。
```

---

## 3. Evidence

已完成：

```text
sample_01_validated
sample_02_validated
sample_03_validated
B端 Source Pack ready
E端效果验证：PARTIAL_PASS_CONTINUE_TO_F_DECISION
```

相关文件：

```text
10_工程化交接/dbskill样例01_自然语言升级与下一阶段路线_v0.1.md
10_工程化交接/dbskill样例02_上下文汇总与自然语言专业化测试_v0.1.md
10_工程化交接/dbskill样例03_外部GitHubSkill局部抽取判断测试_v0.1.md
10_工程化交接/dbskill三样例SourcePack_v0.1.md
10_工程化交接/dbskill第一批三样例效果验证报告_v0.1.md
```

---

## 4. What batch 2 would do

### dbs-decision

试接入范围：

```text
只用于记录 F端 owner decisions、阶段门、是否接受/暂缓/拒绝。
```

### dbs-save

试接入范围：

```text
只用于保存 workflow_loop_state / queue 的快照。
```

### dbs-restore

试接入范围：

```text
只从项目内 state/queue 恢复，不读取未经验证的外部上下文。
```

### dbs-report

试接入范围：

```text
只用于 E/F 端汇总报告，不替代正式索引、变更记录、PR/CI 证据。
```

---

## 5. Alternatives

### A. ACCEPT_SMALL_SCOPE_BATCH_2_TRIAL

```text
允许 D端下一步设计/落库第二批状态链试接入方案。
```

### B. PARTIAL_ACCEPT_MORE_BUSINESS_SAMPLES

```text
要求再补 1-2 个业务/策略样例，再考虑第二批。
```

### C. REVISE_BATCH_1_TEMPLATE

```text
如果觉得前三个样例还偏流程化，先调整第一批模板。
```

### D. REJECT_BATCH_2_FOR_NOW

```text
保持第二批暂缓，只保留第一批自然语言升级能力。
```

---

## 6. Risks

```text
1. 第二批过早接入可能导致过度文档化。
2. save/restore 如果边界不清，会变成混乱记忆系统。
3. report 如果替代正式验证，会降低 E端严谨性。
4. decision 如果替代 Owner 判断，会破坏 F端边界。
```

---

## 7. Guardrails

如果 Owner 允许试接入，必须遵守：

```text
1. 不全量安装 dbskill。
2. 不创建 global runtime 自动触发。
3. 不让 dbs-decision 替代 F端。
4. 不让 save/restore 写到项目 repo 外作为真源。
5. 不让 report 替代 E端验证。
6. 所有状态链试接入必须落到 repo 文件并可验证。
```

---

## 8. Exact action requested

请 Owner 在下面四个选项中选择：

```text
A. ACCEPT_SMALL_SCOPE_BATCH_2_TRIAL
B. PARTIAL_ACCEPT_MORE_BUSINESS_SAMPLES
C. REVISE_BATCH_1_TEMPLATE
D. REJECT_BATCH_2_FOR_NOW
```

推荐默认：

```text
A. ACCEPT_SMALL_SCOPE_BATCH_2_TRIAL
```
