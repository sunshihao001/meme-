# Loop Report Validator Checklist

- [x] 合规 fixture 能通过。
- [x] 缺字段 fixture 能失败。
- [x] 只扫描 loop report 命名文件。
- [x] `validate_all` 包含新 validator。
- [x] 当前真实报告通过。
- [x] 全量验证通过。
- [x] GitHub Actions 通过。

## False-success traps

- 不能只新增文档而不接入 `validate_all`。
- 不能把普通 Markdown 都纳入检查导致误报。
- 不能宣称验证 skill 调用真实性；本 slice 只验证报告声明字段。
