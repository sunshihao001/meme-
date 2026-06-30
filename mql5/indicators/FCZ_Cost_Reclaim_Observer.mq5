#property copyright "MQL5 FCZ research KB"
#property link      "https://github.com/sunshihao001/meme-"
#property version   "1.000"
#property indicator_chart_window
#property indicator_plots 0

input int    InpLookbackBars = 300;
input int    InpATRPeriod = 14;
input bool   InpUseTickVolume = true;
input bool   InpShowDebugText = true;
input bool   InpExportCSV = true;

input int    InpFCZStartShift = 120;
input int    InpFCZEndShift = 60;
input int    InpProfileBins = 48;
input double InpValueAreaRatio = 0.70;

input int    InpImpulseStartShift = 60;
input int    InpImpulseHighShift = 30;
input int    InpWashoutLowShift = 10;

input bool   InpShowAVWAPZoneStart = true;
input bool   InpShowAVWAPImpulseStart = true;
input int    InpRelationLookbackBars = 10;

string PREFIX = "FCZ_OBSERVER_";

int OnInit()
{
   IndicatorSetString(INDICATOR_SHORTNAME, "FCZ Cost Reclaim Observer MVP");
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
   ObjectsDeleteAll(0, PREFIX);
}

int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
   if(rates_total < 50)
      return(rates_total);

   int startShift = MathMax(InpFCZStartShift, InpFCZEndShift);
   int endShift = MathMin(InpFCZStartShift, InpFCZEndShift);
   if(startShift >= rates_total || endShift < 0 || InpProfileBins <= 0)
      return(rates_total);

   double fczHigh = high[endShift];
   double fczLow = low[endShift];
   long totalVol = 0;

   for(int i = endShift; i <= startShift; i++)
   {
      if(high[i] > fczHigh) fczHigh = high[i];
      if(low[i] < fczLow) fczLow = low[i];
      totalVol += tick_volume[i];
   }

   if(fczHigh <= fczLow)
      return(rates_total);

   double binSize = (fczHigh - fczLow) / InpProfileBins;
   double bins[];
   ArrayResize(bins, InpProfileBins);
   ArrayInitialize(bins, 0.0);

   for(int i = endShift; i <= startShift; i++)
   {
      double typical = (high[i] + low[i] + close[i]) / 3.0;
      int bin = (int)MathFloor((typical - fczLow) / binSize);
      if(bin < 0) bin = 0;
      if(bin >= InpProfileBins) bin = InpProfileBins - 1;
      bins[bin] += (double)tick_volume[i];
   }

   int pocBin = 0;
   double maxVol = bins[0];
   double allVol = 0.0;
   for(int b = 0; b < InpProfileBins; b++)
   {
      allVol += bins[b];
      if(bins[b] > maxVol)
      {
         maxVol = bins[b];
         pocBin = b;
      }
   }

   double poc = fczLow + (pocBin + 0.5) * binSize;
   double pocPositionRatio = (poc - fczLow) / (fczHigh - fczLow);
   int lowBin = pocBin;
   int highBin = pocBin;
   double covered = bins[pocBin];
   double target = allVol * InpValueAreaRatio;

   while(covered < target && (lowBin > 0 || highBin < InpProfileBins - 1))
   {
      double lowerVol = (lowBin > 0) ? bins[lowBin - 1] : -1.0;
      double upperVol = (highBin < InpProfileBins - 1) ? bins[highBin + 1] : -1.0;
      if(upperVol >= lowerVol && highBin < InpProfileBins - 1)
      {
         highBin++;
         covered += bins[highBin];
      }
      else if(lowBin > 0)
      {
         lowBin--;
         covered += bins[lowBin];
      }
      else
         break;
   }

   double val = fczLow + lowBin * binSize;
   double vah = fczLow + (highBin + 1) * binSize;

   int fczBars = startShift - endShift + 1;

   DrawRect(PREFIX + "FCZ", time[startShift], fczHigh, time[endShift], fczLow, clrDodgerBlue);
   DrawHLine(PREFIX + "POC", poc, clrGold, 2);
   DrawHLine(PREFIX + "VAH", vah, clrLimeGreen, 1);
   DrawHLine(PREFIX + "VAL", val, clrTomato, 1);

   double avwapZone = EMPTY_VALUE;
   double avwapImpulse = EMPTY_VALUE;
   if(InpShowAVWAPZoneStart && startShift < rates_total)
   {
      avwapZone = CalcAVWAP(startShift, 0, high, low, close, tick_volume, rates_total);
      DrawHLine(PREFIX + "AVWAP_ZONE_START", avwapZone, clrAqua, 1);
   }
   if(InpShowAVWAPImpulseStart && InpImpulseStartShift < rates_total)
   {
      avwapImpulse = CalcAVWAP(InpImpulseStartShift, 0, high, low, close, tick_volume, rates_total);
      DrawHLine(PREFIX + "AVWAP_IMPULSE_START", avwapImpulse, clrViolet, 1);
   }

   double retracement = EMPTY_VALUE;
   if(InpImpulseHighShift < rates_total && InpWashoutLowShift < rates_total && InpImpulseStartShift < rates_total)
   {
      double impulseBase = close[InpImpulseStartShift];
      double impulseTop = high[InpImpulseHighShift];
      double impulseRange = impulseTop - impulseBase;
      if(impulseRange > 0.0)
      {
         retracement = (impulseTop - low[InpWashoutLowShift]) / impulseRange;
         DrawHLine(PREFIX + "RETRACE_0618", impulseTop - impulseRange * 0.618, clrSlateBlue, 1);
         DrawHLine(PREFIX + "RETRACE_0786", impulseTop - impulseRange * 0.786, clrSlateBlue, 1);
         DrawHLine(PREFIX + "RETRACE_0886", impulseTop - impulseRange * 0.886, clrOrangeRed, 1);
      }
   }

   string state = "STATE_PROFILE_READY";
   string pocRelation = RelationToLevel(close[0], poc, _Point * 3.0);
   string avwapRelation = "not_available";
   if(avwapZone != EMPTY_VALUE)
      avwapRelation = RelationToLevel(close[0], avwapZone, _Point * 3.0);

   int pocAboveBars = CountConsecutiveClosesAbove(close, poc, rates_total, InpRelationLookbackBars);
   int avwapAboveBars = 0;
   if(avwapZone != EMPTY_VALUE)
      avwapAboveBars = CountConsecutiveClosesAbove(close, avwapZone, rates_total, InpRelationLookbackBars);
   bool pocRejectedRecently = WasRejectedRecently(high, close, poc, rates_total, InpRelationLookbackBars);
   bool avwapRejectedRecently = false;
   if(avwapZone != EMPTY_VALUE)
      avwapRejectedRecently = WasRejectedRecently(high, close, avwapZone, rates_total, InpRelationLookbackBars);

   DrawLabel(PREFIX + "STATUS",
             "FCZ Observer MVP\n" +
             "POC: " + DoubleToString(poc, _Digits) + " (" + pocRelation + ")\n" +
             "POC position: " + DoubleToString(pocPositionRatio, 3) + "\n" +
             "POC above bars: " + IntegerToString(pocAboveBars) + " rejected_recently=" + BoolText(pocRejectedRecently) + "\n" +
             "VAH/VAL: " + DoubleToString(vah, _Digits) + " / " + DoubleToString(val, _Digits) + "\n" +
             "AVWAP ZoneStart: " + ValueText(avwapZone) + " (" + avwapRelation + ")\n" +
             "AVWAP above bars: " + IntegerToString(avwapAboveBars) + " rejected_recently=" + BoolText(avwapRejectedRecently) + "\n" +
             "Retracement: " + ValueText(retracement) + "\n" +
             "State: " + state + "\n" +
             "Allowed: observe_only");

   if(InpExportCSV)
      ExportLatest(_Symbol, EnumToString(_Period), time[0], fczHigh, fczLow, fczBars,
                   poc, vah, val, InpProfileBins, pocPositionRatio, totalVol,
                   pocAboveBars, avwapAboveBars, pocRejectedRecently, avwapRejectedRecently,
                   avwapZone, avwapImpulse, retracement, pocRelation, avwapRelation, state);

   return(rates_total);
}

