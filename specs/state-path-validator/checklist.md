# State Path Validator Checklist

```text
[ ] Add scripts/validate_state_paths.py
[ ] Add tests/test_validate_state_paths.py
[ ] Validate known state names
[ ] Normalize optional STATE_ prefix
[ ] Validate allowed transitions
[ ] Allow pending_real_state_path
[ ] Allow disputed ? paths without transition enforcement
[ ] Allow NO_PULLBACK_DIRECT_MARKUP
[ ] Allow execution_not_actionable
[ ] Run python -m unittest discover -s tests
[ ] Run python scripts/validate_sample_csv.py
[ ] Run python scripts/validate_state_paths.py
```
