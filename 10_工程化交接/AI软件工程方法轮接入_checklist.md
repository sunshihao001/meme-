# AI 软件工程方法轮接入 checklist

## 需求拷问 Checklist

```text
[ ] 用户是谁？
[ ] 解决谁的痛点？
[ ] 当前痛点是什么？
[ ] 现有系统是否已有类似逻辑？
[ ] 范围内是什么？
[ ] 明确不做什么？
[ ] 边界情况有哪些？
[ ] 失败场景有哪些？
[ ] 安全/隐私/权限风险是什么？
[ ] 如何证明完成？
[ ] 哪些必须 owner 决策？
```

## Spec Checklist

```text
[ ] Background
[ ] Goal
[ ] Non-goals
[ ] User Stories
[ ] Acceptance Criteria
[ ] Edge Cases
[ ] Failure Modes
[ ] Security / Privacy
[ ] Testing Requirements
[ ] QA Requirements
[ ] Human Decisions Needed
```

## Codex Handoff Checklist

```text
[ ] Read 列表完整
[ ] Task 只对应一个 issue
[ ] 明确 Do not expand scope
[ ] 明确 TDD when practical
[ ] 明确 Add/update tests
[ ] 明确 Run available checks
[ ] 明确 Report changed files
[ ] 明确 Report exact verification results
[ ] 明确 Stop and ask 条件
```

## QA / CI Checklist

```text
[ ] 单元测试已运行
[ ] 集成测试已运行
[ ] UI 改动时 Playwright 已运行
[ ] UI 改动时 a11y 已检查
[ ] 安全相关改动已审计
[ ] CI 通过
[ ] PR 描述包含验证结果
[ ] Owner 最终确认
```

## GitHub 沉淀 Checklist

```text
[ ] spec 写入 specs/<feature>/spec.md 或本项目对应目录
[ ] plan 写入 specs/<feature>/plan.md
[ ] tasks 写入 specs/<feature>/tasks.md
[ ] checklist 写入 specs/<feature>/checklist.md
[ ] issue 已创建或本地 issue 草案已保存
[ ] ADR 需要时写入 docs/adr/
[ ] PR 描述保留验证结果
```
