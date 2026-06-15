# ZigZag自动斐波那契指标

> 本地文档目标名：ZigZag自动斐波那契指标
> 来源标题：在MQL5代码库免费下载MetaTrader 5的'ZigZag auto Fibo' ('livioalves')指标, 2025.10.17
> 来源链接：https://www.mql5.com/zh/code/50652
> 下载时间：2026-06-12 23:16:42
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
因此发布一个[链接](/zh/code/50652) -  
让其他人评价 

__

喜欢这个脚本？ 在[MetaTrader 5](https://download.terminal.free/cdn/web/metaquotes.ltd/mt5/mt5setup.exe?utm_source=www.mql5.com&utm_campaign=download)客户端尝试它 

到包裹

![指标](https://c.mql5.com/i/code/indicator.png)

# ZigZag auto Fibo - MetaTrader 5脚本

[Livio Alves](/zh/users/livioalves)

![Livio Alves](https://c.mql5.com/avatar/2024/9/66f6e96c-8d25.png)

####  [Livio Alves](/zh/users/livioalves)

  * __[巴西](https://www.mql5.com/go?https://maps.google.com/?z=4&q=%e5%b7%b4%e8%a5%bf "实时")
  * __[1594](/zh/users/livioalves/achievements "等级")






[ 5 代码 ](/zh/users/livioalves/publications) [ 10 评论 ](/zh/users/livioalves/publications/all)

|  [Chinese __](javascript:void\(false\);) [English](/en/code/50652) [Русский](/ru/code/50652) [Español](/es/code/50652) [Deutsch](/de/code/50652) [日本語](/ja/code/50652) [Português](/pt/code/50652) [한국어](/ko/code/50652) [Français](/fr/code/50652) [Italiano](/it/code/50652) [Türkçe](/tr/code/50652)

显示: 
    807
等级: 
    

(7)
已发布: 
    17 十月 2025, 13:01
    

[__ZigZagAutoFibo.png](/zh/code/download/50652/zigzagautofibo.png "ZigZagAutoFibo.png") (21.75 KB)

[__FiboZigZag.mq5](/zh/code/download/50652/fibozigzag.mq5 "FiboZigZag.mq5") (9.03 KB) 预览

__[__下载ZIP](/zh/code/download/50652.zip "下载单独ZIP文档中的全部附件") [__在MetaEditor如何使用下载的代码](https://www.metatrader5.com/zh/metaeditor/help/workspace/toolbox#codebase)

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

该指标以 ZigZag 指标为基础，用于绘制斐波那契回撤线。  我从该 Metatrader 4[代码](/zh/code/18078) https://www.mql5.com/zh/code/18078 进行了转换。 

![之字形自动斐波指标](https://c.mql5.com/18/169/ZigZagAutoFibo__9.png)   


  


由MetaQuotes Ltd译自英文  
原代码： [https://www.mql5.com/en/code/50652](/en/code/50652)

![SL-TP Values](https://c.mql5.com/i/code/indicator.png) [SL-TP Values](/zh/code/50653)

指标显示以存款货币定义的止损和或止盈值。 注：它根据简单计算得出估计值，不考虑经纪佣金。

![Risk reward box](https://c.mql5.com/i/code/indicator.png) [Risk reward box](/zh/code/50669)

该指标可在所有已打开的图表上根据最高价、最低价和旧蜡烛图自动创建风险/回报框。 您可以使用该指标轻松拖动并更改大小和价格，以满足您的需求。

![ZZVolatility](https://c.mql5.com/i/code/indicator.png) [ZZVolatility](/zh/code/50597)

另一个之字形之字形

![CCI beginner tutorial by William210](https://c.mql5.com/i/code/indicator.png) [CCI beginner tutorial by William210](/zh/code/50578)

学习 MQL5 代码的 CCI 入门教程
