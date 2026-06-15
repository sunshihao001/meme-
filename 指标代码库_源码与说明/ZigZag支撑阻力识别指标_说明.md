# ZigZag支撑阻力识别指标

> 本地文档目标名：ZigZag支撑阻力识别指标
> 来源标题：在MQL5代码库免费下载MetaTrader 5的'ZigZag Support and Resistance Detection' ('protimetrader')指标, 2026.04.23
> 来源链接：https://www.mql5.com/zh/code/60339
> 下载时间：2026-06-12 23:16:44
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
因此发布一个[链接](/zh/code/60339) -  
让其他人评价 

__

喜欢这个脚本？ 在[MetaTrader 5](https://download.terminal.free/cdn/web/metaquotes.ltd/mt5/mt5setup.exe?utm_source=www.mql5.com&utm_campaign=download)客户端尝试它 

到包裹

![指标](https://c.mql5.com/i/code/indicator.png)

# ZigZag Support and Resistance Detection - MetaTrader 5脚本

[Tshidiso Ephraim Mpakanyane](/zh/users/protimetrader)

![Tshidiso Ephraim Mpakanyane](https://c.mql5.com/avatar/2026/2/69955d55-e0e8.png)

####  [Tshidiso Ephraim Mpakanyane](/zh/users/protimetrader)

__

  * __[南非](https://www.mql5.com/go?https://maps.google.com/?z=4&q=%e5%8d%97%e9%9d%9e "实时")
  * __[4174](/zh/users/protimetrader/achievements "等级")



**4.7** (21)




[ 5 产品 ](/zh/users/protimetrader/seller) [ 4 代码 ](/zh/users/protimetrader/publications) [ 1 主题 ](/zh/users/protimetrader/publications) [ 2 评论 ](/zh/users/protimetrader/publications/all)

|  [Chinese __](javascript:void\(false\);) [English](/en/code/60339) [Русский](/ru/code/60339) [Español](/es/code/60339) [Deutsch](/de/code/60339) [日本語](/ja/code/60339) [Português](/pt/code/60339) [한국어](/ko/code/60339) [Français](/fr/code/60339) [Italiano](/it/code/60339) [Türkçe](/tr/code/60339)

显示: 
    528
等级: 
    

(9)
已发布: 
    23 四月 2026, 14:09
已更新: 
    24 五月 2026, 14:17
    

[__ZigZagSNRDetection.mq5](/zh/code/download/60339/ZigZagSNRDetection.mq5 "ZigZagSNRDetection.mq5") (26.54 KB) 预览

__[__下载ZIP](/zh/code/download/60339.zip "下载单独ZIP文档中的全部附件") [__在MetaEditor如何使用下载的代码](https://www.metatrader5.com/zh/metaeditor/help/workspace/toolbox#codebase)

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

  * 使用 ZigZag 支点检测关键支撑位和阻力位。
  * 识别最高和最低极值以计算水平。  

  * 可选择显示收盘和开盘水平，用于历史分析。
  * 可调整的 ZigZag 参数：深度、偏差和回踩。
  * 交互式标签显示水平类型和时间框架。
  * 适用于所有标准 MetaTrader 符号和从日内到日间的时间框架。



  


**参数：**

参数名称 | 说明  
---|---  
输入回溯 | 为水平检测进行分析的总条数。  
  
输入深度 | 用于识别枢轴的 ZigZag 深度参数。  
  
输入偏差 | 用于过滤微小价格波动的 ZigZag 偏差。  
  
输入后退步长 | ZigZag 回踩参数，用于避免错误的枢轴点。  
  
InpDrawClosed | 显示已突破的水平。  
  
InpDrawZigZag | 在图表上显示之字形线。  
  
输入绘制标签 | 显示每个级别的文本标签。  
  
  
  


**如何使用**

简单的分步指南：

  1. 将指标附加到所选符号和时间框架的图表上。
  2. 调整 ZigZag（之字形）参数（深度、偏差、后步），以适应您的分析风格。
  3. 选择是否显示封闭水平、ZigZag 线和标签。
  4. 指标将显示支撑位和阻力位，并突出显示枢轴群。
  5. 观察图表中多个水平线汇聚的区域，以确定潜在的关注区域。



  


了解支撑位和阻力位：

  * 支撑位由低中枢绘制，阻力位由高中枢绘制。
  * 开放水平延伸至当前条形图，而封闭水平已被打破。
  * 标签表示水平类型（S 表示支撑位，R 表示阻力位）和图表时间框架。



  


**屏幕截图：**

![](https://c.mql5.com/18/178/BTCUSDM1.png)  


  


**结论：**

ZigZag SNR Detection 提供了支撑位和阻力位的结构化视图。它有助于分析价格行为，同时保持市场结构的可视化展示。

由MetaQuotes Ltd译自英文  
原代码： [https://www.mql5.com/en/code/60339](/en/code/60339)

![To Close All Open Trades of Different Symbols](https://c.mql5.com/i/code/library.png) [To Close All Open Trades of Different Symbols](/zh/code/70966)

技术细节 使用带有 TRADE_ACTION_DEAL 的 MQL5 OrderSend，以当前买入价/卖出价即时关闭市场。包括滑点容差（10 点）、适当的成交量匹配和神奇数字保存。通过仓位向后循环，防止执行过程中的指数移动。

![Liquidity Sweep H4 - M15 \(Swing Highs and Lows\) / MQL5](https://c.mql5.com/i/code/expert.png) [Liquidity Sweep H4 - M15 (Swing Highs and Lows) / MQL5](/zh/code/68951)

该智能交易系统（EA）旨在检测 H4 时间框架上的波段高点和低点，然后等待 M15 时间框架上的扫描（流动性抓取），以触发具有明确风险管理的买入/卖出交易。

![计算地块百分比](https://c.mql5.com/i/code/library.png) [计算地块百分比](/zh/code/71010)

根据存款百分比计算批量的功能

![ICT True Open and Power of 3 \(PO3\) Lines](https://c.mql5.com/i/code/indicator.png) [ICT True Open and Power of 3 (PO3) Lines](/zh/code/71047)

ICT 和 SMC 交易员必备的轻量级实用工具。它能自动绘制真实的每日、每周和每月开盘价，为 3 力量（积累、操纵、分配）概念奠定基础。
