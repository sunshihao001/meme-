# EN_Wyckoff吸筹派发自动化_适合深洗与二次确认语义

> 来源标题：Automating Classic Market Methods in MQL5 (Part 1): Wyckoff Accumulation and Distribution - MQL5 Articles
> 来源链接：https://www.mql5.com/en/articles/22628
> 下载时间：2026-06-13 00:08:29
> 用途：补充 meme 市场庄家控盘、深洗、诱多、二次确认相关语义。

---

__

[ __](/en/articles/22628?print= "Printer friendly version")

![preview](data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAsICAoIBwsKCQoNDAsNERwSEQ8PESIZGhQcKSQrKigkJyctMkA3LTA9MCcnOEw5PUNFSElIKzZPVU5GVEBHSEX/2wBDAQwNDREPESESEiFFLicuRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUX/wAARCAAQACADASIAAhEBAxEB/8QAGAAAAgMAAAAAAAAAAAAAAAAAAgQDBQb/xAAhEAABBAEDBQAAAAAAAAAAAAABAAIDESEEEpExMkFCUf/EABYBAQEBAAAAAAAAAAAAAAAAAAQBAv/EABcRAQEBAQAAAAAAAAAAAAAAAAEAAhH/2gAMAwEAAhEDEQA/AMfHKR0ymmTyVhp4VcB8NIxY9ynCwnM86eUjtdwln6h15tRncRmQoNo8m1h29qZL/9k=)

