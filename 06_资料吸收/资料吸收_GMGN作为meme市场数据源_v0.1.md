# 资料吸收_GMGN作为meme市场数据源_v0.1

> 位置：`06_资料吸收/资料吸收_GMGN作为meme市场数据源_v0.1.md`  
> 分线：资料吸收 / 数据源理论 / meme 市场观察模型  
> 状态：v0.1，需求决策吸收稿  
> 历史来源会话：`20260613_040438_b92757`  
> 当前平台：Telegram DM  
> 当前主题：继续 gmgn-skills 相关话题 + 安装配置 GMGN Skill + 配置 API Key  
> 本地 GMGN 知识库：`C:/Users/Administrator/gmgn_requirement_knowledge_base`  
> 本地 GMGN 源码：`C:/Users/Administrator/source_repos/gmgn-skills`  
> 用途：将“meme 市场数据源优先使用 GMGN”的理论正式纳入第一控盘区成本中枢回收模型的需求控制面、样本标注和后续观察器设计。

---

## 1. 本文要解决的问题

当前“第一控盘区成本中枢回收模型”已经明确：

```text
短中期：研究库 + 样本标注 + 反证审计 + MQL5/复盘观察器需求源
长期：经过证据门验证后，才考虑可回测 / 可部署 / 可执行交易系统
```

但此前数据源层还没有明确写入：

```text
meme 市场上使用什么数据源作为优先来源？
哪些 GMGN 能力可以用于第一控盘区、成本中枢、深洗、重新接受、二次启动、死亡盘和风控标注？
GMGN 能提供什么，不能提供什么？
哪些数据必须多源校验？
GMGN 是否可以直接触发交易执行？
```

Owner 现已决定：

```text
在 meme 市场上使用的数据源理论需要加入 GMGN。
```

本文用于把这个决策写入项目知识库。

---

## 2. 当前定义

### 2.1 GMGN 在本项目中的角色

GMGN 在本项目中定位为：

```text
meme 市场优先数据源
+ 候选标的发现源
+ Token 尽调 / 安全 / 池子 / 持仓 / 交易者数据源
+ 钱包画像 / Smart Money / KOL 追踪源
+ 第一控盘区与庄家结构观察字段来源
+ 后续样本标注、反证实验、观察器需求和回测数据仓库的重要上游
```

GMGN 当前不是：

```text
唯一真源
自动交易授权源
收益证明源
策略有效性证明源
无需校验的安全判断源
```

### 2.2 数据源优先级定义

在 meme 市场研究阶段：

```text
GMGN 可作为第一优先研究数据源和观察器数据源。
```

但进入量化、回测、交易执行或商业化前，必须引入多源校验：

```text
GMGN + Dexscreener / Birdeye / GeckoTerminal / 链上 RPC / GoPlus / RugCheck 等补源
```

---

## 3. GMGN 能力与当前模型映射

### 3.1 市场发现与行情

来源能力：

```text
market kline
market trending
market trenches
market signal
```

对应当前模型：

```text
候选 meme 标的发现
早期新币发现
K 线与成交量观察
第一波拉升识别
趋势 / 热度 / 信号密度观察
```

可转化字段：

```text
chain
token_address
symbol
kline_window
price_usd
volume_usd
liquidity_usd
market_cap_usd
holder_count
volume_growth
buy_sell_ratio
signal_density
launchpad_stage
```

### 3.2 Token 尽调与风控

来源能力：

```text
token info
token security
token pool
token holders
token traders
```

对应当前模型：

```text
能不能纳入样本池
是否存在 honeypot / mint / freeze / blacklist / tax / rug 风险
池子深度是否支持执行
Top holders 是否过度集中
早期买家 / sniper / insider / bundler 风险
交易者结构是否支持控盘区假设
```

可转化字段：

```text
security_veto_flags
honeypot
mint_disabled
freeze_disabled
blacklist_risk
renounced
lp_burn_ratio
top10_holder_rate
dev_holding_rate
insider_ratio
sniper_ratio
bundler_rate
rug_probability
liquidity_safety_score
```

### 3.3 钱包画像与聪明钱追踪

来源能力：

```text
portfolio holdings
portfolio activity
portfolio stats
portfolio created-tokens
track smartmoney
track kol
track follow-wallet
track follow-tokens
track follow-token-groups
```

对应当前模型：

```text
早期控盘资金识别
Smart Money 是否介入
KOL 是否形成流量或出货风险
Dev 历史项目质量
早期钱包是否仍持有
同步买入 / 同步卖出结构
死亡盘 / 分发风险识别
```

