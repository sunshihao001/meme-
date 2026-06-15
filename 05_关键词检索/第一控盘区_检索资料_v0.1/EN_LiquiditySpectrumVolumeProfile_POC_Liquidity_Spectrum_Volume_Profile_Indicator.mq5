//+------------------------------------------------------------------+
//|                  Liquidity Spectrum Volume Profile Indicator.mq5 |
//|                                             Abioye Israel Pelumi |
//|                             https://linktr.ee/abioyeisraelpelumi |
//+------------------------------------------------------------------+
#property copyright "Abioye Israel Pelumi"
#property link      "https://linktr.ee/abioyeisraelpelumi"
#property version   "1.00"
#property indicator_chart_window
#property indicator_plots 0

//--- INPUT PARAMETERS
input int   InpLookback      = 100;   // Number of bars used for calculation
input bool  InpVolumeProfile = true;  // Display volume profile boxes
input bool  InpLiqLevels     = true;  // Display POC (liquidity) lines

//--- CONSTANTS
#define N_BINS          100    // Number of price levels (bins)
#define MAX_BAR_WIDTH   50     // Maximum horizontal width of profile
#define OBJ_PREFIX      "VP_"  // Prefix for all chart objects
#define POC_THRESHOLD   25     // Threshold for drawing POC lines

//+------------------------------------------------------------------+
//| Convert "bars ago" into actual chart time                        |
//| This allows drawing objects into the past or future              |
//+------------------------------------------------------------------+
datetime BarsAgoToTime(const datetime &times[], int copiedBars,
                       int barsAgo, long barDur)
  {
//--- Case 1: within available history
   if(barsAgo >= 0 && barsAgo < copiedBars)
      return times[barsAgo];
//--- Case 2: future projection (negative index)
   if(barsAgo < 0)
      return (datetime)((long)times[0] - (long)barsAgo * barDur); // barsAgo is negative
//--- Case 3: beyond copied range
   return (datetime)((long)times[copiedBars-1] - (long)(barsAgo - copiedBars + 1) * barDur);
  }

//+------------------------------------------------------------------+
//| Create or update a rectangle (volume profile bar)                |
//| Returns true if a new object was created                         |
//+------------------------------------------------------------------+
bool DrawBox(const string name,
             datetime x1, double yTop,
             datetime x2, double yBot,
             color fillCol)
  {
   bool created = false;

//--- Create object only if it does not exist
   if(ObjectFind(0, name) < 0)
     {
      ObjectCreate(0, name, OBJ_RECTANGLE, 0, x1, yTop, x2, yBot);
      created = true;
     }

//--- Update object properties
   ObjectSetInteger(0, name, OBJPROP_COLOR, fillCol);
   ObjectSetInteger(0, name, OBJPROP_BGCOLOR, fillCol);
   ObjectSetInteger(0, name, OBJPROP_FILL, true);
   ObjectSetInteger(0, name, OBJPROP_BACK, true);
   ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);

//--- Update position
   ObjectMove(0, name, 0, x1, yTop);
   ObjectMove(0, name, 1, x2, yBot);

   return created;
  }
//+------------------------------------------------------------------+
//| Create or update a horizontal POC (liquidity) line               |
//| Returns true if a new object was created                         |
//+------------------------------------------------------------------+
bool DrawTrend(const string name,
               datetime x1, double y,
               datetime x2,
               color col, int w)
  {
   bool created = false;

//--- Create only if missing
   if(ObjectFind(0, name) < 0)
     {
      ObjectCreate(0, name, OBJ_TREND, 0, x1, y, x2, y);
      created = true;
     }

//--- Update properties
   ObjectSetInteger(0, name, OBJPROP_COLOR, col);
   ObjectSetInteger(0, name, OBJPROP_WIDTH, w);
   ObjectSetInteger(0, name, OBJPROP_RAY_RIGHT, false);
   ObjectSetInteger(0, name, OBJPROP_BACK, true);
   ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);

//--- Update position
   ObjectMove(0, name, 0, x1, y);
   ObjectMove(0, name, 1, x2, y);

   return created;
  }
//+------------------------------------------------------------------+
//| Delete all indicator objects                                     |
//+------------------------------------------------------------------+
void DeleteAllObjects()
  {
   for(int i = ObjectsTotal(0, 0, -1) - 1; i >= 0; i--)
     {
      string n = ObjectName(0, i, 0, -1);
      if(StringFind(n, OBJ_PREFIX) == 0)
         ObjectDelete(0, n);
     }
  }

