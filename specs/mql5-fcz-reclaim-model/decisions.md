# Decisions

> Feature / Project：mql5-fcz-reclaim-model  
> Stage：需求拷问斗 / Good Question Brief  
> Status：v0.1  
> Purpose：记录 specs/mql5-fcz-reclaim-model 下与需求澄清阶段相关的 Owner 决策和未决问题。

---

## 1. Confirmed Decisions

### D1：当前目标是 1 + 2，最终目标是 3

```text
短中期：研究型目标 + 工具型目标。
长期：交易系统目标。
```

含义：

```text
先把模型变成可定义、可反证、可标注、可回测的研究对象；同时沉淀为 MQL5 / 复盘观察器 / 状态标注器的需求来源。最终在验证通过后，再考虑升级为交易系统。
```

---

### D2：当前用户排序

```text
1. Owner / 研究者本人
2. AI Agent / Codex / Claude
3. 未来自动交易系统
4. 未来普通交易者 / 客户
```

含义：

```text
当前阶段优先服务 Owner 和 AI Agent，不直接面向普通交易者或自动交易系统。
```

---

### D3：当前 Non-goals 已确认

```text
1. 不做自动下单系统。
2. 不承诺收益率。
3. 不把观察指标写成买卖信号神器。
4. 不直接进入 Codex 实现策略逻辑。
5. 不直接做正式回测结论。
6. 不把外部理论直接升级为核心规则。
7. 不因为失败样本而事后修改定义。
8. 不把图形成立等同于交易可执行。
```

---

### D4：核心假设 H1-H7 已确认

详见：

```text
specs/mql5-fcz-reclaim-model/clarification.md
specs/mql5-fcz-reclaim-model/good_question_brief.md
```

---

### D5：失败模式 F1-F8 已确认

详见：

```text
specs/mql5-fcz-reclaim-model/clarification.md
specs/mql5-fcz-reclaim-model/good_question_brief.md
```

---

### D6：路线为先 A，再 B，最后 C

```text
A. 研究库优先
B. 半自动标注器 / 观察器优先
C. 回测原型优先
```

Hard gate：

```text
未完成 A，不进入 B。
未完成 B 的观察与标注验证，不进入 C。
```

---

### D7：clarification 阶段验收标准 AC1-AC10 已确认

详见：

```text
specs/mql5-fcz-reclaim-model/clarification.md
```

---

### D8：meme 市场数据源理论加入 GMGN

```text
Owner 已决定：在 meme 市场上使用的数据源理论需要加入 GMGN。
```

含义：

```text
GMGN 作为当前模型的 meme 市场优先研究数据源与观察器数据源，用于市场发现、K 线、Token 安全、池子、持仓、交易者、钱包画像、Smart Money / KOL 追踪等上游数据。
```

边界：

```text
GMGN 查询能力用于研究、样本标注、反证审计和观察器需求；GMGN 执行能力只作为未来交易系统候选，不进入当前自动化；安全、交易、回测或商业化结论必须经过多源校验、真实样本、反证实验、消融实验和 Owner 决策。
```

来源文件：

```text
06_资料吸收/资料吸收_GMGN作为meme市场数据源_v0.1.md
C:/Users/Administrator/gmgn_requirement_knowledge_base
C:/Users/Administrator/source_repos/gmgn-skills
```

---

### D9：GMGN 加入后仍定位为结构观察器，下一步优先 GMGN 样本标注 MVP

```text
Owner 已确认：GMGN 加入后，当前项目仍定位为 GMGN 驱动的 FCZ 结构观察器 / 样本标注框架 / 风险审查器，暂不升级为完整量化体系；下一步优先做 GMGN 样本标注 MVP，而不是回测 MVP 或自动交易。
```

含义：

```text
当前阶段的目标是验证 GMGN 数据是否足以支持第一控盘区结构的可标注、可反证、可重复观察。只有通过真实样本、反证、消融、多源校验、成本后正期望、样本外和执行可行性等升级门，才能讨论候选量化策略。
```

来源文件：

```text
specs/mql5-fcz-reclaim-model/structural_observer_vs_quant_system_gate.md
```

---

### D10：跨会话 GMGN 量化闭环只迁移只读与审计能力到 FCZ 样本标注 MVP

```text
Owner 已确认：@jiegoufenxibot 里的 GMGN 量化闭环理解，只把“只读数据采集、标准化 DTO、特征字段、审计追溯、风险拒绝”迁移到当前 FCZ 项目；暂不迁移 quote layer、decision execution、swap、strategy create、完整量化闭环。
```

含义：

```text
当前项目吸收 GMGN 跨会话知识时，目标是服务 GMGN-driven FCZ Sample Labeling MVP。允许迁移 Collector / Normalizer / Feature / Audit 思想；不迁移交易执行层、报价层、完整量化闭环或任何私钥/API 执行能力。
```

来源：

```text
@jiegoufenxibot / jiegou profile 中关于 GMGN 最小可行量化闭环 MVP 的研究；当前项目只吸收其非执行、只读、样本标注与审计相关部分。
```

---

### D11：最终目标是 GMGN 驱动的 meme 市场量化自动交易系统

```text
Owner 已确认：最终目标是做成 meme 市场量化数据交易系统，数据源是 GMGN Skill / GMGN OpenAPI，结构策略核心是当前第一控盘区成本中枢回收模型，终局能力包括自动筛选条件、自动交易、自动下单、自动止盈止损。
```

阶段边界：

```text
该终局目标不改变当前阶段 gate。当前仍必须先完成 GMGN 样本标注 MVP、数据质量、多源校验、反证、消融、回测、成本后净期望、paper trading、quote-only dry run、manual approval trading 等层级后，才能逐步进入自动交易。
```

来源文件：

```text
specs/mql5-fcz-reclaim-model/full_meme_quant_trading_system_gap_brief.md
```

---

## 2. Open Decisions

以下仍需 Owner 后续确认：

```text
OD1. 第一控盘区的最终默认量化定义。
OD2. 成本中枢默认优先级：POC / Value Area / AVWAP / 结构区间。
OD3. 深洗和死亡盘的硬边界。
OD4. 重新接受的最低确认标准。
OD5. 二次启动是否必须突破前高 / BOS / 放量。
OD6. 首批样本市场、周期、数量。
OD7. 成功 / 失败 / 不可执行的阈值。
OD8. 半自动观察器的第一版字段范围。
OD9. 回测原型的最小可行规则集。
OD10. 首批 GMGN 接入能力范围：market.kline / trending / token.security / holders / traders / track.smartmoney。
OD11. GMGN 数据进入样本 CSV schema 的字段优先级。
OD12. 是否为 GMGN adapter 单独创建 spec / issue；当前不授权交易执行能力。
```

---

## 3. Codex Boundary

进入 Codex handoff 前必须写明：

```text
Codex 只能执行已经被 clarification / spec / issue 明确限定的任务。
Codex 不得自行定义策略核心概念。
Codex 不得自行选择成本中枢表达方式。
Codex 不得自行排除失败样本。
Codex 不得自行新增过滤条件美化结果。
Codex 不得把观察指标写成自动交易建议。
```
