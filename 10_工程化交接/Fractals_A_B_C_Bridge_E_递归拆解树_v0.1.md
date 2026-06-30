# Fractals A/B/C/Bridge/E 递归拆解树 v0.1

> 分线：10_工程化交接 / Fractals 拆解结果  
> 状态：v0.1 / 第一版递归拆解结果  
> 输入：`10_工程化交接/Fractals拆解工作单_v0.1.md`、`A端_当前阶段理论边界与循环推理_v0.1.md`、`A端自动循环拷问与Fractals拆解理论底稿_v0.1.md`  
> 目标：把当前阶段的 observe-only 母库目标拆成 A/B/C/Bridge/E 递归树，并给出当前量化体系系统结构的完善优先级。  
> 边界：本文件是理论拆解与优先级结果，不是代码实现，不替代 validator / issue / PR。

---

## 1. 根任务

```text
把当前阶段的治理入口、validator、样本反证、只读数据和 FCZ 状态机收束成一个可验证、可协作、可继续工程化的 observe-only 系统母库。
```

### 根任务的当前约束

```text
- 当前阶段不是交易执行阶段。
- 当前阶段不是自动下单阶段。
- 当前阶段不是 private key / swap / wallet custody 阶段。
- 当前阶段必须优先建立可验证、可协作、可回炉的研究闭环。
```

---

## 2. A/B/C/Bridge/E 总树

```text
1. A 端：治理入口 / 需求控制 / 概念边界
2. B 端：样本反证 / Source Pack / 只读证据收敛
3. C 端：FCZ 状态机 / mapper / 风险分诊 / 理论结构化
4. Bridge：任务路由 / 规范映射 / handoff / 阶段门
5. E 端：validator / 质量门 / 索引 / 变更记录 / 假完成检测
```

---

## 3. A 端递归拆解

### A1. 治理入口层

```text
A1.1 README / AGENTS / SOURCE_OF_TRUTH / ROADMAP 对齐
A1.2 Project Continuation Brief 入口固化
A1.3 新 Agent 阅读顺序固化
A1.4 真源 / 索引 / 变更记录优先级确认
```

### A2. 当前阶段理论边界层

```text
A2.1 当前阶段目标句固化
A2.2 observe-only / research-only 边界固化
A2.3 非目标清单固化
A2.4 禁区清单固化（交易 / 私钥 / swap / wallet）
```

### A3. 概念解析与问题世界建模层

```text
A3.1 表层词 → 专业概念族
A3.2 problem world / solution world / shared phenomena
A3.3 当前缺口识别
A3.4 需要外部证据还是内部收束的判断
```

### A4. 自动循环拷问层

```text
A4.1 自动提问
A4.2 自动调用技能组合
A4.3 自动证据吸收
A4.4 自动重新评估是否继续 A / 转端
```

### A5. Fractals 拆解契约层

```text
A5.1 输出 real_objective / problem_world / output_contract / verifier_gate
A5.2 输出 allowed_ports / forbidden_ports / max_depth / stop_conditions
A5.3 输出 Fractals 可消费 bounded contract
```

### A 端优先级

```text
P0：A1 / A2
P1：A3
P2：A4
P3：A5
```

### A 端停机门

```text
- 目标、边界、方案、验证至少 3 项达到可执行级别。
- 连续 2 轮没有新增有效信息。
- 继续追问只会改细节，不会改路线。
- 已经能生成 Fractals 可消费契约。
```

---

## 4. B 端递归拆解

### B1. 样本反证入口

```text
B1.1 真实失败样本
B1.2 反证样本
B1.3 漏掉大涨样本
B1.4 死亡盘误判样本
B1.5 不可执行样本
```

### B2. 只读数据收敛层

```text
B2.1 GMGN raw response
B2.2 snapshot
B2.3 provenance / request_hash / schema_version
B2.4 data quality report
```

### B3. Source Pack 压缩层

```text
B3.1 来源名称 / 链接 / 类型
B3.2 核心观点
B3.3 可吸收点
B3.4 不可直接照搬点
B3.5 与当前目标的关系
```

### B4. 知识适配判断层

```text
B4.1 是否真的回答了 A 端缺口
B4.2 是否要回 A 重新定义
B4.3 是否进入 C 的理论结构化
```

### B 端优先级

```text
P0：B2 / B1
P1：B3
P2：B4
```

### B 端停机门

```text
- 有足够 provenance。
- 样本能被追溯。
- Source Pack 已能被 C 端消费。
```

---

## 5. C 端递归拆解

### C1. FCZ 状态机理论层

```text
C1.1 状态集合
C1.2 状态转移规则
C1.3 invalidation rule
C1.4 禁止状态
```

### C2. GMGN mapper 层

```text
C2.1 只读输入数据族
C2.2 输出对象
C2.3 观察证据 vs 事实 vs 信号 的区分
C2.4 missing / unknown / conflict 处理
```

### C3. 风险分诊层

