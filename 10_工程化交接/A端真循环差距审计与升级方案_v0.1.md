# A端真循环差距审计与升级方案 v0.1

> 分线：10_工程化交接 / A端流程 / loop engineering  
> 输入原话：现在好像还做不到像 GitHub 里那些文章说的循环，是能够自动判断推理，自动解决问题，然后再持续循环的持续运作工作流。不只是现在这样一问一答，还是以人为主，完全没有达到预期效果。  
> 状态：v0.1 / 差距审计 + 升级方案  
> 目的：承认当前 A端/dbskill 方案仍主要是“一问一答 + 项目级规则”，审计它与真正自动循环工作流之间的差距，并定义下一阶段如何升级到可持续运作的 loop。

---

## 1. 一句话结论

```text
你的判断是对的：当前还没有达到 GitHub 文章里说的“持续自动循环工作流”。
```

当前已经做到的是：

```text
自然语言输入 → A端轻量升级 → 文档落库 → 人工继续推进
```

但还没有做到：

```text
事件触发 → 自动判断 → 自动分派 → 自动执行 → 自动验证 → 自动修复/迭代 → 自动记录状态 → 触发下一轮
```

所以问题不是：

```text
A端方向错了。
```

而是：

```text
现在还停留在“认知/需求控制层”，没有升级到“事件驱动 + maker/checker + 状态机 + 持续循环”的运行层。
```

---

## 2. A端轻量升级：我理解你真正想说的是

你真正指出的是：

```text
现在这个系统虽然会总结、会升级表达、会写文档，
但还不是一个会自己持续工作的 agent loop。
```

你期待的是：

```text
AI 能够根据目标自动判断下一步，
自动调用合适的端口/工具/skill，
自动解决可解决的问题，
自动检查结果，
发现没完成就继续循环，
直到完成、失败、超预算或需要 Owner 决策。
```

你不满意的点是：

```text
现在仍然需要你一句一句推动，
所以它更像“增强版助手”，
还不像“持续运作的自动工作流”。
```

这个判断成立。

---

## 3. 当前架构已经有的部分

当前已经有：

```text
1. A端：自然语言理解、需求澄清、路由判断。
2. dbskill 第一批：问题成型、概念拆解、目标升级、反向诊断。
3. D端：落库、索引、变更记录、git 提交。
4. E端：验证口径、PR checks、validate_all。
5. F端：Owner 决策边界。
6. 状态记录：sample_01_validated / sample_02_validated / needs_sample_03 等。
```

这些是循环的组件，但还不是循环本身。

---

## 4. 当前缺失的“真循环”组件

真正自动循环至少需要 8 个组件：

```text
1. Trigger：什么事件自动启动？
2. Queue：待处理任务放在哪里？
3. State：当前循环状态如何持久化？
4. Classifier：自动判断任务类型、风险、端口。
5. Maker：谁负责执行可自动解决部分？
6. Checker：谁独立验证结果？
7. Stop Condition：什么时候停止、升级或交给 Owner？
8. Continuation：下一轮如何自动接上？
```

当前缺口：

```text
Trigger：缺
Queue：弱
State：有文档状态，但不是机器可读状态机
Classifier：A端有判断，但不是自动任务队列分类器
Maker：D/C 可执行，但未自动调度
Checker：E 有验证，但未形成循环反馈
Stop Condition：有概念，但不是每轮强制执行
Continuation：主要靠用户继续发消息
```

---

## 5. 专业化目标定义

下一阶段目标不应该叫：

```text
继续完善 A端提示词
```

而应该叫：

```text
A端事件驱动循环控制器 v0.1
```

专业表达：

```text
把 A端从自然语言升级门，扩展成一个事件驱动的 loop control plane：
它能够读取任务队列、判断任务类型、选择端口、调用 maker/checker、记录状态、根据验证结果进入下一轮或停止。
```

---

## 6. 建议升级成三层 loop 架构

### L0：自然语言升级层

当前已经基本建立。

```text
用户输入 → A端轻量升级 → 专业化表达 / 下一步动作
```

用途：

```text
把普通想法变成可运行任务。
```

---

### L1：单任务 maker/checker 循环

下一步最应该做这一层。

```text
任务进入队列
→ A端分类
→ D/C 执行 maker 工作
→ E端验证 checker
→ 如果失败，回到 maker 修复
→ 如果通过，记录状态
→ 如果超出边界，交给 F端
```

