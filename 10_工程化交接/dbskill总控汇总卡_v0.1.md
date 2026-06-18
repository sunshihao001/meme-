# dbskill 总控汇总卡 v0.1

> 分线：10_工程化交接 / 外部技能接入  
> 来源：dbskill 外部仓库评估、接入映射表、第一/二/三批接入执行卡片  
> 目的：把 dbskill 的接入策略压缩成一页总控卡，方便后续真正安装、桥接、合并、验证时快速执行。

---

## 1. 总判断

```text
dbskill 整仓结论：BRIDGE + PARTIAL MERGE
```

含义：

```text
1. 不全量直接 ADOPT。
2. 不直接替代 A/B/C/D/E/F 六端主技能。
3. 作为 L3 外部桥接包登记。
4. 其中部分能力并入 A 端判断、F 端决策、L5/L6 状态链。
5. 内容生产、标题、聊天室、学习类先 Pattern Only。
```

---

## 2. 接入主线

```text
第一批：判断推理能力
第二批：持续判断 + 状态回填能力
第三批：工作台迁移 / 对标 / 慢变量 / 执行阻塞
Pattern Only：内容、平台表达、学习、聊天室
```

---

## 3. 三批接入总览

| 批次 | skill | 主端口 | 层级 | 动作 | 核心用途 |
|---|---|---|---|---|---|
| 第一批 | `dbs-good-question` | A | L2 | MERGE | 问题说明书 / Agent 可解性 |
| 第一批 | `dbs-deconstruct` | A | L2/L3 | MERGE | 概念拆解 / 术语消歧 / 假设核查 |
| 第一批 | `dbs-goal` | A | L2/L3 | MERGE | 愿望语法转可检查目标 |
| 第一批 | `dbs-diagnosis` | A/C/F | L3/L4 | BRIDGE | 商业问题消解 / 诊断依据 |
| 第二批 | `dbs-decision` | F | L2/L5/L6 | MERGE/BRIDGE | 决策事件 / 回填 / 阶段画像 |
| 第二批 | `dbs-save` | B/F | L5/L6 | BRIDGE | 状态快照 |
| 第二批 | `dbs-restore` | A/B/F | L5/L6 | BRIDGE | 跨对话恢复 |
| 第二批 | `dbs-report` | E/F | L5 | BRIDGE | 多快照合并报告 |
| 第三批 | `dbs-agent-migration` | A/D/E | L3/L5 | BRIDGE | 多 agent 工作台迁移 |
| 第三批 | `dbs-benchmark` | B/C/F | L4 | BRIDGE/PATTERN | 对标过滤 |
| 第三批 | `dbs-slowisfast` | A/F | L4/L2 | BRIDGE/PATTERN | 慢变量 / 摩擦点 |
| 第三批 | `dbs-action` | A/F | L4 | BRIDGE/PATTERN | 执行阻塞诊断 |

---

## 4. Pattern Only 暂缓区

```text
- dbs-content
- dbs-content-system
- dbs-hook
- dbs-xhs-title
- dbs-ai-check
- dbs-learning
- dbs-chatroom
- dbs-chatroom-austrian
```

暂缓原因：

```text
它们偏内容生产、平台表达、学习、多角色讨论，
不是当前 meme / 方法轮主线的第一优先。
```

---

## 5. A-F 端口落点

### A 端：需求澄清 / 概念解析 / 路由门

```text
主接：dbs-good-question / dbs-deconstruct / dbs-goal / dbs-diagnosis
辅助：dbs-restore / dbs-agent-migration / dbs-slowisfast / dbs-action
```

核心价值：

```text
补强判断推理能力。
```

---

### B 端：资料压缩 / Source Pack

```text
主接：dbs-save / dbs-restore
辅助：dbs-benchmark
```

核心价值：

```text
把状态、资料、对标证据变成可恢复材料。
```

---

### C 端：理论生成 / Codex 调用

```text
主接：dbs-diagnosis / dbs-benchmark
辅助：内容类 pattern only
```

核心价值：

```text
提供商业诊断视角和外部对标视角，但不替代理论生成主线。
```

---

### D 端：Repo Landing

```text
主接：dbs-agent-migration
```

核心价值：

```text
辅助多 agent 工作台规则、真源和 bridge 落库。
```

---

### E 端：Verification / PR-CI

```text
主接：dbs-report / dbs-agent-migration
辅助：dbs-ai-check pattern only
```

核心价值：

```text
辅助报告审查、工作台一致性审查和内容特征检查。
```

---

### F 端：Owner Decision

```text
主接：dbs-decision / dbs-report / dbs-save / dbs-restore
辅助：dbs-diagnosis / dbs-benchmark / dbs-slowisfast / dbs-action
```

核心价值：

```text
补强持续判断、决策回填、阶段画像和 owner 风险判断。
```

---

## 6. 真正执行时的顺序

```text
Step 1：先接 A 端判断四件套
- dbs-good-question
- dbs-deconstruct
- dbs-goal
- dbs-diagnosis

Step 2：再接 F 端状态四件套
- dbs-decision
- dbs-save
- dbs-restore
- dbs-report

Step 3：再接第三批增强件
- dbs-agent-migration
- dbs-benchmark
- dbs-slowisfast
- dbs-action

Step 4：最后才评估 Pattern Only 区
```

---

## 7. 不允许的接法

```text
1. 不允许把 dbskill 整仓直接当成 L1 主技能。
2. 不允许让 dbs-diagnosis 替代 F 端 owner 决策。
3. 不允许只装一个技能点但没有映射、alias、验证方式。
4. 不允许把 save/restore 的状态真源放到 repo 外导致不可追溯。
5. 不允许内容类 skill 抢占当前方法轮主线。
```

---

## 8. 验证口径

每接一个 dbskill 子技能，必须回答：

```text
1. 它补哪个内部缺口？
2. 它归属哪个端口？
3. 它属于 L1-L6 哪一层？
4. 它是 ADOPT / BRIDGE / MERGE / PATTERN_ONLY 哪一种？
5. 是否保留 alias？
6. 输出能否进入现有模板？
7. 是否有验证样例？
8. 是否会破坏 A-F 权限边界？
```

---

## 9. 当前最终建议

```text
先不要急着全量安装。
先按本总控卡做 bridge + partial merge，
优先把第一批和第二批变成内部可调用能力，
第三批按实际场景启用，
内容/学习/聊天室类继续保留为 pattern only。
```
