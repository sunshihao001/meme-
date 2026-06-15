# PR Draft: Project Validation Quality Gate

## Summary

- Adds project-level validation gate via `scripts/validate_all.py`.
- Adds CSV schema and state-path validators with unit tests.
- Adds GitHub Actions workflow draft to run validation on PRs and main pushes.
- Adds PR description template and GitHub/CI connection plan.

## Linked Issue / Spec

```text
Issue: local draft / GitHub issue UNKNOWN
Specs:
- specs/csv-schema-validator/spec.md
- specs/state-path-validator/spec.md
- specs/validate-all/spec.md
```

## Scope

### In scope

```text
- Validate sample CSV schema.
- Validate sample current_state_path fields.
- Run all current quality checks through one command.
- Provide CI workflow draft.
```

### Out of scope

```text
- No market data fetching.
- No strategy logic changes.
- No MQL5 indicator implementation.
- No GitHub push/PR creation until repo and permissions are confirmed.
```

## Changed Files

```text
scripts/validate_sample_csv.py
scripts/validate_state_paths.py
scripts/validate_all.py
tests/test_validate_sample_csv.py
tests/test_validate_state_paths.py
tests/test_validate_all.py
.github/workflows/validate.yml
.gitignore
10_工程化交接/pr_templates/project_validation_pr_description.md
10_工程化交接/GitHub与CI接入规划_v0.1.md
```

## Verification

### Commands run

```text
python scripts/validate_all.py
```

### Exact output

```text
...............
----------------------------------------------------------------------
Ran 15 tests in 0.090s

OK
OK: sample CSV schema valid (58 columns; real=反证样本库_v0.1.csv; simulated=模拟反证样本库_v0.1.csv)
OK: sample CSV state paths valid

==> C:\Users\Administrator\AppData\Local\hermes\hermes-agent\venv\Scripts\python.exe -m unittest discover -s tests

==> C:\Users\Administrator\AppData\Local\hermes\hermes-agent\venv\Scripts\python.exe scripts/validate_sample_csv.py

==> C:\Users\Administrator\AppData\Local\hermes\hermes-agent\venv\Scripts\python.exe scripts/validate_state_paths.py

OK: all project validation checks passed
```

## Risk Review

### Product risk

```text
Low. This PR adds validation infrastructure only.
```

### Technical risk

```text
Medium-low. Schema is hardcoded for v0.1; future schema evolution needs explicit update.
```

### Security / permission risk

```text
Low locally. GitHub push/PR/CI activation requires owner confirmation.
```

### Data risk

```text
Low. Validators read CSV files only and do not mutate sample data.
```

## QA Notes

```text
UI involved: no
Playwright required: no
Accessibility check required: no
Security-sensitive logic: no
External credentials used: no
```

## Owner Decision Needed

```text
- [ ] Provide GitHub repo URL or owner/repo.
- [ ] Confirm whether current directory should be initialized as a git repo.
- [ ] Confirm whether .github/workflows/validate.yml may be pushed.
- [ ] Confirm whether to create GitHub issue/PR after repo is configured.
```

## Checklist

```text
- [x] Spec exists
- [x] Scope limited
- [x] Tests added
- [x] Validation run locally
- [x] Changed files listed
- [x] Exact verification output pasted
- [x] Owner decisions marked
```
