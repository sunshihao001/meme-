# Demand Subprotocol Activation Evidence Template v0.1

> 分线：10_工程化交接 / templates  
> 状态：v0.1 / TP-009 可复用模板  
> 来源：`10_工程化交接/Codex_handoff_demand_subprotocol_activation_template.md`、P73 `intent-brainstorm-grill` activation artifact  
> 目的：让未来 A端 / demand-grilling loop report 能稳定记录“触发了哪个子协议、为什么触发、产出了什么、被谁消费”，避免只在聊天中声称调用。  
> 边界：本模板记录 activation evidence；不表示外部 Superpowers / grill-me / grill-with-docs 已作为本地独立 skill 执行。

---

## 1. 什么时候使用

当 A端需求控制 / 需求拷问在一次 loop 中触发某个子协议、子流程、辅助 lens 或外部方法论时，必须记录本模板。

典型触发：

```text
intent-brainstorm-grill
clarify
source-pack-request
owner-decision-brief
maker-checker-design
verification-gate
protective-knowledge-update
```

---

## 2. 最小记录字段

```text
activation_id:
parent_loop_id:
parent_skill_or_port:
subprotocol_name:
subprotocol_source:
trigger_reason:
input_question_or_gap:
expected_artifact:
artifact_path:
downstream_consumer:
output_consumed_by:
authority_boundary:
forbidden_actions:
verification_evidence:
status:
```

字段说明：

```text
parent_skill_or_port：例如 A端 / meme-demand-control-port。
subprotocol_source：本地 skill、repo 模板、外部参考、手工 lens。
trigger_reason：为什么需要这个子协议，不是“因为想用”。
expected_artifact：应该产出什么文件/brief/report。
artifact_path：实际落库路径；如果没有，必须写 missing reason。
downstream_consumer：B/C/D/E/F 哪个端口或哪个 validator 会消费。
output_consumed_by：实际被谁使用。
authority_boundary：本子协议允许做什么。
forbidden_actions：明确不能越权的动作。
verification_evidence：文件存在、validator、PR/CI、人工确认等。
status：PROPOSED / EXECUTED / PARTIAL / BLOCKED / REJECTED。
```

---

## 3. Markdown 模板

```md
# Subprotocol Activation Evidence

## Activation Summary

```text
activation_id:
parent_loop_id:
parent_skill_or_port:
subprotocol_name:
subprotocol_source:
trigger_reason:
status:
```

## Input Gap

```text
input_question_or_gap:
why_parent_skill_alone_is_insufficient:
```

## Expected Artifact

```text
expected_artifact:
artifact_path:
downstream_consumer:
output_consumed_by:
```

## Authority Boundary

```text
authority_boundary:
forbidden_actions:
owner_decision_required:
```

## Execution Evidence

```text
commands_or_files_checked:
verification_evidence:
validator_result:
```

## Result

```text
accepted_output:
rejected_output:
remaining_gap:
next_port:
```
```

---

## 4. P73 兼容示例字段

以下字段可用于把 P73 的 `intent-brainstorm-grill` 激活样例转成规范记录：

```text
activation_id: P73-intent-brainstorm-grill
parent_loop_id: loop_agent_demand_grilling_report_20260615_0117
parent_skill_or_port: A端 / demand-grilling control
subprotocol_name: intent-brainstorm-grill
subprotocol_source: repo-local demand cognition orchestrator activation note
trigger_reason: 原始需求过宽，需要先拆 intent、goal、artifact、verification、authority boundary
expected_artifact: demand cognition orchestrator activation artifact
artifact_path: specs/mql5-fcz-reclaim-model/clarification/demand_cognition_orchestrator_activation.md
downstream_consumer: A端控制循环 / C端理论生成 / D端落库 / E端验证
output_consumed_by: loop_agent_demand_grilling_report_20260615_0117
status: EXECUTED
```

---

## 5. 禁止误报

禁止写法：

```text
1. “已调用 grill-me skill”，但本地没有实际 skill/tool 调用或证据。
2. “已执行 Superpowers”，但只是借鉴了其思路。
3. 子协议没有产物路径，却声称已完成。
4. 没有 downstream consumer，却声称进入循环。
5. 把子协议产物直接当成最终结论，跳过 E端验证。
```

正确写法：

```text
借鉴外部方法论 lens：写 referenced_only。
实际执行本地模板/文件：写 EXECUTED 并给 artifact_path。
只提出待执行：写 PROPOSED。
执行了一半：写 PARTIAL 并说明 blocker。
```

---

## 6. 与 loop report validator 的关系

未来可以让 `scripts/validate_loop_agent_reports.py` 检查：

```text
1. 如果报告声称触发 subprotocol，必须有 activation evidence。
2. activation evidence 必须包含 artifact_path 或 missing reason。
3. subprotocol_source 必须区分 local skill / repo template / external reference。
4. status 必须是 PROPOSED / EXECUTED / PARTIAL / BLOCKED / REJECTED 之一。
```

当前本模板先作为项目级可复用文档，不立即扩大 validator 范围。

---

## 7. 本版结论

```text
A端需求控制不是“说自己调用了很多方法”，而是必须留下可消费、可审计、可验证的子协议激活证据。

本模板把子协议从聊天里的隐性动作，变成 repo 内可复用的 activation evidence。
```
