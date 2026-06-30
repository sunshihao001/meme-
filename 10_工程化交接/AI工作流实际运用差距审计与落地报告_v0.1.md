# AI 工作流实际运用差距审计与落地报告 v0.1

> 分线：10_工程化交接 / AI 工作流运行态审计  
> 时间：2026-06-14 22:50:05 -0700  
> 触发问题：用户指出 `gh` 这类能力在项目中被列出，但此前没有真正安装、认证并用于工作流。  
> 本轮目标：用需求拷问方式找出类似“列了但没实际用”的 AI 工作流能力，回填理论，并至少落实一个能力到真实运行。

---

## 1. 本轮唯一最高价值问题

```text
当前项目中哪些 AI 工作流能力只是被文档列出、模板提到或规划过，但还没有进入真实运行闭环；其中哪一个最值得立即转成实际运用，以减少后续 Agent 继续假装完成？
```

---

## 2. Good Question Brief

### 原始问题

```text
还有哪些在实际ai工作流中运用但是想gh这样只是列出了，但没有被实际运用到的，使用需求拷问出来，并更新回填到理论，并落实到实际运用
```

### 改写后的 Agent 可执行问题

```text
在当前 meme- / MQL5 FCZ Reclaim 项目中，审计所有被 AI 工作流文档、任务包、handoff 或 issue 草案提到的能力，区分“已真实运行”“只被列出/规划”“需要 owner 决策后才能运行”，并选择一个最高价值、风险可控的能力立即落实到真实 GitHub / CI / repo 工作流中，然后把结果回填到项目理论与任务包。
```

### 核心冲突

```text
项目文档越来越像现代 AI 工作流，但部分能力仍停留在“模板 / 草案 / 推荐动作”，没有真实外部对象、编号、运行日志或工具输出作证。
```

### 验证入口

```text
1. gh auth status / gh repo view / gh pr list / gh issue list 的真实输出。
2. GitHub Issue / PR / Actions 是否存在真实 URL 和编号。
3. 项目文件是否把 #UNKNOWN 替换为真实 issue / PR 引用。
4. validate_all 和 GitHub Actions 是否继续通过。
```

---

## 3. Runtime Skill / Tool Audit

### loaded

```text
spec-first-ai-engineering
dbs-good-question
github-issues
github-pr-workflow
```

### actually executed this round

```text
gh auth status
gh repo view
gh pr list
gh issue list
gh label list
gh label create
gh issue create
gh issue view
```

### forbidden / not executed

```text
未经 owner 合并 PR
修改 branch protection
批量创建全部 GitHub issues
自动交易
私钥
swap
cron job
```

---

## 4. 差距矩阵：列出但未实际运用

| 能力项 | 文档中是否列出 | 本轮前真实状态 | 风险 | 本轮处理 |
|---|---|---|---|---|
| `gh` CLI | 已列出为推荐 GitHub 工作流 | 未安装 / 未认证 | 中 | 已安装、认证，并用于 repo / PR / issue / label / run 检查 |
| GitHub Issues | 有 7 个本地 issue draft | GitHub open issues = 0 | 高 | 已创建真实 Issue #2 作为 TP-003 入口 |
| Codex handoff 使用真实 issue 编号 | 模板要求 GitHub issue #number | 仍为 `#UNKNOWN` | 高 | 本轮将 TP-003 绑定到 Issue #2，待回填 handoff |
| GitHub labels | issue 草案列出建议标签 | 仓库只有默认标签 | 中 | 已创建 `validator` / `ci` / `ai-workflow` / `quality-gate` 标签 |
| PR checks via `gh` | workflow 中列出 CI | 此前用 API fallback 检查 | 低 | 已可用 `gh pr checks`，后续验证改用 gh |
| Branch protection | 文件中建议 owner 决策 | 未确认 / 未执行 | 高 | 继续保持 Needs owner，不擅自修改 |
| Codex / Claude Code 实际执行 | 有 handoff 模板 | 未实际调用外部 coding agent | 中 | 标记为 referenced_only，后续需单独 issue / owner 决策 |
| agent run log / trace | 方法论强调 runtime evidence | 仅 Markdown 报告，无结构化 run log | 中 | 新增为后续任务建议，不在本轮扩张 |
| eval harness | 质量门理念已出现 | 只有 deterministic validators，无 LLM eval | 中 | 新增为后续任务建议 |
| project_state.yaml | 需求上需要 machine-readable state | 不存在 | 中 | 新增为后续任务建议 |

---

## 5. 本轮实际落地

### 5.1 创建真实 GitHub Issue

已创建：

```text
Issue #2：TP-003: add index reference validator quality gate
URL：https://github.com/sunshihao001/meme-/issues/2
状态：OPEN
```

标签：

```text
documentation
validator
ci
ai-workflow
quality-gate
```

### 5.2 真实 gh 验证证据

```text
gh repo view -> sunshihao001/meme-
gh pr list -> PR #1 OPEN，CI success
gh issue list -> 本轮前 open issues = []
gh issue create -> created https://github.com/sunshihao001/meme-/issues/2
gh issue view 2 -> state OPEN
```

---

## 6. 理论回填结论

本轮把“AI 工作流实际运用”补充为四级状态，不再只写 allowed / forbidden：

```text
1. listed_only：文档中出现，但没有真实工具运行证据。
2. authenticated：工具已安装/认证，但还没有用于项目对象。
3. executed_once：至少对真实项目对象执行过一次，并有 URL / ID / run output。
4. workflow_integrated：已经被任务包、handoff、validator、CI 或项目真源引用，后续默认使用。
```

对应规则：

```text
任何能力只有达到 executed_once，才能在报告里写“已实际运用”。
只有达到 workflow_integrated，才能写“已接入项目工作流”。
```

---

## 7. 下一步建议

最小下一步仍然是 TP-003，但现在入口从本地草案升级为真实 GitHub Issue：

```text
读取 GitHub Issue #2 和本地 issue-005，执行 index reference validator。
```

后续不要再从 `#UNKNOWN` handoff 开始。
