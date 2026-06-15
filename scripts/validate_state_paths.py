#!/usr/bin/env python
"""Validate sample current_state_path values against the project state machine."""

from __future__ import annotations

import csv
import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[1]
DEFAULT_REAL_CSV = PROJECT_ROOT / "07_样本标注" / "反证样本库_v0.1.csv"
DEFAULT_SIMULATED_CSV = PROJECT_ROOT / "07_样本标注" / "模拟反证样本库_v0.1.csv"

KNOWN_STATES = {
    "IDLE",
    "FCZ_CANDIDATE",
    "FCZ_LOCKED",
    "FIRST_IMPULSE",
    "DEEP_WASHOUT_OR_SWEEP",
    "RECLAIM_TEST",
    "COST_ANCHOR_ACCEPTED",
    "PULLBACK_TEST",
    "SECOND_START_CANDIDATE",
    "CONFIRMED_OBSERVATION",
    "FAILED_RECLAIM",
    "DEATH_MARKET_RISK",
    "NO_TRADE",
}

SPECIAL_MARKERS = {
    "pending_real_state_path",
    "NO_PULLBACK_DIRECT_MARKUP",
    "execution_not_actionable",
}

ALLOWED_TRANSITIONS = {
    "IDLE": {"FCZ_CANDIDATE", "NO_TRADE"},
    "FCZ_CANDIDATE": {"FCZ_LOCKED", "IDLE", "NO_TRADE"},
    "FCZ_LOCKED": {"FIRST_IMPULSE", "NO_TRADE", "RECLAIM_TEST"},
    "FIRST_IMPULSE": {"DEEP_WASHOUT_OR_SWEEP", "DEATH_MARKET_RISK", "NO_PULLBACK_DIRECT_MARKUP"},
    "DEEP_WASHOUT_OR_SWEEP": {"RECLAIM_TEST", "DEATH_MARKET_RISK", "NO_TRADE"},
    "RECLAIM_TEST": {"COST_ANCHOR_ACCEPTED", "FAILED_RECLAIM", "DEATH_MARKET_RISK", "NO_TRADE"},
    "COST_ANCHOR_ACCEPTED": {"PULLBACK_TEST", "SECOND_START_CANDIDATE", "FAILED_RECLAIM"},
    "PULLBACK_TEST": {"SECOND_START_CANDIDATE", "FAILED_RECLAIM", "DEATH_MARKET_RISK"},
    "SECOND_START_CANDIDATE": {"CONFIRMED_OBSERVATION", "FAILED_RECLAIM", "DEATH_MARKET_RISK", "execution_not_actionable"},
    "CONFIRMED_OBSERVATION": {"FAILED_RECLAIM", "DEATH_MARKET_RISK", "execution_not_actionable"},
    "FAILED_RECLAIM": {"DEATH_MARKET_RISK", "NO_TRADE"},
    "DEATH_MARKET_RISK": {"NO_TRADE"},
    "NO_TRADE": set(),
    "NO_PULLBACK_DIRECT_MARKUP": set(),
    "execution_not_actionable": set(),
}


def _clean_segment(segment: str) -> tuple[str, bool]:
    segment = (segment or "").strip()
    disputed = "?" in segment
    segment = segment.split("?", 1)[0].strip()
    segment = segment.split()[0].strip() if segment else segment
    if segment.startswith("STATE_"):
        segment = segment[len("STATE_") :]
    return segment, disputed


def _is_pending(row: dict[str, str]) -> bool:
    return row.get("sample_source", "").strip() == "real_pending"


def validate_state_path(path: str, row: dict[str, str], label: str, line: int) -> list[str]:
    errors: list[str] = []
    path = (path or "").strip()
    if not path:
        if _is_pending(row):
            return []
        return [f"{label} line {line}: current_state_path is required for non-pending rows"]
    if path in SPECIAL_MARKERS:
        return []

    raw_segments = [part.strip() for part in path.split(">") if part.strip()]
    if not raw_segments:
        return [] if _is_pending(row) else [f"{label} line {line}: current_state_path has no states"]

    normalized: list[str] = []
    disputed_path = False
    for raw in raw_segments:
        state, disputed = _clean_segment(raw)
        disputed_path = disputed_path or disputed
        if state in SPECIAL_MARKERS:
            normalized.append(state)
            continue
        if state not in KNOWN_STATES:
            errors.append(f"{label} line {line}: unknown state {raw!r} in current_state_path")
        normalized.append(state)

    if errors or disputed_path:
        return errors

    for prev, nxt in zip(normalized, normalized[1:]):
        allowed = ALLOWED_TRANSITIONS.get(prev, set())
        if nxt not in allowed:
            errors.append(f"{label} line {line}: invalid transition {prev}>{nxt}")
    return errors


def validate_csv(path: Path, label: str) -> list[str]:
    errors: list[str] = []
    if not path.exists():
        return [f"{label} CSV missing: {path}"]
    with path.open(newline="", encoding="utf-8-sig") as f:
        reader = csv.DictReader(f)
        if not reader.fieldnames or "current_state_path" not in reader.fieldnames:
            return [f"{label} CSV missing current_state_path column: {path}"]
        for line, row in enumerate(reader, start=2):
            errors.extend(validate_state_path(row.get("current_state_path", ""), row, label, line))
    return errors


def validate_files(real_csv: Path = DEFAULT_REAL_CSV, simulated_csv: Path = DEFAULT_SIMULATED_CSV) -> list[str]:
    errors: list[str] = []
    errors.extend(validate_csv(Path(real_csv), "real"))
    errors.extend(validate_csv(Path(simulated_csv), "simulated"))
    return errors


def main() -> int:
    errors = validate_files()
    if errors:
        print("CSV state path validation failed:")
        for error in errors:
            print(f"- {error}")
        return 1
    print("OK: sample CSV state paths valid")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
