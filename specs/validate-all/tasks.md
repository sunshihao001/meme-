# Project Validate All Tasks

## Task 1

Create `tests/test_validate_all.py`.

Acceptance:

```text
Tests fail before scripts/validate_all.py exists.
```

## Task 2

Create `scripts/validate_all.py`.

Acceptance:

```text
run_commands returns 0 when all subprocesses return 0.
run_commands returns first non-zero code when a subprocess fails.
COMMANDS includes unittest, validate_sample_csv, validate_state_paths.
```

## Task 3

Run verification:

```text
python -m unittest discover -s tests
python scripts/validate_all.py
```

## Task 4

Update index and change log.
