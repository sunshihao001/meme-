//+------------------------------------------------------------------+
//|                                                       FIB_OB.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include  <Trade/Trade.mqh>
CTrade trade;

#define BullOB clrLime
#define BearOB clrRed

//+------------------------------------------------------------------+
//|                           Global vars                            |
//+------------------------------------------------------------------+
double Lots = 0.01;
int takeProfit = 170;
//int stopLoss = 200;
int length = 100;

input double stopLoss = 350;
input double Mgtn = 00.85;

bool isBullishOB = false; 
bool isBearishOB = false;

input int Time1Hstrt = 3;
input int Time1Hend = 4;

class COrderBlock : public CObject {
public:
   int direction;
   datetime time;//[]
   double high;
   double low;
   
   void draw(datetime tmS, datetime tmE, color clr){
      string objOB = " OB REC" + TimeToString(time);
      ObjectCreate( 0, objOB, OBJ_RECTANGLE, 0, time, low, tmS, high);
      ObjectSetInteger( 0, objOB, OBJPROP_FILL, true);
      ObjectSetInteger( 0, objOB, OBJPROP_COLOR, clr);
      
      string objtrade = " OB trade" + TimeToString(time);
      ObjectCreate( 0, objtrade, OBJ_RECTANGLE, 0, tmS, high, tmE, low); // trnary operator
      ObjectSetInteger( 0, objtrade, OBJPROP_FILL, true);
      ObjectSetInteger( 0, objtrade, OBJPROP_COLOR, clr);
   }  
};


COrderBlock* OB;
color OBClr;
datetime T1;
datetime T2;
//+------------------------------------------------------------------+
//|               Defines, includes, & variables                     |
//+------------------------------------------------------------------+
#define FIBO_OBJ "Fibo Retracement"
MqlTick currentTick;
long MagicNumber = 76543;
int TotalBars;

//+------------------------------------------------------------------+
//|                          fibo vars                               |
//+------------------------------------------------------------------+
double Fib_Trade_lvls = 61.8;

double fib_low, fib_high;
datetime fib_t1, fib_t2;




