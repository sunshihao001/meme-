# 成交量分布VolumeProfile指标

> 本地文档目标名：成交量分布VolumeProfile指标
> 来源标题：在MQL5代码库免费下载MetaTrader 5的'Volume Profile' ('baset84')指标, 2025.12.30
> 来源链接：https://www.mql5.com/zh/code/47784
> 下载时间：2026-06-12 23:16:36
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
因此发布一个[链接](/zh/code/47784) -  
让其他人评价 

__

喜欢这个脚本？ 在[MetaTrader 5](https://download.terminal.free/cdn/web/metaquotes.ltd/mt5/mt5setup.exe?utm_source=www.mql5.com&utm_campaign=download)客户端尝试它 

到包裹

![指标](https://c.mql5.com/i/code/indicator.png)

# Volume Profile - MetaTrader 5脚本

[Mohammad Baset](/zh/users/baset84)

![Mohammad Baset](https://c.mql5.com/avatar/2024/1/65930fb1-5225.jpg)

####  [Mohammad Baset](/zh/users/baset84)

  * __[伊朗](https://www.mql5.com/go?https://maps.google.com/?z=4&q=%e4%bc%8a%e6%9c%97 "实时")
  * __[1514](/zh/users/baset84/achievements "等级")






[ 1 代码 ](/zh/users/baset84/publications) [ 6 评论 ](/zh/users/baset84/publications/all)

|  [Chinese __](javascript:void\(false\);) [English](/en/code/47784) [Русский](/ru/code/47784) [Español](/es/code/47784) [Deutsch](/de/code/47784) [日本語](/ja/code/47784) [Português](/pt/code/47784) [한국어](/ko/code/47784) [Français](/fr/code/47784) [Italiano](/it/code/47784) [Türkçe](/tr/code/47784)

显示: 
    883
等级: 
    

(25)
已发布: 
    30 十二月 2025, 13:43
已更新: 
    29 一月 2026, 13:50
    

[__Volume Profile.mq5](/zh/code/download/47784/volume_profile.mq5 "Volume Profile.mq5") (15.55 KB) 预览

__[__下载ZIP](/zh/code/download/47784.zip "下载单独ZIP文档中的全部附件") [__在MetaEditor如何使用下载的代码](https://www.metatrader5.com/zh/metaeditor/help/workspace/toolbox#codebase)

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

### 什么是成交量曲线？  


交易量曲线工具又称水平交易量，使用水平柱状图显示特定时间范围内每个价格的交易量。较长的柱状图表示该价格的交易量较大，而较短的柱状图则表示交易活动较少。该指标的计算方法简单，可实现高速、轻量级执行。

### 如何使用  


要显示特定时间间隔内的交易量概况，可将执行指标后出现的两条垂直线分别放在该时间间隔的开始和结束处。调整这些线将根据所选时间间隔改变成交量曲线。

  


![示例截图](https://c.mql5.com/18/176/XAUUSDDaily__5.png)  


**示例截图**

### 输入设置  


  * **计算时间框架** ：该指标的计算假设是，交易量在整个蜡烛长度内（从低点到高点）均匀分布，这可能会导致结果不够准确，尤其是在使用较小的时间范围时（见图 1）。通过更改输入部分的这一选项，可以基于较低的时间范围（如 1 分钟）进行计算，从而获得与使用刻度线数据计算几乎相当的精确结果（见图 2）。
  * **VP 条数** ：柱状图条数，较小的数字表示发生最多交易的**价格范围** ，较大的数字表示发生最多交易的**确切价格** 。更改此输入值时，控制点 (POC) 的位置可能会移动，但这不是因为计算错误或代码错误，而是因为您在寻找不同的东西。
  * **应用体积** ：默认应用成交量为实际成交量。但是，如果在输入中选择 "tick_volume"，或者服务器上没有实际成交量数据，指标将使用刻度线成交量数据。



  * **最大 VP 柱长度与图表宽度比** ：您可以调整 VP 柱的长度与图表宽度的比率。



###   


![图 1（当前时间框架）](https://c.mql5.com/18/176/current_tf__4.png)

**图 1：基于当前时间框架的计算**

  


![图 2（1 分钟时限）](https://c.mql5.com/18/176/1minute_tf__4.png)

**图 2：基于 1 分钟时间框架的计算**

### 注意事项  


使用较低的时间框架进行计算时，指标需要该时间框架的价格数据，而这些数据可能尚未下载。下载可能需要一些时间，因此请耐心拖放垂直线，直到下载完成！

我希望它能帮助你成功交易，并通过评论代码中的错误让我感到高兴！




由MetaQuotes Ltd译自英文  
原代码： [https://www.mql5.com/en/code/47784](/en/code/47784)

![Cosine distance and cosine similarity](https://c.mql5.com/i/code/library.png) [Cosine distance and cosine similarity](/zh/code/47793)

计算两个向量之间的余弦距离和相似度。 余弦距离为 1-余弦相似度，余弦相似度为两个向量大小相乘的点积。

![Connect Disconnect Sound Alert](https://c.mql5.com/i/code/expert.png) [Connect Disconnect Sound Alert](/zh/code/47846)

本实用程序是在连接/断开时添加声音提示的简单示例

![键盘操盘手 \(KeyTrader Pro\)](https://c.mql5.com/i/code/expert.png) [键盘操盘手 (KeyTrader Pro)](/zh/code/67766)

告别繁琐计算，D键做多，J键做空。集成了自动风控计算与HUD面板的终极键盘交易工具。 英文：Stop calculating, start trading. The ultimate keyboard trading tool with auto risk management and HUD.

![COLLECT ALL INDICATORS DATA](https://c.mql5.com/i/code/script.png) [COLLECT ALL INDICATORS DATA](/zh/code/47755)

该脚本收集所有 MQL5 内置指标缓冲区，并将其存储到 CSV 文件中，以用于分析。
