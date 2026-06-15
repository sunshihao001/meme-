# EN_动态STF流动性扫荡指标_适合假突破与快速回收

> 来源标题：Building a Dynamic STF Liquidity Sweep Indicator in MQL5 - MQL5 Articles
> 来源链接：https://www.mql5.com/en/articles/22140
> 下载时间：2026-06-13 00:08:32
> 用途：补充 meme 市场庄家控盘、深洗、诱多、二次确认相关语义。

---

__

[ __](/en/articles/22140?print= "Printer friendly version")

![preview](data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAsICAoIBwsKCQoNDAsNERwSEQ8PESIZGhQcKSQrKigkJyctMkA3LTA9MCcnOEw5PUNFSElIKzZPVU5GVEBHSEX/2wBDAQwNDREPESESEiFFLicuRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUX/wAARCAAQACADASIAAhEBAxEB/8QAFwAAAwEAAAAAAAAAAAAAAAAAAgMEBv/EAB4QAAMAAgEFAAAAAAAAAAAAAAABAgMRMQQTIVFx/8QAFgEBAQEAAAAAAAAAAAAAAAAABAID/8QAFxEBAQEBAAAAAAAAAAAAAAAAAAIBEf/aAAwDAQACEQMRAD8A3XdhPTpDFllcPZNpIKfojg+0snN68DV1FJckkUNVojZazT//2Q==)

![Building a Dynamic STF Liquidity Sweep Indicator in MQL5](https://c.mql5.com/2/217/22140-building-a-dynamic-stf-liquidity-sweep-indicator-in-mql5_600x314.jpg)

# Building a Dynamic STF Liquidity Sweep Indicator in MQL5

[MetaTrader 5](/en/articles/mt5) — [Examples](/en/articles/mt5/examples) | 28 May 2026, 13:07

![](https://c.mql5.com/i/icons.svg#views-usage) 1 911  [ ![](https://c.mql5.com/i/icons.svg#comments-usage) 1 ](/en/forum/510370 "Comments")

![Chukwubuikem Okeke](https://c.mql5.com/avatar/2025/10/68e38c38-0777.jpg)

[Chukwubuikem Okeke](/en/users/bikeen)

### Introduction

I still remember staring at price charts, repeatedly asking myself questions every trader eventually encounters: Why does price often take out stop-losses before moving in the anticipated direction? What truly drives the market? Why do bullish moves often push downward before rallying aggressively?

The deeper I observed market behavior, the clearer it became that price movements were not entirely random. Behind many of these seemingly deceptive moves was a recurring concept—liquidity—a concept that resonates strongly with modern traders and MQL5 developers alike. It explained why price frequently sweeps above highs or below lows before reversing with strong momentum. What initially appeared to be random market manipulation gradually revealed itself as a structured process of liquidity collection performed by institutional participants.

However, understanding the concept as a trader was one thing; implementing it programmatically in MQL5 was an entirely different challenge. Like many developers, I found that most liquidity sweep indicators use either basic wick-based logic or a fixed sweep time window. These approaches can work in some market conditions. However, they often miss liquidity grabs that develop through extended or irregular price formations. Consequently, many valid sweep events are either identified too late or missed entirely.

This article addresses that challenge by building a Dynamic Single-Timeframe (STF) Liquidity Sweep Indicator in MQL5 capable of detecting liquidity sweeps regardless of how long the setup takes to form. Rather than relying solely on static wick logic, the indicator incorporates:

  * Dynamic sweep detection 
  * Wick-ratio validation 
  * Dual-candle sweep detection (Engulfing pattern) 
  * One-sweep-per-level validation rule 
  * Post-violation liquidity sweep invalidation 



These mechanisms improve detection accuracy while significantly reducing false signals.

###   


### Understanding the Concept  


In financial markets, liquidity refers to the availability of buy and sell orders within a particular price region. It represents the pool of resting orders that market participants place around key market structures such as swing highs, swing lows, equal highs and lows, and consolidation ranges. These areas attract stop-loss orders, breakout entries, and pending orders. As a result, price often reacts strongly around them.

Within Smart Money Concepts (SMC), it is commonly said that liquidity drives the market. This idea is based on the belief that price is constantly seeking areas where large concentrations of orders exist. Since institutional participants require significant opposing orders to efficiently enter or exit positions without causing excessive price imbalance, the markets frequently move toward these liquidity pools.

###   


### Types of Liquidity in Smart Money Concepts

In SMC, liquidity refers to areas in the market where large clusters of pending orders, stop-losses, or trapped trader positions are concentrated. These areas provide the necessary volume for institutional participants to execute large positions efficiently. 

Liquidity is generally categorized into two primary forms:

_Buy-Side Liquidity_ : Refers to the concentration of resting buy orders above the current market price, where breakout buyers place buy-stop pending orders and short sellers position their stop-losses. These liquidity pools are commonly found above swing highs, equal highs, and consolidation ranges (resistance levels).

![Buy-Side Liquidity](https://c.mql5.com/2/214/Buy-side_liquidity.png)

Fig. 1. Buy-Side Liquidity

_Sell-Side Liquidity_ : Emerges as the concentration of resting sell orders below the current market price, where breakout sellers place sell-stop pending orders and long traders position their stop-losses. These liquidity pools reside at lower price levels such as swing lows, equal lows, and consolidation ranges (support levels).

![Sell-Side Liquidity](https://c.mql5.com/2/214/Sell-side_liquidity.png)

Fig. 2. Sell-Side Liquidity

Price often seeks out these areas before establishing its true directional move, a phenomenon commonly known as liquidity __ sweep. 

Liquidity sweeps generally manifest in two primary forms depending on how price interacts with the targeted liquidity level and how quickly the market reclaims the swept zone:

  * _Wick Sweep_ : Occurs when one candle aggressively trades above or below a key liquidity zone, briefly triggering resting stop-losses and breakout orders before rapidly reversing back within range. This type of sweep is characterized by long wicks or rejection tails, indicating immediate absorption of liquidity and strong market rejection from the swept area.



![Wick sweep](https://c.mql5.com/2/214/Wick_sweep.png)

Fig. 3. Wick Sweep

  * _Dual-Candle Sweep_ : Consists of a two-candle sequence in which the first candle temporarily breaches a liquidity level, while the following candle retraces and closes back within the swept range. For additional confirmation, the recovery candle is required to form an engulfing pattern, signaling a potential shift in order flow and reinforcing the validity of the liquidity sweep.



![Dual-candle sweep](https://c.mql5.com/2/214/Dual-candle_sweep.png)

Fig. 4. Dual-Candle Sweep

###   


### MQL5 Implementation

Having established the foundational concepts of liquidity, along with the visual models used to identify them on price charts, the next step is to translate these ideas into practical implementation. In this section, we model liquidity concepts using native MQL5 constructs. This enables rule-based detection, market-structure analysis, and automated liquidity mapping in MetaTrader 5.

**Compiler Directives**

We begin by defining the compiler directives, which specify the program metadata and compilation behavior of the MQL5 indicator. This is followed by the inclusion of the required standard library dependencies and the declaration of reusable constants that will be referenced throughout the implementation, improving consistency, readability, and maintainability. 
    
    
    //+------------------------------------------------------------------+
    //|                               Liquidity Sweep Sentinel (STF).mq5 |
    //|                                             © 2026, ChukwuBuikem |
    //|                             https://www.mql5.com/en/users/bikeen |
    //+------------------------------------------------------------------+
    #property copyright "© 2026, ChukwuBuikem"
    #property link      "https://www.mql5.com/en/users/bikeen"
    #property version   "1.00"
    #property indicator_chart_window
    #property  indicator_plots 0
    
    #include <ChartObjects\ChartObjectsTxtControls.mqh>
    #include <ChartObjects\ChartObjectsLines.mqh>
    
    #define PROG_NAME "Liquidity Sweep Sentinel (STF)"
    #define TRENDLINE PROG_NAME + "_Trendline"
    #define TEXT PROG_NAME + "_Text"
    #define CHART_ID ChartID()
    #define MIN_WICK_RATIO 45

**Custom Data Structure**

To efficiently model and track liquidity sweep events, we define a custom data structure using the struct construct provided by MQL5.
    
    
    //--- Custom data structure
    struct st_LiquiditySweep
      {
       //---+
       double            swingPrice;  //Swing point price
       datetime          swingTime;   //Swing point timestamp
       bool              swept;       //Swing point sweep flag
       // constructor
                         st_LiquiditySweep(): swingPrice(EMPTY_VALUE),
                         swingTime(LONG_MIN), swept(false) {}
      };

Explanation:

This structure encapsulates the essential properties associated with a liquidity sweep candidate.   


  * _swingPrice_ : Stores the price value of the identified swing point.
  * _swingTime_ : Records the timestamp at which the swing point was formed.
  * _swept_ : Boolean flag used to track whether the analyzed swing point has already been swept by price.
  * _Constructor_ : Initializes all structure members with safe default values to prevent undefined behavior during runtime.



**Indicator Settings**

The following input parameters define the configurable behavior and visual appearance of the liquidity sweep indicator. By exposing these values as input variables, traders can dynamically customize the sensitivity of swing detection and the graphical representation of liquidity zones directly from the indicator settings panel. 
    
    
    //--- Indicator settings
    input int rightLeftBars = 3;                //Pivot strength (bars on each side)
    input color buyLiquidityColor = clrRed;     //Color for Buy-side liquidity
    input color sellLiquidityColor = clrPurple; //Color for Sell-side liquidity
    

Explanation:

  * _rightLeftBars_ _:_ Determines the pivot strength by specifying the number of neighboring bars required on both the left and right sides of a candle to validate a swing high or swing low.
  * _buyLiquidityColor and _sellLiquidityColor__ : Define the drawing colors used to visually represent Buy-side and Sell-side liquidity zones on the chart, respectively.



**Global State Variables**

With the core data structure in place, we now transition to defining the program’s global variables. These serve as shared instances that persist across the program lifecycle, enabling coordinated access to both data and interface components.
    
    
    //--- Global state variables
    CChartObjectText text;
    CChartObjectTrend trendLine;
    int barIndex = -1;
    st_LiquiditySweep buySideLiquidity, sellSideLiquidity;
    st_LiquiditySweep sweeps[], violates[];
    

Explanation:

  * _text_ : An instance of CChartObjectText, used to create text objects for rendering liquidity-related annotations directly on the chart.
  * _trendLine_ : Standard library CChartObjectTrend instance, used to mark liquidity sweep levels visually.
  * _barIndex_ : Stores the index of the currently analyzed bar within the OnCalculate event handler.
  * _buySideLiquidity and sellSideLiquidity_ : Instances of the st_LiquiditySweep structure, used to store and manage the currently detected Buy-side and Sell-side liquidity level.
  * _sweeps[] and violates[]_ : Dynamic array instances of the st_LiquiditySweep structure used to store previously swept and previously violated swing points, respectively. These arrays support the implementation of the “one sweep per level” rule by preventing duplicate sweep detections on the same liquidity level, while also avoiding invalid post-violation sweep detections once a liquidity level has been structurally breached.



This state-management layer forms the foundation for maintaining historical liquidity context during real-time market analysis.

**Utility Functions**

To improve modularity and maintain clean separation of responsibilities, several utility functions are introduced throughout the implementation. These helper functions encapsulate reusable operations such as candle-state validation, swing analysis, array management, and liquidity sweep event visualization.

  * New Candle Detection



Efficient liquidity analysis requires the indicator to distinguish between an actively forming candle and a fully closed candle. The following utility function performs new-candle detection by monitoring changes in the opening timestamp of incoming price bars. This ensures that liquidity calculations and sweep validations are executed only once per completed candle, preventing redundant processing during intra-bar price updates.
    
    
    //+------------------------------------------------------------------+
    //|                  New candle detection                            |
    //+------------------------------------------------------------------+
    bool isNewCandle(const datetime newOpenTime)
      {
    //---
       static datetime lastOpenTime = LONG_MIN;
       if(lastOpenTime == LONG_MIN)
         {
          lastOpenTime = newOpenTime;
          return false;
         }
       if(lastOpenTime != newOpenTime)
         {
          lastOpenTime = newOpenTime;
          return true;
         }
       return false;
      }

  * Swing Analysis

The following utility functions implement a rule-based swing detection mechanism using a left-right bar comparison model. A candle is only considered a valid swing point if its high or low exceeds neighboring candles within a configurable lookback/lookforward range (rightLeftBars). Additional helper functions are then used to locate the next valid swing high or swing low after a given starting position. 
    
    
    //+------------------------------------------------------------------+
    //|                Swing high detection                              |
    //+------------------------------------------------------------------+
    bool isSwingHigh(const int index, const MqlRates &rates[])
      {
    //---
       int totalBars = ArraySize(rates);
    //--- Index boundary validation
       if(index < rightLeftBars)
          return false;
       if(index >= totalBars - rightLeftBars)
          return false;
    
       for(int w = 1; w <= rightLeftBars && (index - w) >= 1; w++)
         {
          //--- Look right
          if(rates[index].high < rates[index - w].high)
             return false;
          //--- Look left
          if(rates[index].high < rates[index + w].high)
             return false;
         }
       return true;
      }
    //+------------------------------------------------------------------+
    //|                 Swing low detection                              |
    //+------------------------------------------------------------------+
    bool isSwingLow(const int index, const MqlRates &rates[])
      {
    //---
       int totalBars = ArraySize(rates);
    //--- Index boundary validation
       if(index < rightLeftBars)
          return false;
       if(index >= totalBars - rightLeftBars)
          return false;
    
       for(int w = 1; w <= rightLeftBars && (index - w) >= 1; w++)
         {
          if(index - w < 1)
             return false;
          //--- Look right
          if(rates[index].low > rates[index - w].low)
             return false;
          //--- Look left
          if(rates[index].low > rates[index + w].low)
             return false;
         }
       return true;
      }
    //+------------------------------------------------------------------+
    //|            Obtain the index of next swing high                   |
    //+------------------------------------------------------------------+
    int getNextSwingHighIndex(const int startIndex, const double minPrice)
      {
    //---
       MqlRates rates[] = {};
       ArraySetAsSeries(rates, true);
       int bars = Bars(_Symbol, PERIOD_CURRENT);
       if(CopyRates(_Symbol, PERIOD_CURRENT, 0, bars, rates) < bars)
          return -1;
    
       for(int w = startIndex + 1; w <= bars - (rightLeftBars + 1); w++)
         {
          if(isSwingHigh(w, rates))
             //--- High must be higher than minimum price
             if(rates[w].high > minPrice)
                return w;
         }
       return -1;// Invalid index
      }
    //+------------------------------------------------------------------+
    //|            Obtain the index of next swing low                    |
    //+------------------------------------------------------------------+
    int getNextSwingLowIndex(const int startIndex, const double maxPrice)
      {
    //---
       MqlRates rates[] = {};
       ArraySetAsSeries(rates, true);
       int bars = Bars(_Symbol, PERIOD_CURRENT);
    
       if(CopyRates(_Symbol, PERIOD_CURRENT, 0, bars, rates) < bars)
          return -1;
    
       for(int w = startIndex + 1; w <= bars - (rightLeftBars + 1); w++)
         {
          if(isSwingLow(w, rates))
             //--- Low must be lower than Maximum price
             if(rates[w].low < maxPrice)
                return w;
         }
       return -1;// Invalid index
      }

Explanation:

  * _isSwingHigh()_ : Determines whether a candle at a specified index qualifies as swing****high.
  * _isSwingLow()_ : Determines whether a candle at a specified index qualifies as swing low.
  * _getNextSwingHighIndex()_ : Searches for the next valid swing high after a specified starting index. Only swing highs whose price exceeds the supplied minimum threshold are accepted.
  * _getNextSwingLowIndex()_ : Obtains the index of the next valid swing low after a specified starting position. This function mirrors the swing-high logic but focuses on bearish structural movement by identifying subsequent swing lows. Only lows below the specified threshold are considered valid.

Together, these functions form a dynamic swing-search engine that detects both historical and newly formed swing highs and lows. Through localized candle validation and forward index scanning, the system can efficiently locate structural turning points while adapting to continuously evolving price action.  


  * Engulfing Pattern Detection



To improve confirmation accuracy, the system implements engulfing pattern detection to identify strong momentum shifts in price action. By validating bullish and bearish engulfing formations, the system can better validate potential reversals following liquidity sweeps and reduce weak or misleading signals.
    
    
    //+------------------------------------------------------------------+
    //|              Bullish engulfing detection                         |
    //+------------------------------------------------------------------+
    bool isBullishEngulfing(const double currOpen, const double currClose,
                            const double prevOpen, const double prevClose)
      {
    //---
       return (prevClose < prevOpen && currClose > currOpen
               && currOpen <= prevClose && currClose > prevOpen);
      }
    //+------------------------------------------------------------------+
    //|              Bearish engulfing detection                         |
    //+------------------------------------------------------------------+
    bool isBearishEngulfing(const double currOpen, const double currClose,
                            const double prevOpen, const double prevClose)
      {
    //---
       return (prevClose > prevOpen && currClose < currOpen &&
               currOpen >= prevClose && currClose < prevOpen);
      }

  * Wick-Ratio Validation



To support precise liquidity sweep detection, wick-ratio validation functions are introduced. These utilities quantify the relative size of a candle’s upper and lower wicks as a percentage of the total candle range. This helps identify strong rejection behavior commonly associated with wick-sweeps while filtering out structurally weak candles.
    
    
    //+------------------------------------------------------------------+
    //|             Upper wick ratio validation                          |
    //+------------------------------------------------------------------+
    int upperWickRatio(const double open, const double high,
                       const double low, const double close)
      {
    //---
       double candleRange = high - low;
       double ratio = (high - MathMax(open, close)) / candleRange;
       ratio = NormalizeDouble(ratio, 2);
    
       return (int)(ratio * 100);
      }
    //+------------------------------------------------------------------+
    //|                Lower wick ratio validation                       |
    //+------------------------------------------------------------------+
    int lowerWickRatio(const double open, const double high,
                       const double low, const double close)
      {
    //---
       double candleRange = high - low;
       double ratio = (MathMin(open, close) - low) / candleRange;
       ratio = NormalizeDouble(ratio, 2);
    
       return (int)(ratio * 100);
      }

  * Array Management



To maintain an efficient and structured workflow for storing and validating liquidity-related data, a set of helper functions is introduced for dynamic array management. These utilities handle safe insertion of new elements and fast lookup of existing swing points, ensuring data integrity during real-time market analysis.
    
    
    //+------------------------------------------------------------------+
    //|                     Storage helper                               |
    //+------------------------------------------------------------------+
    bool append(const st_LiquiditySweep &value, st_LiquiditySweep &destArr[])
      {
    //---
       if(ArrayResize(destArr, ArraySize(destArr) + 1) == -1)
          return false;
    
       destArr[ArraySize(destArr) - 1] = value;
    
       return true;
      }
    //+------------------------------------------------------------------+
    //|                        Search helper                             |
    //+------------------------------------------------------------------+
    bool isExist(const datetime swingTime, const st_LiquiditySweep &searchArr[])
      {
    //---
       for(int w = ArraySize(searchArr) - 1; w >= 0; w--)
         {
          if(searchArr[w].swingTime == swingTime)
            {
             return true;
            }
         }
       return false;
      }

Explanation:

  * _append()__:_ Safely appends a new st_LiquiditySweep instance to a dynamic array.
  * _isExist()_ : This function checks whether a given swing timestamp already exists in the stored liquidity sweep array.



Together, these helper functions ensure controlled memory growth and prevent duplicate processing of identical swing points, reinforcing the reliability of the liquidity sweep tracking system. 

  * Visualization



These functions utilize standard library instances of CChartObjectTrend and CChartObjectText, enabling simplified and reliable access to graphical object creation and manipulation. By leveraging these standard library classes, the implementation ensures consistent object handling while reducing the complexity typically associated with direct chart object management in MQL5.
    
    
    //+------------------------------------------------------------------+
    //|                   Trendline creation                             |
    //+------------------------------------------------------------------+
    void drawTrendline(const string objName, const datetime time1,
                       const double price1, const datetime time2,
                       const double price2, const color clr,
                       const int width, const string tooltip)
      {
    //---
       if(trendLine.Create(CHART_ID, objName, 0, time1, price1, time2, price2))
         {
          trendLine.Color(clr);
          trendLine.Width(width);
          trendLine.Tooltip(tooltip);
          trendLine.SetInteger(OBJPROP_HIDDEN, true);
         }
      }
    //+------------------------------------------------------------------+
    //|                     Text creation                                |
    //+------------------------------------------------------------------+
    void createText(const string objName, const datetime time,
                    const double price, const color clr, const string display,
                    const int fontSize = 10, const string font = "Arial")
      {
    //---
       if(text.Create(CHART_ID, objName, 0, time, price))
         {
          text.Color(clr);
          text.Font(font);
          text.FontSize(fontSize);
          text.Tooltip(display);
          text.SetString(OBJPROP_TEXT, display);
          text.SetInteger(OBJPROP_HIDDEN, true);
         }
      }

**Initialization and Cleanup**

The initialization phase establishes the baseline market structure required for liquidity sweep detection. During OnInit(), the indicator performs a historical scan to identify initial swing highs and lows that are higher or lower than recent closed candle values, respectively. Additionally, cleanup logic in OnDeinit() ensures proper removal of all graphical objects associated with the indicator to maintain chart integrity.
    
    
    //+------------------------------------------------------------------+
    //|                   Initialization function                        |
    //+------------------------------------------------------------------+
    int OnInit()
      {
    //---
       MqlRates rates[];
       ArraySetAsSeries(rates, true);
       if(CopyRates(_Symbol, PERIOD_CURRENT, 0, iBars(_Symbol, PERIOD_CURRENT), rates) > 0)
         {
          if((barIndex = getNextSwingHighIndex(rightLeftBars, iHigh(_Symbol, PERIOD_CURRENT, 1))) != -1)
            {
             buySideLiquidity.swept = false;
             buySideLiquidity.swingPrice = rates[barIndex].high;
             buySideLiquidity.swingTime = rates[barIndex].time;
            }
          if((barIndex = getNextSwingLowIndex(rightLeftBars, iLow(_Symbol, PERIOD_CURRENT, 1))) != -1)
            {
             sellSideLiquidity.swept = false;
             sellSideLiquidity.swingPrice = rates[barIndex].low;
             sellSideLiquidity.swingTime = rates[barIndex].time;
            }
         }
       return(INIT_SUCCEEDED);
      }
    //+------------------------------------------------------------------+
    //|                   Deinitialization function                      |
    //+------------------------------------------------------------------+
    void OnDeinit(const int32_t reason)
      {
    //--- Clear chart
       ObjectsDeleteAll(CHART_ID, PROG_NAME);
       ChartRedraw(CHART_ID);
      }

**Core Engine (OnCalculate)**

The OnCalculate() function serves as the core execution engine of the indicator, handling real-time liquidity analysis, sweep detection, and structural updates. To reduce computational overhead, the logic runs only when a new candle forms. This ensures a significant reduction in runtime load while maintaining accurate market structure tracking. 
    
    
    //+------------------------------------------------------------------+
    //|               Core Engine (OnCalculate)                          |
    //+------------------------------------------------------------------+
    int OnCalculate(const int32_t rates_total,
                    const int32_t prev_calculated,
                    const datetime &time[],
                    const double &open[],
                    const double &high[],
                    const double &low[],
                    const double &close[],
                    const long &tick_volume[],
                    const long &volume[],
                    const int32_t &spread[])
      {
    //---
       if(isNewCandle(time[rates_total - 1]))
         {
          ArraySetAsSeries(open, true);
          ArraySetAsSeries(high, true);
          ArraySetAsSeries(low, true);
          ArraySetAsSeries(close, true);
          ArraySetAsSeries(time, true);
          //--- SWEEP DETECTION
          //--- Buy-side liquidity sweeps: Wick and Dual-candle sweep
          if((!buySideLiquidity.swept &&  high[1] >= buySideLiquidity.swingPrice &&
              close[1] < buySideLiquidity.swingPrice && open[1] < buySideLiquidity.swingPrice &&
              upperWickRatio(open[1], high[1], low[1], close[1]) >= MIN_WICK_RATIO) ||
             (!buySideLiquidity.swept &&  close[2] > buySideLiquidity.swingPrice &&
              close[1] < buySideLiquidity.swingPrice && isBearishEngulfing(open[1], close[1], open[2], close[2])))
            {
             if(!isExist(buySideLiquidity.swingTime, sweeps) && !isExist(buySideLiquidity.swingTime, violates))
               {
                buySideLiquidity.swept = true;
                //--- Append to sweep array
                if(!append(buySideLiquidity, sweeps))
                  {
                   Print("[RUNTIME]: Failed to append Buy-side LQ to sweep array.");
                  }
                //--- Mark level with trendline and text
                drawTrendline(TRENDLINE + "Buy-side", buySideLiquidity.swingTime, buySideLiquidity.swingPrice, time[1],
                              buySideLiquidity.swingPrice, buyLiquidityColor, 2, "Buy-side LQ");
                createText(TEXT + "Buy-side", buySideLiquidity.swingTime + PeriodSeconds(),
                           buySideLiquidity.swingPrice + (20 * _Point), buyLiquidityColor, "Buy-side LQ");
                ChartRedraw(CHART_ID);
               }
             //--- Scan for older swing high (next liquidity target)
             if((barIndex = getNextSwingHighIndex(iBarShift(_Symbol, PERIOD_CURRENT, buySideLiquidity.swingTime),
                                                  buySideLiquidity.swingPrice)) != -1)
               {
                buySideLiquidity.swingPrice = high[barIndex];
                buySideLiquidity.swingTime = time[barIndex];
                buySideLiquidity.swept = false;
               }
             return rates_total;
            }
          //--- Sell-side liquidity sweeps: Wick and Dual-candle sweep
          if((!sellSideLiquidity.swept && low[1] <= sellSideLiquidity.swingPrice &&
              close[1] > sellSideLiquidity.swingPrice && open[1] > sellSideLiquidity.swingPrice &&
              lowerWickRatio(open[1], high[1], low[1], close[1]) >= MIN_WICK_RATIO) ||
             (!sellSideLiquidity.swept && close[2] < sellSideLiquidity.swingPrice &&
              close[1] > sellSideLiquidity.swingPrice && isBullishEngulfing(open[1], close[1], open[2], close[2])))
            {
             if(!isExist(sellSideLiquidity.swingTime, sweeps) && !isExist(sellSideLiquidity.swingTime, violates))
               {
                sellSideLiquidity.swept = true;
                //--- Append to sweep array
                if(!append(sellSideLiquidity, sweeps))
                  {
                   Print("[RUNTIME]: Failed to append Sell-side LQ to sweep array.");
                  }
                //--- Mark level with trendline and text
                drawTrendline(TRENDLINE + "Sell-Side", sellSideLiquidity.swingTime, sellSideLiquidity.swingPrice, time[1],
                              sellSideLiquidity.swingPrice, sellLiquidityColor, 2, "Sell-side LQ");
                createText(TEXT + "Sell-Side", sellSideLiquidity.swingTime + PeriodSeconds(),
                           sellSideLiquidity.swingPrice - (10 * _Point), sellLiquidityColor, "Sell-side LQ");
                ChartRedraw(CHART_ID);
               }
             //--- Scan for older swing low (next liquidity target)
             if((barIndex = getNextSwingLowIndex(iBarShift(_Symbol, PERIOD_CURRENT, sellSideLiquidity.swingTime),
                                                 sellSideLiquidity.swingPrice)) != -1)
               {
                sellSideLiquidity.swingPrice = low[barIndex];
                sellSideLiquidity.swingTime = time[barIndex];
                sellSideLiquidity.swept = false;
               }
             return rates_total;
            }
          //--- SWEEP VIOLATION
          //--- Buy-side liquidity violation
          if((!buySideLiquidity.swept && close[2] > buySideLiquidity.swingPrice && close[1] > buySideLiquidity.swingPrice) ||
             (!buySideLiquidity.swept &&  close[2] > buySideLiquidity.swingPrice && close[1] < buySideLiquidity.swingPrice &&
              !isBearishEngulfing(open[1], close[1], open[2], close[2])) ||
             (!buySideLiquidity.swept && close[1] > buySideLiquidity.swingPrice))
            {
             buySideLiquidity.swept = true;
             //--- Append to violate array
             if(!append(buySideLiquidity, violates))
               {
                Print("[RUNTIME]: Failed to append Buy-side LQ to violate array.");
               }
             //--- Scan for older swing high (next liquidity target)
             if((barIndex = getNextSwingHighIndex(iBarShift(_Symbol, PERIOD_CURRENT, buySideLiquidity.swingTime),
                                                  buySideLiquidity.swingPrice)) != -1)
               {
                //--- Update buy side liquidity structure
                buySideLiquidity.swingPrice = high[barIndex];
                buySideLiquidity.swingTime = time[barIndex];
                buySideLiquidity.swept = false;
               }
             return rates_total;
            }
          //--- Sell-side liquidity violation
          if((!sellSideLiquidity.swept && close[2] < sellSideLiquidity.swingPrice && close[1] < sellSideLiquidity.swingPrice) ||
             (!sellSideLiquidity.swept &&  close[2] < sellSideLiquidity.swingPrice && close[1] > buySideLiquidity.swingPrice &&
              !isBullishEngulfing(open[1], close[1], open[2], close[2])) ||
             (!sellSideLiquidity.swept && close[1] < sellSideLiquidity.swingPrice))
            {
             sellSideLiquidity.swept = true;
             //--- Append to violate array
             if(!append(sellSideLiquidity, violates))
               {
                Print("[RUNTIME]: Failed to append Sell-side LQ to violate array.");
               }
             //--- Scan for older swing low (next liquidity target)
             if((barIndex = getNextSwingLowIndex(iBarShift(_Symbol, PERIOD_CURRENT, sellSideLiquidity.swingTime)
                                                 , sellSideLiquidity.swingPrice)) != -1)
               {
                //--- Update sell side liquidity structure
                sellSideLiquidity.swingPrice = low[barIndex];
                sellSideLiquidity.swingTime = time[barIndex];
                sellSideLiquidity.swept = false;
               }
             return rates_total;
            }
          //--- NEWER SWING POINT SEARCH
          //--- Scan for swing highs closer to market price
          if((barIndex = getNextSwingHighIndex(rightLeftBars, iHigh(_Symbol, PERIOD_CURRENT, 1)))
             != -1 && time[barIndex] > buySideLiquidity.swingTime)
            {
             //--- Update buy side liquidity structure
             buySideLiquidity.swingPrice = high[barIndex];
             buySideLiquidity.swingTime = time[barIndex];
             buySideLiquidity.swept = false;
             return rates_total;
            }
          //--- Scan for swing lows closer to market price
          if((barIndex = getNextSwingLowIndex(rightLeftBars, iLow(_Symbol, PERIOD_CURRENT, 1)))
             != -1 && time[barIndex] > sellSideLiquidity.swingTime)
            {
             //--- Update sell side liquidity structure
             sellSideLiquidity.swingPrice = low[barIndex];
             sellSideLiquidity.swingTime = time[barIndex];
             sellSideLiquidity.swept = false;
             return rates_total;
            }
         }
       return(rates_total);
      }

Explanation:

Upon detection of a new candle, the core execution workflow proceeds through the following stages: 

  * _Sweep Detection_

The sweep detection logic identifies valid Buy-side and Sell-side liquidity sweeps using both single-candle wick rejection and dual-candle engulfing confirmation models. When a sweep is confirmed, the system performs the following steps sequentially:  


  1. Ensures the level is not already present in the sweeps or violates arrays.
  2. Set the sweep state flag to true. 
  3. Store the sweep in the sweeps array. 
  4. Render trendline and text annotations on the chart. 
  5. Identify and assign the next valid swing point as the new liquidity target.



  * _Sweep Violation_



Sweep violation logic handles cases where a liquidity level is invalidated or structurally broken without a proper sweep confirmation. This ensures the model does not repeatedly reference obsolete liquidity zones.

  1. Marks the current liquidity level as processed (swept = true).
  2. Stores the level in the violates array to prevent reprocessing.
  3. Advances to the next valid swing structure.



  * _Newer Swing Points Search_



In the absence of a sweep or violation event on the current candle, the engine scans for newly formed swing highs or swing lows relative to the prevailing market structure. This ensures that the active liquidity reference remains updated and aligned with evolving price action.

  1. Ensures liquidity tracking remains aligned with evolving market structure.
  2. Updates buySideLiquidity and sellSideLiquidity dynamically.
  3. Resets swept = false to re-enable future detection on the new level.



###   


### Testing

After successful compilation with no errors, the indicator output should appear as shown below:

![Liquidity Sweep Sentinel \(STF\)](https://c.mql5.com/2/215/Liquidity_Sweep_Sentinel_Indicator.png)

Fig. 5. Liquidity Sweep Sentinel Indicator (STF)

###   


### Conclusion

This brings us to the end of the Liquidity Sweep Indicator framework: a verifiable, dynamic Liquidity Sweep Sentinel designed for MetaTrader 5. The system translates Smart Money Concepts into a structured, rule-based execution model capable of identifying and tracking liquidity-driven market behavior in real time.

The indicator framework achieves the following:

  * Detects both single-candle wick-based sweeps and dual-candle liquidity sweep formations, regardless of the duration of their development. 
  * Dynamically tracks Buy-side and Sell-side liquidity levels using swing-based market structure logic. 
  * Maintains historical integrity through structured memory handling, preventing duplicate sweep detection via dedicated sweep and violation tracking arrays. 
  * Filters low-quality price action using wick-ratio validation to ensure only strong rejection events are classified as valid liquidity sweeps. 
  * Continuously adapts to evolving market structure by updating swing points in real time, ensuring liquidity references remain current.

Collectively, this framework forms a structured and extensible foundation for liquidity-based analysis in MQL5, bridging theoretical Smart Money Concepts with practical algorithmic implementation. 

**Attached files** | 

[ __Download ZIP](/en/articles/download/22140.zip "Download all attachments in the single ZIP archive")

[__Liquidity_Sweep_Sentinel_bSTFm.mq5](/en/articles/download/22140/Liquidity_Sweep_Sentinel_bSTFm.mq5 "Download Liquidity_Sweep_Sentinel_bSTFm.mq5") (19.08 KB)

**Warning:** All rights to these materials are reserved by MetaQuotes Ltd. Copying or reprinting of these materials in whole or in part is prohibited.

This article was written by a user of the site and reflects their personal views. MetaQuotes Ltd is not responsible for the accuracy of the information presented, nor for any consequences resulting from the use of the solutions, strategies or recommendations described.

![Chukwubuikem Okeke](https://c.mql5.com/avatar/2025/10/68e38c38-0777_big.jpg)

[Chukwubuikem Okeke](/en/users/bikeen "Chukwubuikem Okeke")

  * __Developer at LiteBrace
  * __[Nigeria](https://www.mql5.com/go?https://maps.google.com/?z=4&q=Nigeria "Lives")
  * __[4396](/en/users/bikeen/achievements "Rating")



* [](https://x.com/devBuike_MQL)

In Christ Alone ✝️ | MQL5 Tutor 📈   
  
  
Driven by an insatiable curiosity for the markets and a passion for problem-solving.   
I specialize in building robust Expert Advisors, custom indicators, and advanced trading utilities using MQL5.

#### Other articles by this author

  * [Building the Market Structure Sentinel Indicator in MQL5](/en/articles/22249)
  * [Adaptive Malaysian Engulfing Indicator (Part 2): Optimized Retest Bar Range](/en/articles/22420)
  * [Adaptive Malaysian Engulfing Indicator (Part 1): Pattern Detection and Retest Validation](/en/articles/22419)
  * [Account Audit System in MQL5 (Part 1): Designing the User Interface](/en/articles/22032)



**Last comments |[Go to discussion](/en/forum/510370) ** (1) 

![Aarthy Rajanbabu](https://c.mql5.com/avatar/2023/12/657A968F-D498.jpg)

**[Aarthy Rajanbabu](/en/users/aarthyr)** | 31 May 2026 at 05:01

it is not showing lines. please check the code. Thanks

![Covariance Matrix Adaptation Evolution Strategy \(CMA-ES\)](https://c.mql5.com/2/151/18227-evolucionnaya-strategiya-adaptacii-logo.png) [Covariance Matrix Adaptation Evolution Strategy (CMA-ES)](/en/articles/18227)

The article explores one of the most interesting non-gradient optimization algorithms, which learns to understand the geometry of the objective function. We will focus on the classical implementation of CMA-ES with a slight modification - replacing the normal distribution with the power one. We will thoroughly examine the math behind the algorithm, as well as practical implementation, and check where CMA-ES is unbeatable and where it should be avoided.

![Integrating AI into 3 Smart Money Concepts \(SMC\): OB, BOS, and FVG](https://c.mql5.com/2/217/22526-integrating-ai-into-3-smart-logo.png) [Integrating AI into 3 Smart Money Concepts (SMC): OB, BOS, and FVG](/en/articles/22526)

This guide integrates a trained XGBoost model (ONNX) into an SMC EA to evaluate trade setups before execution. The Python pipeline labels historical XAUUSD events and produces a 12-feature representation aligned with the EA. The result is a reproducible method to train, export, and embed the model so the EA can filter OB, FVG, and BOS signals programmatically.

![Meta-Labeling the Classics \(Part 1\): Filtering and Sizing RSI Trades](https://c.mql5.com/2/217/22274-meta-labeling-the-classics-logo.png) [Meta-Labeling the Classics (Part 1): Filtering and Sizing RSI Trades](/en/articles/22274)

RSI accumulates losses in trending conditions by firing at every threshold crossing regardless of market regime. A Random Forest secondary classifier trained on 12 contextual features — RSI momentum slope, EMA50 trend velocity, ATR-normalised trend stretch, and nine others — filters raw signals and scales position size by classifier confidence on EURUSD H1. Results compare plain RSI, meta-filtered RSI, and bet-sized RSI across a 16-month out-of-sample period with per-trade metrics and drawdown diagnostics.

![News Filtering with MetaTrader 5 Economic Calendar and CSV Fallback](https://c.mql5.com/2/216/22580-news-filtering-with-metatrader-logo.png) [News Filtering with MetaTrader 5 Economic Calendar and CSV Fallback](/en/articles/22580)

This article presents a self-contained news filter module for MetaTrader 5 built on the platform's economic calendar API. It implements symbol-to-currency mapping, pre- and post-event trading pauses, and optional position size reduction on high-impact days, with a CSV-based fallback for the Strategy Tester. A demo EA and live chart dashboard show integration and verification in both live and backtest environments.

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


