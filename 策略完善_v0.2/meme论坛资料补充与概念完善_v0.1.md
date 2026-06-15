# Meme 第一控盘区深洗回收模型：论坛资料补充与概念完善 v0.1

> 目的：根据用户明确的 meme 市场语境，围绕“庄家控盘、第一波拉升、深洗、二次启动、诱多反抽”重新搜索 MQL5 论坛/文章资料，并提炼对策略本身有用的概念。  

---

## 1. 本轮搜索方向

用户明确：

```text
该策略用于 meme 市场。
一般先确定庄家第一波控盘区域，随后第一波拉升，然后深度回撤、长时间洗盘。
真正要判断的是：后续如果重新起来，什么位置才相对稳妥。
```

因此本轮不再只搜：

```text
POC / VWAP / Fibonacci
```

而是增加庄家周期语义：

```text
Wyckoff
Accumulation
Re-accumulation
Distribution
Washout
Shakeout
Spring
Liquidity Sweep
Liquidity Grab
Bull Trap
Dead Cat Bounce
Market Maker
Order Block
Inducement
Break of Structure
```

---

## 2. 新下载资料目录

```text
C:\Users\Administrator\Documents\MQL5_第一控盘区成本中枢回收模型_学习资料\meme庄家控盘语义补充资料
```

下载清单：

```text
meme语义补充下载清单.json
```

---

## 3. 本轮新增重点资料

### 3.1 Wyckoff 吸筹派发自动化

文件：

```text
EN_Wyckoff吸筹派发自动化_适合深洗与二次确认语义.md
```

对应策略价值：

```text
Wyckoff 的 Accumulation / Distribution / Spring / Test / Sign of Strength / Last Point of Support 语义，与 meme 第一控盘、深洗、二次启动非常接近。
```

可借鉴概念：

```text
Accumulation：第一控盘区 / 吸筹区
Spring / Shakeout：深洗 / 假跌破 / 清理浮筹
Sign of Strength：重新起来后的强度确认
Last Point of Support：二次确认前的回踩不破点
Distribution：第一波派发或尾仓派发
```

对当前策略的启发：

```text
你的“第一次拉起后回撤不破，再二次拉升确认”，可以借鉴 Wyckoff 中 Spring -> Test -> SOS -> LPS 的结构。
```

---

### 3.2 BOS 流动性扫荡策略

文件：

```text
EN_BOS流动性扫荡策略_适合诱多与洗盘识别.md
```

对应策略价值：

```text
meme 深洗经常不是普通下跌，而是扫掉前低流动性后快速收回。
```

可借鉴概念：

```text
Liquidity Sweep
Break of Structure
Stop Hunt
False Breakout
Reclaim after Sweep
```

对当前策略的启发：

```text
深回撤时如果跌破 VAL / POC / 前低后快速收回，可能不是死亡盘，而是洗盘/扫流动性。
但如果扫完后无法收回 POC/AVWAP，则更可能是死亡盘。
```

---

### 3.3 动态 STF 流动性扫荡指标

文件：

```text
EN_动态STF流动性扫荡指标_适合假突破与快速回收.md
```

对应策略价值：

```text
用于理解 Wick Sweep 和 Close Sweep，这对区分 meme 洗盘很重要。
```

可借鉴分类：

```text
Wick Sweep：影线扫流动性后收回
Close Sweep：收盘跌破后再收回，风险更高
```

对当前策略的启发：

```text
如果深洗只是影线刺破控盘区但快速收回，可能是洗盘。
如果连续收盘在控盘区下方，且POC/AVWAP变压力，则更可能是死亡盘。
```

---

### 3.4 流动性扫荡 MA 过滤工具

文件：

```text
EN_流动性扫荡MA过滤工具_适合洗盘识别.md
```

对应策略价值：

```text
可作为“洗盘后是否重新回到趋势过滤线/成本线之上”的参考。
```

对当前策略的启发：

```text
AVWAP 可以替代普通 MA，作为更符合成本逻辑的过滤线。
```

---

### 3.5 订单块 + 诱导 + BOS 策略

文件：

```text
EN_订单块诱导BOS策略_区分真突破与流动性陷阱.md
```

对应策略价值：

```text
用于区分真突破和流动性陷阱，对 meme 诱多反抽识别有价值。
```

可借鉴概念：

