# Issue Draft: Add CSV schema validator for sample libraries

## Title

Add CSV schema validator for real and simulated sample libraries

## Goal

Add a lightweight validator that checks the real and simulated sample CSV files conform to the expected 58-column schema and source/realness rules.

## Background

The project has two CSV sample libraries:

```text
07_样本标注/反证样本库_v0.1.csv
07_样本标注/模拟反证样本库_v0.1.csv
```

Both should use the same 58-column schema. The real CSV should contain real or pending-real samples. The simulated CSV should contain only synthetic samples.

## Scope

Implement:

```text
scripts/validate_sample_csv.py
tests/test_validate_sample_csv.py
```

The validator must:

```text
1. Check both CSV files exist.
2. Check exact 58-column header order.
3. Check every row has the same field count as header.
4. Check sample_id is non-empty and unique within each file.
5. Check real CSV sample_source is one of real, real_pending, imported, backtest.
6. Check real CSV is_real_sample is true for current rows.
7. Check simulated CSV sample_source is synthetic.
8. Check simulated CSV is_real_sample is false.
9. Print success output on pass.
10. Exit non-zero and print clear errors on failure.
```

## Non-goals

```text
1. Do not auto-fix CSV files.
2. Do not fetch market data.
3. Do not implement strategy logic.
4. Do not add CI in this issue.
5. Do not create GitHub issues/PRs unless separately authorized.
```

## Acceptance Criteria

```text
1. `python -m unittest discover -s tests` passes.
2. `python scripts/validate_sample_csv.py` passes on current CSV files.
3. Tests cover missing column, duplicate sample_id, simulated is_real_sample=true, real sample_source=synthetic, and malformed row width.
4. Validator uses stdlib only unless project conventions require otherwise.
5. Codex reports changed files and exact verification output.
```

## Risk

```text
1. Hardcoding schema is acceptable for v0.1 but may need schema file later.
2. Real CSV imported/backtest exceptions are not fully decided; current default is is_real_sample=true for all real CSV rows.
```

## Suitable for Codex

```text
Yes. This is a small, bounded, testable task.
```
