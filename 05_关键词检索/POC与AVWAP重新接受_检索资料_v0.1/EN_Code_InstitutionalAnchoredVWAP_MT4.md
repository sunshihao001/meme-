# EN_Code_InstitutionalAnchoredVWAP_MT4

> 来源标题：Free download of the 'Institutional Anchored VWAP (Smart Money Benchmark)' indicator by 'KayruYuta' for MetaTrader 4 in the MQL5 Code Base, 2026.03.27
> 来源链接：https://www.mql5.com/en/code/71075
> 下载时间：2026-06-13 02:50:28
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

Find us on[Twitter](https://x.com/mql5com)!  
Join our fan page

__

Interesting script?  
So post a [link](/en/code/71075) to it -  
let others appraise it 

__

You liked the script? Try it in the [MetaTrader 5](https://download.terminal.free/cdn/web/metaquotes.ltd/mt5/mt5setup.exe?utm_source=www.mql5.com&utm_campaign=download) terminal 

to pocket

![Indicators](https://c.mql5.com/i/code/indicator.png)

# Institutional Anchored VWAP (Smart Money Benchmark) - indicator for MetaTrader 4

[Amanda Vitoria De Paula Pereira](/en/users/kayruyuta)

![Amanda Vitoria De Paula Pereira](https://c.mql5.com/avatar/2026/2/698a2d48-4b18.jpg)

####  [Amanda Vitoria De Paula Pereira](/en/users/kayruyuta)

__

  * __Engineer at Brasil
  * __[Brazil](https://www.mql5.com/go?https://maps.google.com/?z=4&q=Brazil "Lives")
  * __[5921](/en/users/kayruyuta/achievements "Rating")



**5** (7)




"At 6, I disassembled toys to understand their mechanics, by 12, I was captivated by the intersection of art and mathematics. I saw the micro and macro connections like a musical arrangement, to me, everything is a grand opera; a harmony that makes my eyes shine." 

[ 1 product ](/en/users/kayruyuta/seller) [ 4 articles ](/en/users/kayruyuta/publications) [ 33 codes ](/en/users/kayruyuta/publications) [ 17 comments ](/en/users/kayruyuta/publications/all)

Views: 
    3511
Rating: 
    

(4)
Published: 
    27 March 2026, 05:56
    

[__Institutional_VWAP.mq4](/en/code/download/71075/Institutional_VWAP.mq4 "Institutional_VWAP.mq4") (8.42 KB) view

__[__Download as ZIP](/en/code/download/71075.zip "Download all attachments in the single ZIP archive") [__How to download code from MetaEditor](https://www.metatrader5.com/en/metaeditor/help/workspace/toolbox#codebase)

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

> Retail traders use Moving Averages; Institutional algorithms use the VWAP. When a hedge fund or liquidity provider executes massive block orders, their execution algorithms are benchmarked against the Volume Weighted Average Price. They accumulate positions when the price is below the VWAP (Discount) and distribute when it is above (Premium).

MetaTrader 4 lacks a native, institutional-grade Anchored VWAP. This indicator bridges that gap by calculating the true volume-weighted price from the exact start of your chosen session (Daily, Weekly, or Monthly) and projecting standard deviation bands to identify extreme algorithmic over-extension.

[ ![Print](https://c.mql5.com/18/178/Print__12.jpg)](https://c.mql5.com/18/178/Print__11.jpg "https://c.mql5.com/18/178/Print__11.jpg")

  


### **Core Features**  


  * **True Mathematical VWAP:** Calculates the cumulative Typical Price (H+L+C)/3 multiplied by tick volume, providing the actual "fair value" line of the day.

  * **Dynamic Anchoring:** Automatically resets the calculation at the start of a new Day, Week, or Month without any repainting.

  * **Algorithmic Deviation Bands:** Projects an upper and lower Standard Deviation band. In quantitative finance, price action hitting the 2nd standard deviation from the VWAP is statistically overextended, offering high-probability mean-reversion entries.

  * **Zero Lag & CPU Optimized:** Modern MQL4 OnCalculate structure ensures the indicator runs instantly even on a 10-year historical chart without freezing the terminal.




### **Input Parameters**  


  * **AnchorPeriod:** Choose between PERIOD_D1, PERIOD_W1, or PERIOD_MN1.

  * **DeviationMultiplier:** The standard deviation multiplier for the outer bands (Default is 2.0).

  * **Line Styles:** Fully customizable colors and weights for the VWAP and Bands.


  


![Institutional ICT Killzones and Asian Range](https://c.mql5.com/i/code/indicator.png) [Institutional ICT Killzones and Asian Range](/en/code/71073)

An essential time-and-price indicator for SMC and ICT traders on MT4. It automatically highlights the Asian Range, London Killzone, and New York Killzone, featuring a built-in Broker GMT Offset adjustment for perfect session timing.

![Prop Firm Risk Monitor e Auto-Lot Calculator](https://c.mql5.com/i/code/indicator.png) [Prop Firm Risk Monitor e Auto-Lot Calculator](/en/code/71058)

An essential on-chart dashboard for MT4 prop firm traders. It tracks real-time daily drawdown to protect your funded accounts and provides an instant risk-to-lot-size calculator based on your exact stop loss.

![Institutional Psychological Levels and Magnet Zones](https://c.mql5.com/i/code/indicator.png) [Institutional Psychological Levels and Magnet Zones](/en/code/71076)

Automatically identifies key psychological "Round Numbers" where institutional liquidity and bank orders are concentrated. Essential for spotting high-probability reversal zones and magnet price targets.

![Institutional ATR Trailing Stop and Breakeven Manager](https://c.mql5.com/i/code/expert.png) [Institutional ATR Trailing Stop and Breakeven Manager](/en/code/71077)

A professional trade management Expert Advisor for MT4. It replaces static trailing stops with a dynamic, volatility-based ATR Trailing logic, and includes an automated Breakeven feature to protect funded prop firm accounts.
