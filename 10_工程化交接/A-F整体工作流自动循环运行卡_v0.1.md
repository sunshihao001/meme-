# A-F整体工作流自动循环运行卡 v0.1

> 分线：10_工程化交接 / 整体工作流 loop  
> 状态：v0.1 / 手动触发的最小整体 loop  
> 目的：让 A-F 多端口不再只是文档化职责，而能按统一 state/queue 读取任务、判断下一端、执行、验证、决策和继续。

---

## 1. 运行入口

每轮先读取两个文件：

```text
10_工程化交接/workflow_loop_state_v0.1.yaml
10_工程化交接/workflow_loop_queue_v0.1.yaml
```

然后执行：

```text
读取状态 → 读取队列 → 找到 P0 可执行任务 → 判断端口 → 执行最小动作 → 更新状态 → 验证或暂停
```

---

## 2. 当前整体状态

```text
loop_id: af-workflow-loop-v0.1
status: running
mode: manual_triggered_minimal_loop
current_stage: INTAKE
current_port: A
current_task_id: task-001-collect-dbskill-sample-03
```

当前阻塞点：

```text
等待 Owner 提供一个真实业务/策略/工作流自然语言想法，用作 sample_03。
```

---

## 3. 端口职责

```text
A：读取状态、澄清任务、判断 next_port、控制循环
B：把样例/资料压缩成 source pack
C：把通过的输入生成方案/理论/第二批接入设计
D：落库、更新状态、提交 git
E：独立验证 maker 产物是否真的有效
F：决定是否授权进入下一阶段或扩大接入
```

---

## 4. 整体循环步骤

### Step 1：A端读取 state/queue

检查：

```text
current_task_id
current_stage
next_action
blocked_by
forbidden
```

---

### Step 2：A端选择 P0 任务

当前 P0：

```text
task-001-collect-dbskill-sample-03
```

如果任务需要 Owner 输入：

```text
暂停并请求输入，不编造。
```

---

### Step 3：A端执行自然语言升级

拿到 sample_03 后，运行：

```text
Natural Language to Expert Upgrade Brief
```

输出至少包括：

```text
1. 我理解你真正想说的是
2. 当前想法的限制
3. 专业化升级版本
4. 建议工作流
5. 下一步最小动作
```

---

### Step 4：D端落库

生成：

```text
10_工程化交接/dbskill样例03_业务策略工作流自然语言升级测试_v0.1.md
```

更新：

```text
workflow_loop_state_v0.1.yaml
workflow_loop_queue_v0.1.yaml
dbskill_loop_state_v0.1.yaml
dbskill总控汇总卡_v0.1.md
skills/meme-demand-control-port/SKILL.md
知识库索引_v0.1.md
设计规范变更记录.md
```

---

### Step 5：B端整理 Source Pack

当 sample_01/02/03 都存在后，B端生成：

```text
10_工程化交接/dbskill三样例SourcePack_v0.1.md
```

内容：

```text
1. 三个输入原话
2. 三个专业化升级结果
3. 每个样例触发了哪些 dbskill 能力
4. 共同模式
5. 问题与风险
```

---

### Step 6：E端验证

E端生成：

```text
10_工程化交接/dbskill第一批三样例效果验证报告_v0.1.md
```

验证：

```text
是否真的提升理解
是否真的提升专业化表达
是否真的产生可执行路线
是否没有过度流程化
是否保护 F端决策边界
```

---

### Step 7：F端决策

E端通过后，生成：

```text
10_工程化交接/dbskill第二批状态链试接入OwnerDecisionBrief_v0.1.md
```

F端只需决定：

```text
ACCEPT_SMALL_SCOPE_BATCH_2_TRIAL
PARTIAL_ACCEPT_MORE_SAMPLES
REVISE_BATCH_1_TEMPLATE
REJECT_BATCH_2_FOR_NOW
```

---

## 5. Stop Conditions

### Success

```text
sample_03_validated
B source pack ready
E verification done
F decision brief ready
```

### Pause

```text
waiting_for_owner_input
waiting_for_owner_decision
```

### Revise

```text
E端发现输出只是漂亮总结
E端发现没有实际专业化升级
E端发现过度流程化或污染主线
```

### Block

```text
同类失败连续 3 次
需要超授权操作
试图跳过 E/F
```

---

## 6. 当前下一步

```text
请求 Owner 提供 sample_03：一个真实业务/策略/工作流自然语言想法。
```

示例：

```text
我想让这个 meme 策略以后能自动判断哪些币值得观察，但不想自动交易，应该怎么设计？
```

收到输入后，整体 workflow loop 从 task-001 继续。
