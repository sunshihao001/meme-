# B端正式 Source Pack / 证据收敛模板 v0.1

> 分线：10_工程化交接 / B端正式化
> 状态：v0.2 / B端运行合同 + 模板（提速版）
> 目标：把 B 端从“读一堆资料”升级为“可审计、可压缩、可收敛、可给下游消费的证据门”。
> 范围：资料读取、证据压缩、覆盖矩阵、缺口标记、冲突整理、上下文清洗；不直接做最终理论，不做 repo 修改，不替代 A 端路由。
> 速度原则：B 端默认先给搜索/压缩策略简报，再按最小必要集补证，不做无边界扩搜。

---

## 1. B 端定位

B 端不是：

```text
- 理论生成器
- 最终结论输出器
- repo 落库执行器
- 验证审查器
- 证据堆砌器
```

B 端是：

```text
- 证据压缩门
- Source Pack 门
- 上下文清洗门
- 缺口/冲突/未知标记者
- 下游可消费证据供应器
```

A 端把问题问清楚后，B 端要负责：

```text
把散乱资料压缩成下游能直接消费的干净证据包。
```

---

## 2. B 端单一核心职责

### 核心职责

```text
把分散的文件、样本、旧知识和外部来源，压缩成可追踪、可消费、低噪音的 Source Pack。
```

### B 端必须同时完成的 4 件事

```text
1. 读取相关文件与来源。
2. 识别哪些证据存在，哪些未知，哪些冲突。
3. 把证据按主题压缩成 Source Pack。
4. 给 A/C 端提供可直接使用的上下文。
```

### B 端绝不做的事

```text
1. 不直接输出最终理论结论。
2. 不替 A 端做概念路由。
3. 不替 C 端生成完整方案。
4. 不修改 repo 真源。
5. 不把 unknown 当成结论。
```

---

## 3. B 端输入 / 输出合同

### 3.1 允许输入

```text
- 项目文件
- 原始资料
- 样本记录
- 旧知识库
- 外部文章 / 外部 skill source
- A 端路由说明
```

### 3.2 必须输出

B 端每轮至少产出以下其中 2 类，理想情况全部产出：

```text
- Source Pack
- Coverage Matrix
- Evidence Index
- Gaps / Conflicts / Unknowns
- Downstream Handoff Note
```

### 3.3 输出必须可消费

输出不能只是摘要，必须能被下游消费，例如：

```text
- A 端能据此重新澄清
- C 端能据此生成 theory / spec
- D 端能据此做落库准备
- E 端能据此验证证据链
```

---

## 4. B 端证据收敛模型

B 端的证据收敛必须走这条链：

```text
来源集合
→ 文件清单
→ 证据摘要
→ 覆盖矩阵
→ 冲突/缺口/未知
→ 可消费 Source Pack
→ 下游 handoff
```

### 4.1 证据收敛要回答的 6 个问题

```text
1. 读了什么？
2. 这些资料各自提供了什么证据？
3. 哪些证据彼此一致，哪些冲突？
4. 哪些地方还不知道？
5. 哪些内容可以直接下游消费？
6. 哪些地方需要回到 A 端重新澄清？
```

### 4.2 不能犯的证据错误

```text
- 不能把文件清单当成证据包。
- 不能把 read only 记录当成最终判断。
- 不能把 unknown 填成结论。
- 不能把旧知识直接覆盖成当前真源。
```

---

## 5. B 端技能编排协议

B 端不是单纯读文件，而是一个 evidence orchestration 门。

### 5.1 B 端默认技能编排顺序

```text
1. codebase-inspection
2. github-repo-management
3. ai-method-wheel
4. dbs-content-system（当需要旧知识结构化时）
5. dbs-deconstruct（当概念需要拆解时）
6. dbs-learning（当需要切主题包时）
7. ocr-and-documents（当输入包含 PDF/扫描件时）
```

### 5.2 技能状态必须区分

```text
listed_only
installed
loaded
activated
executed
output_consumed
referenced_only
conditional_not_executed
missing
forbidden
```

### 5.3 运行规则

```text
1. 先确定需要收敛哪些证据，再读文件。
2. 如果只是 pattern only，不能伪装成 executed。
3. 如果文件缺失，要明确写 missing / not read。
4. 每个证据点都要有来源路径。
```

