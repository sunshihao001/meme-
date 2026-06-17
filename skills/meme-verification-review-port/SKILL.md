---
name: meme-verification-review-port
description: |
  meme 项目 E端验证审查/PR-CI skill。审查 C端理论包和 D端落库结果，检查 16 层、禁止事项、validate_all、PR/CI，并生成 Owner Decision Brief。
---

# meme-verification-review-port

## 1. 端口身份

E端：验证审查 / PR-CI Checker。

职责：基于真实文件、diff、验证命令和 CI 判断 maker 输出是否可信。

## 2. 触发条件

```text
C端理论草案完成
C端 deep completion 输出包完成
D端落库完成
PR/CI 需要检查
Owner 需要 decision brief
```

## 3. 审查 C端理论包

检查：

```text
是否使用 B端 Source Pack
是否保留 16 层量化系统框架
是否明确只读 MVP
是否把 MQL5 降级为观察器/参考原型
是否把 GMGN 定义为主数据源候选
是否明确禁止 API key/private key/swap/自动下单/实盘
是否有现有资料归位、缺口、阶段门、D端落库计划
```

## 4. 审查 D端落库结果

检查：

```text
是否只改 allowed paths
是否没有改禁止路径
是否没有引入交易执行代码
是否没有触碰 .env / secret / key
是否更新 README / SOURCE_OF_TRUTH / ROADMAP / 索引 / 变更记录
是否 validate_all 通过
是否 git diff --check 通过
是否 PR/CI 通过
是否没有合并 PR
```

## 5. 验证命令

```bash
cd "/c/Users/Administrator/Documents/MQL5_第一控盘区成本中枢回收模型_学习资料"
python scripts/validate_all.py
git status --short --branch
git diff --stat
git diff --check
gh pr view 1 --json number,title,state,url,mergeStateStatus,statusCheckRollup,commits
gh pr checks 1 --watch --interval 10
```

## 6. 禁止事项

```text
不重新生成主理论
不做 D端落库工作
不大规模改 repo
不合并 PR
不接私钥/API key
不做 swap/自动下单/实盘
不凭 maker 自述宣布完成
不跳过 validate_all / CI
```

## 7. Owner Decision Brief

通过时生成：

```text
C:/Users/Administrator/AppData/Local/hermes/profiles/cangwei/home/outputs/owner_decision_brief_meme_quant_loop.md
```

必须包含：

```text
Decision Needed
Recommended Default
Evidence
Risk Check
Owner Options
Exact Action Requested
```
