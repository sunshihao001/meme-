# 资料吸收：VWAP 成本锚与确认机制 v0.1

> 分线：F资料吸收 / C语义概念 / H指标规则  
> 来源标题：Price Action Analysis Toolkit Development (Part 10): External Flow (II) VWAP  
> URL：https://www.mql5.com/zh/articles/16984  
> 本地原文路径：`05_关键词检索/POC与AVWAP重新接受_检索资料_v0.1/ZH_VWAP成交量加权平均价_外部资金流.md`  
> 关联主题：VWAP、AVWAP、成本锚、确认机制、假信号过滤  

---

## 1. 资料核心内容

VWAP 是成交量加权平均价格：

```text
VWAP = ∑(价格 × 成交量) / ∑成交量
```

资料强调 VWAP 可以作为：

```text
平均成交价格；
动态参考线；
市场方向辅助；
信号生成与确认工具。
```

同时资料中提到确认机制：

```text
只有当信号在多个时间间隔内持续出现时，才更新信号，以减少假阳性。
```

---

## 2. 和本策略相关的概念

### 2.1 VWAP 是成本锚

对本策略：

```text
VWAP / AVWAP 代表一段结构的平均资金成本。
```

但它不是：

```text
单独买点。
```

---

### 2.2 多周期确认思想

资料中信号需要多个确认周期。

对本策略转化为：

```text
单根站上 AVWAP 只是弱接受；
连续站上且回撤不破，才接近中等/强接受。
```

---

### 2.3 价格与 VWAP 的关系

资料指出价格在 VWAP 上方通常偏强，在下方通常偏弱。

对本策略：

```text
深洗后重新站回 AVWAP，代表价格重新回到某类成本线之上；
但是否稳妥，需要后续停留、回撤和二次确认。
```

---

## 3. 可以吸收进知识库的内容

```text
VWAP/AVWAP 是成本线，不是买点。
VWAP信号必须有确认机制。
单次穿越容易产生假阳性。
应把“站上后持续”和“回撤不破”纳入重新接受定义。
```

---

## 4. 对已有定义的影响

```text
[x] 修改部分定义
[x] 新增关键词
[x] 新增指标字段
```

新增字段候选：

```text
avwap_above_bars
avwap_reclaim_confirmations
avwap_failed_reclaim_count
avwap_pullback_hold
```

---

## 5. 新增关键词

```text
VWAP
Volume Weighted Average Price
VWAP Signal Confirmation
VWAP Cross
VWAP Support
VWAP Resistance
VWAP False Signal
```

---

## 6. 待验证问题

```text
1. meme市场中站上 AVWAP 至少需要多少根K线确认？
2. AVWAP 是否比普通VWAP更适合第一控盘区模型？
3. 成交量异常尖峰是否会扭曲VWAP？
4. 是否需要多锚点AVWAP共振？
```
