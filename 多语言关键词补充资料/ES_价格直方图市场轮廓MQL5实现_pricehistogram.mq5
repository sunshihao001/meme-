//+------------------------------------------------------------------+
//|                                               PriceHistogram.mq5 |
//|                                      Copyright vdv_2001 Software |
//|                                                 vdv_2001@mail.ru |
//+------------------------------------------------------------------+
#property copyright "Dmitry Voronkov"
#property link      "vdv_2001@mail.ru"
#property version   "1.00"

#property description "The indicator «Price histogram» (Market profile)."
#property description "The indicator shows points where the market will be «most convenient» for a trade. "
#property description "It isn't recommended to use it as a separate tool, use it with the other indicators or oscillators."

#include "ClassExpert.mqh"
//The block of input parameters
input int         DayTheHistogram   = 10;          // Days for histogram
input int         DaysForCalculation= 500;         // Days for calculation(-1 all
input int        RangePercent      = 70;          // Percent range
input color       InnerRange        =Indigo;       // Inner range color
input color       OuterRange        =Magenta;      // Outer range color
input color       ControlPoint      =Orange;       // Point of Control (POC) color
input bool        ShowValue         =true;         // Show Values

// Class variable
CExpert ExtExpert;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
// Check for the symbol synchronisation before the beginning of calculations
   int err=0;
   while(!(bool)SeriesInfoInteger(Symbol(),0,SERIES_SYNCHRONIZED) && err<AMOUNT_OF_ATTEMPTS)
     {
      Sleep(500);
      err++;
     }
// Initialization of CExpert class
   ExtExpert.RangePercent=RangePercent;
   ExtExpert.InnerRange=InnerRange;
   ExtExpert.OuterRange=OuterRange;
   ExtExpert.ControlPoint=ControlPoint;
   ExtExpert.ShowValue=ShowValue;
   ExtExpert.DaysForCalculation=DaysForCalculation;
   ExtExpert.DayTheHistogram=DayTheHistogram;
   ExtExpert.Init();
   return(0);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   ExtExpert.Deinit(reason);
  }
//+------------------------------------------------------------------+
//| Expert Tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   ExtExpert.OnTick();
  }
//+------------------------------------------------------------------+
//| Expert Event function                                            |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,         // event identifier
                  const long& lparam,   // event parameter of long type
                  const double& dparam, // event parameter of double type
                  const string& sparam) // event parameter of string type
  {
   ExtExpert.OnEvent(id,lparam,dparam,sparam);
  }
//+------------------------------------------------------------------+
//| Expert Timer function                                            |
//+------------------------------------------------------------------+
void OnTimer()
  {
   ExtExpert.OnTimer();
  }
//+------------------------------------------------------------------+
