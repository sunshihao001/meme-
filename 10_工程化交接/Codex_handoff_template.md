# Codex Handoff 模板

```md
Read:
- AGENTS.md
- SOURCE_OF_TRUTH.md
- specs/<feature>/spec.md
- specs/<feature>/plan.md
- specs/<feature>/tasks.md
- specs/<feature>/checklist.md
- GitHub issue #<number>

Task:
Implement this issue only.

Rules:
- Do not expand scope.
- Use TDD when practical.
- Add or update tests.
- Run available checks.
- Report changed files.
- Report exact verification results.
- Stop and ask if product/security/permission decision is needed.

Verification:
- Run the commands listed in the issue.
- If a command cannot run, report the exact blocker.
- Do not fabricate passing results.

Output:
- Summary of changes.
- Changed files.
- Tests/checks run with exact output.
- Remaining risks or owner decisions.
```

---

# 当前项目的真实 Codex / Agent Handoff：TP-003

> 状态：真实 GitHub Issue 已创建，不再使用 `#UNKNOWN`。  
> GitHub Issue：#2  
> URL：https://github.com/sunshihao001/meme-/issues/2

```md
Read:
- AGENTS.md
- SOURCE_OF_TRUTH.md
- 10_工程化交接/Project_Continuation_Brief_v0.1.md
- 10_工程化交接/优先级问题清单任务包_v0.1.md
- 10_工程化交接/issues/issue-005-index-reference-validator.md
- GitHub issue #2: https://github.com/sunshihao001/meme-/issues/2

Task:
Implement TP-003 only: add an index reference validator quality gate.

Rules:
- Do not expand scope.
- Use TDD: write `tests/test_validate_index_references.py` first and observe RED.
- Add `scripts/validate_index_references.py` using Python standard library only.
- Parse formal file paths from `00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md`.
- Ignore URLs, explanatory prose, tree branch glyph lines, and directory-only entries where appropriate.
- Wire the validator into `scripts/validate_all.py`.
- Update index, changelog, Project Continuation Brief, and task package status.
- Run exact verification commands and report output.
- Stop for owner decision before merge, branch protection, bulk issue creation, or broad directory restructuring.

Verification:
```bash
python scripts/validate_index_references.py
python -m unittest discover -s tests -p 'test_validate_index_references.py'
python scripts/validate_all.py
gh pr checks 1
```

Output:
- Summary of changes.
- Changed files.
- RED/GREEN test evidence.
- Exact validation output.
- GitHub Issue #2 / PR #1 linkage status.
```
