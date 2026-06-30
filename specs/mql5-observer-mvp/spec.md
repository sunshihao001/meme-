# MQL5 Observer MVP Spec

## Goal
Create a bounded specification for the first MQL5 FCZ Cost Reclaim Observer MVP. The MVP is an observation/status-labeling indicator, not an Expert Advisor and not an automated trading system.

## Source Documents
- `08_指标需求/MQL5观察指标MVP开发计划_v0.1.md`
- `08_指标需求/MQL5观察指标需求_v0.2.md`
- `08_指标需求/MQL5观察指标字段映射与模块优先级_v0.1.md`
- `09_规则与回测/状态机规则整合_v0.1.md`
- `10_工程化交接/策略完善旧版字段状态机吸收审计_v0.1.md`

## In Scope
- Manual FCZ marking/input.
- POC / VAH / VAL calculation within the marked FCZ.
- AVWAP ZoneStart and ImpulseStart drawing.
- Manual first-impulse high and washout low markers.
- Retracement ratio display.
- POC/AVWAP relation display.
- Simplified observer state display.
- Minimal CSV export for sample labeling.

## Out of Scope
- Automatic trading.
- Any `CTrade`, `OrderSend`, or order-management logic.
- Full automatic FCZ detection.
- Full risk scoring automation.
- Backtesting engine.
- Multi-symbol scanner.
- Chain/DEX data integration.

## Acceptance Criteria
- The MVP spec preserves observer-only positioning.
- Implementation handoff forbids trading APIs.
- Input parameter table is copied from `MQL5观察指标MVP开发计划_v0.1.md` as candidate defaults, not validated thresholds.
- Output fields match the MVP CSV field list in the plan.
- The plan can be implemented in vertical slices.

## Verification
- Documentation validation: `python scripts/validate_all.py`.
- Future implementation verification must include compile/run proof from MetaEditor/MT5 or an explicit blocker brief if the environment is unavailable.
