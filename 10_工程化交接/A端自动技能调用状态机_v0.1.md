# A端自动技能调用状态机 v0.1

> 分线：10_工程化交接 / A端自动化
> 目的：把 A 端的“自动提问 → 自动判断 → 自动调用技能 → 自动推理 → 继续提问”写成可执行的状态机。

---

## 1. 状态机总图

```text
INTAKE
→ CLARIFY
→ ROUTE_SKILL
→ ABSORB_EVIDENCE
→ REEVALUATE
→ LOOP_BACK / TRANSFER
```

---

## 2. 状态定义

### 2.1 INTAKE

接收用户新输入，判断是不是新想法、新问题，还是续接/执行/验证。

进入条件：

- 有新的自然语言输入

动作：

- 识别输入类型
- 判断是否需要进入 A 端自动循环
- 先做最小澄清

---

### 2.2 CLARIFY

当输入还不够清楚时，A 端自动追问最关键问题。

动作：

- 自动提问 1-3 个关键问题
- 收集目标、边界、缺口
- 判断当前是否足够进入技能路由

退出条件：

- 问题已经足够清楚
- 或者用户明确说停

---

### 2.3 ROUTE_SKILL

根据当前缺口自动选择最相关技能。

路由规则：

- 模糊想法 → `brainstorming / dbs-good-question / grill-me / grill-with-docs / dbs-deconstruct / dbs-goal`
- 缺背景证据 → `Agent Reach / dbs-learning / dbs-content-system / dbs-report / dbs-save / dbs-restore`
- 需要方案收束 → `to-prd / writing-plans / to-issues / triage / improve-codebase-architecture / executing-plans`
- 需要判断继续还是停机 → `dbs-decision / dbs-slowisfast / dbs-report / dbs-goal`

动作：

- 调用对应技能
- 获取新增信息

---

### 2.4 ABSORB_EVIDENCE

把技能返回的信息吸收进当前理解。

动作：

- 归纳新增信息
- 判断信息增量
- 更新当前想法轮廓

---

### 2.5 REEVALUATE

判断是否继续循环、转端，或停机。

判断问题：

- 现在更像澄清、研究、搜索、理论、执行、验证还是决策？
- 新信息是否改变路线？
- 是否已经足够让用户满意？

动作：

- 决定继续 CLARIFY
- 决定再次 ROUTE_SKILL
- 决定转 B/C/D/E/F
- 决定停机

---

### 2.6 LOOP_BACK / TRANSFER

根据判断结果进入下一轮或转端。

#### LOOP_BACK

当仍不成熟时，回到 CLARIFY 或 ROUTE_SKILL。

#### TRANSFER

当已成熟时，转入：

- B：外部资料 / Source Pack
- C：方案 / PRD / plan
- D：落库 / 执行
- E：验证
- F：决策

---

## 3. 轮次升级规则

### 第一轮

优先做：

- 问题定义
- 目标确认
- 边界确认

### 第二轮

优先做：

- 补证据
- 补概念
- 补外部来源

### 第三轮及以后

优先做：

- 收束方案
- 判断是否转端
- 判断是否已满意

---

## 4. 停机条件

A 端停止于以下任一条件：

```text
1. 初步想法已经收束到你满意的地步。
2. 继续追问只会改细节，不会改路线。
3. 你明确说“满意”或“先停”。
```

---

## 5. 一句话版本

```text
A 端状态机 = 先问清楚，再按需调用技能补信息，吸收后重新判断，直到用户满意或转端。
```
