---
name: meme-theory-codex-port
description: |
  meme 项目 C端理论生成/Codex 调用 skill。基于 Source Pack 生成 Codex prompt，调用 Codex read-only 或 repo 外输出目录 worker，产出理论草案/深度理论包，不改 meme repo。
---

# meme-theory-codex-port

## 1. 端口身份

C端：理论生成 / Hermes 调用 Codex 端。

职责：基于 B端 Source Pack 调用 Codex 生成理论草案或 v0.2 深度理论包。

## 2. Handoff 接收纪律

C端只接收 A端问题框架 + B端 Source Pack + 明确理论生成任务。没有 A/B handoff 时，不直接生成理论，必须打回 A 或 B。

最小 handoff 必须包含：

```text
From: A/B
To: C
Goal:
Input:
Boundary:
Expected:
Return if:
```

## 3. 适用场景

```text
B端 Source Pack 已生成
需要长理论草案
需要 deep framework completion
需要 Codex 作为 maker worker
```

## 3. 输入

```text
C:/Users/Administrator/AppData/Local/hermes/profiles/cangwei/home/source-packs/meme-quant-master-source-pack.md
```

## 4. v0.2 深度输出目录

```text
C:/Users/Administrator/AppData/Local/hermes/profiles/cangwei/home/codex-outputs/meme-quant-master-theory-deep-completion-v0.2/
```

必含文件：

```text
00_master_framework.md
01_source_pack_coverage_matrix.md
02_16_layer_deep_map.md
03_gmgn_to_fcz_mapper_theory.md
04_sample_labeling_and_falsification.md
05_risk_reason_codes_and_scoring.md
06_stage_gates_kill_switch_owner_decisions.md
07_d_port_repo_landing_plan.md
08_e_port_review_checklist.md
99_run_report.md
```

## 5. 推荐 Codex v0.2 命令

```bash
OUT='/c/Users/Administrator/AppData/Local/hermes/profiles/cangwei/home/codex-outputs/meme-quant-master-theory-deep-completion-v0.2'
PROMPT='/c/Users/Administrator/AppData/Local/hermes/profiles/cangwei/home/codex-prompts/meme-quant-master-theory-deep-completion-v0.2.md'
mkdir -p "$OUT"

codex exec   --skip-git-repo-check   -C "$OUT"   --sandbox workspace-write   --output-last-message "$OUT/99_run_report.md"   - < "$PROMPT"
```

## 6. 深度要求

每一层必须包含：

```text
Layer name
Purpose
Inputs
Outputs
Data objects
Primary decisions
Failure modes
Unknowns / assumptions
Current repo evidence
GMGN-related evidence
Stage gate
E端验收点
D端落库候选文件/章节
```

## 7. 上游打回机制

```text
Source Pack 不足 → 打回 B端
需求目标/验收标准不足 → 打回 A端
涉及方向/权限/交易阶段门 → 打回 Owner
```

必须输出 `C端 Upstream Revision Request`，不能硬生成低质量理论包。

## 8. 禁止事项

```text
不改 meme repo
不落库
不提交 git
不 push
不创建 PR
不合并 PR
不接私钥/API key
不做 swap/自动下单/实盘
不把单文件草案冒充深度理论包
不把长输出贴 Telegram
```

## 9. 验证命令

```bash
OUT='/c/Users/Administrator/AppData/Local/hermes/profiles/cangwei/home/codex-outputs/meme-quant-master-theory-deep-completion-v0.2'
test -s "$OUT/00_master_framework.md"
test -s "$OUT/01_source_pack_coverage_matrix.md"
test -s "$OUT/02_16_layer_deep_map.md"
test -s "$OUT/03_gmgn_to_fcz_mapper_theory.md"
test -s "$OUT/04_sample_labeling_and_falsification.md"
test -s "$OUT/05_risk_reason_codes_and_scoring.md"
test -s "$OUT/06_stage_gates_kill_switch_owner_decisions.md"
test -s "$OUT/07_d_port_repo_landing_plan.md"
test -s "$OUT/08_e_port_review_checklist.md"
cd '/c/Users/Administrator/Documents/MQL5_第一控盘区成本中枢回收模型_学习资料'
git diff --exit-code
```
