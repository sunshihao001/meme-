# 资料吸收：Order Block / Inducement / BOS v0.1

> 分线：F资料吸收 / D风险管理 / C语义概念  
> 来源标题：Automating Trading Strategies in MQL5 (Part 48): Order Blocks, Inducement, Break of Structure  
> URL：https://www.mql5.com/en/articles/22078  
> 本地原文路径：`05_关键词检索/诱多反抽与二次启动_检索资料_v0.1/EN_OrderBlock_Inducement_BOS_流动性陷阱.md`  
> 关联主题：诱多、订单块、诱导、BOS、二次启动确认  

---

## 1. 资料核心内容

该资料强调：

```text
很多看似延续的突破，其实是为了扫掉止损和制造流动性陷阱。
```

它提出用：

```text
Order Block + Inducement + Break of Structure
```

来提升结构判断可靠性。

---

## 2. 和本策略相关的概念

### 2.1 Inducement

对应本策略：

```text
第一次拉起或短暂突破可能只是诱导，不一定是真二次启动。
```

### 2.2 Break of Structure / BOS

对应本策略：

```text
二次拉升需要形成结构推进，最好出现 higher high / BOS。
```

### 2.3 Order Block / Mitigation Block

对应本策略：

```text
第一控盘区可以兼具成本区和订单块/缓解区意义。
```

---

## 3. 可以吸收进知识库的内容

```text
突破不等于确认；
诱导后的BOS才更有意义；
回撤到关键区后的反应比第一次突破更重要；
深度回到订单块但没有反应，风险升高。
```

对本策略转化为：

```text
第一次拉起 = 可能是诱导；
回撤不破 + 二次拉升 = 更接近BOS确认；
如果回撤跌穿成本锚并反抽失败 = 诱多反抽。
```

---

## 4. 对已有定义的影响

```text
[x] 修改部分定义
[x] 新增风险项
[x] 新增关键词
```

---

## 5. 新增关键词

```text
Order Block
Inducement
Break of Structure
BOS
Mitigation Block
Liquidity Trap
Higher Timeframe Trend
Fair Value Gap
```

---

## 6. 待验证问题

```text
1. 二次启动是否必须有BOS？
2. 成本锚回撤不破和BOS哪个优先级更高？
3. 第一控盘区能否等同为早期Order Block？
4. 诱导是否常常发生在第一次拉起阶段？
```
