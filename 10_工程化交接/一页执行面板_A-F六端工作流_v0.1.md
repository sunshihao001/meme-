# 一页执行面板：A-F 六端工作流 v0.1

> 用途：手机 / 快速接管 / 现场执行  
> 规则：先按这个面板分端，再进各端正式合同与模板。

---

## 1. 一句话总纲

```text
A 定问题 → B 收证据 → C 造理论 → D 落仓库 → E 独验证 → F 拍板决策
```

---

## 2. 当前执行顺序

```text
1. A 端：把用户话说清楚，转成专业概念和路由
2. B 端：把资料压成干净 Source Pack
3. C 端：把 A/B 输入做成理论/方案包
4. D 端：把审查通过内容安全落库
5. E 端：独立验证 diff / CI / 边界
6. F 端：最终 owner 决策
```

---

## 3. 端口速查

### A 端

```text
职责：需求澄清、概念解析、路由
输入：用户原话、上下文、真源、技能候选
输出：Demand Grilling Brief、Concept Parsing Brief、Routing Brief
禁区：不做最终理论、不做证据压缩、不落库、不验证
```

### B 端

```text
职责：证据压缩、Source Pack
输入：文件、样本、旧知识、外部来源
输出：Source Pack、Coverage Matrix、Evidence Index
禁区：不下结论、不改 repo
```

### C 端

```text
职责：理论生成、Codex 调用、方案拆解
输入：A/B 输入、真源、任务包
输出：Theory Package、Codex Handoff、Landing Plan
禁区：不替 A/B、不改 repo、不替 E 验证
```

### D 端

```text
职责：Repo Landing、安全落库
输入：C/E 输入、repo 状态、PR 上下文
输出：Changed Files、Validation、Commit/PR 状态
禁区：不发明方向、不越过审查
```

### E 端

```text
职责：独立验证、PR-CI 审查
输入：A/B/C/D、diff、CI logs
输出：Verification Report、Verdict、Revision Request
禁区：不代替 D 改库、不把 pass 误判成业务正确
```

### F 端

```text
职责：owner 决策、风险边界
输入：A/B/C/D/E、目标、限制、偏好
输出：Owner Decision Brief、Approve/Pause/Redo
禁区：不做澄清、不做证据压缩、不做落库
```

---

## 4. 六端技能栈速记

```text
A: meme-demand-control-port
B: meme-source-pack-port
C: meme-theory-codex-port
D: meme-repo-landing-port
E: meme-verification-review-port
F: meme-owner-decision-port
```

### A 辅助

```text
dbs-good-question, ai-method-wheel, maintainer-orchestrator, github-pr-workflow, github-repo-management
```

### B 辅助

```text
codebase-inspection, ai-method-wheel, github-repo-management
```

### C 辅助

```text
codex, ai-method-wheel, maintainer-orchestrator, github-repo-management
```

### D 辅助

```text
github-pr-workflow, github-repo-management, ai-method-wheel, codex
```

### E 辅助

```text
requesting-code-review, github-pr-workflow, github-code-review, ai-method-wheel, systematic-debugging
```

### F 辅助

```text
dbs-decision, ai-method-wheel, maintainer-orchestrator, github-pr-workflow
```

---

## 5. 最小执行原则

```text
A 先把问题专业化
B 再把证据干净化
C 再把理论结构化
D 再把内容安全落库
E 再把结果独立验证
F 再做最终拍板
```

---

## 6. 现场快速判断

```text
- 现在问题不清？先 A
- 证据太乱？先 B
- 理论还没成形？先 C
- 要改仓库？先 D
- 要确认真假/越权？先 E
- 要决定路线/风险？先 F
```

---

## 7. 新 bot 启动一句话

```text
先确认你是 A/B/C/D/E/F 哪一端，再按该端合同工作；不要越端、不要混端、不要用口头感觉代替职责合同。
```
