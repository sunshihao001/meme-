# FORUM_突破策略过滤确认EA逻辑讨论

> 来源标题：Breakout Trading Strategy Discussion: Filters, Confirmation, and EA Logic - Best Forex Trading Strategy - Trading Systems - MQL5 programming forum
> 来源链接：https://www.mql5.com/en/forum/507369
> 下载时间：2026-06-13 00:18:08
> 用途：V0.1风险管理语义二次检索补全来源。

---

# Breakout Trading Strategy Discussion: Filters, Confirmation, and EA Logic

[ __New comment](javascript:void\(false\);)

![Carl Marvin Fajardo](https://c.mql5.com/avatar/2026/3/69a58903-f216.png)

732 2

[Carl Marvin Fajardo](/en/users/carlfx888) 2026.03.26 03:04

Hello traders and developers,

I would like to start a discussion about **breakout[ trading strategies](https://www.mql5.com/en/articles/3074 "Article: Comparative Analysis of 10 Trending Strategies ")**, especially from the perspective of **trade validation, false breakout filtering, and EA development in MQL5**.

Breakout trading is one of the most interesting approaches because it can capture strong momentum when price moves out of consolidation or a key structure area. At the same time, one of the biggest challenges is that not all breakouts lead to continuation. Many setups fail quickly or turn into false breakouts.

I am interested in learning how other traders and developers approach this problem in practice.

Some points I would like to discuss:

**1\. Breakout confirmation**  
What do you consider the most reliable confirmation before entering a breakout trade?

  * Candle close outside the range 
  * Retest of the broken level 
  * Volatility expansion 
  * Momentum confirmation 
  * Session timing 



**2\. False breakout filtering**  
What filters have helped you reduce bad entries?

  * Higher timeframe direction 
  * Range quality or consolidation structure 
  * Support and resistance strength 
  * Spread filter 
  * Time/session filter 
  * Distance filter from key levels 



**3\. Best market conditions**  
In your experience, where do breakout strategies perform best?

  * Forex majors 
  * Gold 
  * Indices 
  * London session 
  * New York session 
  * Session opens 



**4\. EA development logic in MQL5**  
For developers, which breakout model has worked better in testing?

  * Pending stop orders above and below a range 
  * Candle-close confirmation 
  * Retest entry logic 
  * Multi-timeframe confirmation 
  * Breakout plus momentum threshold 



**5\. Trade management**  
How do you usually manage breakout positions after entry?

  * Fixed stop loss and take profit 
  * ATR-based stop loss 
  * Partial close 
  * Break-even rules 
  * Trailing stop after expansion 



My current interest is understanding how to improve breakout quality, not just detecting the break itself. In many cases, the real challenge seems to be identifying whether the pre-breakout structure is clean enough and whether the breakout has enough context to continue.

I would appreciate hearing from traders who use breakout setups manually, as well as developers who have coded and tested breakout systems in MQL5.

Some direct questions:

  * What is your preferred breakout confirmation method? 
  * Which filters made the biggest improvement in your results? 
  * What is the most difficult part of coding a breakout EA properly? 
  * Do you find breakout systems more reliable on specific symbols or sessions? 



I’m looking forward to learning from your experience and testing ideas.

Thank you.

  * [How to better filter false entries in trend-following strategies on XAUUSD during volatile periods?](https://www.mql5.com/en/forum/504875)
  * [Breakout Trading Strategy](https://www.mql5.com/en/forum/60363)
  * [Resolving Conflicting Bias in GOLD Confirmation Logic (MQL5)](https://www.mql5.com/en/forum/504817)



![Osmar Sandoval Espinosa](https://c.mql5.com/avatar/2026/1/69605f71-0073.jpg)

1842 3

[Osmar Sandoval Espinosa](/en/users/osmarsandovalespinosa) 2026.03.26 03:15 [#1](/en/forum/507369#comment_59458174 "Permanent link")

Here is a code I developed on breaktout...

I'm waiting for it to be published on code base.

**Files:**

[__RANGE_BREAKOUT_EURUSD.mq5](https://c.mql5.com/3/486/RANGE_BREAKOUT_EURUSD.mq5 "Download RANGE_BREAKOUT_EURUSD.mq5") 14 kb

[[WARNING CLOSED!] Any newbie](https://www.mql5.com/en/forum/401198/32518767#comment_32518767 "\[WARNING CLOSED!\] Any newbie question, so as not to clutter up the forum. Professionals, don't go by. Can't go anywhere without you.") [expert advisor - miscellaneous](https://www.mql5.com/en/forum/161964/4020950#comment_4020950 "expert advisor - miscellaneous questions") [Colors](https://www.mql5.com/en/book/applications/charts/charts_color "Colors")

[](/en/forum "Root")[](/en/forum/trading_systems "Category: Trading Systems")

[ __New comment](javascript:void\(false\);)

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


