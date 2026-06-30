# Issue Draft: 增加索引引用存在性 Validator

> 状态：GitHub Issue 已创建 / open  
> GitHub Issue：#2  
> URL：https://github.com/sunshihao001/meme-/issues/2  
> 类型：validator / quality-gate  
> 标签：validator, ci, documentation, ai-workflow, quality-gate  
> Agent 执行分类：Autonomous

---

## 1. Goal

新增 validator 检查 `知识库索引_v0.1.md` 中列出的项目路径是否真实存在，防止索引漂移。

---

## 2. Problem

本项目要求新增正式文件必须更新索引，但目前 CI 还没有自动检查：

```text
1. 索引中路径是否存在。
2. 已删除/移动文件是否仍残留在索引中。
3. 新增治理层文件是否可被后续 Agent 找到。
```

---

## 3. Scope

```text
1. 新增 scripts/validate_index_references.py。
2. 新增 tests/test_validate_index_references.py。
3. 支持解析索引中的 code block 路径。
4. 忽略明显不是路径的说明行。
5. 接入 scripts/validate_all.py。
```

---

## 4. Non-goals

```text
1. 不要求索引覆盖仓库内所有文件。
2. 不改变索引结构。
3. 不检查外部 URL。
4. 不引入外部依赖。
```

---

## 5. Acceptance Criteria

```text
- [ ] validator 能发现不存在的索引路径。
- [ ] 当前索引通过检查，或 PR 同步修复索引。
- [ ] validate_all 聚合新 validator。
- [ ] GitHub Actions 通过。
```

---

## 6. Verification Plan

```bash
python scripts/validate_index_references.py
python -m unittest tests/test_validate_index_references.py
python scripts/validate_all.py
```
