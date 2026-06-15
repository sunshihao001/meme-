# Demand Subprotocol Activation Template Plan

## Implementation approach

1. Use P73 as the canonical example rather than inventing a second methodology.
2. Keep the slice documentation-first: template, handoff, contract reference, index, changelog.
3. Do not change validator semantics unless a failing case proves a gap.
4. Verify with the existing aggregate validator.

## Files to create/update

```text
specs/demand-subprotocol-activation-template/spec.md
specs/demand-subprotocol-activation-template/plan.md
specs/demand-subprotocol-activation-template/tasks.md
specs/demand-subprotocol-activation-template/checklist.md
10_工程化交接/Codex_handoff_demand_subprotocol_activation_template.md
10_工程化交接/需求拷问端自拷问整体缺口审计_v0.1.md
00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md
00_知识库设计规范/05_索引与变更记录/设计规范变更记录.md
```

## Verification

```bash
python scripts/validate_all.py
gh issue view 4
```