可转化字段：

```text
wallet_realized_pnl
wallet_win_rate
avg_hold_time
entry_delay_after_launch
rug_exposure_ratio
dev_success_ratio
early_buyer_concentration
first70_current_holding_ratio
top10_holder_change_rate
synchronized_buy_score
synchronized_sell_score
kol_exit_liquidity_risk
dev_split_wallet_pattern_score
```

### 3.4 交易执行能力的边界

GMGN 也包含：

```text
order quote
swap execute
multi-swap
strategy create
strategy list
strategy cancel
gas price
```

但在当前项目阶段，这些能力只允许作为：

```text
执行可行性研究字段
滑点 / 报价 / 池深 / gas / 可成交性评估来源
未来交易系统阶段的候选接口
```

当前不允许作为：

```text
自动下单系统
实盘执行授权
Codex 可自行调用的交易能力
```

---

## 4. GMGN 与第一控盘区模型的字段映射

### 4.1 第一控盘区

GMGN 可提供：

```text
market kline：早期价格 / 成交量 / 拉升结构
market trenches：早期新币阶段 / launchpad 状态
token holders：早期持仓集中度
token traders：早期交易者结构
portfolio / track：关键钱包是否集中买入
```

可映射为：

```text
fcz_start_time
fcz_end_time
fcz_high
fcz_low
fcz_volume_share
early_buyer_concentration
synchronized_buy_score
first70_current_holding_ratio
```

### 4.2 成本中枢

GMGN 可提供：

```text
market kline
volume / liquidity / price series
token traders buy/sell distribution
```

但注意：

```text
POC / Value Area / Volume Profile 可能需要在本地基于 GMGN kline/trade 数据二次计算。
GMGN 不应被直接假设已经提供完整成本中枢定义。
```

可映射为：

```text
cost_center_method = GMGN-derived-POC / GMGN-derived-ValueArea / GMGN-kline-structure
poc_level
vah_level
val_level
cost_center_confidence
data_source = GMGN
```

### 4.3 深洗 vs 死亡盘

GMGN 可提供：

```text
价格下跌幅度
流动性变化
holder_count 变化
Top holders 变化
Smart Money 是否离场
KOL 是否出货
Dev / insider 风险
security / pool 风险变化
```

可映射为：

```text
washout_depth_pct
washout_duration_bars
liquidity_decay_rate
holder_decay_rate
top10_holder_change_rate
synchronized_sell_score
kol_exit_liquidity_risk
death_market_score
```

### 4.4 重新接受与二次启动

GMGN 可提供：

```text
kline 回收结构
volume_growth
buy_sell_ratio
net_buy_volume_usd
smart_money_buy_count
holder_growth_rate
signal_density
```

可映射为：

```text
value_area_reentered
poc_reclaimed
avwap_reclaimed
acceptance_grade
second_push_confirmed
market_volume_growth
buy_sell_ratio
smart_money_buy_count_10m
holder_growth_rate
```

### 4.5 诱多与失败反抽

GMGN 可提供：

```text
突破后买卖比恶化
净买入转负
Smart Money 出货
KOL 出货
Top holder 减仓
流动性下降
signal 失效
```

可映射为：

```text
bull_trap_score
failed_reclaim_score
synchronized_sell_score
kol_exit_liquidity_risk
liquidity_trap_score
max_adverse_excursion_R
```

---

## 5. 数据仓库吸收原则

参考本地 GMGN 知识库：

```text
C:/Users/Administrator/gmgn_requirement_knowledge_base/09_指标与量化准备工作/02_GMGN数据仓库设计.md
```

本项目后续如果接入 GMGN，应沿用四层数据仓库思想：

```text
Raw Layer：保存 GMGN 原始响应，保证可追溯
Snapshot Layer：按时间保存 Token / Wallet / Market 状态
Feature Layer：计算第一控盘区、庄家结构、风险和接受度特征
Decision Layer：保存信号、评分、策略决策、订单与审计；当前阶段只保存研究/观察结论，不保存自动交易决策
```

本项目当前优先只需要：

```text
Raw Layer
Snapshot Layer
Feature Layer
```

Decision Layer 中的交易执行字段，必须等 Owner 决策和交易系统阶段后再启用。

---

## 6. 多源校验原则

参考本地 GMGN 知识库：

```text
C:/Users/Administrator/gmgn_requirement_knowledge_base/09_指标与量化准备工作/05_GMGN多源校验与补源清单.md
```

核心原则：

