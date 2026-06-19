# 外部观点吸收：Vibe Coding 第一关，先把模糊想法拷打成 Spec v0.2

> 分线：10_工程化交接 / 外部观点吸收
> 来源：X / Twitter 状态 `https://x.com/i/status/2054051112987115714`
> 作者：Xudong Han（@Xudong07452910）
> 抓取方式：Agent Reach v1.5.0 → OpenCLI Twitter Article
> 原始证据：`10_工程化交接/raw_refs/x_2054051112987115714_agent_reach_opencli.yaml`
> 状态：v0.2 / 已从“搜索摘要吸收”升级为“Agent Reach 抓取全文后重新吸收”

---

## 0. 本次纠偏记录

之前只用普通 `web_extract` / `web_search` / `x_search`，只能拿到 X 搜索摘要，因此文件 v0.1 标注为“未获取完整正文”。

Owner 纠正：应使用 `Agent-Reach` 这个专门外部搜索/社媒读取能力。

本次实际验证结果：

```text
agent-reach version → Agent Reach v1.5.0
agent-reach doctor --json → Twitter/X status=ok, active_backend=OpenCLI
opencli twitter article 2054051112987115714 -f yaml → 成功抓取 344 行 / 14346 字节原始 YAML
```

因此，后续处理 X 长文 / Twitter Article 类来源时，不能先用普通网页抽取下结论；应优先走：

```text
Agent Reach / OpenCLI / twitter article
→ x_search / web_search 兜底
→ web_extract 兜底
→ 明确标注不可获取边界
```

---

## 1. 原文核心观点

这篇文章的核心不是“怎么写代码”，而是：

```text
Vibe Coding 里投入产出比最高的一步，不是写代码，
而是先把脑子里模糊的“我想让它能 XX”，
通过对话拷打成一份能直接对照写代码、验收和修改的 spec。
```

作者的关键判断是：

```text
Spec 越糊，AI 跑得越快，偏得越远。
```

文章明确说：

```text
Vibe Coding 的 “Vibe” 是建立在 spec 上面的。
模糊需求在 AI Coding 流程里会被指数级放大。
```

原因是：

```text
AI 一次可能交付 20 个文件、500 行代码。
用户只扫一眼，能跑就过。
如果第一句话没说清，AI 自己脑补的假设会嵌进多个文件和多层抽象里，
等两周后才暴露时，修改成本可能比重写还高。
```

---

## 2. 文章提出的五步流程

### 2.1 第一步：先用一张表逼自己说人话

在和 AI 对话前，先花 10 分钟把原始想法写成表格，尤其要写出：

```text
我知道什么？
我不知道什么？
哪些边界还没定？
哪些问题需要 AI 追问我？
```

重点不是表本身，而是最后一行：

```text
不知道的地方。
```

因为当 Owner 诚实写出“不知道”，才知道下一步应该让 AI 追问什么。

对应到本项目：

```text
L0 自然语言表达层不能直接丢给 D/C 执行。
应先进入 A 端需求拷问，把“我还没想清楚”的部分暴露出来。
```

---

### 2.2 第二步：开 Plan mode，让 Claude Code 反着追问

文章强调，Claude Code 默认是“动手型选手”，用户一说需求它就容易开始建文件。

所以要开 Plan mode：

```text
不写代码
不改文件
只追问和澄清
```

这和本项目 A 端规则高度一致：

```text
A 端不是执行端。
A 端是阻止过早执行的需求拷问门。
```

文章把这个过程类比为苏格拉底的“产婆术”：

```text
不是直接告诉用户答案，
而是通过连续追问，
把用户脑子里尚未成型的答案逼出来。
```

对应到本项目：

```text
A 端 = Owner 自然语言 → 专业需求/Spec 的产婆术。
```

---

### 2.3 第三步：把对话沉淀成可审的 spec.md

文章强调：

```text
spec 不是给老板看的散文，
是给 Claude Code 和用户自己看的合同。
```

好的 spec 应该：

```text
像列表
像表格
像合同
能直接被代码实现和验收对照
```

坏的 spec 是：

```text
一堆“该功能旨在……”这种看起来正式但无法执行的散文。
```

对应到本项目：

```text
A 端输出不能只是解释和建议，
必须形成可交给 B/C/D/E/F 的 Handoff / Spec / 验收字段。
```

---

### 2.4 第四步：让 Codex 给 Claude Code 当 Review

文章建议用不同厂商模型互审 spec：

```text
Claude Code 生成 spec；
Codex review spec，挑自相矛盾、模糊措辞、失败 case、隐含假设。
```

核心价值不是“哪个模型更聪明”，而是：

```text
不同模型训练分布不同，盲区互补。
```

对应到本项目：

```text
C 端可以生成理论/spec；
E 端或另一模型做 checker/review；
不能让 maker 自己确认自己完成。
```

这进一步支持已有规则：

```text
maker / checker 分离。
```

---

### 2.5 第五步：把 spec 拆成 prompt_plan 和 todo

文章强调，Vibe Coding 另一个翻车点是：

```text
让 AI 一口气实现整个大功能。
```

正确做法是：

```text
spec → prompt_plan → todo.md
每一步独立验收
错了立刻知道错在哪一步
```

对应到本项目：

```text
C-execution 不能直接变成一个巨大任务；
必须拆成 D 端可落库/可验证的小片段；
E 端按片段验收。
```

---

## 3. 文章列出的常见坑及本项目映射

### 坑 1：忘开 Plan mode，AI 直接动手

