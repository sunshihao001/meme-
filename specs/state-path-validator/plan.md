# State Path Validator Plan

## Approach

Implement a Python stdlib validator for `current_state_path` values in:

```text
07_样本标注/反证样本库_v0.1.csv
07_样本标注/模拟反证样本库_v0.1.csv
```

The validator should reuse no external dependencies.

## Known states

```text
STATE_IDLE
STATE_FCZ_CANDIDATE
STATE_FCZ_LOCKED
STATE_FIRST_IMPULSE
STATE_DEEP_WASHOUT_OR_SWEEP
STATE_RECLAIM_TEST
STATE_COST_ANCHOR_ACCEPTED
STATE_PULLBACK_TEST
STATE_SECOND_START_CANDIDATE
STATE_CONFIRMED_OBSERVATION
STATE_FAILED_RECLAIM
STATE_DEATH_MARKET_RISK
STATE_NO_TRADE
```

CSV values often omit `STATE_` prefix, so the validator should accept canonical names like `FCZ_LOCKED` and normalize them to `STATE_FCZ_LOCKED` where possible.

## Special allowed markers

```text
pending_real_state_path
NO_PULLBACK_DIRECT_MARKUP
execution_not_actionable
```

## Disputed paths

If a segment contains `?`, treat it as disputed and validate only that the base state is known when possible. Do not enforce transitions for disputed paths.

## Verification

Run:

```text
python -m unittest discover -s tests
python scripts/validate_sample_csv.py
python scripts/validate_state_paths.py
```
