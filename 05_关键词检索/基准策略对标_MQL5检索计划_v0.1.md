# 基准策略对标_MQL5检索计划 v0.1

> 版本：v0.1  
> 分线：关键词检索线 / 规则与回测线 / 资料吸收线  
> 目的：围绕 POC 站回、AVWAP 站回、Liquidity Sweep 回收、当前复合策略四个基准，定向检索 MQL5 中文论坛、文章、代码库和市场资料，避免继续泛泛堆概念。  
> 状态：检索计划初版 / 待执行下载 / 待吸收  

---

## 1. 本文要解决的问题

当前策略已经进入验证阶段，不能再无限扩大概念库。

现在的检索目标不是：

```text
继续找更多交易术语
继续下载更多类似指标
继续证明当前策略看起来合理
```

而是：

```text
围绕 4 个基准策略，找到 MQL5 上可对标、可实现、可反驳、可回测的资料。
```

4 个基准策略是：

```text
A. 简单 POC 站回策略
B. 简单 AVWAP 站回策略
C. 简单 Liquidity Sweep 回收策略
D. 当前复合策略：第一控盘区 + 深洗 + POC/AVWAP 接受 + 回撤不破 + 二次启动
```

---

## 2. 检索总原则

### 2.1 不再泛搜

禁止继续使用过宽关键词，例如：

```text
交易策略
稳定EA
高胜率指标
智能交易
机构交易
```

这些会带来大量噪音。

---

### 2.2 每条资料必须归入一个基准

每条资料必须归类为：

```text
POC 基准
AVWAP 基准
Liquidity Sweep 基准
复合策略基准
回测/优化/过拟合纪律
失败案例 / 反例
```

无法归类的资料默认不吸收。

---

### 2.3 每条资料只吸收 3 类内容

```text
1. 规则定义：它到底怎么触发？
2. 实现方式：MQL5 里怎么计算、绘制、导出、回测？
3. 失败条件：它什么时候失效、过拟合、诱多、回撤过大？
```

不再为普通观点单独写长篇吸收笔记。

---

## 3. 检索范围

优先级：

```text
P1. MQL5 中文文章：https://www.mql5.com/zh/articles
P2. MQL5 中文代码库：https://www.mql5.com/zh/code/mt5
P3. MQL5 中文论坛：https://www.mql5.com/zh/forum
P4. MQL5 英文代码库 / 文章 / 论坛
P5. MQL5 Market 产品描述，仅作功能对标，不作策略可信证据
```

注意：

```text
Market 产品描述通常有营销夸大，只能用于识别行业常见模块，不能作为策略有效性证据。
```

---

## 4. 基准 A：POC 站回策略检索

### 4.1 中文关键词

```text
POC 控制点
成交量分布 控制点
成交量轮廓 POC
市场轮廓 POC
价值区域 POC
价格重新进入价值区域
成交密集区 支撑 阻力
Volume Profile 控制点
Market Profile 价值区域
```

### 4.2 英文关键词

```text
POC reclaim
Point of Control reclaim
Volume Profile POC
Market Profile POC
Value Area re-entry
VAH VAL POC strategy
High Volume Node support resistance
POC rejection
POC retest
```

### 4.3 MQL5 站内检索语句

```text
site:mql5.com/zh/articles POC 成交量分布 控制点
site:mql5.com/zh/code/mt5 Volume Profile POC
site:mql5.com/zh/forum POC 成交量 价值区域
site:mql5.com/en/code/mt5 Volume Profile POC Value Area
site:mql5.com/en/forum POC reclaim Volume Profile
```

### 4.4 要吸收的问题

```text
1. POC 是按 tick volume 还是 real volume 计算？
2. Value Area 比例是否固定 70%？
3. POC 站回如何定义：收盘站回、实体站回、N 根 K 停留？
4. POC 拒绝如何定义？
5. POC 单独作为信号的失败场景有哪些？
```

---

## 5. 基准 B：AVWAP 站回策略检索

### 5.1 中文关键词