适合先做：

```text
文档更新
索引验证
样例验证
小型 skill 状态更新
外部 skill 接入评估
```

不适合先做：

```text
自动交易
大规模代码重构
全局 skill 安装
高风险权限操作
```

---

### L2：持续事件驱动循环

等 L1 跑稳后再做。

```text
cron / GitHub issue / PR check / Telegram 指令 / 文件状态变化
→ 自动启动循环
→ 自动处理队列
→ 自动汇报结果
```

这才接近 GitHub 文章里说的长期自动循环。

---

## 7. 最小可行真循环 MVP

建议不要一上来做大而全，而是先做一个最小循环：

```text
dbskill-sample-validation-loop v0.1
```

目标：

```text
持续推进 dbskill 第一批样例验证，直到达到 sample_03_validated，然后自动生成 E端总体验证请求。
```

### 输入状态

```text
sample_01_validated
sample_02_validated
needs_sample_03
```

### 触发方式

第一阶段先手动触发：

```text
用户说：继续 dbskill loop
```

第二阶段再做半自动触发：

```text
cron job 每天/每次检查状态文件
```

### 循环步骤

```text
1. A端读取状态。
2. 判断下一个缺口：needs_sample_03。
3. 要求或选取一个真实业务/策略/工作流输入。
4. 跑 Natural Language to Expert Upgrade Brief。
5. D端落库样例03报告。
6. E端验证 01/02/03 三个样例是否证明第一批有效。
7. 如果通过，生成 F端决策 brief：是否试接入第二批状态链。
8. 如果失败，退回 A端调整模板，不进入第二批。
```

### 停止条件

```text
成功：sample_03_validated + E端验证通过 + F端决策 brief 生成。
失败：样例03无法证明提升，或 E端发现只是漂亮话。
暂停：需要用户提供真实业务/策略输入。
禁止：自动进入第二批、自动全局安装、自动改变核心 skill。
```

---

## 8. 当前 dbskill 第二批暂不应直接接入

原因：

```text
第二批 dbs-decision / save / restore / report 是状态链能力。
如果没有先定义 loop 的 state/queue/stop condition，它们接进来会变成更多文档，而不是真循环。
```

更专业的顺序：

```text
先定义 loop state 文件
再定义 queue
再定义 maker/checker steps
再考虑 save/restore/report
最后才考虑自动触发
```

---

## 9. 推荐新增的机器可读状态文件

建议下一步新增：

```text
10_工程化交接/dbskill_loop_state_v0.1.yaml
```

内容示例：

```yaml
loop_id: dbskill-sample-validation-loop-v0.1
status: running
current_stage: sample_validation
samples:
  sample_01: validated
  sample_02: validated
  sample_03: needed
batch_2_status: hold_for_e_review
next_action: collect_real_business_or_workflow_input_for_sample_03
stop_conditions:
  success: sample_03_validated_and_e_review_passed
  pause: waiting_for_owner_input
  reject: e_review_finds_no_actual_improvement
forbidden:
  - install_full_dbskill_repo
  - enter_batch_2_without_e_review
  - global_runtime_trigger_without_owner_decision
```

这个文件会把“聊天里说的状态”变成“循环可以读取的状态”。

---

## 10. 推荐新增的循环运行卡

建议新增：

```text
10_工程化交接/dbskill_sample_validation_loop_运行卡_v0.1.md
```

运行卡说明：

```text
1. 如何读取 state。
2. 如何判断下一步。
3. 如何运行样例。
4. 如何让 E端验证。
5. 如何生成 F端决策。
6. 如何停止或继续。
```

---

## 11. 本轮结论

```text
你指出的问题成立：当前还不是持续自动循环，只是项目级规则 + 一问一答执行。
```

更专业的下一步不是继续扩写 A端，而是：

```text
把 dbskill 样例验证做成一个最小 maker/checker loop：
状态文件 + 运行卡 + 停止条件 + E端验证 + F端决策。
```

建议下一步执行：

```text
1. 新建 dbskill_loop_state_v0.1.yaml。
2. 新建 dbskill_sample_validation_loop_运行卡_v0.1.md。
3. 用样例03作为 loop 的下一个待处理任务。
4. 通过 E端后，再决定第二批状态链。
```
