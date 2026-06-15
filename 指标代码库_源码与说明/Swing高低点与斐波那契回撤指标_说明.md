# Swing高低点与斐波那契回撤指标

> 本地文档目标名：Swing高低点与斐波那契回撤指标
> 来源标题：在MQL5代码库免费下载MetaTrader 5的'Swing High Low and Fibonacci Retracement Indicator' ('hmhieu')指标, 2025.09.29
> 来源链接：https://www.mql5.com/zh/code/52000
> 下载时间：2026-06-12 23:16:43
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
因此发布一个[链接](/zh/code/52000) -  
让其他人评价 

__

喜欢这个脚本？ 在[MetaTrader 5](https://download.terminal.free/cdn/web/metaquotes.ltd/mt5/mt5setup.exe?utm_source=www.mql5.com&utm_campaign=download)客户端尝试它 

到包裹

![指标](https://c.mql5.com/i/code/indicator.png)

# Swing High Low and Fibonacci Retracement Indicator - MetaTrader 5脚本

[Minh Hieu Hoang](/zh/users/hmhieu)

![Minh Hieu Hoang](https://c.mql5.com/avatar/2024/9/66dd3a9d-d376.jpg)

####  [Minh Hieu Hoang](/zh/users/hmhieu)

__

  * __[越南](https://www.mql5.com/go?https://maps.google.com/?z=4&q=%e8%b6%8a%e5%8d%97 "实时")
  * __[4317](/zh/users/hmhieu/achievements "等级")



**5** (31)




I am a programmer specializing in developing automated trading bots. If you are in need of a custom trading bot, feel free to reach out.   
Don’t hesitate to contact me via email at hieuhoangcntt@gmail.com.

[ 3 代码 ](/zh/users/hmhieu/publications) [ 5 评论 ](/zh/users/hmhieu/publications/all)

|  [Chinese __](javascript:void\(false\);) [English](/en/code/52000) [Русский](/ru/code/52000) [Español](/es/code/52000) [Deutsch](/de/code/52000) [日本語](/ja/code/52000) [Português](/pt/code/52000) [한국어](/ko/code/52000) [Français](/fr/code/52000) [Italiano](/it/code/52000) [Türkçe](/tr/code/52000)

显示: 
    827
等级: 
    

(13)
已发布: 
    29 九月 2025, 12:55
    

[__SwingHighLow_and_Fibonacci.mq5](/zh/code/download/52000/swinghighlow_and_fibonacci.mq5 "SwingHighLow_and_Fibonacci.mq5") (5.61 KB) 预览

__[__下载ZIP](/zh/code/download/52000.zip "下载单独ZIP文档中的全部附件") [__在MetaEditor如何使用下载的代码](https://www.metatrader5.com/zh/metaeditor/help/workspace/toolbox#codebase)

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

这是一个演示版本。

如果您想创建自己的交易机器人，并与该指标集成，请与我联系。

我将帮助您创建专为您量身定制的优化交易机器人。

  


[ ![斐波那契](https://c.mql5.com/18/168/EURUSDH1__19.png)](https://c.mql5.com/18/168/EURUSDH1__18.png "https://c.mql5.com/18/156/EURUSDH1.png")   


由MetaQuotes Ltd译自英文  
原代码： [https://www.mql5.com/en/code/52000](/en/code/52000)

![2-Pair Correlation EA](https://c.mql5.com/i/code/expert.png) [2-Pair Correlation EA](/zh/code/52043)

2-Pair Correlation EA 是一款免费的智能交易系统，可利用 BTC/USD 和 ETH/USD 的价格相关性进行交易。该 EA 在货币对出现分歧时开启交易，并在货币对重新对齐时关闭交易，以最小的工作量实现自动交易。

![价格变量](https://c.mql5.com/i/code/indicator.png) [价格变量](/zh/code/63139)

PriceVar% 是一个指标，用于衡量价格与移动平均线之间的百分比差，突出显示市场走势相对于参考值的强度。

![Engulfing Indicator](https://c.mql5.com/i/code/indicator.png) [Engulfing Indicator](/zh/code/51974)

这是一个有助于识别吞没蜡烛形态的指标。

![量子金银交易商](https://c.mql5.com/i/code/expert.png) [量子金银交易商](/zh/code/63193)

量子系统 - 利用量子态和概率做出决策。
