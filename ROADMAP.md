# ROADMAP.md

> 项目：meme- / MQL5 第一控盘区成本中枢回收模型知识库  
> 状态：v0.1  
> 目的：给 GitHub 协作、AI Agent 执行和 owner 决策提供阶段路线图。  
> 最后更新：2026-06-14

---

## 1. 路线图原则

```text
1. 项目现实优先于方法论完整性。
2. 先把知识库变成可验证协作仓库，再扩大研究范围。
3. 每个阶段都必须有可检查交付物。
4. 研究结论、样本事实、指标需求、交易执行边界必须分开。
5. AI Agent 执行小而清晰的 issue；owner 保留产品、风险、合并和发布决策权。
```

---

## 2. 当前阶段：P0 GitHub 项目治理层

目标：

```text
让仓库成为长期可协作的真源，而不只是本地文件夹上传结果。
```

交付物：

```text
README.md
ROADMAP.md
.github/ISSUE_TEMPLATE/ai_workflow_task.yml
.github/ISSUE_TEMPLATE/research_sample_task.yml
.github/ISSUE_TEMPLATE/validator_task.yml
.github/pull_request_template.md
10_工程化交接/Project_Continuation_Brief_v0.1.md
10_工程化交接/issues/ 下一阶段 issue 草案
```

完成标准：

```text
1. 新 Agent 能从 README / AGENTS / SOURCE_OF_TRUTH / ROADMAP 找到入口。
2. 新任务能从 Issue 模板进入 Good Question Brief → spec → tasks → PR。
3. PR 模板强制记录验证结果、索引/变更记录更新和 owner 决策点。
4. validate_all 通过。
5. 本阶段通过 PR 合并到 main。
```

---

## 3. P1 样本标注主线

目标：

```text
把第一批真实/反证样本推进到更可审计的状态，避免策略只停留在理论语义。
```

推荐 issues：

```text
P1-1 补齐 FCZ_B_0001 真实“模型符合但失败”样本。
P1-2 为 FCZ_C_0001 / FCZ_D_0001 增加图表派生结构标注。
P1-3 统一样本记录 Markdown 字段完整性要求。
P1-4 将样本记录与 CSV 同步规则写入 validator。
```

完成标准：

```text
1. FCZ_B_0001 不再停留在待搜空壳。
2. C/D 样本拥有可复核的图表派生结构字段。
3. 每条样本记录能通过自动化格式/状态校验。
4. CSV 与单样本记录之间的关键字段同步规则明确。
```

---

## 4. P2 可验证知识库工程化

目标：

```text
把 Markdown 知识库逐步变成可验证知识系统，减少 AI 幻觉和文档漂移。
```

推荐 issues：

```text
P2-1 增加样本记录 Markdown 字段完整性 validator。
P2-2 增加索引引用存在性 validator。
P2-3 增加变更记录格式 validator。
P2-4 增加 specs / tasks / checklist 一致性 validator。
```

完成标准：

```text
1. validate_all 覆盖更多项目规则。
2. CI 能在 PR 中阻止索引漂移、样本记录缺字段、状态路径错误。
3. Agent 修改项目时有明确的自动反馈。
```

---

## 5. P3 策略规则与反证实验

目标：

```text
把第一控盘区、深洗、POC/AVWAP 回收、二次启动、诱多过滤等语义推进为可反证的规则集合。
```

推荐 issues：

```text
P3-1 将状态机规则整合文档升级为可执行检查清单。
P3-2 按反证实验设计补充失败样本分层。
P3-3 建立消融实验字段到样本库字段的映射。
P3-4 明确“观察有效”与“交易可用”之间的缺口。
```

完成标准：

```text
1. 每个核心判断字段都有反例或失败模式。
2. 不把单一成功样本升级为策略有效结论。
3. 商业可用性诊断与研究观察结论分离。
```

---

## 6. P4 MQL5 观察指标 MVP

目标：

```text
基于已稳定的语义、字段和样本要求，设计 MQL5 / MT5 观察指标 MVP。
```

推荐 issues：

```text
P4-1 编写 MQL5观察指标MVP开发计划_v0.1.md。
P4-2 明确 MVP 不做自动下单，只做观察器 / 状态标注器 / 风险评分可视化。
P4-3 将字段映射转化为模块优先级。
P4-4 设计人工复盘导出格式。
```

完成标准：

```text
1. MVP 范围不包含自动交易。
2. 每个指标模块都有输入、输出、边界、失败模式。
3. 可交给 Codex / Claude Code 做小步工程实现。
```

---

## 7. P5 多 Agent 协作成熟化

目标：

```text
让 Hermes / Codex / Claude Code / Grok 等 Agent 可以围绕同一个 GitHub 真源协作，而不互相污染上下文。
```

推荐 issues：

```text
P5-1 增强 AGENTS.md / CLAUDE.md / Codex handoff 的一致性。
P5-2 建立 Agent handoff checklist。
P5-3 将常见任务沉淀为项目 skill 更新。
P5-4 引入 code review / simplification / validator-first 工作流。
```

完成标准：

```text
1. 每个 Agent 都知道读什么、改什么、不改什么。
2. 长期逻辑沉淀在 repo 文件和 skills/ 中。
3. PR 与 CI 成为协作闭环，而不是聊天结论。
```

---

## 8. 当前 owner 决策点

```text
1. 是否把 main 分支设置为必须 PR + CI 通过后才能合并。
2. 是否优先推进 P1 样本标注，还是 P2 validators。
3. 是否接受 GitHub Issues 作为所有新任务入口。
4. 是否暂缓自动交易方向，继续保持观察器 / 研究知识库定位。
```

---

## 9. 当前继续入口与 V0.5 控制面

当前接手项目、判断优先级和自动推进任务包时，先读取：

```text
10_工程化交接/Project_Continuation_Brief_v0.1.md
```

如果任务涉及 V0.5 需求拷问端运行态，还要读取：

```text
specs/mql5-fcz-reclaim-model/loop_agent_demand_grilling_contract.md
10_工程化交接/V0.5需求拷问理论补全体系承接清单_v0.1.md
```

原则：

```text
1. Project Continuation Brief 负责回答“现在从哪里继续”。
2. V0.5 运行契约负责回答“拷问端是否真的调用、是否越权、是否可验证”。
3. ROADMAP 只保留阶段路线，不承载每轮运行细节。
```
