---
title: Meme 项目方向调整设计文档
status: draft — 待 Owner 确认
created: 2026-06-28
trigger: 用户参考 CryptoAgents + Aegis Flux 两个多代理项目，要求把 meme 项目往 AI 辅助判断推理方向调整
decision_pending: 引擎放置位置（A/B/C）
---

# Meme 项目方向调整设计文档

## 1. 背景与触发

用户提出参考两个多代理 AI 项目，把 meme 项目往新方向调整：

| 参考项目 | 仓库 | 定位 |
|---|---|---|
| CryptoAgents | `github.com/sserrano44/CryptoAgents` | 多代理加密货币交易桌模拟 |
| Aegis Flux | `github.com/FamilOrujov/multi-agent-hedgefund` | 多代理投资分析系统（含 HITL 护栏） |

**用户明确要求：**
- 前期先做出用 AI 辅助判断推理市场的能力
- 不一定一开始就做成交易机器人
- 配合已有 meme-repo 项目来看，这次是调整方向

本文档是方向调整的设计草案，**确认后再动代码**。

---

## 2. 参考项目架构分析

### 2.1 CryptoAgents

| 维度 | 内容 |
|---|---|
| 定位 | 完整交易桌模拟（含交易员 + 持仓管理） |
| 编排 | LangGraph 有向图 |
| 代理链 | 市场/社交/新闻/基本面分析师 → 多空研究员辩论 → 交易员 → 风险三视角(激进/中性/保守) → 组合经理 |
| LLM | OpenAI (gpt-4o) |
| 数据源 | CoinMarketCap / Google News / Reddit |
| 输出 | 交易决策（买/卖/持有） |
| 工程化 | CLI + 编程接口 |

**可借鉴：** 风险三视角辩论模式、多空研究员对抗机制
**前期不需要：** 交易员节点、持仓管理、真实交易执行

### 2.2 Aegis Flux (multi-agent-hedgefund)

| 维度 | 内容 |
|---|---|
| 定位 | 投资分析系统（分析 + 推荐，**不执行交易**） |
| 编排 | LangGraph **循环图**（置信度低时自动精炼回环） |
| 代理链 | Data Scout → 技术/基本面/情绪分析师 → **共识辩论** → 组合经理 |
| LLM | **Ollama 本地 LLM**（零 API 成本） |
| 数据源 | Yahoo Finance + Tavily 实时网络研究 |
| 输出 | **可审计投资论点 + PDF 报告** |
| 人工控制 | **HITL 护栏**（可配置审查触发器，SELL 必审） |
| 工程化 | FastAPI + WebSocket + Docker + PostgreSQL + 向量库 + Textual TUI |

**与 meme Paper-Only 的高度契合点：**
1. 本身不是交易机器人 — 输出可审计判断而非交易指令，契合 Paper-Only 边界
2. HITL 护栏 ≈ 拒绝门禁 + Paper-Only 边界检查，天然同构
3. 共识辩论机制 — 代理基于证据互相说服（非简单投票），服务"判断推理"
4. 循环图 + 置信度回环 — 判断不确定时自动精炼，比单向流水线更适合推理
5. 本地 LLM — 成本可控，隐私

---

## 3. meme-repo 现状诊断

### 3.1 已有规则层（完整）

meme-repo 已定义完整的判断规则体系，位于 `docs/project_ai_context/`：

| 文件 | 内容 | 对应引擎角色 |
|---|---|---|
| `00_PROJECT_IDENTITY` | 项目身份/边界 | 系统约束 |
| `01_STRATEGY_DEFINITION` | FCZ/Volume Profile/深回撤/二次启动 | 链上结构分析师 |
| `02_SOURCE_ROLE_MAP` | 证据来源与角色映射 | Data Scout 数据规范 |
| `03_EVIDENCE_BRIEF_REQUIREMENT` | 证据完整性要求 | 证据校验 |
| `04_DECISION_OUTPUT_RULES` | 5 种输出类型 + 禁止项 | Portfolio Manager |
| `05_REJECTION_GATE` | Holder/Bundler/Insider 拒绝门禁 | 风险审查员 |
| `06_PAPER_ONLY_BOUNDARY` | Paper-Only 禁止项 | HITL 护栏 |
| `06-1_BOUNDARY_CHECKLIST` | 越界检测清单 | 边界守卫 |
| `06-2_VERIFICATION_GATE` | 验证门禁 | 置信度回环 |
| `07_NEXT_ROADMAP` | Phase 0-6 路线 | 执行路线 |
| `08_LEARNING_LOOP` | 学习闭环 | 反馈循环 |
| `09_STRUCTURE_FIX_PLAN` | 结构修复方案 | 架构修正 |

