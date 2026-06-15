import csv
import importlib.util
import tempfile
import unittest
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[1]
VALIDATOR_PATH = PROJECT_ROOT / "scripts" / "validate_state_paths.py"


def load_validator():
    spec = importlib.util.spec_from_file_location("validate_state_paths", VALIDATOR_PATH)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


class ValidateStatePathsTests(unittest.TestCase):
    def setUp(self):
        self.validator = load_validator()
        self.headers = ["sample_id", "sample_class", "sample_source", "is_real_sample", "current_state_path"]

    def write_csv(self, path, rows):
        with path.open("w", newline="", encoding="utf-8-sig") as f:
            writer = csv.DictWriter(f, fieldnames=self.headers)
            writer.writeheader()
            writer.writerows(rows)

    def row(self, sid="S1", klass="B", source="real_pending", real="true", path="FCZ_LOCKED>FIRST_IMPULSE"):
        return {
            "sample_id": sid,
            "sample_class": klass,
            "sample_source": source,
            "is_real_sample": real,
            "current_state_path": path,
        }

    def test_known_path_passes(self):
        with tempfile.TemporaryDirectory() as tmp:
            p = Path(tmp) / "samples.csv"
            self.write_csv(p, [self.row(path="FCZ_LOCKED>FIRST_IMPULSE>DEEP_WASHOUT_OR_SWEEP>RECLAIM_TEST")])
            self.assertEqual(self.validator.validate_csv(p, "test"), [])

    def test_pending_placeholder_passes(self):
        with tempfile.TemporaryDirectory() as tmp:
            p = Path(tmp) / "samples.csv"
            self.write_csv(p, [self.row(path="pending_real_state_path")])
            self.assertEqual(self.validator.validate_csv(p, "test"), [])

    def test_disputed_path_passes(self):
        with tempfile.TemporaryDirectory() as tmp:
            p = Path(tmp) / "samples.csv"
            self.write_csv(p, [self.row(klass="E", path="FCZ_CANDIDATE>FCZ_LOCKED? disputed>RECLAIM_TEST? disputed")])
            self.assertEqual(self.validator.validate_csv(p, "test"), [])

    def test_unknown_state_fails(self):
        with tempfile.TemporaryDirectory() as tmp:
            p = Path(tmp) / "samples.csv"
            self.write_csv(p, [self.row(path="FCZ_LOCKED>ALIEN_STATE")])
            errors = self.validator.validate_csv(p, "test")
            self.assertTrue(any("unknown state" in e for e in errors))

    def test_invalid_transition_fails(self):
        with tempfile.TemporaryDirectory() as tmp:
            p = Path(tmp) / "samples.csv"
            self.write_csv(p, [self.row(path="FCZ_LOCKED>DEATH_MARKET_RISK>FIRST_IMPULSE")])
            errors = self.validator.validate_csv(p, "test")
            self.assertTrue(any("invalid transition" in e for e in errors))

    def test_empty_path_allowed_for_real_pending(self):
        with tempfile.TemporaryDirectory() as tmp:
            p = Path(tmp) / "samples.csv"
            self.write_csv(p, [self.row(source="real_pending", path="")])
            self.assertEqual(self.validator.validate_csv(p, "test"), [])


if __name__ == "__main__":
    unittest.main()
