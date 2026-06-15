#!/usr/bin/env python
"""Validate sample Markdown records for minimum field completeness."""

from __future__ import annotations

import re
import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[1]
DEFAULT_RECORDS_DIR = PROJECT_ROOT / "07_样本标注" / "样本记录"

FIELD_RE = re.compile(r"^\s*([^：:\n]+?)\s*[：:]\s*(.*)\s*$")

REQUIRED_FIELDS = {
    "sample_id",
    "sample_class",
    "sample_subclass",
    "symbol",
    "timeframe",
    "reviewer",
    "review_date",
    "rule_version",
    "sample_source",
    "is_real_sample",
    "source_chart_url",
    "raw_data_path",
    "entry_rule_triggered",
    "net_realized_R_after_cost",
    "win_loss",
    "failure_reason",
    "final_classification",
    "would_rule_have_triggered_ex_ante",
    "was_boundary_moved_after_outcome",
    "was_anchor_changed_after_outcome",
    "commercial_actionability_score",
}

CRITICAL_NONBLANK_FIELDS = {
    "sample_id",
    "sample_class",
    "sample_subclass",
    "reviewer",
    "review_date",
    "rule_version",
    "sample_source",
    "is_real_sample",
    "source_chart_url",
    "raw_data_path",
    "final_classification",
}

ALLOWED_PLACEHOLDERS = {"unknown", "pending", "real_pending", "pending_real_chart_url", "pending_real_raw_refs"}


def _parse_fields(text: str) -> dict[str, str]:
    fields: dict[str, str] = {}
    for line in text.splitlines():
        match = FIELD_RE.match(line)
        if not match:
            continue
        key = match.group(1).strip()
        value = match.group(2).strip()
        fields[key] = value
    return fields


def _blank(value: str | None) -> bool:
    return value is None or value.strip() == ""


def validate_record(path: Path) -> list[str]:
    path = Path(path)
    errors: list[str] = []
    if not path.exists():
        return [f"record missing: {path}"]

    text = path.read_text(encoding="utf-8")
    fields = _parse_fields(text)

    for field in sorted(REQUIRED_FIELDS):
        if field not in fields:
            errors.append(f"{path.name}: missing required field {field}")

    for field in sorted(CRITICAL_NONBLANK_FIELDS):
        if field in fields and _blank(fields[field]):
            errors.append(f"{path.name}: blank critical field {field}")

    sample_id = fields.get("sample_id", "").strip()
    if sample_id and sample_id != path.stem:
        errors.append(f"{path.name}: sample_id {sample_id!r} does not match filename stem {path.stem!r}")

    sync_line = next((line.strip() for line in text.splitlines() if line.strip().startswith("至少同步字段：")), "")
    if not sync_line:
        errors.append(f"{path.name}: CSV sync status line missing")
    else:
        sync_status = sync_line.split("：", 1)[1].strip() if "：" in sync_line else sync_line
        if sync_status == "unknown":
            errors.append(f"{path.name}: CSV sync status must not be unknown")

    final_classification = fields.get("final_classification", "").strip()
    if final_classification == "unknown":
        errors.append(f"{path.name}: final_classification must be classified or pending, not unknown")

    return errors


def validate_records_dir(records_dir: Path = DEFAULT_RECORDS_DIR) -> list[str]:
    records_dir = Path(records_dir)
    if not records_dir.exists():
        return [f"sample records directory missing: {records_dir}"]
    paths = sorted(records_dir.glob("*.md"))
    if not paths:
        return [f"sample records directory has no markdown files: {records_dir}"]
    errors: list[str] = []
    for path in paths:
        errors.extend(validate_record(path))
    return errors


def main() -> int:
    errors = validate_records_dir()
    if errors:
        print("Sample record markdown validation failed:")
        for error in errors:
            print(f"- {error}")
        return 1
    print(f"OK: sample markdown records valid ({len(list(DEFAULT_RECORDS_DIR.glob('*.md')))} record(s))")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
