# skills/dbs 未跟踪项处理建议 v0.1

> 分线：skills / dbs 治理
> 目的：对当前仍未进入 git 的 dbs 相关目录给出处理建议，避免把镜像、真源、草案混在一起。

---

## 1. 建议继续整理并纳入真源的目录

这些目录看起来像是完整 skill 真源，后续适合统一纳入仓库治理：

- `skills/dbs-action`
- `skills/dbs-agent-migration`
- `skills/dbs-ai-check`
- `skills/dbs-benchmark`
- `skills/dbs-chatroom`
- `skills/dbs-chatroom-austrian`
- `skills/dbs-content`
- `skills/dbs-content-system`
- `skills/dbs-decision`
- `skills/dbs-deconstruct`
- `skills/dbs-diagnosis`
- `skills/dbs-goal`
- `skills/dbs-good-question`
- `skills/dbs-hook`
- `skills/dbs-learning`
- `skills/dbs-report`
- `skills/dbs-restore`
- `skills/dbs-save`
- `skills/dbs-slowisfast`
- `skills/dbs-xhs-title`
- `skills/dbs/`

### 理由

- `.agents/skills/dbs-*` 已经显示出这些 skill 的镜像存在。
- `skills-lock.json` 指向仓库内 `skills/dbs-*` 的真源路径。
- 这些目录很可能就是仓库技能的最终载体，只是当前工作区还没把它们纳入 git 跟踪。

---

## 2. 建议暂缓的目录/文件

- `skills-lock.json`：已经加入 `.gitignore`，当前按状态文件处理。
- `.agents/`：作为镜像/缓存目录，当前不建议直接纳入仓库。

---

## 3. 继续处理建议

```text
如果要让仓库真正完整，下一步应该把 skills/dbs-* 逐个纳入 git，并检查是否需要对齐 AGENTS / SKILL / 说明文档。
```

```text
如果你不想扩大主线，就先保留这些目录未跟踪，等统一技能治理时再收。
```
