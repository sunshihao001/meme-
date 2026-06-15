# 资料吸收：Wyckoff Spring / Test / SOS / LPS v0.1

> 分线：F资料吸收 / B庄家周期 / C语义概念  
> 来源标题：Automating Classic Market Methods in MQL5 (Part 1): Wyckoff Accumulation and Distribution  
> URL：https://www.mql5.com/en/articles/22628  
> 语言：英文  
> 本地原文路径：`meme庄家控盘语义补充资料/EN_Wyckoff吸筹派发自动化_适合深洗与二次确认语义.md`  
> 关联主题：深洗 vs 死亡盘、二次确认、LPS保守位置  

---

## 1. 资料核心内容

该资料讲的是如何用 MQL5 自动化 Wyckoff 的 Accumulation / Distribution 结构。

它的关键观点不是某一个信号，而是：

```text
Wyckoff 事件必须按顺序判断，不能孤立判断。
```

尤其强调：

```text
Spring 不是普通跌破；
SOS 不是普通上涨；
LPS 才是 SOS 之后的低风险确认位置；
必须用状态机保证顺序。
```

---

## 2. 和本策略相关的概念

### 2.1 Spring

对应本策略：

```text
深洗 / 假跌破 / 扫流动性
```

但 Spring 不是：

```text
任何大跌
任何跌破前低
任何跌到0.618/0.786
```

Spring 的含义是：

```text
在一个已经形成的区间或控盘结构内，价格故意跌破支撑，清洗弱手和流动性，然后重新回到区间。
```

---

### 2.2 Sign of Strength / SOS

对应本策略：

```text
深洗后第一次有效拉起
```

但 SOS 还不是最终稳妥点。

它只是说明：

```text
深洗后需求开始出现。
```

---

### 2.3 Last Point of Support / LPS

对应本策略最重要：

```text
第一次拉起后回撤不破关键成本锚的位置。
```

这与用户保守风格高度一致。

当前策略真正想研究的位置更接近：

```text
LPS之后，或LPS确认后的二次拉升。
```

而不是：

```text
Spring低点
第一次站回POC
第一次站上AVWAP
第一次拉起
```

---

## 3. 可以吸收进知识库的内容

### 3.1 状态机思想

Wyckoff 资料强调：

```text
事件必须有先后顺序。
```

对本策略应转化为：

```text
第一控盘区 -> 深洗 -> 回收成本锚 -> 第一次拉起 -> 回撤不破 -> 二次拉升确认
```

不能跳步。

---

### 3.2 Spring 必须有上下文

资料中强调：

```text
A spring is not merely a dip below support.
```

对本策略应转化为：

```text
深洗不是单纯跌破，而是第一控盘区形成后的上下文事件。
```

---

### 3.3 LPS 是保守入口语义

资料把 LPS 作为 SOS 后的低风险位置。

对本策略应转化为：

```text
相对稳妥位置 = 成本锚回收后，第一次拉起之后的回撤不破区域，再由二次拉升确认。
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
本资料强化了“不能在Spring/深洗低点上车”的保守逻辑。
它把当前策略的核心确认点从“回收后买”进一步推向“回收后等待LPS/二次确认”。
```

---

## 5. 新增关键词

```text
Wyckoff Spring
Shakeout
Sign of Strength
SOS
Last Point of Support
LPS
Last Point of Supply
LPSY
Upthrust
Sign of Weakness
SOW
State Machine
```

---

## 6. 待验证问题

```text
1. meme市场中的LPS是否会比传统市场更短、更快？
2. LPS是否必须回踩POC/AVWAP，还是只要不破局部结构低点即可？
3. SOS是否必须突破第一控盘区上沿，还是只要重新回到成本区上方即可？
4. Spring是否可以是多次扫低点，而不是单次？
```

---

## 7. 应更新的文件

```text
02_庄家周期/深洗与死亡盘语义深化_v0.1.md
03_语义概念/Wyckoff映射_Spring_Test_SOS_LPS_v0.1.md
04_风险管理/诱多反抽与二次启动区分_v0.1.md
08_指标需求/MQL5观察指标需求_v0.2.md
```