```text
Order Block
Inducement
Break of Structure
Liquidity Trap
Mitigation Block
```

对当前策略的启发：

```text
第一控盘区可以同时被视为 Volume Profile 成本区 + Order Block / Mitigation Block。
如果后续回到该区域只是为了诱导买入然后继续卖，则属于诱多反抽；如果回到该区域后回撤不破并BOS，则更接近二次启动。
```

---

### 3.6 俄文 Accumulation / Distribution 资料

文件：

```text
RU_AccumulationDistribution工作方法_MQL4参考.md
```

对应策略价值：

```text
虽然是 MQL4，但俄文资料中“накопление / распределение”对应吸筹/派发，适合作为多语言搜索入口。
```

---

## 4. 对策略定义的进一步完善

结合本轮资料，策略应更准确地定义为：

```text
meme 市场中的庄家第一控盘区深洗后 re-accumulation / reclaim 模型。
```

完整表达：

```text
先通过第一控盘区和第一波拉升确认庄家曾经控盘；再等待深度回撤和长时间洗盘；后续只有当价格重新回收 POC / AVWAP 成本锚，并表现出类似 Wyckoff Spring/Test/SOS/LPS 的二次确认结构时，才把它从普通反抽升级为二次启动观察对象。
```

---

## 5. 当前策略类型最终归类 v0.1

主类型：

```text
Meme Market Maker Re-accumulation Reclaim Strategy
```

中文：

```text
meme 庄家深洗后重新吸筹/成本回收策略
```

子类型：

```text
1. 第一控盘区识别策略
2. 深洗/扫流动性识别策略
3. POC/AVWAP成本锚回收策略
4. 二次启动确认策略
5. 诱多反抽/尾仓派发风险过滤策略
```

---

## 6. 需要继续打磨的概念

### 6.1 第一控盘区 vs Wyckoff Accumulation

需要回答：

```text
第一控盘区是否等价于 Accumulation Range？
meme 市场中第一控盘区是否更短、更暴力？
Volume Profile POC 与 Wyckoff trading range 如何结合？
```

---

### 6.2 深洗 vs Spring / Shakeout

需要回答：

```text
深回撤到 0.618-0.786 是否只是价格比例？
是否还要看是否扫掉前低/VAL？
是否快速收回才算洗盘？
长期不收回是否就是死亡盘？
```

---

### 6.3 重新起来 vs Sign of Strength

需要回答：

```text
第一次拉起是否等价于 SOS？
还是只有二次拉升才算 SOS？
第一次拉起后的回撤不破是否等价于 Test / LPS？
```

---

### 6.4 二次确认 vs LPS

需要回答：

```text
真正稳妥的位置是否应接近 LPS，而不是 Spring 或 SOS？
如果是，策略核心应从“回收后买”改为“回收后等待 LPS”。
```

这和你的保守风格高度一致。

---

## 7. 当前最适合采用的概念框架

建议把原模型升级为：

```text
第一控盘区 = Accumulation / Re-accumulation Range
深回撤 = Washout / Shakeout / Spring
POC/AVWAP回收 = Value Reclaim / Cost Basis Reclaim
第一次拉起 = Initial SOS Candidate
回撤不破 = Test / LPS Candidate
二次拉升 = SOS Confirmation / Markup Continuation
失败结构 = Bull Trap / Distribution / Dead Cat Bounce
```

---

## 8. 下一步搜索关键词

继续搜索：

```text
Wyckoff Spring Test LPS MQL5
Sign of Strength Last Point of Support MQL5
Accumulation Distribution indicator MQL5
Liquidity Sweep Reclaim MQL5
Order Block Inducement BOS MQL5
Bull Trap False Breakout MQL5
Volume Profile Re-accumulation
Anchored VWAP Reclaim
```

俄文：

```text
Вайкофф накопление распределение
ложный пробой возврат уровня
снятие ликвидности
накопление объем профиль
```

---

## 9. 本轮结论

你这个策略最接近的国际语义不是单纯 VWAP/POC/Fib，而是：

```text
Wyckoff re-accumulation + liquidity sweep / washout + POC/AVWAP reclaim + LPS/second push confirmation
```

中文可以定义为：

```text
meme 庄家第一控盘区深洗后二次启动确认策略
```

这是目前最清晰、最准确的分类。
