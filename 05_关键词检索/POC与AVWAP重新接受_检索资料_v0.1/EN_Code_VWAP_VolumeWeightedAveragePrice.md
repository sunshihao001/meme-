# EN_Code_VWAP_VolumeWeightedAveragePrice

> 来源标题：Free download of the 'VWAP - Volume Weighted Average Price' indicator by 'felipealmeida' for MetaTrader 5 in the MQL5 Code Base, 2015.12.24
> 来源链接：https://www.mql5.com/en/code/14484
> 下载时间：2026-06-13 02:50:25
> 用途：POC/AVWAP重新接受专题补全来源。

---

  * [![](https://c.mql5.com/i/sidebar/mt.svg)MetaTrader 5](/en/code/mt5)
    * [![](https://c.mql5.com/i/sidebar/expert.svg)Experts](/en/code/mt5/experts)
    * [![](https://c.mql5.com/i/sidebar/indicator.svg)Indicators](/en/code/mt5/indicators)
    * [![](https://c.mql5.com/i/sidebar/scripts.svg)Scripts](/en/code/mt5/scripts)
    * [![](https://c.mql5.com/i/sidebar/library.svg)Libraries](/en/code/mt5/libraries)
  * [![](https://c.mql5.com/i/sidebar/mt.svg)MetaTrader 4](/en/code/mt4)
    * [![](https://c.mql5.com/i/sidebar/expert.svg)Experts](/en/code/mt4/experts)
    * [![](https://c.mql5.com/i/sidebar/indicator.svg)Indicators](/en/code/mt4/indicators)
    * [![](https://c.mql5.com/i/sidebar/scripts.svg)Scripts](/en/code/mt4/scripts)
    * [![](https://c.mql5.com/i/sidebar/library.svg)Libraries](/en/code/mt4/libraries)


  * [![](https://c.mql5.com/i/sidebar/storage.svg)Storage](/en/code/storage)



__

Watch [how to download](https://youtu.be/rloNyFVtHuA?list=PLltlMLQ7OLeKwyQwC8FhiKwjl9syKhOCK) trading robots for free 

__

Find us on[Facebook](https://www.facebook.com/mql5.community/)!  
Join our fan page

__

Interesting script?  
So post a [link](/en/code/14484) to it -  
let others appraise it 

__

You liked the script? Try it in the [MetaTrader 5](https://download.terminal.free/cdn/web/metaquotes.ltd/mt5/mt5setup.exe?utm_source=www.mql5.com&utm_campaign=download) terminal 

to pocket

![Indicators](https://c.mql5.com/i/code/indicator.png)

# VWAP - Volume Weighted Average Price - indicator for MetaTrader 5

[Felipe Almeida](/en/users/felipealmeida)

![Felipe Almeida](https://c.mql5.com/avatar/2015/12/567C5FB1-B510.PNG)

####  [Felipe Almeida](/en/users/felipealmeida)

  * __Owner at SOL Digital
  * __[Brazil](https://www.mql5.com/go?https://maps.google.com/?z=4&q=Brazil "Lives")
  * __[9761](/en/users/felipealmeida/achievements "Rating")






MQL5 EAs, Indicators and Scripts developer.

[ 2 codes ](/en/users/felipealmeida/publications) [ 5 comments ](/en/users/felipealmeida/publications/all)

|  [English __](javascript:void\(false\);) [Русский](/ru/code/14484) [中文](/zh/code/14484) [Español](/es/code/14484) [Deutsch](/de/code/14484) [日本語](/ja/code/14484) [Português](/pt/code/14484)

Views: 
    116568
Rating: 
    

(141)
Published: 
    24 December 2015, 09:25
Updated: 
    22 November 2016, 07:32
    

[__vwap.mq5](/en/code/download/14484/vwap.mq5 "vwap.mq5") (21.89 KB) view

__[__Download as ZIP](/en/code/download/14484.zip "Download all attachments in the single ZIP archive") [__How to download code from MetaEditor](https://www.metatrader5.com/en/metaeditor/help/workspace/toolbox#codebase)

![MQL5 - Language of trade strategies built-in the MetaTrader 5 client terminal](https://c.mql5.com/i/registerlandings/logo-2.png)

You are missing trading opportunities:

  * Free trading apps
  * Over 8,000 signals for copying
  * Economic news for exploring financial markets



Registration Log in

  * [Log in With Google](https://www.mql5.com/en/auth_oauth2?provider=Google&amp;return=popup&amp;reg=1)



You agree to [website policy](/en/about/privacy) and [terms of use](/en/about/terms)

If you do not have an account, please [register](https://www.mql5.com/en/auth_register)

Allow the use of cookies to log in to the MQL5.com website.

Please enable the necessary setting in your browser, otherwise you will not be able to log in.

  * [Log in With Google](https://www.mql5.com/en/auth_oauth2?provider=Google&amp;return=popup)



     ![MQL5 Freelance](https://c.mql5.com/i/code/icon_freelance.svg) Need a robot or indicator based on this code? Order it on Freelance  [Go to Freelance](/en/job/new "Go to Freelance")

**Updates:**

  * 2016-02-04; v1.47: Performance upgrade.
  * 2016-01-15; v1.46: Performance upgrade.
  * 2015-12-31; v1.45: Performance upgrade.
  * 2015-12-31; v1.44: Performance upgrade.
  * 2015-12-31; v1.43: Performance upgrade.
  * 2015-12-26; v1.42: Performance upgrade.
  * 2015-12-26; v1.41: Minor changes for performance upgrade.
  * 2015-12-24; v1.40: Initial public version.



  


VWAP is an intra-day calculation used primarily by algorithms and institutional traders to assess where a stock is trading relative to its volume weighted average for the day. Day traders also use VWAP for assessing market direction and filtering trade signals. Before using VWAP, understand how it is calculated, how to interpret it and use it, as well the drawbacks of the indicator ([http://traderhq.com/trading-strategies/understanding-volume-weight-average-price/](/go?link=https://traderhq.com/best-stock-advisors-stock-picking-newsletters-investment-advice-research-analysis-websites/ "http://traderhq.com/trading-strategies/understanding-volume-weight-average-price/")).

This is a VWAP indicator based on the Investopedia description ([http://www.investopedia.com/articles/trading/11/trading-with-vwap-mvwap.asp](/go?link=https://www.investopedia.com/articles/trading/11/trading-with-vwap-mvwap.asp "http://www.investopedia.com/articles/trading/11/trading-with-vwap-mvwap.asp")).

I've added six lines to this indicator. The principal is the VWAP Daily which is the calculation based on the intra-day values. All the other five lines you can set the period of the calculation, so it can be less or greater than the intra-day period.

All six lines are independent. As default only the intra-day comes enabled, but you can enable the others in the properties panel.

Thanks for downloading this code. I will be waiting for your comments, vote and rating.

  


![](https://c.mql5.com/18/45/01.png)  


![](https://c.mql5.com/18/45/02.PNG)

![](https://c.mql5.com/18/45/03.PNG)

![](https://c.mql5.com/18/45/04.PNG)

![](https://c.mql5.com/18/45/05.PNG)

![RJT Matches](https://c.mql5.com/i/code/indicator.png) [RJT Matches](/en/code/14428)

This indicator helps determine the end and the beginning of trends based on the inclination of the matches.

![PA_Oscillator](https://c.mql5.com/i/code/indicator.png) [PA_Oscillator](/en/code/14332)

A simple oscillator that shows the speed of the MACD indicator change implemented as a two-colored histogram.

![ManualTradeOnStrategyTester](https://c.mql5.com/i/code/expert.png) [ManualTradeOnStrategyTester](/en/code/14535)

A simple way on how EA can link a manual order command from outside to use it in MetaTrader 5 Strategy Tester.

![VWAP Lite - Volume Weighted Average Price](https://c.mql5.com/i/code/indicator.png) [VWAP Lite - Volume Weighted Average Price](/en/code/14557)

VWAP is an intra-day calculation used primarily by algorithms and institutional traders to assess where a stock is trading relative to its volume weighted average for the day.
