import importlib.util
import tempfile
import textwrap
import unittest
from pathlib import Path


PROJECT_ROOT = Path(__file__).resolve().parents[1]
VALIDATOR_PATH = PROJECT_ROOT / "scripts" / "validate_loop_agent_reports.py"


def load_module():
    spec = importlib.util.spec_from_file_location("validate_loop_agent_reports", VALIDATOR_PATH)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


VALID_REPORT = """
# Loop Agent Demand Grilling Report

## 本轮唯一最高价值问题
如何防止循环代理只写方法论而没有执行证据？

## Skill Orchestration Evidence
- product_identity: Demand Cognition & Knowledge Integration Orchestrator
- skill_invocation_plan: dbs-good-question -> spec-first-ai-engineering
- skill_runtime_matrix: installed / loaded / executed / output_consumed / referenced_only / conditional_not_executed / missing / forbidden
- skill_handoff_chain: owner_request -> problem_statement -> validator quality gate
- missing_skill_bridge: sup / Superpowers brainstorming = missing_runtime_skill

## Skill Runtime Audit
- loaded: spec-first-ai-engineering, dbs-good-question
- referenced_only: github-pr-workflow
- conditional_not_executed: gmgn-token read-only not needed this round
- forbidden: swap, private key, auto trading, cron job

## 外部搜索来源
- external_search_sources: not_applicable
- not_applicable_reason: 本轮是 validator quality gate，不涉及 MQL5 指标/EA/回测/观察器 MVP。

## 输出类型与权限分类
- 输出类型: validator quality gate
- 权限分类: Autonomous

## 更新文件
- scripts/validate_loop_agent_reports.py
- tests/test_validate_loop_agent_reports.py

## 状态标注
- PROPOSED: future cron integration
- UNKNOWN: owner merge decision
- REQUIRES_OWNER: enabling branch protection

## 验证输出
python scripts/validate_all.py
OK: all project validation checks passed

## 下一轮建议
继续 TP-003 index reference validator。
"""


INVALID_REPORT = """
# Loop Agent Demand Grilling Report

## 本轮唯一最高价值问题
如何防止循环代理只写方法论而没有执行证据？

## 更新文件
- README.md
"""


class LoopAgentReportValidatorTests(unittest.TestCase):
    def setUp(self):
        self.module = load_module()

    def test_valid_report_passes_required_evidence_schema(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "loop_agent_demand_grilling_report_20990101_0000.md"
            path.write_text(textwrap.dedent(VALID_REPORT).strip() + "\n", encoding="utf-8")

            errors = self.module.validate_report_file(path)

        self.assertEqual(errors, [])

    def test_missing_required_evidence_is_rejected(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "loop_agent_demand_grilling_report_20990101_0001.md"
            path.write_text(textwrap.dedent(INVALID_REPORT).strip() + "\n", encoding="utf-8")

            errors = self.module.validate_report_file(path)

        self.assertTrue(any("loaded" in error for error in errors))
        self.assertTrue(any("referenced_only" in error for error in errors))
        self.assertTrue(any("验证输出" in error for error in errors))
        self.assertTrue(any("下一轮" in error for error in errors))

    def test_validate_reports_checks_only_loop_report_markdown_files(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            reports_dir = root / "specs" / "mql5-fcz-reclaim-model" / "reports"
            reports_dir.mkdir(parents=True)
            (reports_dir / "loop_agent_demand_grilling_report_20990101_0000.md").write_text(
                textwrap.dedent(VALID_REPORT).strip() + "\n",
                encoding="utf-8",
            )
            (reports_dir / "ordinary_notes.md").write_text("notes without schema\n", encoding="utf-8")

            errors = self.module.validate_reports(reports_dir)

        self.assertEqual(errors, [])


if __name__ == "__main__":
    unittest.main()
