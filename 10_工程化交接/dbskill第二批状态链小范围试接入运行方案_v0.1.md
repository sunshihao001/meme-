# dbskill 第二批状态链小范围试接入运行方案 v0.1

> 分线：10_工程化交接 / dbskill / 第二批状态链  
> 状态：v0.1 / C端设计 + D端可落库方案  
> 前置决策：ACCEPT_SMALL_SCOPE_BATCH_2_TRIAL  
> 目的：在 Owner 授权后，定义 dbs-decision / dbs-save / dbs-restore / dbs-report 如何小范围接入整体 A-F workflow loop，避免污染、越权和过度文档化。

---

## 1. 一句话方案

```text
第二批不作为独立全局 skill 安装，而作为 A-F workflow loop 的状态链辅助层。
```

它只服务于：

```text
决策记录
状态快照
状态恢复
汇总报告
```

不服务于：

```text
自由记忆
全局自动触发
替代 Owner 决策
替代 E端验证
替代 git / 索引 / 变更记录
```

---

## 2. 四个能力的小范围定位

### 2.1 dbs-decision

本地定位：

```text
F端决策事件记录器
```

允许用途：

```text
1. 记录 Owner 选择。
2. 记录可选项、推荐默认、风险、约束。
3. 把决策回填到 workflow_loop_state。
```

禁止用途：

```text
1. 自动替 Owner 决策。
2. 把建议写成已批准。
3. 绕过 F端。
```

---

### 2.2 dbs-save

本地定位：

```text
workflow state snapshot 保存器
```

允许用途：

```text
1. 保存 workflow_loop_state / queue 的阶段快照。
2. 保存 dbskill_loop_state 的状态变化。
3. 生成可追溯快照文件。
```

禁止用途：

```text
1. 保存到 repo 外作为真源。
2. 保存未经验证的聊天片段当结论。
3. 替代正式变更记录。
```

---

### 2.3 dbs-restore

本地定位：

```text
workflow state 恢复入口
```

允许用途：

```text
1. 从项目内 state/queue 恢复当前 loop。
2. 找到当前 task、stage、port、next_action。
3. 恢复后交 A端判断是否继续。
```

禁止用途：

```text
1. 恢复仓库外未验证上下文。
2. 自动继续高风险任务。
3. 恢复旧错误判断而不经 E端检查。
```

---

### 2.4 dbs-report

本地定位：

```text
E/F 汇总报告辅助器
```

允许用途：

```text
1. 汇总多个状态快照。
2. 汇总样例验证结果。
3. 生成 Owner 可读决策材料。
```

禁止用途：

```text
1. 替代 E端验证。
2. 替代 PR checks / validate_all。
3. 只生成漂亮总结而没有证据路径。
```

---

## 3. 新增状态目录建议

建议后续新增目录：

```text
10_工程化交接/state_snapshots/
```

用途：

```text
保存 dbs-save 产生的状态快照。
```

命名规则：

```text
YYYYMMDD_HHMM_<loop_id>_<stage>_snapshot.yaml
```

当前先不创建大量快照，只在下一轮真正状态变化时创建。

---

## 4. 第二批试接入后的 workflow 状态变化

当前状态：

```text
OWNER_GATE → DESIGN
F端决策已完成
下一步交 C端设计状态链 wrapper
```

建议下一轮：

```text
C端生成 dbskill第二批状态链wrapper设计_v0.1.md
D端落库 snapshot 目录和初始快照
E端验证状态链是否污染主线
```

---

## 5. 验收标准

第二批试接入必须满足：

```text
1. 每个状态变化都有 repo 内文件记录。
2. 每个 Owner 决策有明确选项和决策值。
3. 每个 restore 都只从项目内 state/queue 读取。
4. 每个 report 都引用证据文件。
5. 不创建全局 runtime 自动触发。
6. 不替代 E端验证和 F端决策。
```

---

## 6. 本版结论

```text
第二批可以小范围试接入，但只能作为 A-F workflow loop 的状态链辅助层。
```

当前状态应更新为：

```text
batch_2_trial_authorized
next_stage: DESIGN
next_port: C
```
