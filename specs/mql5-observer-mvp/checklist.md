# MQL5 Observer MVP Checklist

## Boundary
- [ ] Indicator only, not EA.
- [ ] No `CTrade` usage.
- [ ] No `OrderSend` usage.
- [ ] No automatic entry/exit instruction.

## Functionality
- [ ] Manual FCZ input/marking works.
- [ ] POC/VAH/VAL are calculated inside the marked FCZ.
- [ ] AVWAP ZoneStart and ImpulseStart are drawn.
- [ ] Retracement ratio is displayed.
- [ ] Simplified current_state is displayed.
- [ ] Minimal CSV export works.

## Verification
- [ ] `python scripts/validate_all.py` passes for project docs.
- [ ] MQL5 compile evidence is attached, or blocker brief explains why unavailable.
- [ ] Manual chart run evidence is attached, or blocker brief explains why unavailable.
