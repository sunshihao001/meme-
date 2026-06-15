import csv
import importlib.util
import tempfile
import unittest
from pathlib import Path


PROJECT_ROOT = Path(__file__).resolve().parents[1]
VALIDATOR_PATH = PROJECT_ROOT / "scripts" / "validate_sample_csv.py"


def load_validator():
    spec = importlib.util.spec_from_file_location("validate_sample_csv", VALIDATOR_PATH)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


class ValidateSampleCsvTests(unittest.TestCase):
    def setUp(self):
        self.validator = load_validator()
        self.headers = list(self.validator.EXPECTED_COLUMNS)

    def write_csv(self, path, rows, headers=None):
        headers = headers or self.headers
        with path.open("w", newline="", encoding="utf-8-sig") as f:
            writer = csv.DictWriter(f, fieldnames=headers)
            writer.writeheader()
            for row in rows:
                writer.writerow({h: row.get(h, "") for h in headers})

    def valid_row(self, sample_id="FCZ_0001", source="real_pending", is_real="true"):
        row = {h: "" for h in self.headers}
        row.update(
            {
                "sample_id": sample_id,
                "sample_class": "B",
                "sample_subclass": "B1",
                "reviewer": "test",
                "rule_version": "v0.1",
                "sample_source": source,
                "is_real_sample": is_real,
                "current_state_path": "FCZ_LOCKED>FAILED_RECLAIM",
            }
        )
        return row

    def test_valid_real_and_simulated_files_pass(self):
        with tempfile.TemporaryDirectory() as tmp:
            tmp = Path(tmp)
            real = tmp / "real.csv"
            sim = tmp / "sim.csv"
            self.write_csv(real, [self.valid_row("FCZ_B_0001", "real_pending", "true")])
            self.write_csv(sim, [self.valid_row("SIM_FCZ_B_0001", "synthetic", "false")])

            errors = self.validator.validate_files(real, sim)

            self.assertEqual(errors, [])

    def test_missing_column_fails(self):
        with tempfile.TemporaryDirectory() as tmp:
            tmp = Path(tmp)
            real = tmp / "real.csv"
            sim = tmp / "sim.csv"
            headers = self.headers[:-1]
            self.write_csv(real, [self.valid_row()], headers=headers)
            self.write_csv(sim, [self.valid_row("SIM_1", "synthetic", "false")])

            errors = self.validator.validate_files(real, sim)

            self.assertTrue(any("header mismatch" in e for e in errors))

    def test_duplicate_sample_id_fails(self):
        with tempfile.TemporaryDirectory() as tmp:
            tmp = Path(tmp)
            real = tmp / "real.csv"
            sim = tmp / "sim.csv"
            self.write_csv(real, [self.valid_row("DUP"), self.valid_row("DUP")])
            self.write_csv(sim, [self.valid_row("SIM_1", "synthetic", "false")])

            errors = self.validator.validate_files(real, sim)

            self.assertTrue(any("duplicate sample_id" in e for e in errors))

    def test_simulated_is_real_true_fails(self):
        with tempfile.TemporaryDirectory() as tmp:
            tmp = Path(tmp)
            real = tmp / "real.csv"
            sim = tmp / "sim.csv"
            self.write_csv(real, [self.valid_row("FCZ_1")])
            self.write_csv(sim, [self.valid_row("SIM_1", "synthetic", "true")])

            errors = self.validator.validate_files(real, sim)

            self.assertTrue(any("simulated CSV" in e and "is_real_sample" in e for e in errors))

    def test_real_sample_source_synthetic_fails(self):
        with tempfile.TemporaryDirectory() as tmp:
            tmp = Path(tmp)
            real = tmp / "real.csv"
            sim = tmp / "sim.csv"
            self.write_csv(real, [self.valid_row("FCZ_1", "synthetic", "true")])
            self.write_csv(sim, [self.valid_row("SIM_1", "synthetic", "false")])

            errors = self.validator.validate_files(real, sim)

            self.assertTrue(any("real CSV" in e and "sample_source" in e for e in errors))

    def test_malformed_row_width_fails(self):
        with tempfile.TemporaryDirectory() as tmp:
            tmp = Path(tmp)
            real = tmp / "real.csv"
            sim = tmp / "sim.csv"
            real.write_text(",".join(self.headers) + "\n" + ",".join(["x"] * (len(self.headers) + 1)) + "\n", encoding="utf-8-sig")
            self.write_csv(sim, [self.valid_row("SIM_1", "synthetic", "false")])

            errors = self.validator.validate_files(real, sim)

            self.assertTrue(any("row width" in e for e in errors))


if __name__ == "__main__":
    unittest.main()
