import contextlib
import importlib.util
import io
import sys
import unittest
from pathlib import Path
from unittest import mock


PROJECT_ROOT = Path(__file__).resolve().parents[1]
VALIDATOR_PATH = PROJECT_ROOT / "scripts" / "validate_all.py"


def load_module():
    spec = importlib.util.spec_from_file_location("validate_all", VALIDATOR_PATH)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


class ValidateAllTests(unittest.TestCase):
    def setUp(self):
        self.module = load_module()

    def test_commands_include_all_quality_gates(self):
        command_text = [" ".join(cmd) for cmd in self.module.COMMANDS]
        self.assertTrue(any("unittest discover -s tests" in text for text in command_text))
        self.assertTrue(any("scripts/validate_sample_csv.py" in text for text in command_text))
        self.assertTrue(any("scripts/validate_state_paths.py" in text for text in command_text))
        self.assertTrue(any("scripts/validate_loop_agent_reports.py" in text for text in command_text))
        self.assertTrue(any("scripts/validate_index_references.py" in text for text in command_text))
        self.assertTrue(any("scripts/validate_sample_records.py" in text for text in command_text))

    def test_run_commands_returns_zero_when_all_pass(self):
        commands = [[sys.executable, "ok1"], [sys.executable, "ok2"]]
        with mock.patch.object(self.module.subprocess, "run") as run:
            run.return_value.returncode = 0
            with contextlib.redirect_stdout(io.StringIO()):
                result = self.module.run_commands(commands)
        self.assertEqual(result, 0)
        self.assertEqual(run.call_count, 2)

    def test_run_commands_returns_nonzero_when_command_fails(self):
        commands = [[sys.executable, "ok"], [sys.executable, "fail"], [sys.executable, "skip"]]
        with mock.patch.object(self.module.subprocess, "run") as run:
            run.side_effect = [
                mock.Mock(returncode=0),
                mock.Mock(returncode=7),
                mock.Mock(returncode=0),
            ]
            with contextlib.redirect_stdout(io.StringIO()):
                result = self.module.run_commands(commands)
        self.assertEqual(result, 7)
        self.assertEqual(run.call_count, 2)


if __name__ == "__main__":
    unittest.main()
