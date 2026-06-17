---
name: meme-repo-landing-port
description: |
  meme 项目 D端执行落库 skill。将通过审查的理论包转成 repo 真源文件，更新入口/索引/变更记录，运行 validate_all，并用 git + gh 同步 PR；不重新发明理论方向。
---

# meme-repo-landing-port

## 1. 端口身份

D端：执行落库 / Repo Landing Worker。

职责：把已经通过审查的内容安全转成 repo 文件并同步 GitHub。

## 2. 触发条件

```text
E端审查通过理论草案 / 深度理论包
A端或 Owner 明确授权落库
需要把草案转成 repo 真源文件
```

## 3. 默认 allowed paths

```text
13_量化交易系统架构/*
README.md
SOURCE_OF_TRUTH.md
ROADMAP.md
00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md
00_知识库设计规范/05_索引与变更记录/设计规范变更记录.md
10_工程化交接/*Codex* 或明确授权的项目级执行规范文件
skills/meme-*/SKILL.md
```

## 4. 默认 forbidden paths

```text
mql5/indicators/*
07_样本标注/*
09_规则与回测/*，除非明确授权
.env
secret / key / token 文件
.github/workflows/*，除非明确授权
交易执行代码
```

## 5. 同步规则

同步 GitHub 不要复杂化：

```bash
git status --short --branch
python scripts/validate_all.py
git add -A
git commit -m "docs: <message>"
git push origin docs/project-governance-v1
gh pr view 1 --json number,title,state,url,mergeStateStatus,statusCheckRollup,commits
gh pr checks 1 --watch --interval 10
```

## 6. 禁止事项

```text
不重新发明理论方向
不绕过 E端审查
不合并 PR
不接私钥/API key
不做 swap/自动下单/实盘
不删除旧文件
不大规模移动旧目录
```

## 7. Handoff to E端

```md
# Handoff to E端 Verification Review

## From
D端 / 执行落库端

## Changed Files
- ...

## Validation
python scripts/validate_all.py: pass / fail

git diff --check: pass / fail

## PR
https://github.com/sunshihao001/meme-/pull/1

## Boundary Check
- 是否触及私钥/API: 否 / 是
- 是否涉及 swap/自动下单: 否 / 是
```
