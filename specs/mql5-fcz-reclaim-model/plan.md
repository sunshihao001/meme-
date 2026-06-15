# MQL5 FCZ Reclaim Model Plan

> Feature: mql5-fcz-reclaim-model  
> Status: ready-for-task-breakdown  
> Depends on: `specs/mql5-fcz-reclaim-model/spec.md`

---

## 1. Goal

把当前 `MQL5_第一控盘区成本中枢回收模型_学习资料` 项目接入现有 AI Method Wheel，使后续工作从 repo artifact 开始，而不是从聊天上下文开始。

本计划只负责项目级 spec 编译和后续 issue 路由，不直接实现 MQL5 指标、EA、样本采集自动化或实盘功能。

---

## 2. Architecture

本项目采用两层结构：

```text
ai- 方法轮仓库 = control plane
当前 MQL5 FCZ 项目 = execution target
```

当前项目只保存必要薄适配层：

```text
AGENTS.md
SOURCE_OF_TRUTH.md
skills/mql5-fcz-reclaim-kb/SKILL.md
specs/
10_工程化交接/
scripts/
tests/
.github/workflows/validate.yml
```

不复制完整方法论理论，不在业务项目里继续演化方法轮。

---

## 3. Current State

已完成：

```text
1. 项目级 AGENTS.md / SOURCE_OF_TRUTH.md / skill 真源。
2. 策略定义、资料吸收、状态机规则与成熟度审计。
3. 反证样本库、模拟样本库、样本字段表。
4. CSV schema validator。
5. State path validator。
6. Project validate_all 质量门禁。
7. GitHub Actions validate.yml 草案。
8. PR template 与本地 PR draft。
```

当前缺口：

```text
1. 项目级 feature 尚未有 specs/mql5-fcz-reclaim-model 四件套。
2. 后续 issue 优先级尚未被编译成明确 tasks。
3. GitHub repo URL / gh CLI 状态仍未满足真实 issue 创建条件。
```

---

## 4. Proposed Approach

### Phase 1: Spec set creation

创建：

```text
specs/mql5-fcz-reclaim-model/spec.md
specs/mql5-fcz-reclaim-model/plan.md
specs/mql5-fcz-reclaim-model/tasks.md
specs/mql5-fcz-reclaim-model/checklist.md
```

目的：

```text
把当前项目状态编译为可审计、可拆 issue、可交给 Codex 的标准入口。
```

---

### Phase 2: Index and changelog update

更新：

```text
00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md
00_知识库设计规范/05_索引与变更记录/设计规范变更记录.md
```

目的：

```text
保证新增长期事实落到项目知识库索引和变更记录。
```

---

### Phase 3: Validation

运行：

```text
python scripts/validate_all.py
```

并额外检查：

```text
specs/mql5-fcz-reclaim-model/spec.md
specs/mql5-fcz-reclaim-model/plan.md
specs/mql5-fcz-reclaim-model/tasks.md
specs/mql5-fcz-reclaim-model/checklist.md
```

目的：

```text
确认新增 docs 不破坏现有 CSV / state path / unit test 质量门禁。
```

---

## 5. Recommended Next Issue Sequence

完成本 spec set 后，建议按以下顺序推进 issue。

### Issue 1: Create local GitHub issue drafts for method-wheel next slices

类型：工程化交接  
状态：建议优先  
目标：从 `tasks.md` 生成本地 issue 草案，不假造真实 GitHub issue 编号。

输出：

```text
10_工程化交接/issues/issue-002-real-sample-collection-workflow.md
10_工程化交接/issues/issue-003-mql5-observer-mvp-spec.md
10_工程化交接/codex_handoff/issue-002-real-sample-collection-workflow.md
```

---

### Issue 2: Real sample collection workflow hardening

类型：样本标注 / QA  
目标：让真实样本采集从 pending 槽位进入可操作流程。

范围：

```text
1. 检查 07_样本标注/真实样本采集执行清单_v0.1.md。
2. 明确 FCZ_B_0001 / FCZ_C_0001 / FCZ_D_0001 最小必填字段。
3. 生成样本填充 QA checklist。
4. 不填假数据，不抓取未知数据。
```

---

### Issue 3: MQL5 observer MVP spec

类型：指标需求 / 工程 spec  
目标：把状态机输出层整理成 MQL5 观察指标 MVP 的开发 spec。

范围：

```text
1. 读取 08_指标需求/MQL5观察指标需求_v0.2.md。
2. 读取 09_规则与回测/状态机规则整合_v0.1.md。
3. 输出 specs/mql5-observer-mvp/ 四件套。
4. 只做观察指标，不做 EA，不自动下单。
```

---

### Issue 4: Spec file validator

类型：质量门禁  
目标：增加轻量 `scripts/validate_specs.py`，检查关键 spec 文件存在与关键 gate 字段。

说明：

```text
这是可选增强，不应阻塞当前 spec 四件套完成。
```

---

## 6. Files Changed by This Plan

本阶段创建：

```text
specs/mql5-fcz-reclaim-model/spec.md
specs/mql5-fcz-reclaim-model/plan.md
specs/mql5-fcz-reclaim-model/tasks.md
specs/mql5-fcz-reclaim-model/checklist.md
```

本阶段更新：

```text
00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md
00_知识库设计规范/05_索引与变更记录/设计规范变更记录.md
```

本阶段不修改：

```text
07_样本标注/*.csv
scripts/*.py
tests/*.py
.github/workflows/validate.yml
```

除非验证发现必须修复的现有错误。

---

## 7. Verification Plan

执行：

```text
python scripts/validate_all.py
```

预期：

```text
OK: all project validation checks passed
```

额外人工检查：

```text
1. 四个 spec 文件存在。
2. 知识库索引包含四个文件路径。
3. 变更记录包含 v0.1-P28-MQL5 FCZ 项目级Spec四件套。
4. 文档没有声称已创建真实 GitHub issue / PR。
5. 文档没有把观察模型升级为自动交易系统。
```

---

## 8. Risks and Mitigations

### Risk 1: 方法轮分叉

风险：在当前项目里重写一套方法论。  
缓解：所有文档只引用 AI Method Wheel，不重新定义完整方法论。

### Risk 2: 策略误升级

风险：把观察模型误写成自动 EA 或实盘策略。  
缓解：spec / checklist 均明确 non-goal 和 safety gate。

### Risk 3: GitHub 状态虚构

风险：当前目录不是 git repo 或 gh 不可用，却声称已创建 issue/PR。  
缓解：只能生成本地 issue 草案，真实 GitHub 操作需 repo URL 与 owner 授权。

### Risk 4: 文档继续膨胀但没有执行

风险：只继续写文档，不进入样本验证或 MVP。  
缓解：tasks.md 必须推荐下一个可执行 vertical slice。

---

## 9. Open Questions

```text
1. GitHub repo URL / owner-repo 仍需 owner 提供。
2. 是否允许当前目录 git init / push 仍需 owner 决策。
3. 下一个执行 slice 建议优先：真实样本采集流程，而不是继续理论扩写。
```

---

## 10. Stage Exit

本 plan 完成后，项目阶段应标记为：

```text
Ready for GitHub issue draft
```

不是：

```text
Ready for Codex
```

原因：仍需先从 tasks.md 生成具体 issue，并由 owner 决定是否连接真实 GitHub repo。
