# FORUM_Wyckoff吸筹派发文章讨论

> 来源标题：Discussing the article: "Automating Classic Market Methods in MQL5 (Part 1): Wyckoff Accumulation and Distribution" - Technical Trading - Articles, Library comments - MQL5 programming forum
> 来源链接：https://www.mql5.com/en/forum/510756
> 下载时间：2026-06-13 00:08:36
> 用途：补充 meme 市场庄家控盘、深洗、诱多、二次确认相关语义。

---

# Discussing the article: "Automating Classic Market Methods in MQL5 (Part 1): Wyckoff Accumulation and Distribution"

[ __New comment](javascript:void\(false\);)

![MetaQuotes](https://c.mql5.com/avatar/2010/1/4B5DE8B4-9045.jpg)

Moderator315602

[MetaQuotes](/en/users/metaquotes) 2026.06.04 12:55

Check out the new article: [Automating Classic Market Methods in MQL5 (Part 1): Wyckoff Accumulation and Distribution](/en/articles/22628).

The article describes an MQL5 EA that automates Wyckoff accumulation and distribution via a finite state machine. It confirms spring to SOS and upthrust to SOW before placing LPS or LPSY entries, using relative tick volume as the confirmation metric. Readers get the state model, detection criteria, code organization, and MetaTrader 5 testing procedure. 

One of the most enduring frameworks in technical analysis is the Wyckoff method. Richard Wyckoff developed it in the 1930s after decades of observing how large institutional operators accumulate and distribute positions in financial markets.

The method describes market movement not as random noise, but as a series of cause-and-effect cycles driven by institutional supply and demand. These cycles leave identifiable structural footprints—the spring, the sign of strength, the upthrust, and the sign of weakness—that a prepared trader can detect and trade.

Although widely discussed, the Wyckoff method is rarely automated in MQL5. This is not because individual events are difficult to detect; for example, a close below support is trivial. The challenge is that each Wyckoff event only carries meaning in the context of the events that preceded it. A spring is not merely a dip below support. It is a dip below support that occurs within a defined range, following a prior downtrend, confirmed by a specific volume signature. Detecting it in isolation is meaningless. Detecting it as part of a validated sequence is everything.

In this article, we build a complete Expert Advisor that automates this sequential detection using a finite state machine. The EA identifies accumulation structures on the H4 timeframe, detects the spring shakeout, confirms demand with a sign of strength, and enters long at the last point of support.

![](https://c.mql5.com/3/490/22628-automating-classic-market-methods-in-mql5-part-1-wyckoff-accumulation_1200x628.jpg)

Author: [Tola Moses Hector](/en/users/TOLAHECTORFOREX "TOLAHECTORFOREX")

[](/en/forum "Root")[](/en/forum/art "Category: Articles, Library comments")

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


