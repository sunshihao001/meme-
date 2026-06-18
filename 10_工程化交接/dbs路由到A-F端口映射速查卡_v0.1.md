# dbs 路由 → A/B/C/D/E/F 映射速查卡 v0.1

> 分线：10_工程化交接 / dbskill 接入
> 状态：v0.1 / 两仓理解后的速查卡
> 输入依据：已阅读项目级 dbskill 安装目录 `.agents/skills/` 的主入口与代表技能；已阅读当前工作流仓库的 A/B/C/D/E 主 skill、A端入口规则、dbs 路由规则、workflow state/queue。
> 目标：让新输入可以先经 dbs 能力识别，再快速路由到 A/B/C/D/E/F，避免技能堆叠和 A 端过载。

---

## 1. 两仓理解摘要

### 1.1 dbskill 仓库/安装目录理解

当前项目已安装 21 个 dbskill 项目级技能，核心入口是：

```text
dbs = 主路由器，只负责识别用户意图并路由到具体技能。
```

已重点阅读：

```text
.agents/skills/dbs/SKILL.md
.agents/skills/dbs-good-question/SKILL.md
.agents/skills/dbs-deconstruct/SKILL.md
.agents/skills/dbs-decision/SKILL.md
.agents/skills/dbs-learning/SKILL.md
.agents/skills/dbs-content-system/SKILL.md
.agents/skills/dbs-save/SKILL.md
```

关键认识：

```text
1. dbs 本身不做诊断、不做分析、不直接给建议，只做路由。
2. dbs-good-question 适合把模糊问题改成 Agent 可推理、可验证的问题说明书。
3. dbs-deconstruct 适合拆概念，解决“词很多但边界不清”的问题。
4. dbs-goal 适合把愿望语法变成可检查目标。
5. dbs-decision 适合长期决策、状态画像、结果回填和本地知识工程。
6. dbs-learning 适合把课题拆成连续学习/研究梯度。
7. dbs-content-system 是重型内容资产工程，不适合轻量输入直接启用。
8. dbs-save / restore / report 是状态管理三件套，不替代 E端验证或 F端决策。
```

### 1.2 当前工作流仓库理解

当前项目工作流的端口主 skill 是：

```text
A：skills/meme-demand-control-port/SKILL.md
B：skills/meme-source-pack-port/SKILL.md
C：skills/meme-theory-codex-port/SKILL.md
D：skills/meme-repo-landing-port/SKILL.md
E：skills/meme-verification-review-port/SKILL.md
F：Owner 决策门，目前通过 Owner Decision Brief / 决策记录文件体现
```

已重点阅读：

```text
AGENTS.md
skills/meme-demand-control-port/SKILL.md
skills/meme-source-pack-port/SKILL.md
skills/meme-theory-codex-port/SKILL.md
skills/meme-repo-landing-port/SKILL.md
skills/meme-verification-review-port/SKILL.md
10_工程化交接/A端默认入口与跳过条件规则_v0.1.md
10_工程化交接/dbs路由默认入口与A/B/C接入规则_v0.1.md
10_工程化交接/A_B_C前置研究循环规则_v0.1.md
10_工程化交接/workflow_loop_state_v0.1.yaml
10_工程化交接/workflow_loop_queue_v0.1.yaml
```

关键认识：

```text
1. 工作流当前已进入 fast_path 优先模式。
2. 新输入默认先过 dbs 路由，再进入 A 端最小澄清。
3. A 端是需求澄清/控制/路由端，不直接 maker 执行。
4. B 端只读资料压缩，输出 Source Pack，不写理论、不改 repo。
5. C 端基于 B 端 Source Pack 生成理论/方案，不改 meme repo。
6. D 端在授权后落库、更新索引/变更记录、提交推送。
7. E 端基于真实文件/diff/验证命令/CI 做 checker。
8. F 端由 Owner 做方向、权限、阶段门决策。
```

---

## 2. 总路由原则

```text
先 dbs 路由，再 A 端最小澄清。
先判断问题类型，再选择能力包。
先做最小可消费产物，再进入深度模式。
不能让技能名替代端口职责。
不能让 dbskill 状态三件套替代 workflow state / E端验证 / F端决策。
```

默认路径：

```text
用户新输入
→ dbs 主路由
→ A 端最小澄清
→ A/B/C/D/E/F 端口判断
→ 执行对应最小动作
```

---

## 3. 一页映射表

### 3.1 A 端：需求澄清 / 概念解析 / 路由控制

适用输入：

```text
新想法、模糊表达、多个概念混在一起、外部技能接入、工作流哪里慢/哪里乱、是否需要调整方向。
```

推荐 dbs 能力包：

```text
dbs-good-question：把模糊问题改成可推理问题说明书。
dbs-deconstruct：拆概念，解决词义和边界混乱。
dbs-goal：把愿望变成交付物和检查标准。
dbs-decision：需要记录阶段决策或 Owner gate 时启用。
dbs-slowisfast：用户急于全量推进、可能过早收敛时启用。
```

A 端最小输出：

```text
问题类型：____
核心想法：____
当前缺口：____
推荐端口：____
是否 deep_path：____
```

禁止：

```text
不直接进入 B 搜索。
不直接写 C 长理论。
不把所有 dbs 技能一次性展开。
```

---

### 3.2 B 端：Source Pack / 证据收敛 / 外部资料压缩

适用输入：

```text
A 端已经明确搜索依据；需要读文件、外部资料、样本、旧知识；需要整理 evidence/gap/unknown。
```

