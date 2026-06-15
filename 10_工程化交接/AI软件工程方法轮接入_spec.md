# AI 软件工程方法轮接入 spec

> 版本：v0.1  
> 分线：工程化交接线 / 需求拷问线 / Codex执行线  
> 状态：spec 草案，可用于继续澄清与 GitHub 沉淀  

---

## Background

当前项目已经形成 MQL5 / meme 第一控盘区成本中枢回收模型知识库，包含策略定义、资料吸收、反证样本库、状态机规则、商业审计与样本 CSV 模板。

当前新需求不是继续深化交易策略本身，而是接入一套 AI 软件工程方法轮：

```text
需求拷问
-> 生产级 spec
-> 用户故事 / GitHub issue
-> Codex 执行
-> TDD / 测试
-> QA / Playwright / 可访问性 / 安全审计
-> PR
-> CI
-> 人类最终判断
-> 记录到 GitHub
```

目标是把已澄清到一半的需求整理成可交给 Codex / 编码 Agent 执行的工程化说明书。

---

## Goal

建立一个可复用的“需求拷问与方法轮接入”工作流，使后续任何功能需求都能被整理为：

```text
1. Agent 可推理
2. Agent 可批评
3. Agent 可验证
4. Codex 可执行
5. GitHub 可沉淀
```

---

## Non-goals

本阶段不做：

```text
1. 不直接实现业务代码。
2. 不让 Codex 在没有验收标准时开工。
3. 不把聊天记录当长期项目记忆。
4. 不跳过需求澄清、测试计划、风险审计。
5. 不创建虚假的 GitHub issue 编号或 PR 编号。
6. 不声称功能完成，除非有测试/验证证据。
```

---

## User Stories

### Story 1：作为项目 owner，我要把模糊需求变成可执行 spec

验收标准：

```text
给定一段模糊需求，系统能输出 spec.md、plan.md、tasks.md、checklist.md 草案。
```

### Story 2：作为 Codex 执行器，我要拿到边界清晰的 handoff

验收标准：

```text
Codex handoff 明确 Read、Task、Rules、Verification、Stop conditions。
```

### Story 3：作为 reviewer，我要知道哪些需要人类判断

验收标准：

```text
输出 Owner Decision Brief，区分 Autonomous / Needs owner / Ignored by owner。
```

### Story 4：作为维护者，我要把工程决策沉淀到 GitHub

验收标准：

```text
输出 issue 草案、PR 描述模板、docs/adr 建议，而不是只留在聊天里。
```

---

## Acceptance Criteria

```text
1. 需求澄清摘要包含目标、约束、不确定点。
2. 好问题清单把模糊问题改写成可执行问题。
3. 缺失信息分为必须回答、最好回答、可以后置。
4. 风险地图覆盖产品、技术、安全、数据、权限、测试、运维、成本。
5. spec 草案包含 Background、Goal、Non-goals、User Stories、Acceptance Criteria、Edge Cases、Failure Modes、Security / Privacy、Testing Requirements、QA Requirements、Human Decisions Needed。
6. tasks / issue 拆分按垂直切片，而不是按技术层拆。
7. Codex Handoff 可直接复制给 Codex。
8. Owner Decision Brief 明确推荐默认选项、替代方案、风险和精确问题。
9. 所有 UNKNOWN 必须显式标记，不得编造。
10. 所有长期结论必须能落到 GitHub 或本地文件。
```

---

## Edge Cases

```text
1. 用户只给出一句模糊需求。
2. 需求涉及权限、凭据、发布、资金或安全风险。
3. 现有系统可能已有类似逻辑，但路径 UNKNOWN。
4. Codex 执行中发现 spec 与代码现实冲突。
5. 测试环境缺失或 CI 不可用。
6. GitHub issue 编号尚未创建。
7. 用户要求“继续推进”，但没有提供 owner 决策。
```

---

## Failure Modes

```text
1. 过早进入编码，导致 scope creep。
2. spec 只描述愿景，没有验收标准。
3. issue 按技术层拆，无法垂直验证用户价值。
4. Codex 自行扩大范围。
5. AI 把聊天上下文当长期记忆，未写入 repo。
6. 没有测试证据就宣布完成。
7. 人类必须决策的问题被 AI 擅自默认。
```

---

## Security / Privacy

```text
1. 不保存 API key、token、密码、私钥、连接字符串。
2. 涉及 GitHub 权限、CI secret、部署、发布必须 owner 决策。
3. Codex handoff 不应包含敏感凭据。
4. 安全相关改动必须进入 Needs owner 或要求专门 review。
```

---

## Testing Requirements

每个可执行 issue 必须包含：

```text
1. 单元测试要求。
2. 集成测试要求。
3. 若涉及 UI，Playwright 或等价 E2E 测试要求。
4. 若涉及可访问性，a11y 检查要求。
5. 若涉及权限/安全，安全回归测试要求。
6. 明确可运行命令和预期结果。
```

---

## QA Requirements

```text
1. Codex 必须报告 changed files。
2. Codex 必须报告 exact verification results。
3. Reviewer 需要检查 spec compliance。
4. CI 通过前不能合并。
5. 人类 owner 最终判断是否发布、合并、开放权限。
```

---

## Human Decisions Needed

```text
1. GitHub repo 路径 / issue 编号：UNKNOWN。
2. 当前要工程化的第一个具体 feature：UNKNOWN。
3. Codex 执行环境与权限边界：UNKNOWN。
4. 是否允许创建 GitHub issue / PR：需要 owner 决策。
5. 是否有 CI / Playwright / 安全扫描现成配置：UNKNOWN。
```
