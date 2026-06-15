# GMGN 第一轮候选池（FCZ_B / FCZ_C / FCZ_D）

> 位置：`specs/mql5-fcz-reclaim-model/gmgn_first_round_candidate_pool.md`  
> 类型：候选池 / 采样中间态 / 只读 GMGN 发现层  
> 状态：v0.1

---

## 1. 数据来源

本候选池来自当前轮 GMGN 只读采样：

```text
gmgn-cli market trending --chain sol --interval 1h --limit 5 --raw
```

已获得 5 个候选 token 的实时 trending 结果。

---

## 2. 候选池摘要

### 2.1 FCZ_C_0001 候选：TIRED

```text
sample target: FCZ_C_0001
symbol: TIRED
chain: sol
address: Epyzu4d2TPpsQYnbQK1oZbPY8fVR1EsDnnYAYztKpump
launchpad: Pump.fun
exchange: pump_amm
price: 0.0000257127
1h price change: +1008.53%
liquidity: 11519 USD
market cap: 25712.7 USD
holder_count: 325
top_10_holder_rate: 0.2675
smart_degen_count: 6
renowned_count: 3
bundler_rate: 0.271
is_wash_trading: false
creator_token_status: creator_close
launch status: graduated/open market
candidate reason: 具备高动量 + 复合结构观察价值，适合作为“模型不完全符合但大涨”的候选池参考。
status: provisional_candidate
```

### 2.2 FCZ_D_0001 候选：WORLDCUP

```text
sample target: FCZ_D_0001
symbol: WORLDCUP
chain: sol
address: 9o7XtuVTAGrj3PRVYmdZyPVZEWEBnjX7hystGCvy92Vq
launchpad: pool_meteora
exchange: meteora_damm_v2
price: 0.0000310156
1h price change: +264.777%
liquidity: 32516.4 USD
market cap: 31015.6 USD
holder_count: 1282
top_10_holder_rate: 0.3619
smart_degen_count: 0
renowned_count: 0
bundler_rate: 0.4728
is_wash_trading: false
creator_token_status: creator_close
launch status: open market
candidate reason: holder 集中度偏高、bundler rate 偏高、smart money 缺失，适合作为死亡盘/派发风险候选池参考。
status: provisional_candidate
```

### 2.3 FCZ_B_0001 当前状态

```text
sample target: FCZ_B_0001
status: still_pending
reason: 需要“模型符合但失败”的真实样本，当前 trending 快照里尚未确定可直接对应的失败样本。
```

---

## 3. 候选池外溢样本

以下 token 可作为补充观察，不直接映射到当前三大首轮目标：

### 3.1 Claudberghini

```text
symbol: Claudberghini
address: EDjvJPVK4Ue4Rkh83dJrc7whzBqQBcu5EfhicmuCpump
price change 1h: +331.139%
liquidity: 7093.41 USD
smart_degen_count: 4
bundler_rate: 0.2049
creator_token_status: creator_close
```

### 3.2 AOG

```text
symbol: AOG
address: 7piED467yURBzJd2zSrhqJWGbNRWnAeYWFTRfC1pump
price change 1h: +10216.2%
liquidity: 33214.1 USD
smart_degen_count: 1
top_10_holder_rate: 0.1998
sniper_count: 20
bundler_rate: 0.1724
```

### 3.3 NVIDIA

```text
symbol: NVIDIA
address: G8rpCWojd9RvTHyiUNGUH4xZ9tugejD7CgxdujBbPVD3
price change 1h: +286.923%
liquidity: 33460.2 USD
smart_degen_count: 0
bundler_rate: 0.4928
```

---

## 4. 下一步如何用这个候选池

1. FCZ_C_0001 和 FCZ_D_0001 可以直接接样本记录骨架，继续补 provenance 和结构字段。
2. FCZ_B_0001 继续在后续 GMGN 抓取里找“模型符合但失败”的样本。
3. 候选池不等于最终样本，只是采样入口。
4. 一旦拿到真实图表或更完整的历史 OHLCV，就把候选池中的 token 写入对应样本记录。
