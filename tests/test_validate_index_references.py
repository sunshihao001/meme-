import importlib.util
import tempfile
import unittest
from pathlib import Path


PROJECT_ROOT = Path(__file__).resolve().parents[1]
VALIDATOR_PATH = PROJECT_ROOT / "scripts" / "validate_index_references.py"


def load_validator():
    spec = importlib.util.spec_from_file_location("validate_index_references", VALIDATOR_PATH)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


class ValidateIndexReferencesTests(unittest.TestCase):
    def setUp(self):
        self.validator = load_validator()

    def write_index(self, root: Path, body: str) -> Path:
        index = root / "00_知识库设计规范" / "05_索引与变更记录" / "知识库索引_v0.1.md"
        index.parent.mkdir(parents=True)
        index.write_text(body, encoding="utf-8")
        return index

    def test_existing_file_and_directory_references_pass(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / "README.md").write_text("ok", encoding="utf-8")
            (root / "docs").mkdir()
            index = self.write_index(
                root,
                """
# index
```text
README.md
docs/
```
""",
            )

            errors = self.validator.validate_index(index, root)

            self.assertEqual(errors, [])

    def test_missing_reference_fails(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            index = self.write_index(
                root,
                """
```text
missing/file.md
```
""",
            )

            errors = self.validator.validate_index(index, root)

            self.assertTrue(any("missing index reference" in error for error in errors))
            self.assertTrue(any("missing/file.md" in error for error in errors))

    def test_tree_prefixes_are_normalized(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / "docs").mkdir()
            (root / "docs" / "a.md").write_text("ok", encoding="utf-8")
            index = self.write_index(
                root,
                """
```text
├─ docs/a.md
└─ docs/
```
""",
            )

            references = self.validator.extract_index_references(index)
            errors = self.validator.validate_index(index, root)

            self.assertIn("docs/a.md", references)
            self.assertIn("docs/", references)
            self.assertEqual(errors, [])

    def test_non_path_explanatory_lines_are_ignored(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / "README.md").write_text("ok", encoding="utf-8")
            index = self.write_index(
                root,
                """
```text
用途：说明文字，不是路径
当前最建议推进：
https://github.com/example/repo/issues/1
README.md
```
""",
            )

            references = self.validator.extract_index_references(index)
            errors = self.validator.validate_index(index, root)

            self.assertEqual(references, ["README.md"])
            self.assertEqual(errors, [])


if __name__ == "__main__":
    unittest.main()
