# Loop Report Validator Plan

## 小切片

1. RED：先写 `tests/test_validate_loop_agent_reports.py`，验证脚本不存在时失败。
2. GREEN：实现最小 schema validator。
3. 聚合：把 `scripts/validate_loop_agent_reports.py` 加入 `scripts/validate_all.py`。
4. 回填：更新任务包、Project Continuation Brief、索引和变更记录。
5. 验证：运行单测、脚本、`validate_all`、提交推送并检查 CI。

## 设计选择

- 使用 Python 标准库，不引入依赖。
- 以关键词 evidence schema 为第一版，不做 YAML/frontmatter 强约束。
- 默认只扫描 `loop_agent_demand_grilling_report_*.md`，避免普通笔记误报。
