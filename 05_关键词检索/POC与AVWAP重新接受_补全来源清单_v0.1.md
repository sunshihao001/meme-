# POC 与 AVWAP 重新接受：补全来源清单 v0.1

> 分线：E关键词检索 / F资料吸收 / C语义概念  
> 版本：v0.1  
> 状态：已完成本轮检索与下载  
> 目的：记录 POC / VWAP / AVWAP / Value Area / Reclaim 专题资料来源。  

---

## 1. 本轮检索主题

```text
POC重新接受、价值区域回收、VWAP/AVWAP成本锚、站回/拒绝/回撤不破、支撑压力转换。
```

---

## 2. 下载目录

```text
C:\Users\Administrator\Documents\MQL5_第一控盘区成本中枢回收模型_学习资料\05_关键词检索\POC与AVWAP重新接受_检索资料_v0.1
```

下载清单：

```text
POC与AVWAP重新接受检索下载清单.json
```

---

## 3. 来源清单

| 优先级 | 资料 | URL | 本地文档 | 用途 |
|---|---|---|---|---|
| P1 | ZH_VWAP成交量加权平均价_外部资金流 | https://www.mql5.com/zh/articles/16984 | `05_关键词检索/POC与AVWAP重新接受_检索资料_v0.1/ZH_VWAP成交量加权平均价_外部资金流.md` | VWAP定义、成本线、确认机制 |
| P1 | EN_VWAP_ExternalFlow | https://www.mql5.com/en/articles/16984 | `05_关键词检索/POC与AVWAP重新接受_检索资料_v0.1/EN_VWAP_ExternalFlow.md` | 英文VWAP核对 |
| P2 | EN_TickBufferVWAP_短窗口不平衡 | https://www.mql5.com/en/articles/19290 | `05_关键词检索/POC与AVWAP重新接受_检索资料_v0.1/EN_TickBufferVWAP_短窗口不平衡.md` | 短窗口VWAP/微结构参考 |
| P1 | EN_Code_VWAP_VolumeWeightedAveragePrice | https://www.mql5.com/en/code/14484 | `05_关键词检索/POC与AVWAP重新接受_检索资料_v0.1/EN_Code_VWAP_VolumeWeightedAveragePrice.md` | MT5 VWAP源码 |
| P1 | EN_Code_DailyVWAP | https://www.mql5.com/en/code/61090 | `05_关键词检索/POC与AVWAP重新接受_检索资料_v0.1/EN_Code_DailyVWAP.md` | Daily VWAP源码 |
| P2 | EN_Forum_AnchoredVWAP_best_respected | https://www.mql5.com/en/forum/455444 | `05_关键词检索/POC与AVWAP重新接受_检索资料_v0.1/EN_Forum_AnchoredVWAP_best_respected.md` | AVWAP锚点选择讨论 |
| P2 | EN_Code_InstitutionalAnchoredVWAP_MT4 | https://www.mql5.com/en/code/71075 | `05_关键词检索/POC与AVWAP重新接受_检索资料_v0.1/EN_Code_InstitutionalAnchoredVWAP_MT4.md` | Anchored VWAP实现参考，MT4 |
| P1 | EN_MarketProfile_POC_ValueArea | https://www.mql5.com/en/articles/16461 | `05_关键词检索/POC与AVWAP重新接受_检索资料_v0.1/EN_MarketProfile_POC_ValueArea.md` | POC/Value Area语义 |
| P1 | EN_AnalyticalVolumeProfileTrading_AVPT | https://www.mql5.com/en/articles/20327 | `05_关键词检索/POC与AVWAP重新接受_检索资料_v0.1/EN_AnalyticalVolumeProfileTrading_AVPT.md` | Volume Profile/POC/市场记忆 |

---

## 4. 附件源码

```text
vwap.mq5
vwap.py
Daily VWAP.mq5 / daily_vwap.mq5
Institutional_VWAP.mq4
marketprofile.mq5
AVPT.mq5
Slippage.mq5
```

---

## 5. 初步吸收结论

### 5.1 VWAP 是成本线，不是单独买点

VWAP代表成交量加权平均价格，适合作为成本参考。

对本策略：

```text
AVWAP/VWAP 只说明成本位置，不说明价格已经被重新接受。
```

---

### 5.2 VWAP 信号需要确认机制

VWAP资料中使用多个确认周期来减少假阳性。

对本策略：

```text
单根站上 AVWAP 不足以确认；至少需要停留、回撤不破、二次推进。
```

---

### 5.3 AVWAP 锚点选择是关键问题

论坛资料说明“哪个 anchored VWAP 最受尊重”本身就是问题。

对本策略：

```text
AVWAP锚点不能随意，应围绕第一控盘区起点、第一波启动点、重新回收点等结构锚。
```

---

### 5.4 POC 与 Value Area 要一起看

POC 是价值区域内部核心点，但重新接受不应只看一条 POC 线。

应同时看：

```text
是否进入 Value Area；
是否站回 POC；
是否在 POC 上方停留；
是否回撤不破 VAL/POC/AVWAP。
```

---

## 6. 后续吸收笔记

已建立：

```text
06_资料吸收/资料吸收_VWAP成本锚与确认机制_v0.1.md
06_资料吸收/资料吸收_POC价值区域回收_v0.1.md
06_资料吸收/资料吸收_AVWAP锚点选择_v0.1.md
```
