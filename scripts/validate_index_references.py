#!/usr/bin/env python
"""Validate that project-local paths listed in the knowledge-base index exist.

The validator intentionally checks only path-like entries inside fenced code
blocks. Explanatory prose, URLs, and obvious labels are ignored so the index can
remain human-readable while still catching stale file references.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[1]
DEFAULT_INDEX = PROJECT_ROOT / "00_知识库设计规范" / "05_索引与变更记录" / "知识库索引_v0.1.md"

TREE_PREFIX_RE = re.compile(r"^(?:[│\s]*[├└]─\s*)+")
URL_RE = re.compile(r"^[a-zA-Z][a-zA-Z0-9+.-]*://")
EXPLANATORY_MARKERS = (
    "：",
    ": ",
    "用途",
    "当前",
    "后续",
    "如果",
    "如涉及",
    "Owner",
)
PATH_HINTS = ("/", "\\", ".md", ".py", ".csv", ".json", ".yml", ".yaml", ".txt", ".mq5", ".ex5")


def _inside_fenced_code_lines(text: str) -> list[tuple[int, str]]:
    lines: list[tuple[int, str]] = []
    in_fence = False
    for line_no, line in enumerate(text.splitlines(), start=1):
        stripped = line.strip()
        if stripped.startswith("```"):
            in_fence = not in_fence
            continue
        if in_fence:
            lines.append((line_no, line.rstrip()))
    return lines


def _normalize_reference(raw: str) -> str | None:
    value = raw.strip()
    if not value:
        return None

    value = TREE_PREFIX_RE.sub("", value).strip()
    value = value.strip("` ")
    if not value or URL_RE.match(value):
        return None
    if value.startswith("#") or value.startswith("-"):
        return None
    if "*" in value or value.endswith(":"):
        return None
    if any(marker in value for marker in EXPLANATORY_MARKERS):
        return None
    if not any(hint in value for hint in PATH_HINTS):
        return None

    value = value.replace("\\", "/")
    while value.startswith("./"):
        value = value[2:]
    if value.startswith("/"):
        return None
    if ".." in Path(value).parts:
        return None
    return value


def extract_index_references(index_path: Path = DEFAULT_INDEX) -> list[str]:
    text = Path(index_path).read_text(encoding="utf-8")
    refs: list[str] = []
    for _line_no, raw in _inside_fenced_code_lines(text):
        ref = _normalize_reference(raw)
        if ref:
            refs.append(ref)
    return refs


def validate_index(index_path: Path = DEFAULT_INDEX, project_root: Path = PROJECT_ROOT) -> list[str]:
    errors: list[str] = []
    index_path = Path(index_path)
    project_root = Path(project_root)
    if not index_path.exists():
        return [f"index file missing: {index_path}"]

    text = index_path.read_text(encoding="utf-8")
    context_prefix = ""
    for line_no, raw in _inside_fenced_code_lines(text):
        normalized_raw = _normalize_reference(raw)
        if normalized_raw and normalized_raw.endswith("/"):
            context_prefix = normalized_raw
            ref = normalized_raw
        elif normalized_raw and context_prefix:
            prefixed = context_prefix + normalized_raw
            if (project_root / prefixed).exists():
                ref = prefixed
            else:
                ref = normalized_raw
        else:
            ref = normalized_raw
        if not ref:
            continue
        candidate = project_root / ref
        if not candidate.exists():
            errors.append(f"line {line_no}: missing index reference: {ref}")
    return errors


def main() -> int:
    errors = validate_index()
    if errors:
        print("Index reference validation failed:")
        for error in errors:
            print(f"- {error}")
        return 1
    print(f"OK: index references valid ({len(extract_index_references())} reference(s))")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
