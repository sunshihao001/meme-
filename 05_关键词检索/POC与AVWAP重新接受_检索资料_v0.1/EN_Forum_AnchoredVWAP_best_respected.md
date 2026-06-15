# EN_Forum_AnchoredVWAP_best_respected

> 来源标题：How to find the best (most respected) anchored vwap at any given time. - Moving Average, MA - Technical Indicators - MQL5 programming forum
> 来源链接：https://www.mql5.com/en/forum/455444
> 下载时间：2026-06-13 02:50:27
> 用途：POC/AVWAP重新接受专题补全来源。

---

# How to find the best (most respected) anchored vwap at any given time.

[ __New comment](javascript:void\(false\);)

![Skyler James Lee](https://c.mql5.com/avatar/2023/2/63ed2394-e552.jpg)

307

[Skyler James Lee](/en/users/skylerlee) 2023.10.09 20:40

I was brainstorming the other day wondering how one would go about coding something like this logically. I had an idea involving plotting a 1 period sma on the highest highs of each candle (for example's sake) then with a vwap on a higher timeframe create a variable which runs through each possible period from each lowest low or highest high as an anchor point. For each period, I would measure the amount of times this 1 sma is within a small envelope surrounding each vwap line. I would take the number of periods the sma was in this envelope, divide it by its current number of periods, and save it into a new variable if it is of higher correlation than the previous. Essentially what I should be left with is the VWAP line which was most respected in terms of correlation. From here I should be able to assign the desired anchor point and use this line as my point of interest until a VWAP with a greater correlation coefficient presents itself. 

  


I thought I should write this idea down somewhere before I forgot it and figured I might as well share it in case anyone more experienced has a better method of doing something like this. 

  


One problem I notice frequently with a great majority of eas is the static nature of lines used for points of interest. (Moving averages, vwaps, envelopes, etc) Only in the [strategy tester](https://www.mql5.com/en/articles/239 "Article: The Fundamentals of Testing in MetaTrader 5 ") do you find the best settings overall but rarely does one find a dynamic strategy which self-optimizes based on correlation. 

  


The greatest problem I see with this inherent flaw is the likelihood for settings to become overfitted, and quickly rendered useless in ever changing market conditions.

  * [RSI & Momentum Color+Alarm](https://www.mql5.com/en/forum/175084/4272530#comment_4272530)
  * [Simple Custom Indicators using Math.](https://www.mql5.com/en/forum/132157)
  * [Optimisation! Share your experiences, please.](https://www.mql5.com/en/forum/399506/32077376#comment_32077376)



![](https://c.mql5.com/avatar/avatar_na2.png)

[Deleted] 2023.10.09 20:42 [#1](/en/forum/455444#comment_49837278 "Permanent link")

Your topic has been moved to the section: [Technical Indicators  
](/en/forum/indicators)Please consider which section is most appropriate — [https://www.mql5.com/en/forum/172166/page6#comment_49114893](/en/forum/172166/page6#comment_49114893)

![](https://c.mql5.com/avatar/avatar_na2.png)

[Deleted] 2023.10.09 20:42 [#2](/en/forum/455444#comment_49837281 "Permanent link")

  * Usually people who can't code don't receive free help on this forum.
  * If you show your attempts and describe your problem clearly, you will most probably receive an answer from the community. [Use the **CODE button (Alt-S)**](/en/articles/24#insert-code) when inserting code.
  * To learn MQL programming, you can research the many available [Articles](/en/articles) on the subject, or examples [in the Codebase](/en/code), as well as reference the online [Documentation](/en/docs).   

  * If you do not want to learn to code, that is not a problem. You can either [look at the Codebase](/en/code) if something free already exists, or in [the Market](/en/market) for paid products (also sometimes free). However, recommendations or suggestions for [Market](/en/market) products are not allowed on the forum, so you will have to do your own research.   

  * Finally, you also have the option to hire a programmer in the [Freelance section](/en/job).  




[How do I code](https://www.mql5.com/en/forum/457789/50656836#comment_50656836 "How do I code in an indicator?") [EA, OnChartEvent, HotKey scripts](https://www.mql5.com/en/forum/460138/51553193#comment_51553193 "EA, OnChartEvent, HotKey scripts ?") [please a person remove](https://www.mql5.com/en/forum/457719/50626868#comment_50626868 "please a person remove zero divide error from this EA")

![Conor Mcnamara](https://c.mql5.com/avatar/2025/9/68dab3ec-4506.png)

11460

[Conor Mcnamara](/en/users/phade) 2023.10.09 23:10 [#3](/en/forum/455444#comment_49840006 "Permanent link")

I think there were some creative "self optimising" vwap indicators on the marketplace (not free). Maybe you should take a look there, or are you sure the idea hasn't been put into action already? 

[Copyright - indicator based](https://www.mql5.com/en/forum/160765/3829439#comment_3829439 "Copyright - indicator based on someone elses work.") [Is there an EA](https://www.mql5.com/en/forum/349977/28408008#comment_28408008 "Is there an EA which automatically enters trades at a given entry, SL and TP?") [EURUSD - Trends, Forecasts](https://www.mql5.com/en/forum/404904/33854278#comment_33854278 "EURUSD - Trends, Forecasts and Implications \(Part 2\)")

![Skyler James Lee](https://c.mql5.com/avatar/2023/2/63ed2394-e552.jpg)

307

[Skyler James Lee](/en/users/skylerlee) 2023.10.30 15:13 [#4](/en/forum/455444#comment_50224438 "Permanent link")

**Conor Mcnamara[#](/en/forum/455444#comment_49840006):**  
I think there were some creative "self optimising" vwap indicators on the marketplace (not free). Maybe you should take a look there, or are you sure the idea hasn't been put into action already?

If there is, I haven't found anything. Marketplace indicators won't do me any good. I am looking to build this myself or pay to have it coded for me to save some time, because marketplace indicators don't come with source code. I don't know of any indicators which do this in this way. I had another idea, involving casting each period into a correlation matrix, although I think it might be a better idea to do that with use moving averages instead, and anchor them by truncating the infinite series of averaging periods at highs and lows. I came here hoping I could openly brainstorm with others and hopefully to learn alternative ways of doing this before I embark on the project. I will keep this updated as I progress, as things come to fruition, I may post developments, share code, etc. 

[Coding Documentation and Trading](https://www.mql5.com/en/forum/199811 "Coding Documentation and Trading Help Needed") [How to write an](https://www.mql5.com/en/forum/442539/45270644#comment_45270644 "How to write an EA?") [Jurik](https://www.mql5.com/en/forum/173010/4210897#comment_4210897 "Jurik")

![Lorentzos Roussos](https://c.mql5.com/avatar/2025/3/67c6d936-d959.jpg)

49235

[Lorentzos Roussos](/en/users/lorio) 2023.10.31 20:43 [#5](/en/forum/455444#comment_50257117 "Permanent link")

**Skyler James Lee :**  
I was brainstorming the other day wondering how one would go about coding something like this logically. I had an idea involving plotting a 1 period sma on the highest highs of each candle (for example's sake) then with a vwap on a higher timeframe create a variable which runs through each possible period from each lowest low or highest high as an anchor point. For each period, I would measure the amount of times this 1 sma is within a small envelope surrounding each vwap line. I would take the number of periods the sma was in this envelope, divide it by its current number of periods, and save it into a new variable if it is of higher correlation than the previous. Essentially what I should be left with is the VWAP line which was most respected in terms of correlation. From here I should be able to assign the desired anchor point and use this line as my point of interest until a VWAP with a greater correlation coefficient presents itself. 

  


I thought I should write this idea down somewhere before I forgot it and figured I might as well share it in case anyone more experienced has a better method of doing something like this. 

  


One problem I notice frequently with a great majority of eas is the static nature of lines used for points of interest. (Moving averages, vwaps, envelopes, etc) Only in the [strategy tester](/en/articles/239 "Article: The Fundamentals of Testing in MetaTrader 5 ") do you find the best settings overall but rarely does one find a dynamic strategy which self-optimizes based on correlation. 

  


The greatest problem I see with this inherent flaw is the likelihood for settings to become overfitted, and quickly rendered useless in ever changing market conditions. 

Won't the vwap diverge out of correlation anyway ? (because it becomes less sensitive as new bars come in.)

Also if it is intended for SR then you are not looking for correlation as the moment the price "hits" it it will diverge again

If you'd set some hard rules you could attempt at letting the machine do the work for you.

Some ideas :

  * The anchored vwap starts with a new high or a new low.
  * Previous anchored vwaps stop when a new one begins.
  * When the price breaks a vwap (without starting a new one) you create a signal.
  * The signal has properties like distance in bars from creation ,distance in price (of the vwap) from the pivot point that created it and type
  * Then you monitor the signal and it's outcome
  * You take all signals and store them 
  * You export the stored data to excel and let the Excel solver figure out if theres any edge there (i.e accept only between 2 distances in bars and price etc)



[Arbitration Advisor](https://www.mql5.com/en/forum/409951/36485906#comment_36485906 "Arbitration Advisor") [Creating a BUY/SELL order](https://www.mql5.com/en/forum/358888 "Creating a BUY/SELL order at touch of indicator") [Elite indicators :)](https://www.mql5.com/en/forum/175037/4588513#comment_4588513 "Elite indicators :\)")

[](/en/forum "Root")[](/en/forum/indicators "Category: Technical Indicators")

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


