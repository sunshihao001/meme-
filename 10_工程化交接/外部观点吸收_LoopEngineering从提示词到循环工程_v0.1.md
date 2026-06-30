# 外部观点吸收：Loop Engineering，从写提示词到写循环 v0.1

> 分线：10_工程化交接 / 外部观点吸收
> 来源：X / Twitter 状态 `https://x.com/Formulasearch/status/2067479963268518337`
> 作者：Formulasearch
> 抓取方式：Agent Reach v1.5.0 → OpenCLI Twitter Article
> 原始证据：`10_工程化交接/raw_refs/x_2067479963268518337_agent_reach_opencli.yaml`
> 状态：v0.1 / 外部观点吸收

---

## 1. 原文核心思想

这篇文章的核心判断是：

```text
AI 工作方式正在从“写提示词”转向“写循环”。
```

提示词解决的是：

```text
人在场时，如何让 AI 做下一步。
```

循环工程解决的是：

```text
人不一直在场时，如何让 AI 在边界、反馈、记忆和验证约束下持续推进。
```

文章引用 Boris Cherny 的观点：

```text
我不再 prompt Claude 了。
我让一堆循环跑着，由它们去提示 Claude、去琢磨该干什么。
我的工作变成了写循环。
```

这和 Owner 当前方法轮的方向高度一致：

```text
不要只做聊天式问答；
要把 AI 工作放进可持续的 repo-backed loop；
让任务、状态、验证、记忆沉淀在文件和流程里。
```

---

## 2. 文章的关键概念拆解

### 2.1 人肉发动机问题

传统 AI 使用方式是：

```text
人输入 prompt
AI 生成
人检查
人再输入
AI 再生成
```

这个模式的结构性天花板是：

```text
你不在，流程就停。
```

文章称用户成了“人肉发动机”。

本项目映射：

```text
如果 A/B/C/D/E/F 只靠 Owner 每句话手动推动，
工作流就不是系统，只是聊天辅助。
```

但要注意：

```text
不能因为要摆脱人肉发动机，就取消 Owner 判断。
```

正确方向是：

```text
Owner 不做每一步推动器；
Owner 保留目标、边界、验收、停止条件和最终决策权。
```

---

### 2.2 拉尔夫循环 / Loop Engineering

文章提到 Geoffrey Huntley 的“拉尔夫循环”：

```text
极简 bash 循环
每轮清空上下文
把测试报错作为硬反馈
让 AI 持续修复
```

本质不是多智能体炫技，而是：

```text
循环 + 硬反馈 + 持久状态。
```

对本项目的启发：

```text
A/B/C/D/E/F 不应只是文档说明；
应逐步变成可运行、可恢复、可验证的 loop。
```

但本项目不能直接照搬“无人循环改代码”，因为 Owner 不是专业工程团队，且当前项目强调研究/观察，不是自动交易或无监督执行。

---

## 3. 成熟循环的 5 个零件 + 1 个记忆

文章按 Addy Osmani 的拆解，给出成熟循环系统的组成。

### 3.1 自动化触发器

```text
循环的心跳。
可以是定时任务、新 PR、队列任务、外部事件。
```

本项目映射：

```text
workflow_loop_queue_v0.1.yaml
cron / 手动触发 / Telegram bot 输入
```

当前阶段判断：

```text
不要急于全自动触发。
先保留 manual_triggered_minimal_loop，确保 A 端和 F 端 gate 稳定。
```

---

### 3.2 工作区隔离 / Worktrees

```text
多个 Agent 并行时，每个 Agent 独立工作目录，避免互相打架。
```

本项目映射：

```text
未来 D 端执行 / Fractals 类 worker swarm 可以参考 worktree leaf execution。
```

当前阶段判断：

```text
这是第二阶段能力。
先稳定 A/B/C/D/E/F handoff，再考虑多 worktree 并行。
```

---

### 3.3 Skills 技能文件

文章说：

```text
AI 每次启动都是失忆的。
把项目规范写进 SKILL.md，AI 读了就能干活。
```

本项目映射：

```text
skills/meme-demand-control-port/SKILL.md
skills/meme-source-pack-port/SKILL.md
skills/meme-theory-codex-port/SKILL.md
skills/meme-repo-landing-port/SKILL.md
skills/meme-verification-review-port/SKILL.md
```

这进一步支持 Owner 今天的核心理念：

```text
不是每次在聊天里重新解释；
而是把稳定规则写进 repo 和 skill 真源。
```

---

### 3.4 连接器 / MCP

```text
循环要接入 Jira、数据库、Slack、PR 等真实工作流。
```

本项目映射：

```text
Agent Reach = B 端外部资料读取连接器能力；
GitHub/PR/CI = D/E 端工程连接器；
Telegram 多 bot = A-F 分工通信层。
```

当前阶段判断：

```text
连接器服务工作流，不替代工作流。
不要把 MCP/工具层误认为 A-F 主框架。
```

