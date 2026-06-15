# CSV Schema Validator Spec

> Feature: csv-schema-validator  
> Status: ready-for-issue-draft / not-yet-implemented  
> Owner decision: selected as first Codex-executable feature  

---

## Background

The project now has two CSV sample libraries:

```text
07_样本标注/反证样本库_v0.1.csv
07_样本标注/模拟反证样本库_v0.1.csv
```

Both were upgraded to a 58-column schema that includes state-machine audit fields:

```text
sample_source
is_real_sample
current_state_path
state_invalidated_reason
entry_lag_bars
post_signal_break_anchor_bars
```

Manual edits can easily cause schema drift, missing columns, wrong row widths, or synthetic samples leaking into the real sample library. A small validator is needed before any Codex-driven or human-driven sample work continues.

---

## Goal

Create a lightweight CSV schema validator that verifies the real and simulated sample CSV files conform to the expected schema and basic source/realness rules.

The validator should be runnable locally and suitable for CI later.

---

## Non-goals

This feature does not:

```text
1. Validate trading strategy correctness.
2. Calculate win rate, expectancy, R values, or backtest results.
3. Fetch real market data.
4. Modify sample rows automatically.
5. Create GitHub issues or PRs.
6. Implement MQL5 indicators.
```

---

## User Stories

### Story 1: Maintainer validates schema before editing samples

As a maintainer, I want to run one command that checks both real and simulated CSV sample libraries, so that schema drift is caught before sample work continues.

### Story 2: Codex has a safe first task

As an AI coding agent, I need a small, testable task with clear acceptance criteria, so that I can implement and verify without expanding scope.

### Story 3: Reviewer can trust verification output

As a reviewer, I want the validator to print exact pass/fail messages and exit non-zero on failure, so that CI can enforce it later.

---

## Acceptance Criteria

### Required behavior

```text
1. Validator checks both CSV files exist.
2. Validator checks both CSV files have exactly the expected 58 columns in the expected order.
3. Validator checks every row has the same number of fields as the header.
4. Validator checks real CSV sample_source is one of: real, real_pending, imported, backtest.
5. Validator checks real CSV is_real_sample is true for all current rows unless explicitly marked imported/backtest with documented exception.
6. Validator checks simulated CSV sample_source is synthetic for all rows.
7. Validator checks simulated CSV is_real_sample is false for all rows.
8. Validator checks sample_id is non-empty and unique within each file.
9. Validator prints a concise success summary on pass.
10. Validator exits with non-zero status and clear errors on failure.
```

### Expected files

Validator implementation should live in one of these locations, unless repo convention says otherwise:

```text
scripts/validate_sample_csv.py
```

Test file should live in one of these locations, unless repo convention says otherwise:

```text
tests/test_validate_sample_csv.py
```

If the project has no test framework yet, Codex may add a minimal Python stdlib `unittest` test file.

---

## Edge Cases

```text
1. CSV contains UTF-8 BOM.
2. CSV contains Chinese notes.
3. CSV contains blank optional fields.
4. File has header but no data rows.
5. Row has extra trailing comma.
6. Row has fewer columns than header.
7. Duplicate sample_id.
8. sample_source has typo such as synthethic.
9. is_real_sample uses TRUE/FALSE uppercase.
10. CSV file path contains Chinese characters.
```

Suggested policy:

```text
- UTF-8 BOM: accept.
- Chinese text: accept.
- Blank optional fields: accept.
- Header-only file: fail for current project because both files should have rows.
- TRUE/FALSE uppercase: accept by normalizing case.
```

---

## Failure Modes

```text
1. Validator silently passes malformed CSV.
2. Validator depends on current working directory too rigidly.
3. Validator rewrites CSV without owner permission.
4. Validator falsely rejects valid Chinese text or BOM.
5. Validator hardcodes unstable row counts instead of validating schema and core rules.
```

---

## Security / Privacy

```text
1. Validator must not read credentials.
2. Validator must not send network requests.
3. Validator must not modify files by default.
4. Validator should only read the configured CSV files.
```

---

## Testing Requirements

At minimum:

```text
1. Unit test: valid real and simulated CSV fixtures pass.
2. Unit test: missing required column fails.
3. Unit test: duplicate sample_id fails.
4. Unit test: simulated CSV with is_real_sample=true fails.
5. Unit test: real CSV with sample_source=synthetic fails.
6. Unit test: malformed row width fails.
```

If using Python stdlib only:

```text
python -m unittest discover -s tests
```

Manual validation command:

```text
python scripts/validate_sample_csv.py
```

---

## QA Requirements

Codex must report:

```text
1. Changed files.
2. Exact command used to run tests.
3. Exact command used to validate current CSVs.
4. Exact output of both commands.
```

---

## Human Decisions Needed

```text
1. Whether validator should allow imported/backtest rows with is_real_sample=false: UNKNOWN, default no for current rows.
2. Whether to place scripts under scripts/ or another project convention: default scripts/.
3. Whether to add CI now: no, separate issue.
```
