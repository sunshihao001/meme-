# skills/dbs 目录整理清单 v0.1

> 分线：skills / dbs 技能治理
> 目的：记录当前 .agents/skills/dbs-* 与仓库 skills/dbs-* 的关系，作为后续统一治理的依据。

---

## 1. 当前观察

当前工作区里能看到两套来源：

- `.agents/skills/dbs-*`：本地镜像 / 运行缓存式目录
- `skills/dbs-*`：仓库内技能目录

这说明目前的 dbs 技能已经被镜像到工作区，但还没有对“真源、镜像、是否需提交”做一次最终判定。

---

## 2. 当前初步判断

### 建议保留为仓库真源的

- `skills/dbs-good-question`
- `skills/dbs-deconstruct`
- `skills/dbs-goal`
- `skills/dbs-diagnosis`
- `skills/dbs-learning`
- `skills/dbs-content`
- `skills/dbs-report`
- `skills/dbs-save`
- `skills/dbs-restore`
- `skills/dbs-slowisfast`
- `skills/dbs-xhs-title`
- `skills/dbs-action`
- `skills/dbs-agent-migration`
- `skills/dbs-ai-check`
- `skills/dbs-benchmark`
- `skills/dbs-chatroom`
- `skills/dbs-chatroom-austrian`
- `skills/dbs-content-system`
- `skills/dbs-decision`
- `skills/dbs-hook`

### 需要后续单独确认的

- `skills/dbs/` 主入口 skill
- `.agents/skills/dbs/` 镜像目录

---

## 3. 处理原则

```text
1. 先确认仓库 skills/ 是否是最终真源。
2. 再决定 .agents/ 里的镜像是否应保留为缓存，不纳入提交。
3. 不在未确认真源前删除任何技能目录。
4. 不把镜像目录和真源目录混为一谈。
```

---

## 4. 下一步建议

```text
1. 若要继续治理 dbs 技能，先逐个检查仓库 skills/dbs-* 是否缺失关键文档。
2. 若只想清理工作区，把 .agents/ 视为缓存并保留 .gitignore 忽略即可。
3. 若要统一真源，则需要再做一次 skills mirror ↔ repo skills 的差异比对。
```