![Automating Classic Market Methods in MQL5 \(Part 1\): Wyckoff Accumulation and Distribution](https://c.mql5.com/2/219/22628-automating-classic-market-methods-in-mql5-part-1-wyckoff-accumulation_600x314.jpg)

# Automating Classic Market Methods in MQL5 (Part 1): Wyckoff Accumulation and Distribution

[MetaTrader 5](/en/articles/mt5) — [Trading](/en/articles/mt5/trading) | 4 June 2026, 12:55

![](https://c.mql5.com/i/icons.svg#views-white-usage) 1 687  [ ![](https://c.mql5.com/i/icons.svg#comments-white-usage) 0 ](/en/forum/510756 "Comments")

![Tola Moses Hector](https://c.mql5.com/avatar/2025/12/693e9f9e-dbad.jpg)

[Tola Moses Hector](/en/users/tolahectorforex)

### Introduction  


One of the most enduring frameworks in technical analysis is the Wyckoff method. Richard Wyckoff developed it in the 1930s after decades of observing how large institutional operators accumulate and distribute positions in financial markets.

The method describes market movement not as random noise, but as a series of cause-and-effect cycles driven by institutional supply and demand. These cycles leave identifiable structural footprints—the spring, the sign of strength, the upthrust, and the sign of weakness—that a prepared trader can detect and trade.

Although widely discussed, the Wyckoff method is rarely automated in MQL5. This is not because individual events are difficult to detect; for example, a close below support is trivial. The challenge is that each Wyckoff event only carries meaning in the context of the events that preceded it. A spring is not merely a dip below support. It is a dip below support that occurs within a defined range, following a prior downtrend, confirmed by a specific volume signature. Detecting it in isolation is meaningless. Detecting it as part of a validated sequence is everything.

In this article, we build a complete Expert Advisor that automates this sequential detection using a finite state machine. The EA identifies accumulation structures on the H4 timeframe, detects the spring shakeout, confirms demand with a sign of strength, and enters long at the last point of support. For distribution, it mirrors the same logic in reverse: upthrust, a sign of weakness, and a short entry at the last point of supply. We will cover the following topics:

  1. [Understanding the Wyckoff framework](/en/articles/22628#para2)
  2. [Why tick volume works as an institutional proxy](/en/articles/22628#para3)
  3. [The state machine architecture](/en/articles/22628#para4)
  4. [Implementation in MQL5](/en/articles/22628#para5)
  5. [Backtesting](/en/articles/22628#para6)
  6. [Conclusion](/en/articles/22628#para7)



By the end, you will have a fully functional MQL5 Expert Advisor that detects and trades Wyckoff structures automatically.

###   


### Understanding the Wyckoff Framework  


The Wyckoff method describes four recurring market cycles: accumulation, markup, distribution, and markdown. Accumulation occurs when institutions quietly build long positions in a sideways range following a downtrend. Markup follows as price rises on institutional demand. Distribution occurs when institutions sell into an uptrend, creating a sideways range at the top. Markdown follows as price falls on institutional supply.

This EA focuses on the two transition points—the end of Accumulation and the end of Distribution—because these offer the best-defined, highest-probability setups in the entire Wyckoff cycle.

**The Accumulation Sequence**

Accumulation moves through five phases. In Phase A, a selling climax on high volume stops the downtrend. An automatic rally then defines the top of the range. A secondary test on lower volume confirms that selling pressure has dried up. The second phase sees institutions quietly accumulate within the range as price oscillates between support and resistance. The third phase delivers the spring—a deliberate false breakdown below range support on lower-than-average volume, designed to flush out weak holders and collect liquidity before the markup begins. The fourth phase confirms institutional demand with a sign of strength: a high-volume close above range resistance. The last point of support is the pullback that follows the sign of strength—the final low-risk entry before phase E begins and price leaves the range.

![](https://c.mql5.com/2/216/part_1_buy_demo.png)

Fig. 1. Chart showing spring, sign of strength, and "LPS" entry.

**The Distribution Mirror**

Distribution reverses every element. The upthrust is the false breakout above range resistance on low volume—the institutional bull trap at the top. The sign of weakness is the high-volume breakdown below range support. The last point of supply is the low-volume rally after the sign of weakness—the optimal short entry before "markdown" begins.

![](https://c.mql5.com/2/216/part_1_sell_demo.png)

Fig. 2. Chart showing upthrust, sign of weakness, and "LPSY" entry.

**What the EA Detects  
**

The EA does not attempt to label every Wyckoff event from preliminary support to phase E. Full phase detection on live data requires subjective judgment that is difficult to codify reliably. Instead, it focuses on the events with the clearest, most objective definitions: range formation following a directional move, the spring or upthrust as the terminal shakeout, the sign of strength (SOS) or sign of weakness (SOW) as confirmation, and the last point of support (LPS) or the last point of supply (LPSY) as the entry trigger.

###   


### Why Tick Volume Works as an Institutional Proxy  


Volume is central to every Wyckoff detection decision. This raises a practical question for MetaTrader 5 forex traders: real exchange volume is not available for currency pairs. MetaTrader 5 provides tick volume—the number of price changes per bar.

Tick volume is a valid proxy for trading activity. Research consistently shows a high correlation (typically above 0.85) with real traded volume on major forex pairs. When institutions are active, prices change frequently. When the market is quiet, ticks are sparse. The relative volume patterns that Wyckoff described—climactic volume on reversals, low volume on tests, and expanding volume on breakouts—manifest clearly in tick volume data.

The critical point is that we always work with relative volume, not absolute counts. A selling climax does not require a specific tick number. It requires tick volume substantially above the average for that instrument on that timeframe. Every volume check in the EA computes a rolling average over the bars within the current range and compares each bar as a ratio against that baseline. This approach is instrument-agnostic and works identically on EURUSD, gold, and any other symbols in MetaTrader 5.

###   


### The State Machine Architecture  


Before writing the first line of code, the most important design decision must be made: the EA will use a finite state machine to track where the market is in the Wyckoff sequence. This is the only reliable architecture for implementing a sequential pattern detector.

Consider the naive alternative—an independent check in OnTick:
    
    
    if(iLow(_Symbol, PERIOD_CURRENT, 1) < supportLevel)
       OpenLong();  // WRONG: fires on any dip, regardless of context

This fires on any dip below any support level, with no regard for whether a range exists, whether a prior downtrend preceded it, or whether volume was appropriate. It is not a Wyckoff spring detector. It is a noise generator.

A state machine solves this by ensuring the EA is always in exactly one state and can only advance to the next state when the specific structural evidence for that state is present. The spring cannot be evaluated before the range is confirmed. The sign of strength cannot be evaluated before the spring is confirmed. The entry cannot execute before the sign of strength is confirmed. The sequence is enforced mechanically—it cannot be skipped.

The complete state flow for accumulation is as follows: "STATE_IDLE" → "STATE_RANGE_FORMING" → "STATE_SPRING_DETECTED" → "STATE_SOS_CONFIRMED" → "STATE_IN_TRADE." While the complete state flow for accumulation is as follows: "STATE_IDLE" → "STATE_RANGE_FORMING" → "STATE_UPTHRUST_DETECTED" → "STATE_SOW_CONFIRMED" → "STATE_IN_TRADE." Any state can reset to "STATE_IDLE" if the structure is invalidated—for example, if the price closes below the spring low after the spring is detected, the accumulation thesis is abandoned and the EA starts scanning for a fresh structure.

###   


### Implementation in MQL5  


To create the program in MQL5, open MetaEditor, navigate to the Experts folder, click "New," and follow the prompts to create the file. We will build the EA piece by piece, explaining each section as we go.

****Includes and Input Parameters****

We begin by including the standard trade library and defining the EA's state machine enumeration and all input parameters.
    
    
    //+------------------------------------------------------------------+
    //|                                                    WyckoffEA.mq5 |
    //|                                Copyright 2026, Tola Moses Hector |
    //|                                          https://t.me/tolahector |
    //+------------------------------------------------------------------+
    #property copyright "Copyright 2026, Tola Moses Hector"
    #property link      "https://t.me/tolahector"
    #property version   "1.00"
    #property description "Wyckoff Accumulation and Distribution EA"
    #property description "Detects Spring + SOS for long entries (LPS)"
    #property description "Detects Upthrust + SOW for short entries (LPSY)"
    #property description "H4 timeframe recommended"
    
    #include <Trade\Trade.mqh>
    
    //+------------------------------------------------------------------+
    //| EA State Machine                                                 |
    //+------------------------------------------------------------------+
    enum ENUM_WYCKOFF_STATE
      {
       STATE_IDLE,               // No structure active
       STATE_RANGE_FORMING,      // Valid range identified — locked, watching for Spring/UT
       STATE_SPRING_DETECTED,    // Spring confirmed, watching for SOS
       STATE_SOS_CONFIRMED,      // SOS confirmed, watching for LPS entry
       STATE_UPTHRUST_DETECTED,  // Upthrust confirmed, watching for SOW
       STATE_SOW_CONFIRMED,      // SOW confirmed, watching for LPSY entry
       STATE_IN_TRADE            // Position open
      };
    
    //+------------------------------------------------------------------+
    //| Input Parameters                                                 |
    //+------------------------------------------------------------------+
    input group "=== Range Detection ==="
    input int    InpTrendBars       = 15;    // Bars of prior trend required
    input int    InpMinRangeBars    = 10;    // Minimum bars to form range
    input int    InpMaxRangeBars    = 60;    // Maximum bars to scan for range
    input double InpMinRangePips    = 20.0;  // Minimum range height (pips)
    input double InpMaxRangePips    = 400.0; // Maximum range height (pips)
    input double InpSpringTolerance = 10.0;  // Pips below support for Spring
    input int    InpRangeWatchBars  = 30;    // Max bars to watch range before reset
    
    input group "=== Volume Settings ==="
    input double InpHighVolMult     = 1.2;   // High-volume multiplier (SOS/SOW)
    input double InpLowVolMult      = 1.2;   // Low-volume multiplier (Spring/Upthrust)
    
    input group "=== Entry and Risk ==="
    input double InpRiskPercent     = 1.0;   // Risk per trade (% of balance)
    input double InpRR              = 2.0;   // Risk-reward ratio
    input int    InpATRPeriod       = 14;    // ATR period for stop distance
    input double InpATRMult         = 1.5;   // ATR multiplier for stop distance
    input int    InpLPSBars         = 8;     // Bars to wait for LPS/LPSY pullback
    
    input group "=== General ==="
    input int    InpMagicNumber     = 777001; // Magic number
    input int    InpSlippage        = 10;     // Slippage in points
    input bool   InpShowLabels      = true;   // Draw event labels on chart

We start by including "Trade\Trade.mqh," which provides the "CTrade" class needed for order execution and position management. Furthermore, we define the "ENUM_WYCKOFF_STATE" enumeration with seven states that represent every possible position in the Wyckoff detection sequence. This enumeration is the backbone of the entire EA—every detection decision flows from the current state. The input parameters are organized into four groups using the "input group" directive. The "Range Detection" group controls how the EA identifies a valid trading range and prior trend. The "Volume Settings" group defines the relative volume thresholds used for every Wyckoff event. The "Entry and Risk" group controls position sizing and stop placement. All parameters are configurable from the properties window without code changes.

**Global Variables and Range Structure**

Next, we define the data structure that stores all information about the current Wyckoff structure and the global variables that manage EA state.
    
    
    //+------------------------------------------------------------------+
    //| Wyckoff Range Data Structure                                     |
    //+------------------------------------------------------------------+
    struct SWyckoffRange
      {
       double            support;        // Range support level
       double            resistance;     // Range resistance level
       int               start_bar;      // Bars back where range started
       double            avg_volume;     // Average tick volume within range
       bool              bullish_bias;   // true = accumulation, false = distribution
       double            spring_low;     // Low of the Spring bar
       double            sos_high;       // High of the SOS bar
       double            upthrust_high;  // High of the Upthrust bar
       double            sow_low;        // Low of the SOW bar
      };
    
    //+------------------------------------------------------------------+
    //| Global Variables                                                 |
    //+------------------------------------------------------------------+
    ENUM_WYCKOFF_STATE g_state          = STATE_IDLE;         // Current EA state
    SWyckoffRange      g_range;                               // Current range data
    CTrade             g_trade;                               // Trade execution object
    int                g_atr_handle     = INVALID_HANDLE;     // ATR indicator handle
    datetime           g_last_bar       = 0;                  // Last processed bar time
    int                g_lps_count      = 0;                  // Bars waited after SOS
    int                g_lpsy_count     = 0;                  // Bars waited after SOW
    int                g_range_watch    = 0;                  // Bars watched in RANGE_FORMING

The "SWyckoffRange" struct serves as the EA's memory of the current structure. It stores the range boundaries, the volume baseline computed from within the range, the directional bias determined by whether a downtrend or uptrend preceded the range, and the price levels of each detected event. Keeping all structure data in one place makes the code readable and eliminates scattered global variables. The global section instantiates "g_trade" from "CTrade" for all trade operations and creates "g_atr_handle" for the ATR indicator used in stop distance calculation.

**Utility Functions**

Before building the detection logic, we define several utility functions used throughout the EA.
    
    
    //+------------------------------------------------------------------+
    //| Returns pip size for the current symbol                          |
    //+------------------------------------------------------------------+
    double PipSize()
      {
       int digits = (int)SymbolInfoInteger(_Symbol, SYMBOL_DIGITS); // Get symbol digits
       return (digits == 3 || digits == 5) ? _Point * 10.0 : _Point; // Return pip size
      }
    
    //+------------------------------------------------------------------+
    //| Calculates lot size from risk percent and stop distance          |
    //+------------------------------------------------------------------+
    double CalcLots(double sl_pips)
      {
       double balance    = AccountInfoDouble(ACCOUNT_BALANCE);                    // Get balance
       double risk_money = balance * InpRiskPercent / 100.0;                      // Monetary risk
       double tick_val   = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE);    // Tick value
       double tick_size  = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_SIZE);     // Tick size
       double pip_size   = PipSize();                                             // Get pip size
       if(tick_size <= 0 || tick_val <= 0 || sl_pips <= 0)
          return 0;                                                               // Validate inputs
       double pip_value  = (pip_size / tick_size) * tick_val;                     // Pip monetary value
       double lots       = risk_money / (sl_pips * pip_value);                    // Raw lot size
       double step       = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);         // Volume step
       double min_lot    = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);          // Minimum lot
       double max_lot    = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX);          // Maximum lot
       lots = MathFloor(lots / step) * step;                                      // Normalize to step
       return MathMax(min_lot, MathMin(max_lot, lots));                           // Clamp to limits
      }
    
    //+------------------------------------------------------------------+
    //| Checks if EA has an open position on this symbol                 |
    //+------------------------------------------------------------------+
    bool PositionOpen()
      {
       for(int i = PositionsTotal() - 1; i >= 0; i--)                             // Iterate positions
         {
          ulong ticket = PositionGetTicket(i);                                    // Get ticket
          if(!PositionSelectByTicket(ticket))
             continue;                                                            // Select position
          if(PositionGetString(POSITION_SYMBOL)  != _Symbol)
             continue;                                                            // Check symbol
          if(PositionGetInteger(POSITION_MAGIC)  != InpMagicNumber)
             continue;                                                            // Check magic
          return true;                                                            // Position found
         }
       return false;                                                              // No position
      }

"PipSize()" detects whether the symbol has three or five decimal digits and returns the correct pip size in price units. This makes every subsequent distance calculation instrument-agnostic. "CalcLots()" computes position size from a monetary risk target using "SYMBOL_TRADE_TICK_VALUE" and "SYMBOL_TRADE_TICK_SIZE"—the broker-provided values that convert price distance to account currency correctly for any instrument, including gold and indexes. This is more accurate than simple pip multiplication, which fails on nonstandard instruments. "PositionOpen()" scans all open positions and returns true if any belong to this EA on the current symbol, using both the symbol name and magic number to avoid confusion with manual trades.

**Chart Drawing Functions**

Chart labels are important for verifying that the EA is detecting events correctly during testing. We define simple drawing helpers.
    
    
    //+------------------------------------------------------------------+
    //| Draws a horizontal line at the specified price level             |
    //+------------------------------------------------------------------+
    void DrawHLine(string name, double price, color clr, ENUM_LINE_STYLE style)
      {
       if(!InpShowLabels)
          return;                                                                // Check flag
       string obj = "WYK_" + name;                                               // Build object name
       ObjectDelete(0, obj);                                                     // Remove existing
       ObjectCreate(0, obj, OBJ_HLINE, 0, 0, price);                             // Create hline
       ObjectSetInteger(0, obj, OBJPROP_COLOR, clr);                             // Set color
       ObjectSetInteger(0, obj, OBJPROP_STYLE, style);                           // Set style
       ObjectSetInteger(0, obj, OBJPROP_WIDTH, 1);                               // Set width
       ChartRedraw(0);                                                           // Redraw chart
      }
    
    //+------------------------------------------------------------------+
    //| Places a text label at the specified time and price              |
    //+------------------------------------------------------------------+
    void DrawLabel(string name, datetime time, double price, string text, color clr)
      {
       if(!InpShowLabels)
          return;                                                                // Check flag
       string obj = "WYK_" + name;                                               // Build object name
       ObjectDelete(0, obj);                                                     // Remove existing
       ObjectCreate(0, obj, OBJ_TEXT, 0, time, price);                           // Create text object
       ObjectSetString(0, obj, OBJPROP_TEXT, text);                              // Set text content
       ObjectSetInteger(0, obj, OBJPROP_COLOR, clr);                             // Set color
       ObjectSetInteger(0, obj, OBJPROP_FONTSIZE, 9);                            // Set font size
       ChartRedraw(0);                                                           // Redraw chart
      }
    
    //+------------------------------------------------------------------+
    //| Removes all chart objects created by this EA                     |
    //+------------------------------------------------------------------+
    void ClearLabels()
      {
       int total = ObjectsTotal(0);                                              // Get object count
       for(int i = total - 1; i >= 0; i--)                                       // Iterate backwards
         {
          string name = ObjectName(0, i);                                        // Get object name
          if(StringFind(name, "WYK_") == 0)
             ObjectDelete(0, name);                                              // Delete if EA's
         }
       ChartRedraw(0);                                                           // Redraw chart
      }

"DrawHLine()" places or updates a horizontal line at the range support and resistance levels. Prefixing all object names with "WYK_" allows "ClearLabels()" to reliably remove only this EA's objects without touching any manually placed lines or indicators. "DrawLabel()" places event name tags—"SPRING," "SOS," "UPTHRUST," "SOW," "LPS," and "LPSY"—directly on the chart at the price and time of each detected event.

**Prior Trend Detection**

A trading range only carries Wyckoff significance if it follows a directional move. We check this before accepting any range as valid.
    
    
    //+------------------------------------------------------------------+
    //| Returns true if a downtrend preceded the specified bar           |
    //+------------------------------------------------------------------+
    bool HasPriorDowntrend(int from_bar)
      {
       double high_buf[], low_buf[];                                             // Price buffers
       ArraySetAsSeries(high_buf, true);                                         // Set as series
       ArraySetAsSeries(low_buf,  true);                                         // Set as series
       if(CopyHigh(_Symbol, PERIOD_CURRENT, from_bar, InpTrendBars, high_buf) < InpTrendBars)
          return false;                                                          // Copy highs
       if(CopyLow(_Symbol, PERIOD_CURRENT, from_bar, InpTrendBars, low_buf)  < InpTrendBars)
          return false;                                                          // Copy lows
       double first_high = 0, second_low = DBL_MAX;                              // Init comparators
       int half = InpTrendBars / 2;                                              // Split midpoint
       for(int i = 0; i < half; i++)
          first_high = MathMax(first_high, high_buf[i + half]);                  // Find early high
       for(int i = 0; i < half; i++)
          second_low = MathMin(second_low, low_buf[i]);                          // Find recent low
       return first_high > second_low + PipSize() * InpMinRangePips * 0.3;       // Confirm descent
      }
    
    //+------------------------------------------------------------------+
    //| Returns true if an uptrend preceded the specified bar            |
    //+------------------------------------------------------------------+
    bool HasPriorUptrend(int from_bar)
      {
       double high_buf[], low_buf[];                                              // Price buffers
       ArraySetAsSeries(high_buf, true);                                          // Set as series
       ArraySetAsSeries(low_buf,  true);                                          // Set as series
       if(CopyHigh(_Symbol, PERIOD_CURRENT, from_bar, InpTrendBars, high_buf) < InpTrendBars)
          return false;                                                          // Copy highs
       if(CopyLow(_Symbol, PERIOD_CURRENT, from_bar, InpTrendBars, low_buf)  < InpTrendBars)
          return false;                                                          // Copy lows
       double first_low = DBL_MAX, second_high = 0;                              // Init comparators
       int half = InpTrendBars / 2;                                              // Split midpoint
       for(int i = 0; i < half; i++)
          first_low   = MathMin(first_low,   low_buf[i + half]);                 // Find early low
       for(int i = 0; i < half; i++)
          second_high = MathMax(second_high, high_buf[i]);                       // Find recent high
       return second_high > first_low + PipSize() * InpMinRangePips * 0.3;       // Confirm ascent
      }

Both functions split the "InpTrendBars" lookback period in half and compare the price structure of the earlier half against the recent half. For "HasPriorDowntrend()", the highest high should be in the earlier period and the lowest low in the recent period—confirming that the price moved downward over the lookback. "HasPriorUptrend()" applies the mirror logic. The minimum distance threshold prevents a flat, trendless period from being misclassified as a trend.

**Range Detection**

With prior trend detection in place, we can now identify valid trading ranges. The function scans from the minimum required bar count upward, returning the first range that satisfies all conditions rather than always expanding to the maximum. This prevents the state machine from being anchored to an overly wide, unfocused range.

When both a prior downtrend and a prior uptrend are detected before the same range, the EA resolves the ambiguity by comparing the first and last close of the trend period immediately before the range. If the price fell into the range, the preceding move was a downtrend, and the bias is accumulation. If the price rose into the range, the preceding move was an uptrend, and the bias is distribution.
    
    
    //+------------------------------------------------------------------+
    //| Scans recent bars once to identify a valid Wyckoff range         |
    //+------------------------------------------------------------------+
    bool DetectRange()
      {
       double high_buf[], low_buf[];                                             // Price buffers
       long   vol_buf[];                                                         // Volume buffer
       ArraySetAsSeries(high_buf, true);                                         // Set as series
       ArraySetAsSeries(low_buf,  true);                                         // Set as series
       ArraySetAsSeries(vol_buf,  true);                                         // Set as series
       int bars = InpMaxRangeBars + InpTrendBars + 5;                            // Total bars needed
       if(CopyHigh(_Symbol, PERIOD_CURRENT, 1, bars, high_buf)     < bars)
          return false;                                                          // Copy highs
       if(CopyLow(_Symbol, PERIOD_CURRENT, 1, bars, low_buf)      < bars)
          return false;                                                          // Copy lows
       if(CopyTickVolume(_Symbol, PERIOD_CURRENT, 1, bars, vol_buf) < bars)
          return false;                                                          // Copy volumes
       double pip   = PipSize();                                                 // Get pip size
       double min_h = InpMinRangePips * pip;                                     // Min height in price
       double max_h = InpMaxRangePips * pip;                                     // Max height in price
    //--- Try each possible range length from minimum to maximum
       for(int range_bars = InpMinRangeBars; range_bars <= InpMaxRangeBars; range_bars++)   // Try lengths
         {
          double rh = 0, rl = DBL_MAX;                                           // Init bounds
          for(int i = 0; i < range_bars; i++)                                    // Scan range bars
            {
             rh = MathMax(rh, high_buf[i]);                                      // Update range high
             rl = MathMin(rl, low_buf[i]);                                       // Update range low
            }
          double height = rh - rl;                                               // Compute height
          if(height < min_h)
             continue;                                                           // Too narrow, try longer
          if(height > max_h)
             break;                                                              // Too wide, stop
          //--- Check that all bars stay within 25% tolerance of range height
          double tol  = height * 0.25;                                           // Tolerance band
          bool   fits = true;                                                    // Fit flag
          for(int i = 0; i < range_bars; i++)                                    // Check each bar
            {
             if(high_buf[i] > rh + tol || low_buf[i] < rl - tol)                 // Bar outside range
               {
                fits = false;                                                    // Mark as not fitting
                break;                                                           // Stop checking
               }
            }
          if(!fits)
             continue;                                                           // Skip this length
          //--- Confirm a prior trend before the range
          bool down_before = HasPriorDowntrend(range_bars + 1);                  // Check downtrend
          bool up_before   = HasPriorUptrend(range_bars + 1);                    // Check uptrend
          if(!down_before && !up_before)
             continue;                                                           // No prior trend
          //--- Compute average volume within the range
          double avg_vol = 0;                                                    // Volume sum
          for(int i = 0; i < range_bars; i++)
             avg_vol += (double)vol_buf[i];                                      // Accumulate
          avg_vol /= range_bars;                                                 // Compute average
          //--- Populate the range struct
          g_range.support       = rl;                                            // Store support
          g_range.resistance    = rh;                                            // Store resistance
          g_range.start_bar     = range_bars;                                    // Store bar count
          g_range.avg_volume    = avg_vol;                                       // Store average vol
          //--- When both trends detected, pick the more dominant one
          if(down_before && up_before)
            {
             //--- Measure which directional move was larger immediately before range
             double high_buf[], low_buf[];
             ArraySetAsSeries(high_buf, true);
             ArraySetAsSeries(low_buf,  true);
             int trend_bars = InpTrendBars;
             CopyHigh(_Symbol, PERIOD_CURRENT, range_bars + 1, trend_bars, high_buf);
             CopyLow(_Symbol, PERIOD_CURRENT, range_bars + 1, trend_bars, low_buf);
             double trend_high = 0, trend_low = DBL_MAX;
             for(int k = 0; k < trend_bars; k++)
               {
                trend_high = MathMax(trend_high, high_buf[k]);
                trend_low  = MathMin(trend_low,  low_buf[k]);
               }
             double first_close  = iClose(_Symbol, PERIOD_CURRENT, range_bars + trend_bars);
             double last_close   = iClose(_Symbol, PERIOD_CURRENT, range_bars + 1);
             //--- If price fell into the range = downtrend before = accumulation
             //--- If price rose into the range = uptrend before = distribution
             g_range.bullish_bias = (last_close < first_close);
            }
          else
             g_range.bullish_bias = down_before;                                 // Set Bias
          g_range.spring_low    = 0;                                             // Clear spring low
          g_range.sos_high      = 0;                                             // Clear SOS high
          g_range.upthrust_high = 0;                                             // Clear upthrust
          g_range.sow_low       = 0;                                             // Clear SOW low
          DrawHLine("SUPPORT",    g_range.support,    clrGreen, STYLE_DASH);     // Draw support
          DrawHLine("RESISTANCE", g_range.resistance, clrRed,   STYLE_DASH);     // Draw resistance
          Print(StringFormat("WyckoffEA: Range locked | Bias: %s | S: %.5f | R: %.5f | Bars: %d | AvgVol: %.0f",
                             g_range.bullish_bias ? "ACCUMULATION" : "DISTRIBUTION",
                             g_range.support, g_range.resistance, range_bars, avg_vol));     // Log result
          return true;                                                           // Range valid
         }
       return false;                                                             // No range found
      }

"DetectRange()" seeds each candidate range from the minimum bar count and expands upward. The 25% tolerance band accommodates the natural variability of real Wyckoff ranges without accepting wildly expanded zones. Once a range is found, the function calls "HasPriorDowntrend()" and "HasPriorUptrend()" to verify a directional move preceded it and sets "g_range.bullish_bias" accordingly. The average volume is then computed from the range bars—this becomes the baseline for every subsequent volume comparison. Note that we copy from bar 1, not bar 0, to avoid acting on incomplete bar data.

**Spring and Upthrust Detection**

With a confirmed range and its volume baseline, we watch for the terminal shakeout event that signals the end of phase B.
    
    
    //+------------------------------------------------------------------+
    //| Checks the last closed bar for a valid Spring                    |
    //+------------------------------------------------------------------+
    bool CheckSpring()
      {
       double low1   = iLow(_Symbol, PERIOD_CURRENT, 1);                         // Last bar low
       double close1 = iClose(_Symbol, PERIOD_CURRENT, 1);                       // Last bar close
       double pip    = PipSize();                                                 // Get pip size
       double thresh = g_range.support - InpSpringTolerance * pip;               // Spring threshold
       if(low1 < thresh && close1 > g_range.support)                             // Penetrate and recover
         {
          long vol1 = iTickVolume(_Symbol, PERIOD_CURRENT, 1);                   // Last bar volume
          if((double)vol1 < g_range.avg_volume * InpLowVolMult)                  // Below volume threshold
            {
             g_range.spring_low = low1;                                          // Store Spring low
             datetime t1 = iTime(_Symbol, PERIOD_CURRENT, 1);                    // Get bar time
             DrawLabel("SPRING", t1, low1 - pip * 5, "SPRING", clrLime);         // Draw label
             Print(StringFormat("WyckoffEA: SPRING | Low: %.5f | Close: %.5f | Vol: %I64d | AvgVol: %.0f",
                                low1, close1, vol1, g_range.avg_volume));                     // Log event
             return true;                                                        // Spring confirmed
            }
         }
       return false;                                                              // Not a Spring
      }
    
    //+------------------------------------------------------------------+
    //| Checks the last closed bar for a valid Upthrust                  |
    //+------------------------------------------------------------------+
    bool CheckUpthrust()
      {
       double high1  = iHigh(_Symbol, PERIOD_CURRENT, 1);                        // Last bar high
       double close1 = iClose(_Symbol, PERIOD_CURRENT, 1);                       // Last bar close
       double pip    = PipSize();                                                // Get pip size
       double thresh = g_range.resistance + InpSpringTolerance * pip;            // Upthrust threshold
       if(high1 > thresh && close1 < g_range.resistance)                         // Penetrate and reverse
         {
          long vol1 = iTickVolume(_Symbol, PERIOD_CURRENT, 1);                   // Last bar volume
          if((double)vol1 < g_range.avg_volume * InpLowVolMult)                  // Below volume threshold
            {
             g_range.upthrust_high = high1;                                      // Store Upthrust high
             datetime t1 = iTime(_Symbol, PERIOD_CURRENT, 1);                    // Get bar time
             DrawLabel("UT", t1, high1 + pip * 5, "UPTHRUST", clrOrangeRed);     // Draw label
             Print(StringFormat("WyckoffEA: UPTHRUST | High: %.5f | Close: %.5f | Vol: %I64d | AvgVol: %.0f",
                                high1, close1, vol1, g_range.avg_volume));                    // Log event
             return true;                                                         // Upthrust confirmed
            }
         }
       return false;                                                              // Not an Upthrust
      }

"CheckSpring()" evaluates three conditions simultaneously on the last closed bar. The low must penetrate below the spring threshold—the support level minus the configured tolerance. The close must recover back above support within the same bar. The tick volume must be below the low-volume multiplier times the range average—confirming absorption rather than aggressive selling. All three must be true for the spring to be valid. Storing "g_range.spring_low" provides an invalidation level: if a subsequent bar closes below this level, the accumulation thesis is abandoned. "CheckUpthrust()" applies the identical logic in reverse at range resistance.

**Sign of Strength and Sign of Weakness**

The spring and upthrust are necessary but not sufficient. We need confirmation that institutional demand or supply has actually taken control.
    
    
    //+------------------------------------------------------------------+
    //| Checks the last closed bar for a Sign of Strength                |
    //+------------------------------------------------------------------+
    bool CheckSOS()
      {
       double close1 = iClose(_Symbol, PERIOD_CURRENT, 1);                       // Last bar close
       double high1  = iHigh(_Symbol, PERIOD_CURRENT, 1);                        // Last bar high
       if(close1 > g_range.resistance)                                           // Close above resistance
         {
          long vol1 = iTickVolume(_Symbol, PERIOD_CURRENT, 1);                   // Last bar volume
          if((double)vol1 > g_range.avg_volume * InpHighVolMult)                 // Above volume threshold
            {
             g_range.sos_high = high1;                                           // Store SOS high
             datetime t1 = iTime(_Symbol, PERIOD_CURRENT, 1);                    // Get bar time
             DrawLabel("SOS", t1, high1 + PipSize() * 5, "SOS", clrDodgerBlue); // Draw label
             Print(StringFormat("WyckoffEA: SOS | Close: %.5f | Vol: %I64d | AvgVol: %.0f",
                                close1, vol1, g_range.avg_volume));              // Log event
             return true;                                                        // SOS confirmed
            }
         }
       return false;                                                              // Not a SOS
      }
    
    //+------------------------------------------------------------------+
    //| Checks the last closed bar for a Sign of Weakness                |
    //+------------------------------------------------------------------+
    bool CheckSOW()
      {
       double close1 = iClose(_Symbol, PERIOD_CURRENT, 1);                       // Last bar close
       double low1   = iLow(_Symbol, PERIOD_CURRENT, 1);                         // Last bar low
       if(close1 < g_range.support)                                              // Close below support
         {
          long vol1 = iTickVolume(_Symbol, PERIOD_CURRENT, 1);                   // Last bar volume
          if((double)vol1 > g_range.avg_volume * InpHighVolMult)                 // Above volume threshold
            {
             g_range.sow_low = low1;                                             // Store SOW low
             datetime t1 = iTime(_Symbol, PERIOD_CURRENT, 1);                    // Get bar time
             DrawLabel("SOW", t1, low1 - PipSize() * 5, "SOW", clrCrimson);      // Draw label
             Print(StringFormat("WyckoffEA: SOW | Close: %.5f | Vol: %I64d | AvgVol: %.0f",
                                close1, vol1, g_range.avg_volume));              // Log event
             return true;                                                        // SOW confirmed
            }
         }
       return false;                                                              // Not a SOW
      }

The volume logic for the sign of strength and sign of weakness is the direct opposite of the spring and upthrust. Where the spring required low volume to confirm absorption, the sign of strength requires high volume to confirm institutional demand breaking price out of the range. A breakout above resistance on weak volume is unconvincing—institutions are not driving it. A breakout on volume at least 1.2 times the range average carries structural conviction. "CheckSOW()" applies the identical requirement for the distribution breakdown.

**Entry Logic: LPS and LPSY**

After a sign of strength or a sign of weakness confirmation, the EA waits for a pullback before entering. Chasing a breakout bar produces poor risk-reward. The last point of support and the last point of supply—the pullbacks after the sign of strength and sign of weakness—provide the optimal entries.
    
    
    //+------------------------------------------------------------------+
    //| Waits for LPS pullback and opens long position                   |
    //+------------------------------------------------------------------+
    void CheckLPSEntry()
      {
       g_lps_count++;                                                            // Increment wait counter
       if(g_lps_count > InpLPSBars)                                              // Wait window expired
         {
          Print("WyckoffEA: LPS window expired — resetting.");                   // Log expiry
          g_state = STATE_IDLE;                                                  // Reset state
          ClearLabels();                                                         // Clear chart
          return;                                                                // Exit function
         }
       double close1 = iClose(_Symbol, PERIOD_CURRENT, 1);                       // Last bar close
       long   vol1   = iTickVolume(_Symbol, PERIOD_CURRENT, 1);                  // Last bar volume
       bool pulled_back = (close1 < g_range.sos_high && close1 > g_range.support); // Pullback check
       bool low_vol     = ((double)vol1 < g_range.avg_volume * InpHighVolMult);     // Volume check
       Print(StringFormat("WyckoffEA: LPS check %d/%d | Close: %.5f | PulledBack: %s | LowVol: %s",
                          g_lps_count, InpLPSBars, close1,
                          pulled_back ? "YES" : "NO", low_vol ? "YES" : "NO"));  // Log check
       if(pulled_back && low_vol)                                                // LPS conditions met
         {
          double atr_buf[];                                                      // ATR buffer
          ArraySetAsSeries(atr_buf, true);                                       // Set as series
          if(CopyBuffer(g_atr_handle, 0, 1, 1, atr_buf) < 1)
             return;                                                             // Copy ATR value
          double atr    = atr_buf[0];                                            // ATR value
          double ask    = SymbolInfoDouble(_Symbol, SYMBOL_ASK);                 // Current ask
          double sl     = ask - atr * InpATRMult;                                // Stop loss price
          double sl_pip = (ask - sl) / PipSize();                                // Stop in pips
          double tp     = ask + sl_pip * InpRR * PipSize();                      // Take profit price
          double lots   = CalcLots(sl_pip);                                      // Calculate lot size
          if(lots <= 0)
             return;                                                             // Invalid lot size
          long   stop_lv  = SymbolInfoInteger(_Symbol, SYMBOL_TRADE_STOPS_LEVEL); // Broker stop level
          double min_dist = stop_lv * _Point;                                    // Minimum distance
          if(ask - sl < min_dist)
             sl = ask - min_dist - _Point;                                       // Adjust SL if needed
          if(tp - ask < min_dist)
             tp = ask + min_dist + _Point;                                       // Adjust TP if needed
          if(g_trade.Buy(lots, _Symbol, ask, sl, tp, "Wyckoff LPS Long"))        // Open long
            {
             datetime t1 = iTime(_Symbol, PERIOD_CURRENT, 1);                    // Get bar time
             DrawLabel("LPS", t1, iLow(_Symbol, PERIOD_CURRENT, 1) - PipSize() * 3, "LPS", clrGold); // Draw label
             Print(StringFormat("WyckoffEA: LONG opened | Lots: %.2f | Ask: %.5f | SL: %.5f | TP: %.5f",
                                lots, ask, sl, tp));                                          // Log trade
             g_state = STATE_IN_TRADE;                                           // Update state
            }
         }
      }
    
    //+------------------------------------------------------------------+
    //| Waits for LPSY rally and opens short position                    |
    //+------------------------------------------------------------------+
    void CheckLPSYEntry()
      {
       g_lpsy_count++;                                                           // Increment wait counter
       if(g_lpsy_count > InpLPSBars)                                             // Wait window expired
         {
          Print("WyckoffEA: LPSY window expired — resetting.");                  // Log expiry
          g_state = STATE_IDLE;                                                  // Reset state
          ClearLabels();                                                         // Clear chart
          return;                                                                // Exit function
         }
       double close1 = iClose(_Symbol, PERIOD_CURRENT, 1);                       // Last bar close
       long   vol1   = iTickVolume(_Symbol, PERIOD_CURRENT, 1);                  // Last bar volume
       bool rallied = (close1 > g_range.sow_low && close1 < g_range.resistance); // Rally check
       bool low_vol = ((double)vol1 < g_range.avg_volume * InpHighVolMult);      // Volume check
       Print(StringFormat("WyckoffEA: LPSY check %d/%d | Close: %.5f | Rallied: %s | LowVol: %s",
                          g_lpsy_count, InpLPSBars, close1,
                          rallied ? "YES" : "NO", low_vol ? "YES" : "NO"));      // Log check
       if(rallied && low_vol)                                                    // LPSY conditions met
         {
          double atr_buf[];                                                      // ATR buffer
          ArraySetAsSeries(atr_buf, true);                                       // Set as series
          if(CopyBuffer(g_atr_handle, 0, 1, 1, atr_buf) < 1)
             return;                                                             // Copy ATR value
          double atr    = atr_buf[0];                                            // ATR value
          double bid    = SymbolInfoDouble(_Symbol, SYMBOL_BID);                 // Current bid
          double sl     = bid + atr * InpATRMult;                                // Stop loss price
          double sl_pip = (sl - bid) / PipSize();                                // Stop in pips
          double tp     = bid - sl_pip * InpRR * PipSize();                      // Take profit price
          double lots   = CalcLots(sl_pip);                                      // Calculate lot size
          if(lots <= 0)
             return;                                                             // Invalid lot size
          long   stop_lv  = SymbolInfoInteger(_Symbol, SYMBOL_TRADE_STOPS_LEVEL); // Broker stop level
          double min_dist = stop_lv * _Point;                                    // Minimum distance
          if(sl - bid < min_dist)
             sl = bid + min_dist + _Point;                                       // Adjust SL if needed
          if(bid - tp < min_dist)
             tp = bid - min_dist - _Point;                                       // Adjust TP if needed
          if(g_trade.Sell(lots, _Symbol, bid, sl, tp, "Wyckoff LPSY Short"))     // Open short
            {
             datetime t1 = iTime(_Symbol, PERIOD_CURRENT, 1);                    // Get bar time
             DrawLabel("LPSY", t1, iHigh(_Symbol, PERIOD_CURRENT, 1) + PipSize() * 3, "LPSY", clrGold); // Draw label
             Print(StringFormat("WyckoffEA: SHORT opened | Lots: %.2f | Bid: %.5f | SL: %.5f | TP: %.5f",
                                lots, bid, sl, tp));                                          // Log trade
             g_state = STATE_IN_TRADE;                                           // Update state
            }
         }
      }

Both entry functions increment a bar counter each time they are called. If the pullback does not materialize within "InpLPSBars" bars, the state machine resets to "STATE_IDLE," and the structure is abandoned—the EA never chases a trade. The stop loss is placed at 1.5 ATR below the entry for longs and above for shorts, making it proportional to current market volatility rather than a fixed pip distance. The take profit is set at the configured risk-reward ratio. The broker's "SYMBOL_TRADE_STOPS_LEVEL" is checked before execution, and the stop and take profit are adjusted if they fall within the broker's minimum distance requirement.

**OnInit, OnDeinit, and OnTick**

With all detection and entry functions defined, the event handlers bring the EA to life.
    
    
    //+------------------------------------------------------------------+
    //| Expert initialization function                                   |
    //+------------------------------------------------------------------+
    int OnInit()
      {
       g_atr_handle = iATR(_Symbol, PERIOD_CURRENT, InpATRPeriod);               // Create ATR handle
       if(g_atr_handle == INVALID_HANDLE)                                        // Check handle
         {
          Print("WyckoffEA: ATR indicator handle creation failed.");             // Log error
          return INIT_FAILED;                                                    // Return failure
         }
       g_trade.SetExpertMagicNumber(InpMagicNumber);                             // Set magic number
       g_trade.SetDeviationInPoints(InpSlippage);                                // Set slippage
       g_state       = STATE_IDLE;                                               // Initialize state
       g_lps_count   = 0;                                                        // Initialize LPS counter
       g_lpsy_count  = 0;                                                        // Initialize LPSY counter
       g_range_watch = 0;                                                        // Initialize watch counter
       g_last_bar    = 0;                                                        // Initialize bar time
       Print("WyckoffEA initialized | Symbol: ", _Symbol,
             " | TF: ", EnumToString(Period()),
             " | Magic: ", InpMagicNumber);                                      // Log initialization
       return INIT_SUCCEEDED;                                                    // Return success
      }
    
    //+------------------------------------------------------------------+
    //| Expert deinitialization function                                 |
    //+------------------------------------------------------------------+
    void OnDeinit(const int reason)
      {
       IndicatorRelease(g_atr_handle);                                            // Release ATR handle
       ClearLabels();                                                             // Remove chart objects
      }
    
    //+------------------------------------------------------------------+
    //| Expert tick function                                             |
    //+------------------------------------------------------------------+
    void OnTick()
      {
       datetime current_bar = iTime(_Symbol, PERIOD_CURRENT, 0);                 // Current bar open time
       if(current_bar == g_last_bar)
          return;                                                                // Skip if same bar
       g_last_bar = current_bar;                                                 // Update last bar time
       if(g_state == STATE_IN_TRADE)                                             // In trade state
         {
          if(!PositionOpen())                                                    // Position has closed
            {
             Print("WyckoffEA: Trade closed — returning to IDLE.");              // Log closure
             g_state       = STATE_IDLE;                                         // Reset state
             g_lps_count   = 0;                                                  // Reset LPS counter
             g_lpsy_count  = 0;                                                  // Reset LPSY counter
             g_range_watch = 0;                                                  // Reset watch counter
             ClearLabels();                                                      // Clear chart
            }
          return;                                                                // Exit tick
         }
       switch(g_state)                                                           // State machine switch
         {
          case STATE_IDLE:                                                       // Idle state
             if(DetectRange())                                                   // Range found
               {
                g_state       = STATE_RANGE_FORMING;                             // Advance state
                g_range_watch = 0;                                               // Reset watch counter
               }
             break;                                                              // End case
          case STATE_RANGE_FORMING:                                              // Range locked — watch only
             g_range_watch++;                                                    // Increment watch counter
             if(g_range_watch > InpRangeWatchBars)                               // Range stale
               {
                Print("WyckoffEA: Range watch expired — returning to IDLE.");    // Log expiry
                g_state = STATE_IDLE;                                            // Reset state
                ClearLabels();                                                   // Clear chart
                break;                                                           // End case
               }
             if(g_range.bullish_bias)                                            // Accumulation bias
               {
                if(CheckSpring())
                   g_state = STATE_SPRING_DETECTED;                              // Spring found
               }
             else                                                                // Distribution bias
               {
                if(CheckUpthrust())
                   g_state = STATE_UPTHRUST_DETECTED;                            // Upthrust found
               }
             break;                                                              // End case
          case STATE_SPRING_DETECTED:                                            // Spring detected
             if(CheckSOS())                                                      // SOS found
               {
                g_state     = STATE_SOS_CONFIRMED;                               // Advance state
                g_lps_count = 0;                                                 // Reset LPS counter
               }
             else
                if(iClose(_Symbol, PERIOD_CURRENT, 1) < g_range.spring_low)      // Spring failed
                  {
                   Print("WyckoffEA: Spring invalidated — returning to IDLE.");  // Log failure
                   g_state = STATE_IDLE;                                         // Reset state
                   ClearLabels();                                                // Clear chart
                  }
             break;                                                              // End case
          case STATE_SOS_CONFIRMED:                                              // SOS confirmed
             CheckLPSEntry();                                                    // Check LPS entry
             break;                                                              // End case
          case STATE_UPTHRUST_DETECTED:                                          // Upthrust detected
             if(CheckSOW())                                                      // SOW found
               {
                g_state      = STATE_SOW_CONFIRMED;                              // Advance state
                g_lpsy_count = 0;                                                // Reset LPSY counter
               }
             else
                if(iClose(_Symbol, PERIOD_CURRENT, 1) > g_range.upthrust_high)    // Upthrust failed
                  {
                   Print("WyckoffEA: Upthrust invalidated — returning to IDLE.");  // Log failure
                   g_state = STATE_IDLE;                                           // Reset state
                   ClearLabels();                                                  // Clear chart
                  }
             break;                                                                // End case
          case STATE_SOW_CONFIRMED:                                                // SOW confirmed
             CheckLPSYEntry();                                                     // Check LPSY entry
             break;                                                                // End case
         }
      }

"OnInit()" creates the ATR indicator handle and returns "INIT_FAILED" immediately if creation fails, preventing the EA from running without its stop distance calculator. "OnDeinit()" releases the indicator handle and cleans up all chart objects. "OnTick()" uses a new-bar gate—comparing the current bar's open time against the stored "g_last_bar"—so all detection logic runs exactly once per closed bar rather than on every tick. The switch statement makes the state machine readable at a glance: each case has one responsibility, each transition has one trigger, and the code cannot reach any detection function without passing through all preceding states.

###   


### Backtesting  


To test the EA, open the MetaTrader 5 Strategy Tester and use these settings: Symbol = EURUSD; Timeframe = H4; Modeling = Every tick based on real ticks; Initial deposit = $10,000; Period = 2022.01.01–2024.12.31. Use the following inputs: "InpTrendBars" = 15; "InpMinRangeBars" = 15; "InpMaxRangeBars" = 60; "InpMinRangePips" = 20; "InpMaxRangePips" = 400; "InpSpringTolerance" = 10; "InpHighVolMult" = 1.2; "InpLowVolMult" = 1.2; "InpRiskPercent" = 1.0; "InpRR" = 2.0; "InpATRPeriod" = 14; "InpATRMult" = 1.5; and "InpLPSBars" = 8.

**What to Expect**

Wyckoff structures are not common. On EURUSD H4, expect between four and ten qualifying setups per year. This is correct behavior—the EA does not generate signals constantly. It waits for the full sequential evidence to accumulate before committing. When it does enter, the structural backing is complete: confirmed range, confirmed spring or upthrust, confirmed sign of strength or sign of weakness, and a pullback entry.

Trade duration will be bimodal: many short trades stopped at the initial stop during failed structures, and fewer but significantly longer winners that capture the markup or markdown phase after a complete accumulation or distribution. The average winner should be substantially larger than the average loser. If the profit factor is consistently below 1.0, increase "InpHighVolMult" to require a stronger sign of strength and a sign of weakness confirmation.

**Test Results**

_Demonstration on EURUSD H4._

![Demonstration on a chart](https://c.mql5.com/2/216/WyckoffEA.gif)

Fig. 3. Visual demonstration of detection and entry.

![graph](https://c.mql5.com/2/216/graph.png)

Fig. 4. Test results: equity and balance curve.

![test results](https://c.mql5.com/2/216/results.png)

Fig. 5. Test results.

![entries](https://c.mql5.com/2/216/entries.png)

Fig. 6. Test results, entries.

###   


### Known Limitations

Wyckoff structures require prior trend context. In genuinely sideways, trendless markets, the range detector may identify false structures. Increase "InpMinRangePips" and "InpTrendBars" if too many low-quality ranges are detected on a particular instrument.

Tick volume is a proxy, not real volume. The relative volume patterns are reliable. Absolute threshold values may need adjustment per broker. Run initial tests and observe the Journal tab for the volume diagnostics printed by each detection function.

The EA tracks one structure at a time. If a spring is invalidated because the price closes below the spring low, the state machine resets to "STATE_IDLE" and begins scanning for a new range. This is correct Wyckoff behavior—a failed spring changes the structural interpretation.

The "LPS" and "LPSY" entry window is fixed. After a sign of strength or a sign of weakness confirmation, the EA waits up to "InpLPSBars" bars for the pullback. In strong markup or markdown moves, price may not pull back within this window. The EA resets rather than chasing the move. This is conservative behavior by design.

The code is a demonstration of the Wyckoff concept in MQL5. Before live deployment, adjust volume multipliers to your symbol's typical tick volume behavior and run a minimum 24-month backtest on a demo account.

  


### Conclusion  


Wyckoff spent decades studying the same market behavior that modern traders call "Smart Money Concepts," "institutional footprints," and "liquidity engineering." His framework remains relevant because it describes market structure in terms of cause and effect—not patterns and indicators—and cause and effect does not go out of date.

The challenge of automating Wyckoff is not detecting individual events. Any EA can detect a close below support. The challenge is ensuring that each event only means something in the context of the events that preceded it. That context is what the state machine in this article enforces. A spring is not just a false breakdown. It is a false breakdown that occurs within a defined range, after a prior downtrend, on lower-than-average volume. Remove any of those conditions, and the signal is not a Wyckoff spring—it is just a dip. The state machine makes this impossible to bypass. The code cannot reach "CheckSpring()" without first passing through "DetectRange()." It cannot reach "CheckLPSEntry()" without first passing through both "CheckSpring()" and "CheckSOS()."

Every function introduced in this article has a single job. Furthermore, every state transition has a single trigger. Every volume check uses a relative ratio computed from the current structure, not a hard-coded number. The result is an EA that adapts to different instruments and volatility regimes while remaining anchored to the structural logic Wyckoff described.

The EA does not trade often. When it does, the full weight of a confirmed Wyckoff sequence is behind the entry.

All code was compiled and tested in MetaTrader 5. The complete WyckoffEA.mq5 source file is attached to this article. Copy WyckoffEA.mq5 to MQL5\\\Experts\\\ and compile in MetaEditor with no additional dependencies. Recommended for EURUSD on H4. Always test on a demo account before live deployment.

**Attached files** | 

[ __Download ZIP](/en/articles/download/22628.zip "Download all attachments in the single ZIP archive")

[__WyckoffEA.mq5](/en/articles/download/22628/WyckoffEA.mq5 "Download WyckoffEA.mq5") (41.36 KB)

**Warning:** All rights to these materials are reserved by MetaQuotes Ltd. Copying or reprinting of these materials in whole or in part is prohibited.

This article was written by a user of the site and reflects their personal views. MetaQuotes Ltd is not responsible for the accuracy of the information presented, nor for any consequences resulting from the use of the solutions, strategies or recommendations described.

![Tola Moses Hector](https://c.mql5.com/avatar/2025/12/693e9f9e-dbad_big.jpg)

[Tola Moses Hector](/en/users/tolahectorforex "Tola Moses Hector")

  * __Advanced Trading Systems
  * __[South Africa](https://www.mql5.com/go?https://maps.google.com/?z=4&q=South+Africa "Lives")
  * __[2201](/en/users/tolahectorforex/achievements "Rating")



* [](https://wa.me/27793002733)
* [](https://t.me/tolahector)

I started as a trader, analyzing charts, price action, and market structure long before writing my first line of MQL code. That trading foundation shapes every Expert Advisor and indicator I build.   
  
Today, I develop professional-grade Expert Advisors and indicators for MetaTrader, with a focus on robustness, clarity, and real-world usability. My work emphasizes clean architecture, risk-aware logic, and long-term maintainability rather than over-optimized or curve-fit systems.   
  
Beyond trading software, I also develop full-stack solutions, including front-end and back-end web applications, API integrations, and server deployments. I work with cloud infrastructure such as Microsoft Azure to support scalable, secure, and high-performance trading and data systems.   
  
My goal is simple: built well-engineered, professional tools that traders can understand, trust, and confidently use in live market environments.

#### Other articles by this author

  * [Position Management: A Reusable Trade Journal with Live Maximum Adverse Excursion, Maximum Favorable Excursion, and R-Multiple Tracking in MQL5](/en/articles/22855)
  * [Position Management: Safe Pyramiding with a Unified Stop in MQL5](/en/articles/22187)



**[Go to discussion](/en/forum/510756) **

![MetaTrader 5 Machine Learning Blueprint \(Part 17\): CPCV Backtesting — From Python Model to Tick-Level Evidence](https://c.mql5.com/2/219/21954-metatrader-5-machine-learning-logo.png) [MetaTrader 5 Machine Learning Blueprint (Part 17): CPCV Backtesting — From Python Model to Tick-Level Evidence](/en/articles/21954)

We bridge Python-native artifacts to MQL5 for tick-accurate CPCV backtesting. The export script converts the ONNX model, calibrator, feature spec, and path masks to flat files, while the expert advisor rebuilds features, performs ONNX inference with calibration, and trades on real ticks. The Strategy Tester runs each combinatorial path, and Python aggregates per-path equities into a path Sharpe distribution to assess robustness after spread, slippage, and commission.

![Seasonality Indicator by Hours, Days of the Week, and Days of the Month](https://c.mql5.com/2/153/18672-indikator-sezonnosti-po-chasam-logo__2.png) [Seasonality Indicator by Hours, Days of the Week, and Days of the Month](/en/articles/18672)

The article explains how to develop a tool for analyzing recurring price patterns in financial markets — by day of the month (1-31), day of the week (Monday-Sunday), or hour of the day (0-23). The indicator analyzes historical data, calculates the average return for each period, and displays the results as a histogram with a forecast. It includes customizable parameters: seasonality type, number of bars analyzed, display as percentages or absolute values, chart colors.

![MQL5 Trading Tools \(Part 34\): Replacing Native Chart Objects with an Interactive Canvas Drawing Layer](https://c.mql5.com/2/219/22786-mql5-trading-tools-part-34-logo.png) [MQL5 Trading Tools (Part 34): Replacing Native Chart Objects with an Interactive Canvas Drawing Layer](/en/articles/22786)

We replace native MetaTrader chart objects with a canvas-based drawing engine that renders tools pixel-by-pixel on a full-chart bitmap layer. The article implements persistent object storage with per-tool style memory, precise hit testing, selection, whole-object dragging, and handle manipulation. It also adds new line tools, a reorganized category system with a one-click delete action, and a rubber-band preview for multi-click placement.

![Backtracking Search Algorithm \(BSA\)](https://c.mql5.com/2/152/18568-algoritm-obratnogo-poiska-backtracking-logo.png) [Backtracking Search Algorithm (BSA)](/en/articles/18568)

What if an optimization algorithm could remember its past journeys and use that memory to find better solutions? BSA does just that – balancing exploration with revisiting the tried and true. In this article, we reveal the secrets of the algorithm. A simple idea, minimum parameters and a stable result.

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


