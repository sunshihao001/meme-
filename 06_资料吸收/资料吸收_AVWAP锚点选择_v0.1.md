# 资料吸收：AVWAP 锚点选择 v0.1

> 分线：F资料吸收 / C语义概念 / H指标规则  
> 来源标题：Anchored VWAP forum discussion、Institutional Anchored VWAP、VWAP CodeBase  
> URL：  
> - https://www.mql5.com/en/forum/455444  
> - https://www.mql5.com/en/code/71075  
> - https://www.mql5.com/en/code/14484  
> 本地原文路径：`05_关键词检索/POC与AVWAP重新接受_检索资料_v0.1/`  
> 关联主题：AVWAP、锚点选择、最受尊重的VWAP、庄家成本线  

---

## 1. 资料核心内容

AVWAP 的关键不是公式，而是：

```text
从哪里开始锚定。
```

论坛讨论本身说明：

```text
如何找到最受尊重的 Anchored VWAP 是一个开放问题。
```

对本策略而言，锚点不能随意选。

---

## 2. 和本策略相关的 AVWAP 锚点

当前建议保留四类：

```text
AVWAP_ZoneStart：第一控盘区起点；
AVWAP_ImpulseStart：第一波启动K线；
AVWAP_Reclaim：重新站回POC那根K线；
AVWAP_PullbackLow：深洗低点。
```

优先级：

```text
1. ZoneStart：庄家初始控盘平均成本；
2. ImpulseStart：第一波启动资金成本；
3. Reclaim：回收后新资金成本；
4. PullbackLow：反弹资金成本，仅辅助。
```

---

## 3. 可以吸收进知识库的内容

```text
AVWAP 不是一条固定线，而是一组结构锚点成本线；
不同锚点代表不同资金成本；
多条 AVWAP 共振比单条 AVWAP 更可靠；
回收后 AVWAP 从压力转支撑，才有接受意义。
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
avwap_zonestart_reclaimed
avwap_impulsestart_reclaimed
avwap_reclaim_support
avwap_confluence_count
best_respected_avwap_anchor
```

---

## 5. 新增关键词

```text
Anchored VWAP
AVWAP
Institutional VWAP
Smart Money Benchmark
Best Respected AVWAP
AVWAP Anchor
AVWAP Confluence
```

---

## 6. 待验证问题

```text
1. meme第一控盘区模型中哪类AVWAP锚点最稳定？
2. ZoneStart和ImpulseStart冲突时谁优先？
3. AVWAP_Reclaim是否适合判断回收后新资金成本？
4. 多AVWAP共振是否可作为强接受条件？
```
