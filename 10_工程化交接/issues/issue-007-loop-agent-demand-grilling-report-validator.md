# Issue Draft: 增加循环代理需求拷问报告 Validator

> 状态：implemented on branch / awaiting PR merge  
> 类型：validator / AI-workflow-quality-gate  
> 建议标签：validator, ai-workflow, quality-gate, loop-agent  
> Agent 执行分类：Autonomous

---

## 1. Goal

把 `loop_agent_demand_grilling_contract.md` 中的运行契约转化为可验证质量门，检查每轮循环代理报告是否包含必要证据，防止 Agent 只写方法论或假装完成。

---

## 2. Background

项目已经有以下循环控制文件：

```text
specs/mql5-fcz-reclaim-model/demand_control_loop.md
specs/mql5-fcz-reclaim-model/demand_theory_evolution_loop.md
specs/mql5-fcz-reclaim-model/loop_agent_demand_grilling_contract.md
```

但目前 CI 还不能检查循环代理报告是否真的包含：

```text
1. 本轮唯一最高价值问题。
2. 实际加载的 skills。
3. 禁止调用的 capabilities。
4. 输出类型与权限分类。
5. 更新文件。
6. PROPOSED / UNKNOWN / REQUIRES_OWNER 标注。
7. validate_all 输出。
8. 下一轮入口。
```

---

## 3. Scope

```text
1. 设计 loop-agent report 最小 schema。
2. 新增 scripts/validate_loop_agent_reports.py。
3. 新增 tests/test_validate_loop_agent_reports.py。
4. 接入 scripts/validate_all.py。
5. 提供一个合规 fixture 和一个缺字段 fixture。
6. 更新 README / ROADMAP 或索引中对该质量门的说明，若需要。
```

---

## 4. Non-goals

```text
1. 不自动运行循环代理。
2. 不创建 cron job。
3. 不检查报告内容“是否聪明”，只检查必要证据字段是否存在。
4. 不验证 skill_view 调用真实性；只验证报告是否声明了 loaded / referenced / forbidden。
5. 不进入交易执行、GMGN swap、私钥或自动下单。
```

---

## 5. Acceptance Criteria

```text
- [x] validator 能识别合规 loop_agent_demand_grilling_report。
- [x] validator 能拒绝缺少 required evidence 的报告。
- [x] validate_all 聚合新 validator。
- [x] tests 覆盖通过样例和失败样例。
- [x] 当前仓库已有报告如不符合 schema，不强行 retroactive 修复；可先只检查新命名报告目录。
- [ ] GitHub Actions 通过。
```

---

## 6. Verification Plan

```bash
python scripts/validate_loop_agent_reports.py
python -m unittest discover -s tests -p 'test_validate_loop_agent_reports.py'
python scripts/validate_all.py
```

---

## 7. Owner Decisions

```text
1. 是否要求所有未来 loop report 都必须进入 CI 检查。
2. 是否允许 cron 未来自动生成 report；当前默认不允许。
3. 是否把此 validator 作为 P2 可验证知识库工程化的优先任务。
```

---

## 8. Implementation Notes

```text
实现路径：specs/loop-report-validator/
脚本：scripts/validate_loop_agent_reports.py
测试：tests/test_validate_loop_agent_reports.py
聚合：scripts/validate_all.py
```
