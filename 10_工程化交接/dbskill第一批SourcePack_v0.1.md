# dbskill 第一批 Source Pack v0.1

> 分线：10_工程化交接 / 外部技能接入 / B端SourcePack  
> 来源仓库：https://github.com/dontbesilent2025/dbskill  
> 本地镜像：C:/Users/Administrator/ai-skill-knowledge/repos/dbskill  
> 范围：dbs-good-question / dbs-deconstruct / dbs-goal / dbs-diagnosis  
> 目的：把第一批接入所需原文证据压缩成 B 端可交付 Source Pack，供 C 端设计 A端判断增强包。

---

## 1. Source Pack 结论

```text
第一批四个 skill 适合进入 A 端判断增强链。
```

它们分别覆盖：

```text
1. dbs-good-question：把模糊问题转成 Agent 可推理、可批评、可验证的问题说明书。
2. dbs-deconstruct：把模糊概念拆到原子级，识别伪概念、语言陷阱和 Question/Problem 混淆。
3. dbs-goal：把愿望语法审计成可检查目标，识别空转词和不可验收目标。
4. dbs-diagnosis：商业模式问诊/体检，核心不是回答问题，而是消解错误问题。
```

---

## 2. 原始技能路径

```text
C:/Users/Administrator/ai-skill-knowledge/repos/dbskill/skills/dbs-good-question/SKILL.md
C:/Users/Administrator/ai-skill-knowledge/repos/dbskill/skills/dbs-deconstruct/SKILL.md
C:/Users/Administrator/ai-skill-knowledge/repos/dbskill/skills/dbs-goal/SKILL.md
C:/Users/Administrator/ai-skill-knowledge/repos/dbskill/skills/dbs-diagnosis/SKILL.md
```

---

## 3. dbs-good-question 摘要

### 触发

```text
/dbs-good-question
/好问题
/问题说明书
/Agent可解性
“这个问题能不能自动化解决”
“帮我把问题说清楚”
```

### 核心使命

```text
让问题承担推理约束。
```

### 关键原则

```text
1. 好问题先钉现象。
2. 好问题要暴露冲突。
3. Agent 需要约束场。
4. 自动化解决需要反馈回流。
5. 不要装确定。
6. 先给抓手，再做审计。
```

### 标准检查

```text
对象 / 目标 / 冲突 / 约束 / 反馈
```

### 自动化判断

```text
A档：可高度自动化
B档：可半自动化
C档：可辅助推理
D档：暂不适合自动化
```

### 对 A 端价值

```text
可并入 Demand Grilling Brief 的“问题定义 + Agent 可解性 + 验证边界”部分。
```

---

## 4. dbs-deconstruct 摘要

### 触发

```text
/dbs-deconstruct
/拆概念
“帮我拆解这个概念”
“这个词到底什么意思”
```

### 核心使命

```text
反对语言对理智的蛊惑，把模糊商业概念拆到原子级。
```

### 关键原则

```text
1. 语言的界限即世界的界限。
2. 意义即使用。
3. 7 张表构建本体论。
4. 区分 Question 和 Problem。
```

### 标准流程

```text
1. 接收概念。
2. 使用场景分析。
3. 概念还原。
4. 伪概念检测。
5. 奥派经济学校准。
6. 输出拆解报告。
```

### 对 A 端价值

```text
可并入 A 端的“概念解析 / 术语消歧 / 假设核查”模块。
```

---

## 5. dbs-goal 摘要

### 触发

```text
/dbs-goal
/目标
“帮我搞清楚目标”
“我想做个人 IP”
“我的目标是成为...”
```

### 核心使命

```text
反对目标语言的空转，把模糊目标审计成可检查交付物。
```

### 关键原则

```text
1. 意义即使用。
2. 发动机空转检测。
3. 家族相似性而非本质定义。
4. 目标的工作定义：下一步做什么，什么时候算完。
```

### 三个用法测试

```text
1. 如果做到了，你会指着什么说“就是这个”？
2. 什么情况下算没做到？
3. 做到这一步之后，下一步做什么？
```

### 输出结构

```text
原话 / 三个用法测试 / 空转词清单 / 重写版 / 验收 checklist / 下一步行动
```

### 对 A 端价值

```text
可并入 A 端的“目标澄清 / 验收标准 / 下一步动作”模块。
```

---

## 6. dbs-diagnosis 摘要

### 触发

```text
/dbs-diagnosis
/问诊
“帮我看看商业模式”
“诊断一下我的业务”
“我有个商业问题”
```

### 核心使命

```text
不是回答问题，而是消解问题。
```

### 两种模式

```text
问诊：判断具体问题本身成不成立。
体检：用框架拆商业模式。
```

### 问诊分类

```text
1. 纯信息获取类。
2. 情绪宣泄类。
3. 复杂问题。
```

### 消解漏斗

```text
1. 语言陷阱检测。
2. 假设错误检测。
3. 逻辑错误检测。
4. 事实前提核查。
5. 信息充分性判断。
```

### 对 A/C/F 价值

```text
A端：判断问题是否成立。
C端：提供商业诊断视角。
F端：辅助 owner 决策，但不能替代 owner 决策。
```

---

## 7. B端证据判断

```text
第一批四个 skill 不是平行工具，而是一条 A端判断链：
好问题 → 概念拆解 → 目标澄清 → 商业诊断/问题消解。
```

建议 C 端包装时不要照搬原始四个 skill，而应合并成：

```text
dbskill-A端判断增强包
```

---

## 8. 给 C端的输入

C 端应基于本 Source Pack 输出：

```text
10_工程化交接/dbskill-A端判断增强包设计_v0.1.md
```

必须包含：

```text
1. 何时调用四个能力。
2. 四个能力如何合并进 Demand Grilling Brief。
3. 哪些内容只作为外部桥接参考。
4. 哪些内容不能进入 A 端主控。
5. 输出模板。
```
