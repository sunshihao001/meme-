# 当前可调用 Skill 组合速查卡 v0.1

> 分线：10_工程化交接 / 运行速查
> 目的：把当前 Hermes 里已经可调用的 skill 组合压成一页速查，方便直接判断输入该走哪一组。

---

## 1. A 端：需求拷问 / 问题定义

### 触发场景

- 输入很模糊
- 想法很多但边界不清
- 需要先判断这件事到底该怎么问
- 还不适合直接搜资料或写 PRD

### 可调用组合

```text
dbs-good-question
+ brainstorming
+ grill-with-docs
+ grill-me
```

### 作用

- 把人话问清楚
- 找缺口
- 统一概念
- 决定是否进入 B / C

---

## 2. B/C 端：规格收束 / 任务拆分

### 触发场景

- A 端已经把问题拷问清楚
- 需要把结果写成 PRD
- 需要拆成 issue
- 需要给后续执行准备任务结构

### 可调用组合

```text
to-prd
+ to-issues
+ triage
```

### 作用

- 把对话收成规格
- 把规格拆成任务
- 给任务分级和治理

---

## 3. 执行前编排层

### 触发场景

- 计划已稳定
- 准备进入施工
- 需要先做执行编排
- 需要 worktree 隔离

### 可调用组合

```text
executing-plans
+ using-git-worktrees
```

### 作用

- 把计划变成执行动作
- 隔离施工空间
- 降低互相污染

---

## 4. 质量收尾层（当前未全齐）

### 适合做什么

- 验证完成度
- 结束分支
- 接收 review
- 做并行 agent 协同
- 做更细的代码质量治理

### 当前状态

```text
已确认可见但未纳入主链：
- tdd
- improve-codebase-architecture

尚未稳定确认：
- verification-before-completion
- finishing-a-development-branch
- dispatching-parallel-agents
- receiving-code-review
```

---

## 5. 默认使用顺序

### 模糊想法 → 规格

```text
A 端组合
→ B/C 端组合
```

### 规格 → 执行

```text
to-prd
→ to-issues
→ triage
→ executing-plans
→ using-git-worktrees
```

### 施工之后

```text
Hermes 回收验证
→ Owner 决策
```

---

## 6. 当前最稳的判断

### 已经能稳定调用

```text
A/B/C 主链核心组合
```

### 还没完全齐的

```text
D/E 收尾与验证链条
```

### 现在最适合的方式

```text
先用 Hermes 把问题拷问清楚；
再用 Hermes 把规格收束好；
真正改代码时交给 Codex；
最后再由 Hermes 回收和验证。
```

---

## 7. 一句话结论

```text
现在 Hermes 已经能跑起 A/B/C 的核心 skill 组合；完整 D/E 收尾链还需继续补齐。
```