推荐 dbs 能力包：

```text
dbs-learning：把研究课题拆成连续学习/研究梯度。
dbs-content-system：只有当资料量大、边界清、要做内容资产工程时启用。
dbs-deconstruct：资料里概念混乱时辅助拆解。
dbs-report：多份资料/状态需要合并报告时启用。
dbs-restore：需要接续已有 dbs 存档时启用。
```

B 端最小输出：

```text
Search / Compression Brief
Source Inventory
Evidence Summary
Gaps / Conflicts / Unknowns
Downstream Handoff to C/A
```

禁止：

```text
不下最终理论结论。
不修改 repo。
不把 unknown 填成结论。
不直接调用 Codex。
```

---

### 3.3 C 端：理论生成 / 方案包 / Codex 调用

适用输入：

```text
A 端问题已定清；B 端 Source Pack 已足够；需要把 A+B 转成理论、方案、执行包。
```

推荐 dbs 能力包：

```text
dbs-deconstruct：辅助理论概念拆解。
dbs-learning：将复杂理论拆成阶段化学习/研究结构。
dbs-content-system：只有当理论材料本身是内容资产工程时启用。
dbs-decision：理论方案涉及阶段门或取舍时启用。
```

C 端最小输出：

```text
Short Theory Package
Input Alignment with A/B
Assumptions / Gaps
Downstream Landing Plan
Verification Handoff
```

deep_path 触发：

```text
Owner 明确要求深入。
A/B 输入已足够且影响 baseline。
需要生成 C-execution 包交 D/E/F。
```

禁止：

```text
不绕过 A/B 硬写长理论。
不改 repo。
不把浅草稿冒充深度理论包。
```

---

### 3.4 D 端：Repo Landing / 文件落库 / GitHub 同步

适用输入：

```text
C 端方案已被接受；E 或 Owner 允许落库；已有明确文件路径和更新范围。
```

推荐 dbs 能力包：

```text
dbs-save：需要保存本轮落库前后状态时可用。
dbs-restore：需要恢复之前上下文时可用。
dbs-report：需要把多次落库形成报告时可用。
dbs-decision：涉及 Owner 阶段门时回 F。
```

D 端最小输出：

```text
Changed Files
Validation Commands
Index / Change Log Updates
Git Commit / Push Result
Handoff to E
```

禁止：

```text
不重新发明理论方向。
不绕过 E/F 授权。
不触碰私钥/API/交易执行。
不静默删除/移动旧资料。
```

---

### 3.5 E 端：Verification / Review / PR-CI Checker

适用输入：

```text
C 理论包完成；D 落库完成；需要审查 diff、验证命令、CI、禁止事项。
```

推荐 dbs 能力包：

```text
dbs-ai-check：只在需要检查文本 AI 味时启用，不是默认验证工具。
dbs-report：需要把验证结果打包报告时启用。
dbs-decision：验证结论需要 Owner 做阶段选择时启用。
```

E 端最小输出：

```text
Evidence Checked
Validation Result
Risk / Forbidden Action Check
PASS / PARTIAL / FAIL
Owner Decision Brief candidate
```

禁止：

```text
不替 D 落库。
不凭 maker 自述宣布完成。
不跳过真实文件/diff/命令输出。
```

---

### 3.6 F 端：Owner Decision / 阶段门 / 授权

适用输入：

```text
需要用户决定方向、是否吸收、是否落库、是否扩大、是否停止、是否授权高风险动作。
```

推荐 dbs 能力包：

```text
dbs-decision：长期决策系统、阶段记录、结果回填。
dbs-save：保存本轮关键状态。
dbs-report：多轮决策需要报告。
dbs-slowisfast：用户可能急于跳过关键判断时启用。
```

F 端最小输出：

```text
Decision Needed
Recommended Default
Evidence
Options
Risk
Exact Reply Options
```

禁止：

```text
AI 不替 Owner 做最终授权。
dbs-decision 不替代 Owner 决策。
状态存档不替代 E 端验证。
```

---

## 4. 快速路由口诀

```text
说不清 → A + dbs-good-question / deconstruct / goal
资料乱 → B + dbs-learning / content-system / report
要理论 → C + deconstruct / learning / decision
要落库 → D + save/report（但先有授权）
要验收 → E + report/decision（但看真实文件和命令）
要拍板 → F + decision/save/report
想继续 → restore
想保留 → save
想汇总 → report
想慢下来 → slowisfast
```

---

## 5. 默认不启用的 dbskill

以下技能不是工作流默认组件，只有明确场景才启用：

```text
dbs-content：内容创作诊断
dbs-hook：短视频开头
dbs-xhs-title：小红书标题
dbs-ai-check：AI 写作特征检测
dbs-chatroom：多角色讨论
dbs-chatroom-austrian：奥派聊天室
dbs-benchmark：对标分析
dbs-diagnosis：商业模式诊断
dbs-agent-migration：Agent 工作台迁移
```

原因：

```text
它们很有用，但不是当前 meme 工作流默认路径；默认启用会让 A 端路由变慢、变散。
```

---

## 6. 下一步建议

```text
1. 将本速查卡加入知识库索引和变更记录。
2. 后续如需更强执行力，可把本速查卡拆成 A/B/C/D/E/F 各端口的“dbs调用片段”。
3. 不建议再把 21 个 dbskill 全部写进 A 端主 skill；A 端只保留路由原则和最小常驻包。
```