# CSV Schema Validator Plan

## Implementation approach

Build a small Python validator using stdlib only:

```text
csv
pathlib
argparse
sys
```

Default target files:

```text
07_样本标注/反证样本库_v0.1.csv
07_样本标注/模拟反证样本库_v0.1.csv
```

Expected behavior:

```text
python scripts/validate_sample_csv.py
```

prints success if both files pass, and exits non-zero with clear errors if any check fails.

---

## Expected schema source

The validator should define the canonical expected 58-column header in code for the first version.

Future improvement may extract schema from a JSON/YAML file, but that is out of scope.

---

## Validation rules

### Common rules

```text
1. File exists.
2. Header matches expected columns exactly and in order.
3. At least one data row exists.
4. Every row has same field count as header.
5. sample_id is non-empty.
6. sample_id is unique within file.
```

### Real CSV rules

```text
1. sample_source in {real, real_pending, imported, backtest}.
2. Current default: is_real_sample must normalize to true.
```

### Simulated CSV rules

```text
1. sample_source must be synthetic.
2. is_real_sample must normalize to false.
```

---

## Test plan

Create tests using unittest.

Suggested tests:

```text
test_valid_csvs_pass
test_missing_column_fails
test_duplicate_sample_id_fails
test_simulated_true_is_real_fails
test_real_synthetic_source_fails
test_bad_row_width_fails
```

Use temporary CSV fixtures in tests, not the project CSV files, where practical.

---

## Commands Codex should run

```text
python -m unittest discover -s tests
python scripts/validate_sample_csv.py
```

If Python command differs on environment, use the available Python interpreter and report exact command.
