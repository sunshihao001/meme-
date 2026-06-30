# dbskill 接入映射表 v0.1

> 分线：10_工程化交接 / 外部技能接入  
> 来源仓库：https://github.com/dontbesilent2025/dbskill  
> 上游 commit：a58f647ccdc74bbf6b3f5bf5f29b7a4b842d6534  
> 目的：把 dbskill 的 21 个 skill 映射到当前 A/B/C/D/E/F 端口、L1-L6 层级，以及 ADOPT / BRIDGE / MERGE / REJECT 接入动作。

---

## 1. 总原则

```text
1. dbskill 整仓作为 L3 外部桥接包。
2. 不直接替代 A-F 主端口。
3. 对 A/F 端最有价值，B/C 可部分消费，D/E 主要做落库和验证。
4. 先接入判断能力、目标澄清、概念拆解、决策系统和状态链。
5. 内容生产、标题、聊天室、学习类先 pattern only。
```

---

## 2. 接入映射总表

| dbskill skill | 对应端口 | L1-L6 层级 | 接入动作 | alias | 验证方式 | 备注 |
|---|---|---|---|---|---|---|
| `dbs` | A | L3/L2 | BRIDGE | 是 | 能否正确路由到子技能 | 主入口，适合做外部路由层 |
| `dbs-good-question` | A | L2 | MERGE | 是 | 能否生成 Demand Grilling Brief | 已有局部接入，应和 A 端统一 |
| `dbs-deconstruct` | A | L2/L3 | MERGE | 是 | 能否拆清概念、术语、假设 | 补强概念解析 |
| `dbs-goal` | A | L2/L3 | MERGE | 是 | 能否把愿望变成可检查目标 | 补强目标澄清 |
| `dbs-diagnosis` | A/C/F | L3/L4 | BRIDGE | 是 | 能否消解问题并输出诊断依据 | 商业诊断核心，不直接替代 owner 判断 |
| `dbs-decision` | F | L2/L5/L6 | MERGE/BRIDGE | 是 | 能否形成决策事件、回填和状态画像 | 对 F 端非常有价值 |
| `dbs-save` | B/F | L5/L6 | BRIDGE | 是 | 能否保存关键状态且可被恢复 | 状态链候选 |
| `dbs-restore` | A/B/F | L5/L6 | BRIDGE | 是 | 能否从历史状态接续判断 | 跨对话接续候选 |
| `dbs-report` | E/F | L5 | BRIDGE | 是 | 能否合并存档生成报告 | 可作为 Owner Brief / Review Report 辅助 |
| `dbs-agent-migration` | A/D/E | L3/L5 | BRIDGE | 是 | 能否统一 Claude/Codex/Grok/Hermes 工作台 | 对多端工作台有价值 |
| `dbs-benchmark` | B/C/F | L4 | BRIDGE/PATTERN | 暂保留 | 能否产出有效对标过滤 | 后续按业务需要接入 |
| `dbs-slowisfast` | A/F | L4/L2 | BRIDGE/PATTERN | 暂保留 | 能否识别走捷径和关键摩擦 | 可用于 owner 风险判断 |
| `dbs-action` | A/F | L4 | BRIDGE/PATTERN | 暂保留 | 能否识别执行阻塞 | 非当前第一优先 |
| `dbs-content` | C | L4 | PATTERN_ONLY | 否 | 是否能稳定提升内容诊断 | 内容类，暂不主接 |
| `dbs-content-system` | C/D | L4/L5 | PATTERN_ONLY | 否 | 是否能建立内容资产工程 | 偏内容工程，暂缓 |
| `dbs-hook` | C | L4 | PATTERN_ONLY | 否 | 是否适配当前内容主线 | 短视频局部能力 |
| `dbs-xhs-title` | C | L4 | PATTERN_ONLY | 否 | 是否适配小红书场景 | 强平台特化 |
| `dbs-ai-check` | E | L4/L5 | PATTERN_ONLY | 否 | 是否能稳定识别 AI 味 | 可作为内容审查参考 |
| `dbs-learning` | B/C | L4/L5 | PATTERN_ONLY | 否 | 是否能形成连续学习资产 | 不是当前主线第一优先 |
| `dbs-chatroom` | A/C/F | L3/L4 | PATTERN_ONLY | 否 | 是否能提供真正增量视角 | 多角色讨论，仅参考 |
| `dbs-chatroom-austrian` | C/F | L4 | PATTERN_ONLY | 否 | 是否适合经济学视角讨论 | 专项参考 |

---

## 3. 第一批优先接入

```text
1. dbs-good-question
2. dbs-deconstruct
3. dbs-goal
4. dbs-diagnosis
```

对应能力：

```text
A 端：问题澄清 / 概念拆解 / 目标澄清 / 商业问题消解
```

判断：

```text
这四个最适合补“判断推理能力”。
```

---

## 4. 第二批优先接入

```text
5. dbs-decision
6. dbs-save
7. dbs-restore
8. dbs-report
```

对应能力：

```text
F 端：owner decision / 状态回填 / 决策事件 / 报告归档
```

判断：

```text
这四个补“持续判断能力”和“跨对话状态能力”。
```

---

## 5. 第三批接入

```text
9. dbs-agent-migration
10. dbs-benchmark
11. dbs-slowisfast
12. dbs-action
```

对应能力：

```text
工作台迁移 / 对标 / 慢变量 / 执行阻塞
```

判断：

```text
有价值，但要看实际场景，不急着全量进入主栈。
```

---

## 6. 暂不主接的 pattern only

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

原因：

```text
它们偏内容生产、平台表达、学习、多角色讨论，
不是当前 meme / 方法轮主线第一优先。
```

---

## 7. 关键判断

你现在不是要“把 dbskill 全装进来”，而是要：

```text
把 dbskill 作为外部技能仓库进行吸收，
先拿判断能力和状态能力，
再看内容/学习/聊天室是否有实际需求。
```

---

## 8. 下一步建议

```text
下一步应做《dbskill 第一批接入执行卡片》：
- dbs-good-question
- dbs-deconstruct
- dbs-goal
- dbs-diagnosis
```

每个卡片包含：

```text
接入目标
归属端口
归属层级
与现有技能的关系
是否保留 alias
验证方式
```