---

## 6. B 端的技能栈矩阵

### 6.1 主 skill

```text
meme-source-pack-port
```

### 6.2 B 端固定辅助技能

```text
codebase-inspection
ai-method-wheel
github-repo-management
```

### 6.3 B 端证据压缩桥接技能

```text
dbs-content-system
dbs-deconstruct
dbs-learning
ocr-and-documents（conditional）
```

### 6.4 B 端可选模式

```text
external article synthesis：pattern_only
repo fact compression：tool-driven
```

说明：

```text
B 端可以吸收外部文章和旧知识的结构模式，但不能把“读到”直接变成“已证实”。
```

---

## 7. B 端输出模板

### 7.1 Source Pack 模板

```md
# Source Pack

## 1. Goal

## 2. Source Inventory

## 3. Evidence Summary

## 4. Coverage Matrix

## 5. Conflicts / Gaps / Unknowns

## 6. High-confidence Facts

## 7. Low-confidence / Pending Facts

## 8. Downstream Handoff
```

### 7.2 Coverage Matrix 模板

```md
# Coverage Matrix

| Topic | Source | Evidence Type | Confidence | Notes |
|---|---|---|---|---|
| ... | ... | ... | ... | ... |
```

### 8. B 端速度协议

```text
1. 默认模式 = fast_path。
2. 先返回 Search/Compression Brief，再进入资料收敛，不先全量铺开。
3. B 端每轮优先做“最小可消费 Source Pack”，不是“最大信息堆”。
4. 如果证据已足够支撑 C 端，就停止继续扩搜。
5. 如果 2 轮内仍缺口大，明确写 gap，而不是继续拖长流程。
```

---

## 9. B 端验收标准

```md
# Evidence Index

- file/path
- what it proves
- what it does not prove
- who consumes it
```

### 7.4 Gaps / Conflicts / Unknowns 模板

```md
# Gaps / Conflicts / Unknowns

## Gaps

## Conflicts

## Unknowns

## Return-to-A hints
```

---

## 8. B 端的分级标准

### 8.1 高置信证据

```text
可直接下游消费，不需要再解释很多。
```

### 8.2 中置信证据

```text
可用，但需要标记条件、范围或不确定性。
```

### 8.3 低置信证据

```text
只能作为候选，不能作为结论。
```

### 8.4 冲突证据

```text
不能强行合并，必须显式列出冲突源。
```

---

## 9. B 端与 A 端的边界

B 端不做：

```text
- 概念定性
- 端口路由
- 最终需求裁定
```

A 端不做：

```text
- 证据压缩
- 资料去噪
- coverage matrix
- source pack
```

两者都不做的：

```text
- 最终理论结论
- repo 落库
- 验证审查
```

---

## 10. B 端与 A 端的协作

### 10.1 A → B

A 给 B 的不是泛泛“去查”，而是：

```text
- 需要什么主题
- 需要什么证据边界
- 什么可以 UNKNOWN
- 要补什么格式
```

### 10.2 B → A

B 返回：

```text
- Source Pack
- coverage matrix
- gaps/conflicts/unknowns
- 是否需要 A 再澄清概念
```

### 10.3 A/B 闭环原则

```text
A 先定问题世界
B 再收证据
A 再决定是否进入 C/D/E/F
```

---

## 11. B 端验收标准

B 端本轮是否完成，不看“读了多少文件”，看这 5 个结果：

```text
1. 证据是否被压缩成可消费 Source Pack。
2. gaps / conflicts / unknown 是否清晰。
3. 下游是否能据此继续。
4. 是否保留来源路径。
5. 是否避免把 unknown 伪装成结论。
```

---

## 12. B 端输出文件建议

建议后续每轮固定输出：

```text
B端_Source_Pack_<date>.md
B端_Coverage_Matrix_<date>.md
B端_Evidence_Index_<date>.md
B端_Gaps_Conflicts_Unknowns_<date>.md
```

---

## 13. 本版结论

```text
B 端的专业化路径已经明确：

B 端不是“整理摘要”，而是“把证据变成下游可消费包”。

如果 B 端做不到干净的证据压缩，后续端口就会继续在脏上下文里工作。
```
