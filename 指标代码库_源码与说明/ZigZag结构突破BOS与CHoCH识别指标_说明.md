# ZigZag结构突破BOS与CHoCH识别指标

> 本地文档目标名：ZigZag结构突破BOS与CHoCH识别指标
> 来源标题：在MQL5代码库免费下载MetaTrader 5的'ZigZag BOS CHoCH Detection' ('protimetrader')指标, 2026.03.17
> 来源链接：https://www.mql5.com/zh/code/65980
> 下载时间：2026-06-12 23:16:45
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
因此发布一个[链接](/zh/code/65980) -  
让其他人评价 

__

喜欢这个脚本？ 在[MetaTrader 5](https://download.terminal.free/cdn/web/metaquotes.ltd/mt5/mt5setup.exe?utm_source=www.mql5.com&utm_campaign=download)客户端尝试它 

到包裹

![指标](https://c.mql5.com/i/code/indicator.png)

# ZigZag BOS CHoCH Detection - MetaTrader 5脚本

[Tshidiso Ephraim Mpakanyane](/zh/users/protimetrader)

![Tshidiso Ephraim Mpakanyane](https://c.mql5.com/avatar/2026/2/69955d55-e0e8.png)

####  [Tshidiso Ephraim Mpakanyane](/zh/users/protimetrader)

__

  * __[南非](https://www.mql5.com/go?https://maps.google.com/?z=4&q=%e5%8d%97%e9%9d%9e "实时")
  * __[4174](/zh/users/protimetrader/achievements "等级")



**4.7** (21)




[ 5 产品 ](/zh/users/protimetrader/seller) [ 4 代码 ](/zh/users/protimetrader/publications) [ 1 主题 ](/zh/users/protimetrader/publications) [ 2 评论 ](/zh/users/protimetrader/publications/all)

|  [Chinese __](javascript:void\(false\);) [English](/en/code/65980) [Русский](/ru/code/65980) [Español](/es/code/65980) [Deutsch](/de/code/65980) [日本語](/ja/code/65980) [Português](/pt/code/65980) [한국어](/ko/code/65980) [Français](/fr/code/65980) [Italiano](/it/code/65980) [Türkçe](/tr/code/65980)

显示: 
    580
等级: 
    

(4)
已发布: 
    17 三月 2026, 13:59
已更新: 
    16 四月 2026, 14:07
    

[__ZigZagBOSCHoCH.mq5](/zh/code/download/65980/ZigZagBOSCHoCH.mq5 "ZigZagBOSCHoCH.mq5") (20.16 KB) 预览

__[__下载ZIP](/zh/code/download/65980.zip "下载单独ZIP文档中的全部附件") [__在MetaEditor如何使用下载的代码](https://www.metatrader5.com/zh/metaeditor/help/workspace/toolbox#codebase)

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

**功能特点**

  * 使用标准 MQL5**之字形** 方法进行**经典之字形摆动检测** （深度/偏差/后退）。
  * **自动枢轴跟踪** （内部存储最近的摆动点，用于结构分析）。
  * **结构中断 (BOS)** 检测： 
    * 标记同一结构方向上的延续中断。
    * 绘制水平水平线并标记为 "BOS"。
  * **字符变化 (CHoCH)** 检测： 
    * 标记与之前结构方向相反的第一个断点。
    * 绘制水平线并标记为 "CHOCH"。
  * **清洁图表对象** ： 
    * 线条和标签直接绘制在图表上，清晰可见。
    * 在新条形图上更新，避免不必要的重绘。



  


**参数：**

参数名称 | 说明  
---|---  
输入回溯 | 在收集最近的 ZigZag 支点以进行结构检测时，要扫描多少个条形图。  
输入深度 | ZigZag 深度（标准 MQL5 ZigZag 参数）。  
输入偏差 | 以点为单位的 ZigZag 偏差（标准 MQL5 ZigZag 参数）。  
输入后退步长 | ZigZag 后退步长（标准 MQL5 ZigZag 参数）。  
  
  


  


**注意事项和限制：**

  * **ZigZag 重绘：** 与所有基于 ZigZag 的工具一样，摆动点可以更新，直到确认一条腿。BOS/CHoCH 水平可能会相应移动。
  * **基于收盘价的确认：** 突破检测使用相对于相关摆动水平的蜡烛收盘进行评估。
  * **图表对象：** BOS/CHoCH 水平使用图表对象（线条 + 文本标签）绘制。
  * **性能：** 回溯值过大可能会降低较慢设备或低时间框架的性能。



  


**截图：**

![](https://c.mql5.com/18/176/Screenshot_1.png)  


  


**结论：**

该指标将**标准 MQL5 ZigZag 的** 可靠性与清晰的**BOS/CHoCH** 市场结构标签相结合。对于希望直接在图表上确认波段结构的交易者来说，这是一款轻量级可视化工具。

由MetaQuotes Ltd译自英文  
原代码： [https://www.mql5.com/en/code/65980](/en/code/65980)

![Trend based on WPR](https://c.mql5.com/i/code/indicator.png) [Trend based on WPR](/zh/code/69380)

该指标结合了 WPR 和总损益。我不知道如何详细介绍这个指标，但您可以试试。

![Multi-timeframe RSI scanner with visual dashboard and alerts](https://c.mql5.com/i/code/indicator.png) [Multi-timeframe RSI scanner with visual dashboard and alerts](/zh/code/69317)

可用于生产的多时间框架 RSI 扫描仪，带有智能警报重试系统。可同时监控多达 7 个时间框架，在 3 个以上 TFs 一致时突出显示收敛区，现在还能自动重试失败通知，确保你不会错过关键的超买/超卖设置。

![WPR With TPSL](https://c.mql5.com/i/code/indicator.png) [WPR With TPSL](/zh/code/69480)

图表窗口中的 WPR 指标与 TPSL

![VR Rsi Robot - 多时间框架交易策略](https://c.mql5.com/i/code/expert.png) [VR Rsi Robot - 多时间框架交易策略](/zh/code/70465)

仅有两个时间框架 — H1 和 D1 — 同步工作，以过滤掉市场噪音，只捕捉RSI从超买和超卖区域发出的强力反转信号。没有随机入场，只有来自“老大哥”的明确方向确认。
