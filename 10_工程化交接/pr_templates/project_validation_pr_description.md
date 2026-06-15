# PR 描述模板：项目质量门禁 / 方法轮任务

## Summary

<!-- 用 2-5 条说明本 PR 做了什么。 -->

- 
- 
- 

## Linked Issue / Spec

```text
Issue: #UNKNOWN
Spec: specs/<feature>/spec.md
Plan: specs/<feature>/plan.md
Tasks: specs/<feature>/tasks.md
Checklist: specs/<feature>/checklist.md
```

## Scope

### In scope

```text
- 
```

### Out of scope

```text
- 不扩展未在 issue/spec 中声明的功能
- 不修改凭据、权限、发布配置
- 不修改无关策略理论文件
```

## Changed Files

```text
- 
```

## Verification

### Commands run

```text
python -m unittest discover -s tests
python scripts/validate_sample_csv.py
python scripts/validate_state_paths.py
python scripts/validate_all.py
```

### Exact output

```text
粘贴真实输出，不要改写或概括。
```

## Risk Review

### Product risk

```text
- 
```

### Technical risk

```text
- 
```

### Security / permission risk

```text
- 
```

### Data risk

```text
- 
```

## QA Notes

```text
- 是否涉及 UI：否 / 是
- 是否需要 Playwright：否 / 是
- 是否涉及可访问性：否 / 是
- 是否涉及安全敏感逻辑：否 / 是
- 是否涉及外部权限或 token：否 / 是
```

## Owner Decision Needed

```text
- [ ] 是否允许创建/更新 GitHub issue
- [ ] 是否允许创建 PR
- [ ] 是否允许接入 GitHub Actions CI
- [ ] 是否允许合并
```

## Checklist

```text
- [ ] Spec 已读
- [ ] Scope 未扩展
- [ ] Tests 已新增或更新
- [ ] 本地验证已运行
- [ ] changed files 已列出
- [ ] exact verification output 已粘贴
- [ ] owner decision 已标记
```
