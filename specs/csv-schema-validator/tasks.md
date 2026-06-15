# CSV Schema Validator Tasks

## Task 1: Add validator script

Create:

```text
scripts/validate_sample_csv.py
```

Requirements:

```text
1. Define EXPECTED_COLUMNS with the 58-column schema.
2. Validate real CSV and simulated CSV by default.
3. Accept optional CLI args for custom real/simulated CSV paths if simple.
4. Print clear error messages.
5. Exit 0 on success, non-zero on failure.
6. Do not modify CSV files.
```

---

## Task 2: Add tests

Create:

```text
tests/test_validate_sample_csv.py
```

Use stdlib unittest unless project already has pytest.

Test cases:

```text
1. valid real/simulated fixtures pass.
2. missing column fails.
3. duplicate sample_id fails.
4. simulated row with is_real_sample=true fails.
5. real row with sample_source=synthetic fails.
6. malformed row width fails.
```

---

## Task 3: Run verification

Run:

```text
python -m unittest discover -s tests
python scripts/validate_sample_csv.py
```

Report exact output.

---

## Out of scope

```text
1. Adding CI workflow.
2. Auto-fixing CSV files.
3. Fetching market data.
4. Implementing strategy logic.
5. Creating GitHub issue or PR without owner authorization.
```
