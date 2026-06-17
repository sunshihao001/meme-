# meme-：Meme 第一控盘区成本中枢回收模型知识库

> 状态：研究型知识库 / 观察指标需求库 / AI Agent 协作仓库  
> 当前阶段：GitHub 项目治理层 v0.1 / GMGN 自建量化交易系统架构落库  
> 最后更新：2026-06-16

---

## 1. 项目是什么

本仓库用于维护一个围绕 meme 市场结构策略的研究知识库，核心关注：

```text
meme 庄家第一控盘区深洗后，基于 POC / AVWAP 成本锚重新接受与二次拉升确认的保守型 re-accumulation / reclaim 观察策略。
```

它把策略研究拆成可审计、可反证、可迭代的文件系统：

```text
策略定义
庄家周期语义
第一控盘区 / POC / AVWAP 等概念定义
诱多与死亡盘风险过滤
真实与模拟样本标注
MQL5 / MT5 观察指标需求
规则、回测与反证实验设计
AI 软件工程方法轮交接材料
```

---

## 2. 项目不是什么

本仓库当前不是：

```text
自动下单系统
收益承诺系统
单一买卖信号库
MT5 最终执行平台
链上数据全自动标注系统
```

所有策略、指标、评分、样本标注内容都必须保持研究/观察定位，不能被写成自动交易建议或收益保证。

---

## 3. 快速入口

Agent / 人类接手项目时，先读：

```text
AGENTS.md
SOURCE_OF_TRUTH.md
00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md
00_知识库设计规范/05_索引与变更记录/设计规范变更记录.md
skills/mql5-fcz-reclaim-kb/SKILL.md
ROADMAP.md
```

如果只想了解当前项目结构，先看：

```text
00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md
```

如果要理解最终 GMGN 自建 meme 量化交易系统架构，先看：

```text
13_量化交易系统架构/00_总览_GMGN自建meme量化交易系统.md
13_量化交易系统架构/01_系统层次地图.md
13_量化交易系统架构/03_缺口清单与阶段门.md
13_量化交易系统架构/04_MVP闭环定义.md
13_量化交易系统架构/06_C端v0.2深度理论落库总纲.md
13_量化交易系统架构/07_FCZ状态机专题_v0.2.md
```

如果要继续推进 AI 工作流，先看：

```text
10_工程化交接/
specs/
.github/ISSUE_TEMPLATE/
.github/pull_request_template.md
```

如果要先接手当前项目、判断从哪里继续，先看：

```text
10_工程化交接/Project_Continuation_Brief_v0.1.md
```

---

## 4. 目录结构

```text
00_知识库设计规范/       # 总纲、分线、版本、索引、变更记录
01_策略定义/             # 策略定位、边界、商业角色
02_庄家周期/             # 深洗、死亡盘、重新吸筹等周期语义
03_语义概念/             # 第一控盘区、POC、AVWAP、重新接受等概念
04_风险管理/             # 诱多、失败回收、结构风险评分
05_关键词检索/           # 多语言关键词、检索计划、资料清单
06_资料吸收/             # MQL5 / 论坛 / 文章资料吸收笔记
07_样本标注/             # 样本字段、样本记录、CSV 样本库
08_指标需求/             # MQL5 观察指标需求与字段映射
09_规则与回测/           # 状态机、反证、消融、对标实验
10_工程化交接/           # AI 工程流、Issue/PR 草案、Codex handoff
11_问题清单/             # 待决策问题
12_决策记录/             # Owner 决策记录
13_量化交易系统架构/     # GMGN 自建 meme 量化交易系统架构、缺口、MVP 与迁移路线
99_归档/                 # 废弃或过时材料
scripts/                 # 本地验证脚本
tests/                   # 单元测试
specs/                   # AI 方法轮 spec / plan / tasks / checklist
.github/                 # GitHub Actions、Issue 模板、PR 模板
skills/                  # 项目级 Agent skill 真源
```

---

## 5. 当前验证方式

本地运行：

```bash
python scripts/validate_all.py
```

当前验证聚合包含：

```text
unit tests
sample CSV schema validator
sample state-path validator
```

GitHub Actions：

```text
.github/workflows/validate.yml
```

每个 PR 至少应说明是否运行了：

```text
python scripts/validate_all.py
```

---

## 6. AI 工作流

本项目采用轻量 AI Method Wheel：

```text
Good Question Brief
→ spec
→ plan
→ tasks
→ GitHub issue / local issue draft
→ Agent handoff
→ TDD / QA / review
→ PR
→ CI
→ Owner decision
→ merge
```

执行原则：

```text
1. GitHub 是协作真源，聊天不是长期记忆。
2. 重要结论必须写入 Markdown / CSV / spec / issue draft。
3. 每次新增正式文件必须更新索引与变更记录。
4. 每次进入 PR 前必须跑 validate_all。
5. Agent 可以执行清晰、可验证的小任务；产品、风险、权限、合并、发布仍由 owner 决策。
6. GMGN 自建量化交易系统架构只允许先做只读数据、样本反证、状态字段和观察闭环；禁止跳到 API key/private key/swap/自动下单。
```

---

## 7. 当前推荐下一步

优先级见：

```text
ROADMAP.md
```

当前最建议的下一批 issue：

```text
1. 先接入 Project Continuation Brief 到入口层。
2. 补齐 FCZ_B_0001 真实“模型符合但失败”样本。
3. 为 FCZ_C_0001 / FCZ_D_0001 增加图表派生结构标注。
4. 增加样本记录 Markdown 字段完整性 validator。
5. 增加索引引用存在性 validator。
6. 编写 MQL5 观察指标 MVP 开发计划。
```

对应本地草案位于：

```text
10_工程化交接/
```

---

## 8. 贡献 / Agent 执行规则

任何 Agent 开始工作前必须：

```text
1. 读取 AGENTS.md 与 SOURCE_OF_TRUTH.md。
2. 确认任务属于哪个分线。
3. 从 main 新建分支，不直接在 main 上做大改。
4. 修改后更新索引与变更记录。
5. 运行 python scripts/validate_all.py。
6. 提交 PR，并在 PR 中写明验证结果和 owner 决策点。
```

详细模板见：

```text
.github/ISSUE_TEMPLATE/
.github/pull_request_template.md
```
