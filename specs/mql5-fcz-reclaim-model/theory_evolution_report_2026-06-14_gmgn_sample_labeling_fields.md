# Theory Evolution Report：GMGN 样本标注 MVP 最小字段扩展

> 位置：`specs/mql5-fcz-reclaim-model/theory_evolution_report_2026-06-14_gmgn_sample_labeling_fields.md`  
> 类型：Demand Theory Evolution Loop 运行报告  
> 状态：已执行 / 已回填  
> 本轮理论缺口：GMGN 样本标注 MVP 需要哪些最小字段，才能支持 FCZ 结构可标注、可反证、可重复观察。  
> 执行边界：只读数据、样本标注、理论回填；未调用交易执行能力。

---

## 1. 本轮实际加载的 skills

本轮不是只“按方法论模拟”，而是实际加载/验证以下 skills：

```text
dbs-good-question
dbs-goal
dbs-chatroom
dbs-slowisfast
dbs-decision
dbs-report
markdown-research-knowledge-bases
spec-first-ai-engineering
gmgn-market
gmgn-token
gmgn-portfolio
gmgn-track
```

GMGN 执行类 skills 未调用：

```text
gmgn-swap
gmgn-cooking
```

未进行：

```text
私钥配置
自动交易
自动下单
自动止盈止损
Codex 实现
GitHub issue / PR
```

---

## 2. dbs-good-question 输出的问题说明书

本轮将模糊问题改写为：

```text
在最终目标是 GMGN-powered meme 市场量化自动交易系统的前提下，当前第一阶段 GMGN 样本标注 MVP 需要哪些最小 GMGN 字段，才能把 FCZ 结构策略转成可标注、可反证、可重复观察的数据结构，并避免过早跳到自动下单、swap、止盈止损等执行层？
```

可验证交付物：

```text
1. 产出 GMGN 样本标注字段扩展文档。
2. 字段按来源能力、用途、必填性、边界分层。
3. 明确最小必填字段集。
4. 明确 candidate / watch / reject / needs_manual_review 的 v0.1 判定逻辑。
5. 明确 GMGN 只读数据与未来执行占位字段的边界。
6. 更新索引和变更记录。
7. 运行 validate_all.py。
```

---

## 3. dbs-goal 目标清晰化

本轮目标不是：

```text
构建完整量化交易系统
构建 GMGN 自动下单系统
实现止盈止损
写代码接 swap
```

本轮目标是：

```text
把 GMGN 只读数据能力转成 FCZ 样本标注字段层，使后续真实样本、反证、回测和自动交易升级有可追溯数据基础。
```

完成态：

```text
能够指向一个文件：07_样本标注/GMGN样本标注字段扩展_v0.1.md。
```

失败态：

```text
如果文件只列 GMGN 接口，不说明如何服务 FCZ 结构标注、反证、事前可见性、后续执行边界，则本轮失败。
```

---

## 4. Concept / Data Absorption Summary

本轮吸收来源：

```text
1. 07_样本标注/样本标注模板_v0.1.md
2. 07_样本标注/样本字段表_v0.1.md
3. gmgn_requirement_knowledge_base/09_指标与量化准备工作/01_GMGN指标字典.md
4. gmgn-market skill
5. gmgn-token skill
6. gmgn-portfolio skill
7. gmgn-track skill
```

吸收后形成 9 层字段结构：

```text
L0 Provenance / 审计追溯字段
L1 Market Discovery / 市场发现字段
L2 Token Identity / Token 基础身份字段
L3 Security & Veto / 安全与硬拒绝字段
L4 Liquidity & Pool / 流动性与池子字段
L5 Holder & Trader Structure / 持仓与交易者结构字段
L6 Wallet / Smart Money / KOL 字段
L7 FCZ Derived Structure / FCZ 派生结构字段
L8 Sample Outcome / 反证与结果字段
L9 Future Execution Placeholder / 后续执行占位字段
```

---

## 5. 本轮理论回填

新增文件：

```text
07_样本标注/GMGN样本标注字段扩展_v0.1.md
```

文档核心结论：

```text
GMGN 样本标注 MVP 的第一任务，不是寻找买点，而是建立“可追溯、可反证、可重复观察”的数据结构。
```

明确当前最小必填字段覆盖：

```text
候选发现
安全拒绝
流动性与池深
持仓结构
FCZ 候选
成本中枢置信度
深洗 / sweep / reclaim
事前可见性
二次启动候选
诱多 / 死亡盘风险
样本反证审计
```

---

## 6. dbs-chatroom 多角色审查摘要

### 6.1 量化研究员

最重要的不是更多信号，而是防后视偏差字段：

```text
gmgn_would_trigger_ex_ante
gmgn_boundary_moved_after_outcome
gmgn_anchor_changed_after_outcome
gmgn_failure_explained_by_new_rule
```

### 6.2 风控负责人

在没有 hard veto、流动性、holder 集中、rug、KOL 出货、smart money 分歧字段前，自动交易只会放大风险。

### 6.3 数据工程师

没有 provenance 字段，后续所有回测与样本复现都会失效。因此 L0 字段必须强制必填。

### 6.4 Owner 代理视角

当前可自动推进字段扩展；但真实样本范围、最小流动性门槛、是否外部补源仍需 Owner 决策。

---

## 7. dbs-slowisfast 判断

本轮必须慢做的是：

```text
样本字段与反证结构。
```

原因：

```text
这部分是后续自动交易系统的资产层。字段错了，后面回测、评分、下单、止损止盈都会建立在错误数据上。
```

本轮不值得慢做的是：

```text
继续扩展方法论文件。
```

结论：

```text
慢在字段定义和反证审计，快在文件落地和验证。
```

---

## 8. dbs-decision：已确认与待确认

### 8.1 本轮已自动落实

```text
GMGN 只读字段扩展已落到 07_样本标注/GMGN样本标注字段扩展_v0.1.md。
```

### 8.2 待 Owner 决策

```text
1. 第一批 GMGN 真实样本选取范围：只做 Solana meme，还是包含 Base / BSC / ETH？
2. 第一批样本数量：20 个、50 个还是 100 个？
3. 最小流动性门槛是多少？10k / 30k / 50k USD？
4. 是否允许使用 GMGN 外部补源来补 first70_current_holding_ratio？
5. candidate 是否只代表样本观察，还是 paper trading 阶段可升级为 paper signal？
6. 是否建立 specs/gmgn-fcz-sample-labeling-mvp/ 目录？
```

---

## 9. 本轮文件变更

新增：

```text
07_样本标注/GMGN样本标注字段扩展_v0.1.md
specs/mql5-fcz-reclaim-model/theory_evolution_report_2026-06-14_gmgn_sample_labeling_fields.md
```

待同步：

```text
00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md
00_知识库设计规范/05_索引与变更记录/设计规范变更记录.md
```

---

## 10. 下一轮建议

下一轮最高价值理论缺口：

```text
如何从 GMGN 字段扩展生成第一批 20 个真实样本采集执行清单，并定义真实样本 CSV schema？
```

建议产出：

```text
07_样本标注/GMGN真实样本采集执行清单_v0.1.md
07_样本标注/GMGN反证样本库字段表_v0.1.md
```

仍然禁止：

```text
gmgn-swap
gmgn-cooking
自动下单
自动止盈止损
```
