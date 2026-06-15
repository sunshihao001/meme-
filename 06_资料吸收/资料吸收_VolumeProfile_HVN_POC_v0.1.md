# 资料吸收：Volume Profile / HVN / POC v0.1

> 分线：F资料吸收 / C语义概念 / H指标规则  
> 来源标题：Liquidity Spectrum Volume Profile、Analytical Volume Profile Trading、Volume Profile CodeBase  
> URL：  
> - https://www.mql5.com/en/articles/22342  
> - https://www.mql5.com/en/articles/20327  
> - https://www.mql5.com/es/code/47784  
> 本地原文路径：`05_关键词检索/第一控盘区_检索资料_v0.1/`  
> 关联主题：第一控盘区、成交密集、HVN、POC、流动性架构、市场记忆  

---

## 1. 资料核心内容

Volume Profile 相关资料关注：

```text
成交量如何分布在不同价格水平；
哪些价格区域存在高成交节点；
POC 如何代表最大成交价格；
成交密集区如何形成市场记忆和流动性结构。
```

这对第一控盘区非常重要，因为 meme 第一控盘区不能只靠肉眼画箱体。

---

## 2. 和本策略相关的概念

### 2.1 High Volume Node / HVN

对应本策略：

```text
第一控盘区内部的高成交区域。
```

如果一个所谓控盘区没有 HVN 或成交密集，它更可能只是主观画线。

---

### 2.2 POC

对应本策略：

```text
第一控盘区内部最大成交价格，是核心成本锚。
```

但仍需强调：

```text
POC 是点，控盘区是区域。
```

---

### 2.3 Market Memory

Volume Profile 资料中“市场记忆”概念可吸收为：

```text
早期成交密集区会在后续深洗回收时重新产生反应。
```

对本策略非常关键。

---

## 3. 可以吸收进知识库的内容

### 3.1 第一控盘区必须有成交密集证据

建议写入判断标准：

```text
第一控盘区必须至少具备成交密集、价格停留、POC/HVN中的一种强证据，最好多证据共振。
```

---

### 3.2 POC位置影响控盘区质量

如果 POC 在区间极端边缘，说明该区可能不均衡。

可作为后续量化字段：

```text
poc_position_ratio
```

用于判断：

```text
POC 是否位于区间内部合理位置。
```

---

### 3.3 深洗回收要观察 HVN/POC 反应

后续回收不是只看价格重新涨，而要看：

```text
是否重新进入 HVN；
是否站回 POC；
是否在高成交区域上方重新接受；
是否从 LVN 快速穿越回 HVN。
```

---

## 4. 对已有定义的影响

```text
[ ] 不影响，只作为补充
[x] 修改部分定义
[ ] 推翻旧定义
[x] 新增关键词
[x] 新增指标字段
```

说明：

```text
Volume Profile 使第一控盘区定义从图形概念升级为可计算的成交结构概念。
```

---

## 5. 新增关键词

```text
Volume Profile
High Volume Node
HVN
Low Volume Node
LVN
Point of Control
POC
Liquidity Spectrum
Market Memory
Volume Distribution
Profile Bins
Value Area
```

---

## 6. 新增指标字段候选

```text
zone_volume_share
poc_position_ratio
hvn_count
lvn_boundary_detected
profile_bin_count
poc_reaction_count
retest_volume_response
```

---

## 7. 待验证问题

```text
1. meme DEX 成交数据是否足够构建可靠 Volume Profile？
2. 如果只有K线成交量，没有真实逐笔成交，POC是否仍可用？
3. 第一控盘区至少需要多少根K线/多少成交量才能成立？
4. HVN和POC哪个对后续回收更重要？
5. LVN是否可以作为深洗快速穿越区？
```

---

## 8. 应更新的文件

```text
03_语义概念/第一控盘区定义_v0.1.md
03_语义概念/POC与AVWAP重新接受定义_v0.1.md
08_指标需求/MQL5观察指标需求_v0.2.md
09_规则与回测/结构字段评分模型_v0.1.md
```