//+------------------------------------------------------------------+
//| Core calculation function                                        |
//| Builds and draws the volume profile                              |
//+------------------------------------------------------------------+
void RecalcVolumeProfile(bool &need_redraw)
  {
   DeleteAllObjects();

//--- Exit early if both features are disabled
   if(!InpVolumeProfile && !InpLiqLevels)
      return;
   int totalBars = Bars(_Symbol, _Period);
   int lookback  = MathMin(InpLookback, totalBars - 1);
   if(lookback < 2)
      return;

//--- Prepare arrays for market data
   double   hi[], lo[], cl[];
   long     vol[];
   datetime tm[];
   ArraySetAsSeries(hi,true);
   ArraySetAsSeries(lo,true);
   ArraySetAsSeries(cl,true);
   ArraySetAsSeries(vol,true);
   ArraySetAsSeries(tm,true);

//--- Copy required data from terminal
   if(CopyHigh(_Symbol,_Period,0,lookback,hi)  < lookback)
      return;
   if(CopyLow(_Symbol,_Period,0,lookback,lo)  < lookback)
      return;
   if(CopyClose(_Symbol,_Period,0,lookback,cl)  < lookback)
      return;
   if(CopyTime(_Symbol,_Period,0,lookback,tm)  < lookback)
      return;
//--- Prefer tick volume, fallback to real volume
   if(CopyTickVolume(_Symbol,_Period,0,lookback,vol) < lookback)
      if(CopyRealVolume(_Symbol,_Period,0,lookback,vol) < lookback)
         return;

//--- Determine price range
   double priceMax = hi[ArrayMaximum(hi, 0, lookback)];
   double priceMin = lo[ArrayMinimum(lo, 0, lookback)];
   if(priceMax <= priceMin)
      return;
      
   int idxHigh = ArrayMaximum(hi, 0, lookback);
   int idxLow  = ArrayMinimum(lo, 0, lookback);
//--- Divide price range into bins
   double step = (priceMax - priceMin) / N_BINS;

//--- build bins
   double bins[];
   ArrayResize(bins, N_BINS);
   ArrayInitialize(bins, 0.0);

//--- Assign volume to bins
   for(int i = 0; i < N_BINS; i++)
     {
      double lower = priceMin + step * i;
      double upper = lower + step;
      for(int j = 0; j < lookback; j++)
        {
         double c = cl[j];
         if(c >= lower - step && c <= upper + step)
           {
            bins[i] += (double)vol[j];
           }
        }
     }

//--- Find maximum volume bin
   double maxBin = 0;
   for(int i = 0; i < N_BINS; i++)
      if(bins[i] > maxBin)
         maxBin = bins[i];
   if(maxBin == 0)
      return;

//--- Define drawing boundaries
   int profileLeftBarsAgo = lookback + MAX_BAR_WIDTH;
   long barDur = (long)PeriodSeconds(_Period);
   datetime profileLeftTime = BarsAgoToTime(tm, lookback, profileLeftBarsAgo, barDur);

// POC right end = bar_index + 5 (5 bars into the future)
   datetime pocRightTime = BarsAgoToTime(tm, lookback, -5, barDur);

//--- Loop through bins and draw
   for(int i = 0; i < N_BINS; i++)
     {
      double lower = priceMin + step * i;
      double upper = lower + step;
      double mid   = (lower + upper) * 0.5;

      //--- Normalize bin width
      int val = (int)(bins[i] / maxBin * (double)MAX_BAR_WIDTH);
      if(val < 1)
         continue;

      int profileRightBarsAgo = profileLeftBarsAgo - val;
      datetime profileRightTime  = BarsAgoToTime(tm, lookback, profileRightBarsAgo, barDur);

      color    box_line_clr   = (val >= 40) ? clrBlue : (val > 30) ? clrGreen : (val > 20) ? clrGray : (val > 10) ? clrOlive : clrAquamarine;
      //--- Draw volume box
      if(InpVolumeProfile)
        {
         string boxName = OBJ_PREFIX + "BOX_" + IntegerToString(i);
         if(DrawBox(boxName, profileRightTime, upper, profileLeftTime, lower, box_line_clr))
            need_redraw = true;
        }

      //--- Draw POC line for strong bins
      // POC lines for high-volume bins
      if(val > POC_THRESHOLD && InpLiqLevels)
        {
         string lineName = OBJ_PREFIX + "POC_" + IntegerToString(i);
         int    lineW   = (val > 45) ? 3 : (val > 35) ? 2 : 1;
         if(DrawTrend(lineName, pocRightTime, mid, profileLeftTime, box_line_clr, lineW))
            need_redraw = true;
        }
     }

// Border right = bar_index + 5 (same as POC)
   datetime borderRightTime = pocRightTime;
   datetime borderLeftTime = BarsAgoToTime(tm, lookback,
                                           profileLeftBarsAgo + MAX_BAR_WIDTH, barDur);
//--- outer border box
   if(DrawBox(OBJ_PREFIX+"BORDER", borderRightTime, priceMax, borderLeftTime, priceMin, clrSnow))
      need_redraw = true;
  }


//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
   bool redraw = false;
//--- Initial calculation so indicator appears immediately
   RecalcVolumeProfile(redraw);

   if(redraw)
      ChartRedraw(0);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Deinitialization                                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//  ObjectsDeleteAll(0);
   DeleteAllObjects();
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
   bool need_redraw = false;

//--- Recalculate only when new data arrives
   if(prev_calculated == 0 || rates_total != prev_calculated)
      RecalcVolumeProfile(need_redraw);

//--- Redraw only if something changed
   if(need_redraw)
      ChartRedraw(0);

//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
