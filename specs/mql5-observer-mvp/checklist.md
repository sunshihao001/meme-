# MQL5 Observer MVP Checklist

## Boundary
- [x] Indicator only, not EA.
- [x] No `CTrade` usage.
- [x] No `OrderSend` usage.
- [x] No automatic entry/exit instruction.

## Functionality
- [x] Manual FCZ input/marking works at source/compile level via shift parameters; manual chart visual confirmation remains pending.
- [x] POC/VAH/VAL are calculated inside the marked FCZ.
- [x] AVWAP ZoneStart and ImpulseStart are calculated and drawn as horizontal reference lines.
- [x] Retracement ratio is displayed and 0.618 / 0.786 / 0.886 reference lines are drawn.
- [x] Simplified current_state is displayed.
- [x] Minimal CSV export code includes the MVP header, including `fcz_bars`; runtime CSV generation still requires manual chart run.

## Verification
- [x] `python scripts/validate_all.py` passes for project docs.
- [x] MQL5 compile evidence is attached: `10_工程化交接/MQL5观察器MVP编译证据_v0.1.md`.
- [x] Recompile + MT5 data-dir install evidence is attached: `10_工程化交接/MQL5观察器MVP安装与运行验证_v0.1.md`.
- [ ] Manual chart run evidence is attached, or blocker brief explains why unavailable. Current status: blocked by lack of stable MT5 GUI / visual confirmation channel; see install/run evidence brief.
