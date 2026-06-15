#!/usr/bin/env python
"""Run the project's baseline validation checks."""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[1]

COMMANDS = [
    [sys.executable, "-m", "unittest", "discover", "-s", "tests"],
    [sys.executable, "scripts/validate_sample_csv.py"],
    [sys.executable, "scripts/validate_state_paths.py"],
    [sys.executable, "scripts/validate_loop_agent_reports.py"],
    [sys.executable, "scripts/validate_index_references.py"],
    [sys.executable, "scripts/validate_sample_records.py"],
]


def _format_command(command: list[str]) -> str:
    return " ".join(command)


def run_commands(commands: list[list[str]] = COMMANDS) -> int:
    for command in commands:
        print(f"\n==> {_format_command(command)}")
        completed = subprocess.run(command, cwd=PROJECT_ROOT)
        if completed.returncode != 0:
            print(f"FAILED: {_format_command(command)} exited with {completed.returncode}")
            return completed.returncode
    print("\nOK: all project validation checks passed")
    return 0


def main() -> int:
    return run_commands(COMMANDS)


if __name__ == "__main__":
    raise SystemExit(main())
