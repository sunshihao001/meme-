# Loop Report Validator Spec

> 状态：v0.1 / TP-002 执行规格  
> 来源：`10_工程化交接/issues/issue-007-loop-agent-demand-grilling-report-validator.md`

## Goal

把 `loop_agent_demand_grilling_contract.md` 中的运行报告契约转成可执行质量门，防止循环代理只写方法论、缺少运行证据却声称完成。

## Scope

- 新增 `scripts/validate_loop_agent_reports.py`。
- 新增 `tests/test_validate_loop_agent_reports.py`。
- 接入 `scripts/validate_all.py`。
- 只检查 `specs/mql5-fcz-reclaim-model/reports/loop_agent_demand_grilling_report_*.md`。

## Required Evidence

每份报告至少包含：

```text
本轮唯一最高价值问题
loaded / 实际加载技能
referenced_only / referenced only
conditional_not_executed / 未调用说明
forbidden / 禁止调用
输出类型
权限分类 / authority
更新文件
PROPOSED
UNKNOWN
REQUIRES_OWNER
验证输出 / validate_all
下一轮 / 下一步
```

## Non-goals

- 不判断报告推理质量。
- 不追溯验证 `skill_view` 调用真实性。
- 不自动运行循环代理。
- 不创建 cron job。
- 不接触交易执行、私钥、swap、自动下单。

## Acceptance Criteria

- 合规 loop report 通过。
- 缺 required evidence 的报告失败并指出缺项。
- `validate_all` 聚合该 validator。
- 当前已有 runtime audit report 通过。
- GitHub Actions 通过。