double CalcAVWAP(int fromShift, int toShift,
                 const double &high[], const double &low[], const double &close[],
                 const long &tick_volume[], int rates_total)
{
   double pv = 0.0;
   double vol = 0.0;
   int from = MathMin(fromShift, rates_total - 1);
   int to = MathMax(toShift, 0);
   for(int i = to; i <= from; i++)
   {
      double typical = (high[i] + low[i] + close[i]) / 3.0;
      double v = (double)tick_volume[i];
      pv += typical * v;
      vol += v;
   }
   if(vol <= 0.0)
      return(EMPTY_VALUE);
   return(pv / vol);
}

void DrawRect(string name, datetime t1, double p1, datetime t2, double p2, color clr)
{
   if(ObjectFind(0, name) < 0)
      ObjectCreate(0, name, OBJ_RECTANGLE, 0, t1, p1, t2, p2);
   ObjectSetInteger(0, name, OBJPROP_COLOR, clr);
   ObjectSetInteger(0, name, OBJPROP_BACK, true);
   ObjectSetInteger(0, name, OBJPROP_FILL, false);
   ObjectMove(0, name, 0, t1, p1);
   ObjectMove(0, name, 1, t2, p2);
}

void DrawHLine(string name, double price, color clr, int width)
{
   if(ObjectFind(0, name) < 0)
      ObjectCreate(0, name, OBJ_HLINE, 0, 0, price);
   ObjectSetDouble(0, name, OBJPROP_PRICE, price);
   ObjectSetInteger(0, name, OBJPROP_COLOR, clr);
   ObjectSetInteger(0, name, OBJPROP_WIDTH, width);
}

