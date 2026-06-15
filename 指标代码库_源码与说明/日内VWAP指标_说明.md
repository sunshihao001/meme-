# 日内VWAP指标

> 本地文档目标名：日内VWAP指标
> 来源标题：在MQL5代码库免费下载MetaTrader 5的'Daily VWAP' ('Syllyon')指标, 2025.08.05
> 来源链接：https://www.mql5.com/zh/code/61090
> 下载时间：2026-06-12 23:16:39
> 类型：MQL5指标代码库

---

  * [![](https://c.mql5.com/i/sidebar/mt.svg)MetaTrader 5](/zh/code/mt5)
    * [![](https://c.mql5.com/i/sidebar/expert.svg)EA](/zh/code/mt5/experts)
    * [![](https://c.mql5.com/i/sidebar/indicator.svg)指标](/zh/code/mt5/indicators)
    * [![](https://c.mql5.com/i/sidebar/scripts.svg)脚本](/zh/code/mt5/scripts)
    * [![](https://c.mql5.com/i/sidebar/library.svg)程序库](/zh/code/mt5/libraries)
  * [![](https://c.mql5.com/i/sidebar/mt.svg)MetaTrader 4](/zh/code/mt4)
    * [![](https://c.mql5.com/i/sidebar/expert.svg)EA](/zh/code/mt4/experts)
    * [![](https://c.mql5.com/i/sidebar/indicator.svg)指标](/zh/code/mt4/indicators)
    * [![](https://c.mql5.com/i/sidebar/scripts.svg)脚本](/zh/code/mt4/scripts)
    * [![](https://c.mql5.com/i/sidebar/library.svg)程序库](/zh/code/mt4/libraries)


  * [![](https://c.mql5.com/i/sidebar/storage.svg)存储](/zh/code/storage)



__

[请观看](https://youtu.be/rloNyFVtHuA?list=PLltlMLQ7OLeKwyQwC8FhiKwjl9syKhOCK)如何免费下载自动交易 

__

请在[Twitter](https://x.com/mql5com)上找到我们！  
加入我们粉丝页

__

有趣的脚本？  
因此发布一个[链接](/zh/code/61090) -  
让其他人评价 

__

喜欢这个脚本？ 在[MetaTrader 5](https://download.terminal.free/cdn/web/metaquotes.ltd/mt5/mt5setup.exe?utm_source=www.mql5.com&utm_campaign=download)客户端尝试它 

到包裹

![指标](https://c.mql5.com/i/code/indicator.png)

# Daily VWAP - MetaTrader 5脚本

[Guillermo Pineda](/zh/users/syllyon)

![Guillermo Pineda](https://c.mql5.com/avatar/2025/5/6835f8d3-9c16.jpg)

####  [Guillermo Pineda](/zh/users/syllyon)

__

  * __MQL5 Developer 在[Remote](https://T.me/Syllyon)
  * __[委内瑞拉](https://www.mql5.com/go?https://maps.google.com/?z=4&q=%e5%a7%94%e5%86%85%e7%91%9e%e6%8b%89 "实时")
  * __[18567](/zh/users/syllyon/achievements "等级")



**4.7** (17)

  * [](https://T.me/Syllyon) [T.me/Syllyon](https://T.me/Syllyon)



我是一名 MQL4 和 MQL5 开发人员，专注于构建强大且可定制的交易专家顾问、指标和脚本。   
我正在积极拓展量化交易和机器学习应用，以优化金融策略。   
  
如果您有项目构思或想法想要讨论，请随时联系我！

[ 14 产品 ](/zh/users/syllyon/seller) [ 3 代码 ](/zh/users/syllyon/publications) [ 1 主题 ](/zh/users/syllyon/publications) [ 23 评论 ](/zh/users/syllyon/publications/all)

|  [Chinese __](javascript:void\(false\);) [English](/en/code/61090) [Русский](/ru/code/61090) [Español](/es/code/61090) [Deutsch](/de/code/61090) [日本語](/ja/code/61090) [Português](/pt/code/61090) [한국어](/ko/code/61090) [Français](/fr/code/61090) [Italiano](/it/code/61090) [Türkçe](/tr/code/61090)

显示: 
    863
等级: 
    

(8)
已发布: 
    5 八月 2025, 12:32
    

[__Daily VWAP.mq5](/zh/code/download/61090/daily_vwap.mq5 "Daily VWAP.mq5") (7.23 KB) 预览

__[__下载ZIP](/zh/code/download/61090.zip "下载单独ZIP文档中的全部附件") [__在MetaEditor如何使用下载的代码](https://www.metatrader5.com/zh/metaeditor/help/workspace/toolbox#codebase)

![MQL5 - MetaTrader 5客户端内置的交易策略语言](https://c.mql5.com/i/registerlandings/logo-2.png)

您错过了交易机会：

  * 免费交易应用程序
  * 8,000+信号可供复制
  * 探索金融市场的经济新闻



注册 登录

  * [使用 Google 登录](https://www.mql5.com/zh/auth_oauth2?provider=Google&amp;return=popup&amp;reg=1)



您同意[网站政策](/zh/about/privacy)和[使用条款](/zh/about/terms)

如果您没有帐号，请[注册](https://www.mql5.com/zh/auth_register)

可以使用cookies登录MQL5.com网站。

请在您的浏览器中启用必要的设置，否则您将无法登录。

  * [使用 Google 登录](https://www.mql5.com/zh/auth_oauth2?provider=Google&amp;return=popup)



     ![MQL5自由职业者](https://c.mql5.com/i/code/icon_freelance.svg) 需要基于此代码的EA交易或指标吗？请在自由职业者服务中订购  [进入自由职业者服务](/zh/job/new "进入自由职业者服务")

## **每日 VWAP：您必不可少的日内公允价值指标**

**每日成交量加权平均价（Daily VWAP）** 是一种精确编码的定制指标，旨在为交易者提供日内分析的重要依据：每日重置的成交量加权平均价。与传统的移动平均线不同，VWAP 将交易量纳入计算，使交易活动较多的价格具有更大的权重。这使得它成为衡量资产在整个交易日中真实公允价值的一个非常有价值的工具。

该指标从每个新交易时段开始，计算（价格 * 成交量）除以每天累计成交量的累计和。它直接在图表上绘制出一条平滑的线，让您很容易就能直观地看到今天大部分交易量相对于价格的位置。

**为什么使用每日 VWAP？**

  * **确定日内公允价值：** 了解资产根据成交量调整后的平均交易价格，为看涨或看跌情绪提供明确基准。

  * **战略性进出场点：** 许多机构交易者将 VWAP 作为关键参考点。交易价格高于 VWAP 表明看涨情绪，而价格低于 VWAP 则表明看跌控制。这为潜在的进场和出场策略提供了宝贵的见解。

  * **趋势确认：** 使用 VWAP 来确认日内趋势的强度。强劲的趋势通常会使价格维持在 VWAP 的相对位置。

  * **简单明了：** 尽管计算很复杂，但每日 VWAP 在图表上只显示一条清晰的线，使您的分析简洁明了、重点突出。




**本源代码的功能：**

  * **每日重置：** 在每个新交易日开始时，VWAP 计算会自动重置，为每日市场活动提供全新视角。

  * **稳健计算：** 利用标准 MQL5 函数精确计算典型价格和交易量。

  * **简洁的绘图：** 在图表上显示明显的蓝线，便于识别。

  * **开源：** 提供完整的 MQL5 源代码，允许完全透明、学习和社区进一步定制。




![BTCUSD 的 VWAP（M15）](https://c.mql5.com/18/164/BTCUSDM15_-_VWAP_21o.png)  


  


由MetaQuotes Ltd译自英文  
原代码： [https://www.mql5.com/en/code/61090](/en/code/61090)

![Weekly VWAP](https://c.mql5.com/i/code/indicator.png) [Weekly VWAP](/zh/code/61091)

每周 VWAP（成交量加权平均价）是一个功能强大的 MQL5 指标，用于计算和显示每个交易周的成交量加权平均价。它是确定每周公允价值和了解较长时间框架内潜在情绪的重要工具。

![Monthly VWAP](https://c.mql5.com/i/code/indicator.png) [Monthly VWAP](/zh/code/61098)

月度 VWAP（成交量加权平均价）是一个重要的 MQL5 指标，用于计算和显示每个交易月的成交量加权平均价。它是了解长期市场情绪、识别关键月度公允价值以及为战略决策提供信息的强大工具。

![Trend Equilibrium Indicator TrendEQ](https://c.mql5.com/i/code/indicator.png) [Trend Equilibrium Indicator TrendEQ](/zh/code/54846)

趋势平衡指标 TrendEQ 结合动量和波动性动态分析市场走势。TrendEQ 将动量与市场波动性进行缩放，为趋势强度和方向提供了可靠的衡量标准。

![AutoTrendLines Indicator for MQL5](https://c.mql5.com/i/code/indicator.png) [AutoTrendLines Indicator for MQL5](/zh/code/61217)

AutoTrendLines 指标可在 MetaTrader 5 图表上自动绘制支撑和阻力趋势线。它使用两种方法确定关键价位：两个极值（类型 1）或极值和 Delta（类型 2）。只有在形成新的条形图时，才会重新计算趋势线，确保高效运行。
