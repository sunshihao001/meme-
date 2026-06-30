# Hermes / GitHub / 外部资源三层工作流 v0.1

> 分线：10_工程化交接 / AI 工作流控制面  
> 状态：v0.1 / 初始正式版  
> 目的：回答“正确的完善是在 Hermes 里，还是完善到 GitHub 仓库里”，并把当前最新 Loop Engineering 工作流落成项目级执行判断。

---

## 1. 结论

正确的完善不是二选一。

```text
Hermes 负责认知、拷问、编译、验证；
GitHub 仓库负责真源、版本、协作、交付；
外部资源负责证据输入、认知校准和方法更新。
```

一句话：

```text
Hermes 是控制面；GitHub 是真源面；外部资源是证据面。
```

---

## 2. 为什么不能只放在 Hermes

如果只放在 Hermes，会出现：

```text
1. 聊天上下文会丢失或压缩。
2. 新 Agent 无法接手。
3. 结论无法被 Git / PR / CI 验证。
4. Owner 后续仍要反复口头提醒。
5. 需求拷问会停留在“说得明白”，没有进入项目真源。
```

因此，Hermes 中形成的稳定结论必须进入仓库文件。

---

## 3. 为什么不能只放在 GitHub

如果只放在 GitHub，会出现：

```text
1. 仓库只沉淀结果，不负责实时思考。
2. 外部资料质量无法在写入前被判断。
3. 模糊需求会直接污染文档。
4. Codex / Agent 容易按未拷问清楚的目标执行。
5. 旧结论可能被机械追加，而不是被重新判断。
```

因此，进入 GitHub 前必须经过 Hermes 的需求拷问、证据分级和验证判断。

---

## 4. 三层职责分工

| 层 | 角色 | 负责什么 | 不负责什么 | 典型产物 |
|---|---|---|---|---|
| Hermes 控制面 | 认知 / 编译 / 验证 | 需求拷问、目标压缩、Loop Brief、外部资料判断、Verifier Gate | 不作为长期真源，不替代 Git 历史 | Demand Contract、Loop Brief、Verifier 报告、下一步判断 |
| GitHub 真源面 | 项目 / 版本 / 协作 | README、ROADMAP、SOURCE_OF_TRUTH、docs、issues、PR、CI、validators | 不承担临场需求澄清 | Markdown 真源、spec、tests、scripts、变更记录 |
| 外部资源证据面 | 资料 / 社区 / 代码样例 | X / Reddit / V2EX / GitHub / Substack / CSDN 等资料收集与对标 | 不直接决定项目方向 | raw、clean、reading、insights、workflow patches |

---

## 5. 最新工作流主线

当前项目应按 Loop Engineering 主线运行：

```text
User Goal
→ Hermes Demand Interrogation
→ 外部证据收集与质量分级
→ Hermes 认知收敛
→ Loop Brief / Demand Contract
→ GitHub 真源文件更新
→ Codex / Agent 执行 bounded WORK_ORDER
→ Hermes Verifier Gate
→ GitHub commit / PR / CI / changelog
→ Learnback / workflow patch
```

关键变化：

```text
需求拷问端不再只是“问问题”；
它升级为 Loop Brief Compiler，负责把模糊目标编译成有边界、有路径、有检查、有状态、有停止门的项目执行结构。
```

---

## 6. 需求拷问端探查模板

任何复杂任务进入前，先回答以下问题。

### 6.1 问题世界

```text
这是业务策略问题、工程实现问题、AI 工作流问题，还是外部资料认知更新问题？
```

### 6.2 目标压缩

```text
用户真正想改变什么？
是要更新 Hermes 的思考方式，还是要更新 GitHub 项目真源？
```

### 6.3 入库判断

```text
这个结论是否需要 7 天后仍然有效？
是否需要新 Agent 接手？
是否需要被 Git / CI / validator 验证？
```

如果是，则必须进入 GitHub。

### 6.4 外部证据判断

```text
外部资料只是观点，还是有可执行仓库 / 实践证据 / 反例？
是否足够成为 workflow patch？
```

### 6.5 Loop 值得性

```text
任务是否超过一轮？
是否需要状态外置？
是否需要 Codex / Agent 执行？
是否需要 Verifier 独立验收？
```

如果是，则编译 `.loop/` 或等价 Loop Brief。

---

## 7. 外部资源使用规则

外部资源必须分层，不得把搜索候选直接写成结论。

```text
raw evidence
→ clean candidates
→ reading cards
→ insights
→ workflow patch
→ GitHub 真源更新
```

判断标准：

| 类型 | 是否能入真源 | 说明 |
|---|---|---|
| 单篇观点文章 | 通常不能直接入真源 | 可作为 opinion_candidate |
| 多来源一致观点 | 可进入 insights | 仍需标注证据质量 |
| GitHub 可执行方法 | 可作为 tool_candidate | 需验证是否适配本项目 |
| 理论 + 可执行证据 + 项目适配 + 可验证行为变化 | 可进入 workflow_patch | 可更新项目方法论 |

---

## 8. 当前项目落地规则

### 8.1 留在 Hermes 的内容

```text
1. 临场推理。
2. 未成熟假设。
3. 外部资料初筛。
4. 需求拷问过程。
5. Verifier 判断过程。
```

### 8.2 必须写入 GitHub 的内容

```text
1. 项目定位变化。
2. 工作流规则变化。
3. 目录结构 / 真源入口变化。
4. 可复用模板。
5. validator / CI / Issue / PR 规则。
6. 已经确认的外部研究结论。
7. Owner 后续需要持续依赖的判断。
```

### 8.3 需要 HumanGate 的内容

```text
1. 自动交易、swap、私钥、真实资金。
2. GitHub branch protection / merge / release。
3. 大范围目录重构。
4. 替换核心技术栈。
5. 把研究观察升级成交易执行。
```

---

## 9. 对本项目的当前建议

当前最正确的开展方式是：

```text
1. Hermes 继续作为需求拷问端、Loop Brief Compiler 和 Verifier。
2. GitHub 继续作为项目真源：README / ROADMAP / SOURCE_OF_TRUTH / 索引 / 变更记录 / validator。
3. 外部资源继续作为认知更新证据，但必须经过 raw-clean-reading-insights-workflow 分层。
4. 每次形成稳定判断，都写入 10_工程化交接 或对应业务分线。
5. 复杂任务不要直接交给 Codex，先编译 bounded WORK_ORDER。
```

---

## 10. 下一步执行顺序

建议下一轮按以下顺序推进：

```text
Step 1：读取本文件 + 项目AI操作面板 + Project Continuation Brief。
Step 2：对当前任务做需求拷问，判断是研究、工程、样本、validator 还是工作流更新。
Step 3：如果需要外部资料，先建立 research quality gate。
Step 4：形成 Demand Contract / Loop Brief。
Step 5：写入 GitHub 对应分线文件。
Step 6：如涉及代码或批量文件，交给 Codex 执行 bounded WORK_ORDER。
Step 7：Hermes 独立验证并更新索引、变更记录和 handoff。
```

---

## 11. 最终原则

```text
聊天不是长期真源；
仓库不是临场大脑；
外部资料不是直接结论；
需求拷问端不是问卷，而是 Loop Brief Compiler；
Codex 不是方向判断者，而是 bounded executor；
Hermes 不是只回答问题，而是控制面 + verifier。
```

最终表达：

> 项目完善应以 GitHub 仓库为长期真源，以 Hermes 为需求认知和 Loop 编译控制面，以外部资源作为证据输入。只有经过需求拷问、证据分级和验证门的结论，才应该进入仓库成为项目长期资产。
