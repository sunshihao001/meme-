# EN_Code_DailyVWAP

> 来源标题：Free download of the 'Daily VWAP' indicator by 'Syllyon' for MetaTrader 5 in the MQL5 Code Base, 2025.07.03
> 来源链接：https://www.mql5.com/en/code/61090
> 下载时间：2026-06-13 02:50:26
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
So post a [link](/en/code/61090) to it -  
let others appraise it 

__

You liked the script? Try it in the [MetaTrader 5](https://download.terminal.free/cdn/web/metaquotes.ltd/mt5/mt5setup.exe?utm_source=www.mql5.com&utm_campaign=download) terminal 

to pocket

![Indicators](https://c.mql5.com/i/code/indicator.png)

# Daily VWAP - indicator for MetaTrader 5

[Guillermo Pineda](/en/users/syllyon)

![Guillermo Pineda](https://c.mql5.com/avatar/2025/5/6835f8d3-9c16.jpg)

####  [Guillermo Pineda](/en/users/syllyon)

__

  * __MQL5 Developer at[Remote](https://T.me/Syllyon)
  * __[Venezuela](https://www.mql5.com/go?https://maps.google.com/?z=4&q=Venezuela "Lives")
  * __[18567](/en/users/syllyon/achievements "Rating")



**4.7** (17)

  * [](https://T.me/Syllyon) [T.me/Syllyon](https://T.me/Syllyon)



I'm a MQL4 and MQL5 developer with a focus on building robust, customizable trading Expert Advisors, Indicators and Scripts.   
I'm actively expanding into quantitative trading and machine learning applications to optimize financial strategies. 

[ 14 products ](/en/users/syllyon/seller) [ 3 codes ](/en/users/syllyon/publications) [ 1 topic ](/en/users/syllyon/publications) [ 23 comments ](/en/users/syllyon/publications/all)

|  [English __](javascript:void\(false\);) [Русский](/ru/code/61090) [中文](/zh/code/61090) [Español](/es/code/61090) [Deutsch](/de/code/61090) [日本語](/ja/code/61090) [Português](/pt/code/61090) [한국어](/ko/code/61090) [Français](/fr/code/61090) [Italiano](/it/code/61090) [Türkçe](/tr/code/61090)

Views: 
    13240
Rating: 
    

(8)
Published: 
    3 July 2025, 15:18
    

[__Daily VWAP.mq5](/en/code/download/61090/daily_vwap.mq5 "Daily VWAP.mq5") (7.23 KB) view

__[__Download as ZIP](/en/code/download/61090.zip "Download all attachments in the single ZIP archive") [__How to download code from MetaEditor](https://www.metatrader5.com/en/metaeditor/help/workspace/toolbox#codebase)

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

## **Daily VWAP: Your Essential Intraday Fair Value Indicator**

The **Daily VWAP (Volume Weighted Average Price)** is a precisely coded custom indicator designed to provide traders with a critical piece of intraday analysis: the volume-weighted average price, reset daily. Unlike traditional moving averages, VWAP incorporates volume into its calculation, giving more weight to prices where more trading activity occurred. This makes it an incredibly valuable tool for gauging the true fair value of an asset throughout the trading day.

This indicator calculates the cumulative sum of (Price * Volume) divided by the cumulative volume for each day, starting fresh at the beginning of every new trading session. It plots a smooth line directly on your chart, making it easy to visualize where the majority of today's trading volume has occurred relative to price.

**Why use Daily VWAP?**

  * **Identify Intraday Fair Value:** Understand the average price at which an asset has traded, adjusted for volume, providing a clear benchmark for bullish or bearish sentiment.

  * **Strategic Entry & Exit Points:** Many institutional traders use VWAP as a key reference point. Price trading above VWAP can indicate bullish sentiment, while price below VWAP may suggest bearish control. This offers valuable insights for potential entry and exit strategies.

  * **Trend Confirmation:** Use VWAP to confirm the strength of an intraday trend. A strong trend often sees price maintaining its position relative to VWAP.

  * **Simple & Uncluttered:** Despite its sophisticated calculation, the Daily VWAP is presented as a single, clear line on your chart, keeping your analysis clean and focused.




**Features of this Source Code:**

  * **Daily Reset:** The VWAP calculation automatically resets at the start of each new trading day, providing a fresh perspective on daily market activity.

  * **Robust Calculation:** Utilizes standard MQL5 functions for accurate calculation of typical price and volume.

  * **Clean Plotting:** Displays a distinct blue line on your chart for easy identification.

  * **Open Source:** Full MQL5 source code is provided, allowing for complete transparency, learning, and further customization by the community.




![VWAP on BTCUSD \(M15\)](https://c.mql5.com/18/164/BTCUSDM15_-_VWAP_21o.png)  


  


![Watermark](https://c.mql5.com/i/code/indicator.png) [Watermark](/en/code/59930)

The Watermark indicator is lightweight and efficient, designed to display an informative watermark over the main MetaTrader 5 chart. It automatically shows the current symbol, chart time and asset description, allowing traders to customise their interface with style and convenience.

![Tuyul Uncensored](https://c.mql5.com/i/code/expert.png) [Tuyul Uncensored](/en/code/60961)

try to imitate trading system using expert advisor

![Weekly VWAP](https://c.mql5.com/i/code/indicator.png) [Weekly VWAP](/en/code/61091)

Weekly VWAP (Volume Weighted Average Price) is a powerful MQL5 indicator that calculates and displays the Volume Weighted Average Price for each trading week. It's a crucial tool for identifying weekly fair value and understanding the underlying sentiment over a longer timeframe.

![Monthly VWAP](https://c.mql5.com/i/code/indicator.png) [Monthly VWAP](/en/code/61098)

Monthly VWAP (Volume Weighted Average Price) is an essential MQL5 indicator that calculates and displays the Volume Weighted Average Price for each trading month. It's a powerful tool for understanding long-term market sentiment, identifying key monthly fair value, and informing strategic decisions.