```text
VWAP 成交量加权平均价
锚定 VWAP
Anchored VWAP
AVWAP 锚点
VWAP 回踩
VWAP 重新站上
VWAP 成本线
VWAP 支撑 阻力
```

### 5.2 英文关键词

```text
Anchored VWAP MT5
AVWAP reclaim
VWAP reclaim
VWAP retest
VWAP support resistance
VWAP anchor point
anchored volume weighted average price
VWAP standard deviation bands
```

### 5.3 MQL5 站内检索语句

```text
site:mql5.com/zh/articles VWAP 成交量加权平均价
site:mql5.com/zh/code/mt5 VWAP
site:mql5.com/zh/forum VWAP 交易策略
site:mql5.com/en/code/mt5 Anchored VWAP
site:mql5.com/en/forum VWAP reclaim strategy
```

### 5.4 要吸收的问题

```text
1. AVWAP 锚点如何选择？
2. 是锚定第一控盘区起点、第一波起点、回收点，还是深洗低点？
3. VWAP 站回是否需要成交量确认？
4. VWAP 单独作为成本锚时，在哪些市场失效？
5. AVWAP 是否需要标准差带辅助过滤？
```

---

## 6. 基准 C：Liquidity Sweep 回收策略检索

### 6.1 中文关键词

```text
流动性扫荡
扫流动性
流动性抓取
假突破
假突破回收
突破失败
诱多
诱空
快速回收
前低刺破收回
```

### 6.2 英文关键词

```text
Liquidity Sweep
Liquidity Grab
False Breakout
Fakeout
Failed Breakout
Sweep and Reclaim
Stop Hunt
Bull Trap
Bear Trap
Liquidity Trap
```

### 6.3 MQL5 站内检索语句

```text
site:mql5.com/zh/code/mt5 流动性 扫荡
site:mql5.com/zh/forum 假突破 回收
site:mql5.com/zh/articles false breakout
site:mql5.com/en/code/mt5 Liquidity Sweep
site:mql5.com/en/forum Liquidity Grab False Breakout
```

### 6.4 要吸收的问题

```text
1. Sweep 的触发是刺破前低，还是必须收回？
2. N 根 K 线内回收更合理？3、5、8 还是按 ATR？
3. Sweep 后是否需要 BOS / CHoCH 确认？
4. 假突破策略最常见的失败场景是什么？
5. Sweep 与普通跌破反抽如何区分？
```

---

## 7. 基准 D：当前复合策略检索

### 7.1 中文关键词

```text
吸筹 洗盘 二次启动
Wyckoff 吸筹 洗盘
重新吸筹
Spring Test LPS SOS
订单块 诱导 BOS
结构突破 回撤不破
成本区 回收
区间突破 回踩确认
```

### 7.2 英文关键词

```text
Wyckoff Spring Test LPS SOS
Re-accumulation breakout
Second leg confirmation
Second push confirmation
Order Block Inducement BOS
Breakout retest confirmation
Reclaim pullback continuation
Accumulation manipulation distribution
```

### 7.3 MQL5 站内检索语句

```text
site:mql5.com/zh/articles Wyckoff 吸筹
site:mql5.com/zh/code/mt5 Order Block BOS
site:mql5.com/zh/forum 二次启动 假突破
site:mql5.com/en/code/mt5 Wyckoff Spring BOS
site:mql5.com/en/forum Re-accumulation breakout retest
```

### 7.4 要吸收的问题

```text
1. 是否已有类似“吸筹区 -> 洗盘 -> 回收 -> 二次启动”的完整规则？
2. 对方如何定义确认，而不是事后解释？
3. 对方是否使用多策略确认？
4. 对方是否给出了回测或失败讨论？
5. 当前策略相比对方，是更早、更晚、更严格，还是只是更复杂？
```

---

## 8. 回测 / 优化 / 过拟合检索

### 8.1 中文关键词

```text
策略测试器
EA 优化
过拟合
参数优化
回测结果分析
多品种测试
样本外测试
前向测试
最大回撤
利润因子
期望值
```

