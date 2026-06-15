# 资料吸收：Liquidity Sweep / Reclaim v0.1

> 分线：F资料吸收 / B庄家周期 / D风险管理  
> 来源标题：Liquidity Sweep on BoS、Dynamic STF Liquidity Sweep、Liquidity Grab 等本轮资料  
> URL：  
> - https://www.mql5.com/en/articles/20569  
> - https://www.mql5.com/en/articles/22140  
> - https://www.mql5.com/en/articles/18379  
> - https://www.mql5.com/ru/articles/20986  
> - https://www.mql5.com/ru/articles/16518  
> 语言：英文 / 俄文  
> 本地原文路径：`05_关键词检索/深洗与死亡盘_检索资料_v0.1/`  
> 关联主题：深洗、假跌破、流动性扫荡、快速收回、死亡盘过滤  

---

## 1. 资料核心内容

本组资料围绕：

```text
Liquidity Sweep
Liquidity Grab
Stop Hunt
False Breakout
Break of Structure
Reclaim
```

核心思想是：

```text
价格经常会扫过明显高低点之外的流动性，但真正关键不是“扫”，而是扫完之后是否重新收回，并与结构方向形成确认。
```

---

## 2. 和本策略相关的概念

### 2.1 Liquidity Sweep

对应本策略：

```text
深洗中的扫流动性动作
```

典型表现：

```text
跌破前低
跌破区间下沿
跌破VAL/第一控盘区下沿
刺穿散户止损区域
随后重新收回
```

---

### 2.2 Wick Sweep

对应本策略中较健康的深洗表现：

```text
影线刺破关键位置，但收盘重新回到结构内部。
```

策略含义：

```text
更像清洗/扫流动性，而不是彻底破位。
```

---

### 2.3 Close Sweep

对应更高风险的深洗表现：

```text
收盘跌破关键位置，之后才尝试收回。
```

策略含义：

```text
需要更多确认，不能直接按健康深洗处理。
```

---

### 2.4 Reclaim

对应本策略核心：

```text
重新收回 / 重新接受成本区
```

Reclaim 不等于：

```text
触碰
一根K线站上
短暂反抽
```

更合理理解：

```text
扫流动性后重新回到关键结构区，并在后续回撤中不重新失守。
```

---

## 3. 可以吸收进知识库的内容

### 3.1 深洗要拆成“扫”和“收回”两个动作

原来容易把深洗看成一个整体：

```text
跌很深 = 洗盘
```

现在应拆为：

```text
Sweep：扫掉流动性
Reclaim：重新收回关键结构
Confirm：后续结构确认
```

只有 Sweep 没有 Reclaim，不应视为健康深洗。

---

### 3.2 深洗有效性需要后续结构确认

Liquidity Sweep on BoS 资料强调：

```text
扫流动性要结合 Break of Structure。
```

对本策略转化为：

```text
扫低点后，如果没有重新回收 POC/AVWAP，也没有结构转强，就不能升级为二次启动观察对象。
```

---

### 3.3 过滤线可以从普通MA升级为成本锚

有资料用 MA Filter 判断扫流动性后的方向过滤。

对本策略更合适的过滤线是：

```text
POC
AVWAP
第一控盘区上下沿
Value Area
```

也就是说：

```text
AVWAP 是比普通MA更符合庄家成本逻辑的过滤线。
```

---

## 4. 对已有定义的影响

```text
[ ] 不影响，只作为补充
[x] 修改部分定义
[ ] 推翻旧定义
[x] 新增风险项
[x] 新增关键词
```

说明：

```text
本组资料把“深洗”进一步拆成 Sweep -> Reclaim -> Confirm 三段。
这会让策略不再把扫低点本身视为机会，而是把“扫后收回并确认”视为机会。
```

---

## 5. 新增关键词

```text
Liquidity Sweep
Liquidity Grab
Stop Hunt
Sell Side Liquidity
Buy Side Liquidity
Wick Sweep
Close Sweep
Reclaim
Failed Reclaim
Break of Structure
BOS
False Breakout
False Breakdown
ATR Filter
Liquidity Zone
```

---

## 6. 待验证问题

```text
1. meme 市场中 Wick Sweep 的有效性是否高于 Close Sweep？
2. Sweep 后必须在多少根K线内收回，才算快速回收？
3. Sweep 低点是否应成为失效锚？
4. Reclaim 的判断应以收盘价、停留时间还是回撤不破为准？
5. 是否需要建立 sweep_reclaim_score？
```

---

## 7. 应更新的文件

```text
02_庄家周期/深洗与死亡盘语义深化_v0.1.md
03_语义概念/POC与AVWAP重新接受定义_v0.1.md
04_风险管理/结构风险评分模型_v0.1.md
08_指标需求/MQL5观察指标需求_v0.2.md
```

---

## 8. 对当前策略的新增表达

建议后续把深洗定义升级为：

```text
深洗不是单纯深跌，而是 Sweep -> Reclaim -> Confirm 三段结构；只有扫流动性后重新回收第一控盘区成本锚，并在后续回撤中不重新失守，才有资格进入二次启动观察。
```
