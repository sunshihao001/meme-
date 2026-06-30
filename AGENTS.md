# AGENTS.md

> 项目：MQL5_第一控盘区成本中枢回收模型_学习资料  
> 用途：跨 Agent 宿主的项目级工作规则。Claude Code / Codex / Grok / Hermes 等进入本项目时，优先读取本文件。  
> 状态：v0.1，Agent 工作台最小规则层。

---

## 1. 项目定位

本项目是一个围绕 meme 市场结构策略的本地 Markdown 知识库，核心主题是：

```text
meme 庄家第一控盘区深洗后，基于 POC / AVWAP 成本锚重新接受与二次拉升确认的保守型 re-accumulation / reclaim 观察策略。
```

本项目当前不是：

```text
自动下单系统
收益承诺系统
单一买卖信号库
MT5 最终执行平台
链上数据全自动标注系统
```

本项目当前是：

```text
策略研究知识库
MQL5 / MT5 资料吸收库
结构语义定义库
风险评分与观察指标需求库
后续 OKX/crypto quant 系统的知识源之一
```

---

## 2. 最高工作纪律

所有 Agent 在本项目工作时必须遵守：

```text
1. 所有重要结论必须落到本地 Markdown 文件，不只停留在聊天上下文。
2. 不把推测写成已确认结论。
3. 不把观察指标写成自动交易建议。
4. 不破坏已有目录结构与历史版本。
5. 新增文件必须更新索引与变更记录。
6. 引入外部资料时必须保留来源、吸收笔记与对策略的影响。
7. 策略、指标、评分、样本标注四层必须分开，不混写。
8. 新输入默认先过 dbs 路由，再进入 A 端最小澄清；除非明确是续接、执行、恢复或验证。
9. 跳过 A 端时必须说明跳过理由，不能静默绕过入口门禁。
```

---

## 3. 启动阅读顺序

Agent 接手本项目时，先按顺序读取：

```text
1. SOURCE_OF_TRUTH.md
2. 10_工程化交接/Project_Continuation_Brief_v0.1.md
3. 00_知识库设计规范/00_总纲/知识库总纲_v0.1.md
4. 00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md
5. 00_知识库设计规范/05_索引与变更记录/设计规范变更记录.md
6. 当前任务对应分线的 README.md 与主文档
```

如果任务涉及项目级工作流，还要读取：

```text
skills/mql5-fcz-reclaim-kb/SKILL.md
skills/meme-demand-control-port/SKILL.md
skills/meme-source-pack-port/SKILL.md
skills/meme-theory-codex-port/SKILL.md
skills/meme-repo-landing-port/SKILL.md
skills/meme-verification-review-port/SKILL.md
```

---

## 4. 目录职责

```text
00_知识库设计规范/       # 总纲、设计规范、分线规范、版本机制、索引和变更记录
01_策略定义/             # 策略是什么、边界是什么、不是什么
02_庄家周期/             # 庄家阶段、深洗、死亡盘、重新吸筹等周期语义
03_语义概念/             # 第一控盘区、POC、AVWAP、重新接受等概念定义
04_风险管理/             # 诱多、失败回收、死亡盘、结构风险评分
05_关键词检索/           # 多语言关键词、检索计划、资料下载清单
06_资料吸收/             # MQL5 / 论坛 / 文章资料吸收笔记
07_样本标注/             # 后续人工样本标注体系与案例库
08_指标需求/             # MQL5 观察指标、状态标注器、字段映射、MVP计划
09_规则与回测/           # 后续规则整合、评分校准、回测设计
99_归档/                 # 过时版本、废弃定义、旧资料归档
skills/                  # 项目级 Agent skill 真源，只放可执行工作流，不放普通文章
```

---

## 5. 文档写作规范

新增知识库文章必须尽量包含：

```text
标题
版本
分线
目的
状态
本文要解决的问题
当前定义
不是什么
结构拆解
正向表现
反向表现 / 风险表现
常见误判
专属关键词
资料来源 / 可检索方向
对当前策略的影响
本版结论
下一步
```

资料吸收笔记必须写清：

```text
来源
原始问题
可吸收观点
不可直接照搬的部分
对 meme 第一控盘区模型的影响
可转化为指标 / 标注 / 风险评分的字段
```

---

## 6. meme 多端口 skills 约定

meme 多 Telegram bot 循环代理建议按端口拆分专用 skills，而不是只靠提示词：

```text
A 需求控制端 → meme-demand-control-port
B Source Pack 端 → meme-source-pack-port
C 理论生成端 → meme-theory-codex-port
D 落库端 → meme-repo-landing-port
E 验证审查端 → meme-verification-review-port
```

这些 skills 是项目级执行适配层；通用方法论归 ai-，meme 项目专属流程归 meme-。

---

## 7. 版本与命名规则

新增正式文件使用：

```text
主题名_v0.x.md
```

重大阶段变更在：

```text
00_知识库设计规范/05_索引与变更记录/设计规范变更记录.md
```

增加一个版本段落，例如：

```text
v0.1-P7-Agent工作台骨架
```

同时更新：

```text
00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md
```

---

## 7. 当前优先主线

当前建议优先级：

```text
P1. 执行 TP-003 / GitHub Issue #2：index reference validator，防止索引引用漂移。
P2. 执行 TP-004：sample record markdown validator，保护样本主线。
P3. 补 FCZ_B_0001 真实失败样本。
P4. 补 FCZ_C / FCZ_D 图表派生结构。
P5. 写 MQL5 观察器 MVP 计划，但仍保持观察器定位，不进入自动下单。
```

---

## 8. 禁止事项

```text
1. 禁止把聊天总结当成最终交付，必须写入文件。
2. 禁止直接删除或移动历史资料，除非用户明确授权。
3. 禁止把 MQL5 指标需求写成自动下单 EA。
4. 禁止把单篇论坛观点直接升级为策略结论。
5. 禁止在没有样本验证前宣称某个评分字段有效。
6. 禁止让 bridge 承载长期逻辑；长期逻辑必须维护在项目 skills/ 真源中。
```

---

## 9. 维护方式

以后维护原则：

```text
1. 项目规则先改 AGENTS.md。
2. Claude 专属说明只改 CLAUDE.md。
3. 真源地图只改 SOURCE_OF_TRUTH.md。
4. 工作流逻辑只改 skills/mql5-fcz-reclaim-kb/SKILL.md。
5. 普通知识内容仍进入 01-09 对应分线。
6. 每次结构变更必须更新索引与变更记录。
```
