# Issue Draft: 增加样本记录 Markdown 字段完整性 Validator

> 状态：draft  
> 类型：validator / quality-gate  
> 建议标签：validator, ci, sample-labeling  
> Agent 执行分类：Autonomous

---

## 1. Goal

新增一个 validator，检查 `07_样本标注/样本记录/*.md` 是否满足最低字段完整性要求，减少样本记录漂移。

---

## 2. Problem

当前已有 CSV schema validator 与 state-path validator，但单样本 Markdown 记录仍可能出现：

```text
1. reviewer / review_date 缺失。
2. source_chart_url 未说明。
3. CSV 同步状态缺失。
4. final_classification 与 current_state_path 不一致。
5. unknown 字段没有原因。
```

---

## 3. Scope

```text
1. 新增 scripts/validate_sample_records.py。
2. 新增 tests/test_validate_sample_records.py。
3. 接入 scripts/validate_all.py。
4. 根据现有样本记录定义最低必需字段。
5. 更新 specs 或 issue draft 中的验证说明。
```

---

## 4. Non-goals

```text
1. 不重写样本记录模板。
2. 不强制所有研究字段都有确定值。
3. 不引入外部依赖。
4. 不改变 CSV schema。
```

---

## 5. Acceptance Criteria

```text
- [ ] validator 可独立运行。
- [ ] tests 覆盖通过样例和失败样例。
- [ ] validate_all 聚合新 validator。
- [ ] 当前样本记录通过检查，或 PR 同步修复记录。
- [ ] GitHub Actions 通过。
```

---

## 6. Verification Plan

```bash
python scripts/validate_sample_records.py
python -m unittest tests/test_validate_sample_records.py
python scripts/validate_all.py
```