```text
C3.1 candidate / watch / reject / needs_manual_review
C3.2 reason-code taxonomy
C3.3 confidence 与 evidence 的关系
```

### C4. MVP 结构层

```text
C4.1 observe-only MVP
C4.2 research-only 输出
C4.3 未来执行层的阶段门
```

### C 端优先级

```text
P0：C1 / C2
P1：C3
P2：C4
```

### C 端停机门

```text
- 状态机不再混淆 hypothesis 与 signal。
- mapper 只输出观察输入，不输出 executable states。
- 风险分诊可被样本反证。
```

---

## 6. Bridge 端递归拆解

### Bridge1. 路由映射层

```text
Bridge1.1 A → B / C / D / E / F 路由规则
Bridge1.2 allowed / forbidden ports 映射
Bridge1.3 任务级 handoff 约束
```

### Bridge2. 规范映射层

```text
Bridge2.1 目录归位
Bridge2.2 真源与索引一致性
Bridge2.3 变更记录一致性
```

### Bridge3. 阶段门层

```text
Bridge3.1 哪些层能做
Bridge3.2 哪些层不能跳
Bridge3.3 哪些层需要 Owner Gate
```

### Bridge4. 给 Codex / 后续 agent 的工作单转换层

```text
Bridge4.1 bounded work order
Bridge4.2 单 issue slice
Bridge4.3 只读边界 / 允许文件 / 禁止文件
```

### Bridge 优先级

```text
P0：Bridge1 / Bridge2
P1：Bridge3
P2：Bridge4
```

### Bridge 停机门

```text
- 能把 A/B/C 的结果变成可执行 handoff。
- 不重定义问题，只做映射。
```

---

## 7. E 端递归拆解

### E1. Validator 层

```text
E1.1 索引引用存在性
E1.2 样本记录 Markdown 完整性
E1.3 loop report schema
E1.4 变更记录格式
E1.5 specs / tasks / checklist 一致性
```

### E2. 假完成检测层

```text
E2.1 文档都在但语义漂移
E2.2 看起来完整但边界不一致
E2.3 数量对了但语义错了
E2.4 把候选集冒充结论
```

### E3. CI / 机检层

```text
E3.1 validate_all
E3.2 单测 / 校验脚本
E3.3 失败路径检查
```

### E4. 反馈回流层

```text
E4.1 回 A 修边界
E4.2 回 B 补证据
E4.3 回 C 改结构
E4.4 回 Bridge 改映射
```

### E 端优先级

```text
P0：E1 / E2
P1：E3
P2：E4
```

### E 端停机门

```text
- 验证能抓住漂移与缺字段。
- 反馈能明确回路到 A/B/C/Bridge。
```

---

## 8. 当前量化体系系统结构的完善优先级

这是本轮最重要的结论。

### P0：入口与真源层

```text
1. README / AGENTS / SOURCE_OF_TRUTH / ROADMAP / Continuation Brief 对齐
2. A 端理论底稿与索引 / 变更记录对齐
3. 新 Agent 阅读顺序稳定
```

### P1：validator 质量门

```text
1. 索引引用存在性 validator
2. 样本记录 Markdown 完整性 validator
3. loop report validator
4. 变更记录格式 validator
```

### P2：样本反证层

```text
1. 真实失败样本
2. 反证样本
3. 漏掉大涨样本
4. 死亡盘误判样本
```

### P3：只读数据层

```text
1. GMGN raw response
2. snapshot
3. provenance / request_hash / schema_version
4. data quality report
```

### P4：FCZ 状态机 / mapper 层

```text
1. 状态集合固定
2. 状态转移固定
3. mapper 输入输出固定
4. invalidation rule 固定
```

### P5：风险分诊 / reason-code 层

```text
1. candidate / watch / reject / needs_manual_review
2. reason-code taxonomy
3. confidence / evidence 关系
```

### P6：回测 / 消融层

```text
1. 基准策略
2. 样本外验证
3. 成本模型
4. 反证 / 消融
```

### P7：observe-only MVP

```text
1. 可读、可验、可追溯
2. 永不输出交易执行指令
```

### P8：后续执行层

```text
1. paper trading
2. quote-only dry run
3. manual approval
4. limited auto
5. production auto
```

---

## 9. 当前不该优先做的

```text
- 自动交易实现
- private key / wallet / swap
- 资金执行
- 仓位管理细化
- 实盘止盈止损
- 把成功样本直接当策略有效
```

---

## 10. 结论

当前阶段最合理的路径是：

```text
A 端自动循环拷问
→ 收束问题世界和边界
→ 生成 Fractals 拆解工作单
→ Fractals 输出 A/B/C/Bridge/E 树
→ 先补入口、validator、样本、只读数据、FCZ 状态机
```

### 一句话版

```text
先让 A 端把问题问成契约，再让 Fractals 把契约拆成树，最后按优先级先补治理入口与质量门，再补样本与状态机。
```