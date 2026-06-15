# 市场轮廓MarketProfile指标

> 本地文档目标名：市场轮廓MarketProfile指标
> 来源标题：在MQL5代码库免费下载MetaTrader 5的'Market Profile MT5' ('nguyenvantuan')指标, 2025.07.16
> 来源链接：https://www.mql5.com/zh/code/55396
> 下载时间：2026-06-12 23:16:37
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

请在[Facebook](https://www.facebook.com/mql5.community/)上找到我们！  
加入我们粉丝页

__

有趣的脚本？  
因此发布一个[链接](/zh/code/55396) -  
让其他人评价 

__

喜欢这个脚本？ 在[MetaTrader 5](https://download.terminal.free/cdn/web/metaquotes.ltd/mt5/mt5setup.exe?utm_source=www.mql5.com&utm_campaign=download)客户端尝试它 

到包裹

![指标](https://c.mql5.com/i/code/indicator.png)

# Market Profile MT5 - MetaTrader 5脚本

[删除] |  [Chinese __](javascript:void\(false\);) [English](/en/code/55396) [Русский](/ru/code/55396) [Español](/es/code/55396) [Deutsch](/de/code/55396) [日本語](/ja/code/55396) [Português](/pt/code/55396) [한국어](/ko/code/55396) [Français](/fr/code/55396) [Italiano](/it/code/55396) [Türkçe](/tr/code/55396)

显示: 
    788
等级: 
    

(8)
已发布: 
    16 七月 2025, 12:15
    

[__MarketProfile.mq5](/zh/code/download/55396/marketprofile.mq5 "MarketProfile.mq5") (172 KB) 预览

__[__下载ZIP](/zh/code/download/55396.zip "下载单独ZIP文档中的全部附件") [__在MetaEditor如何使用下载的代码](https://www.metatrader5.com/zh/metaeditor/help/workspace/toolbox#codebase)

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

**Market Profile MetaTrader 指标** \- 是一个经典的 Market Profile 实施工具，可显示一段时间内的价格密度，勾勒出特定交易时段内最重要的价格水平、价值区域和控制值。该指标可连接到 M1 和 D1 之间的时间框架，并显示日、周、月甚至日内交易时段的市场概况。较低的时间框架精度更高。建议使用较高的时间框架，以获得更好的可视性。也可以使用自由绘制矩形时段，在任何时间框架上创建自定义市场概况。有六种不同的配色方案可用于绘制剖面图块。也可以将剖面图绘制成纯色柱状图。您也可以选择根据看涨/看跌柱状图为剖面图着色。该指标基于裸价格行为，不使用任何标准指标。适用于 MetaTrader 4 和 MetaTrader 5。

  


## 输入参数

### 主要

  * **时段** （  默认 = 每日）- 市场概况的交易时段：每日、每周、每月、日内和矩形。要计算矩形时段， 应  在图表中添加名称以 _MPR_ 开头的矩形图表对象。按键盘上的 "r "键将自动添加一个名称正确的矩形对象。
  * **StartFromDate** （  默认 =__DATE__）- 如果**StartFromCurrentSession** 为 _false_ ，那么指标将从该日期开始绘制剖面图。它会绘制到过去。例如，如果设置为 2018-01-20，且**SessionsToCount** 为  2，那么它将绘制 2018-01-20 和 2018-01-19 的剖面图。
  * **StartFromCurrentSession** （  默认为 true）- 如果 _为 true_ ，则指标从今天开始绘制，否则从**StartFromDate** 中指定的日期开始绘制。
  * **SessionsToCount** （  默认 = 2）--绘制市场剖面图的交易时段数。
  * **SeamlessScrollingMode** （ **无缝滚动模式** ）（默认 = false）- 如果 _为 "true_ "，则忽略**StartFromDate（从日期** 开始） 和 **StartFromCurrentSession（从** 当前会话开始） 参数 ；会话从当前图表位置最右边的柱形开始计算和显示。这样就可以无限向后滚动，查看过去的会话。
  * **EnableDevelopingPOC** （  默认 = false）- 如果 _为 "true_ "，将绘制多条水平线来描述控制点在会话中的发展情况。
  * **EnableDevelopingVAHVAL** （  默认值 = false）-- 如果 _为 "_ true"，则将绘制多条水平线来描述 "高值区 "和 "低值区 "在会话中的发展情况。
  * **ValueAreaPercentage** （ **价值区域** 百分比）（默认值 = 70）- 包含在价值区域中的会话 TPO 的百分比份额。



![](https://c.mql5.com/18/158/MarketProfile__1.png)  


  


  


由MetaQuotes Ltd译自英文  
原代码： [https://www.mql5.com/en/code/55396](/en/code/55396)

![Moving Average Candlesticks MT5](https://c.mql5.com/i/code/indicator.png) [Moving Average Candlesticks MT5](/zh/code/55398)

移动平均线烛台 MetaTrader 指标 - 使用烛台条形图显示标准移动平均线。它根据收盘价、开盘价、最低价和最高价计算出的移动平均值绘制烛台。与传统的 MA 指标相比，它能以紧凑的快照方式显示更详细的市场信息。它适用于任何货币对、时间框架和 MA 模式。该指标适用于 MT4 和 MT5。

![Murrey Math Line X MT5](https://c.mql5.com/i/code/indicator.png) [Murrey Math Line X MT5](/zh/code/55400)

Murrey Math Line X MetaTrader 指标--这是一个枢轴线指标，对于懂得如何利用支撑线、阻力线和枢轴线进行交易的每一位交易者来说，它绝对会有所帮助。它在主图上显示 8 条主要线（另有 5 条附加线），帮助您找到卖出、买入和离场的最佳点位。当蜡烛突破任何一条枢轴线后收盘，该指标就会发出警报。您可以在 MT4 和 MT5 平台上下载该指标。

![Moving Average based on Heiken-Ashi](https://c.mql5.com/i/code/indicator.png) [Moving Average based on Heiken-Ashi](/zh/code/60537)

这是一个基于 Heiken-Ashi 蜡烛而非原始市场价格的移动平均线指标。

![Laguerre MT5](https://c.mql5.com/i/code/indicator.png) [Laguerre MT5](/zh/code/55394)

Laguerre MetaTrader 指标 - 完全自定义指标，不依赖 MT4/MT5 标准指标。它在图表的单独窗口中显示加权趋势线。可用于发出简单的进场和出场信号。该指标适用于 MT4 和 MT5。
