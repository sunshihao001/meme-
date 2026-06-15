# 多日动态VWAP指标

> 本地文档目标名：多日动态VWAP指标
> 来源标题：在MQL5代码库免费下载MetaTrader 5的'Multi-Day Dynamic VWAP' ('phade')指标, 2025.06.07
> 来源链接：https://www.mql5.com/zh/code/59157
> 下载时间：2026-06-12 23:16:40
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
因此发布一个[链接](/zh/code/59157) -  
让其他人评价 

__

喜欢这个脚本？ 在[MetaTrader 5](https://download.terminal.free/cdn/web/metaquotes.ltd/mt5/mt5setup.exe?utm_source=www.mql5.com&utm_campaign=download)客户端尝试它 

到包裹

![指标](https://c.mql5.com/i/code/indicator.png)

# Multi-Day Dynamic VWAP - MetaTrader 5脚本

[Conor Mcnamara](/zh/users/phade)

![Conor Mcnamara](https://c.mql5.com/avatar/2025/9/68dab3ec-4506.png)

####  [Conor Mcnamara](/zh/users/phade)

  * __[爱尔兰](https://www.mql5.com/go?https://maps.google.com/?z=4&q=%e7%88%b1%e5%b0%94%e5%85%b0 "实时")
  * __[11460](/zh/users/phade/achievements "等级")



**5** (4)




I started learning C programming in 2010. From there I picked up many languages.   
I'm working on several indicator projects and EA concepts.

[ 7 产品 ](/zh/users/phade/seller) [ 47 代码 ](/zh/users/phade/publications) [ 47 主题 ](/zh/users/phade/publications) [ 1464 评论 ](/zh/users/phade/publications/all)

|  [Chinese __](javascript:void\(false\);) [English](/en/code/59157) [Русский](/ru/code/59157) [Español](/es/code/59157) [Deutsch](/de/code/59157) [日本語](/ja/code/59157) [Português](/pt/code/59157) [한국어](/ko/code/59157) [Français](/fr/code/59157) [Italiano](/it/code/59157) [Türkçe](/tr/code/59157)

显示: 
    1234
等级: 
    

(5)
已发布: 
    7 六月 2025, 11:53
    

[__Multi-Day Dynamic VWAP.mq5](/zh/code/download/59157/multi-day_dynamic_vwap.mq5 "Multi-Day Dynamic VWAP.mq5") (15.25 KB) 预览

__[__下载ZIP](/zh/code/download/59157.zip "下载单独ZIP文档中的全部附件") [__在MetaEditor如何使用下载的代码](https://www.metatrader5.com/zh/metaeditor/help/workspace/toolbox#codebase)

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

该指标动态绘制**多日 VWAP（成交量加权平均价）** 水平，默认情况下从日时间框架开始（时间框架可在输入中完全自定义）。由于它可以计算多日（或多条）的 VWAP，因此类似于锚定 VWAP。它在识别**关键支撑/阻力位** 、**趋势确认** 和**均值回归信号** 方面功能强大。除了动态更新的 VWAP 水平外，市场收盘价与 heiken ashi 趋势一起绘制，有助于直观地显示看跌和看涨趋势。 

VWAP 表示选定时间段内**按成交量加权的平均价格** 。与简单平均数不同的是，它能告诉你 _大部分成交量在哪里交易_ ，这对机构来说是一个至关重要的基准。

在使用 VWAP 寻找  信号时，理想的做法是观察市场价格如何从 VWAP 价格出发，而不是直接在 VWAP 价格买入。

**趋势支撑/阻力：**

  * **下降趋势：** **当当前价格低于 VWAP 时，** VWAP 成为**阻力** 。  
_价格低于 VWAP = 卖家控制了市场。_
  * **上升趋势：** **当当前价格高于 VWAP 时，** VWAP 起**支撑** 作用。  
_价格高于 VWAP = 买方占优。_



**动量：**

在使用 VWAP 寻找交易信号时，关注**价格如何 _远离_ VWAP 水平**，而不是直接在**VWAP 水平** 进场，会更有洞察力。 

  * 如果价格向趋势方向**强烈偏离** VWAP，则通常预示着**动量持续** 或**强烈的方向性倾向** 。 
  * 这种变动表明，**市场参与者正在投入资本** ，并改变了所认为的价值，从而揭示了一个潜在的高定罪机会。



**突破信号：**

  * **看涨突破：**  
如果价格**突破** VWAP，这是一个**潜在的买入信号，表明** 买方正在控制市场。 
  * **看跌突破：**  
如果价格**跌破** VWAP，则表明卖方占据主导地位，是**潜在** 的**卖出机会** 。



**横盘市场的均值回归：**

  * 在**横盘或盘整的市场** 中，价格往往会**回撤到 VWAP** 。 
  * 这提供了高概率的反趋势交易和均值回归设置。



  


[ ![动态 VWAP 水平](https://c.mql5.com/18/162/VWAP__1.PNG)](https://c.mql5.com/18/162/VWAP.PNG "https://c.mql5.com/18/162/VWAP.PNG")  


  


由MetaQuotes Ltd译自英文  
原代码： [https://www.mql5.com/en/code/59157](/en/code/59157)

![Creating a Simple News Filter for XAUUSD Trading on MT5](https://c.mql5.com/i/code/script.png) [Creating a Simple News Filter for XAUUSD Trading on MT5](/zh/code/59130)

XAUUSD（黄金）交易经常受到美元、英镑或欧元发布等重大经济新闻事件的影响。要在这些动荡时期降低风险，在您的智能交易系统 (EA) 中使用新闻过滤器至关重要。在本文中，我将分享如何在 MT5 上创建一个简单的新闻过滤器，并将其应用于 XAUUSD 交易。

![阿尔法趋势](https://c.mql5.com/i/code/indicator.png) [阿尔法趋势](/zh/code/54459)

这是一个用于确定市场趋势、支撑和阻力水平的指标。 如果有成交量数据，则使用 MFI 计算，如果没有，则使用 RSI 计算。 势头：RSI 和 MFI 波动率：ATR

![T3 Moving Average](https://c.mql5.com/i/code/indicator.png) [T3 Moving Average](/zh/code/56927)

T3 指标是一种先进的移动平均线，它结合了六条指数移动平均线，与传统移动平均线相比，能提供更平滑的价格走势，减少滞后性。

![每日趋势](https://c.mql5.com/i/code/indicator.png) [每日趋势](/zh/code/56909)

该指标可在任何图表时间显示当日趋势。您可以自定义文字在屏幕上的颜色和位置。
