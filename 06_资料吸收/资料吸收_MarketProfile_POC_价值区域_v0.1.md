# 资料吸收：Market Profile / POC / 价值区域 v0.1

> 分线：F资料吸收 / C语义概念 / H指标规则  
> 来源标题：Market Profile indicator / 市场轮廓指标  
> URL：https://www.mql5.com/zh/articles/16461  
> 本地原文路径：`05_关键词检索/第一控盘区_检索资料_v0.1/ZH_MarketProfile_POC价值区域_中文已下载源.md`  
> 关联主题：第一控盘区、成本中枢、POC、VAH、VAL、价值区域  

---

## 1. 资料核心内容

Market Profile 不是直接买卖信号，而是帮助理解：

```text
市场在哪些价格接受成交；
价格在哪些水平停留更久；
市场的价值区域在哪里；
POC / VAH / VAL 如何形成。
```

资料中强调 Market Profile 能显示：

```text
价格在某些水平花费的时间；
某些水平发生的成交量；
最大交易活动发生在哪里；
关键供需水平在哪里。
```

---

## 2. 和本策略相关的概念

### 2.1 价值区域

对应本策略：

```text
第一控盘区的区域边界。
```

不是一个点，而是一段市场接受过的价格区间。

---

### 2.2 POC

对应本策略：

```text
第一控盘区内部最重要的成本锚。
```

但 POC 不是第一控盘区本身。

关系应定义为：

```text
第一控盘区 = 价值区域
POC = 价值区域内的核心成本点
VAH/VAL = 价值区域上下边界
```

---

### 2.3 Initial Balance

资料中 Market Profile 有 Initial Balance 概念。

对 meme 策略的启发：

```text
meme 早期第一控盘区可以借鉴 Initial Balance 的思想，但不能机械照搬交易日第一个小时。
```

更适合定义为：

```text
代币早期第一次市场接受区 / 初始成本平衡区。
```

---

## 3. 可以吸收进知识库的内容

### 3.1 第一控盘区应是区域，不是单点

应写入策略定义：

```text
第一控盘区不是 POC，而是包含 POC、VAH、VAL、成交/停留密集的价值区域。
```

---

### 3.2 第一控盘区代表“早期价值接受”

Market Profile 语义中，“价值区域”代表市场接受过的价格范围。

对本策略转化为：

```text
第一控盘区 = meme 早期主要资金和市场达成过短暂成本共识的区域。
```

---

### 3.3 后续深洗回收的是“价值区”而不是某条线

后续观察不应只看：

```text
是否碰到 POC
```

而应看：

```text
是否重新进入价值区域；
是否站回 POC；
是否在 VAH/VAL 内重新接受；
回撤是否不再跌回 VAL 下方。
```

---

## 4. 对已有定义的影响

```text
[ ] 不影响，只作为补充
[x] 修改部分定义
[ ] 推翻旧定义
[x] 新增关键词
```

说明：

```text
本资料强化了“第一控盘区是价值区域，而不是单个 POC”的定义。
```

---

## 5. 新增关键词

```text
Market Profile
Initial Balance
Value Area
Value Area High
VAH
Value Area Low
VAL
Point of Control
POC
Fair Value
Acceptance
Rejection
```

---

## 6. 待验证问题

```text
1. meme 第一控盘区是否可以用固定时间窗口构造？
2. 第一控盘区 VAH/VAL 是否应由成交量分布还是价格停留时间确定？
3. POC 位于区间边缘时，控盘区是否无效？
4. 深洗后重新进入价值区域是否比站回 POC 更早？
```

---

## 7. 应更新的文件

```text
03_语义概念/第一控盘区定义_v0.1.md
03_语义概念/POC与AVWAP重新接受定义_v0.1.md
08_指标需求/MQL5观察指标需求_v0.2.md
```
