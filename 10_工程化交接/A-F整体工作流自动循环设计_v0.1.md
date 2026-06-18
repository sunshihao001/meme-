# A-F整体工作流自动循环设计 v0.1

> 分线：10_工程化交接 / 整体工作流 loop  
> 输入修正：不是只是 A端的自动循环，要是整体工作流的循环  
> 状态：v0.1 / 整体 A-F loop 设计与最小落地方案  
> 目的：纠正前一版只聚焦 A端/dbskill 样例验证 loop 的偏差，把目标升级为 A/B/C/D/E/F 整体工作流的自动判断、自动执行、自动验证、持续循环。

---

## 1. 纠正结论

用户指出：

```text
不是只是 A端的自动循环，而是整体工作流的循环。
```

这个修正是对的。

前一版只做了：

```text
A端/dbskill 样例验证 loop
```

但真正目标应该是：

```text
A-F 多端口整体工作流 loop
```

也就是：

```text
A 判断与路由
→ B 收集证据/上下文
→ C 生成理论/方案/执行草案
→ D 落库/执行/提交
→ E 验证/审查/反馈
→ F 决策/授权/阶段门
→ 回到 A 更新状态并进入下一轮
```

---

## 2. 整体 loop 的目标

整体工作流循环不是“某个端口自己循环”，而是：

```text
整个 A-F 系统能够围绕一个目标持续推进。
```

它需要做到：

```text
1. 自动识别当前任务处于哪个端口。
2. 自动判断下一步应该交给哪个端口。
3. 自动执行低风险任务。
4. 自动验证结果。
5. 自动把失败反馈回上一端。
6. 自动记录状态。
7. 自动在需要 Owner 决策时暂停。
8. 决策后继续下一轮。
```

---

## 3. 当前与目标的差距

当前已经有端口文档和 skill，但还缺整体 loop 运行层。

差距：

```text
1. 没有统一的 A-F workflow_state 文件。
2. 没有统一任务队列 queue。
3. 没有端口状态机。
4. 没有跨端口 next_route 自动判定。
5. 没有 maker/checker 迭代计数。
6. 没有失败反馈规则。
7. 没有统一 stop condition。
8. 没有 event trigger / cron / PR check / Telegram command 的入口。
```

所以当前是：

```text
端口能力存在，但整体循环缺失。
```

---

## 4. 整体 A-F loop 最小架构

建议整体 loop 采用 6 个核心文件：

```text
1. workflow_loop_state_v0.1.yaml
2. workflow_loop_queue_v0.1.yaml
3. A-F整体工作流自动循环运行卡_v0.1.md
4. workflow_loop_event_log_v0.1.md
5. workflow_loop_e_verification_report_v0.1.md
6. workflow_loop_owner_decision_brief_v0.1.md
```

当前先落地前三个：

```text
workflow_loop_state_v0.1.yaml
workflow_loop_queue_v0.1.yaml
A-F整体工作流自动循环运行卡_v0.1.md
```

---

## 5. 端口状态机

整体 loop 的状态机：

```text
INTAKE        A端接收自然语言 / 事件 / 队列项
CLARIFY       A端澄清目标、边界、验收
SOURCE_PACK   B端收集证据/上下文
DESIGN        C端生成方案/理论/执行草案
LANDING       D端落库/执行/提交
VERIFY        E端验证/审查/反馈
OWNER_GATE    F端决策/授权/暂停
DONE          完成
BLOCKED       阻塞
REVISE        退回上一端修正
```

端口映射：

```text
A → INTAKE / CLARIFY / ROUTE
B → SOURCE_PACK
C → DESIGN
D → LANDING
E → VERIFY
F → OWNER_GATE
```

---

## 6. 整体 loop 每轮步骤

每轮循环必须这样跑：

```text
Step 1  读取 workflow_loop_state
Step 2  读取 workflow_loop_queue
Step 3  A端分类当前任务
Step 4  判断 next_port
Step 5  执行该端口最小任务
Step 6  写入产物和 event_log
Step 7  如果是 maker 产物，送 E端验证
Step 8  E端通过则更新 state
Step 9  E端失败则返回对应端口 revise
Step 10 如需权限/方向/扩大接入，则进入 F端
Step 11 F端决策后回到 A端继续下一轮
```

---

## 7. maker/checker 关系

在整体 loop 中：

```text
A/B/C/D 可以是 maker 或前置控制端；
E 必须是 checker；
F 是 owner gate；
A 是 loop controller。
```

关键原则：

```text
maker 不检查自己是否完成；
E端独立验证；
F端决定是否扩大权限或进入下一阶段。
```

---

## 8. 整体 loop 的停止条件

### 成功停止

```text
任务达到验收标准；
E端验证通过；
状态更新为 DONE；
必要时 F端确认。
```

### 暂停

```text
缺真实输入；
缺证据；
需要 Owner 方向判断；
触及权限边界。
```

### 返工

```text
E端验证失败；
产物只是漂亮总结；
没有可执行下一步；
索引/验证/CI 不通过。
```

### 中止

```text
连续 3 次同类失败；
任务风险超出授权；
进入禁止事项；
Owner 拒绝。
```

---

## 9. 最小可行整体 loop MVP

建议第一个整体 loop 不做所有任务，而只围绕一个低风险主线：

```text
dbskill 第一批三样例验证 → E端总验证 → F端决策是否进入第二批
```

这条主线正好覆盖 A-F：

```text
A：判断 sample_03 需求
B：整理 sample_01/02/03 上下文
C：生成是否进入第二批的方案
D：落库报告和状态
E：验证三样例是否真实有效
F：决定是否允许小范围接入第二批状态链
```

这比只跑 A端 loop 更接近整体工作流循环。

---

## 10. 下一步落地

本轮应新增：

```text
10_工程化交接/workflow_loop_state_v0.1.yaml
10_工程化交接/workflow_loop_queue_v0.1.yaml
10_工程化交接/A-F整体工作流自动循环运行卡_v0.1.md
```

然后当前 state 应进入：

```text
current_stage: INTAKE
current_port: A
next_port: A
current_task: collect_sample_03_real_input
```

因为现在整体 loop 的下一个真实动作仍然是：

```text
等待 sample_03 的真实业务/策略/工作流输入。
```

但不同点是：

```text
这不再只是 A端样例状态，
而是 A-F 整体 workflow queue 的一个任务项。
```

---

## 11. 本版结论

```text
用户修正成立：目标应是整体 A-F 工作流循环，不是 A端单点循环。
```

本轮升级方向：

```text
从 dbskill_sample_validation_loop
升级为
workflow_loop_state + workflow_loop_queue + A-F整体运行卡。
```

这一步完成后，系统才开始具备：

```text
整体任务队列
整体状态机
跨端口路由
maker/checker循环
owner gate
持续推进条件
```