项目映射：

```text
没有 A 端 handoff，不允许 B/C/D/E 直接执行。
```

---

### 坑 2：嫌 AI 问题烦，开始随口答“都行/随便”

项目映射：

```text
Owner 如果犹豫超过 5 秒，真实答案通常是“我还没想好”。
A 端应记录 TBD，而不是替 Owner 静默决定。
```

---

### 坑 3：spec 出现“快速 / 流畅 / 友好”这类词

项目映射：

```text
所有模糊形容词必须变成验收标准。
例如：快速 → 1 秒内 / 5 秒内；及时 → 每日 9 点前；稳定 → 连续 N 次无失败。
```

---

### 坑 4：把“怎么做”塞进 spec

文章强调：

```text
spec 描述“做什么”，不是“怎么做”。
```

项目映射：

```text
A 端 Spec/Handoff 应描述目标、边界、验收；
实现方案进入 C 端理论/架构；
具体代码进入 D 端。
```

---

### 坑 5：一份 spec 装两个独立需求

项目映射：

```text
一个可独立上线/验证的目标 = 一个 spec / 一个 handoff / 一个任务切片。
不要把多个工作流改造混在同一个任务里。
```

---

### 坑 6：spec 写完就不更新

项目映射：

```text
spec 不是石碑。
E 端验证、F 端决策、外部来源吸收后，允许更新 spec；
但更新必须有来源、原因和变更记录。
```

---

## 4. 与当前 A-F 工作流的核心一致性

这篇文章与 Owner 今天反复表达的理念高度一致：

```text
不要让 AI 直接执行模糊想法。
先拷问，后 spec，再执行，再验证。
```

映射到本项目：

```text
L0：Owner 用自然语言说粗糙想法
A：需求拷问 / 概念拆解 / 多路线深化
B：外部资料与知识储备 Source Pack
C：理论/spec/方案生成
D：repo 落库 / 执行
E：验证 / review / 反证
F：Owner 决策 / 是否吸收为基线
```

文章中的 Plan mode，对应本项目的 A 端入口纪律：

```text
Plan mode = 工具层面的禁止动手
A 端 = 工作流层面的禁止过早执行
```

文章中的 Codex review，对应本项目的 E 端验证纪律：

```text
不同模型互审 = maker/checker 分离
```

文章中的 prompt_plan / todo，对应本项目的 workflow_loop_queue：

```text
大任务 → 小切片 → 独立验收 → 状态回填
```

---

## 5. 对 Trellis / Fractals 判断的补强

这篇文章进一步支持之前的判断：

```text
Trellis 更适合当前主线；
Fractals 更适合作为后续执行层参考。
```

原因：

```text
当前最重要的不是多 agent swarm 并行执行，
而是让模糊想法先变成可审、可拆、可验收的 spec/task/memory。
```

Trellis 更接近：

```text
spec / task / workspace memory / plan / verify / finish
```

Fractals 更接近：

```text
recursive task tree / worktree leaf execution / worker swarm
```

所以当前阶段仍应：

```text
先补 spec-first 工作流骨架，
再考虑多 agent 并行执行。
```

---

## 6. 对 Agent Reach 的吸收判断

Agent Reach 本身也应进入工作流认知：

```text
Agent Reach = B 端外部资料搜索/读取能力层，
不是 A-F 工作流主框架。
```

它适合放在：

```text
B 端 Source Pack / 外部知识储备
A↔B 双门循环中的 B 端抓取工具
```

不适合变成：

```text
整个工作流编排器
A 端需求治理替代品
D/E/F 执行验证替代品
```

正确位置：

```text
A 端提出搜索策略 / 来源缺口
B 端调用 Agent Reach 抓取 X、Reddit、YouTube、网页、GitHub 等来源
B 端输出 Source Pack
A/C 判断是否吸收进理论
D/E/F 再落库、验证、决策
```

---

## 7. 本项目应更新的运行规则

后续遇到 X / Twitter Article / 社媒来源时，检索顺序应为：

```text
1. 如果来源是 X/Twitter：优先 Agent Reach / OpenCLI / twitter article 或 search
2. 如果是 YouTube：优先 Agent Reach / yt-dlp
3. 如果是 GitHub：优先 gh CLI / Agent Reach GitHub channel
4. 如果是网页：Jina Reader / web_extract
5. 如果是普通全网搜索：web_search / Exa（若 Agent Reach Exa 配好）
6. 如果专用渠道不可用，再明确标注边界，不补写不可见内容
```

本次验证到的当前环境状态：

```text
Agent Reach：已安装，v1.5.0
Twitter/X：可用，active_backend=OpenCLI
Reddit：可用，active_backend=OpenCLI
B站：可用，active_backend=OpenCLI
小红书：可用，active_backend=OpenCLI
Web：可用，active_backend=Jina Reader
GitHub：可用，active_backend=gh CLI
Exa：未配置
LinkedIn：未配置
```

---

## 8. 更新后的认知基线

一句话：

```text
Vibe Coding 不是先 vibe 再补救；
而是先把 vibe 拷打成 spec，再让 AI 执行。
```

对应本项目的专业表达：

```text
A 端的最高价值，是把 Owner 的自然语言愿望，
通过对抗性追问转化为可执行、可审查、可拆分、可验证的 Spec/Handoff。
```

对应执行原则：

```text
模糊想法不下放；
没有 spec 不执行；
没有 handoff 不进下游；
没有验证不算完成；
外部来源优先用专用抓取能力，不用普通搜索替代。
```
