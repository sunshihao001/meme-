# State Path Validator Spec

## Background

The project now has a working CSV schema validator. The next vertical slice should validate semantic consistency of `current_state_path` in real and simulated sample CSVs.

## Goal

Add a lightweight validator that checks state-machine paths recorded in sample CSV rows use known states and follow allowed transitions.

## Non-goals

```text
1. Do not infer states from chart data.
2. Do not modify CSV files.
3. Do not implement trading logic.
4. Do not add CI in this issue.
```

## User Stories

```text
As a researcher, I want invalid state paths flagged before sample analysis.
As a reviewer, I want B/C/D/A/E/F samples to remain auditable through explicit state paths.
As a Codex worker, I need a bounded validator with tests and exact verification commands.
```

## Acceptance Criteria

```text
1. Add scripts/validate_state_paths.py.
2. Add tests/test_validate_state_paths.py.
3. Validate current_state_path in both CSV files.
4. Allow pending placeholders in real pending samples: empty or pending_real_state_path.
5. Allow disputed markers with ? for E-class style paths.
6. Allow known non-core terminal markers: NO_PULLBACK_DIRECT_MARKUP and execution_not_actionable.
7. Fail unknown states.
8. Fail invalid transition pairs for normal non-disputed paths.
9. Print OK on pass and return non-zero on failure.
10. Existing CSV schema validator tests still pass.
```

## Edge Cases

```text
empty current_state_path in pending real rows
pending_real_state_path placeholder
disputed state path containing ?
path with unknown state
path with allowed terminal marker
path with invalid transition
```

## Testing Requirements

```text
python -m unittest discover -s tests
python scripts/validate_sample_csv.py
python scripts/validate_state_paths.py
```

## Human Decisions Needed

```text
Whether to later enforce state path for all real rows once real data exists: needs owner later.
Whether to model C-class direct-markup as formal state: needs owner later.
```