### 8.2 英文关键词

```text
Strategy Tester
EA optimization
overfitting
walk forward test
out of sample test
profit factor
expectancy
maximum drawdown
multi symbol backtest
parameter robustness
```

### 8.3 MQL5 站内检索语句

```text
site:mql5.com/zh/articles 策略测试器 优化 过拟合
site:mql5.com/zh/forum EA 优化 回测 过拟合
site:mql5.com/en/articles Strategy Tester optimization overfitting
site:mql5.com/en/forum EA optimization walk forward test
```

### 8.4 要吸收的问题

```text
1. MQL5 策略测试中哪些指标最容易骗人？
2. 如何做样本外测试？
3. 如何避免参数过拟合？
4. 多品种、多周期测试怎么组织？
5. 如何记录 profit_factor、expectancy_R、max_drawdown_R？
```

---

## 9. 失败案例 / 反例检索

### 9.1 中文关键词

```text
EA 高胜率 爆仓
EA 回测好 实盘差
策略失效
假突破失败
VWAP 失效
POC 失效
流动性扫荡失败
马丁 网格 风险
```

### 9.2 英文关键词

```text
high win rate EA crash
backtest good live bad
strategy failed live trading
VWAP failed strategy
POC failed reclaim
false breakout failed
liquidity sweep failed
over optimized EA
```

### 9.3 要吸收的问题

```text
1. 成功回测为什么实盘失败？
2. 高胜率策略为什么容易爆？
3. 哪些失败是结构策略无法避免的？
4. 哪些失败可以通过死亡盘过滤提前识别？
5. 哪些失败来自执行成本、滑点和流动性？
```

---

## 10. 每条资料的记录模板

检索到资料后，统一记录：

```text
资料ID：
标题：
URL：
来源类型：文章 / 代码库 / 论坛 / 市场 / 外部
语言：中文 / 英文 / 俄文 / 其他
归属基准：POC / AVWAP / Sweep / 复合策略 / 回测纪律 / 失败案例
相关程度：高 / 中 / 低
是否下载源码：是 / 否
是否有回测：是 / 否
是否有失败讨论：是 / 否
是否值得写吸收笔记：是 / 否
```

---

## 11. 吸收笔记命名规范

如果值得吸收，写入：

```text
06_资料吸收/资料吸收_基准策略对标_POC站回_v0.1.md
06_资料吸收/资料吸收_基准策略对标_AVWAP站回_v0.1.md
06_资料吸收/资料吸收_基准策略对标_LiquiditySweep回收_v0.1.md
06_资料吸收/资料吸收_基准策略对标_复合策略确认_v0.1.md
06_资料吸收/资料吸收_回测优化与过拟合纪律_v0.1.md
06_资料吸收/资料吸收_失败案例与反例库_v0.1.md
```

不是每条资料都单独写文章，优先按主题合并吸收。

---

## 12. 下载目录建议

本轮检索资料建议集中放入：

```text
05_关键词检索/基准策略对标_MQL5检索资料_v0.1/
```

内部可分：

```text
POC站回/
AVWAP站回/
LiquiditySweep回收/
复合策略确认/
回测优化纪律/
失败案例反例/
原始HTML备份/
源码/
```

---

## 13. 本轮完成标准

第一轮定向检索完成标准：

```text
1. 每个基准至少找到 5 条相关资料。
2. 每个基准至少找到 1 个可参考指标或 EA 实现。
3. 至少找到 5 条回测 / 优化 / 过拟合资料。
4. 至少找到 5 条失败案例或反例讨论。
5. 写出一份基准策略对标吸收总结。
```

最低完成标准：

```text
总资料不少于 30 条。
```

---

## 14. 下一步

执行本计划后，下一步写：

```text
06_资料吸收/资料吸收_基准策略对标总结_v0.1.md
```

并把结论回填到：

```text
09_规则与回测/基准策略对比实验设计_v0.1.md
07_样本标注/meme样本标注体系_v0.1.md
08_指标需求/MQL5观察指标需求_v0.2.md
```
