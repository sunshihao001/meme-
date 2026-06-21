# 当前 Hermes 可调用 Skill 组合清单与缺失补齐表 v0.1

> 分线：10_工程化交接 / skill 运行状态
> 目的：确认当前 Hermes 里哪些 skill 组合已经能调用，哪些还缺，方便后续按组合治理，而不是按单 skill 记忆。

---

## 1. 当前可调用的核心组合

### 1.1 A 端：需求拷问 / 问题定义

已确认可用：

- `dbs-good-question`
- `brainstorming`
- `grill-with-docs`
- `grill-me`

用途：

```text
自然语言输入 → 需求拷问 → 问题定义 → 决定是否进入 B/C
```

---

### 1.2 B/C 端：规格收束 / 任务拆分

已确认可用：

- `to-prd`
- `to-issues`
- `triage`

用途：

```text
A 端拷问后的结果 → PRD → issue 拆分 → 任务分级
```

---

### 1.3 执行前编排层

已确认可用：

- `executing-plans`
- `using-git-worktrees`

用途：

```text
计划已稳定 → 执行编排 → worktree 隔离 → 进入施工
```

---

## 2. 当前已确认在 Hermes 中可见但未纳入主链的相关 skill

已确认可见：

- `tdd`
- `improve-codebase-architecture`

用途：

```text
执行阶段的代码质量 / 架构改进支撑
```

---

## 3. 目前还没有在 Hermes 可见列表中稳定确认到的 skill

以下 skill 目前未在 Hermes `skills list` 中稳定确认到，需后续补齐或重新检查安装路径：

- `verification-before-completion`
- `finishing-a-development-branch`
- `dispatching-parallel-agents`
- `receiving-code-review`

说明：

```text
不是判定为无效，而是当前 Hermes 可见列表里尚未稳定确认。
```

---

## 4. 当前可运行的默认组合

### 4.1 第一阶段默认组合

```text
 dbs-good-question
+brainstorming
+grill-with-docs
+grill-me
```

### 4.2 规格化组合

```text
 to-prd
+to-issues
+triage
```

### 4.3 执行前组合

```text
 executing-plans
+using-git-worktrees
```

### 4.4 质量收尾组合（待补齐）

```text
 verification-before-completion
+tdd
+improve-codebase-architecture
+finishing-a-development-branch
```

---

## 5. 当前判断

### 已经能调用起来的

```text
A/B/C 主链核心组合已经可用。
```

### 还没完全齐备的

```text
D/E 收尾与验证链条还需要继续补齐。
```

### 当前最佳使用方式

```text
先用 A 端把问题拷问清楚；
再用 B/C 收束成 PRD / issue / plan；
然后交给 Codex 做执行；
Hermes 再回收验证和归档。
```

---

## 6. 一句话结论

```text
当前 Hermes 已经能跑起 A/B/C 主链组合，但完整 D/E 全链路还没完全齐，需要边用边补。
```