```text
GMGN 是 meme 市场优先研究数据源，但不是唯一真源。
```

必须多源校验的类别：

```text
Token 安全：GoPlus / RugCheck / 链上合约检查
市场行情：Dexscreener / Birdeye / GeckoTerminal / 链上 RPC
钱包资金流：Solscan / Etherscan / Helius / QuickNode / Alchemy
社交补源：X / Telegram / Website / GitHub
```

冲突处理原则：

```text
安全字段冲突：取更保守结果。
价格 / 流动性冲突：用时间最近且交易对匹配的数据。
钱包标签冲突：保留多标签和来源，不硬覆盖。
社交字段冲突：只作为辅助，不作为自动买入核心依据。
```

---

## 7. 对当前需求控制面的影响

GMGN 数据源理论加入后，Demand Grilling Brief 的目标应扩展为：

```text
短中期：研究库 + 样本标注 + 反证审计 + GMGN 数据源映射 + MQL5/复盘观察器需求源
长期：经真实样本、反证、消融、多源校验、可执行性评估后，才考虑可回测 / 可部署 / 可执行交易系统
```

Agent Execution Boundary 应新增：

```text
Agent 可以读取 GMGN 知识库和源码来整理字段映射。
Agent 可以设计 GMGN adapter / data warehouse / feature schema。
Agent 不得自行使用 GMGN_PRIVATE_KEY 或执行 swap / strategy create。
Agent 不得把 GMGN signal 直接解释为买卖建议。
```

---

## 8. 对样本标注模板的影响

建议后续补充样本字段：

```text
data_source_primary：GMGN
source_capabilities：market.kline / market.trending / token.security / token.holders / track.smartmoney 等
gmgn_raw_refs：GMGN 原始响应引用
data_confidence_price
data_confidence_liquidity
data_confidence_security
data_confidence_holder_structure
gmgn_conflict_flags
gmgn_multisource_required
```

进入真实样本阶段前，这些字段应进入样本标注模板或 CSV schema 的后续 issue。

---

## 9. 对观察器 / MQL5 需求的影响

MQL5 / 复盘观察器不应直接依赖 GMGN 实时执行权限，而应消费：

```text
GMGN-derived snapshots
GMGN-derived features
GMGN-derived risk scores
```

推荐架构：

```text
GMGN adapter / collector
→ Raw / Snapshot / Feature storage
→ FCZ sample labeling / observer
→ MQL5 or chart overlay / review dashboard
→ Owner / checker review
```

不推荐：

```text
MQL5 指标直接持有 GMGN 交易权限
Codex 直接调用 GMGN swap
观察器输出自动买卖信号
```

---

## 10. Owner 决策记录

本次 Owner 决策：

```text
在 meme 市场上使用的数据源理论需要加入 GMGN。
```

当前落实方式：

```text
将 GMGN 作为 meme 市场优先研究数据源与观察器数据源写入资料吸收层、Demand Grilling Brief、decisions、待决策问题和后续样本/观察器设计。
```

未决问题：

```text
1. GMGN 是否作为首批真实样本采集的 primary data source？
2. 首批接入哪些 GMGN 能力：market.kline / trending / token.security / holders / traders / track.smartmoney？
3. GMGN 数据进入样本 CSV schema 的字段优先级是什么？
4. 是否需要为 GMGN adapter 单独创建 spec / issue？
5. 是否已配置 GMGN_API_KEY；若涉及交易执行，是否明确禁止 GMGN_PRIVATE_KEY 在当前阶段使用？
```

---

## 11. 本版结论

GMGN 应正式纳入当前模型的数据源理论：

```text
GMGN 是 meme 市场优先研究数据源和观察器数据源，负责提供市场发现、K 线、Token 安全、池子、持仓、交易者、钱包画像、Smart Money/KOL 追踪等上游数据。
```

但当前阶段仍然坚持：

```text
GMGN 查询能力用于研究、样本标注、反证审计和观察器需求；
GMGN 执行能力只作为未来交易系统候选，不进入当前自动化；
任何安全、交易、回测或商业化结论都必须经过多源校验、真实样本、反证实验、消融实验和 Owner 决策。
```

---

## 12. 下一步

建议下一步：

```text
1. 更新 Demand Grilling Brief，加入 GMGN 数据源理论。
2. 更新 decisions.md，记录 Owner 对 GMGN 数据源理论的确认。
3. 更新待决策问题，加入 GMGN 数据源 P0/P1 决策。
4. 后续创建 GMGN adapter / sample schema 扩展的 spec 或 issue，但暂不进入交易执行。
```
