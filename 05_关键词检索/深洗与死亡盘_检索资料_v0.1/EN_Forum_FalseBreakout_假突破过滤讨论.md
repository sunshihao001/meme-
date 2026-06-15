# EN_Forum_FalseBreakout_假突破过滤讨论

> 来源标题：False breakout - Equities - General - MQL5 programming forum
> 来源链接：https://www.mql5.com/en/forum/508608
> 下载时间：2026-06-13 02:35:41
> 用途：深洗 vs 死亡盘专题补全来源。

---

# False breakout

[ __New comment](javascript:void\(false\);)

![Kam Yuk Wong](https://c.mql5.com/avatar/2023/11/65577293-7B0F.png)

270

[Kam Yuk Wong](/en/users/stockvcp) 2026.04.20 10:45

How to avoid false breakout ? I focus on trading breakout, but false breakout greatly affect my equity growth, hope someone can help me to avoid the false breakout. Thanks 

![William Roeder](https://c.mql5.com/avatar/2016/12/584F20BE-8336.png)

Moderator32624

[William Roeder](/en/users/whroeder1) 2026.04.20 11:29 [#1](/en/forum/508608#comment_59609790 "Permanent link")

hope someone can help 

My [crystal ball](/en/forum/387614#comment_27538185 "https://www.mql5.com/en/forum/387614#comment_27538185") is cracked. Does yours accurately see the future? 

![Ryan L Johnson](https://c.mql5.com/avatar/2025/5/68239006-fc9d.png)

5292 1

[Ryan L Johnson](/en/users/rjo) 2026.04.20 13:04 [#2](/en/forum/508608#comment_59610310 "Permanent link")

As most traders on this Forum are trading FX, let's start with the premise that the FX market exhibits ranging "behavior" about 70% of the time. If you're trying to catch lengthy price breakouts, you have to find that 30% of trending prices and filter out everything else. The following indicator is designed for that purpose:

[Code Base](/en/code)

[ATR Cycles](/en/code/65801)

[Ryan L Johnson](/en/users/RJo), 2025.11.08 14:29

A volatility filter based on 3 ATR's: a fast ATR, a middle ATR, and a slow ATR 

Within that 30% of price activity, most breakouts are rather short lived, so consider setting your TP at 20 to 25% above/below yesterday's daily price range for longs/shorts, respectively:

[Code Base](/en/code)

[Daily Range Projections Full](/en/code/566)

[Nikolay Kositsin](/en/users/GODZILLA), 2011.11.22 11:12

Forecasting the next day candlestick changing range for all bars of the current chart. 

[DeMarker - Oscillators -](https://www.metatrader5.com/en/terminal/help/indicators/oscillators/demarker "DeMarker - Oscillators - Technical Indicators - Price Charts, Technical and Fundamental Analysis") [Bears Power - Oscillators](https://www.metatrader5.com/en/mobile-trading/android/help/chart/indicators/oscillators/bears_power "Bears Power - Oscillators - Indicators - Charts - MetaTrader 5 for Android") [Bears Power - Oscillators](https://www.metatrader5.com/en/mobile-trading/iphone/help/chart/indicators/oscillators/bears_power "Bears Power - Oscillators - Indicators - Chart - MetaTrader 5 for iPhone")

![Alex Holloway](https://c.mql5.com/avatar/2025/10/68E06535-55B3.jpg)

493

[Alex Holloway](/en/users/alex_holloway) 2026.04.20 15:03 [#3](/en/forum/508608#comment_59610919 "Permanent link")

**Kam Yuk Wong :**  
How to avoid false breakout ? I focus on trading breakout, but false breakout greatly affect my equity growth, hope someone can help me to avoid the false breakout. Thanks 

Simply wait for price action confirmation. Wait for 1 or 2 candles to close after the breakout occurred.

If you're using automated system (algo solutions) then make sure the EA has a filter for false breakout.

[On Balance Volume -](https://www.metatrader5.com/en/mobile-trading/android/help/chart/indicators/volume_indicators/on_balance_volume "On Balance Volume - Volume Indicators - Indicators - Charts - MetaTrader 5 for Android") [On Balance Volume -](https://www.metatrader5.com/en/mobile-trading/iphone/help/chart/indicators/volume_indicators/on_balance_volume "On Balance Volume - Volume Indicators - Indicators - Chart - MetaTrader 5 for iPhone") [On Balance Volume -](https://www.metatrader5.com/en/terminal/help/indicators/volume_indicators/obv "On Balance Volume - Volume Indicators - Technical Indicators - Price Charts, Technical and Fundamental Analysis")

![Mostafa Ghanbari](https://c.mql5.com/avatar/2026/2/699f1de0-1ded.jpg)

2027

[Mostafa Ghanbari](/en/users/mghfx) 2026.04.20 17:31 [#4](/en/forum/508608#comment_59611687 "Permanent link")

**Kam Yuk Wong :**  
How to avoid false breakout ? I focus on trading breakout, but false breakout greatly affect my equity growth, hope someone can help me to avoid the false breakout. Thanks 

False breakouts are indeed one of the biggest challenges for breakout traders. Here are a few professional techniques to help you filter out "fakeouts" and improve your win rate:

  * **Wait for the Retest:** Instead of entering exactly at the moment of the break, wait for the price to come back and test the previous resistance/support level. If the level holds and price bounces, it confirms the breakout.

  * **Check the Volume:** A genuine breakout is usually accompanied by a significant surge in volume. If the price moves out of a range on low volume, it is highly likely to be a false breakout.

  * **Use Multi-Timeframe Analysis:** If you see a breakout on a 15-minute chart, check the 4-hour or Daily chart. If the price is hitting a major higher-timeframe resistance, the lower-timeframe breakout will likely fail.

  * **Look for Consolidation near the Level:** If the price "builds up" (consolidates) right under a resistance level before breaking, it shows strength. Avoid trading "V-shaped" breakouts where the price rallies from far away and breaks the level immediately; these are often exhausted.

  * **ATR Filter:** Give the trade some "breathing room." Use the [Average True Range](https://www.metatrader5.com/en/terminal/help/indicators/oscillators/atr "MetaTrader 5 Help: Average True Range Indicator") (ATR) indicator to set your stop loss or to wait for the price to move a certain distance beyond the level before entering.




Focusing on these filters will slow down your trading, but it will significantly protect your equity. Good luck!

[Relative Strength Index -](https://www.metatrader5.com/en/terminal/help/indicators/oscillators/rsi "Relative Strength Index - Oscillators - Technical Indicators - Price Charts, Technical and Fundamental Analysis") [Relative Strength Index -](https://www.metatrader5.com/en/mobile-trading/android/help/chart/indicators/oscillators/relative_strength_index "Relative Strength Index - Oscillators - Indicators - Charts - MetaTrader 5 for Android") [Relative Strength Index -](https://www.metatrader5.com/en/mobile-trading/iphone/help/chart/indicators/oscillators/relative_strength_index "Relative Strength Index - Oscillators - Indicators - Chart - MetaTrader 5 for iPhone")

![Yohana Parmi](https://c.mql5.com/avatar/2026/4/69e6669f-88cd.jpg)

11863 1

[Yohana Parmi](/en/users/yohana) 2026.04.21 08:23 [#5](/en/forum/508608#comment_59614545 "Permanent link")

**Kam Yuk Wong :**  
_How to avoid false breakout ? I focus on trading breakout, but false breakout greatly affect my equity growth, hope someone can help me to avoid the false breakout. Thanks _

To prevent false breakouts, _start by understanding first the market's characteristics and the behavior of market participants_.  
Because the market is predominantly sideways, this is due to parties seeking to _maintain price stability within a certain price range_.

_For example:_

Bitcoin (BTCUSD) market is different from EURUSD, EURGBP or even XAUUSD market.  
Therefore, we can't apply the same approach to all symbols.  
Generally _(supply and demand)_ , they are the same, but at certain times, you may find differences.

Even though the price is heading towards a major trend,   
market participants' behavior causes the price to move sideways first   
before suddenly spiking upwards or downwards before heading towards the main trend.

Before the price continues its upward trend, it usually begins with a new breakout low.  
Conversely, before the price continues its [downward trend](https://www.mql5.com/en/docs/constants/objectconstants/enum_gann_direction "MQL5 documentation: Gann Objects"), it usually begins with a new breakout high.

These are the moments when many people experience false breakouts.

Sometimes you can apply one method to all symbols, but sometimes you can't.  
That's where the big challenge lies :)

Maybe some people don't agree with my views, but I tell you the truth from my experience.

Good luck.

[Basic Principles - Trading](https://www.metatrader5.com/en/terminal/help/trading/general_concept "Basic Principles - Trading Operations") [Trading Principles - Trade](https://www.metatrader5.com/en/mobile-trading/iphone/help/trade/general_concept "Trading Principles - Trade - MetaTrader 5 for iPhone") [Relative Strength Index -](https://www.metatrader5.com/en/terminal/help/indicators/oscillators/rsi "Relative Strength Index - Oscillators - Technical Indicators - Price Charts, Technical and Fundamental Analysis")

[](/en/forum "Root")[](/en/forum/general "Category: General")

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


