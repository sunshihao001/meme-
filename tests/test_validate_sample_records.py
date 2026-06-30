import importlib.util
import tempfile
import unittest
from pathlib import Path


PROJECT_ROOT = Path(__file__).resolve().parents[1]
VALIDATOR_PATH = PROJECT_ROOT / "scripts" / "validate_sample_records.py"


def load_validator():
    spec = importlib.util.spec_from_file_location("validate_sample_records", VALIDATOR_PATH)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


VALID_RECORD = """# FCZ_X_0001 样本记录

## 1. 样本基础信息

```text
sample_id：FCZ_X_0001
sample_class：X
sample_subclass：X1
symbol：TOKEN
chain_or_market：sol
exchange_or_dex：pump_amm
timeframe：5m
sample_start_time：2026-01-01
sample_end_time：2026-01-01
reviewer：Hermes
review_date：2026-06-15
rule_version：v0.1
sample_source：real_pending
is_real_sample：true
```

## 2. 图表与原始资料

```text
source_chart_url：https://example.com/chart
raw_data_path：07_样本标注/raw_refs/example.json
screenshot_path：unknown
相关截图：unknown
相关备注：pending
```

## 4. 触发与结果

```text
entry_rule_triggered：unknown
triggered_group：unknown
entry_time：unknown
entry_price：unknown
stop_price：unknown
max_favorable_excursion_R：unknown
max_adverse_excursion_R：unknown
gross_realized_R：unknown
net_realized_R_after_cost：unknown
win_loss：unknown
failure_reason：unknown
final_classification：candidate_for_deeper_review
```

## 5. 风险评分

```text
commercial_actionability_score：2
```

## 6. 审计问题

```text
would_rule_have_triggered_ex_ante：unknown
was_boundary_moved_after_outcome：unknown
was_anchor_changed_after_outcome：unknown
is_failure_explained_by_new_rule：unknown
new_rule_needed：unknown
can_simpler_rule_explain_it：unknown
```

## 8. CSV 同步检查

必须同步更新：已同步到 07_样本标注/反证样本库_v0.1.csv

```text
07_样本标注/反证样本库_v0.1.csv
```

至少同步字段：已按下列字段同步

```text
sample_id
sample_class
sample_subclass
symbol
timeframe
rule_version
final_classification
```
"""


class ValidateSampleRecordsTests(unittest.TestCase):
    def setUp(self):
        self.validator = load_validator()

    def write_record(self, root: Path, name: str, body: str) -> Path:
        records = root / "07_样本标注" / "样本记录"
        records.mkdir(parents=True)
        path = records / name
        path.write_text(body, encoding="utf-8")
        return path

    def test_valid_record_passes(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            path = self.write_record(root, "FCZ_X_0001.md", VALID_RECORD)

            errors = self.validator.validate_record(path)

            self.assertEqual(errors, [])

    def test_missing_required_field_fails(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            body = VALID_RECORD.replace("reviewer：Hermes\n", "")
            path = self.write_record(root, "FCZ_X_0001.md", body)

            errors = self.validator.validate_record(path)

            self.assertTrue(any("missing required field" in error and "reviewer" in error for error in errors))

    def test_blank_critical_value_fails(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            body = VALID_RECORD.replace("source_chart_url：https://example.com/chart", "source_chart_url：")
            path = self.write_record(root, "FCZ_X_0001.md", body)

            errors = self.validator.validate_record(path)

            self.assertTrue(any("blank critical field" in error and "source_chart_url" in error for error in errors))

    def test_synced_record_with_unknown_sync_status_fails(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            body = VALID_RECORD.replace("至少同步字段：已按下列字段同步", "至少同步字段：unknown")
            path = self.write_record(root, "FCZ_X_0001.md", body)

            errors = self.validator.validate_record(path)

            self.assertTrue(any("CSV sync status" in error for error in errors))

    def test_directory_validation_finds_records(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            self.write_record(root, "FCZ_X_0001.md", VALID_RECORD)

            errors = self.validator.validate_records_dir(root / "07_样本标注" / "样本记录")

            self.assertEqual(errors, [])


if __name__ == "__main__":
    unittest.main()
