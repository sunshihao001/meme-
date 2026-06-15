//+------------------------------------------------------------------+
//|                      Malaysian Engulfing - Pattern Detection.mq5 |
//|                                             © 2026, ChukwuBuikem |
//|                             https://www.mql5.com/en/users/bikeen |
//+------------------------------------------------------------------+
#property copyright "© 2026, ChukwuBuikem"
#property link      "https://www.mql5.com/en/users/bikeen"
#property version   "1.00"
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
//|        Initialization function                                   |
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
//| Custom indicator iteration function                              |
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
//| Function to detect perfect bullish engulfing                     |
//+------------------------------------------------------------------+
bool isBullishEngulfing(const int index, const double &open[], const double &high[],
                        const double &low[], const double &close[])
  {
//---
   return(close[index - 1] < open[index - 1] && close[index] > open[index]
          && open[index] <= close[index - 1] && close[index] > high[index - 1]);
  }
//+------------------------------------------------------------------+
//| Function to detect perfect bearish engulfing                     |
//+------------------------------------------------------------------+
bool isBearishEngulfing(const int index, const double &open[], const double &high[],
                        const double &low[], const double &close[])
  {
//---
   return(close[index - 1] > open[index - 1] && close[index] < open[index]
          && open[index] >= close[index - 1] && close[index] < low[index - 1]);
  }
//+------------------------------------------------------------------+
