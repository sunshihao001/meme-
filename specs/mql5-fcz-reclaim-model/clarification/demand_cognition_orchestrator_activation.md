# Demand Cognition Orchestrator Activation Clarification

> 项目：mql5-fcz-reclaim-model  
> 时间：2026-06-15 01:17 PDT  
> 运行模式：manual / subprotocol activation sample  
> 父 skill：`spec-first-ai-engineering`  
> 子协议：`references/intent-brainstorm-grill.md`  
> 状态：v0.1 / PROPOSED clarification artifact  
> 目的：把“需求拷问端存在但没有运用起来”的问题，转成一次真实的子协议激活样例。

---

## 1. Subprotocol Activation Evidence

```text
parent_skill：spec-first-ai-engineering
subprotocol：references/intent-brainstorm-grill.md
loaded_reference：yes
activated：yes
trigger_reason：Owner 确认“存在，但是没有运用起来”，要求从安装态进入真实运用态。
expected_artifact：本 clarification artifact + 后续 loop report / validator / issue handoff 输入。
downstream_consumer：需求拷问端技能编排层、loop agent demand-grilling contract、loop report validator、后续 GitHub issue / Codex handoff。
```

执行状态：

```text
funnel_layers_completed：
- goal
- users_operators
- boundaries_non_goals
- assumptions
- failure_modes
- options_compared
- acceptance_criteria

artifact_path：specs/mql5-fcz-reclaim-model/clarification/demand_cognition_orchestrator_activation.md
output_consumed_by：本轮 P73 变更记录、loop report、运行契约引用、后续 issue handoff 候选。
```

---

## 2. Goal

本轮要改变的结果不是继续证明 `intent-brainstorm-grill` 是否存在，而是：

```text
让需求拷问端首次以可审计方式激活 `intent-brainstorm-grill` 子协议，产出 durable clarification artifact，并将其作为后续需求拷问、validator 和 issue handoff 的输入。
```

目标状态：

```text
1. 子协议不再只是 installed_as_subprotocol / loadable_reference。
2. 本轮明确记录 activated = yes。
3. 7 层 funnel 完整落盘。
4. artifact 被项目索引、变更记录和 loop report 消费。
5. 后续任何“需求拷问端已运用”的声明都能用相同格式审计。
```

---

## 3. Users / Operators

```text
Owner：判断需求拷问端是否真的变成可用产品，而不是方法论堆叠。
主 Agent / Hermes：按 skill orchestration contract 执行，避免假调用。
后续 Codex / Claude Code / GitHub issue 执行者：读取 clarification artifact，知道真正要实现什么。
Reviewer / CI / validator：检查 report 是否提供 subprotocol activation evidence。
项目知识库维护者：避免把方法轮文档无限膨胀进业务仓库。
```

承担后果的人：

```text
Owner 承担产品方向选择后果；
Agent 承担执行证据完整性；
项目仓库承担长期可维护性；
validator 承担防止假完成的质量门责任。
```

---

## 4. Boundaries / Non-goals

本轮明确不做：

```text
1. 不把 Superpowers brainstorming、/grill-me、/grill-with-docs 伪装成本地独立 skill。
2. 不为了“看起来全链条”机械调用所有 DBS skill。
3. 不创建自动 cron，不启动无人值守长期循环。
4. 不进入交易执行、私钥、swap、自动下单、资金相关能力。
5. 不把需求拷问端扩成另一个庞大产品仓库；本轮只做最小可验证激活样例。
6. 不把 Owner 的“可以”解读成同意所有未来自动化 side effects；本轮只允许文档、validator、索引、变更记录、提交推送和 CI 检查。
```

本轮可以做：

```text
1. 写 clarification artifact。
2. 写 loop report。
3. 更新索引和变更记录。
4. 如有必要，更新运行契约中对本 artifact 的引用。
5. 运行 validate_all。
6. 提交、推送、查 CI。
```

---

## 5. Assumptions

```text
1. 当前仓库分支 `docs/project-governance-v1` 是本轮治理文档工作的目标分支。
2. `intent-brainstorm-grill` 已通过 skill_view 加载，属于 `spec-first-ai-engineering` 的子协议。
3. 本轮的最小价值不是继续外部搜索，而是把已存在子协议从 loaded_reference 推进到 activated / executed / output_consumed。
4. 当前 validator 已能检查 loop report 的 subprotocol_activation_plan 和 subprotocol_execution_evidence 字段。
5. Owner 当前关注的是 AI 工作流/需求端产品能力，不是 MQL5 交易策略本体的新规则。
```