void DrawLabel(string name, string text)
{
   if(!InpShowDebugText)
      return;
   if(ObjectFind(0, name) < 0)
      ObjectCreate(0, name, OBJ_LABEL, 0, 0, 0);
   ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_RIGHT_UPPER);
   ObjectSetInteger(0, name, OBJPROP_XDISTANCE, 20);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE, 20);
   ObjectSetInteger(0, name, OBJPROP_COLOR, clrWhite);
   ObjectSetString(0, name, OBJPROP_TEXT, text);
}

string ValueText(double value)
{
   if(value == EMPTY_VALUE)
      return("NA");
   return(DoubleToString(value, _Digits));
}

string RelationToLevel(double price, double level, double tolerance)
{
   if(level == EMPTY_VALUE)
      return("not_available");
   if(MathAbs(price - level) <= tolerance)
      return("touch");
   if(price > level)
      return("reclaimed");
   return("below");
}

int CountConsecutiveClosesAbove(const double &close[], double level, int rates_total, int maxBars)
{
   if(level == EMPTY_VALUE || rates_total <= 0 || maxBars <= 0)
      return(0);
   int limit = MathMin(maxBars, rates_total);
   int count = 0;
   for(int i = 0; i < limit; i++)
   {
      if(close[i] > level)
         count++;
      else
         break;
   }
   return(count);
}

bool WasRejectedRecently(const double &high[], const double &close[], double level, int rates_total, int lookbackBars)
{
   if(level == EMPTY_VALUE || rates_total <= 0 || lookbackBars <= 0)
      return(false);
   if(close[0] >= level)
      return(false);
   int limit = MathMin(lookbackBars, rates_total);
   for(int i = 0; i < limit; i++)
   {
      if(high[i] >= level && close[i] < level)
         return(true);
   }
   return(false);
}

string BoolText(bool value)
{
   return(value ? "true" : "false");
}

void ExportLatest(string symbol, string timeframe, datetime sampleTime,
                  double fczHigh, double fczLow, int fczBars, double poc, double vah, double val,
                  int profileBinCount, double pocPositionRatio, long zoneTickVolumeSum,
                  int pocAboveBars, int avwapAboveBars, bool pocRejectedRecently, bool avwapRejectedRecently,
                  double avwapZone, double avwapImpulse, double retracement,
                  string pocRelation, string avwapRelation, string state)
{
   string fileName = "FCZ_Observer_latest.csv";
   int handle = FileOpen(fileName, FILE_WRITE | FILE_CSV | FILE_ANSI);
   if(handle == INVALID_HANDLE)
      return;

   FileWrite(handle,
             "symbol", "timeframe", "sample_time", "fcz_high", "fcz_low",
             "fcz_bars", "poc_level", "vah_level", "val_level", "profile_bin_count",
             "poc_position_ratio", "zone_tick_volume_sum", "poc_above_bars",
             "avwap_above_bars", "poc_rejected_recently", "avwap_rejected_recently", "avwap_zonestart",
             "avwap_impulsestart", "retracement_ratio", "poc_relation",
             "avwap_relation", "current_state", "allowed_mode",
             "positive_evidence", "negative_evidence", "missing_evidence");

   FileWrite(handle,
             symbol, timeframe, TimeToString(sampleTime, TIME_DATE | TIME_MINUTES),
             DoubleToString(fczHigh, _Digits), DoubleToString(fczLow, _Digits),
             IntegerToString(fczBars), DoubleToString(poc, _Digits), DoubleToString(vah, _Digits), DoubleToString(val, _Digits),
             IntegerToString(profileBinCount), DoubleToString(pocPositionRatio, 6), IntegerToString(zoneTickVolumeSum),
             IntegerToString(pocAboveBars), IntegerToString(avwapAboveBars), BoolText(pocRejectedRecently), BoolText(avwapRejectedRecently),
             ValueText(avwapZone), ValueText(avwapImpulse), ValueText(retracement),
             pocRelation, avwapRelation, state, "observe_only",
             "manual_fcz_and_profile_ready", "thresholds_not_validated", "manual_chart_review_required");

   FileClose(handle);
}
