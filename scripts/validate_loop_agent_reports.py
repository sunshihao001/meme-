#!/usr/bin/env python
"""Validate loop-agent demand-grilling report evidence.

The validator intentionally checks a minimal evidence schema, not whether the
report's reasoning is correct. It prevents false completion by requiring each
loop report to state the question, runtime skill classification, authority,
changed files, uncertainty/owner labels, verification output, and next entry.
"""

from __future__ import annotations

import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[1]
DEFAULT_REPORTS_DIR = PROJECT_ROOT / "specs" / "mql5-fcz-reclaim-model" / "reports"
REPORT_GLOB = "loop_agent_demand_grilling_report_*.md"

REQUIRED_EVIDENCE: list[tuple[str, tuple[str, ...]]] = [
    ("问题空间或当前收敛切片", ("本轮唯一最高价值问题", "current_convergence_slice", "当前收敛切片", "problem_world", "concept_map_seed", "issue_tree_seed")),
    ("外部搜索来源", ("external_search_sources", "external_sources_absorbed", "not_applicable_reason", "https://www.mql5.com/zh/articles", "mql5.com/zh/articles")),
    ("product_identity", ("product_identity", "Demand Cognition", "需求认知")),
    ("skill_invocation_plan", ("skill_invocation_plan", "技能编排计划")),
    ("skill_runtime_matrix", ("skill_runtime_matrix", "installed", "output_consumed")),
    ("skill_handoff_chain", ("skill_handoff_chain", "handoff_chain", "输出交接")),
    ("missing_skill_bridge", ("missing_skill_bridge", "missing_runtime_skill", "缺失技能桥接")),
    ("loaded", ("loaded", "实际加载技能", "实际加载")),
    ("referenced_only", ("referenced_only", "referenced only", "referenced_only", "referenced /", "只 referenced")),
    ("conditional_not_executed", ("conditional_not_executed", "conditional", "not_executed", "未调用", "按需但未调用", "not called")),
    ("forbidden", ("forbidden", "禁止调用", "not called")),
    ("输出类型", ("输出类型", "output_type", "output type")),
    ("权限分类", ("权限分类", "authority", "Autonomous", "Needs owner")),
    ("更新文件", ("更新文件", "changed files", "本轮更新文件")),
    ("PROPOSED", ("PROPOSED",)),
    ("UNKNOWN", ("UNKNOWN",)),
    ("REQUIRES_OWNER", ("REQUIRES_OWNER",)),
    ("验证输出", ("验证输出", "validate_all", "validation output")),
    ("下一轮", ("下一轮", "next round", "下一步")),
]


def _normalize(text: str) -> str:
    return text.casefold().replace("-", "_").replace(" ", "_")


def validate_report_text(text: str, source: str = "<text>") -> list[str]:
    """Return schema errors for a single report body."""
    normalized = _normalize(text)
    errors: list[str] = []

    for evidence_name, aliases in REQUIRED_EVIDENCE:
        if not any(_normalize(alias) in normalized for alias in aliases):
            errors.append(f"{source}: missing required evidence {evidence_name!r}")

    return errors


def validate_report_file(path: Path) -> list[str]:
    """Return schema errors for one markdown report file."""
    path = Path(path)
    if not path.exists():
        return [f"report missing: {path}"]
    if not path.is_file():
        return [f"report path is not a file: {path}"]

    text = path.read_text(encoding="utf-8-sig")
    return validate_report_text(text, str(path))


def find_report_files(reports_dir: Path = DEFAULT_REPORTS_DIR) -> list[Path]:
    reports_dir = Path(reports_dir)
    if not reports_dir.exists():
        return []
    return sorted(reports_dir.glob(REPORT_GLOB))


def validate_reports(reports_dir: Path = DEFAULT_REPORTS_DIR) -> list[str]:
    """Validate all loop report markdown files under reports_dir."""
    reports_dir = Path(reports_dir)
    if not reports_dir.exists():
        return [f"loop-agent reports directory missing: {reports_dir}"]

    report_files = find_report_files(reports_dir)
    if not report_files:
        return [f"no loop-agent reports found in {reports_dir} matching {REPORT_GLOB}"]

    errors: list[str] = []
    for path in report_files:
        errors.extend(validate_report_file(path))
    return errors


def main() -> int:
    errors = validate_reports(DEFAULT_REPORTS_DIR)
    if errors:
        print("Loop-agent report validation failed:")
        for error in errors:
            print(f"- {error}")
        return 1

    count = len(find_report_files(DEFAULT_REPORTS_DIR))
    print(f"OK: loop-agent reports valid ({count} report(s); dir={DEFAULT_REPORTS_DIR})")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
