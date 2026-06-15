# Codex / Agent Handoff — TP-009 Demand Subprotocol Activation Template

> GitHub Issue：#4  
> URL：https://github.com/sunshihao001/meme-/issues/4  
> Status：ready for bounded implementation  
> Source sample：P73 `intent-brainstorm-grill` activation artifact

```md
Read:
- AGENTS.md
- SOURCE_OF_TRUTH.md
- 10_工程化交接/Project_Continuation_Brief_v0.1.md
- specs/mql5-fcz-reclaim-model/clarification/demand_cognition_orchestrator_activation.md
- specs/mql5-fcz-reclaim-model/reports/loop_agent_demand_grilling_report_20260615_0117.md
- specs/mql5-fcz-reclaim-model/loop_agent_demand_grilling_contract.md
- specs/demand-subprotocol-activation-template/spec.md
- specs/demand-subprotocol-activation-template/plan.md
- specs/demand-subprotocol-activation-template/tasks.md
- specs/demand-subprotocol-activation-template/checklist.md
- GitHub Issue #4: https://github.com/sunshihao001/meme-/issues/4

Task:
Implement TP-009 only: make demand subprotocol activation evidence reusable for future loop-agent / demand-grilling reports.

Rules:
- Do not expand scope.
- Use P73 as the canonical example.
- Do not create a new standalone Hermes skill unless the owner explicitly decides product-line split.
- Do not claim external Superpowers / grill-me / grill-with-docs were executed as local independent skills.
- Keep trading execution, private keys, GMGN swap, auto-trading, cron, branch protection, and merge out of scope.
- If changing validator behavior, add/update tests first and report exact RED/GREEN evidence.
- Update index and changelog.

Expected output:
- A reusable activation-evidence template or guidance block.
- Contract/handoff references that future agents can follow.
- Exact verification output.

Verification:
```bash
python -m unittest discover -s tests
python scripts/validate_all.py
gh issue view 4
```

Stop and ask owner if:
- The implementation requires a standalone local Hermes skill.
- The demand side should become a separate product line.
- The task would create cron automation, branch protection, merge, or trading-related side effects.
```
