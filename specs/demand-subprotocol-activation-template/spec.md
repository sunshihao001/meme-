# Demand Subprotocol Activation Template Spec

> Feature：demand-subprotocol-activation-template  
> GitHub Issue：#4 / https://github.com/sunshihao001/meme-/issues/4  
> Status：v0.1 / PROPOSED  
> Source sample：`specs/mql5-fcz-reclaim-model/clarification/demand_cognition_orchestrator_activation.md`

---

## 1. Background

P72 established a state model for demand-side subprotocols:

```text
parent_skill_installed → subprotocol_present → subprotocol_loaded → subprotocol_activated → subprotocol_executed → subprotocol_output_consumed
```

P73 executed the first real sample for `spec-first-ai-engineering/references/intent-brainstorm-grill.md` and produced a durable clarification artifact.

The remaining problem is repeatability: future loop reports still depend on the agent remembering to write the same evidence manually.

---

## 2. Goal

Create a reusable handoff/spec slice so future demand-grilling runs can include subprotocol activation evidence without reinventing the format each time.

---

## 3. Users / Operators

```text
Owner：audits whether the demand side is really operating, not just documenting methods.
Hermes / Claude / Codex agents：copy or follow a concrete activation-evidence template.
Reviewer / CI：checks reports contain the evidence fields.
Future workflow maintainer：decides whether to later promote this into a standalone skill.
```

---

## 4. Scope

```text
1. Provide a concrete activation-evidence template.
2. Reference the P73 activation sample as the canonical example.
3. Bind GitHub Issue #4 to this handoff slice.
4. Update loop-agent contract / handoff guidance so future runs know where to copy from.
5. Keep product-line split as an owner decision, not an implied default.
```

---

## 5. Non-goals

```text
1. Do not create a new standalone Hermes skill in this issue.
2. Do not install or claim execution of external Superpowers / grill-me skills.
3. Do not alter trading strategy, sample labels, private keys, GMGN swap, or auto-trading.
4. Do not create cron jobs or merge PRs.
```

---

## 6. Required Template

Future reports should include these two blocks when a subprotocol is relevant.

### subprotocol_activation_plan

```text
parent_skill：<top-level Hermes skill loaded via skill_view>
subprotocol：<support reference path, e.g. references/intent-brainstorm-grill.md>
trigger_reason：<why this subprotocol is needed this run>
expected_artifact：<file or object expected from the subprotocol>
downstream_consumer：<report / validator / issue / handoff / index / changelog / other consumer>
allowed_side_effects：<read_only / write_files / commit / push_pr_allowed>
forbidden_capabilities：<explicit no-go list>
```

### subprotocol_execution_evidence

```text
loaded_reference：yes/no + how loaded
activated：yes/no + why
funnel_layers_completed：<layers completed, or not_applicable_reason>
artifact_path：<durable output path, or not_applicable_reason>
output_consumed_by：<concrete downstream file/object/URL, or not yet consumed>
validation_evidence：<command output / validator / CI / manual review>
state_after_run：<loaded_reference / activated / executed / output_consumed / partial / blocked>
```

---

## 7. Acceptance Criteria

```text
1. GitHub Issue #4 exists and references P73.
2. This spec package exists and can be used by Codex / agent handoff.
3. The Codex handoff file includes an Issue #4 handoff.
4. The project index and changelog reference this package.
5. `python scripts/validate_all.py` passes.
```

---

## 8. Open Owner Decisions

```text
REQUIRES_OWNER：Should demand cognition become a separate product line or remain a control layer inside this project?
REQUIRES_OWNER：Should `demand-brainstorm-grill` become a standalone local Hermes skill later?
```
