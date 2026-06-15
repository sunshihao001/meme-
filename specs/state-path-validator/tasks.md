# State Path Validator Tasks

## Issue: Add state path validator for sample CSVs

### Goal

Validate that `current_state_path` values in real and simulated sample CSVs use known state-machine states and allowed transitions.

### Scope

Implement:

```text
scripts/validate_state_paths.py
tests/test_validate_state_paths.py
```

### Acceptance Criteria

```text
1. Known paths pass.
2. pending_real_state_path passes.
3. Empty path passes only for real_pending rows.
4. Disputed paths with ? pass without transition enforcement.
5. Unknown state fails.
6. Invalid transition fails.
7. Existing CSV schema validator still passes.
```

### Test Requirements

```text
python -m unittest discover -s tests
python scripts/validate_sample_csv.py
python scripts/validate_state_paths.py
```

### Suitable for Codex

```text
Yes. Small, bounded, testable.
```