//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit(){
   trade.SetExpertMagicNumber(MagicNumber);

   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason){

   
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(){
  
    if(isNewBar()){
      getOrderB();
      getSwings();
      double Bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      double Ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
      
      if(CheckPointer(OB) != POINTER_INVALID  && OB.direction > 0 && Ask < OB.high){
         
         double entry = Ask;
         double tp = getHigh(iHighest(_Symbol, PERIOD_CURRENT, MODE_HIGH, iBarShift(_Symbol, PERIOD_CURRENT, OB.time)));
         double sl = NormalizeDouble(OB.low - Mgtn, _Digits);
        // double sl = getLow(iLowest(_Symbol, PERIOD_CURRENT, MODE_LOW, 2,iBarShift(_Symbol, PERIOD_CURRENT, OB.time)));
         
         ObjectCreate( 0, FIBO_OBJ, OBJ_FIBO, 0, fib_t1, fib_low, fib_t2, fib_high);
         
         double entLvl = fib_high - (fib_high - fib_low) * Fib_Trade_lvls / 100; // check this if non
         
         if(OB.high <= entLvl){
            T2  = getTime(0);
            OB.draw(T1, T2, OBClr);
            trade.Buy(Lots, _Symbol, entry, sl, tp, "OB buy");
            delete OB;
         }else{
            delete OB;
         }
         
      }
      if(CheckPointer(OB) != POINTER_INVALID && OB.direction < 0 && Bid > OB.low){
         
         double entry = Bid;
         double tp = getLow(iLowest(_Symbol, PERIOD_CURRENT, MODE_LOW, iBarShift(_Symbol, PERIOD_CURRENT, OB.time)));
         double sl = NormalizeDouble(OB.high + Mgtn, _Digits);
        // double sl = getHigh(iHighest(_Symbol, PERIOD_CURRENT, MODE_HIGH, iBarShift(_Symbol, PERIOD_CURRENT, OB.time)));
         
         ObjectCreate( 0, FIBO_OBJ, OBJ_FIBO, 0, fib_t2, fib_high, fib_t1, fib_low);
         
         double entLvl = fib_low + (fib_low - fib_high) * Fib_Trade_lvls / 100;
         
         if(OB.low >= entLvl){
            T2 = getTime(0);
            OB.draw(T1, T2, OBClr);
            trade.Sell(Lots, _Symbol, entry, sl, tp, "OB sell");
            delete OB;
         }else{
            delete OB;
         }
         
      }
      ObjectSetInteger( 0, FIBO_OBJ, OBJPROP_COLOR, clrBlack);
      
      for(int i = 0; i < ObjectGetInteger( 0, FIBO_OBJ, OBJPROP_LEVELS); i++){
         ObjectSetInteger( 0, FIBO_OBJ, OBJPROP_LEVELCOLOR, i, clrBlack);
      }
    }
   
}
//+------------------------------------------------------------------+

// function to get the swing points 
void getSwings(){
   
   const int len = 5;
   int left_bars, right_bars;
   int bar_Now = len;
   bool isSwingH = true, isSwingL = true;   
   
   for(int i = 1; i <= len; i++){
      right_bars = bar_Now - i;
      left_bars = bar_Now + i;
      
      if((getHigh(bar_Now) <= getHigh(right_bars)) ||(getHigh(bar_Now) < getHigh(left_bars))){
         isSwingH = false;
      }
      
      if((getLow(bar_Now) >= getLow(right_bars)) || getLow(bar_Now) > getLow(left_bars)){
         isSwingL = false;
      }
      if(isSwingH){
         Print("We have a swing high at index: ", bar_Now, "at price: ", getHigh(bar_Now));
         fib_high = getHigh(bar_Now);
         fib_t1 = getTime(bar_Now);
      }
      if(isSwingL){
         Print("We have a swing low at index: ", bar_Now," at price: ", getLow(bar_Now));
         fib_low = getLow(bar_Now);
         fib_t2 = getTime(bar_Now);
      }
      
   }   
}

//+------------------------------------------------------------------+
//|                      Function to find OB                         |
//+------------------------------------------------------------------+
void getOrderB(){

   static int prevDay = 0;
   
   MqlDateTime structTime;
   TimeCurrent(structTime);
   structTime.min = 0;
   structTime.sec = 0;
   
   structTime.hour = Time1Hstrt;
   datetime timestrt = StructToTime(structTime);
   
   structTime.hour = Time1Hend;
   datetime timend = StructToTime(structTime);

   if(TimeCurrent() >= timestrt && TimeCurrent() < timend){
      if(prevDay != structTime.day_of_year){
         delete OB;
         
         for(int i = 1; i < 100; i++){
            if(getOpen(i) < getClose(i)){ // index is i since the loop starts from i which is = 1 "for(int i = 1)..."
               if(getOpen(i + 2) < getClose(i + 2)){
                  if(getOpen(i + 3) > getClose(i + 3) && getOpen(i + 3) < getClose(i + 2)){
                     Print("Bullish Order Block confirmed at: ", TimeToString(getTime(i + 2), TIME_DATE||TIME_MINUTES));
                     //isBullishOB = true;
                     OB = new COrderBlock();
                     OB.direction = 1;
                     OB.time = getTime(i + 3);
                     OB.high = getHigh(i + 3);
                     OB.low = getLow(i + 3);
                     isBullishOB = true;
                     
                     OBClr = isBullishOB ? BullOB : BearOB;
                     
                     // specify strt time
                     T1 = OB.time;
                     
                     // reset BULL OB flag
                     isBullishOB = false;
                     prevDay = structTime.day_of_year;
                     break;
                     
                     delete OB;
                  }
               }
            }
            if(getOpen(i) > getClose(i)){
               if(getOpen(i + 2) > getClose(i + 2)){
                  if(getOpen(i + 3) < getClose(i + 3) && getOpen(i + 3) < getClose(i + 2)){
                     Print("Bearish Order Block confirmed at: ", TimeToString(getTime(i + 2), TIME_DATE||TIME_MINUTES));
                     //isBearishOB = true;
                     OB = new COrderBlock();
                     OB.direction = -1;
                     OB.time = getTime(i + 3);
                     OB.high = getHigh(i + 3);
                     OB.low = getLow(i + 3);
                     isBearishOB = true;
                     
                     OBClr = isBearishOB ? BearOB : BullOB;
                     
                     T1 = OB.time;
                     
                     // reset the BEAR OB flag
                     isBearishOB = false;
                     prevDay = structTime.day_of_year;
                     break;
                     
                     delete OB;
                  }
               }
            }
         }
      }
   }
}

bool isNewBar() {
   // Memorize the time of opening of the last bar in the static variable
   static datetime last_time = 0;
   
   // Get current time
   datetime lastbar_time = (datetime)SeriesInfoInteger(Symbol(), Period(), SERIES_LASTBAR_DATE);

   // First call
   if (last_time == 0) {
      last_time = lastbar_time;
      return false;
   }

   // If the time differs (new bar)
   if (last_time != lastbar_time) {
      last_time = lastbar_time;
      return true;
   }

   // If no new bar, return false
   return false;
}

double getHigh(int index) {
    return iHigh(_Symbol, _Period, index);
}

double getLow(int index) {
    return iLow(_Symbol, _Period, index);
}

double getOpen(int index){
   return iOpen(_Symbol, _Period, index);
}

double getClose(int index){
   return iClose(_Symbol, _Period, index);
}

datetime getTime(int index) {
    return iTime(_Symbol, _Period, index);
}



