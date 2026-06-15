# Project Validate All Spec

## Background

The project now has two executable quality checks:

```text
python scripts/validate_sample_csv.py
python scripts/validate_state_paths.py
```

Unit tests also exist:

```text
python -m unittest discover -s tests
```

A single project-level command is needed so humans, Codex, and future CI can run the same baseline validation.

## Goal

Add `scripts/validate_all.py` to run the current project quality gate in order.

## Non-goals

```text
1. Do not add CI workflow in this issue.
2. Do not modify CSV data.
3. Do not implement strategy logic.
4. Do not add external dependencies.
```

## Acceptance Criteria

```text
1. `python scripts/validate_all.py` runs unit tests, CSV schema validation, and state path validation.
2. It prints each step name before running.
3. If any step fails, it exits non-zero and stops or reports failure clearly.
4. If all pass, it prints a final OK message.
5. `python -m unittest discover -s tests` passes.
6. `python scripts/validate_all.py` passes on current project files.
```

## Testing Requirements

Add unittest coverage for:

```text
1. all commands pass -> exit 0
2. a command fails -> exit non-zero
3. command list contains unit tests, validate_sample_csv, validate_state_paths
```

Use Python stdlib only.

## Human Decisions Needed

```text
None for local validate_all.py.
CI integration is separate and should be a later owner decision.
```
