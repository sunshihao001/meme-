---
name: meme-source-pack-port
description: |
  meme 项目 B端 Source Pack / 资料压缩 skill。只读读取关键项目和 GMGN 资料，压缩成 source-pack.md，交给 C端理论生成；不改 repo、不调用 Codex。
---

# meme-source-pack-port

## 1. 端口身份

B端：资料压缩 / Source Pack Builder。

职责：把散乱项目资料压缩成 C端可使用的 Source Pack。

## 2. Handoff 接收纪律

B端只接收 A端 handoff / 搜索任务单 / 知识缺口定义。没有 A端 handoff 时，不直接处理用户原始输入，必须打回 A端。

最小 handoff 必须包含：

```text
From: A
To: B
Goal:
Input:
Boundary:
Expected:
Return if:
```

## 3. 适用场景

```text
C端理论生成前
资料太散
Codex 不应直接读大目录
需要生成 source-pack.md
```

## 3. 必读文件

```text
README.md
AGENTS.md
SOURCE_OF_TRUTH.md
ROADMAP.md
10_工程化交接/Project_Continuation_Brief_v0.1.md
10_工程化交接/根系需求更正_GMGN自建交易系统_v0.1.md
10_工程化交接/Hermes调用Codex命令编排工作流_v0.1.md
specs/mql5-fcz-reclaim-model/full_meme_quant_trading_system_gap_brief.md
09_规则与回测/GMGN数据源到FCZ状态机字段映射_v0.1.md
13_量化交易系统架构/00_总览_GMGN自建meme量化交易系统.md
13_量化交易系统架构/01_系统层次地图.md
13_量化交易系统架构/02_现有资料归位矩阵.md
13_量化交易系统架构/03_缺口清单与阶段门.md
13_量化交易系统架构/04_MVP闭环定义.md
13_量化交易系统架构/05_从研究库到交易系统的迁移路线.md
```

GMGN 资料优先读取：

```text
C:/Users/Administrator/gmgn_requirement_knowledge_base/README.md
C:/Users/Administrator/gmgn_requirement_knowledge_base/10_GMGN最小可行量化闭环MVP/README.md
```

## 4. 输出文件

```text
C:/Users/Administrator/AppData/Local/hermes/profiles/cangwei/home/source-packs/meme-quant-master-source-pack.md
```

## 5. Source Pack 必含章节

```text
Project Identity
Root Goal Correction
Current Stage and Forbidden Actions
16-Layer Quant System Frame
Current Read-Only MVP
Existing Material Mapping Summary
GMGN Capability Summary
Current Gaps
Instructions for C端 Theory Generation
Files Read
Not Read / Unknown
```

## 6. 禁止事项

```text
不写最终理论
不调用 Codex
不改 repo
不提交 git
不 push
不创建 PR
不复制大段 gmgn-skills 原文
不接 API key/private key
不做交易执行
```

## 7. 验证命令

```bash
test -s "/c/Users/Administrator/AppData/Local/hermes/profiles/cangwei/home/source-packs/meme-quant-master-source-pack.md"
cd "/c/Users/Administrator/Documents/MQL5_第一控盘区成本中枢回收模型_学习资料"
git diff --exit-code
```

## 8. 打回规则

```text
关键文件缺失 → 打回 A端
GMGN 资料不足 → 报告 unknown，不猜测
需求目标不清 → 打回 A端
涉及 owner gate → 打回 Owner
```
