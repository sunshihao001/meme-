# Issue Draft: 编写 MQL5 观察指标 MVP 开发计划

> 状态：draft  
> 类型：spec / indicator-requirements  
> 建议标签：mql5, spec, observer, needs-owner-review  
> Agent 执行分类：Needs owner

---

## 1. Goal

编写 `08_指标需求/MQL5观察指标MVP开发计划_v0.1.md`，把现有语义、字段和状态机需求收敛成一个可执行的观察指标 MVP 计划。

---

## 2. Background

项目当前定位是：

```text
观察器
状态标注器
风险评分可视化工具
人工复盘辅助工具
多机器人审查输入工具
```

不是：

```text
自动下单 EA
买卖信号神器
收益率承诺系统
```

---

## 3. Scope

```text
1. 读取 08_指标需求/MQL5观察指标需求_v0.2.md。
2. 读取 08_指标需求/MQL5观察指标字段映射与模块优先级_v0.1.md。
3. 读取 09_规则与回测/状态机规则整合_v0.1.md。
4. 产出 MVP 模块拆分、输入输出、非目标、风险与验证计划。
5. 更新索引与变更记录。
```

---

## 4. Non-goals

```text
1. 不写自动下单逻辑。
2. 不承诺收益。
3. 不直接进入 MQL5 代码实现。
4. 不跳过 owner 对 MVP 边界的确认。
```

---

## 5. Acceptance Criteria

```text
- [ ] MVP 文件存在并归入 08_指标需求。
- [ ] 每个模块有输入、输出、边界、失败模式。
- [ ] 明确不做自动交易。
- [ ] 可转化为后续 Codex / Claude Code 小任务。
- [ ] 索引与变更记录更新。
- [ ] validate_all 通过。
```

---

## 6. Owner Decisions

```text
1. 是否确认 MVP 第一版只做观察器和复盘辅助。
2. 是否优先实现 POC/AVWAP 回收观察，还是状态机可视化。
3. 是否允许后续进入 MQL5 指标代码实现。
```
