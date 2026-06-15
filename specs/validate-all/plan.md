# Project Validate All Plan

## Implementation

Create:

```text
scripts/validate_all.py
tests/test_validate_all.py
```

`validate_all.py` should expose:

```python
COMMANDS = [...]
run_commands(commands=COMMANDS) -> int
main() -> int
```

This makes subprocess behavior testable without invoking the full test suite recursively.

## Commands

```text
python -m unittest discover -s tests
python scripts/validate_sample_csv.py
python scripts/validate_state_paths.py
```

Use `sys.executable` instead of hardcoded `python` internally.

## Verification

Run:

```text
python -m unittest discover -s tests
python scripts/validate_all.py
```
