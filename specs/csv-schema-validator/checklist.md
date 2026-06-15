# CSV Schema Validator Checklist

## Spec readiness

```text
[x] Goal defined
[x] Non-goals defined
[x] Acceptance criteria defined
[x] Edge cases defined
[x] Testing requirements defined
[x] Human decisions marked
```

## Implementation checklist

```text
[ ] Add scripts/validate_sample_csv.py
[ ] Add EXPECTED_COLUMNS with 58 columns
[ ] Validate real CSV rules
[ ] Validate simulated CSV rules
[ ] Validate duplicate sample_id
[ ] Validate row width
[ ] Print concise success output
[ ] Exit non-zero on failure
```

## Test checklist

```text
[ ] valid fixtures pass
[ ] missing column fails
[ ] duplicate sample_id fails
[ ] simulated is_real_sample=true fails
[ ] real sample_source=synthetic fails
[ ] malformed row width fails
```

## Verification checklist

```text
[ ] python -m unittest discover -s tests
[ ] python scripts/validate_sample_csv.py
[ ] Report changed files
[ ] Report exact verification output
```

## Owner checklist

```text
[ ] Confirm no CI workflow should be added in this issue
[ ] Confirm no GitHub issue should be created by Codex unless separately authorized
```