---

### 3.5 子智能体分工：制造者 + 审查者

文章强调：

```text
让写代码的模型给自己打分，它会一直夸自己。
必须另派独立 Agent 来挑刺。
自我评分是陷阱。
```

本项目映射：

```text
C/D = maker
E = checker / reviewer
F = Owner final decision
```

这和已有规则一致：

```text
没有 E 端真实验证，不算完成。
```

---

### 3.6 记忆

文章说：

```text
AI 在轮次间会遗忘。
进度必须存磁盘，一个 Markdown 文件就够。
```

本项目映射：

```text
workflow_loop_state_v0.1.yaml
Project_Continuation_Brief_v0.1.md
设计规范变更记录.md
raw_refs 原始证据
```

关键结论：

```text
记忆不是聊天历史；
记忆是 repo 中可检查、可恢复、可版本化的状态。
```

---

## 4. 文章提出的三笔债

### 4.1 验证债

AI 说 Done，不等于完成。

必须有：

```text
测试通过
lint 干净
验收条件满足
硬性停止条件
```

本项目映射：

```text
E 端不能空评。
E 端必须基于真实文件、diff、命令输出、验收标准验证。
```

---

### 4.2 理解债

循环产出速度超过人阅读速度，长期会导致：

```text
Owner 变成自己系统里的陌生人。
```

本项目映射：

```text
必须控制 D 端落库节奏；
必须保留 F 端 Owner 可理解的一页总控卡；
长理论要有摘要、边界、可判断点。
```

这也提醒：

```text
自动化不是越多越好。
如果 Owner 理解不了，系统智能度反而下降。
```

---

### 4.3 认知妥协

最危险的不是 AI 写错代码，而是：

```text
人因为 AI 太方便，放弃思考“该不该做”。
```

本项目映射：

```text
F 端不能被自动化替代。
A 端也不能只做机械路由。
Owner 判断力必须保留在目标、边界、价值、停止条件上。
```

关键原则：

```text
循环让生产变便宜；
但不让判断变便宜。
```

---

## 5. 对当前工作流的吸收判断

这篇文章应被吸收为：

```text
A-F 工作流从 prompt 驱动，升级为 loop 驱动的认知依据。
```

但吸收方式不是“马上全自动化”，而是：

```text
BRIDGE / PATTERN_ONLY
```

可吸收：

```text
1. 自动触发器概念
2. worktree 隔离概念
3. skill 作为长期规则记忆
4. connector/MCP 作为外部世界接口
5. maker/checker 分离
6. progress/spec/todo 作为循环记忆
7. 硬性验收条件和停止条件
```

不可直接照搬：

```text
1. 无人看管长时间自动执行
2. 无上限循环重试
3. 只要能跑就算完成
4. 让 AI 自己验收自己
5. 取消 Owner 的 F 端判断
```

---

## 6. 与 Trellis / Fractals / Agent Reach 的关系

### 6.1 Trellis

这篇文章进一步支持：

```text
Trellis 更适合作为当前主线参考。
```

因为 Trellis 对应：

```text
spec / task / workspace memory / plan / verify / finish
```

这正是 loop engineering 所需的稳定底座。

---

### 6.2 Fractals

Fractals 对应：

```text
recursive task tree / worktree leaf execution / worker swarm
```

更适合作为未来 D 端执行层参考。

不适合当前直接主导 A-F 工作流，因为：

```text
当前最重要的是 Owner gate、spec、memory、verification，
不是先扩大并行执行规模。
```

---

### 6.3 Agent Reach

Agent Reach 对应：

```text
B 端外部资料读取连接器。
```

它提供循环的外部知识输入，但不替代：

```text
A 端判断
C 端理论生成
D 端落库
E 端验证
F 端决策
```

---

## 7. 对本项目的更新后判断

Owner 当前工作流不应停在：

```text
用户问一句 → AI 答一句
```

也不应跳到：

```text
全自动多 agent swarm 无人值守
```

更合适的中间形态是：

```text
manual_triggered_minimal_loop
```

即：

```text
Owner 自然语言输入
→ A 端拷问和路由
→ B/C/D/E/F 形成可恢复循环
→ 每轮进度写入 repo
→ E 端硬验证
→ F 端保留最终判断
```

本项目下一步应强化的不是“更多 prompt”，而是：

```text
1. spec/handoff 的硬格式
2. workflow_loop_state / queue 的实际使用
3. E 端验证命令和证据
4. F 端一页总控卡
5. B 端外部知识输入优先走 Agent Reach
```

---

## 8. 一句话认知基线

```text
提示词让 AI 动一下；循环让 AI 持续动。
但循环必须被 spec、记忆、验证、权限和 Owner 判断约束。
```

对应本项目：

```text
不要只训练“提示词能力”，要建设“可恢复、可验证、可停机、可审查”的 A-F 循环能力。
```
