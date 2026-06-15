# Meme 市场第一控盘区成本中枢回收模型：策略定位与定义 v0.1

> 重要背景：本策略不是传统外汇/股票趋势跟随策略，而是用于 **meme 市场** 的庄家第一波控盘、第一波拉升、深度洗盘、后续二次启动观察模型。  
> 当前目标：先把策略本身定义清楚、分类清楚、语义边界清楚；暂不急于细化入场规则和自动交易规则。  

---

## 1. 用户原始策略语境

该策略服务的市场是：

```text
meme 市场 / 高波动投机市场 / 庄家控盘明显的早期代币市场
```

典型路径是：

```text
庄家第一波控盘区域形成
-> 第一波拉升制造市场注意力
-> 随后深度回撤
-> 长时间洗盘
-> 市场热度下降、浮筹被清理
-> 后续如果重新起来，需要判断哪里才是相对稳妥的上车区域
```

核心问题不是：

```text
最低点在哪里？
第一波什么时候追？
Fib 0.618 能不能买？
POC 一碰能不能买？
AVWAP 回踩能不能买？
```

真正问题是：

```text
庄家第一波控盘成本区经历深洗后，后续价格如果重新起来，什么时候说明它不是普通反抽，而是重新回到庄家成本中枢并具备二次启动可能？
```

---

## 2. 一句话重新定义

```text
这是一个用于 meme 市场的“庄家第一控盘成本区深洗后重新接受与二次启动确认模型”。
```

更完整定义：

```text
在 meme 市场中，先识别庄家第一波控盘形成的成本中枢；当价格经历第一波拉升后深度回撤并长时间洗盘，再观察后续价格是否重新回收 POC / AVWAP 等成本锚，并通过第一次拉起、回撤不破、二次拉升来确认庄家成本区重新被市场接受，从而只研究二次确认后的相对稳妥小段。
```

短名称：

```text
meme 第一控盘区深洗回收模型
```

工程化名称：

```text
Meme First Control Zone Re-accumulation Reclaim Model
```

---

## 3. 该策略属于什么类型？

### 3.1 一级分类

```text
庄家控盘结构识别策略
```

### 3.2 二级分类

```text
深度洗盘后二次启动确认策略
```

### 3.3 技术分析映射

```text
Accumulation / Re-accumulation Strategy
Market Maker Control Zone Strategy
Volume Profile POC Reclaim Strategy
Anchored VWAP Cost Basis Reclaim Strategy
Washout Retest Confirmation Strategy
Second Leg / Second Expansion Confirmation Strategy
```

### 3.4 中文分类

```text
主分类：庄家第一控盘区深洗后二次启动策略
副分类：成本中枢回收确认策略
风控分类：诱多反抽 / 尾仓派发识别策略
执行风格：保守确认型，不是左侧抄底型
```

---

## 4. 它不是哪类策略？

明确排除：

```text
不是突破追涨策略
不是第一波主升捕捉策略
不是最低点抄底策略
不是单纯 Fib 回撤买入策略
不是单纯 POC 支撑策略
不是单纯 VWAP 回踩策略
不是热度/叙事驱动买入策略
不是无脑庄家还会拉的幻想策略
```

---

## 5. 策略真正捕捉的阶段

meme 庄家控盘周期可以粗分为：

```text
P0：无庄/无结构
P1：庄家吸筹/第一控盘区
P2：第一波拉升/制造关注
P3：高位派发或部分派发
P4：深度回撤/洗盘/冷却
P5：成本区重新接近
P6：POC/AVWAP重新接受
P7：第一次拉起
P8：回撤不破成本锚
P9：二次拉升确认
P10：二次启动后的稳定小段
PX：诱多反抽/尾仓派发/死亡盘
```

本策略只研究：

```text
P6 -> P10
```

尤其是：

```text
P8 / P9 之后的小段
```

---

## 6. 核心判断标准

不是问：

```text
它跌够了吗？
它便宜了吗？
它曾经涨过吗？
庄家还在吗？
```

而是问：

```text
1. 第一控盘成本区是否真实存在？
2. 第一波拉升是否足以证明该区域曾经被控盘？
3. 深度洗盘后是否没有彻底死亡？
4. 后续上涨是否重新回收 POC / AVWAP 成本锚？
5. 第一次拉起后，回撤是否不破关键成本锚？
6. 第二次拉升是否确认市场重新接受该成本区？
7. 反抽中是否没有继续明显派发？
```

只有这些问题都偏正向，才进入研究区。

---

## 7. “绝对稳妥”的重新定义

在 meme 市场没有绝对稳妥。

因此本策略里的“绝对稳妥”应重新定义为：

```text
不是风险为零，而是在庄家深洗后，尽量避开抄底、避开第一波反抽、避开诱多，等待成本区重新被市场接受并经过二次确认后的相对稳妥位置。
```

也就是说：

```text
稳妥 = 结构确认更充分 + 风险暴露更晚 + 放弃最低成本 + 换取更高确定性
```

---

## 8. 当前阶段不急着细化规则

当前不优先做：

```text
精确入场价
止损价
仓位比例
自动下单
胜率回测
参数优化
```

当前优先做：

```text
策略定义
类型归类
庄家行为阶段拆解
洗盘与死亡盘区分
回收与反抽区分
二次启动与诱多区分
关键词体系
相关论坛资料收集
```

---

## 9. 后续要从论坛资料完善的核心概念

优先搜索和学习：

```text
Accumulation
Re-accumulation
Markup
Distribution
Washout
Shakeout
Spring
Test
Retest
Wyckoff
Market Maker Model
Smart Money Concepts
Order Block
Mitigation Block
Liquidity Grab
Bull Trap
Dead Cat Bounce
Volume Profile
Point of Control
Anchored VWAP
```

---

## 10. 当前最准确的策略类型定义

```text
这是一个 meme 市场中的庄家第一控盘区深洗后，基于 POC / AVWAP 成本锚重新接受与二次拉升确认的保守型 re-accumulation / reclaim 观察策略。
```

英文：

```text
A conservative meme-market re-accumulation reclaim model that waits for the first market-maker control zone to be retested by a deep washout, then requires POC / Anchored VWAP reclaim and a second-push confirmation before considering the post-confirmation segment.
```
