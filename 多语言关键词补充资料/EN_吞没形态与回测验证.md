# EN_吞没形态与回测验证

> 来源标题：Adaptive Malaysian Engulfing Indicator (Part 1): Pattern Detection and Retest Validation - MQL5 Articles
> 来源链接：https://www.mql5.com/en/articles/22419
> 下载时间：2026-06-12 23:28:45
> 说明：多语言关键词补充资料，供中文策略语义反向映射使用。

---

__

[ __](/en/articles/22419?print= "Printer friendly version")

![preview](data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAsICAoIBwsKCQoNDAsNERwSEQ8PESIZGhQcKSQrKigkJyctMkA3LTA9MCcnOEw5PUNFSElIKzZPVU5GVEBHSEX/2wBDAQwNDREPESESEiFFLicuRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUX/wAARCAAQACADASIAAhEBAxEB/8QAFwABAQEBAAAAAAAAAAAAAAAAAwECB//EABwQAQACAwEBAQAAAAAAAAAAAAEAAwIRQTETcf/EABUBAQEAAAAAAAAAAAAAAAAAAAID/8QAFxEBAQEBAAAAAAAAAAAAAAAAAQACEf/aAAwDAQACEQMRAD8A5jXWZeG/2J8DuiAWZY+Mpdl1lRhuZoNbSHlWb7I3r1mG1iWjxv/Z)

![Adaptive Malaysian Engulfing Indicator \(Part 1\): Pattern Detection and Retest Validation](https://c.mql5.com/2/211/ChatGPT_Image_6_pxb_2026_x_x_15_39_54_600x314.jpg)

# Adaptive Malaysian Engulfing Indicator (Part 1): Pattern Detection and Retest Validation

[MetaTrader 5](/en/articles/mt5) — [Examples](/en/articles/mt5/examples) | 12 May 2026, 11:59

![](https://c.mql5.com/i/icons.svg#views-white-usage) 4 849  [ ![](https://c.mql5.com/i/icons.svg#comments-white-usage) 0 ](/en/forum/509671 "Comments")

![Chukwubuikem Okeke](https://c.mql5.com/avatar/2025/10/68e38c38-0777.jpg)

[Chukwubuikem Okeke](/en/users/bikeen)

### Introduction

Malaysian Engulfing is a powerful candlestick cue, but in practice it breaks down in two ways: traders and developers struggle to detect truly “perfect” engulfing candles consistently in real time, and a detected candle alone gives little actionable context about what should follow (pullback, retest, invalidation). This article addresses both problems on the MetaTrader 5/MQL5 platform by turning a visual pattern into a reproducible, rule‑based process.

First, we formalize the Malaysian Engulfing definition so it can be coded unambiguously: the second candle's body must fully dominate the prior body (opening at or beyond the prior close and closing beyond the prior extreme). Second, we convert the post-pattern evolution into a lightweight state machine that programmatically tracks the setup—defines a zone (high/low), enforces an invalidation level, waits a fixed retest window (barsRetestRange), and validates returns using a wick-strength filter (wickThreshold). The deliverables are two complementary MQL5 indicators: a strict pattern detector (visual arrows) and a retest validator (zone drawing + deterministic confirmation events) that together move you from subjective chart reading to a testable, automatable workflow.

### Malaysian Engulfing Concept  


Engulfing patterns differ in informational weight. Treating them uniformly leads to inconsistent outcomes. This realization prompted a group of traders to dig deeper into chart behavior, studying not just the presence of engulfing formations, but the quality and intent behind them. The result of that deeper inquiry is what we now refer to as the Malaysian Engulfing Concept—a response to the gap between generic pattern recognition and meaningful market insight. Rather than introducing an entirely new pattern, it reframes the existing engulfing structure through a stricter, more structured lens. 

At its core, the Malaysian Engulfing Concept defines market intent more strictly. It focuses on decisive price displacement where the current candle fully consumes the prior candle's range, signaling a clear shift in order flow. More precisely, the body of the current candle must completely engulf the body of the preceding candle—extending beyond its high and low, respectively—so that the prior candle’s range is fully dominated.

_Anatomy of a Perfect Engulfing_

Understanding the logic behind the Malaysian Engulfing Concept is necessary, but on its own, it remains abstract. In live market conditions, you are not interpreting definitions—you are reading price. This is where many implementations break down: the gap between conceptual clarity and visual recognition.

To bridge that gap, the concept needs to be grounded in a precise visual model. What exactly should you see on the chart for an engulfing pattern to qualify as what Malaysian traders refer to as a "perfect" formation?

In this section, we will translate the rules into a concrete chart structure—breaking down the anatomy of a perfect Malaysian engulfing formation. This includes the exact candle relationships, the degree of range dominance required, and the conditions that distinguish a high-quality setup from a marginal one. The objective is simple: eliminate ambiguity, so that what you define in code is precisely what you recognize on the chart.

_Bullish Engulfing_ : A bullish engulfing formation represents a clear transition from selling pressure to buying dominance. It begins with a bearish candle, reflecting downward momentum, followed immediately by a bullish candle that decisively overtakes it. For the pattern to qualify as a perfect Malaysian engulfing, the body of the second candle must engulf the body of the first—opening at or below the previous close and closing above the previous high.

![Perfect Bullish Engulfing](https://c.mql5.com/2/210/Perfect_Bullish_Engulfing_-_Chart.png)

Fig. 1. Perfect Bullish Engulfing

 _Bearish Engulfing_ A bearish engulfing formation reflects the opposite transition—shifting from buying pressure to selling control. It starts with a bullish candle, indicating upward movement, followed by a bearish candle that fully consumes it. In a perfect Malaysian engulfing setup, the body of the bearish candle must entirely overtake the previous bullish body—opening at or above the prior close and closing below the prior low. 

![Perfect Bearish Engulfing](https://c.mql5.com/2/210/Perfect_Bearish_Engulfing_-_Chart.png)

Fig. 2. Perfect Bearish Engulfing 

Having established the structural logic behind the Malaysian engulfing concept, we can now shift focus to its programmatic detection—defining the exact conditions that allow the pattern to be identified consistently.

**Pattern Detection**

At this stage, the concept has been fully defined and visually grounded. The next step is to eliminate subjectivity in identifying these formations in real time.

Rather than relying on manual chart inspection, we can formalize the rules into a detection engine—an indicator that continuously scans price data and flags only those engulfing structures that meet the strict Malaysian criteria.
    
    
    //+------------------------------------------------------------------+
    //|                      Malaysian Engulfing - Pattern Detection.mq5 |
    //|                                             © 2026, ChukwuBuikem |
    //|                             https://www.mql5.com/en/users/bikeen |
    //+------------------------------------------------------------------+
    #property copyright "© 2026, ChukwuBuikem"
    #property link      "https://www.mql5.com/en/users/bikeen"
    #property version   "1.00"
    #property indicator_chart_window
    #property indicator_buffers 2
    #property indicator_plots 2
    #property indicator_type1 DRAW_ARROW
    #property indicator_color1 clrCrimson
    #property indicator_label1 "Bearish Engulfing"
    #property indicator_type2 DRAW_ARROW
    #property indicator_color2 clrLimeGreen
    #property indicator_label2 "Bullish Engulfing"
    
    #define PROG_NAME "Malaysian Engulfing - Pattern Detection"
    #define ARROW_OFFSET_FACTOR 0.25
    #define OFFSET_MIN 10 * _Point
    
    //--- Indicator buffers and global variables
    double bearishEngulfing[];
    double bullishEngulfing[];
    int start = -1;
    double candleRange = EMPTY_VALUE, offSet = EMPTY_VALUE;
    
    //+------------------------------------------------------------------+
    //|        Initialization function                                   |
    //+------------------------------------------------------------------+
    int OnInit()
      {
    //---
       SetIndexBuffer(0, bearishEngulfing);
       PlotIndexSetDouble(0, PLOT_EMPTY_VALUE, EMPTY_VALUE);
       PlotIndexSetInteger(0, PLOT_ARROW, 234);
       SetIndexBuffer(1, bullishEngulfing);
       PlotIndexSetDouble(1, PLOT_EMPTY_VALUE, EMPTY_VALUE);
       PlotIndexSetInteger(1, PLOT_ARROW, 233);
       return(INIT_SUCCEEDED);
      }
    //+------------------------------------------------------------------+
    //| Custom indicator iteration function                              |
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
       start = (prev_calculated == 0) ? 1 : prev_calculated - 1;
       for(int w = start; w < rates_total - 1 && !IsStopped(); w++)
         {
          //--- Compute normalized candle range (high–low)
          candleRange = NormalizeDouble(MathAbs(high[w] - low[w]), _Digits);
          //--- Deriv arrow offset with minimum threshold enforcement
          offSet = MathMax(candleRange * ARROW_OFFSET_FACTOR, OFFSET_MIN);
          //--- Detect bullish engulfing and position arrow below candle
          if(isBullishEngulfing(w, open, high, low, close))
            {
             bullishEngulfing[w] = low[w] - offSet;
            }
          else
            {
             bullishEngulfing[w] = EMPTY_VALUE;
            }
          //--- Detect bearish engulfing and position arrow above candle
          if(isBearishEngulfing(w, open, high, low, close))
            {
             bearishEngulfing[w] = high[w] + offSet;
            }
          else
            {
             bearishEngulfing[w] = EMPTY_VALUE;
            }
         }
       return(rates_total);
      }
    //+------------------------------------------------------------------+
    //| Function to detect perfect bullish engulfing                     |
    //+------------------------------------------------------------------+
    bool isBullishEngulfing(const int index, const double &open[], const double &high[],
                            const double &low[], const double &close[])
      {
    //---
       return(close[index - 1] < open[index - 1] && close[index] > open[index]
              && open[index] <= close[index - 1] && close[index] > high[index - 1]);
      }
    //+------------------------------------------------------------------+
    //| Function to detect perfect bearish engulfing                     |
    //+------------------------------------------------------------------+
    bool isBearishEngulfing(const int index, const double &open[], const double &high[],
                            const double &low[], const double &close[])
      {
    //---
       return(close[index - 1] > open[index - 1] && close[index] < open[index]
              && open[index] >= close[index - 1] && close[index] < low[index - 1]);
      }                                                                     

Malaysian Engulfing—Pattern Detection

Explanation:

This implementation assumes prior familiarity with the standard structure of a custom indicator; only the core logic and helper functions are clarified in detail.

  * _Compile-Time Definitions (#define):_ At the top level, a few constants are introduced to parameterize the behavior of the indicator.

ARROW_OFFSET_FACTOR — Controls how far the signal arrow is displaced from the candle.  
OFFSET_MIN — Enforces a minimum visual gap, preventing arrows from overlapping small candles.  


  * _Global Variables:_ We maintain two supporting variables.



candleRange — Stores the normalized high-low range of each candle.  


offSet — The computed displacement used to position the signal arrow. 

  *  _Candle Range Logic (OnCalculate()):_ This section implements adaptive visualization. Instead of a fixed offset, arrow placement is scaled relative to each candle’s range, ensuring markers remain visually separated from the candle body. A minimum threshold is also enforced to maintain clarity in low-volatility conditions.



  * _Helper Functions:_ The detection logic is intentionally isolated into two functions, isBullishEngulfing() and isBearishEngulfing(), ensuring a strict and consistent engulfing definition across both patterns.



After attaching the pattern detection indicator to the chart, the identified engulfing setups are visualized as shown below:

![Malaysian Engulfing Pattern Indicator](https://c.mql5.com/2/210/let_go__1.png)

Fig. 3. Pattern Detection Indicator

We now have a program that reliably flags perfect engulfing patterns. The edge is in what follows. A Malaysian engulfing event often initiates an impulsive move, then a pullback, and sometimes a retest of the engulfed zone. This sequence introduces structure. It transforms a single-candle pattern into a multi-phase process that can be tracked, measured, and ultimately automated. 

### Pullback and Retest Validation  


Once a valid Malaysian engulfing pattern has been identified, the question shifts from detection to evolution: how price behaves after the event. This is where the second layer of the system comes into play—an indicator designed not just to detect zones, but to track price interaction with them over time, identifying pullbacks and validating eventual retests.

Instead of relying on lagging confirmations or complex filtering, the approach uses a lightweight, state-driven model. As price evolves, the system transitions through clearly defined states, enabling it to track pullbacks and validate retests as they happen, with minimal delay and reduced ambiguity.

### Implementation

With the validation logic defined, the next step is to express it in code using native MQL5 constructs.

__Preprocessor Directives__

Before implementing the core logic, preprocessor directives define metadata, dependencies, and constants. They set terminal identification, required libraries, and reusable identifiers (eg, bullish/bearish zone names).
    
    
    //+------------------------------------------------------------------+
    //|                      Malaysian Engulfing - Retest Validation.mq5 |
    //|                                             © 2026, ChukwuBuikem |
    //|                             https://www.mql5.com/en/users/bikeen |
    //+------------------------------------------------------------------+
    #property copyright "© 2026, ChukwuBuikem"
    #property link      "https://www.mql5.com/en/users/bikeen"
    #property version  "1.50"
    #property indicator_chart_window
    #property indicator_plots 0
    
    #include <ChartObjects\ChartObjectsShapes.mqh>
    
    #define PROG_NAME "Malaysian Engulfing - Retest Validation"
    #define ZONE_BULL PROG_NAME + "BullishEngulfing"
    #define ZONE_BEAR PROG_NAME + "BearishEngulfing"

_State Enumeration_

At the core of the validation logic is a simple state model that defines how the system interprets market conditions over time. This is implemented through an enumeration, which assigns meaningful names to the different phases of operation.
    
    
    //--- State Enumeration
    enum ENUM_SYSTEM_STATE
      {
       SEARCH_STATE = 0, // Discovery Phase
       FOUND_STATE = 1   // Validation Phase
      };
    

_Data Structure_

The st_Engulfer structure is a compact container used to hold all relevant information about an engulfing zone as it evolves through detection and validation.
    
    
    //--- Data Structure
    struct st_Engulfer
      {
       ENUM_SYSTEM_STATE state;
       datetime          time, retestTime;
       double            high, low;
       //--- Constructor
                         st_Engulfer(): state(SEARCH_STATE), time(LONG_MIN),
                                        retestTime(LONG_MIN), high(EMPTY_VALUE), low(EMPTY_VALUE) {}
      };

  1. Members:



  * state: Tracks the current phase of the system using ENUM_SYSTEM_STATE. It determines whether the structure is searching for a pattern or validating a retest.
  * time: Stores the timestamp of when the engulfing pattern was first identified.
  * retestTime: Records the moment price returns to the zone for validation, marking a confirmed retest.
  * high and low: Define the price boundaries of the engulfing zone, forming the area to be monitored.




2\. Constructor: The constructor initializes all members to safe default values. The state starts in SEARCH_STATE , time fields are set to LONG_MIN to indicate "no valid time yet," and price levels are set to EMPTY_VALUE to show that the zone has not been defined. This ensures the structure begins in a clean, predictable state before any data is assigned.

_Configurable Parameters_

These inputs allow the behavior and appearance of the indicator to be adjusted without modifying the code.
    
    
    //--- Configurable Parameters
    input int   barsRetestRange  = 10;        // Retest window (in bars)
    input color bullishZoneColor = clrGreen;  // Bullish retest zone color
    input color bearishZoneColor = clrRed;    // Bearish retest zone color
    input int   wickThreshold    = 35;        // Minimum wick rati0 (%)

  * barsRetestRange: Defines how many candles the system will wait for a valid retest after an engulfing pattern is found.
  * bullishZoneColor: Sets the color used to draw bullish retest zones on the chart.
  * bearishZoneColor: Sets the color used to draw bearish retest zones.
  * wickThreshold: Specifies the minimum wick-to-body ratio (in percentage) required for a candle to qualify, helping filter out weak patterns.



_Global Variables_

These variables maintain state and objects that persist throughout the indicator’s execution.
    
    
    //--- Global variables
    int start = -1;
    CChartObjectRectangle rect;
    st_Engulfer bullishEngulfer, bearishEngulfer;

  * start: An integer used as the starting index in OnCalculate() for looping through price candles; initialized to -1 to indicate it will be set later based on calculation logic.
  * rect: An instance of CChartObjectRectangle, used to draw and manage a rectangle on the chart for visualizing zones or patterns.
  * bullishEngulfer and bearishEngulfer: Instances of the st_Engulfer structure, used to store and track bullish and bearish engulfing patterns independently as they progress through detection and validation.



_Helper Functions_

To support detection and validation, a set of helper functions handles three key responsibilities: identifying engulfing patterns, validating candle structure through wick ratios, and rendering zones on the chart. 

  * Pattern Detection



The first group of functions focuses on identifying valid engulfing patterns based on strict price relationships between consecutive candles.
    
    
    //+------------------------------------------------------------------+
    //|       Perfect bullish engulfing detection                        |
    //+------------------------------------------------------------------+
    bool isBullishEngulfing(const int index, const double &open[], const double &high[],
                            const double &low[], const double &close[])
      {
    //---
       return(close[index - 1] < open[index - 1] && close[index] > open[index]
              && open[index] <= close[index - 1] && close[index] > high[index - 1]);
      }
    //+------------------------------------------------------------------+
    //|       Perfect bearish engulfing detection                        |
    //+------------------------------------------------------------------+
    bool isBearishEngulfing(const int index, const double &open[], const double &high[],
                            const double &low[], const double &close[])
      {
    //---
       return(close[index - 1] > open[index - 1] && close[index] < open[index]
              && open[index] >= close[index - 1] && close[index] < low[index - 1]);
      }

These functions are inherited directly from the earlier "Pattern Detection" indicator introduced in this article. In this section, they form the foundation of the discovery phase, ensuring only strong, well-defined patterns are considered.

  * _Candle Wick Ratio Validation_



Once a pattern is detected, wick analysis helps filter out weak or indecisive candles.
    
    
    //+------------------------------------------------------------------+
    //|             Upper wick ratio validation                          |
    //+------------------------------------------------------------------+
    int upperWickRatio(const int index, const double &open[], const double &high[],
                       const double &low[], const double &close[])
      {
    //---
       double candleRange = high[index] - low[index];
       double ratio = (high[index] - MathMax(open[index], close[index])) / candleRange;
       ratio = NormalizeDouble(ratio, 2);
    
       return (int)(ratio * 100);
      }
    //+------------------------------------------------------------------+
    //|                Lower wick ratio validation                       |
    //+------------------------------------------------------------------+
    int lowerWickRatio(const int index, const double &open[], const double &high[],
                       const double &low[], const double &close[])
      {
    //---
       double candleRange = high[index] - low[index];
       double ratio = (MathMin(open[index], close[index]) - low[index]) / candleRange;
       ratio = NormalizeDouble(ratio, 2);
    
       return (int)(ratio * 100);
      }

By applying a threshold (eg, wickThreshold), the system can enforce stricter quality control on detected patterns.

  * _Zone Creation_

After a valid pattern passes structural checks, the final step is visualization. 
    
    
    //+------------------------------------------------------------------+
    //|                   Zone creation                                  |
    //+------------------------------------------------------------------+
    void createZone(const string objName, const datetime time1, const double price1,
                    const datetime time2, const double price2, const color clr)
      {
    //---
       if(rect.Create(0, objName, 0, time1, price1, time2, price2))
         {
          rect.Fill(true);
          rect.Color(clr);
          rect.Selectable(false);
          rect.Background(true);
          ChartRedraw();
         }
      }
    

This function bridges analysis and presentation, turning detected patterns into clear visual zones for monitoring pullbacks and retests.

_Initialization and Cleanup_

  *  _OnInit()_ : This function handles initialization when the indicator is loaded. It is currently reserved for the adaptive state engine, which will be introduced and expanded in later parts.


    
    
    //+------------------------------------------------------------------+
    //|        Initialization function                                   |
    //+------------------------------------------------------------------+
    int OnInit(void)
      {
    //--- Adaptive engine
    
       return(INIT_SUCCEEDED);
      }

  * _OnDeinit()_ : This function runs when the indicator is removed or reloaded. It clears all chart objects associated with the program using PROG_NAME, ensuring a clean chart state, and then refreshes the display.


    
    
    //+------------------------------------------------------------------+
    //|        Deinitialization function                                 |
    //+------------------------------------------------------------------+
    void OnDeinit(const int32_t reason)
      {
    //--- Clear chart
       ObjectsDeleteAll(0, PROG_NAME);
       ChartRedraw();
      }

_Core Engine (OnCalculate())_

The OnCalculate() function serves as the main execution loop of the indicator, processing incoming price data candle by candle. It updates only new data using prev_calculated, ensuring efficiency by avoiding redundant computations.
    
    
    //+------------------------------------------------------------------+
    //|             Core iteration function                              |
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
       if(prev_calculated != rates_total && prev_calculated > 0)
         {
          start = (prev_calculated == 0) ? 1 : prev_calculated - 1;
          for(int w = start; w < rates_total - 1 && !IsStopped(); w++)
            {
             //--- Search state
             if(bullishEngulfer.state == SEARCH_STATE)
               {
                if(isBullishEngulfing(w, open, high, low, close))
                  {
                   bullishEngulfer.state = FOUND_STATE;
                   bullishEngulfer.time = time[w - 1];
                   bullishEngulfer.high = high[w - 1];
                   bullishEngulfer.low = low[w - 1];
                   bullishEngulfer.retestTime = time[w] + (PeriodSeconds() * barsRetestRange);// Set retest time window
                   return rates_total;
                  }
               }
             if(bearishEngulfer.state == SEARCH_STATE)
               {
                if(isBearishEngulfing(w, open, high, low, close))
                  {
                   bearishEngulfer.state = FOUND_STATE;
                   bearishEngulfer.time = time[w - 1];
                   bearishEngulfer.high = high[w - 1];
                   bearishEngulfer.low = low[w - 1];
                   bearishEngulfer.retestTime = time[w] + (PeriodSeconds() * barsRetestRange);// Set retest time window
                   return rates_total;
                  }
               }
             //--- Found state
             if(bullishEngulfer.state == FOUND_STATE)
               {
                if(time[w] <= bullishEngulfer.retestTime)
                  {
                   if(close[w] < bullishEngulfer.low)
                     {
                      //--- Broken?  reset state
                      bullishEngulfer.state = SEARCH_STATE;
                      return rates_total;
                     }
                   //--- Validate retest
                   if((low[w] <= bullishEngulfer.high && close[w] > bullishEngulfer.high &&
                       lowerWickRatio(w, open, high, low, close) >= wickThreshold) ||
                      (low[w] <= bullishEngulfer.low && close[w] > bullishEngulfer.low &&
                       lowerWickRatio(w, open, high, low, close) >= wickThreshold))
                     {
                      //--- Draw zone and reset state
                      createZone(ZONE_BULL, bullishEngulfer.time, bullishEngulfer.high,
                                 time[w] + (PeriodSeconds() * 2), bullishEngulfer.low, bullishZoneColor);
                      bullishEngulfer.state = SEARCH_STATE;
                      return rates_total;
                     }
                  }
                else
                   if(time[w] > bullishEngulfer.retestTime)
                     {
                      //--- Outside time range
                      bullishEngulfer.state = SEARCH_STATE;
                      return rates_total;
                     }
               }
             if(bearishEngulfer.state == FOUND_STATE)
               {
                if(time[w] <= bearishEngulfer.retestTime)
                  {
                   if(close[w] > bearishEngulfer.high)
                     {
                      //--- Broken?  reset state
                      bearishEngulfer.state = SEARCH_STATE;
                      return rates_total;
                     }
                   //--- Validate retest
                   if((high[w] >= bearishEngulfer.low && close[w] < bearishEngulfer.low &&
                       upperWickRatio(w, open, high, low, close) >= wickThreshold)
                      || (high[w] >= bearishEngulfer.high && close[w] < bearishEngulfer.high &&
                          upperWickRatio(w, open, high, low, close) >= wickThreshold))
                     {
                      //--- Draw zone and reset state
                      createZone(ZONE_BEAR, bearishEngulfer.time, bearishEngulfer.high,
                                 time[w] + (PeriodSeconds() * 2), bearishEngulfer.low, bearishZoneColor);
                      bearishEngulfer.state = SEARCH_STATE;
                      return rates_total;
                     }
                  }
                else
                   if(time[w] > bearishEngulfer.retestTime)
                     {
                      //--- Outside time range
                      bearishEngulfer.state = SEARCH_STATE;
                      return rates_total;
                     }
               }
            }
         }
       return(rates_total);
      }

  * _Search state:_ In this initial state, the system scans for valid engulfing patterns using isBullishEngulfing() and isBearishEngulfing(). When a bullish or bearish engulfing condition is detected, the corresponding structure is populated with key properties such as time, high, low, and a calculated retest window is defined using barsRetestRange. The state then transitions to FOUND_STATE.  

  *  _Found state:_ Once a pattern is found, the system monitors price behavior within a defined retest window.


  1. If the price breaks beyond the invalidation level, the setup is discarded and the system resets.
  2. If price returns and successfully interacts with the zone while meeting wick strength conditions, a valid retest is confirmed.
  3. Upon confirmation, a zone is drawn on the chart, and the state resets back to SEARCH_STATE.
  4. If the time window expires without validation, the setup is also reset.



### Program Testing

With development complete, the indicator is tested on historical and live data to verify pattern detection, zone rendering, and retest validation under real market conditions. The chart below illustrates a typical detection and subsequent retest scenario generated by the indicator:

![Live Chart](https://c.mql5.com/2/210/ok_ooo__1.png)

Fig. 5. Retest Validation Test

### Conclusion

We have translated the Malaysian Engulfing concept from an ambiguous chart signal into a deterministic, MetaTrader 5‑compatible toolkit composed of two modules:

  * A strict “perfect engulfing” detector that flags only those bullish/bearish candles meeting precise body‑dominance rules.


  * A state‑driven retest validator that creates a monitoring zone, enforces invalidation, limits validation to a configurable bar window (barsRetestRange), and confirms retests using a wick‑ratio filter (wickThreshold).

The architecture deliberately separates detection from scenario validation so each component remains simple, testable, and reusable as an EA building block.  


This design addresses the shortcomings identified in the analysis: it specifies platform and inputs, replaces subjective interpretation with formal rules and explicit state transitions (SEARCH → FOUND → reset/confirm), and produces concrete, chart‑level artifacts (arrows and rectangles) and deterministic events that can be backtested and automated. Next steps include adding an adaptive layer to tune retest candle ranges historically and integrating the modules into a semi-automated or fully automated strategy for robustness across market regimes. 

Source files are attached for testing and extension.

**Attached files** | 

[ __Download ZIP](/en/articles/download/22419.zip "Download all attachments in the single ZIP archive")

[__Malaysian_Engulfing_-_Pattern_Detection.mq5](/en/articles/download/22419/Malaysian_Engulfing_-_Pattern_Detection.mq5 "Download Malaysian_Engulfing_-_Pattern_Detection.mq5") (4.41 KB)

[__Malaysian_Engulfing_-_Retest_Validation.mq5](/en/articles/download/22419/Malaysian_Engulfing_-_Retest_Validation.mq5 "Download Malaysian_Engulfing_-_Retest_Validation.mq5") (9.89 KB)

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

  * [Building a Dynamic STF Liquidity Sweep Indicator in MQL5](/en/articles/22140)
  * [Building the Market Structure Sentinel Indicator in MQL5](/en/articles/22249)
  * [Adaptive Malaysian Engulfing Indicator (Part 2): Optimized Retest Bar Range](/en/articles/22420)
  * [Account Audit System in MQL5 (Part 1): Designing the User Interface](/en/articles/22032)



**[Go to discussion](/en/forum/509671) **

![Exploring Conformal Forecasting of Financial Time Series](https://c.mql5.com/2/147/18324-izuchaem-konformnoe-prognozirovanie-logo.png) [Exploring Conformal Forecasting of Financial Time Series](/en/articles/18324)

In this article, we will consider conformal predictions and the MAPIE library that implements them. This approach is one of the most modern ones in machine learning and allows us to focus on risk management for existing diverse machine learning models. Conformal predictions, by themselves, are not a way to find patterns in data. They only determine the degree of confidence of existing models in predicting specific examples and allow filtering for reliable predictions.

![Creating a Custom Tick Chart in MQL5](https://c.mql5.com/2/212/22460-creating-a-custom-tick-chart-logo.png) [Creating a Custom Tick Chart in MQL5](/en/articles/22460)

Learn how to implement a tick-based chart in MQL5 where each bar is built from a fixed number of ticks instead of time. The article covers creating and configuring a custom symbol, capturing real-time ticks, forming OHLC values, and pushing data with CustomRatesUpdate. This approach produces activity-driven candles that better reflect market intensity and short-term momentum for precise intraday analysis.

![Encoding Candlestick Patterns \(Part 1\): An Alphabetical System for Signal Detection](https://c.mql5.com/2/212/22469-encoding-candlestick-patterns-logo.png) [Encoding Candlestick Patterns (Part 1): An Alphabetical System for Signal Detection](/en/articles/22469)

We present a rule‑based alphabet for candlestick price action that maps measurable shape and direction to letter codes (A/a, H/h, E/e, G/g, D). The article shows an MQL5 implementation: classifying candles, building two‑bar sequences via permutations, and scanning charts with an indicator and alerts. Readers gain a practical template for objective pattern detection and systematic testing.

![The MQL5 Standard Library Explorer \(Part 11\): How to Build a Matrix-Based Market Structure Indicator in MQL5](https://c.mql5.com/2/212/21837-the-mql5-standard-library-explorer-logo__1.png) [The MQL5 Standard Library Explorer (Part 11): How to Build a Matrix-Based Market Structure Indicator in MQL5](/en/articles/21837)

Learn to engineer an MQL5 indicator that converts trend, momentum, and volatility into a single raw score using a matrix.mqh (ALGLIB). The article covers a separate‑window oscillator to validate the core mathematics, then a main‑chart indicator that plots non‑repainting buy/sell arrows when the score crosses user‑defined thresholds. An optional long‑term EMA filter, a minimum‑bar cooldown, and built‑in alerts make the tool practical for live trading.

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


