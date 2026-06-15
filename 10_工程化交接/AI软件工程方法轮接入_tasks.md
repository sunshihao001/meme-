# AI 软件工程方法轮接入 tasks

## Issue 1：建立需求拷问与 spec 模板

标题：建立需求拷问与生产级 spec 模板

目标：

```text
让任何模糊需求都能被整理成可 review、可验证、可交给 Codex 的 spec。
```

范围：

```text
1. 建立 spec.md 模板。
2. 建立需求拷问问题清单。
3. 建立 UNKNOWN 标记规范。
4. 建立风险地图模板。
```

验收标准：

```text
1. 模板包含 Background / Goal / Non-goals / User Stories / Acceptance Criteria / Edge Cases / Failure Modes / Security / Testing / QA / Human Decisions。
2. 至少包含 10 个 grill 问题。
3. 所有 UNKNOWN 必须显式保留。
```

测试要求：

```text
Markdown 文件存在。
grep 能找到 Acceptance Criteria、Human Decisions、UNKNOWN。
```

风险：

```text
模板过度复杂，导致后续不愿使用。
```

是否适合 Codex 执行：

```text
适合。Codex 可创建模板文件并运行文本检查。
```

---

## Issue 2：建立 Codex handoff 模板

标题：建立 Codex 执行交接模板

目标：

```text
确保 Codex 只执行明确 issue，不扩展 scope。
```

范围：

```text
1. 建立 Codex Handoff 模板。
2. 定义 Read / Task / Rules / Verification / Stop conditions。
3. 明确 Codex 需要报告 changed files 和 exact verification results。
```

验收标准：

```text
1. handoff 模板可直接复制给 Codex。
2. 明确 Do not expand scope。
3. 明确 Stop and ask 条件。
4. 明确 TDD when practical。
```

测试要求：

```text
grep 能找到 Do not expand scope、Run available checks、Report changed files。
```

风险：

```text
Codex 仍可能自行扩大范围，需要 reviewer 审查。
```

是否适合 Codex 执行：

```text
适合。
```

---

## Issue 3：建立 Owner Decision Brief 模板

标题：建立 owner 决策简报模板

目标：

```text
把必须由人类判断的产品、安全、权限、发布问题从 AI 自动执行中剥离。
```

范围：

```text
1. 建立 Owner Decision Brief 模板。
2. 区分 Autonomous / Needs owner / Ignored by owner。
3. 定义 Recommended Default、Alternatives、Evidence、Risk。
```

验收标准：

```text
1. 模板包含 Decision Needed、Recommended Default、Alternatives、Evidence、Risk、What happens if A/B、Exact question for owner。
2. 至少列出 GitHub issue 创建、Codex 权限、CI 配置三个 owner 决策点。
```

测试要求：

```text
grep 能找到 Exact question for owner。
```

风险：

```text
问 owner 的问题太多，阻塞推进；需要推荐默认值。
```

是否适合 Codex 执行：

```text
适合创建模板；不适合替 owner 做决策。
```

---

## Issue 4：为第一个真实 feature 生成工程 spec

标题：为第一个真实工程 feature 生成 spec / issue / Codex handoff

目标：

```text
选择一个真实 feature，把方法轮实际跑通。
```

范围：

```text
取决于 owner 选择。
候选：
1. MQL5观察指标MVP开发计划。
2. 反证样本CSV schema 校验器。
3. 状态机路径校验器。
4. GitHub issue 模板落地。
```

验收标准：

```text
1. owner 已选择具体 feature。
2. spec 四件套已生成。
3. issue 草案已生成。
4. Codex handoff 已生成。
```

测试要求：

```text
取决于 feature。
```

风险：

```text
如果没有 owner 决策，此 issue 不能进入 Codex 执行。
```

是否适合 Codex 执行：

```text
Needs owner first。
```
