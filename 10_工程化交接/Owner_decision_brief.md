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

是否允许 Agent/Codex 创建 GitHub issue、branch、PR。

### Recommended Default

```text
先只生成本地 issue 草案，不直接调用 GitHub。
```

### Alternatives

```text
A. 只生成本地 issue 草案
B. 允许创建 GitHub issue
C. 允许创建 branch/PR
```

### Evidence

当前 repo URL 与权限 UNKNOWN。

### Risk

未经授权创建 issue/PR 属于外部副作用。

### What happens if we choose A

```text
安全，但需要 owner 手动复制到 GitHub。
```

### What happens if we choose B/C

```text
效率高，但需要权限与 repo 确认。
```

### Exact question for owner

```text
是否提供 GitHub repo，并授权创建 issue？如果是，请给 repo URL 和权限范围。
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
