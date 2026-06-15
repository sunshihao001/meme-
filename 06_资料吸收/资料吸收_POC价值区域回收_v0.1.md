# 资料吸收：POC 与价值区域回收 v0.1

> 分线：F资料吸收 / C语义概念 / D风险管理  
> 来源标题：Market Profile indicator / Analytical Volume Profile Trading  
> URL：  
> - https://www.mql5.com/en/articles/16461  
> - https://www.mql5.com/en/articles/20327  
> 本地原文路径：`05_关键词检索/POC与AVWAP重新接受_检索资料_v0.1/`  
> 关联主题：POC、Value Area、VAH、VAL、回收、拒绝、市场记忆  

---

## 1. 资料核心内容

Market Profile / Volume Profile 资料强调：

```text
POC 是交易活动最集中的价格水平；
Value Area 是市场接受过的价格范围；
价格在关键成交区会留下市场记忆。
```

---

## 2. 和本策略相关的概念

### 2.1 POC 回收

对本策略：

```text
POC 回收不是碰到 POC，而是重新站回并在其附近/上方重新形成接受。
```

### 2.2 Value Area 回收

更完整的回收应包括：

```text
重新进入 Value Area；
站回 POC；
回撤不重新跌破 VAL 或 POC；
二次拉升离开价值区上沿或重新向上扩展。
```

### 2.3 POC 拒绝

表现为：

```text
接近 POC 后被压回；
站上 POC 后快速跌回；
多次测试 POC 失败；
POC 从成本锚变成上方压力。
```

---

## 3. 可以吸收进知识库的内容

```text
POC 是第一控盘区核心成本点；
Value Area 才是完整成本区域；
重新接受要同时观察区域和中枢；
只看POC一条线容易误判。
```

---

## 4. 对已有定义的影响

```text
[x] 修改部分定义
[x] 新增风险项
[x] 新增指标字段
```

新增字段候选：

```text
value_area_reentered
poc_reclaimed
poc_hold_after_reclaim
poc_rejection_count
val_break_failed
value_area_acceptance_score
```

---

## 5. 新增关键词

```text
POC Reclaim
POC Rejection
Value Area Reclaim
Value Area Acceptance
VAH
VAL
Market Memory
Point of Control
Support Resistance Flip
```

---

## 6. 待验证问题

```text
1. 价格先进入Value Area但未站回POC，是否算弱回收？
2. POC站回但仍低于AVWAP，是否算接受不足？
3. POC和VAL哪个更适合作为失效边界？
4. meme深洗后价格是否常常先回收Value Area，再回收POC？
```
