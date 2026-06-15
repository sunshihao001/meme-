//+------------------------------------------------------------------+
//|                      Malaysian Engulfing - Retest Validation.mq5 |
//|                                             © 2026, ChukwuBuikem |
//|                             https://www.mql5.com/en/users/bikeen |
//+------------------------------------------------------------------+
#property copyright "© 2026, ChukwuBuikem"
#property link      "https://www.mql5.com/en/users/bikeen"
#property version  "1.50"
#property indicator_chart_window
#property indicator_plots 0

#include <ChartObjects\ChartObjectsShapes.mqh>

#define PROG_NAME "Malaysian Engulfing - Retest Validation"
#define ZONE_BULL PROG_NAME + "BullishEngulfing"
#define ZONE_BEAR PROG_NAME + "BearishEngulfing"

//--- State Enumeration
enum ENUM_SYSTEM_STATE
  {
   SEARCH_STATE = 0, // Discovery Phase
   FOUND_STATE = 1   // Validation Phase
  };

//--- Data Structure
struct st_Engulfer
  {
   ENUM_SYSTEM_STATE state;
   datetime          time, retestTime;
   double            high, low;
   //--- Constructor
                     st_Engulfer(): state(SEARCH_STATE), time(LONG_MIN),
                     retestTime(LONG_MIN), high(EMPTY_VALUE), low(EMPTY_VALUE) {}
  };

//--- Configurable Parameters
input int   barsRetestRange  = 10;        // Retest window (in bars)
input color bullishZoneColor = clrGreen;  // Bullish retest zone color
input color bearishZoneColor = clrRed;    // Bearish retest zone color
input int   wickThreshold    = 35;        // Minimum wick rati0 (%)

//--- Global variables
int start = -1;
CChartObjectRectangle rect;
st_Engulfer bullishEngulfer, bearishEngulfer;

//+------------------------------------------------------------------+
//|        Initialization function                                   |
//+------------------------------------------------------------------+
int OnInit(void)
  {
//--- Adaptive engine

   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//|        Deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int32_t reason)
  {
//--- Clear chart
   ObjectsDeleteAll(0, PROG_NAME);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
//|             Core iteration function                              |
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
               bearishEngulfer.retestTime = time[w] + (PeriodSeconds() * barsRetestRange); // Set retest time window
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
                  //--- Broken?  reset state
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
                  //--- Broken?  reset state
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
//+------------------------------------------------------------------+
//|       Perfect bullish engulfing detection                        |
//+------------------------------------------------------------------+
bool isBullishEngulfing(const int index, const double &open[], const double &high[],
                        const double &low[], const double &close[])
  {
//---
   return(close[index - 1] < open[index - 1] && close[index] > open[index]
          && open[index] <= close[index - 1] && close[index] > high[index - 1]);
  }
//+------------------------------------------------------------------+
//|       Perfect bearish engulfing detection                        |
//+------------------------------------------------------------------+
bool isBearishEngulfing(const int index, const double &open[], const double &high[],
                        const double &low[], const double &close[])
  {
//---
   return(close[index - 1] > open[index - 1] && close[index] < open[index]
          && open[index] >= close[index - 1] && close[index] < low[index - 1]);
  }
//+------------------------------------------------------------------+
//|             Upper wick ratio validation                          |
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
//|                Lower wick ratio validation                       |
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
//+------------------------------------------------------------------+
//|                   Zone creation                                  |
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
//+------------------------------------------------------------------+
