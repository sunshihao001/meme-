# Owner Decision Brief

## Decision 1：第一个工程化 feature

### Decision Needed

选择第一个真正进入 spec -> issue -> Codex 的 feature。

### Recommended Default

```text
反证样本 CSV schema 校验器
```

理由：

```text
1. 范围小。
2. 可测试。
3. 直接服务当前样本系统。
4. 不需要外部凭据。
5. 可用 TDD 实现。
```

### Alternatives

```text
A. MQL5观察指标MVP开发计划
B. 状态机路径校验器
C. GitHub issue 模板落地
D. 反证样本 CSV schema 校验器
```

### Evidence

当前已有：

```text
07_样本标注/样本字段表_v0.1.md
07_样本标注/反证样本库_v0.1.csv
07_样本标注/模拟反证样本库_v0.1.csv
```

### Risk

如果直接做 MQL5 指标，范围可能过大，且真实样本尚未填充。

### What happens if we choose D

```text
快速得到一个可验证工具，保证真实/模拟 CSV 不漂移。
```

### What happens if we choose A

```text
更接近产品，但需求和验证复杂度明显更高。
```

### Exact question for owner

```text
第一个交给 Codex 的 feature 是否选择“反证样本 CSV schema 校验器”？
```

---

## Decision 2：GitHub 权限

### Decision Needed

哪些 GitHub 副作用允许 Agent 直接执行，哪些仍需 owner 决策。

### Current State

```text
gh CLI 已安装并认证。
PR #1 已存在：https://github.com/sunshihao001/meme-/pull/1
TP-003 已创建真实 Issue #2：https://github.com/sunshihao001/meme-/issues/2
```

### Recommended Default

```text
允许 Agent 为当前明确任务创建单个 GitHub issue、更新当前 PR 分支并检查 CI；不允许未经确认批量创建 issue、修改 branch protection、合并 PR 或发布 release。
```

### Alternatives

```text
A. 只允许本地 issue 草案
B. 允许当前任务的单个 GitHub issue / PR 检查
C. 允许批量 issue / branch protection / merge
```

### Evidence

当前 repo 与权限已确认：

```text
repo：sunshihao001/meme-
gh auth：sunshihao001 authenticated
open PR：#1
open issue：#2
```

### Risk

批量创建 issue、修改保护规则或合并 PR 仍属于高副作用，需要 owner 决策。

### What happens if we choose B

```text
AI 工作流可以从 #UNKNOWN handoff 升级到真实 GitHub issue / PR / CI 对象，但仍保留 owner 对合并和保护规则的最终控制。
```

### Exact question for owner

```text
是否允许后续每个明确任务都自动创建一个真实 GitHub issue？批量创建、合并和 branch protection 仍默认需要单独确认。
```

---

## Decision 3：Codex 执行边界

### Decision Needed

Codex 是否允许直接修改仓库文件并运行测试。

### Recommended Default

```text
允许 Codex 在本地分支执行单个 issue，但不允许发布、合并、推送敏感配置。
```

### Alternatives

```text
A. 只让 Codex 生成 patch
B. 允许 Codex 本地修改和测试
C. 允许 Codex 创建 PR
```

### Evidence

当前执行环境 UNKNOWN。

### Risk

权限过大可能导致 scope creep 或误改项目规则。

### Exact question for owner

```text
Codex 的权限边界是什么：只生成 patch、本地修改测试，还是允许 PR？
```
