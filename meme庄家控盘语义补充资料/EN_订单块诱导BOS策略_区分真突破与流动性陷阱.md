# EN_订单块诱导BOS策略_区分真突破与流动性陷阱

> 来源标题：Automating Trading Strategies in MQL5 (Part 48): Order Blocks, Inducement, Break of Structure - MQL5 Articles
> 来源链接：https://www.mql5.com/en/articles/22078
> 下载时间：2026-06-13 00:08:34
> 用途：补充 meme 市场庄家控盘、深洗、诱多、二次确认相关语义。

---

__

[ __](/en/articles/22078?print= "Printer friendly version")

![preview](data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAsICAoIBwsKCQoNDAsNERwSEQ8PESIZGhQcKSQrKigkJyctMkA3LTA9MCcnOEw5PUNFSElIKzZPVU5GVEBHSEX/2wBDAQwNDREPESESEiFFLicuRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUX/wAARCAAQACADASIAAhEBAxEB/8QAGAABAAMBAAAAAAAAAAAAAAAABAEDBQf/xAAgEAACAgEDBQAAAAAAAAAAAAABAgADBBEhMQUiUYGh/8QAFQEBAQAAAAAAAAAAAAAAAAAAAQL/xAAXEQEBAQEAAAAAAAAAAAAAAAABAAIR/9oADAMBAAIRAxEAPwDldeMWbnQTSx+nIw3aBrYgxldui9zH1LQqzTdgVjg/YVsZQdpbbafJhmsOsThGnt//2Q==)

![Automating Trading Strategies in MQL5 \(Part 48\): Order Blocks, Inducement, Break of Structure](https://c.mql5.com/2/208/22078-automating-trading-strategies-in-mql5-part-48-order-blocks_600x314.jpg)

# Automating Trading Strategies in MQL5 (Part 48): Order Blocks, Inducement, Break of Structure

[MetaTrader 5](/en/articles/mt5) — [Trading](/en/articles/mt5/trading) | 28 April 2026, 10:59

![](https://c.mql5.com/i/icons.svg#views-white-usage) 6 014  [ ![](https://c.mql5.com/i/icons.svg#comments-white-usage) 0 ](/en/forum/509056 "Comments")

![Allan Munene Mutiiria](https://c.mql5.com/avatar/2022/11/637df59b-9551.jpg)

[Allan Munene Mutiiria](/en/users/29210372)

### Introduction

Traders using price action often struggle to distinguish between genuine breakouts and liquidity traps — price moves that appear to signal a trend continuation but are in fact engineered to sweep stop losses before reversing. Without a structured framework to identify where institutional orders are likely resting and how prices interact with those levels, entries become inconsistent, and risk management becomes guesswork. This article is for [MetaQuotes Language 5](https://www.metaquotes.net/en/metatrader5/algorithmic-trading/mql5 "https://www.metaquotes.net/en/metatrader5/algorithmic-trading/mql5") (MQL5) developers and algorithmic traders looking to automate a structured smart money approach to order block trading.

In the [previous article (Part 47)](/en/articles/21096), we automated the Nick Rypock Trailing Reverse strategy in MQL5, incorporating hedging features that cover trend detection, dynamic trailing logic, and position management across both buy and sell directions. In this article, we build on smart money concepts and construct a program that identifies order blocks in consolidation zones. It validates them using break of structure and inducement detection and executes trades only when conditions align with the higher-timeframe trend. We will cover the following topics:

  1. [Understanding the Inducement Mitigation Block Strategy](/en/articles/22078#para2)
  2. [Implementation in MQL5](/en/articles/22078#para3)
  3. [Backtesting](/en/articles/22078#para4)
  4. [Conclusion](/en/articles/22078#para5)



By the end, you will create a fully automated MQL5 program that detects, validates, and trades order blocks using break of structure and inducement confirmation — ready for backtesting and further customization.

  


### Understanding the Inducement Mitigation Block Strategy

[Order blocks](/go?link=https://www.xs.com/en/blog/order-block-guide/ "https://www.xs.com/en/blog/order-block-guide/") are price zones where institutional participants are believed to have placed significant buy or sell orders, typically forming as the last opposing candle before a strong impulsive move away from a consolidation area. When price eventually returns to these zones, it often reacts, providing an opportunity to enter in the direction of the prevailing institutional flow. The concept is rooted in smart money theory, where large players accumulate or distribute positions within tight ranges before driving price aggressively in one direction.

The [inducement](/go?link=https://howtotrade.com/blog/inducement-trading/ "https://howtotrade.com/blog/inducement-trading/") element adds a critical filter to this framework. Before a genuine break of structure occurs, price frequently makes a minor swing in the opposing direction to trigger retail stop losses and collect liquidity — this engineered move is the inducement. Recognizing it separates high-probability setups from noise, because a break of structure that follows a confirmed inducement carries significantly more weight than one that does not.

Use order block zones as your primary entry reference. Enter longs at bullish order blocks in an established uptrend and shorts at bearish order blocks in a downtrend. Confirm the setup only when a break of structure has occurred after a visible inducement swing, signaling that liquidity has been collected and the move is likely genuine. Use the [fair value gap](/go?link=https://howtotrade.com/blog/fair-value-gap/ "https://howtotrade.com/blog/fair-value-gap/") within the impulse as an additional confluence, treating it as evidence of strong directional intent. Avoid trading order blocks that have been deeply mitigated without reaction, and always align your entries with the higher timeframe trend to filter out counter-trend noise.

We will implement a higher-timeframe trend engine using swing-structure analysis. We will add consolidation detection for order block formation zones, fair value gap scanning for impulsive moves, and validation via break of structure and inducement. Finally, we will implement mitigation tracking with visual updates and a trade execution engine with risk-based lot sizing and trailing stop options. In a nutshell, here is a visual representation of what we intend to achieve.

![STRATEGY BLUEPRINT](https://c.mql5.com/2/205/Screenshot_2026-04-07_133055.png)

  


### Implementation in MQL5

 _Defining Enumerations, Structures, Inputs, and Global Variables_

To set the foundation of the program, we define the core configuration types, data structures, [input parameters](/en/docs/basis/variables/inputvariables), and global state variables that will drive all detection, visualization, and trade execution logic throughout the program.
    
    
    //+------------------------------------------------------------------+
    //|                         Inducement Mitigation Block Strategy.mq5 |
    //|                           Copyright 2026, Allan Munene Mutiiria. |
    //|                                   https://t.me/Forex_Algo_Trader |
    //+------------------------------------------------------------------+
    #property copyright "Copyright 2026, Allan Munene Mutiiria."
    #property link      "https://t.me/Forex_Algo_Trader"
    #property version   "1.00"
    
    #include <Trade/Trade.mqh>
    
    //+------------------------------------------------------------------+
    //| Enums                                                            |
    //+------------------------------------------------------------------+
    
    // Define modes for how many times an OB can be traded
    enum TradeMode
      {
       TradeOnce,       // Trade Once: enter only one trade per OB
       LimitedTrades,   // Limited Trades: enter up to a fixed number of trades per OB
       UnlimitedTrades  // Unlimited Trades: no restriction on trades per OB
      };
    
    // Define the mitigation state of an FVG or OB zone
    enum FVGState
      {
       Normal,   // Normal: zone has not been mitigated yet
       Mitigated // Mitigated: price has swept through the zone
      };
    
    // Define available trailing stop strategies
    enum TrailingTypeEnum
      {
       Trailing_None   = 0, // None: no trailing stop applied
       Trailing_RR     = 1, // RR-Based: trail stop by risk:reward multiples
       Trailing_Points = 2  // Points-Based: trail stop by fixed pip distance
      };
    
    // Define whether to allow trading on already-mitigated OBs
    enum TradeMitigatedOBs
      {
       DoNotTradeMitigated, // Skip Mitigated: ignore OBs that have been mitigated
       TradeMitigated       // Allow Mitigated: still trade OBs after mitigation
      };
    
    //+------------------------------------------------------------------+
    //| Inputs                                                           |
    //+------------------------------------------------------------------+
    input group "=== EA GENERAL SETTINGS ==="
    input ENUM_TIMEFRAMES   higher_tf              = PERIOD_H4;             // Higher Timeframe for Trend
    input ENUM_TIMEFRAMES   trade_tf               = PERIOD_CURRENT;        // Trading Timeframe for OB/FVG
    input int               swing_strength         = 5;                     // Swing Point Strength in Bars
    input double            risk_percent           = 0.1;                   // Risk Percentage per Trade (0.1%)
    input int               sl_offset_pts          = 10;                    // SL Offset Points
    input double            rr_ratio               = 4.0;                   // Risk:Reward Ratio
    input int               minPts                 = 10;                    // Minimum Gap Size in Points
    input int               FVG_Rec_Ext_Bars       = 10;                    // FVG Extension Bars
    input int               OB_Rec_Ext_Bars        = 300;                   // OB Extension Bars
    input int               inducement_ext_bars    = 10;                    // Inducement Trendline Extension Bars
    input int               minIndDepthPts         = 20;                    // Minimum Inducement Depth in Points
    input bool              prt                    = true;                  // Print Statements
    input long              magic_number           = 123456789;             // Magic Number
    input bool              ignoreOverlaps         = true;                  // Ignore new zones that overlap existing ones
    input TradeMode         tradeMode              = TradeOnce;             // Mode for trading OBs
    input int               maxTradesPerOB         = 2;                     // Maximum trades per OB for LimitedTrades
    input int               maxZones               = 50;                    // Maximum OBs to track in array
    input TrailingTypeEnum  TrailingType           = Trailing_RR;           // Trailing Stop Type
    input double            Trailing_Stop_Pips     = 30.0;                  // Trailing Stop in Pips (for Points type)
    input double            Min_Profit_To_Trail_Pips = 50.0;                // Min Profit to Start Trailing in Pips
    input color             def_clr_up             = clrBlue;               // Swing High Color
    input color             def_clr_down           = clrRed;                // Swing Low Color
    input int               object_code            = 77;                    // Object Code for Swing Points
    input int               width                  = 2;                     // Line Width
    input TradeMitigatedOBs tradeMitigated         = TradeMitigated;        // Trade Mitigated OBs
    input int               OBRangeCandles         = 7;                     // Number of Candles for Consolidation Range
    input double            OBMaxDeviation         = 50.0;                  // Max Deviation in Points for Equal Highs/Lows
    input int               OBWaitBars             = 3;                     // Wait Bars for Impulse Confirmation
    input double            OBImpulseThreshold     = 1.0;                   // Impulse Threshold as Multiplier of Range
    input bool              VisualizeLevels        = true;                  // Visualize SL/TP Levels on Chart
    
    //+------------------------------------------------------------------+
    //| Structures                                                       |
    //+------------------------------------------------------------------+
    
    // Store price and bar index together for range analysis
    struct PriceIndex
      {
       double price; // Store the price level
       int    index; // Store the bar index
      };
    
    // Store trade ticket, initial risk, and trailing level for RR trailing
    struct TradeInfo
      {
       ulong  ticket;      // Store open position ticket
       double orig_risk;   // Store initial risk distance in price
       int    trail_level; // Store current RR trailing level reached
      };
    
    // Store all metadata and state for a single Order Block zone
    struct OBZone
      {
       string    name;        // Store the chart object name of the OB rectangle
       datetime  startTime;   // Store the time of the OB candle
       datetime  origEndTime; // Store the calculated expiry time of the OB
       datetime  mitTime;     // Store the time mitigation occurred (0 if not mitigated)
       datetime  fvgTime;     // Store the time of the associated FVG candle
       bool      signal;      // Store whether a trade signal has ever occurred
       bool      mit;         // Store whether the OB has been mitigated
       bool      origUp;      // Store whether the OB is bullish (true) or bearish (false)
       int       tradeCount;  // Store how many times this OB has been traded
       FVGState  state;       // Store the current mitigation state enum value
       bool      newSignal;   // Store whether a fresh signal occurred on this bar
       bool      valid;       // Store whether BOS and inducement have been confirmed
      };
    
    //+------------------------------------------------------------------+
    //| Global Variables                                                 |
    //+------------------------------------------------------------------+
    CTrade   obj_Trade;                      // Trade execution object
    long     chart_id          = -1;         // Higher timeframe chart ID (-1 means not open)
    int      current_trend     = 0;          // Current trend direction: 1=up, -1=down, 0=none
    int      current_font_size = 10;         // Dynamic font size updated by chart scale
    string   fvg_names[];                    // Store names of all FVG rectangle objects
    OBZone   obs[];                          // Store all tracked Order Block zones
    TradeInfo trades[];                      // Store RR trailing data for open positions
    
    //--- Define chart object name prefixes
    #define FVG_Prefix    "FVG REC "  // Prefix for FVG rectangle objects
    #define OB_Prefix     "OB REC "   // Prefix for OB rectangle objects
    #define BOS_Prefix    "BOS_"      // Prefix for BOS line objects
    #define IND_Prefix    "IND_"      // Prefix for inducement trendline objects
    
    //--- Define zone colors per direction and state
    #define CLR_UP        clrGreen   // Active bullish zone color
    #define CLR_DOWN      clrRed     // Active bearish zone color
    #define CLR_MIT_UP    clrPurple  // Mitigated bullish zone color
    #define CLR_MIT_DOWN  clrOrange  // Mitigated bearish zone color
    
    

We start the implementation by including the "Trade.mqh" library, which gives us access to the [CTrade](/en/docs/standardlibrary/tradeclasses/ctrade) class for simplified and reliable trade execution. From there, we define four [enumerations](/en/docs/basis/types/integer/enumeration) that govern the program's core behavioral options. The "TradeMode" enumeration controls how many times a single order block zone can be traded — once, up to a fixed count, or without restriction. The "FVGState" enumeration tracks whether a zone is still active or has already been mitigated by price. The "TrailingTypeEnum" enumeration offers three trailing stop modes: none, risk-to-reward based, and fixed points based. Finally, "TradeMitigatedOBs" determines whether the program should continue trading an order block zone even after the price has swept through it.

Following the enumerations, we declare the [input parameters](/en/docs/basis/variables/inputvariables) grouped under a settings label. These cover the higher timeframe for trend analysis, the trading timeframe for zone detection, swing strength, risk percentage, stop loss offset, risk-to-reward ratio, minimum fair value gap size in points, rectangle extension bars for both fair value gaps and order blocks, inducement extension bars and minimum depth, overlap handling, trade mode selection, trailing stop configuration, visual color preferences, consolidation range settings, and the option to visualize trade levels on the chart.

We then define three [structures](/en/docs/basis/types/classes). The "PriceIndex" structure pairs a price level with its corresponding bar index for use in consolidation range analysis. The "TradeInfo" structure stores the ticket, initial risk distance, and current trailing level for each open position under risk-to-reward trailing management. The "OBZone" structure is the most comprehensive, holding all metadata for a tracked order block — its chart object name, start and expiry times, mitigation time, associated fair value gap time, signal and mitigation flags, direction, trade count, state, and validation status.

On the global side, we instantiate the "CTrade" object for order management, declare the higher timeframe chart identifier, the current trend direction, a dynamic font size variable, and three dynamic arrays — one for fair value gap object names, one for order block zone records using the "OBZone" structure, and one for open trade tracking using "TradeInfo". We also define preprocessor constants for the chart object name prefixes and the four zone colors representing active and mitigated bullish and bearish states. You can change all these to your desired values. The next thing we do is define some helper functions.

_Utility and Visual Helper Functions_

Before the core detection logic runs, we establish a set of helper [functions](/en/docs/basis/function) responsible for color resolution, debug logging, and all chart object rendering. These keep the main logic clean by delegating all visual and state-reporting tasks to dedicated routines.
    
    
    //+------------------------------------------------------------------+
    //| Get color based on state and direction                           |
    //+------------------------------------------------------------------+
    color GetZoneColor(bool isUp, FVGState currentState)
      {
       //--- Return bullish or bearish active color for normal state
       if (currentState == Normal)    return isUp ? CLR_UP   : CLR_DOWN;
       //--- Return bullish or bearish mitigated color for mitigated state
       if (currentState == Mitigated) return isUp ? CLR_MIT_UP : CLR_MIT_DOWN;
       //--- Return no color as fallback
       return clrNONE;
      }
    
    //+------------------------------------------------------------------+
    //| Print OBs for debugging                                          |
    //+------------------------------------------------------------------+
    void PrintOBs()
      {
       //--- Skip if printing is disabled
       if (!prt) return;
       //--- Print total count of tracked OBs
       Print("Current OBs count: ", ArraySize(obs));
       //--- Iterate and print each OB's key properties
       for (int i = 0; i < ArraySize(obs); i++)
         {
          Print("OB ", i, ": ", obs[i].name,
                " state=",      EnumToString(obs[i].state),
                " mit=",        obs[i].mit,
                " tradeCount=", obs[i].tradeCount,
                " newSignal=",  obs[i].newSignal,
                " valid=",      obs[i].valid,
                " endTime=",    TimeToString(obs[i].origEndTime));
         }
      }
    
    //+------------------------------------------------------------------+
    //| Draw trend label on main chart                                   |
    //+------------------------------------------------------------------+
    void DrawTrendLabel()
      {
       //--- Define the label object name
       string trendObj  = "EA_TrendLabel";
       //--- Build the trend text based on current direction
       string trendText = (current_trend ==  1) ? "UPTREND"   :
                          (current_trend == -1) ? "DOWNTREND" : "NO TREND";
       //--- Choose display color matching the trend direction
       color  trendClr  = (current_trend ==  1) ? clrLimeGreen :
                          (current_trend == -1) ? clrRed       : clrGray;
       //--- Create the label if it does not already exist
       if (ObjectFind(0, trendObj) < 0)
          ObjectCreate(0, trendObj, OBJ_LABEL, 0, 0, 0);
       //--- Position the label in the upper-left corner of the chart
       ObjectSetInteger(0, trendObj, OBJPROP_CORNER,    CORNER_LEFT_UPPER);
       ObjectSetInteger(0, trendObj, OBJPROP_XDISTANCE, 12);
       ObjectSetInteger(0, trendObj, OBJPROP_YDISTANCE, 30);
       //--- Set label text, color, font, and size
       ObjectSetString (0, trendObj, OBJPROP_TEXT,      "H4 Trend: " + trendText);
       ObjectSetInteger(0, trendObj, OBJPROP_COLOR,     trendClr);
       ObjectSetInteger(0, trendObj, OBJPROP_FONTSIZE,  14);
       ObjectSetString (0, trendObj, OBJPROP_FONT,      "Arial Bold");
       //--- Refresh the chart to display the updated label
       ChartRedraw(0);
      }
    
    //+------------------------------------------------------------------+
    //| Update font sizes based on chart scale                           |
    //+------------------------------------------------------------------+
    void UpdateFontSizes()
      {
       long scale = 0;
       //--- Read the current chart zoom scale level
       if (ChartGetInteger(0, CHART_SCALE, 0, scale))
         {
          //--- Compute new font size proportional to scale
          current_font_size = (int)(7 + scale * 0.7);
          //--- Clamp font size to a minimum of 6
          if (current_font_size < 6)  current_font_size = 6;
          //--- Clamp font size to a maximum of 15
          if (current_font_size > 15) current_font_size = 15;
          //--- Iterate all chart objects and update text font sizes
          for (int i = ObjectsTotal(0, -1, -1) - 1; i >= 0; i--)
            {
             string name = ObjectName(0, i, -1, -1);
             //--- Apply new font size only to text objects
             if (ObjectGetInteger(0, name, OBJPROP_TYPE) == OBJ_TEXT)
                ObjectSetInteger(0, name, OBJPROP_FONTSIZE, current_font_size);
            }
          //--- Refresh the chart after updating all text objects
          ChartRedraw(0);
         }
      }
    
    //+------------------------------------------------------------------+
    //| Create label for a zone rectangle                                |
    //+------------------------------------------------------------------+
    void CreateLabel(string zoneName, datetime time, double price)
      {
       //--- Build the label object name from the zone name
       string lblName = zoneName + "_Label";
       //--- Create a text object at the midpoint of the zone
       ObjectCreate(0, lblName, OBJ_TEXT, 0, time, price);
       //--- Center the anchor point of the label
       ObjectSetInteger(0, lblName, OBJPROP_ANCHOR,   ANCHOR_CENTER);
       //--- Set label color to black for readability on zone fill
       ObjectSetInteger(0, lblName, OBJPROP_COLOR,    clrBlack);
       //--- Apply the current dynamic font size
       ObjectSetInteger(0, lblName, OBJPROP_FONTSIZE, current_font_size);
       //--- Populate the label text based on zone state
       UpdateLabelText(lblName, zoneName);
      }
    
    //+------------------------------------------------------------------+
    //| Update label position                                            |
    //+------------------------------------------------------------------+
    void UpdateLabel(string zoneName, datetime time, double price)
      {
       //--- Build the label object name
       string lblName = zoneName + "_Label";
       //--- Update only if the label object already exists
       if (ObjectFind(0, lblName) >= 0)
         {
          //--- Move the label to the new time position
          ObjectSetInteger(0, lblName, OBJPROP_TIME,    0, time);
          //--- Move the label to the new price position
          ObjectSetDouble (0, lblName, OBJPROP_PRICE,   0, price);
          //--- Sync the font size with the current dynamic value
          ObjectSetInteger(0, lblName, OBJPROP_FONTSIZE, current_font_size);
          //--- Refresh the label text to reflect any state changes
          UpdateLabelText(lblName, zoneName);
         }
      }
    
    //+------------------------------------------------------------------+
    //| Update label text based on zone state                            |
    //+------------------------------------------------------------------+
    void UpdateLabelText(string lblName, string zoneName)
      {
       //--- Initialize text and tracking variables
       string   text     = "";
       int      tradeCnt = 0;
       FVGState state    = Normal;
       bool     origUp   = false;
       //--- Search OB array for a matching zone and extract its properties
       for (int idx = 0; idx < ArraySize(obs); idx++)
         {
          if (obs[idx].name == zoneName)
            {
             tradeCnt = obs[idx].tradeCount;
             state    = obs[idx].state;
             origUp   = obs[idx].origUp;
             break;
            }
         }
       //--- Build FVG label text from zone color when it is an FVG object
       if (StringFind(zoneName, FVG_Prefix) >= 0)
         {
          color zoneClr   = (color)ObjectGetInteger(0, zoneName, OBJPROP_COLOR);
          bool  isBullish = (zoneClr == CLR_UP);
          text = isBullish ? "Bullish FVG" : "Bearish FVG";
         }
       else
         {
          //--- Assign OB direction label based on state
          if      (state == Normal)    text = origUp ? "Bullish OB" : "Bearish OB";
          else if (state == Mitigated) text = origUp ? "Mitigated Bullish OB" : "Mitigated Bearish OB";
          //--- Append trade count if at least one trade has been taken
          if (tradeCnt > 0) text += " (Traded " + IntegerToString(tradeCnt) + " times)";
         }
       //--- Write the constructed text to the chart label object
       ObjectSetString(0, lblName, OBJPROP_TEXT, text);
      }
    
    

We begin with the "GetZoneColor" [function](/en/docs/basis/function), which resolves the correct display color for any zone based on its direction and current mitigation state. For active zones, it returns green for bullish and red for bearish, and for mitigated zones, it returns purple for bullish and orange for bearish, falling back to no color if neither state matches. Next, the "PrintOBs" function serves as a debugging utility. When printing is enabled, it outputs the total count of tracked order blocks followed by each zone's name, state, mitigation flag, trade count, signal flag, validation status, and expiry time using [EnumToString](/en/docs/convert/enumtostring) to convert the state enumeration into readable text.

The "DrawTrendLabel" function handles the on-chart trend display. It constructs a label object named "EA_TrendLabel" and positions it in the upper-left corner of the chart. The text and color update dynamically — lime green for an uptrend, red for a downtrend, and gray when no trend is defined — before calling [ChartRedraw](/en/docs/chart_operations/ChartRedraw) to reflect the changes immediately. To keep text readable across different zoom levels, we define "UpdateFontSizes". It reads the current chart scale using [ChartGetInteger](/en/docs/chart_operations/chartgetinteger) and computes a proportional font size clamped between 6 and 15. It then iterates all chart objects and applies the updated size to every text object found, finishing with a chart redraw.

For zone labeling, we define three tightly coupled functions. The "CreateLabel" function places a centered black text object at the midpoint of a zone rectangle, applying the current dynamic font size and immediately calling "UpdateLabelText" to populate it. The "UpdateLabel" function repositions and refreshes an existing label when a zone's time or price boundaries change. The "UpdateLabelText" function resolves label content. It searches the order block array for the matching zone name and builds the label string. For fair value gap objects, it reads the zone color to determine direction and writes either "Bullish FVG" or "Bearish FVG". For order block objects, it writes the direction and state, appending a trade count suffix using [IntegerToString](/en/docs/convert/integertostring) if at least one trade has been taken on that zone. Next, we will define the rectangle and line functions.

_Zone Rectangle and Structural Drawing Functions_

With the label and color utilities in place, we now define the functions responsible for drawing and updating all chart objects — zone rectangles, swing point arrows, break of structure lines, trade level lines, and mitigation icons.
    
    
    //+------------------------------------------------------------------+
    //| Create Rectangle zone on chart                                   |
    //+------------------------------------------------------------------+
    void CreateRec(string objName, datetime time1, double price1, datetime time2, double price2, color clr)
      {
       //--- Sync font size before drawing
       UpdateFontSizes();
       //--- Create the rectangle object spanning time and price boundaries
       ObjectCreate(0, objName, OBJ_RECTANGLE, 0, time1, price1, time2, price2);
       //--- Determine if this object is an FVG by checking its name prefix
       bool isFVG = StringFind(objName, FVG_Prefix) >= 0;
       //--- FVGs are unfilled outlines; OBs are solid filled rectangles
       ObjectSetInteger(0, objName, OBJPROP_FILL,  isFVG ? false : true);
       //--- FVGs use a thicker border; OBs use a thinner border
       ObjectSetInteger(0, objName, OBJPROP_WIDTH,  isFVG ? 2 : 1);
       //--- Apply the provided zone color
       ObjectSetInteger(0, objName, OBJPROP_COLOR,  clr);
       //--- Keep the rectangle in the foreground layer
       ObjectSetInteger(0, objName, OBJPROP_BACK,   false);
       //--- Compute midpoint time and price for label placement
       datetime midTime  = time1 + (time2 - time1) / 2;
       double   midPrice = (price1 + price2) / 2;
       //--- Create the descriptive text label at the zone midpoint
       CreateLabel(objName, midTime, midPrice);
       //--- Refresh the chart to render the new rectangle and label
       ChartRedraw(0);
      }
    
    //+------------------------------------------------------------------+
    //| Update Rectangle zone on chart                                   |
    //+------------------------------------------------------------------+
    void UpdateRec(string objName, datetime time1, double price1, datetime time2, double price2, color clr)
      {
       //--- Sync font size before updating
       UpdateFontSizes();
       //--- Update only if the rectangle object already exists on the chart
       if (ObjectFind(0, objName) >= 0)
         {
          //--- Update the start time anchor of the rectangle
          ObjectSetInteger(0, objName, OBJPROP_TIME,  0, time1);
          //--- Update the start price anchor of the rectangle
          ObjectSetDouble (0, objName, OBJPROP_PRICE, 0, price1);
          //--- Update the end time anchor of the rectangle
          ObjectSetInteger(0, objName, OBJPROP_TIME,  1, time2);
          //--- Update the end price anchor of the rectangle
          ObjectSetDouble (0, objName, OBJPROP_PRICE, 1, price2);
          //--- Apply the updated zone color (e.g., after mitigation)
          ObjectSetInteger(0, objName, OBJPROP_COLOR,    clr);
          //--- Recompute midpoint for label repositioning
          datetime midTime  = time1 + (time2 - time1) / 2;
          double   midPrice = (price1 + price2) / 2;
          //--- Move the label to the updated midpoint
          UpdateLabel(objName, midTime, midPrice);
          //--- Refresh the chart to show the updated rectangle
          ChartRedraw(0);
         }
      }
    
    //+------------------------------------------------------------------+
    //| Draw swing point arrow and BoS text on target chart              |
    //+------------------------------------------------------------------+
    void drawSwingPoint(string objName, datetime time, double price, int arrCode, color clr, int direction, long cid = 0)
      {
       //--- Skip creation if the arrow object already exists on the target chart
       if (ObjectFind(cid, objName) >= 0) return;
       //--- Create the arrow object at the swing price and time
       ObjectCreate(cid, objName, OBJ_ARROW, 0, time, price);
       //--- Set the arrow glyph code
       ObjectSetInteger(cid, objName, OBJPROP_ARROWCODE, arrCode);
       //--- Apply the directional color to the arrow
       ObjectSetInteger(cid, objName, OBJPROP_COLOR,     clr);
       //--- Set the font size for the arrow (shared with text objects)
       ObjectSetInteger(cid, objName, OBJPROP_FONTSIZE,  current_font_size);
       //--- Anchor arrow above the bar for upward-pointing swings
       if (direction > 0) ObjectSetInteger(cid, objName, OBJPROP_ANCHOR, ANCHOR_TOP);
       //--- Anchor arrow below the bar for downward-pointing swings
       if (direction < 0) ObjectSetInteger(cid, objName, OBJPROP_ANCHOR, ANCHOR_BOTTOM);
       //--- Build the companion BoS label object name
       string txt          = " BoS";
       string objNameDescr = objName + txt;
       //--- Create the descriptive text label at the same time and price
       ObjectCreate(cid, objNameDescr, OBJ_TEXT, 0, time, price);
       //--- Apply color and font size to the text label
       ObjectSetInteger(cid, objNameDescr, OBJPROP_COLOR,    clr);
       ObjectSetInteger(cid, objNameDescr, OBJPROP_FONTSIZE, current_font_size);
       //--- Position text above the bar for upward swings
       if (direction > 0)
         {
          ObjectSetInteger(cid, objNameDescr, OBJPROP_ANCHOR, ANCHOR_LEFT_UPPER);
          ObjectSetString (cid, objNameDescr, OBJPROP_TEXT,   " " + txt);
         }
       //--- Position text below the bar for downward swings
       if (direction < 0)
         {
          ObjectSetInteger(cid, objNameDescr, OBJPROP_ANCHOR, ANCHOR_LEFT_LOWER);
          ObjectSetString (cid, objNameDescr, OBJPROP_TEXT,   " " + txt);
         }
       //--- Refresh the main chart only when drawing on it
       if (cid == 0) ChartRedraw(0);
      }
    
    //+------------------------------------------------------------------+
    //| Draw break level arrowed line on main chart                      |
    //+------------------------------------------------------------------+
    void drawBreakLevel(string objName, datetime time1, double price1, datetime time2, double price2, color clr, int direction)
      {
       //--- Skip if the break level line already exists
       if (ObjectFind(0, objName) >= 0) return;
       //--- Create a horizontal arrowed line from swing time to break time
       ObjectCreate(0, objName, OBJ_ARROWED_LINE, 0, time1, price1, time2, price2);
       //--- Explicitly set both anchor time and price points
       ObjectSetInteger(0, objName, OBJPROP_TIME,  0, time1);
       ObjectSetDouble (0, objName, OBJPROP_PRICE, 0, price1);
       ObjectSetInteger(0, objName, OBJPROP_TIME,  1, time2);
       ObjectSetDouble (0, objName, OBJPROP_PRICE, 1, price2);
       //--- Apply color and width to the line
       ObjectSetInteger(0, objName, OBJPROP_COLOR, clr);
       ObjectSetInteger(0, objName, OBJPROP_WIDTH, width);
       //--- Build the companion "Break" text label name
       string txt          = " Break ";
       string objNameDescr = objName + txt;
       //--- Create the text label at the end point of the break line
       ObjectCreate(0, objNameDescr, OBJ_TEXT, 0, time2, price2);
       //--- Apply color and font size to the break label
       ObjectSetInteger(0, objNameDescr, OBJPROP_COLOR,    clr);
       ObjectSetInteger(0, objNameDescr, OBJPROP_FONTSIZE, current_font_size);
       //--- Anchor above for downward-facing breaks
       if (direction > 0)
         {
          ObjectSetInteger(0, objNameDescr, OBJPROP_ANCHOR, ANCHOR_RIGHT_UPPER);
          ObjectSetString (0, objNameDescr, OBJPROP_TEXT,   " " + txt);
         }
       //--- Anchor below for upward-facing breaks
       if (direction < 0)
         {
          ObjectSetInteger(0, objNameDescr, OBJPROP_ANCHOR, ANCHOR_RIGHT_LOWER);
          ObjectSetString (0, objNameDescr, OBJPROP_TEXT,   " " + txt);
         }
       //--- Refresh the chart to show the new break level
       ChartRedraw(0);
      }
    
    //+------------------------------------------------------------------+
    //| Draw dotted horizontal trend line for entry/SL/TP visualization |
    //+------------------------------------------------------------------+
    void DrawDottedLine(string name, datetime t1, double p, datetime t2, color lineColor)
      {
       //--- Skip if the line already exists on the chart
       if (ObjectFind(0, name) >= 0) return;
       //--- Create a horizontal trend line between the two time points
       ObjectCreate(0, name, OBJ_TREND, 0, t1, p, t2, p);
       //--- Apply the specified color to the line
       ObjectSetInteger(0, name, OBJPROP_COLOR, lineColor);
       //--- Use a dotted style to distinguish it from structural lines
       ObjectSetInteger(0, name, OBJPROP_STYLE, STYLE_DOT);
       //--- Set line width to 1 pixel
       ObjectSetInteger(0, name, OBJPROP_WIDTH, 1);
       //--- Refresh the chart to display the new dotted line
       ChartRedraw(0);
      }
    
    //+------------------------------------------------------------------+
    //| Draw anchored text label for trade level annotation              |
    //+------------------------------------------------------------------+
    void DrawTextEx(string name, string text, datetime t, double p, color cl, bool isHigh)
      {
       //--- Skip if the text object already exists
       if (ObjectFind(0, name) >= 0) return;
       //--- Create a text object at the specified time and price
       ObjectCreate(0, name, OBJ_TEXT, 0, t, p);
       //--- Set the display text content
       ObjectSetString (0, name, OBJPROP_TEXT,     text);
       //--- Apply the specified color
       ObjectSetInteger(0, name, OBJPROP_COLOR,    cl);
       //--- Apply the current dynamic font size
       ObjectSetInteger(0, name, OBJPROP_FONTSIZE, current_font_size);
       //--- Use bold Arial for clear readability
       ObjectSetString (0, name, OBJPROP_FONT,     "Arial Bold");
       //--- Anchor below the price for swing highs, above for swing lows
       ObjectSetInteger(0, name, OBJPROP_ANCHOR,   isHigh ? ANCHOR_BOTTOM : ANCHOR_TOP);
       //--- Center the text horizontally around the anchor time
       ObjectSetInteger(0, name, OBJPROP_ALIGN,    ALIGN_CENTER);
       //--- Refresh the chart to render the new label
       ChartRedraw(0);
      }
    
    //+------------------------------------------------------------------+
    //| Draw mitigation icon arrow on the OB zone                        |
    //+------------------------------------------------------------------+
    void DrawMitIcon(string zoneNAME, datetime mitTime, double zoneHigh, double zoneLow, bool isUp)
      {
       //--- Build the mitigation icon object name
       string iconName  = zoneNAME + "_MitIcon";
       //--- Place the icon at the near edge of the zone relative to direction
       double iconPrice = isUp ? zoneLow : zoneHigh;
       //--- Create the arrow icon at the mitigation time and price
       ObjectCreate(0, iconName, OBJ_ARROW, 0, mitTime, iconPrice);
       //--- Use arrow code 251 as the mitigation marker glyph
       ObjectSetInteger(0, iconName, OBJPROP_ARROWCODE, 251);
       //--- Apply blue color for mitigation icons
       ObjectSetInteger(0, iconName, OBJPROP_COLOR,     clrBlue);
       //--- Anchor above the price for bullish zones, below for bearish
       ObjectSetInteger(0, iconName, OBJPROP_ANCHOR,    isUp ? ANCHOR_TOP : ANCHOR_BOTTOM);
       //--- Refresh the chart to display the icon
       ChartRedraw(0);
      }

The "CreateRec" function draws a new zone rectangle on the chart. It first syncs the font size, then creates the rectangle object spanning the provided time and price boundaries. It checks the object name against the fair value gap prefix using [StringFind](/en/docs/strings/stringfind) to determine the zone type — fair value gap zones are rendered as unfilled outlines with a thicker border, while order block zones are solid filled with a thinner border. It then computes the midpoint of the rectangle in both time and price to place the descriptive label, finishing with a chart redraw. The companion "UpdateRec" function handles modifications to existing rectangles, updating all four boundary anchors, applying a new color to reflect state changes such as mitigation, repositioning the label to the updated midpoint, and redrawing the chart.

For structural market annotations, we define "drawSwingPoint" to place an arrow and a companion "BoS" text label at a detected swing level. The function accepts a target chart identifier, allowing it to draw on either the main chart or the higher timeframe chart. The arrow anchor and text anchor are set based on the direction parameter — above the bar for upward swings and below for downward ones. A chart redraw is triggered only when drawing on the main chart.

The "drawBreakLevel" function complements the swing point by drawing an arrowed line from the swing time to the bar where the break of structure was confirmed. Both the time and price anchors are set explicitly for both endpoints, and a "Break" text label is placed at the end of the line with directional anchoring to keep it readable regardless of the break direction.

For trade level visualization, we define two lightweight drawing functions. "DrawDottedLine" creates a dotted horizontal trend line between two time points at a fixed price, styled with [STYLE_DOT](/en/docs/constants/indicatorconstants/drawstyles#enum_line_style) to visually distinguish entry, stop loss, and take-profit levels from structural lines. "DrawTextEx" places a bold Arial text label at a specified time and price, anchoring it below the price for swing highs and above for swing lows, with centered horizontal alignment for clean chart presentation.

Finally, the "DrawMitIcon" function places a small arrow marker on a zone at the moment mitigation occurs. It positions the icon at the near edge of the zone — the low for bullish zones and the high for bearish ones — using arrow code 251 as the mitigation glyph, colored blue, and anchored appropriately to the zone direction before redrawing the chart. MQL5 provides these icons, and you can replace any with the one that suits you. See the table below.

![MQL5 WINGDINGS](https://c.mql5.com/2/205/C_MQL5_WINGDINGS.png)

With that done, the next thing we will need is to define helper functions for the swing and consolidation detection.

_Swing Detection and Consolidation Analysis Functions_

Before any order block or fair value gap can be identified, we need reliable tools to detect swing points in price and validate whether a range of bars qualifies as a consolidation zone. These functions form the analytical backbone of the zone detection logic.
    
    
    //+------------------------------------------------------------------+
    //| Check if bar at index is a valid swing high                      |
    //+------------------------------------------------------------------+
    bool isSwingHigh(int curr_bar, ENUM_TIMEFRAMES tf, int length)
      {
       //--- Reject if not enough bars exist on either side
       if (curr_bar < length || curr_bar + length >= iBars(_Symbol, tf)) return false;
       //--- Verify the candidate bar is strictly the highest in the window
       for (int j = 1; j <= length; j++)
         {
          //--- Fail if a newer bar within length is higher or equal
          if (iHigh(_Symbol, tf, curr_bar) <= iHigh(_Symbol, tf, curr_bar - j)) return false;
          //--- Fail if an older bar within length is higher
          if (iHigh(_Symbol, tf, curr_bar) <  iHigh(_Symbol, tf, curr_bar + j)) return false;
         }
       //--- Confirm this bar qualifies as a swing high
       return true;
      }
    
    //+------------------------------------------------------------------+
    //| Check if bar at index is a valid swing low                       |
    //+------------------------------------------------------------------+
    bool isSwingLow(int curr_bar, ENUM_TIMEFRAMES tf, int length)
      {
       //--- Reject if not enough bars exist on either side
       if (curr_bar < length || curr_bar + length >= iBars(_Symbol, tf)) return false;
       //--- Verify the candidate bar is strictly the lowest in the window
       for (int j = 1; j <= length; j++)
         {
          //--- Fail if a newer bar within length is lower or equal
          if (iLow(_Symbol, tf, curr_bar) >= iLow(_Symbol, tf, curr_bar - j)) return false;
          //--- Fail if an older bar within length is lower
          if (iLow(_Symbol, tf, curr_bar) >  iLow(_Symbol, tf, curr_bar + j)) return false;
         }
       //--- Confirm this bar qualifies as a swing low
       return true;
      }
    
    //+------------------------------------------------------------------+
    //| Check consolidation by equal highs and lows across range         |
    //+------------------------------------------------------------------+
    bool IsConsolidationEqualHighsAndLows(int rangeCandles, double maxDeviation, int startingIndex, ENUM_TIMEFRAMES tf)
      {
       //--- Compare adjacent bar highs and lows across the full consolidation range
       for (int i = startingIndex; i < startingIndex + rangeCandles - 1; i++)
         {
          //--- Reject if adjacent highs differ by more than the allowed deviation
          if (MathAbs(iHigh(_Symbol, tf, i) - iHigh(_Symbol, tf, i + 1)) > maxDeviation * _Point) return false;
          //--- Reject if adjacent lows differ by more than the allowed deviation
          if (MathAbs(iLow (_Symbol, tf, i) - iLow (_Symbol, tf, i + 1)) > maxDeviation * _Point) return false;
         }
       //--- Confirm range qualifies as a consolidation zone
       return true;
      }
    
    //+------------------------------------------------------------------+
    //| Get highest high price and bar index within range                |
    //+------------------------------------------------------------------+
    void GetHighestHigh(int rangeCandles, int startingIndex, PriceIndex &highestHighRef, ENUM_TIMEFRAMES tf)
      {
       //--- Seed with the first bar in the range
       highestHighRef.price = iHigh(_Symbol, tf, startingIndex);
       highestHighRef.index = startingIndex;
       //--- Scan remaining bars and update if a higher high is found
       for (int i = startingIndex + 1; i < startingIndex + rangeCandles; i++)
         {
          if (iHigh(_Symbol, tf, i) > highestHighRef.price)
            {
             //--- Update the reference with the new highest high
             highestHighRef.price = iHigh(_Symbol, tf, i);
             highestHighRef.index = i;
            }
         }
      }
    
    //+------------------------------------------------------------------+
    //| Get lowest low price and bar index within range                  |
    //+------------------------------------------------------------------+
    void GetLowestLow(int rangeCandles, int startingIndex, PriceIndex &lowestLowRef, ENUM_TIMEFRAMES tf)
      {
       //--- Seed with the first bar in the range
       lowestLowRef.price = iLow(_Symbol, tf, startingIndex);
       lowestLowRef.index = startingIndex;
       //--- Scan remaining bars and update if a lower low is found
       for (int i = startingIndex + 1; i < startingIndex + rangeCandles; i++)
         {
          if (iLow(_Symbol, tf, i) < lowestLowRef.price)
            {
             //--- Update the reference with the new lowest low
             lowestLowRef.price = iLow(_Symbol, tf, i);
             lowestLowRef.index = i;
            }
         }
      }

The "isSwingHigh" function determines whether a given bar is a valid swing high by checking that it is strictly the highest bar within a surrounding window defined by the length parameter. It first rejects the candidate if there are not enough bars on either side using [iBars](/en/docs/series/ibars), then loops through each offset from one to the length value, comparing the candidate bar's high against both newer and older neighbors retrieved via "iHigh". If any neighbor is higher or equal on the newer side, or strictly higher on the older side, the function returns false immediately. Only when all comparisons pass does it confirm the swing high. The "isSwingLow" function mirrors this logic exactly for swing lows, using [iLow](/en/docs/series/ilow) and reversing the comparison directions to find the strictly lowest bar in the window.

To validate whether a price range qualifies as a consolidation, we define the "IsConsolidationEqualHighsAndLows" function. It iterates through adjacent bar pairs across the specified range and checks that neither the highs nor the lows between consecutive bars differ by more than the configured maximum deviation, scaled by the point size using the [MathAbs](/en/docs/math/mathabs) function. If any adjacent pair exceeds this tolerance in either direction, the range is rejected as non-consolidating. This equal highs and lows approach effectively identifies tight, range-bound price action where institutional accumulation or distribution is likely occurring.

To support the zone boundary calculations, we define "GetHighestHigh" and "GetLowestLow". Both functions accept a "PriceIndex" structure reference and scan a specified range of bars to find the extreme price and its bar index. "GetHighestHigh" seeds the reference with the first bar in the range and updates it whenever a higher high is found further into the range. "GetLowestLow" does the same in reverse, tracking the lowest low and its position. These extremes are later used to define the consolidation boundaries against which breakout direction and impulse strength are measured. We can now detect and create order block zones with complete visualizations.

_Detecting and Creating Order Block Zones_

This is the core detection function that ties consolidation analysis, breakout confirmation, impulse validation, and fair value gap scanning together to identify and register a new order block zone on the chart.
    
    
    //+------------------------------------------------------------------+
    //| Detect and create OB zone with FVG in impulsive area             |
    //+------------------------------------------------------------------+
    void DetectAndCreateZone(int i, ENUM_TIMEFRAMES tf)
      {
       //--- Skip detection if no trend has been established
       if (current_trend == 0) return;
       //--- Set the consolidation range to start one bar after the signal bar
       int consol_start_index = i + 1;
       //--- Ensure enough bars exist for the full consolidation range
       if (consol_start_index + OBRangeCandles - 1 >= iBars(_Symbol, tf)) return;
       //--- Validate the consolidation range with equal highs and lows check
       if (IsConsolidationEqualHighsAndLows(OBRangeCandles, OBMaxDeviation, consol_start_index, tf))
         {
          //--- Find the highest high and lowest low within the consolidation
          PriceIndex hh, ll;
          GetHighestHigh(OBRangeCandles, consol_start_index, hh, tf);
          GetLowestLow  (OBRangeCandles, consol_start_index, ll, tf);
          double breakout_close = iClose(_Symbol, tf, i);
          //--- Determine if price broke out bullishly above the consolidation high
          bool   breakout_up    = (current_trend ==  1) && breakout_close > hh.price;
          //--- Determine if price broke out bearishly below the consolidation low
          bool   breakout_down  = (current_trend == -1) && breakout_close < ll.price;
          //--- Proceed only if a valid directional breakout occurred
          if (breakout_up || breakout_down)
            {
             //--- Calculate the consolidation range height
             double range_val  = hh.price - ll.price;
             //--- Apply the impulse multiplier threshold to the range
             double threshold  = range_val * OBImpulseThreshold;
             bool   impulsive  = false;
             int    impulse_start_bar = -1;
             //--- Search the next few bars for an impulsive extension past the threshold
             for (int k = 1; k <= OBWaitBars; k++)
               {
                int    impulse_shift = i - k;
                if (impulse_shift < 0) break;
                double c = iClose(_Symbol, tf, impulse_shift);
                //--- Confirm bullish impulse if close exceeds high plus threshold
                if (breakout_up   && c >= hh.price + threshold)
                  {
                   impulsive        = true;
                   impulse_start_bar = impulse_shift;
                   break;
                  }
                //--- Confirm bearish impulse if close falls below low minus threshold
                else if (breakout_down && c <= ll.price - threshold)
                  {
                   impulsive        = true;
                   impulse_start_bar = impulse_shift;
                   break;
                  }
               }
             //--- Continue only if an impulsive move was confirmed
             if (impulsive)
               {
                //--- Set FVG direction flags based on breakout direction
                bool     FVG_UP    = breakout_up;
                bool     FVG_DOWN  = breakout_down;
                bool     fvg_found = false;
                datetime fvg_time  = 0;
                double   fvg_price1 = 0, fvg_price2 = 0;
                //--- Scan from breakout bar to impulse bar looking for a valid FVG gap
                for (int f = i; f >= impulse_start_bar; f--)
                  {
                   double low0  = iLow (_Symbol, tf, f);
                   double high2 = iHigh(_Symbol, tf, f + 2);
                   //--- Compute the gap between bar[f] low and bar[f+2] high (bullish gap)
                   double gap_L0_H2 = NormalizeDouble((low0 - high2) / _Point, _Digits);
                   double high0 = iHigh(_Symbol, tf, f);
                   double low2  = iLow (_Symbol, tf, f + 2);
                   //--- Compute the gap between bar[f+2] low and bar[f] high (bearish gap)
                   double gap_H0_L2 = NormalizeDouble((low2 - high0) / _Point, _Digits);
                   //--- Validate and record a bullish FVG if gap exceeds minimum points
                   if (FVG_UP && low0 > high2 && gap_L0_H2 > minPts)
                     {
                      fvg_time   = iTime(_Symbol, tf, f + 1);
                      fvg_price1 = high2;
                      fvg_price2 = low0;
                      fvg_found  = true;
                      break;
                     }
                   //--- Validate and record a bearish FVG if gap exceeds minimum points
                   else if (FVG_DOWN && low2 > high0 && gap_H0_L2 > minPts)
                     {
                      fvg_time   = iTime(_Symbol, tf, f + 1);
                      fvg_price1 = high0;
                      fvg_price2 = low2;
                      fvg_found  = true;
                      break;
                     }
                  }
                //--- Proceed only if an FVG was successfully found
                if (fvg_found)
                  {
                   //--- Normalize FVG boundaries to low/high order
                   double newLow  = MathMin(fvg_price1, fvg_price2);
                   double newHigh = MathMax(fvg_price1, fvg_price2);
                   bool   fvg_overlaps = false;
                   //--- Check new FVG against all existing FVGs for overlap
                   if (ignoreOverlaps)
                     {
                      for (int ex = 0; ex < ArraySize(fvg_names); ex++)
                        {
                         double exLow  = ObjectGetDouble(0, fvg_names[ex], OBJPROP_PRICE, 0);
                         double exHigh = ObjectGetDouble(0, fvg_names[ex], OBJPROP_PRICE, 1);
                         //--- Sort existing zone bounds
                         exLow  = MathMin(exLow, exHigh);
                         exHigh = MathMax(exLow, exHigh);
                         //--- Check if the new FVG overlaps with the existing one
                         if (MathMax(newLow, exLow) < MathMin(newHigh, exHigh))
                           {
                            fvg_overlaps = true;
                            if (prt) Print("Historical: Skipping overlapping FVG at ", TimeToString(fvg_time));
                            break;
                           }
                        }
                     }
                   //--- Abort if this FVG overlaps an existing one
                   if (fvg_overlaps) return;
                   //--- Use the first consolidation candle as the OB candle reference
                   int      last_consol_index = consol_start_index;
                   datetime obTime  = iTime (_Symbol, tf, last_consol_index);
                   double   obLow   = iLow  (_Symbol, tf, last_consol_index);
                   double   obHigh  = iHigh (_Symbol, tf, last_consol_index);
                   bool     is_opposing = false;
                   //--- Check that OB candle is bearish (opposing) for a bullish breakout
                   if (breakout_up   && iOpen(_Symbol, tf, last_consol_index) > iClose(_Symbol, tf, last_consol_index))
                      is_opposing = true;
                   //--- Check that OB candle is bullish (opposing) for a bearish breakout
                   if (breakout_down && iOpen(_Symbol, tf, last_consol_index) < iClose(_Symbol, tf, last_consol_index))
                      is_opposing = true;
                   //--- Reject if the consolidation candle is not opposing
                   if (!is_opposing)
                     {
                      if (prt) Print("Skipping OB creation: Last consolidation candle not opposing at ", TimeToString(obTime));
                      return;
                     }
                   //--- Normalize OB boundaries to low/high order
                   double obNewLow  = MathMin(obLow, obHigh);
                   double obNewHigh = MathMax(obLow, obHigh);
                   bool   ob_overlaps = false;
                   //--- Check new OB against all existing OBs for overlap
                   if (ignoreOverlaps)
                     {
                      for (int ex = 0; ex < ArraySize(obs); ex++)
                        {
                         double exLow  = ObjectGetDouble(0, obs[ex].name, OBJPROP_PRICE, 0);
                         double exHigh = ObjectGetDouble(0, obs[ex].name, OBJPROP_PRICE, 1);
                         //--- Sort existing OB bounds
                         exLow  = MathMin(exLow, exHigh);
                         exHigh = MathMax(exLow, exHigh);
                         //--- Check if the new OB overlaps with the existing one
                         if (MathMax(obNewLow, exLow) < MathMin(obNewHigh, exHigh))
                           {
                            ob_overlaps = true;
                            if (prt) Print("Historical: Skipping overlapping OB at ", TimeToString(obTime));
                            break;
                           }
                        }
                     }
                   //--- Abort if this OB overlaps an existing one
                   if (ob_overlaps) return;
                   //--- Build the FVG object name from its timestamp
                   string   fvgNAME    = FVG_Prefix + "(" + TimeToString(fvg_time) + ")";
                   color    fvgClr     = FVG_UP ? CLR_UP : CLR_DOWN;
                   //--- Calculate the FVG rectangle end time based on extension bars
                   datetime fvgEndTime = fvg_time + PeriodSeconds(tf) * FVG_Rec_Ext_Bars;
                   //--- Draw the FVG rectangle on the chart
                   CreateRec(fvgNAME, fvg_time, fvg_price1, fvgEndTime, fvg_price2, fvgClr);
                   //--- Register the FVG name in the tracking array
                   int fvg_size = ArraySize(fvg_names);
                   ArrayResize(fvg_names, fvg_size + 1);
                   fvg_names[fvg_size] = fvgNAME;
                   if (prt) Print("Historical FVG created: ", fvgNAME);
                   //--- Build the OB object name from its timestamp
                   string   obNAME   = OB_Prefix + "(" + TimeToString(obTime) + ")";
                   color    obClr    = FVG_UP ? CLR_UP : CLR_DOWN;
                   //--- Calculate the OB rectangle end time based on extension bars
                   datetime obEndTime = obTime + PeriodSeconds(tf) * OB_Rec_Ext_Bars;
                   //--- Draw the OB rectangle on the chart
                   CreateRec(obNAME, obTime, obLow, obEndTime, obHigh, obClr);
                   //--- Evict the oldest OB if the storage array is at capacity
                   int ob_size = ArraySize(obs);
                   if (ob_size >= maxZones)
                     {
                      if (prt) Print("Historical: Max OBs reached, removing oldest.");
                      ArrayRemove(obs, 0, 1);
                      PrintOBs();
                     }
                   //--- Append the new OB entry to the storage array
                   ArrayResize(obs, ob_size + 1);
                   obs[ob_size].name        = obNAME;
                   obs[ob_size].startTime   = obTime;
                   obs[ob_size].origEndTime = obEndTime;
                   obs[ob_size].mitTime     = 0;
                   obs[ob_size].fvgTime     = fvg_time;
                   obs[ob_size].signal      = false;
                   obs[ob_size].mit         = false;
                   obs[ob_size].origUp      = FVG_UP;
                   obs[ob_size].tradeCount  = 0;
                   obs[ob_size].state       = Normal;
                   obs[ob_size].newSignal   = false;
                   obs[ob_size].valid       = false;
                   if (prt) Print("Historical OB created: ", obNAME, " origUp=", FVG_UP, " endTime=", TimeToString(obEndTime));
                   PrintOBs();
                  }
               }
            }
         }
      }

The "DetectAndCreateZone" function begins by skipping execution if no trend has been established. It then positions the consolidation range one bar ahead of the signal bar and validates it using our previously defined consolidation check. If the range qualifies, we extract its highest high and lowest low, then check whether the signal bar's close broke above the consolidation high in an uptrend or below the low in a downtrend. When a valid directional breakout is confirmed, we compute an impulse threshold by multiplying the consolidation range height by the configured multiplier. We then scan the next few bars looking for a close that extends past this threshold, confirming that the breakout was genuinely impulsive rather than a weak push. If no such bar is found within the wait window, the zone is discarded.

With an impulsive move confirmed, we scan the bars between the breakout and impulse bars looking for a fair value gap. For a bullish gap, we check that the low of the current bar is above the high of the bar two positions back, and the gap in points exceeds the minimum threshold. For a bearish gap, the logic is reversed. The middle bar's time and the two boundary prices are recorded once a valid gap is found using [NormalizeDouble](/en/docs/convert/normalizedouble) for precision. If a fair value gap is found, we run overlap checks against all existing fair value gaps and order blocks using [MathMin](/en/docs/math/mathmin) and [MathMax](/en/docs/math/mathmax) to normalize boundaries before comparing. We also verify that the first consolidation candle is an opposing candle — bearish for a bullish breakout and bullish for a bearish one — as this is the actual order block candle. If either overlap or opposing checks fail, detection is aborted.

Finally, both the fair value gap and order block rectangles are drawn on the chart using "CreateRec", with end times computed from their respective extension bar settings and [PeriodSeconds](/en/docs/common/periodseconds). The new order block is appended to the tracking array with all its metadata initialized, and if the array has reached the maximum zone limit, the oldest entry is evicted first using [ArrayRemove](/en/docs/array/arrayremove) before resizing. Next, we handle validations and trend analysis.

_Historical State Processing, BOS and Inducement Validation, and Trend Analysis_

With zones created, we now need to replay historical price action to determine each zone's mitigation and signal state, validate them through break of structure and inducement detection, and maintain an up-to-date trend direction from the higher timeframe.
    
    
    //+------------------------------------------------------------------+
    //| Process historical mitigation and signal state for one OB        |
    //+------------------------------------------------------------------+
    void ProcessHistoricalState(int idx, ENUM_TIMEFRAMES tf)
      {
       //--- Retrieve the OB's stored name and time references
       string   obNAME    = obs[idx].name;
       datetime timeSTART = obs[idx].startTime;
       datetime endTime   = obs[idx].origEndTime;
       //--- Retrieve and normalize OB price boundaries from the chart object
       double   obLow  = MathMin(ObjectGetDouble(0, obNAME, OBJPROP_PRICE, 0), ObjectGetDouble(0, obNAME, OBJPROP_PRICE, 1));
       double   obHigh = MathMax(ObjectGetDouble(0, obNAME, OBJPROP_PRICE, 0), ObjectGetDouble(0, obNAME, OBJPROP_PRICE, 1));
       //--- Convert OB start time to a bar index on the trading timeframe
       int      obBar  = iBarShift(_Symbol, tf, timeSTART);
       if (obBar < 0) return;
       //--- Initialize mitigation and signal state flags
       bool     isMit  = false, isSig = false;
       datetime mitTime = 0;
       //--- Iterate bars from just before the OB candle toward the present
       for (int k = obBar - 1; k >= 0; k--)
         {
          double barLow   = iLow  (_Symbol, tf, k);
          double barHigh  = iHigh (_Symbol, tf, k);
          double barClose = iClose(_Symbol, tf, k);
          //--- Check for mitigation: price broke past the far edge of the OB
          if (!isMit)
            {
             bool breakFar = (obs[idx].origUp && barLow < obLow) || (!obs[idx].origUp && barHigh > obHigh);
             if (breakFar)
               {
                isMit   = true;
                mitTime = iTime(_Symbol, tf, k);
                if (prt) Print("Historical Mitigated: ", obNAME, " at time=", TimeToString(mitTime));
               }
            }
          //--- Check for trade signal: previous close inside zone, current close outside
          if ((!isMit || tradeMitigated == TradeMitigated) && !isSig && k >= 1)
            {
             double close2   = iClose(_Symbol, tf, k + 1);
             double close1   = barClose;
             //--- Previous bar closed inside the OB
             bool   inside2  = (close2 >= obLow && close2 <= obHigh);
             //--- Current bar closed outside the OB in the trend direction
             bool   outside1 = obs[idx].origUp ? (close1 > obHigh) : (close1 < obLow);
             if (inside2 && outside1) isSig = true;
            }
         }
       //--- Commit the computed mitigation and signal flags to the OB record
       obs[idx].mit      = isMit;
       obs[idx].signal   = isSig;
       obs[idx].mitTime  = mitTime;
       obs[idx].state    = isMit ? Mitigated : Normal;
       obs[idx].newSignal = false;
       //--- Retrieve the appropriate color for the current OB state
       color currentClr = GetZoneColor(obs[idx].origUp, obs[idx].state);
       //--- Redraw the OB rectangle with the updated color
       UpdateRec(obs[idx].name, obs[idx].startTime, obLow, obs[idx].origEndTime, obHigh, currentClr);
       //--- Draw the mitigation icon if the zone was mitigated
       if (mitTime > 0) DrawMitIcon(obs[idx].name, mitTime, obHigh, obLow, obs[idx].origUp);
      }
    
    //+------------------------------------------------------------------+
    //| Check for BOS and inducement, draw objects if confirmed          |
    //+------------------------------------------------------------------+
    bool HasBOSAndInducement(int idx, ENUM_TIMEFRAMES stf)
      {
       //--- Extract OB time references and direction
       datetime obTime  = obs[idx].startTime;
       datetime endTime = obs[idx].origEndTime;
       datetime fvgTime = obs[idx].fvgTime;
       bool     isBearish = !obs[idx].origUp;
       //--- Convert OB and FVG times to bar indices
       int ob_bar  = iBarShift(_Symbol, stf, obTime);
       int fvg_bar = iBarShift(_Symbol, stf, fvgTime);
       if (ob_bar < 0 || fvg_bar < 0) return false;
       //--- Retrieve OB price boundaries from bar data
       double   obLow    = MathMin(iLow(_Symbol, stf, ob_bar), iHigh(_Symbol, stf, ob_bar));
       double   obHigh   = MathMax(iLow(_Symbol, stf, ob_bar), iHigh(_Symbol, stf, ob_bar));
       //--- Initialize swing search result variables
       double   swing_ext  = 0.0;
       datetime swing_time = 0;
       int      swing_bar  = -1;
       //--- Search bars after the FVG for the first valid swing that lies outside the OB
       for (int k = fvg_bar - 1; k >= 0; k--)
         {
          datetime bar_time = iTime(_Symbol, stf, k);
          //--- Stop scanning once we pass the OB expiry time
          if (bar_time > endTime) break;
          //--- Check for swing low in bearish context, swing high in bullish
          bool is_swing = isBearish ? isSwingLow(k, stf, swing_strength) : isSwingHigh(k, stf, swing_strength);
          if (is_swing)
            {
             double temp_swing_ext = isBearish ? iLow(_Symbol, stf, k) : iHigh(_Symbol, stf, k);
             //--- Skip swings that fall within the OB price range
             if (temp_swing_ext >= obLow && temp_swing_ext <= obHigh) continue;
             //--- Record this as the reference swing for BOS detection
             swing_ext  = temp_swing_ext;
             swing_time = bar_time;
             swing_bar  = k;
             break;
            }
         }
       //--- Abort if no qualifying swing was found after the FVG
       if (swing_ext == 0.0)
         {
          if (prt) Print("No swing found after FVG for: ", obs[idx].name);
          return false;
         }
       //--- Initialize BOS break search variables
       datetime break_time = 0;
       int      break_bar  = -1;
       //--- Search bars after the swing for a bar that closes past the swing level
       for (int k = swing_bar - 1; k >= 0; k--)
         {
          datetime bar_time  = iTime (_Symbol, stf, k);
          //--- Stop scanning once we pass the OB expiry time
          if (bar_time > endTime) break;
          double   bar_low   = iLow  (_Symbol, stf, k);
          double   bar_high  = iHigh (_Symbol, stf, k);
          double   bar_close = iClose(_Symbol, stf, k);
          //--- Confirm a bearish BOS if both low and close are below the swing low
          bool     broken = isBearish
                            ? (bar_low < swing_ext && bar_close < swing_ext)
                            : (bar_high > swing_ext && bar_close > swing_ext);
          if (broken)
            {
             break_time = bar_time;
             break_bar  = k;
             break;
            }
         }
       //--- Abort if no break of structure was confirmed
       if (break_bar == -1)
         {
          if (prt) Print("No BOS break found for OB: ", obs[idx].name);
          return false;
         }
       //--- Build and draw the BOS swing arrow and horizontal break level
       string bos_name = BOS_Prefix + TimeToString(obTime);
       color  bos_clr  = isBearish ? def_clr_down : def_clr_up;
       int    bos_dir  = isBearish ? 1 : -1;
       drawSwingPoint(TimeToString(swing_time), swing_time, swing_ext, object_code, bos_clr, bos_dir, 0);
       drawBreakLevel(bos_name, swing_time, swing_ext, break_time, swing_ext, bos_clr, bos_dir);
       if (prt) Print("BOS detected and drawn for OB: ", obs[idx].name);
       //--- Calculate the reduced strength for inducement swing detection
       int    ind_strength = MathMax(swing_strength / 2, 1);
       bool   found_ind    = false;
       datetime ind_time   = 0;
       double   ind_ext    = 0.0;
       //--- Search between the swing bar and the break bar for an inducement swing
       for (int m = swing_bar - 1; m >= break_bar; m--)
         {
          //--- Check for inducement swing in the opposing direction of the BOS
          bool is_ind_swing = isBearish ? isSwingHigh(m, stf, ind_strength) : isSwingLow(m, stf, ind_strength);
          if (is_ind_swing)
            {
             double temp_ind_ext = isBearish ? iHigh(_Symbol, stf, m) : iLow(_Symbol, stf, m);
             //--- Skip inducements that fall within the OB price range
             if (temp_ind_ext >= obLow && temp_ind_ext <= obHigh) continue;
             //--- Compute the depth of the inducement from the swing level
             double depth = MathAbs(temp_ind_ext - swing_ext) / _Point;
             //--- Accept only inducements deeper than the minimum threshold
             if (depth > minIndDepthPts)
               {
                ind_time  = iTime(_Symbol, stf, m);
                ind_ext   = temp_ind_ext;
                found_ind = true;
               }
            }
         }
       //--- Abort if no valid inducement was found between swing and break
       if (!found_ind)
         {
          if (prt) Print("No significant/non-overlapping inducement found for OB: ", obs[idx].name);
          return false;
         }
       //--- Calculate the end time for the inducement trendline display
       datetime ind_end  = ind_time + PeriodSeconds(stf) * inducement_ext_bars;
       //--- Build the inducement trendline and label object names
       string   ind_name = IND_Prefix + TimeToString(obTime);
       //--- Draw a horizontal dashed trendline at the inducement level
       ObjectCreate(0, ind_name, OBJ_TREND, 0, ind_time, ind_ext, ind_end, ind_ext);
       ObjectSetInteger(0, ind_name, OBJPROP_COLOR,     bos_clr);
       ObjectSetInteger(0, ind_name, OBJPROP_STYLE,     STYLE_DASH);
       ObjectSetInteger(0, ind_name, OBJPROP_WIDTH,     1);
       ObjectSetInteger(0, ind_name, OBJPROP_RAY_RIGHT, false);
       //--- Create the "Inducement" text label above or below the trendline
       string lbl = ind_name + "_label";
       ObjectCreate(0, lbl, OBJ_TEXT, 0, ind_time, ind_ext);
       ObjectSetString (0, lbl, OBJPROP_TEXT,     "Inducement");
       ObjectSetInteger(0, lbl, OBJPROP_COLOR,    bos_clr);
       ObjectSetInteger(0, lbl, OBJPROP_FONTSIZE, current_font_size);
       //--- Anchor text below the line for bearish inducements, above for bullish
       ObjectSetInteger(0, lbl, OBJPROP_ANCHOR,   isBearish ? ANCHOR_LEFT_LOWER : ANCHOR_LEFT_UPPER);
       if (prt) Print("Inducement detected and drawn for OB: ", obs[idx].name);
       return true;
      }
    
    //+------------------------------------------------------------------+
    //| Update trend direction from higher timeframe swing analysis      |
    //+------------------------------------------------------------------+
    void UpdateTrend()
      {
       //--- Retrieve the total number of bars on the higher timeframe
       int bars = iBars(_Symbol, higher_tf);
       double curr_swing_high = -1.0, curr_swing_low = -1.0;
       int    new_trend = 0;
       //--- Clear all objects on the H4 chart when it is open
       if (chart_id > 0) ObjectsDeleteAll(chart_id, -1, -1);
       //--- Iterate from oldest to newest bar looking for swing highs and lows
       for (int i = bars - swing_strength - 1; i >= swing_strength; i--)
         {
          //--- Detect swing high: current bar must be strictly highest in window
          bool isHigh = true;
          for (int j = 1; j <= swing_strength; j++)
            {
             if (iHigh(_Symbol, higher_tf, i) <= iHigh(_Symbol, higher_tf, i + j)) isHigh = false;
             if (iHigh(_Symbol, higher_tf, i) <= iHigh(_Symbol, higher_tf, i - j)) isHigh = false;
            }
          if (isHigh)
            {
             double new_high = iHigh(_Symbol, higher_tf, i);
             //--- Label as HH (higher high) or LH (lower high) relative to last swing high
             string label = (curr_swing_high < 0) ? "H" : (new_high > curr_swing_high ? "HH" : "LH");
             color  clr   = (label == "HH") ? clrBlue : clrRed;
             //--- Draw the swing label on the H4 chart if it is open
             if (chart_id > 0)
                drawSwingPoint(TimeToString(iTime(_Symbol, higher_tf, i)),
                               iTime(_Symbol, higher_tf, i), new_high, 174, clr, -1, chart_id);
             //--- Update trend to bullish on higher high confirmation
             if (label == "HH")   new_trend =  1;
             //--- Update trend to bearish on lower high confirmation
             else if (label == "LH") new_trend = -1;
             curr_swing_high = new_high;
            }
          //--- Detect swing low: current bar must be strictly lowest in window
          bool isLow = true;
          for (int j = 1; j <= swing_strength; j++)
            {
             if (iLow(_Symbol, higher_tf, i) >= iLow(_Symbol, higher_tf, i + j)) isLow = false;
             if (iLow(_Symbol, higher_tf, i) >= iLow(_Symbol, higher_tf, i - j)) isLow = false;
            }
          if (isLow)
            {
             double new_low = iLow(_Symbol, higher_tf, i);
             //--- Label as LL (lower low) or HL (higher low) relative to last swing low
             string label = (curr_swing_low < 0) ? "L" : (new_low < curr_swing_low ? "LL" : "HL");
             color  clr   = (label == "HL") ? clrBlue : clrRed;
             //--- Draw the swing label on the H4 chart if it is open
             if (chart_id > 0)
                drawSwingPoint(TimeToString(iTime(_Symbol, higher_tf, i)),
                               iTime(_Symbol, higher_tf, i), new_low, 174, clr, 1, chart_id);
             //--- Update trend to bullish on higher low confirmation
             if (label == "HL")   new_trend =  1;
             //--- Update trend to bearish on lower low confirmation
             else if (label == "LL") new_trend = -1;
             curr_swing_low = new_low;
            }
         }
       //--- Commit the determined trend direction to the global variable
       current_trend = new_trend;
       //--- Render the updated trend label on the main chart
       DrawTrendLabel();
       //--- Refresh the higher timeframe chart after redrawing swings
       if (chart_id > 0) ChartRedraw(chart_id);
      }
    
    

The "ProcessHistoricalState" function scans bars from just before the order block candle to the present. It checks two conditions per bar. First, it checks whether the price broke past the far edge of the zone — below the low for bullish zones or above the high for bearish ones — marking the zone as mitigated and recording the time if so. Second, subject to the mitigation trade setting, it checks whether the previous bar closed inside the zone while the current bar closed outside in the expected direction, flagging a historical signal. Once the scan completes, the mitigation and signal flags are committed to the zone record, the rectangle is redrawn with the appropriate color via "GetZoneColor", and a mitigation icon is placed if the zone was mitigated.

The "HasBOSAndInducement" function is the validation gate that determines whether a zone is tradable. It begins by converting the order block and fair value gap times to bar indices using [iBarShift](/en/docs/series/ibarshift), then scans forward from the fair value gap bar looking for the first qualifying swing point outside the order block price range — a swing high for bullish zones and a swing low for bearish ones. This swing becomes the reference level for the break of structure detection. A second scan then searches for a bar that closes convincingly past this swing level, confirming the break of structure. If either the swing or the break is not found within the zone's expiry window, the function returns false, and the zone remains unvalidated.

Once a break of structure is confirmed, the swing arrow and break level line are drawn using our previously defined drawing functions. The function then narrows its search to the window between the reference swing bar and the break bar, looking for an inducement swing in the opposing direction — a swing high between a bearish swing and its break, or a swing low for the bullish case. A reduced swing strength computed with [MathMax](/en/docs/math/mathmax) is used here to catch smaller liquidity sweeps. The inducement must also fall outside the order block range and exceed the minimum depth threshold in points. If a valid inducement is found, a dashed horizontal trend line and an "Inducement" text label are drawn at that level before the function returns true.

The "UpdateTrend" function drives the higher timeframe structural analysis. It scans all bars on the higher timeframe from oldest to newest, detecting swing highs and lows using the same strict window comparison logic. Each swing high is labeled as a higher high or lower high relative to the previous swing high, and each swing low as a higher low or lower low. A higher high or higher low updates the trend to bullish, while a lower high or lower low sets it to bearish. All swing labels are drawn on the separately opened higher timeframe chart when available. After the full scan, the resolved trend direction is committed to the global variable, and the trend label on the main chart is refreshed. Before we proceed, let us initialize the program and see the milestone we have achieved. To do that, we used the following logic.

_Initialization Event Handler_

The "OnInit" event handler sets up the entire program state on launch — configuring the trade object, clearing stale chart objects, rebuilding the historical zone map, and validating existing zones before the first tick arrives.
    
    
    //+------------------------------------------------------------------+
    //| Expert initialization function                                   |
    //+------------------------------------------------------------------+
    int OnInit()
      {
    //---
       //--- Assign the magic number to the trade object for order identification
       obj_Trade.SetExpertMagicNumber(magic_number);
       //--- Open a separate chart on the higher timeframe for swing visualization
       chart_id = ChartOpen(_Symbol, higher_tf);
       if (chart_id <= 0)
          Print("Failed to open higher TF chart (possibly in tester). Proceeding without visuals.");
       //--- Remove all previously drawn zone objects from the main chart
       ObjectsDeleteAll(0, FVG_Prefix);
       ObjectsDeleteAll(0, OB_Prefix);
       ObjectsDeleteAll(0, BOS_Prefix);
       ObjectsDeleteAll(0, IND_Prefix);
       //--- Remove the trend label left by any previous EA run
       ObjectDelete(0, "EA_TrendLabel");
       //--- Reset all tracking arrays to empty
       ArrayResize(obs,       0);
       ArrayResize(fvg_names, 0);
       ArrayResize(trades,    0);
       if (prt) Print("Initializing: Deleted all existing objects and reset arrays.");
       //--- Analyze the higher timeframe to establish the initial trend direction
       UpdateTrend();
       //--- Resolve the actual trading timeframe
       ENUM_TIMEFRAMES use_tf    = (trade_tf == PERIOD_CURRENT) ? _Period : trade_tf;
       int             visibleBars = (int)ChartGetInteger(0, CHART_VISIBLE_BARS);
       //--- Scan all visible bars historically to build the initial OB map
       for (int i = visibleBars - 3; i >= 0; i--)
          DetectAndCreateZone(i, use_tf);
       //--- Replay historical price action to set mitigation and signal states
       for (int j = 0; j < ArraySize(obs); j++)
          ProcessHistoricalState(j, use_tf);
       //--- Mark OBs that already have confirmed BOS and inducement as valid
       for (int j = 0; j < ArraySize(obs); j++)
         {
          if (!obs[j].mit && HasBOSAndInducement(j, use_tf))
             obs[j].valid = true;
         }
       //--- Log the full initial OB array
       PrintOBs();
       //--- Sync label font sizes to the current chart scale
       UpdateFontSizes();
    //---
       return(INIT_SUCCEEDED);
      }

We begin by assigning the magic number to the trade object using the [SetExpertMagicNumber](/en/docs/standardlibrary/tradeclasses/CTrade/CTradeSetExpertMagicNumber) method, ensuring all orders placed by this program are uniquely identifiable. We then open a separate chart on the higher timeframe using [ChartOpen](/en/docs/chart_operations/chartopen) for swing visualization, printing a warning if this fails, which can happen inside the strategy tester. Next, all previously drawn zone objects are cleared from the main chart using [ObjectsDeleteAll](/en/docs/objects/ObjectDeleteAll) for each prefix — fair value gaps, order blocks, break of structure lines, and inducement lines — along with the trend label. All three tracking arrays are then reset to zero size with [ArrayResize](/en/docs/array/arrayresize) to start from a clean state.

With the chart clean, we call "UpdateTrend" to establish the initial trend direction from the higher timeframe before any zone detection runs. We then resolve the active trading timeframe, defaulting to the current chart period if [PERIOD_CURRENT](/en/docs/constants/chartconstants/enum_timeframes) is selected, and retrieve the number of visible bars using [ChartGetInteger](/en/docs/chart_operations/chartgetinteger). We scan all visible bars from oldest to newest, calling "DetectAndCreateZone" on each to build the initial order block map.

Once all zones are created, we replay historical price action across each zone by calling "ProcessHistoricalState" to set their mitigation and signal states. A second pass then calls "HasBOSAndInducement" on all unmitigated zones, marking those with confirmed break of structure and inducement as valid and therefore tradeable. Finally, we log the full zone array and sync font sizes before returning [INIT_SUCCEEDED](/en/docs/basis/function/events#enum_init_retcode). Upon compilation, we get the following outcome.

![INITIALIZATION](https://c.mql5.com/2/205/Screenshot_2026-04-07_141108.png)

The screenshot confirms that the initialization was successful. We can now define logic to detect new zones and update the order blocks in the tick event handler.

_Trailing Stop Management, Zone Detection, and State Updates_

With initialization complete, we now define the functions that run on every new bar — managing open trade trailing stops, scanning for new zones, and updating the mitigation and signal state of all tracked order blocks.
    
    
    //+------------------------------------------------------------------+
    //| Handle RR-based trailing stop for all open positions             |
    //+------------------------------------------------------------------+
    void HandleRRTrailing()
      {
       double point = _Point;
       double bid   = SymbolInfoDouble(_Symbol, SYMBOL_BID);
       double ask   = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
       //--- Iterate all tracked trades in reverse for safe removal
       for (int i = ArraySize(trades) - 1; i >= 0; i--)
         {
          //--- Remove the entry if the position no longer exists
          if (!PositionSelectByTicket(trades[i].ticket))
            {
             ArrayRemove(trades, i, 1);
             continue;
            }
          //--- Skip positions on other symbols
          if (PositionGetString (POSITION_SYMBOL) != _Symbol)      continue;
          //--- Skip positions opened by other EAs
          if (PositionGetInteger(POSITION_MAGIC)  != magic_number) continue;
          //--- Read current position details
          double entry  = PositionGetDouble (POSITION_PRICE_OPEN);
          double sl     = PositionGetDouble (POSITION_SL);
          double tp     = PositionGetDouble (POSITION_TP);
          ENUM_POSITION_TYPE type = (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
          //--- Compute current profit distance from entry in price terms
          double profit_dist = (type == POSITION_TYPE_BUY) ? (bid - entry) : (entry - ask);
          double orig_risk   = trades[i].orig_risk;
          int    level       = trades[i].trail_level;
          //--- Advance trailing level while profit exceeds the next RR threshold
          while (profit_dist >= (level + 1) * orig_risk)
            {
             //--- Compute the new SL at the current RR level from entry
             double new_sl = (type == POSITION_TYPE_BUY)
                             ? NormalizeDouble(entry + level * orig_risk, _Digits)
                             : NormalizeDouble(entry - level * orig_risk, _Digits);
             //--- Read broker stop and freeze levels to enforce minimum distance
             long   stop_level   = SymbolInfoInteger(_Symbol, SYMBOL_TRADE_STOPS_LEVEL);
             long   freeze_level = SymbolInfoInteger(_Symbol, SYMBOL_TRADE_FREEZE_LEVEL);
             double min_dist     = MathMax(stop_level, freeze_level) * point;
             //--- Clamp the buy SL so it does not violate the minimum stop distance
             if (type == POSITION_TYPE_BUY)
               {
                double min_sl = bid - min_dist;
                if (new_sl > min_sl) new_sl = min_sl;
               }
             else
               {
                //--- Clamp the sell SL so it does not violate the minimum stop distance
                double max_sl = ask + min_dist;
                if (new_sl < max_sl) new_sl = max_sl;
               }
             //--- Skip if the new SL matches the current SL (no change needed)
             if (new_sl == sl) break;
             //--- Apply the trailing SL modification to the broker
             if (obj_Trade.PositionModify(trades[i].ticket, new_sl, tp))
               {
                sl = new_sl;
                trades[i].trail_level++;
               }
             else break;
             level = trades[i].trail_level;
            }
         }
      }
    
    //+------------------------------------------------------------------+
    //| Apply fixed points trailing stop to all open positions           |
    //+------------------------------------------------------------------+
    void ApplyPointsTrailing()
      {
       double point = _Point;
       //--- Iterate all open positions in reverse for safe modification
       for (int i = PositionsTotal() - 1; i >= 0; i--)
         {
          if (PositionGetTicket(i) > 0)
            {
             //--- Filter by symbol and magic number to target only this EA's trades
             if (PositionGetString(POSITION_SYMBOL) == _Symbol && PositionGetInteger(POSITION_MAGIC) == magic_number)
               {
                double sl        = PositionGetDouble(POSITION_SL);
                double tp        = PositionGetDouble(POSITION_TP);
                double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
                ulong  ticket    = PositionGetInteger(POSITION_TICKET);
                //--- Handle buy position trailing
                if (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
                  {
                   //--- Compute new SL below current bid by the trailing distance
                   double newSL = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID) - Trailing_Stop_Pips * point, _Digits);
                   //--- Move SL only if it improves and profit threshold is met
                   if (newSL > sl && SymbolInfoDouble(_Symbol, SYMBOL_BID) - openPrice > Min_Profit_To_Trail_Pips * point)
                      obj_Trade.PositionModify(ticket, newSL, tp);
                  }
                else if (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
                  {
                   //--- Compute new SL above current ask by the trailing distance
                   double newSL = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK) + Trailing_Stop_Pips * point, _Digits);
                   //--- Move SL only if it improves and profit threshold is met
                   if (newSL < sl && openPrice - SymbolInfoDouble(_Symbol, SYMBOL_ASK) > Min_Profit_To_Trail_Pips * point)
                      obj_Trade.PositionModify(ticket, newSL, tp);
                  }
               }
            }
         }
      }
    
    //+------------------------------------------------------------------+
    //| Detect new OB zones on recent bars                               |
    //+------------------------------------------------------------------+
    void DetectNewZones(ENUM_TIMEFRAMES tf)
      {
       //--- Skip detection when no trend direction is defined
       if (current_trend == 0) return;
       //--- Scan the last 50 confirmed bars for new OB formations
       for (int i = 50; i >= 1; i--)
          DetectAndCreateZone(i, tf);
      }
    
    //+------------------------------------------------------------------+
    //| Update mitigation and signal states for all tracked OBs          |
    //+------------------------------------------------------------------+
    void UpdateOBs(ENUM_TIMEFRAMES tf)
      {
       //--- Read the last two confirmed bar closes and boundaries
       double   prevClose  = iClose(_Symbol, tf, 1);
       double   close2     = iClose(_Symbol, tf, 2);
       double   prevLow    = iLow  (_Symbol, tf, 1);
       double   prevHigh   = iHigh (_Symbol, tf, 1);
       datetime curBarTime = iTime (_Symbol, tf, 1);
       bool     removed    = false;
       //--- Iterate OBs in reverse to allow safe in-place removal
       for (int j = ArraySize(obs) - 1; j >= 0; j--)
         {
          //--- Remove OB entries whose chart objects have been deleted externally
          if (ObjectFind(0, obs[j].name) < 0)
            {
             if (prt) Print("Update: Removed non-existent OB from storage: ", obs[j].name);
             ArrayRemove(obs, j, 1);
             removed = true;
             continue;
            }
          //--- Read the current OB price boundaries from the chart object
          double obLow  = MathMin(ObjectGetDouble(0, obs[j].name, OBJPROP_PRICE, 0), ObjectGetDouble(0, obs[j].name, OBJPROP_PRICE, 1));
          double obHigh = MathMax(ObjectGetDouble(0, obs[j].name, OBJPROP_PRICE, 0), ObjectGetDouble(0, obs[j].name, OBJPROP_PRICE, 1));
          //--- Validate unconfirmed OBs by checking for BOS and inducement now
          if (!obs[j].valid && !obs[j].mit)
            {
             if (HasBOSAndInducement(j, tf))
               {
                obs[j].valid = true;
                if (prt) Print("OB validated with BOS/Inducement: ", obs[j].name);
               }
            }
          //--- Check for mitigation on the last confirmed bar
          if (!obs[j].mit)
            {
             bool breakFar = (obs[j].origUp && prevLow < obLow) || (!obs[j].origUp && prevHigh > obHigh);
             if (breakFar)
               {
                //--- Mark OB as mitigated and record the mitigation bar time
                obs[j].mit     = true;
                obs[j].mitTime = curBarTime;
                obs[j].state   = Mitigated;
                if (prt) Print("Mitigated OB: ", obs[j].name, " at time=", TimeToString(curBarTime));
                //--- Redraw the OB rectangle with the mitigated color
                color mitClr = GetZoneColor(obs[j].origUp, obs[j].state);
                UpdateRec(obs[j].name, obs[j].startTime, obLow, obs[j].origEndTime, obHigh, mitClr);
                //--- Place the mitigation icon on the chart
                DrawMitIcon(obs[j].name, curBarTime, obHigh, obLow, obs[j].origUp);
               }
            }
          //--- Check for a new trade signal on valid OBs that allow it
          if ((!obs[j].mit || tradeMitigated == TradeMitigated) && obs[j].valid)
            {
             //--- Bar two closes ago was inside the OB
             bool inside2  = (close2 >= obLow && close2 <= obHigh);
             //--- Previous bar closed outside the OB in the expected breakout direction
             bool outside1 = obs[j].origUp ? (prevClose > obHigh) : (prevClose < obLow);
             if (inside2 && outside1)
               {
                //--- Flag a new tradeable signal for this OB
                obs[j].newSignal = true;
                obs[j].signal    = true;
                if (prt) Print("Signal (tap) on OB: ", obs[j].name, " at time=", TimeToString(curBarTime));
               }
            }
         }
       //--- Log OB array state after any removals
       if (removed) PrintOBs();
      }
    
    

The "HandleRRTrailing" function manages risk-to-reward-based trailing for all open positions. It iterates the trades array in reverse, removing any entry whose position no longer exists via [PositionSelectByTicket](/en/docs/trading/positionselectbyticket), and skipping positions belonging to other symbols or programs. For each qualifying position, it reads the entry, stop loss, take-profit, and type, then computes the current profit distance from entry. A while loop advances the trailing level as long as the profit distance meets the next risk-to-reward threshold, computing the new stop loss at each level using [NormalizeDouble](/en/docs/convert/normalizedouble). Before applying any modification, it reads the broker's stop and freeze levels via [SymbolInfoInteger](/en/docs/marketinformation/symbolinfointeger) and clamps the new stop loss to respect the minimum distance requirement. The modification is applied with the [PositionModify](/en/docs/standardlibrary/tradeclasses/ctrade/ctradepositionmodify) method, and the trail level is incremented only on success.

The "ApplyPointsTrailing" function handles the fixed points trailing mode. It iterates all open positions, filtering by symbol and magic number, then computes a new stop loss by offsetting the current bid or ask by the configured trailing distance. For buy positions, the stop loss moves up only when it improves, and the profit exceeds the minimum threshold, and for sell positions, the logic is mirrored in the opposite direction.

The "DetectNewZones" function is a lightweight wrapper that scans the last fifty confirmed bars and calls "DetectAndCreateZone" on each, skipping entirely if no trend has been established.

The "UpdateOBs" function processes all tracked order blocks on each new bar. It reads the last two confirmed bar closes and the previous bar's high and low, then iterates the array in reverse. Any zone whose chart rectangle has been externally deleted is removed from the array with the [ArrayRemove](/en/docs/array/arrayremove) function. For the remaining zones, it first attempts to break the structure and inducement validation on any zone not yet confirmed. 

It then checks for mitigation by testing whether the previous bar broke past the far edge of the zone, updating the state, redrawing the rectangle with the mitigated color, and placing the mitigation icon if triggered. Finally, for valid zones that permit trading, it checks whether the bar two candles ago closed inside the zone while the previous bar closed outside in the expected direction, flagging a fresh tradable signal when both conditions are met. We can now call these functions in the tick event handler to do the analysis, and once we confirm the signals, we will trade them.

_The OnTick Event Handler_

The [OnTick](/en/docs/event_handlers/ontick) event handler coordinates trailing-stop management, trend updates, and zone logic on each price tick.
    
    
    //+------------------------------------------------------------------+
    //| Expert tick function                                             |
    //+------------------------------------------------------------------+
    void OnTick()
      {
    //---
       //--- Run RR trailing logic if that mode is active and positions are open
       if (TrailingType == Trailing_RR     && PositionsTotal() > 0) HandleRRTrailing();
       //--- Run points trailing logic if that mode is active and positions are open
       if (TrailingType == Trailing_Points && PositionsTotal() > 0) ApplyPointsTrailing();
       //--- Check for a new bar on the higher timeframe and refresh the trend
       static datetime lastHigherBarTime = 0;
       datetime curHigherBarTime = iTime(_Symbol, higher_tf, 0);
       if (curHigherBarTime != lastHigherBarTime)
         {
          lastHigherBarTime = curHigherBarTime;
          UpdateTrend();
         }
       //--- Resolve the trading timeframe for bar detection
       ENUM_TIMEFRAMES use_tf = (trade_tf == PERIOD_CURRENT) ? _Period : trade_tf;
       //--- Detect a new bar on the trading timeframe
       static datetime lastBarTime = 0;
       datetime curBarTime = iTime(_Symbol, use_tf, 0);
       bool newBar = (curBarTime != lastBarTime);
       //--- Skip all zone logic if this is not a new bar
       if (!newBar) return;
       lastBarTime = curBarTime;
       //--- Scan for newly formed OB zones
       DetectNewZones(use_tf);
       //--- Update mitigation and signal states for all tracked OBs
       UpdateOBs(use_tf);
      }
    

On every tick, we first check whether any open positions require trailing stop management. If the risk-to-reward trailing mode is active, "HandleRRTrailing" is called, and if the fixed points mode is selected, "ApplyPointsTrailing" runs instead. Both are guarded by a check that at least one position is open to avoid unnecessary processing.

Next, we detect whether a new bar has formed on the higher timeframe by comparing the current bar's open time against the last recorded higher timeframe bar time using a static variable. When a new higher timeframe bar is detected, "UpdateTrend" is called to refresh the structural trend direction.

For the trading timeframe, a second static variable tracks the last known bar open time. The current bar time is compared against it to determine whether a new bar has formed. If no new bar exists, the function returns immediately, ensuring all zone logic runs only once per confirmed candle. When a new bar is confirmed, we update the last bar time, then sequentially call "DetectNewZones" and "UpdateOBs" to scan for new zones and refresh all tracked zone states. Upon compilation, we get the following outcome.

![CONFIRMED SETUP](https://c.mql5.com/2/205/Screenshot_2026-04-07_142236.png)

The output confirms that the setup is validated through the tick event handler analysis. Next, we handle trading the setups.

_Trade Execution and Expired Zone Cleanup_

With signals flagged by the update logic, we now define the function that acts on them by placing market orders, managing post-trade bookkeeping, and visualizing trade levels, followed by a cleanup routine that removes expired zones from the tracking array.
    
    
    //+------------------------------------------------------------------+
    //| Execute trades on OBs that carry a new signal                    |
    //+------------------------------------------------------------------+
    void TradeOnOBs()
      {
       //--- Retrieve current market prices
       double Ask     = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
       double Bid     = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
       //--- Retrieve account and symbol parameters for lot sizing
       double balance    = AccountInfoDouble(ACCOUNT_BALANCE);
       double tick_value = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE);
       double min_lot    = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);
       double max_lot    = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX);
       double lot_step   = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);
       //--- Resolve the trading timeframe
       ENUM_TIMEFRAMES use_tf    = (trade_tf == PERIOD_CURRENT) ? _Period : trade_tf;
       datetime        curBarTime = iTime(_Symbol, use_tf, 0);
       //--- Iterate all tracked OBs looking for actionable signals
       for (int j = 0; j < ArraySize(obs); j++)
         {
          //--- Skip OBs without a fresh signal, not validated, or blocked by settings
          if (!obs[j].newSignal || (obs[j].mitTime != 0 && tradeMitigated != TradeMitigated) || !obs[j].valid) continue;
          //--- Enforce the TradeOnce limit
          if (tradeMode == TradeOnce     && obs[j].tradeCount >= 1)             { obs[j].newSignal = false; continue; }
          //--- Enforce the LimitedTrades count limit
          if (tradeMode == LimitedTrades && obs[j].tradeCount >= maxTradesPerOB) { obs[j].newSignal = false; continue; }
          //--- Read OB price boundaries for entry and SL calculation
          double obLow  = MathMin(ObjectGetDouble(0, obs[j].name, OBJPROP_PRICE, 0), ObjectGetDouble(0, obs[j].name, OBJPROP_PRICE, 1));
          double obHigh = MathMax(ObjectGetDouble(0, obs[j].name, OBJPROP_PRICE, 0), ObjectGetDouble(0, obs[j].name, OBJPROP_PRICE, 1));
          //--- Set entry at ask for buys, bid for sells
          double entry  = obs[j].origUp ? Ask : Bid;
          //--- Set SL below the OB for buys, above for sells, with an offset buffer
          double sl     = obs[j].origUp
                          ? NormalizeDouble(obLow  - sl_offset_pts * _Point, _Digits)
                          : NormalizeDouble(obHigh + sl_offset_pts * _Point, _Digits);
          double risk_dist = MathAbs(entry - sl);
          if (risk_dist <= 0) continue;
          //--- Compute risk in points for lot sizing
          double points      = risk_dist / _Point;
          double risk_amount = balance * (risk_percent / 100.0);
          //--- Calculate the lot size that risks exactly the target amount
          double lot_size    = risk_amount / (points * tick_value);
          //--- Round to lot step and clamp within broker limits
          lot_size = MathMin(MathMax(MathRound(lot_size / lot_step) * lot_step, min_lot), max_lot);
          if (lot_size < min_lot) continue;
          //--- Compute TP based on the risk distance and RR ratio
          double tp = obs[j].origUp
                      ? NormalizeDouble(entry + risk_dist * rr_ratio, _Digits)
                      : NormalizeDouble(entry - risk_dist * rr_ratio, _Digits);
          bool result = false;
          //--- Place a buy market order for bullish OBs
          if (obs[j].origUp)
            {
             if (prt) Print("BULLISH OB TRADE SIGNAL For ", obs[j].name, " at ", Bid, " Lot: ", lot_size);
             result = obj_Trade.Buy(lot_size, _Symbol, Ask, sl, tp, "OB Buy");
            }
          else
            {
             //--- Place a sell market order for bearish OBs
             if (prt) Print("BEARISH OB TRADE SIGNAL For ", obs[j].name, " at ", Ask, " Lot: ", lot_size);
             result = obj_Trade.Sell(lot_size, _Symbol, Bid, sl, tp, "OB Sell");
            }
          //--- Process post-trade bookkeeping if the order was accepted
          if (result && obj_Trade.ResultRetcode() == TRADE_RETCODE_DONE)
            {
             ulong ticket = obj_Trade.ResultOrder();
             //--- Register the trade for RR trailing if that mode is active
             if (TrailingType == Trailing_RR)
               {
                int tsize = ArraySize(trades);
                ArrayResize(trades, tsize + 1);
                trades[tsize].ticket      = ticket;
                trades[tsize].orig_risk   = risk_dist;
                trades[tsize].trail_level = 0;
               }
             //--- Increment trade count and clear the fresh signal flag
             obs[j].tradeCount++;
             obs[j].newSignal = false;
             if (prt) Print("Trade executed on ", obs[j].name, ", tradeCount now=", obs[j].tradeCount);
             //--- Update the zone label to reflect the new trade count
             double   midPrice = (obLow + obHigh) / 2;
             datetime midTime  = obs[j].startTime + (obs[j].origEndTime - obs[j].startTime) / 2;
             UpdateLabel(obs[j].name, midTime, midPrice);
             //--- Draw entry, SL, and TP level lines on the chart if enabled
             if (VisualizeLevels)
               {
                datetime drawStart  = curBarTime;
                datetime drawEnd    = drawStart + PeriodSeconds(use_tf) * 5;
                datetime labelTime  = drawEnd + PeriodSeconds(use_tf) / 2;
                bool     isBuy      = obs[j].origUp;
                double   sign       = isBuy ? 1.0 : -1.0;
                //--- Draw and label the entry level
                DrawDottedLine(obs[j].name + "_Entry",       drawStart, entry, drawEnd, clrMagenta);
                DrawTextEx    (obs[j].name + "_Entry_label", "Entry",   labelTime, entry, clrMagenta, isBuy);
                //--- Draw and label the stop loss level
                DrawDottedLine(obs[j].name + "_SL",       drawStart, sl, drawEnd, clrRed);
                DrawTextEx    (obs[j].name + "_SL_label", "SL",       labelTime, sl, clrRed, !isBuy);
                //--- Define a set of green shades for progressive TP levels
                color tpColors[4] = {clrForestGreen, clrGreen, clrDarkGreen, clrLime};
                int   maxLevels   = (int)rr_ratio;
                //--- Draw and label each TP level up to the full RR ratio
                for (int lev = 1; lev <= maxLevels; lev++)
                  {
                   double lev_p   = entry + sign * risk_dist * lev;
                   color  c       = (lev - 1 < 4) ? tpColors[lev - 1] : clrLime;
                   //--- Label the final level as FullTP, intermediate levels as TP1, TP2, etc.
                   string levName = (lev == maxLevels) ? "FullTP" : "TP" + IntegerToString(lev);
                   DrawDottedLine(obs[j].name + "_" + levName,           drawStart, lev_p, drawEnd, c);
                   DrawTextEx    (obs[j].name + "_" + levName + "_label", levName,   labelTime, lev_p, c, isBuy);
                  }
               }
            }
         }
      }
    
    //+------------------------------------------------------------------+
    //| Remove expired OBs from the tracking array (keep chart objects)  |
    //+------------------------------------------------------------------+
    void CleanupExpiredOBs(datetime curBarTime)
      {
       bool removed = false;
       //--- Iterate in reverse to safely remove expired entries
       for (int j = ArraySize(obs) - 1; j >= 0; j--)
         {
          //--- Remove from array once the current bar has passed the OB expiry
          if (curBarTime > obs[j].origEndTime)
            {
             if (prt) Print("Expired OB removed from storage (kept on chart): ", obs[j].name, " endTime=", TimeToString(obs[j].origEndTime));
             ArrayRemove(obs, j, 1);
             removed = true;
            }
         }
       //--- Log the updated OB list after any removals
       if (removed) PrintOBs();
      }

The "TradeOnOBs" function begins by retrieving the current ask and bid prices, account balance, and symbol volume parameters needed for lot sizing. It then iterates all tracked order blocks, skipping any zone that lacks a fresh signal, has not been validated, or is blocked by the mitigation trade setting.

Before placing any order, the trade mode limits are enforced — zones that have already been traded once are skipped when "TradeOnce" is active, and zones that have reached the maximum count are skipped under "LimitedTrades", with the signal flag cleared in both cases. The entry price is set to the ask for bullish zones and the bid for bearish ones, while the stop loss is placed below the order block low for buys and above the high for sells, with the configured point offset applied via "NormalizeDouble". The risk distance is then used alongside the account balance and tick value to compute a precise lot size, which is rounded to the broker's lot step using "MathRound" and clamped between the minimum and maximum volume limits. The take-profit is set by projecting the risk distance by the configured risk-to-reward ratio in the trade direction.

Buy orders are placed with the [Buy](/en/docs/standardlibrary/tradeclasses/ctrade/ctradebuy) method and sell orders with [Sell](/en/docs/standardlibrary/tradeclasses/ctrade/ctradesell), both on the "CTrade" object. If the order is confirmed with [TRADE_RETCODE_DONE](/en/docs/constants/errorswarnings/enum_trade_return_codes), the returned ticket is registered in the trades array for risk-to-reward trailing. If that mode is active, the zone's trade count is incremented, and the signal flag is cleared. The zone label is then updated to reflect the new trade count. When level visualization is enabled, dotted lines and bold text labels are drawn for the entry, stop loss, and each progressive take-profit level up to the full risk-to-reward ratio. Each intermediate level is labeled sequentially as "TP1", "TP2", and so on, with the final level labeled "FullTP", using a range of green shades defined in a local color array.

The "CleanupExpiredOBs" function iterates the tracking array in reverse and removes any zone whose expiry time has been passed by the current bar time, using [ArrayRemove](/en/docs/array/arrayremove) for safe in-place deletion. The chart rectangles are intentionally left on the chart for reference, and the updated array is logged after any removals. When we call these functions in the tick event handler, we get the following outcome.

![TRADED SETUP](https://c.mql5.com/2/205/Screenshot_2026-04-07_142740.png)

The screenshot shows that setups validating signals open the respective trades. The remaining step is deinitializing the program.

_Deinitialization and Chart Event Handlers_

The final two event handlers handle graceful cleanup when the program is removed and respond to live chart interactions.
    
    
    //+------------------------------------------------------------------+
    //| Expert deinitialization function                                 |
    //+------------------------------------------------------------------+
    void OnDeinit(const int reason)
      {
    //---
       //--- Delete all OB rectangle objects and associated labels and icons
       for (int i = 0; i < ArraySize(obs); i++)
         {
          ObjectDelete(0, obs[i].name);
          ObjectDelete(0, obs[i].name + "_Label");
          ObjectDelete(0, obs[i].name + "_MitIcon");
         }
       //--- Delete all FVG rectangle objects
       for (int i = 0; i < ArraySize(fvg_names); i++)
          ObjectDelete(0, fvg_names[i]);
       //--- Delete all BOS, inducement, and OB prefixed objects
       ObjectsDeleteAll(0, BOS_Prefix);
       ObjectsDeleteAll(0, IND_Prefix);
       ObjectsDeleteAll(0, OB_Prefix);
       //--- Remove the trend label from the main chart
       ObjectDelete(0, "EA_TrendLabel");
       //--- Release all dynamic arrays
       ArrayResize(obs,       0);
       ArrayResize(fvg_names, 0);
       ArrayResize(trades,    0);
       //--- Close the higher timeframe chart if it was opened by this EA
       if (chart_id > 0) { ChartClose(chart_id); chart_id = -1; }
       //--- Refresh the main chart after cleanup
       ChartRedraw(0);
       if (prt) Print("Deinit: Deleted all objects, reset arrays, closed higher TF chart if open.");
    //---
      }
    
    //+------------------------------------------------------------------+
    //| Expert chart event function                                      |
    //+------------------------------------------------------------------+
    void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
      {
       //--- Respond to chart scale or size changes by updating all font sizes
       if (id == CHARTEVENT_CHART_CHANGE) UpdateFontSizes();
      }

In the [OnDeinit](/en/docs/event_handlers/ondeinit) event handler, we perform a full cleanup of all objects and resources created during the program's lifetime. We loop through the order block array and individually delete each zone's rectangle, label, and mitigation icon using the [ObjectDelete](/en/docs/objects/objectdelete) function. All fair value gap rectangles are deleted in a second loop, and then [ObjectsDeleteAll](/en/docs/objects/objectdeleteall) is used to sweep any remaining break of structure, inducement, and order block prefixed objects that may have been missed. The trend label is also removed. All three dynamic arrays are then released by resizing them to zero, and if the higher timeframe chart was opened by the program, it is closed with [ChartClose](/en/docs/chart_operations/chartclose) and the identifier is reset to negative one. A final redraw cleans up the chart visually.

In the [OnChartEvent](/en/docs/event_handlers/onchartevent) event handler, we listen for the [CHARTEVENT_CHART_CHANGE](/en/docs/constants/chartconstants/enum_chartevents) event, which fires whenever the chart is resized or the zoom scale is changed. When detected, we call "UpdateFontSizes" to recompute and apply the appropriate font size across all text objects, keeping labels readable at any zoom level. Next, we backtest the program, which is handled in the section below.

###   
  
Backtesting

We tested the program on the AUDUSD pair on the one-minute timeframe using the MetaTrader 5 strategy tester. Below is the compiled result presented as a Graphics Interchange Format (GIF).

![BACKTEST GIF](https://c.mql5.com/2/205/BACKTEST_INDUCEMENT.gif)

During testing, the program identified consolidation zones followed by impulsive breakouts. Order blocks were validated only after a confirmed break of structure, and inducement sweeps were detected. Price returned to several bullish order blocks in the uptrend periods and reacted cleanly, with the risk-to-reward trailing mechanism locking in profits progressively as price extended. Bearish zones in downtrend conditions similarly attracted price returns, with the mitigation color change providing a clear visual distinction between active and swept zones.

Backtest graph:

![GRAPH](https://c.mql5.com/2/205/Screenshot_2026-04-07_171331.png)

Backtest report:

![REPORT](https://c.mql5.com/2/205/Screenshot_2026-04-07_171345.png)

  


### Conclusion

In conclusion, we have built a complete automated trading program in MQL5 that identifies [order block zones](/go?link=https://www.xs.com/en/blog/order-block-guide/ "https://www.xs.com/en/blog/order-block-guide/") from consolidation breakouts, validates them through break of structure and inducement confirmation, and executes trades only when all structural conditions align with the higher timeframe trend. We covered zone detection using equal highs and lows consolidation analysis, fair value gap scanning within impulsive moves, historical state replay for mitigation tracking, and a full trade execution engine with risk-based lot sizing and two trailing stop options.

Disclaimer: This article is for educational purposes only. Trading carries significant financial risks, and past performance during backtesting does not guarantee future results. Thorough backtesting and careful risk management are essential before deploying this program in live markets.

After reading this article, you will be able to:

  * Identify order block zones formed within consolidation ranges and confirmed by impulsive breakouts on your chart
  * Validate trade setups by requiring both a break of structure and a prior inducement sweep before any entry is considered
  * Apply risk-to-reward-based or fixed points trailing stops to manage open positions dynamically as price extends in your favor



**Attached files** | 

[ __Download ZIP](/en/articles/download/22078.zip "Download all attachments in the single ZIP archive")

[__Inducement_Mitigation_Block_Strategy.mq5](/en/articles/download/22078/Inducement_Mitigation_Block_Strategy.mq5 "Download Inducement_Mitigation_Block_Strategy.mq5") (76.71 KB)

**Warning:** All rights to these materials are reserved by MetaQuotes Ltd. Copying or reprinting of these materials in whole or in part is prohibited.

This article was written by a user of the site and reflects their personal views. MetaQuotes Ltd is not responsible for the accuracy of the information presented, nor for any consequences resulting from the use of the solutions, strategies or recommendations described.

![Allan Munene Mutiiria](https://c.mql5.com/avatar/2022/11/637df59b-9551_big.jpg)

[Allan Munene Mutiiria](/en/users/29210372 "Allan Munene Mutiiria")

  * __[Kenya](https://www.mql5.com/go?https://maps.google.com/?z=4&q=Kenya "Lives")
  * __[194457](/en/users/29210372/achievements "Rating")



* [](https://forexalgo-trader.com/) <https://forexalgo-trader.com/>

#### Other articles by this author

  * [MQL5 Trading Tools (Part 35): Adding Channel, Pitchfork, Gann, and Fibonacci Tools to the Canvas Drawing Layer](/en/articles/22838)
  * [MQL5 Trading Tools (Part 34): Replacing Native Chart Objects with an Interactive Canvas Drawing Layer](/en/articles/22786)
  * [MQL5 Trading Tools (Part 33): Building a Rich Content Markup Documentation System for MQL5 Programs](/en/articles/22303)
  * [Trading with the MQL5 Economic Calendar (Part 12): SQLite Storage and Deduplication](/en/articles/22608)
  * [Trading with the MQL5 Economic Calendar (Part 11): Modular Canvas News Dashboard](/en/articles/22597)
  * [MQL5 Trading Tools (Part 32): Crosshair, Magnifier, and Measure Mode](/en/articles/22233)
  * [Building AI-Powered Trading Systems in MQL5 (Part 9): Creating an AI Signal Dispatcher](/en/articles/22495)



**[Go to discussion](/en/forum/509056) **

![Building a Trade Analytics System \(Part 2\): How to Capture Closed Trades and Send JSON in MQL5](https://c.mql5.com/2/209/22216-building-a-trade-analytics-logo.png) [Building a Trade Analytics System (Part 2): How to Capture Closed Trades and Send JSON in MQL5](/en/articles/22216)

We build a lightweight bridge that captures closed trades in MetaTrader 5 and sends them to an external backend over HTTP as JSON. It uses OnTradeTransaction for event detection, reads details from deal history, assembles a JSON payload, and posts it via WebRequest. A local Flask API is used to test the flow, delivering a working path to move trade data outside the terminal.

![Using the MQL5 Economic Calendar for News Filter \(Part 4\): Accurate Backtesting with Static Data](https://c.mql5.com/2/209/22231-using-the-mql5-economic-calendar-logo.png) [Using the MQL5 Economic Calendar for News Filter (Part 4): Accurate Backtesting with Static Data](/en/articles/22231)

This article implements a static, CSV-based news source for the Strategy Tester, so historical economic news events can be preloaded and queried during backtesting. It replaces live calendar calls in tester mode with a fast in-memory search, preserves the live logic for trading, and delivers deterministic, repeatable results with explicit control over included events, enabling reliable validation of news-aware filters, stop suspension, and trade-blocking rules.

![File-Based Versioning of EA Parameters in MQL5](https://c.mql5.com/2/209/21775-file-based-versioning-of-ea-logo.png) [File-Based Versioning of EA Parameters in MQL5](/en/articles/21775)

This article explains how to implement parameter versioning in MQL5 using binary files and packed structures. It shows how to write and read fixed-size records with FileWriteStruct and FileReadStruct in FILE_BIN mode, including version numbers, timestamps, and a checksum. You will also see how to detect changes via checksums, append records safely, and load the latest configuration without overwriting prior settings.

![Neural Networks in Trading: Detecting Anomalies in the Frequency Domain \(CATCH\)](https://c.mql5.com/2/129/Neural_Networks_in_Trading_CATCH___LOGO.png) [Neural Networks in Trading: Detecting Anomalies in the Frequency Domain (CATCH)](/en/articles/17649)

The CATCH framework combines Fourier transform and frequency patching to accurately identify market anomalies beyond the reach of traditional methods. Let us examine how this approach reveals hidden patterns in financial data.

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


