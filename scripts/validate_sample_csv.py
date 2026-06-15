#!/usr/bin/env python
"""Validate real and simulated sample CSV schemas.

This script intentionally uses only the Python standard library so it can run
locally and later in CI without dependency setup.
"""

from __future__ import annotations

import csv
import sys
from pathlib import Path

EXPECTED_COLUMNS = [
    "sample_id",
    "sample_class",
    "sample_subclass",
    "symbol",
    "chain_or_market",
    "exchange_or_dex",
    "timeframe",
    "sample_start_time",
    "sample_end_time",
    "reviewer",
    "review_date",
    "rule_version",
    "sample_source",
    "is_real_sample",
    "current_state_path",
    "state_invalidated_reason",
    "entry_lag_bars",
    "post_signal_break_anchor_bars",
    "first_control_zone_detected",
    "fcz_high",
    "fcz_low",
    "poc_level",
    "vah_level",
    "val_level",
    "first_impulse_done",
    "retracement_ratio",
    "deep_washout_detected",
    "sweep_detected",
    "sweep_grade",
    "sweep_reclaim_bars",
    "value_area_reentered",
    "poc_reclaimed",
    "avwap_reclaimed",
    "avwap_confluence_count",
    "best_respected_avwap_anchor",
    "pullback_holds_anchor",
    "second_push_confirmed",
    "bos_after_reclaim",
    "death_market_score",
    "bull_trap_score",
    "failed_reclaim_score",
    "entry_rule_triggered",
    "triggered_group",
    "entry_time",
    "entry_price",
    "stop_price",
    "max_favorable_excursion_R",
    "max_adverse_excursion_R",
    "gross_realized_R",
    "net_realized_R_after_cost",
    "win_loss",
    "failure_reason",
    "final_classification",
    "would_rule_have_triggered_ex_ante",
    "was_boundary_moved_after_outcome",
    "was_anchor_changed_after_outcome",
    "commercial_actionability_score",
    "notes",
]

REAL_ALLOWED_SOURCES = {"real", "real_pending", "imported", "backtest"}
PROJECT_ROOT = Path(__file__).resolve().parents[1]
DEFAULT_REAL_CSV = PROJECT_ROOT / "07_样本标注" / "反证样本库_v0.1.csv"
DEFAULT_SIMULATED_CSV = PROJECT_ROOT / "07_样本标注" / "模拟反证样本库_v0.1.csv"


def _truthy(value: str) -> str:
    return (value or "").strip().lower()


def _read_csv(path: Path, label: str) -> tuple[list[str], list[dict[str, str]], list[str]]:
    errors: list[str] = []
    if not path.exists():
        return [], [], [f"{label} CSV missing: {path}"]

    with path.open(newline="", encoding="utf-8-sig") as f:
        raw_rows = list(csv.reader(f))

    if not raw_rows:
        return [], [], [f"{label} CSV is empty: {path}"]

    header = raw_rows[0]
    for index, row in enumerate(raw_rows[1:], start=2):
        if len(row) != len(header):
            errors.append(
                f"{label} CSV row width mismatch at line {index}: "
                f"expected {len(header)}, got {len(row)}"
            )

    rows = [dict(zip(header, row)) for row in raw_rows[1:] if len(row) == len(header)]
    return header, rows, errors


def _validate_header(header: list[str], label: str) -> list[str]:
    if header == EXPECTED_COLUMNS:
        return []
    return [
        f"{label} CSV header mismatch: expected {len(EXPECTED_COLUMNS)} columns "
        f"in configured order, got {len(header)} columns"
    ]


def _validate_common_rows(rows: list[dict[str, str]], label: str) -> list[str]:
    errors: list[str] = []
    seen: set[str] = set()
    for index, row in enumerate(rows, start=2):
        sample_id = row.get("sample_id", "").strip()
        if not sample_id:
            errors.append(f"{label} CSV line {index}: sample_id is required")
        elif sample_id in seen:
            errors.append(f"{label} CSV line {index}: duplicate sample_id {sample_id!r}")
        seen.add(sample_id)
    return errors


def _validate_real_rows(rows: list[dict[str, str]]) -> list[str]:
    errors: list[str] = []
    for index, row in enumerate(rows, start=2):
        source = row.get("sample_source", "").strip()
        is_real = _truthy(row.get("is_real_sample", ""))
        if source not in REAL_ALLOWED_SOURCES:
            errors.append(
                f"real CSV line {index}: sample_source must be one of "
                f"{sorted(REAL_ALLOWED_SOURCES)}, got {source!r}"
            )
        if is_real != "true":
            errors.append(
                f"real CSV line {index}: is_real_sample must be true, "
                f"got {row.get('is_real_sample', '')!r}"
            )
    return errors


def _validate_simulated_rows(rows: list[dict[str, str]]) -> list[str]:
    errors: list[str] = []
    for index, row in enumerate(rows, start=2):
        source = row.get("sample_source", "").strip()
        is_real = _truthy(row.get("is_real_sample", ""))
        if source != "synthetic":
            errors.append(
                f"simulated CSV line {index}: sample_source must be synthetic, got {source!r}"
            )
        if is_real != "false":
            errors.append(
                f"simulated CSV line {index}: is_real_sample must be false, "
                f"got {row.get('is_real_sample', '')!r}"
            )
    return errors


def validate_files(real_csv: Path = DEFAULT_REAL_CSV, simulated_csv: Path = DEFAULT_SIMULATED_CSV) -> list[str]:
    errors: list[str] = []

    real_header, real_rows, real_read_errors = _read_csv(Path(real_csv), "real")
    sim_header, sim_rows, sim_read_errors = _read_csv(Path(simulated_csv), "simulated")
    errors.extend(real_read_errors)
    errors.extend(sim_read_errors)

    if real_header:
        errors.extend(_validate_header(real_header, "real"))
        errors.extend(_validate_common_rows(real_rows, "real"))
        errors.extend(_validate_real_rows(real_rows))
    if sim_header:
        errors.extend(_validate_header(sim_header, "simulated"))
        errors.extend(_validate_common_rows(sim_rows, "simulated"))
        errors.extend(_validate_simulated_rows(sim_rows))

    return errors


def main() -> int:
    errors = validate_files()
    if errors:
        print("CSV sample schema validation failed:")
        for error in errors:
            print(f"- {error}")
        return 1

    print(
        "OK: sample CSV schema valid "
        f"({len(EXPECTED_COLUMNS)} columns; real={DEFAULT_REAL_CSV.name}; "
        f"simulated={DEFAULT_SIMULATED_CSV.name})"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
