# Hermes / Codex 职责边界与 A+B+C 技能治理接入 v0.1

> 分线：10_工程化交接 / 工作流总图
> 目的：补全当前 AI 工作流认知，明确 Hermes、Agent Reach、Skills、Codex、Repo、Owner 的职责边界，并将 A+B+C 知识循环接入 skill 治理体系。

---

## 1. 先给总判断

当前工作流的正确方向是：

```text
Hermes 负责把自然语言想法治理成可执行任务；
Codex 负责把可执行任务落实成代码改动；
Hermes 再负责验证、记录、回到 Owner 决策。
```

这不是“谁更强”，而是**分层分工**。

---

## 2. 角色边界

### 2.1 Hermes：控制层 / 认知层 / 治理层

Hermes 主要负责：

- 接收自然语言输入
- 做需求拷问
- 路由到正确端口
- 调用外部资料读取能力
- 组织 A+B+C 知识循环
- 生成 PRD / plan / issue / handoff
- 决定什么时候交给 Codex
- 检查 Codex 产物
- 记录长期记忆和仓库知识

Hermes 不是“只做理论”，但它的主职责是：

```text
想清楚、管流程、做判断。
```

---

### 2.2 Agent Reach：外部知识读取层

Agent Reach 主要负责：

- 读 X / Twitter 长文
- 读网页
- 读 GitHub
- 读 Reddit / YouTube / 其他外部来源
- 给 B 端提供原始来源

它的定位是：

```text
给 Hermes / Codex 装眼睛。
```

但在你的主流程里，最好由 Hermes 调用 Agent Reach，而不是让它单独变成主控。

---

### 2.3 Skills：方法组件层

Skills 不是主工作流本身，而是：

```text
每个阶段可调用的能力模块。
```

例如：

- A 端：需求拷问 / 概念治理
- B 端：外部知识储备 / Source Pack
- C 端：理论收束 / 方案治理
- D 端：落库执行
- E 端：验证
- F 端：Owner 决策

Skills 负责把这些阶段做稳，不负责替代端口。

---

### 2.4 Codex：编码执行层 / maker worker

Codex 主要负责：

- 进入具体 repo
- 按 Hermes 给的 spec / plan / prompt 改代码
- 跑测试
- 生成 patch
- 修 bug
- 做局部工程实现

Codex 的定位是：

```text
写出来、改出来、跑通。
```

它不是总控，不是最终决策者，也不应该吞掉整个工作流。

---

### 2.5 Repo：事实与记忆落点

Repo 是：

- 事实的落点
- 变更的落点
- 文档的落点
- 验证结果的落点

凡是被接受的判断、理论、计划、执行结果，最终都应该回到 repo。

---

### 2.6 Owner：方向与最终决策

Owner 负责：

- 最终方向
- 是否接受
- 是否扩大范围
- 是否进入下一阶段
- 是否合并
- 是否暂停

Owner 不负责代替系统跑细节，但负责最后的门。

---

## 3. 正确的总图

```text
用户自然语言
  ↓
Hermes / A：需求拷问、问题定义、路由判断
  ↓
Hermes + Agent Reach / B：外部资料、Source Pack、知识储备
  ↓
Hermes / C：理论收束、PRD、plan、issue、handoff
  ↓
Codex / D：按 handoff 改代码、实现、修复、测试
  ↓
Hermes + CI / E：验证 diff、测试、文档、结果
  ↓
Owner / F：你判断是否接受、扩大、暂停、合并
```

这个总图比“谁负责理论、谁负责代码”更准确。

---

## 4. A+B+C 知识循环的定位

A+B+C 不是单次问答，而是一个**知识生产循环**。

### A：把问题拷问清楚

A 端要做的是：

- 让人话变成可研究任务
- 判断问题属于什么类型
- 明确搜索依据
- 明确搜索范围
- 明确是否进入 B/C

A 层默认 skill 组合：

```text
dbs-good-question
brainstorming
grill-with-docs
grill-me
dbs-deconstruct
dbs-goal
dbs-decision
```

---

### B：找来源、压 Source Pack

B 端要做的是：

- 收集外部资料
- 压缩为 Source Pack
- 记录来源关系、观点、缺口、冲突、风险
- 判断这些资料能否喂给 C

B 层默认 skill 组合：

```text
Agent Reach
dbs-learning
dbs-content-system
dbs-report
dbs-save
dbs-restore
dbs-deconstruct
```

---

### C：把 A+B 收束成理论 / 方案 / skill 体系

C 端要做的是：

- 将 A+B 压成稳定理论
- 形成 PRD / plan / issue / handoff
- 产出 skill 编组建议
- 产出治理规则

C 层默认 skill 组合：

```text
to-prd
writing-plans
to-issues
triage
improve-codebase-architecture
executing-plans
```

---

## 5. 为什么要这样分

### 5.1 防止 Hermes 过载

如果 Hermes 同时承担：

- 问题定义
- 外部抓取
- 理论生成
- 代码施工
- 最终验证

就会变成一个什么都干、什么都很重的中心。

正确做法是：

```text
Hermes 管理流程，不包揽所有施工。
```

---

### 5.2 防止 Codex 失控

Codex 很适合执行，但如果不先经过 Hermes 的拷问和收束，它会直接进入施工，容易：

- 过早实现
- 跳过边界定义
- 忽略外部证据
- 缺少 Owner gate

所以 Codex 应该吃的是：

```text
Hermes 产出的成熟 handoff。
```

---

### 5.3 防止 skills 变成堆叠列表

skills 不是越多越好，而是按阶段治理：

- 入口型
- 收束型
- 外部知识型
- 治理型
- 执行型

这样才不会出现“装了一堆 skill，但不知道什么时候用”的问题。

---

## 6. 你的工作流应该怎么理解

### 不要再这么理解

```text
Hermes = 只能理论
Codex = 只能编译代码
```

这太绝对了。

### 应该改成

```text
Hermes = 认知 / 路由 / 治理 / 交接
Codex = 编码 / 执行 / 施工
Agent Reach = 外部资料读取
Skills = 分阶段能力组件
Repo = 事实与结果落点
Owner = 最终判断
```

---

## 7. 默认工作顺序

以后面对一个新想法，默认顺序是：

```text
1. Hermes 拷问问题
2. Hermes 调用 Agent Reach / B 端资料
3. Hermes 收束成 PRD / plan / issue / handoff
4. Hermes 决定是否交给 Codex
5. Codex 实施具体改动
6. Hermes + CI 验证
7. Owner 做最终决策
```

---

## 8. 对当前技能编组的接入方式

### 第一阶段：需求拷问

```text
dbs-good-question + brainstorming + grill-with-docs + grill-me + dbs-deconstruct
```

### 第二阶段：知识储备

```text
Agent Reach + dbs-learning + dbs-content-system + dbs-report + dbs-save/restore
```

### 第三阶段：理论治理

```text
to-prd + writing-plans + to-issues + triage + improve-codebase-architecture
```

### 第四阶段：施工执行

交给 Codex。

### 第五阶段：验证与收尾

```text
Hermes + CI + verification-before-completion + Owner gate
```

---

## 9. 需要修正的认知句

以后建议用这句替换旧理解：

```text
Hermes 负责把自然语言想法治理成可执行任务；Codex 负责把可执行任务落实成代码改动；Hermes 再负责验证、记录、回到 Owner 决策。
```

这句话是当前版本的总纲。

---

## 10. 一句话收束

```text
A+B+C 是知识循环；Hermes 负责治理这个循环；Codex 负责执行它的结果；Repo 负责记住它；Owner 负责最终判断。
```