若这些前提错误，会导致：

```text
1. artifact 写错位置，不能被后续工作消费。
2. 把治理层内容过度塞进业务知识库。
3. 把一次 clarification 样例误解为全自动需求端产品已经完成。
4. 把子协议激活误报为外部 Superpowers / grill-me 独立 skill 执行。
```

---

## 6. Risks / Failure Modes

```text
假激活：只写了本文件，但没有被 loop report / validator / issue handoff 消费。
假执行：写了 funnel 标题，但没有形成可检查结论。
过度工程化：为了证明“运用起来”，创建过多新文件和新流程。
技能混淆：把 parent_skill、subprotocol、external_pattern 三层混为一谈。
Owner 意图漂移：把“需求端产品化”误解成“立即开发一个完整软件产品”。
验证空转：validate_all 只证明格式通过，不证明产品思考正确。
后续断链：本 artifact 没有成为下一轮 issue / handoff / contract 的输入。
```

对应防线：

```text
1. loop report 必须记录 output_consumed_by。
2. 变更记录必须记录 P73 激活样例。
3. 下一步若进入 issue，应引用本 artifact。
4. 不声明“完整产品完成”，只声明“子协议激活样例完成”。
```

---

## 7. Options Compared

### Option A：只继续补文档说明

优点：

```text
成本低，风险小。
```

缺点：

```text
会继续停留在“存在但没有运用起来”的问题里。
```

结论：

```text
不选。Owner 已经明确指出存在但没运用。
```

### Option B：立即创建新的本地 bridge skill

优点：

```text
可以把 demand-brainstorm-grill 变成独立 Hermes skill。
```

缺点：

```text
当前真正缺口不是没有 skill，而是已有子协议没有被激活；直接新建 skill 会绕开根因。
```

结论：

```text
暂不选。先跑一次真实激活样例。
```

### Option C：激活已有子协议，产出 durable clarification artifact

优点：

```text
直接修正“存在但没运用”的问题；
不新增过多架构；
能被 validator / report / issue handoff 消费；
符合 P72 的状态层级。
```

缺点：

```text
仍只是样例，不等于长期自动化已完成。
```

结论：

```text
本轮选择 Option C。
```

---

## 8. Decisions

```text
DECISION-001：本轮把 `intent-brainstorm-grill` 作为已加载且已激活的子协议运行。
DECISION-002：本轮 durable artifact 是 `specs/mql5-fcz-reclaim-model/clarification/demand_cognition_orchestrator_activation.md`。
DECISION-003：本轮不创建新的 Hermes skill；先验证已有子协议能否被正确激活。
DECISION-004：本轮不声称 Superpowers / grill-me / grill-with-docs 已作为本地独立 skill 执行。
DECISION-005：本轮完成后，下一步才考虑是否把该激活流程产品化为 issue / bridge skill / CLI command。
```

---

## 9. Open Questions

```text
REQUIRES_OWNER：是否要把需求拷问端正式作为一个独立产品线维护，还是继续作为 MQL5 项目的工作流控制层？
REQUIRES_OWNER：是否需要创建本地 Hermes skill `demand-brainstorm-grill`，还是保持为 `spec-first-ai-engineering` 的子协议？
PROPOSED：后续 GitHub issue 可以以本 artifact 为输入，目标是“让 loop report 自动生成 subprotocol_activation_evidence 模板”。
UNKNOWN：未来是否需要接入外部 Superpowers skill 原仓库，还是只保留方法吸收。
```

---

## 10. Acceptance Criteria

本轮 clarification stage 完成条件：

```text
1. `intent-brainstorm-grill` 通过 skill_view(..., file_path=...) 实际加载。
2. 本文件完整覆盖 Goal / Users / Non-goals / Assumptions / Failure Modes / Options Compared / Acceptance Criteria。
3. 本文件被写入项目仓库，并在索引中登记。
4. 变更记录新增 P73，明确这是一次真实激活样例。
5. loop report 记录 subprotocol_activation_plan 和 subprotocol_execution_evidence。
6. validate_all 通过。
7. 提交推送并确认 CI 通过。
```

完成后可以报告：

```text
intent-brainstorm-grill：loaded_reference=yes；activated=yes；executed=yes for clarification artifact；output_consumed_by=P73 loop report / index / changelog / validator contract。
```

不能报告：

```text
需求拷问端完整产品已完成。
Superpowers / grill-me 独立 skill 已执行。
所有 DBS skill 已全链条执行。
```