### 3.2 缺失的执行引擎层

| 缺失项 | 后果 |
|---|---|
| 多代理编排（agent 定义 + state + 工作流） | 规则无法自动执行，只能靠人/agent 手动读文档 |
| 辩论共识机制 | 缺乏多视角对抗，判断单一化 |
| 数据采集管道（可运行） | Phase 1 卡住，无数据流入 |
| 状态流转 + 置信度回环 | 判断不确定时无法自动精炼 |
| 可审计输出（结构化报告） | 判断过程不可追溯 |

### 3.3 当前阻塞点

- **Phase 1 数据管道** ⛔ 阻塞在 GMGN API key 未提供
- 之前的批判审查发现：阈值未经数据验证、控盘假设未论证、Volume Profile 适用性存疑、样本量不足
- cron 循环空转（文档格式层面自我循环，策略实质零推进）

---

## 4. 核心洞察：有规则无引擎

> meme-repo 当前最大的结构性问题不是规则缺失，而是**规则没有装进执行引擎**。
> 01-09 文档定义了完整的 FCZ 策略 / 拒绝门禁 / 5 种输出 / Paper-Only 边界，但没有一个能跑起来的系统去执行它。
> 这正是之前 v2 skill 暴露的核心教训：**"8 层协议是纯文本堆积，不是执行引擎"**。

两个参考项目（尤其 Aegis Flux）正好提供这个缺失的执行引擎：LangGraph 多代理工作流 + 辩论共识 + 状态流转 + HITL 护栏。

**调整方向 = 把已有规则层装进多代理执行引擎，而不是重写规则。**

---

## 5. 调整方案：规则层 → 多代理引擎节点映射

```
meme-repo 规则层                         →  Aegis Flux 引擎节点
──────────────────────────────────────────────────────────────────
Phase 1 数据管道 (GMGN/Helius/Birdeye)   →  Data Scout Agent（链上数据采集）
01_STRATEGY_DEFINITION (FCZ/VP/深回撤)   →  链上结构分析师 Agent
(新增: 资金流/情绪)                       →  资金流情绪分析师 Agent
05_REJECTION_GATE (Holder/Bundler)       →  风险审查员 Agent
(新增: 多空对抗)                          →  Bull/Bear 辩论共识
04_DECISION_OUTPUT_RULES (5种输出)        →  Portfolio Manager Agent
06_PAPER_ONLY_BOUNDARY                   →  HITL 护栏（Paper-Only 边界检查）
06-2_VERIFICATION_GATE + 08_LOOP         →  循环图置信度回环
```

**规则不变，只是从"文档读"变成"agent 执行"。** meme-repo 的策略领域知识（FCZ、Volume Profile、拒绝门禁）是有价值的，参考项目提供的是通用执行框架，两者互补。

### meme 场景相对参考项目的必要适配

| 参考项目原设计 | meme 场景适配 |
|---|---|
| Yahoo Finance / CoinMarketCap | Solana 链上数据：GMGN / Birdeye / Helius RPC / DexScreener |
| 传统技术指标（RSI/MACD/MA） | FCZ / Volume Profile / Holder 结构 / 深回撤区（已有） |
| 基本面（财报） | 链上基本面：持币分布 / 流动性池 / 合约审计 / bundler 检测 |
| 情绪（Reddit/News） | X / Telegram / DexScreener 热度 + 链上资金流 |
| 输出：买/卖/持有 | 输出：Paper-Only 判断（PAPER_LONG_CONDITIONALLY + 失效条件清单） |

---

## 6. 方向调整后的定位变化

