# Codex Handoff: CSV Schema Validator

Read:
- AGENTS.md
- SOURCE_OF_TRUTH.md
- specs/csv-schema-validator/spec.md
- specs/csv-schema-validator/plan.md
- specs/csv-schema-validator/tasks.md
- specs/csv-schema-validator/checklist.md
- 10_工程化交接/issues/issue-001-csv-schema-validator.md

Task:
Implement this issue only: add a CSV schema validator for the real and simulated sample libraries.

Rules:
- Do not expand scope.
- Use TDD when practical.
- Add or update tests.
- Use Python stdlib unless project conventions require otherwise.
- Do not modify CSV files except if tests create temporary fixtures.
- Do not add CI in this issue.
- Do not fetch market data.
- Do not implement strategy logic.
- Do not create GitHub issues, branches, PRs, or releases unless separately authorized.
- Stop and ask if product/security/permission decision is needed.

Implement:
- scripts/validate_sample_csv.py
- tests/test_validate_sample_csv.py

Verification:
Run:

```text
python -m unittest discover -s tests
python scripts/validate_sample_csv.py
```

If Python command differs, use the available interpreter and report exact command.

Report:
- Changed files.
- Exact verification results.
- Any remaining risk or blocker.
