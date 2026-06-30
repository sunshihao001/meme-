# dbskill sample validation loop 运行卡 v0.1

> 分线：10_工程化交接 / dbskill / loop 运行卡  
> 状态：v0.1 / 最小 maker-checker loop  
> 目的：把 dbskill 第一批样例验证从“一问一答文档推进”升级成可持续读取状态、判断下一步、执行、验证、停止或升级的最小循环。

---

## 1. 运行目标

```text
验证 dbskill 第一批四件套是否真的能把普通自然语言输入升级成更清楚、更专业、更可执行的方案。
```

本 loop 不负责：

```text
1. 全量安装 dbskill。
2. 直接进入第二批状态链。
3. 创建全局 runtime 自动触发。
4. 替代 F端 Owner Decision。
```

---

## 2. 状态文件

每轮先读取：

```text
10_工程化交接/dbskill_loop_state_v0.1.yaml
```

关键字段：

```text
status
current_stage
samples
batch_1.status
batch_2.status
next_action
stop_conditions
forbidden
```

---

## 3. 当前状态

```text
sample_01: validated
sample_02: validated
sample_03: needed
batch_2: hold_for_sample_03_and_e_review
next_action: collect_real_business_strategy_or_workflow_input_for_sample_03
```

---

## 4. 每轮运行步骤

### Step 1：A端读取状态

A端先确认：

```text
当前缺口是什么？
是否需要用户输入？
是否可以自动继续？
是否触及禁止事项？
```

当前缺口：

```text
需要 sample_03，一个真实业务/策略/工作流自然语言输入。
```

---

### Step 2：A端判断是否可自动推进

如果已有真实输入：

```text
继续运行 sample_03。
```

如果没有真实输入：

```text
暂停，向 Owner 请求一个真实业务/策略/工作流想法。
```

不能编造样例。

---

### Step 3：A端运行轻量升级

对 sample_03 输入输出：

```text
1. 我理解你真正想说的是
2. 当前想法的限制
3. 专业化升级版本
4. 建议工作流
5. 下一步最小动作
```

必要时展开：

```text
Natural Language to Expert Upgrade Brief
```

---

### Step 4：D端落库

样例03报告建议文件名：

```text
10_工程化交接/dbskill样例03_业务策略工作流自然语言升级测试_v0.1.md
```

落库后更新：

```text
10_工程化交接/dbskill_loop_state_v0.1.yaml
10_工程化交接/dbskill总控汇总卡_v0.1.md
skills/meme-demand-control-port/SKILL.md
知识库索引_v0.1.md
设计规范变更记录.md
```

---

### Step 5：E端验证

当 sample_01/02/03 都存在后，E端生成：

```text
10_工程化交接/dbskill第一批三样例效果验证报告_v0.1.md
```

E端检查：

```text
1. 是否真的提升理解，而不是复述原话？
2. 是否把模糊输入转成可执行路线？
3. 是否没有过度流程化？
4. 是否没有越过 F端决策？
5. 是否能支持进入第二批状态链？
```

---

### Step 6：F端决策

E端通过后，生成 F端 brief：

```text
Decision needed: 是否小范围试接入 dbskill 第二批状态链？
Recommended default: PARTIAL_ACCEPT_CONTINUE / small-scope batch 2 trial
Evidence: sample_01/02/03 + E端验证
Risk: 状态链过早接入导致过度文档化
Rollback: 保持 batch_2 hold，不改变 runtime
Exact action requested: 允许/拒绝试接入 dbs-decision/save/restore/report
```

---

## 5. 停止条件

### 成功

```text
sample_03_validated
E端验证通过
F端决策 brief 生成
```

### 暂停

```text
等待 Owner 提供真实业务/策略/工作流输入。
```

### 返工

```text
E端认为样例输出只是漂亮总结，没有实际升级效果。
```

### 拒绝扩大

```text
三样例不能证明第一批有稳定价值。
```

---

## 6. 禁止事项

```text
1. 禁止编造 sample_03。
2. 禁止未完成 sample_03 就进入第二批。
3. 禁止没有 E端验证就接入 dbs-decision/save/restore/report。
4. 禁止全量安装 dbskill。
5. 禁止创建全局 runtime 自动触发，除非 F端明确授权。
```

---

## 7. 当前下一步

```text
暂停在 sample_03 输入等待状态。
```

需要 Owner 提供一个真实输入，例如：

```text
我想让这个 meme 策略以后能自动判断哪些币值得观察，但我不想直接自动交易，应该怎么设计？
```

拿到真实输入后，本 loop 继续运行 sample_03。
