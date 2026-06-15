# MQL5 Observer MVP Plan

## Slice 1 — Manual FCZ + Profile
- Add manual inputs or chart-object convention for FCZ bounds.
- Compute profile bins inside FCZ.
- Derive POC / VAH / VAL.
- Draw POC / VAH / VAL lines.

## Slice 2 — AVWAP Core
- Add ZoneStart and ImpulseStart anchors.
- Draw AVWAP ZoneStart and AVWAP ImpulseStart.
- Keep Reclaim/PullbackLow anchors disabled by default.

## Slice 3 — Retracement Reference
- Add manual first impulse high and washout low markers.
- Display retracement ratio.
- Draw 0.618-0.786 and 0.886 reference zones as semantic guides only.

## Slice 4 — Observer State + Export
- Display simplified current_state and allowed_mode.
- Export minimal CSV fields.
- Include positive_evidence / negative_evidence / missing_evidence text fields.

## Safety Boundary
- No trading API.
- No automated entry/exit suggestion.
- All thresholds are candidate observation defaults until sample validation.
