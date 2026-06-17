# meme 多端口 skill 组合栈 v0.1

> 分线：10_工程化交接 / 多 Telegram Bot 端口协作  
> 状态：v0.1 / 端口级 skill 组合约定  
> 目的：明确 meme 项目各 Telegram bot 端口不只是一个单 skill，而是一个由主 skill + 辅助 skills 组成的能力栈。这样新对话即使上下文不共享，也能按同一职责体系工作。

---

## 1. 为什么要有 skill 组合栈

单独一个 skill 往往只能说明：

```text
你是谁
你大概做什么
你不要做什么
```

但复杂端口还需要：

```text
1. 需求拷问能力
2. 循环代理 / maker-checker 认知
3. GitHub / PR / CI 操作能力
4. Codex 调用能力
5. repo 读取与文件归位能力
6. 审查 / debug / decision brief 能力
```

所以每个端口应由：

```text
端口主 skill + 辅助 skills
```

组成，而不是只靠一段提示词。

---

## 2. 端口总览

```text
A端：需求澄清 / 控制端
B端：资料压缩 / Source Pack 端
C端：理论生成 / Codex 调用端
D端：执行落库 / Repo 修改端
E端：验证审查 / PR-CI 端
F端：Owner 决策端（用户本人）
```

---

## 3. A端 skill 组合栈

### 3.1 主 skill

```text
meme-demand-control-port
```

### 3.2 辅助 skills

```text
dbs-good-question
ai-method-wheel
maintainer-orchestrator
github-pr-workflow
github-repo-management
```

### 3.3 A端能力职责

```text
需求拷问
好问题生成
目标澄清
端口路由
任务拆分
Owner decision brief
GitHub 状态判断
```

### 3.4 A端典型输出

```text
Demand Grilling Brief
Port Handoff Packet
Source Pack 任务说明
Codex 理论生成任务说明
执行落库任务说明
Owner Decision Brief
```

---

## 4. B端 skill 组合栈

### 4.1 主 skill

```text
meme-source-pack-port
```

### 4.2 辅助 skills

```text
codebase-inspection
ai-method-wheel
github-repo-management
```

如果后续需要处理 PDF / 扫描文档，再按需加：

```text
ocr-and-documents
```

### 4.3 B端能力职责

```text
只读读取关键项目文件
压缩散乱资料
生成 Source Pack
标记 unknown / not read
给 C端提供干净上下文
```

### 4.4 B端典型输出

```text
source-pack.md
读取文件清单
缺失信息
C端 handoff
```

---

## 5. C端 skill 组合栈

### 5.1 主 skill

```text
meme-theory-codex-port
```

### 5.2 辅助 skills

```text
codex
ai-method-wheel
maintainer-orchestrator
github-repo-management
```

### 5.3 C端能力职责

```text
基于 Source Pack 生成 Codex prompt
调用 Codex read-only / deep completion worker
生成理论草案或多文件理论包
检查 repo 无 diff
如果上游不足则打回 A/B/Owner
```

### 5.4 C端典型输出

```text
Codex prompt 文件
理论草案文件
深度理论补全包目录
C端 Upstream Revision Request
交给 E端的审查 handoff
```

---

## 6. D端 skill 组合栈

### 6.1 主 skill

```text
meme-repo-landing-port
```

### 6.2 辅助 skills

```text
github-pr-workflow
github-repo-management
codex
requesting-code-review
```

### 6.3 D端能力职责

```text
把审查通过的理论包落库成 repo 文件
更新 README / SOURCE_OF_TRUTH / ROADMAP / 索引 / 变更记录
运行 validate_all
git commit / push
检查 PR / CI
```

### 6.4 D端典型输出

```text
changed files
validate_all 结果
commit hash
push 结果
PR / CI 状态
给 E端的落库 handoff
```

---

## 7. E端 skill 组合栈

### 7.1 主 skill

```text
meme-verification-review-port
```

### 7.2 辅助 skills

```text
requesting-code-review
github-pr-workflow
github-code-review
ai-method-wheel
systematic-debugging
```

### 7.3 E端能力职责

```text
审查 C端理论包
审查 D端 repo diff
运行 validate_all
检查 PR / CI
判断是否越权
生成 Owner Decision Brief
```

### 7.4 E端典型输出

```text
C端理论草案审查结果
D端落库结果审查结果
Owner Decision Brief
返回 A/C/D 的修正清单
```

---

## 8. skill 组合栈使用原则

### 原则 1：主 skill 定身份

主 skill 负责告诉 bot：

```text
你是谁
你负责什么
你不负责什么
```

### 原则 2：辅助 skill 补能力

辅助 skills 负责：

```text
需求拷问
GitHub 操作
Codex 调用
验证审查
debug / review
```

### 原则 3：按任务加载，不要全堆

不是每次都加载所有 skill。

例如：

```text
A端必须有 dbs-good-question 和 ai-method-wheel
B端重点是 codebase-inspection
C端重点是 codex
D端重点是 github-pr-workflow
E端重点是 requesting-code-review
```

### 原则 4：长提示词交给文件，不要堆聊天

```text
端口提示词文件
Source Pack
Codex prompt
Owner Decision Brief
```

都应作为 Markdown 文件，而不是聊天长文。

---

## 9. 推荐落库路径

如果后续要正式写入 repo，建议：

```text
10_工程化交接/meme多端口skill组合栈_v0.1.md
skills/meme-demand-control-port/SKILL.md
skills/meme-source-pack-port/SKILL.md
skills/meme-theory-codex-port/SKILL.md
skills/meme-repo-landing-port/SKILL.md
skills/meme-verification-review-port/SKILL.md
```

然后同步更新：

```text
SOURCE_OF_TRUTH.md
ROADMAP.md
00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md
00_知识库设计规范/05_索引与变更记录/设计规范变更记录.md
```

---

## 10. 与 ai- 的关系

```text
meme-：项目级端口 skill 栈
ai-：通用 AI 方法轮 / 通用工作流 skill 本体
```

经验上：

```text
先在 meme 项目跑通端口 skill 栈
再把通用部分抽象回 ai-
```

---

## 11. 一句话结论

```text
每个端口应该有专用 skill 组合栈：主 skill 定身份，辅助 skills 定能力，提示词定当前会话入口，文件定长期规则。
```
