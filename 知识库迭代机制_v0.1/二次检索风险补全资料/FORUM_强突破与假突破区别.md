# FORUM_强突破与假突破区别

> 来源标题：What Defines a Strong Breakout vs. False Breakout? - Breakout - Trading Systems - MQL5 programming forum
> 来源链接：https://www.mql5.com/en/forum/502423
> 下载时间：2026-06-13 00:18:07
> 用途：V0.1风险管理语义二次检索补全来源。

---

# What Defines a Strong Breakout vs. False Breakout?

[ __New comment](javascript:void\(false\);)

![Vivek Kumar](https://c.mql5.com/avatar/2026/5/6a02ba43-4985.png)

858 1

[Vivek Kumar](/en/users/vivekpanu) 2025.12.26 04:46

I’d like to discuss the difference between what we often call a “strong breakout” and a “false breakout”. What criteria do you personally use (candlestick body size, volume, retest behavior, multi-timeframe confirmation)?

My observation: sometimes a breakout above recent highs comes with strong follow-through, but other times it fails quickly and returns inside the range. Curious how experienced members differentiate these cases.

  * [EURUSD - Trends, Forecasts and Implications (Part 2)](https://www.mql5.com/en/forum/404904/33753814#comment_33753814)
  * [Accuracy?](https://www.mql5.com/en/forum/176160)
  * [What is mean by this keywords ?.](https://www.mql5.com/en/forum/464801)



![Keolopile motota](https://c.mql5.com/avatar/2022/2/620D0BB7-BD29.png)

10 1

[Keolopile motota](/en/users/keolopilemotota) 2025.12.26 14:40 [#1](/en/forum/502423#comment_58809815 "Permanent link")

Spike ditecter 

![Ryan L Johnson](https://c.mql5.com/avatar/2025/5/68239006-fc9d.png)

5292

[Ryan L Johnson](/en/users/rjo) 2025.12.26 16:12 [#2](/en/forum/502423#comment_58810282 "Permanent link")

**Vivek Kumar :**  
I’d like to discuss the difference between what we often call a “strong breakout” and a “false breakout”. 

Over the years, I've noticed that about 70% of range-based breakouts are short-lived (not strong). I'm hesitant to say that they're "false" because such a boolean statement depends upon the specific logic/strategy implemented.

For example, let's consider the daily range (DR). To be clear, this is not the average true range (ATR) nor even the average daily range (ADR). It is simply yesterday's High and Low which can be easily implemented by calling the High and Low prices of the D1 timeframe, bar shift 1, and then drawing two respective horizonal rays on a chart. Then add in the same bar's Open price and its horizontal ray. Finally, lets add in two profit target rays at +25% of the DR for buy trades and -25% of the DR for sell trades. You can do this on any intraday chart such as an M6, M15, M20, etc. either manually or programmatically. The Open price is used to determine directional bias (it also can be used as a price "magnet" for rangebound trading, but that is outside of the scope this thread). Stops can be set just a few pips inside the DR.

By setting such a conservative profit target, we've mitigated the effects of the would-be "false" breakouts--we really don't need to price to run that far. In this way, we're dealing with the usual state of the market rather than hunting for diamonds in the rough.

[MINI TERMINAL bring it](https://www.mql5.com/en/forum/145129/3656238#comment_3656238 "MINI TERMINAL bring it back !!!") [trading intra-candle on Open](https://www.mql5.com/en/forum/382927/26161238#comment_26161238 "trading intra-candle on Open Prices") [MTF, ATR % level,](https://www.mql5.com/en/forum/178545/4375285#comment_4375285 "MTF, ATR % level, breakout probabilty")

![Vivek Kumar](https://c.mql5.com/avatar/2026/5/6a02ba43-4985.png)

858

[Vivek Kumar](/en/users/vivekpanu) 2025.12.26 17:03 [#3](/en/forum/502423#comment_58810782 "Permanent link")

**Keolopile motota[#](/en/forum/502423#comment_58809815):**  
Spike ditecter 

Interesting point. Are you referring to detecting liquidity spikes or exhaustion moves that often occur around breakout levels?

If you’re using a specific spike-detection approach or indicator, I’d be interested to hear how you apply it to distinguish real breakouts from false ones.

[False breakouts](https://www.mql5.com/en/forum/256935 "False breakouts") [Need help with great](https://www.mql5.com/en/forum/175734/4290602#comment_4290602 "Need help with great indicator") [FOREX - Trends, Forecasts](https://www.mql5.com/en/forum/408649/35637277#comment_35637277 "FOREX - Trends, Forecasts and Implications \(Episode 17: July 2012\)")

![Vivek Kumar](https://c.mql5.com/avatar/2026/5/6a02ba43-4985.png)

858

[Vivek Kumar](/en/users/vivekpanu) 2025.12.26 17:05 [#4](/en/forum/502423#comment_58810790 "Permanent link")

**Ryan L Johnson[#](/en/forum/502423#comment_58810282):**  


Over the years, I've noticed that about 70% of range-based breakouts are short-lived (not strong). I'm hesitant to say that they're "false" because such a boolean statement depends upon the specific logic/strategy implemented.

For example, let's consider the daily range (DR). To be clear, this is not the average true range (ATR) nor even the average daily range (ADR). It is simply yesterday's High and Low which can be easily implemented by calling the High and Low prices of the D1 timeframe, bar shift 1, and then drawing two respective horizonal rays on a chart. Then add in the same bar's Open price and its horizontal ray. Finally, lets add in two profit target rays at +25% of the DR for buy trades and -25% of the DR for sell trades. You can do this on any intraday chart such as an M6, M15, M20, etc. either manually or programmatically. The Open price is used to determine directional bias (it also can be used as a price "magnet" for rangebound trading, but that is outside of the scope this thread). Stops can be set just a few pips inside the DR.

By setting such a conservative profit target, we've mitigated the effects of the would-be "false" breakouts--we really don't need to price to run that far. In this way, we're dealing with the usual state of the market rather than hunting for diamonds in the rough.

That’s a very helpful way to frame it, especially the point about avoiding a strict “true vs false” classification and instead working with probabilities and context. The daily range example makes it clear how most breakouts don’t need large follow-through to be useful if expectations are adjusted realistically.

I like the idea of anchoring bias around the prior day’s High/Low and Open rather than relying on averaged measures like ATR or ADR, particularly for intraday work. It feels more aligned with how price actually behaves on most days.

This perspective really reinforces the idea of adapting strategy logic to the market’s usual state rather than waiting for exceptional moves. Thanks for sharing such a clear explanation.

[Something Interesting in Financial](https://www.mql5.com/en/forum/207557/5509662#comment_5509662 "Something Interesting in Financial Video July 2017") [Something Interesting in Financial](https://www.mql5.com/en/forum/12758/547747#comment_547747 "Something Interesting in Financial Video July 2013") [SDS - Simple Daily](https://www.mql5.com/en/forum/178793/4386864#comment_4386864 "SDS - Simple Daily System EA")

![](https://c.mql5.com/avatar/avatar_na2.png)

[Deleted] 2026.01.04 16:01 [#5](/en/forum/502423#comment_58862008 "Permanent link")

A strong breakout usually shows a wide‑body candle with rising volume and a clean retest that holds, while a false breakout tends to pop above a level briefly with weak volume and snaps back into the range almost immediately. 

[How to use Support](https://www.mql5.com/en/forum/177227/4330561#comment_4330561 "How to use Support and Resistance Effectively") [A business approach to](https://www.mql5.com/en/forum/402823/32886332#comment_32886332 "A business approach to the EURUSD pair. We discuss analysis methods for this currency pair, advisors, indicators \(we correct errors and refine them\)") [Looking for patterns](https://www.mql5.com/en/forum/414928/37543843#comment_37543843 "Looking for patterns")

![Vivek Kumar](https://c.mql5.com/avatar/2026/5/6a02ba43-4985.png)

858 1

[Vivek Kumar](/en/users/vivekpanu) 2026.01.04 18:08 [#6](/en/forum/502423#comment_58862420 "Permanent link")

**Petra5[#](/en/forum/502423#comment_58862008):**  
A strong breakout usually shows a wide‑body candle with rising volume and a clean retest that holds, while a false breakout tends to pop above a level briefly with weak volume and snaps back into the range almost immediately. 

Thank you 

![Conor Mcnamara](https://c.mql5.com/avatar/2025/9/68dab3ec-4506.png)

11460

[Conor Mcnamara](/en/users/phade) 2026.01.05 00:26 [#7](/en/forum/502423#comment_58863880 "Permanent link")

A breakout is any break through of support or resistance and a strong breakout is a breakout that is not a fake breakout. Research liquidity sweeps and inducement. 

![Ryan L Johnson](https://c.mql5.com/avatar/2025/5/68239006-fc9d.png)

5292

[Ryan L Johnson](/en/users/rjo) 2026.01.05 00:39 [#8](/en/forum/502423#comment_58863889 "Permanent link")

**Conor Mcnamara[#](/en/forum/502423#comment_58863880):**  
A breakout is any break through of support or resistance and a strong breakout is a breakout that is not a fake breakout. Research liquidity sweeps and inducement. 

Let's throw in iceberg orders while we're at it. 

![AnAcc9](https://c.mql5.com/avatar/avatar_na2.png)

155

[AnAcc9](/en/users/anacc9) 2026.01.07 12:51 [#9](/en/forum/502423#comment_58888091 "Permanent link")

An Opposite Hindsight Holy [Grail](/en/articles/5008 "Article: Reversal - Holy Grail or Dangerous Delusion? ") reversal validation. It is impossible to get a better reversal validation than that. 

Obviously in a continuing trend the absence of an Opposite Hindsight Holy [Grail](/en/articles/5008 "Article: Reversal - Holy Grail or Dangerous Delusion? ") validated reversal confirms the validity of the breakout.

![Reversing: The holy grail or a dangerous delusion?](https://c.mql5.com/36/92/reversing-the-holy-grail-or-a-dangerous.jpg)

[Reversing: The holy grail or a dangerous delusion?](https://www.mql5.com/en/articles/5008)

  * 2018.10.19
  * www.mql5.com



In this article, we will study the reverse martingale technique and will try to understand whether it is worth using, as well as whether it can help improve your trading strategy. We will create an Expert Advisor to operate on historic data and to check what indicators are best suitable for the reversing technique. We will also check whether it can be used without any indicator as an independent trading system. In addition, we will check if reversing can turn a loss-making trading system into a profitable one. 

![AnAcc9](https://c.mql5.com/avatar/avatar_na2.png)

155

[AnAcc9](/en/users/anacc9) 2026.01.07 13:04 [#10](/en/forum/502423#comment_58888148 "Permanent link")

**AnAcc9[#](/en/forum/502423#comment_58888091):**  


An Opposite Hindsight Holy [Grail](/en/articles/5008 "Article: Reversal - Holy Grail or Dangerous Delusion? ") reversal validation. It is impossible to get a better reversal validation than that. 

Obviously in a continuing trend the absence of an Opposite Hindsight Holy [Grail](/en/articles/5008 "Article: Reversal - Holy Grail or Dangerous Delusion? ") validated reversal after the breakout, confirms the validity of the breakout.

We all see the Hindsight Holy Grail all the time - after the fact. No-one or nothing can set a retail or institutional trading Foresight Holy Grail which does not exist and never will - although Flash Trading can technically be defined as Foresight Holy Grail Trading after, for example 300 consecutive days positive trading. All of us also know the theoretical Holy Grail: Buy low, sell high. 

[The final Holy Grail!](https://www.mql5.com/en/forum/198339 "The final Holy Grail!") [Sarema EA](https://www.mql5.com/en/forum/175795/4291134#comment_4291134 "Sarema EA") [i think i've found](https://www.mql5.com/en/forum/218190 "i think i've found the holy grail, very easy way to never miss a trade")

[](/en/forum "Root")[](/en/forum/trading_systems "Category: Trading Systems")

[1](/en/forum/502423)[2](/en/forum/502423/page2)

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