| 维度 | 原定位 | 调整后 |
|---|---|---|
| 系统性质 | Paper-Only 决策工作流 **OS**（文档库） | Paper-Only **AI 判断推理引擎**（可执行系统） |
| 规则执行方式 | Agent 读文档手动执行 | 多代理协作自动执行 + 辩论共识 |
| 判断质量 | 单一视角 | 多视角对抗 + 证据驱动共识 |
| 数据依赖 | 阻塞在 GMGN API key | 引擎骨架先行，数据源后接（绕开阻塞） |
| 可审计性 | 散落在文档 | 结构化推理链 + 完整判断报告 |
| Paper-Only 边界 | 文档声明 | HITL 护栏强制执行 |

---

## 7. 数据源策略：绕开 GMGN 阻塞

meme-repo 卡在 Phase 1 因为没 GMGN API key。参考项目的做法是**先把引擎骨架跑通，数据源后接**：

1. **第一阶段（引擎骨架）：** Data Scout 先用公开端点（Birdeye 免费 API / Helius 免费 RPC / DexScreener）或 mock 数据跑通管道
2. **第二阶段（逻辑验证）：** 多代理编排 + 辩论 + Paper-Only 输出用模拟数据验证逻辑闭环
3. **第三阶段（数据接入）：** GMGN key 到位后热替换数据源，引擎本身不动

**这样不再被 API key 卡住**，先做出"AI 辅助判断推理"的能力闭环。

可选的公开数据源（无需付费 key）：
- DexScreener API — token 列表 + 价格 + 流动性（免费）
- Birdeye API — Solana 行情（免费额度）
- Helius RPC — 链上交易/holder 数据（免费额度）
- Jupiter API — 价格聚合

---

## 8. 待确认设计决策

### 决策 1：引擎放置位置（核心决策，需 Owner 拍板）

| 选项 | 方案 | 优点 | 缺点 |
|---|---|---|---|
| **A** | `loop循环项目` 的 `meme-loop-system` 分支搭引擎，引用 meme-repo 规则层 | 引擎与规则分离，loop 仓库承载通用框架的 meme 定制版 | 两仓配合，跨仓库引用 |
| **B** | 直接在 meme-repo 里新增引擎层 | 规则 + 引擎同仓，内聚 | meme-repo 从文档库变成代码项目，结构变化大 |
| **C** | 先只写本设计文档，确认后再动代码 | 零风险，先对齐 | 进度最慢 |

> **当前状态：Owner 已选 C（本文档）。确认设计后再选 A/B 进入实现。**

### 决策 2：LLM 选型

| 选项 | 说明 |
|---|---|
| 本地 LLM (Ollama) | 零成本，隐私，但 VPS 算力可能不足 |
| 云端 LLM (现有中转站) | 当前 Hermes 用的 glm-5.2 / gpt-5.4，成本可控 |
| 混合 | Data Scout 用便宜模型，辩论/决策用强模型 |

### 决策 3：第一期交付范围

| 候选 | 内容 |
|---|---|
| 最小闭环 | Data Scout(mock) + 链上结构分析师 + 风险审查员 + Portfolio Manager → Paper-Only 输出 |
| 含辩论 | 最小闭环 + Bull/Bear 辩论共识 |
| 含回环 | 含辩论 + 置信度回环精炼 |

---

## 9. 后续路线（确认设计后）

```
[本设计文档确认]
       ↓
[选 A/B + LLM 选型 + 第一期范围]
       ↓
[搭引擎骨架 — agent 定义 + state + 工作流]
       ↓
[规则层填入各 agent prompt — 引用 meme-repo 01/04/05/06]
       ↓
[Data Scout 用公开端点/mock 跑通]
       ↓
[多代理编排 + 辩论 + Paper-Only 输出跑通]
       ↓
[可审计报告输出]
       ↓
[GMGN key 到位后热替换数据源]
       ↓
[真实 token 端到端判断推理验证]
```

---

## 10. 参考来源

- CryptoAgents: `https://github.com/sserrano44/CryptoAgents`
- Aegis Flux (multi-agent-hedgefund): `https://github.com/FamilOrujov/multi-agent-hedgefund`
- meme-repo 规则层: `/root/meme-repo/docs/project_ai_context/00-09`
- loop循环项目: `github.com/sunshihao001/loop-.git`（main 分支 + meme-loop-system 分支）
