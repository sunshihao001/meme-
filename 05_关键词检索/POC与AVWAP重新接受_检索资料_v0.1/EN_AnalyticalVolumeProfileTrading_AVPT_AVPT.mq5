//+------------------------------------------------------------------+
//|                                                         AVPT.mq5 |
//|                        GIT under Copyright 2025, MetaQuotes Ltd. |
//|                     https://www.mql5.com/en/users/johnhlomohang/ |
//+------------------------------------------------------------------+
#property copyright "GIT under Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com/en/users/johnhlomohang/"
#property version   "1.00"
#include <Trade/Trade.mqh>


//+------------------------------------------------------------------+
//| Input Parameters                                                |
//+------------------------------------------------------------------+
input group "=== Volume Profile Settings ==="
input int      VP_LookbackBars = 500;        // Volume Profile Lookback Bars
input double   VA_Percentage = 70.0;         // Value Area Percentage
input double   HVN_Threshold = 1.5;          // HVN Volume Threshold (x median)
input double   LVN_Threshold = 0.3;          // LVN Volume Threshold (x median)

input group "=== Trading Settings ==="
input double   LotSize = 0.1;                // Trade Lot Size
input bool     UseAtrSL = true;              // Use ATR for Stop Loss
input double   AtrMultiplier = 2.0;          // ATR Multiplier for SL
input int      AtrPeriod = 14;               // ATR Period
input double   RiskRewardRatio = 1.5;        // Risk/Reward Ratio
input bool     UseTrailingStop = true;       // Enable Trailing Stop
input double   TrailingStep = 0.0010;        // Trailing Stop Step

input group "=== Strategy Settings ==="
input bool     EnableReversion = true;       // Enable Reversion Strategy
input bool     EnableBreakout = false;       // Enable Breakout Strategy
input int      MinBarsBetweenTrades = 3;     // Minimum Bars Between Trades

//+------------------------------------------------------------------+
//| Enumerations                                                     |
//+------------------------------------------------------------------+
enum ENUM_LEVEL_POSITION{
   BELOW,
   ABOVE
};

enum ENUM_DIRECTION{
   UP,
   DOWN
};

//+------------------------------------------------------------------+
//| Global Variables                                                 |
//+------------------------------------------------------------------+
CTrade trade;

// Volume Profile Arrays
double volumeProfile[];
double priceLevels[];
int profileBins;

// Key Levels
double pocPrice;
double vahPrice;
double valPrice;
double hvnLevels[];
double lvnLevels[];

// Trading
datetime lastTradeTime;
int atrHandle;
double currentAtr;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
    // Initialize ATR indicator
    atrHandle = iATR(_Symbol, _Period, AtrPeriod);
    if(atrHandle == INVALID_HANDLE)
    {
        Print("Error creating ATR indicator");
        return(INIT_FAILED);
    }
    
    // Initialize volume profile arrays
    InitializeVolumeProfile();
    
    // Set up timer for periodic updates
    EventSetTimer(60); // Update every minute
    
    return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    IndicatorRelease(atrHandle);
    EventKillTimer();
    CleanUpChartObjects();
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
    // Update ATR value
    UpdateAtrValue();
    
    // Update volume profile every new bar
    if(IsNewBar())
    {
        UpdateVolumeProfile();
        CalculateKeyLevels();
        UpdateChartObjects();
        
        // Check for trading signals
        CheckTradingSignals();
    }
    
    // Manage open positions
    ManagePositions();
}

//+------------------------------------------------------------------+
//| Volume Profile Engine                                           |
//+------------------------------------------------------------------+
void InitializeVolumeProfile()
{
    profileBins = 200; // Number of price bins
    ArrayResize(volumeProfile, profileBins);
    ArrayResize(priceLevels, profileBins);
    ArrayInitialize(volumeProfile, 0);
}

void UpdateVolumeProfile()
{
    // Clear previous profile
    ArrayInitialize(volumeProfile, 0);
    
    // Get price range for current lookback
    double highPrice = GetHighestPrice(VP_LookbackBars);
    double lowPrice = GetLowestPrice(VP_LookbackBars);
    double priceRange = highPrice - lowPrice;
    double binSize = priceRange / profileBins;
    
    // Initialize price levels
    for(int i = 0; i < profileBins; i++)
    {
        priceLevels[i] = lowPrice + (i * binSize);
    }
    
    // Distribute volume across price bins
    for(int bar = 0; bar < VP_LookbackBars; bar++)
    {
        double open = iOpen(_Symbol, _Period, bar);
        double high = iHigh(_Symbol, _Period, bar);
        double low = iLow(_Symbol, _Period, bar);
        double close = iClose(_Symbol, _Period, bar);
        long volume = iVolume(_Symbol, _Period, bar);
        
        DistributeVolumeToBins(open, high, low, close, volume, lowPrice, binSize);
    }
}

void DistributeVolumeToBins(double open, double high, double low, double close, 
                           long volume, double basePrice, double binSize)
{
    double bodyLow = MathMin(open, close);
    double bodyHigh = MathMax(open, close);
    
    for(int i = 0; i < profileBins; i++)
    {
        double binLow = basePrice + (i * binSize);
        double binHigh = binLow + binSize;
        
        // Check if price bin was touched by this candle
        if(!(high < binLow || low > binHigh))
        {
            // Weight volume by time spent in price zone (simplified)
            double overlap = MathMin(high, binHigh) - MathMax(low, binLow);
            double candleRange = high - low;
            
            if(candleRange > 0)
            {
                double weight = overlap / candleRange;
                // Additional weight for body area
                if(binLow <= bodyHigh && binHigh >= bodyLow)
                {
                    double bodyOverlap = MathMin(bodyHigh, binHigh) - MathMax(bodyLow, binLow);
                    weight += (bodyOverlap / candleRange) * 0.3;
                }
                
                volumeProfile[i] += volume * weight;
            }
        }
    }
}

//+------------------------------------------------------------------+
//| Key Levels Calculation                                           |
//+------------------------------------------------------------------+
void CalculateKeyLevels()
{
    CalculatePOC();
    CalculateValueArea();
    CalculateHVNLVN();
}

void CalculatePOC()
{
    double maxVolume = 0;
    int pocIndex = 0;
    
    for(int i = 0; i < profileBins; i++)
    {
        if(volumeProfile[i] > maxVolume)
        {
            maxVolume = volumeProfile[i];
            pocIndex = i;
        }
    }
    
    pocPrice = priceLevels[pocIndex];
}

void CalculateValueArea()
{
    double totalVolume = 0;
    for(int i = 0; i < profileBins; i++)
    {
        totalVolume += volumeProfile[i];
    }
    
    double targetVolume = totalVolume * (VA_Percentage / 100.0);
    int pocIndex = FindPriceIndex(pocPrice);
    
    double currentVolume = volumeProfile[pocIndex];
    int upperIndex = pocIndex;
    int lowerIndex = pocIndex;
    
    while(currentVolume < targetVolume && (upperIndex < profileBins - 1 || lowerIndex > 0))
    {
        bool canExpandUp = (upperIndex < profileBins - 1);
        bool canExpandDown = (lowerIndex > 0);
        
        double upVolume = canExpandUp ? volumeProfile[upperIndex + 1] : 0;
        double downVolume = canExpandDown ? volumeProfile[lowerIndex - 1] : 0;
        
        if(upVolume > downVolume && canExpandUp)
        {
            upperIndex++;
            currentVolume += upVolume;
        }
        else if(canExpandDown)
        {
            lowerIndex--;
            currentVolume += downVolume;
        }
        else if(canExpandUp)
        {
            upperIndex++;
            currentVolume += upVolume;
        }
    }
    
    vahPrice = priceLevels[upperIndex];
    valPrice = priceLevels[lowerIndex];
}

void CalculateHVNLVN()
{
    ArrayResize(hvnLevels, 0);
    ArrayResize(lvnLevels, 0);
    
    // Calculate median volume
    double tempVolumes[];
    ArrayCopy(tempVolumes, volumeProfile);
    ArraySort(tempVolumes);
    double medianVolume = tempVolumes[profileBins / 2];
    
    double hvnThreshold = medianVolume * HVN_Threshold;
    double lvnThreshold = medianVolume * LVN_Threshold;
    
    for(int i = 0; i < profileBins; i++)
    {
        if(volumeProfile[i] >= hvnThreshold)
        {
            int size = ArraySize(hvnLevels);
            ArrayResize(hvnLevels, size + 1);
            hvnLevels[size] = priceLevels[i];
        }
        else if(volumeProfile[i] <= lvnThreshold && volumeProfile[i] > 0)
        {
            int size = ArraySize(lvnLevels);
            ArrayResize(lvnLevels, size + 1);
            lvnLevels[size] = priceLevels[i];
        }
    }
}

//+------------------------------------------------------------------+
//| Trading Signal Logic                                             |
//+------------------------------------------------------------------+
void CheckTradingSignals()
{
    if(!IsTradeAllowed()) return;
    
    // Check minimum bars between trades
    if(Bars(_Symbol, _Period, lastTradeTime, TimeCurrent()) < MinBarsBetweenTrades) 
        return;
    
    double currentPrice = SymbolInfoDouble(_Symbol, SYMBOL_LAST);
    
    if(EnableReversion)
    {
        CheckReversionSignals(currentPrice);
    }
    
    if(EnableBreakout)
    {
        CheckBreakoutSignals(currentPrice);
    }
}

void CheckReversionSignals(double currentPrice)
{
    MqlRates currentRates[];
    CopyRates(_Symbol, _Period, 0, 3, currentRates);
    
    // Buy signal: Price rejects VAL with bullish confirmation
    if(IsNearLevel(currentPrice, valPrice) && 
       IsBullishRejection(currentRates))
    {
        double sl = FindNearestLVN(BELOW);
        double tp = pocPrice;
        OpenTrade(ORDER_TYPE_BUY, sl, tp);
    }
    
    // Sell signal: Price rejects VAH with bearish confirmation
    if(IsNearLevel(currentPrice, vahPrice) && 
       IsBearishRejection(currentRates))
    {
        double sl = FindNearestLVN(ABOVE);
        double tp = pocPrice;
        OpenTrade(ORDER_TYPE_SELL, sl, tp);
    }
}

void CheckBreakoutSignals(double currentPrice)
{
    // Breakout above VAH with confirmation
    if(currentPrice > vahPrice && IsBreakoutConfirmed(UP))
    {
        double sl = FindNearestHVN(BELOW);
        double tp = CalculateBreakoutTP(UP);
        OpenTrade(ORDER_TYPE_BUY, sl, tp);
    }
    
    // Breakout below VAL with confirmation
    if(currentPrice < valPrice && IsBreakoutConfirmed(DOWN))
    {
        double sl = FindNearestHVN(ABOVE);
        double tp = CalculateBreakoutTP(DOWN);
        OpenTrade(ORDER_TYPE_SELL, sl, tp);
    }
}

//+------------------------------------------------------------------+
//| Trade Execution & Risk Management                                |
//+------------------------------------------------------------------+
void OpenTrade(ENUM_ORDER_TYPE type, double sl, double tp)
{
    double price = (type == ORDER_TYPE_BUY) ? SymbolInfoDouble(_Symbol, SYMBOL_ASK) 
                                           : SymbolInfoDouble(_Symbol, SYMBOL_BID);
    
    if(UseAtrSL)
    {
        double atrSl = currentAtr * AtrMultiplier;
        sl = (type == ORDER_TYPE_BUY) ? price - atrSl : price + atrSl;
        
        // Calculate TP based on risk/reward
        double risk = MathAbs(price - sl);
        tp = (type == ORDER_TYPE_BUY) ? price + (risk * RiskRewardRatio) 
                                     : price - (risk * RiskRewardRatio);
    }
    
    // Execute trade using CTrade
    if(trade.PositionOpen(_Symbol, type, LotSize, price, sl, tp, "VolumeProfileEA"))
    {
        lastTradeTime = iTime(_Symbol, _Period, 0);
        Print("Trade executed: ", EnumToString(type), " Price: ", price, " SL: ", sl, " TP: ", tp);
    }
    else
    {
        Print("Trade failed: ", trade.ResultRetcodeDescription());
    }
}

void ManagePositions()
{
    for(int i = PositionsTotal() - 1; i >= 0; i--)
    {
        ulong ticket = PositionGetTicket(i);
        if(PositionSelectByTicket(ticket) && PositionGetString(POSITION_COMMENT) == "VolumeProfileEA")
        {
            if(UseTrailingStop)
            {
                ApplyTrailingStop(ticket);
            }
            
            // Check exit condition: price re-enters Value Area
            if(ShouldExitEarly(ticket))
            {
                ClosePosition(ticket);
            }
        }
    }
}

void ApplyTrailingStop(ulong ticket)
{
    if(PositionSelectByTicket(ticket))
    {
        double currentPrice = SymbolInfoDouble(_Symbol, SYMBOL_LAST);
        double currentSL = PositionGetDouble(POSITION_SL);
        ENUM_POSITION_TYPE type = (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
        
        double newSL = currentSL;
        double point = SymbolInfoDouble(_Symbol, SYMBOL_POINT);
        
        if(type == POSITION_TYPE_BUY)
        {
            newSL = currentPrice - (currentAtr * TrailingStep);
            if(newSL > currentSL + point && newSL < currentPrice - point)
            {
                if(trade.PositionModify(ticket, newSL, PositionGetDouble(POSITION_TP)))
                {
                    Print("Trailing SL updated for BUY: ", newSL);
                }
            }
        }
        else if(type == POSITION_TYPE_SELL)
        {
            newSL = currentPrice + (currentAtr * TrailingStep);
            if(newSL < currentSL - point && newSL > currentPrice + point)
            {
                if(trade.PositionModify(ticket, newSL, PositionGetDouble(POSITION_TP)))
                {
                    Print("Trailing SL updated for SELL: ", newSL);
                }
            }
        }
    }
}

void ClosePosition(ulong ticket)
{
    if(PositionSelectByTicket(ticket))
    {
        ENUM_POSITION_TYPE type = (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
        double volume = PositionGetDouble(POSITION_VOLUME);
        
        if(type == POSITION_TYPE_BUY)
        {
            trade.PositionClose(ticket);
        }
        else if(type == POSITION_TYPE_SELL)
        {
            trade.PositionClose(ticket);
        }
        
        Print("Position closed early: ", ticket);
    }
}

//+------------------------------------------------------------------+
//| Missing Functions Implementation                                |
//+------------------------------------------------------------------+
bool IsTradeAllowed()
{
    // Check if trading is allowed
    if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED))
    {
        Print("Trading not allowed in terminal");
        return false;
    }
    
    if(!SymbolInfoInteger(_Symbol, SYMBOL_TRADE_MODE))
    {
        Print("Trading not allowed for symbol");
        return false;
    }
    
    // Check account balance and margin
    double balance = AccountInfoDouble(ACCOUNT_BALANCE);
    double margin = AccountInfoDouble(ACCOUNT_MARGIN);
    double freeMargin = AccountInfoDouble(ACCOUNT_MARGIN_FREE);
    
    if(freeMargin < LotSize * 1000) // Simple margin check
    {
        Print("Insufficient margin");
        return false;
    }
    
    return true;
}

bool IsNearLevel(double price, double level, double thresholdPercent = 0.001)
{
    double threshold = level * thresholdPercent;
    return MathAbs(price - level) <= threshold;
}

bool IsBullishRejection(MqlRates &rates[])
{
    if(ArraySize(rates) < 3) return false;
    
    // Check for bullish rejection patterns (hammer, doji, etc.)
    MqlRates current = rates[0];
    MqlRates prev = rates[1];
    
    // Hammer pattern
    bool isHammer = (current.close > current.open) && 
                   ((current.close - current.open) * 2 < (current.high - current.low)) &&
                   (current.close > (current.high + current.low) / 2);
    
    // Bullish engulfing
    bool isBullishEngulfing = (current.close > prev.open) && 
                             (current.open < prev.close) &&
                             (current.close > prev.high) &&
                             (current.open < prev.low);
    
    return isHammer || isBullishEngulfing || (current.close > current.open && prev.close < prev.open);
}

bool IsBearishRejection(MqlRates &rates[])
{
    if(ArraySize(rates) < 3) return false;
    
    // Check for bearish rejection patterns (shooting star, etc.)
    MqlRates current = rates[0];
    MqlRates prev = rates[1];
    
    // Shooting star pattern
    bool isShootingStar = (current.close < current.open) && 
                         ((current.open - current.close) * 2 < (current.high - current.low)) &&
                         (current.close < (current.high + current.low) / 2);
    
    // Bearish engulfing
    bool isBearishEngulfing = (current.close < prev.open) && 
                             (current.open > prev.close) &&
                             (current.close < prev.low) &&
                             (current.open > prev.high);
    
    return isShootingStar || isBearishEngulfing || (current.close < current.open && prev.close > prev.open);
}

double FindNearestLVN(ENUM_LEVEL_POSITION position)
{
    double currentPrice = SymbolInfoDouble(_Symbol, SYMBOL_LAST);
    double nearestLVN = 0;
    double minDistance = DBL_MAX;
    
    for(int i = 0; i < ArraySize(lvnLevels); i++)
    {
        double distance = MathAbs(lvnLevels[i] - currentPrice);
        
        if(position == BELOW && lvnLevels[i] < currentPrice)
        {
            if(distance < minDistance)
            {
                minDistance = distance;
                nearestLVN = lvnLevels[i];
            }
        }
        else if(position == ABOVE && lvnLevels[i] > currentPrice)
        {
            if(distance < minDistance)
            {
                minDistance = distance;
                nearestLVN = lvnLevels[i];
            }
        }
    }
    
    // If no LVN found, use ATR-based distance
    if(nearestLVN == 0)
    {
        if(position == BELOW)
            nearestLVN = currentPrice - (currentAtr * 2);
        else
            nearestLVN = currentPrice + (currentAtr * 2);
    }
    
    return nearestLVN;
}

double FindNearestHVN(ENUM_LEVEL_POSITION position)
{
    double currentPrice = SymbolInfoDouble(_Symbol, SYMBOL_LAST);
    double nearestHVN = 0;
    double minDistance = DBL_MAX;
    
    for(int i = 0; i < ArraySize(hvnLevels); i++)
    {
        double distance = MathAbs(hvnLevels[i] - currentPrice);
        
        if(position == BELOW && hvnLevels[i] < currentPrice)
        {
            if(distance < minDistance)
            {
                minDistance = distance;
                nearestHVN = hvnLevels[i];
            }
        }
        else if(position == ABOVE && hvnLevels[i] > currentPrice)
        {
            if(distance < minDistance)
            {
                minDistance = distance;
                nearestHVN = hvnLevels[i];
            }
        }
    }
    
    // If no HVN found, use current price with buffer
    if(nearestHVN == 0)
    {
        if(position == BELOW)
            nearestHVN = currentPrice - (currentAtr * 1);
        else
            nearestHVN = currentPrice + (currentAtr * 1);
    }
    
    return nearestHVN;
}

bool IsBreakoutConfirmed(ENUM_DIRECTION direction)
{
    MqlRates rates[];
    CopyRates(_Symbol, _Period, 0, 2, rates);
    
    if(ArraySize(rates) < 2) return false;
    
    if(direction == UP)
    {
        // Check for consecutive closes above VAH
        return rates[0].close > vahPrice && rates[1].close > vahPrice;
    }
    else
    {
        // Check for consecutive closes below VAL
        return rates[0].close < valPrice && rates[1].close < valPrice;
    }
}

double CalculateBreakoutTP(ENUM_DIRECTION direction)
{
    double currentPrice = SymbolInfoDouble(_Symbol, SYMBOL_LAST);
    double vaHeight = vahPrice - valPrice;
    
    if(direction == UP)
    {
        return currentPrice + vaHeight;
    }
    else
    {
        return currentPrice - vaHeight;
    }
}

bool ShouldExitEarly(ulong ticket)
{
    if(PositionSelectByTicket(ticket))
    {
        double currentPrice = SymbolInfoDouble(_Symbol, SYMBOL_LAST);
        ENUM_POSITION_TYPE type = (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
        
        // Exit if price re-enters value area
        if(type == POSITION_TYPE_BUY && currentPrice <= vahPrice && currentPrice >= valPrice)
            return true;
            
        if(type == POSITION_TYPE_SELL && currentPrice <= vahPrice && currentPrice >= valPrice)
            return true;
    }
    
    return false;
}

//+------------------------------------------------------------------+
//| Visualization Module                                            |
//+------------------------------------------------------------------+
void UpdateChartObjects()
{
    CleanUpChartObjects();
    
    // Draw POC line
    DrawHorizontalLine("POC", pocPrice, clrRed, STYLE_SOLID, 2);
    
    // Draw Value Area
    DrawRectangle("VA", vahPrice, valPrice, clrGreen, 1, STYLE_DASH);
    
    // Draw HVN levels
    for(int i = 0; i < ArraySize(hvnLevels); i++)
    {
        //DrawHorizontalLine("HVN_" + IntegerToString(i), hvnLevels[i], clrBlue, STYLE_DOT, 1);
    }
    
    // Draw LVN levels
    for(int i = 0; i < ArraySize(lvnLevels); i++)
    {
        //DrawHorizontalLine("LVN_" + IntegerToString(i), lvnLevels[i], clrYellow, STYLE_DOT, 1);
    }
    
    // Add labels
    DrawTextLabel("VAH_Label", "VAH: " + DoubleToString(vahPrice, _Digits), vahPrice, clrWhite);
    DrawTextLabel("VAL_Label", "VAL: " + DoubleToString(valPrice, _Digits), valPrice, clrWhite);
    DrawTextLabel("POC_Label", "POC: " + DoubleToString(pocPrice, _Digits), pocPrice, clrWhite);
}

//+------------------------------------------------------------------+
//| Utility Functions                                               |
//+------------------------------------------------------------------+
bool IsNewBar()
{
    static datetime lastBar = 0;
    datetime currentBar = iTime(_Symbol, _Period, 0);
    
    if(currentBar != lastBar)
    {
        lastBar = currentBar;
        return true;
    }
    return false;
}

void UpdateAtrValue()
{
    double atr[1];
    if(CopyBuffer(atrHandle, 0, 0, 1, atr) > 0)
    {
        currentAtr = atr[0];
    }
}

double GetHighestPrice(int bars)
{
    double high = 0;
    for(int i = 0; i < bars; i++)
    {
        double barHigh = iHigh(_Symbol, _Period, i);
        if(barHigh > high) high = barHigh;
    }
    return high;
}

double GetLowestPrice(int bars)
{
    double low = DBL_MAX;
    for(int i = 0; i < bars; i++)
    {
        double barLow = iLow(_Symbol, _Period, i);
        if(barLow < low) low = barLow;
    }
    return low;
}

int FindPriceIndex(double price)
{
    for(int i = 0; i < profileBins; i++)
    {
        if(MathAbs(priceLevels[i] - price) < 0.00001)
            return i;
    }
    return -1;
}

//+------------------------------------------------------------------+
//| Drawing Functions                                               |
//+------------------------------------------------------------------+
void DrawHorizontalLine(string name, double price, color clr, ENUM_LINE_STYLE style, int width)
{
    ObjectCreate(0, name, OBJ_HLINE, 0, 0, price);
    ObjectSetInteger(0, name, OBJPROP_COLOR, clr);
    ObjectSetInteger(0, name, OBJPROP_STYLE, style);
    ObjectSetInteger(0, name, OBJPROP_WIDTH, width);
    ObjectSetInteger(0, name, OBJPROP_BACK, true);
}

void DrawRectangle(string name, double high, double low, color clr, int width, ENUM_LINE_STYLE style)
{
    ObjectCreate(0, name, OBJ_RECTANGLE, 0, iTime(_Symbol, _Period, VP_LookbackBars), high, 
                 iTime(_Symbol, _Period, 0), low);
    ObjectSetInteger(0, name, OBJPROP_COLOR, clr);
    ObjectSetInteger(0, name, OBJPROP_WIDTH, width);
    ObjectSetInteger(0, name, OBJPROP_STYLE, style);
    ObjectSetInteger(0, name, OBJPROP_BACK, true);
    ObjectSetInteger(0, name, OBJPROP_FILL, false);
}

void DrawTextLabel(string name, string text, double price, color clr)
{
    ObjectCreate(0, name, OBJ_TEXT, 0, iTime(_Symbol, _Period, VP_LookbackBars/2), price);
    ObjectSetString(0, name, OBJPROP_TEXT, text);
    ObjectSetInteger(0, name, OBJPROP_COLOR, clr);
    ObjectSetInteger(0, name, OBJPROP_ANCHOR, ANCHOR_LEFT_UPPER);
    ObjectSetInteger(0, name, OBJPROP_BACK, true);
}

void CleanUpChartObjects()
{
    ObjectsDeleteAll(0, "POC");
    ObjectsDeleteAll(0, "VA");
    ObjectsDeleteAll(0, "HVN_");
    ObjectsDeleteAll(0, "LVN_");
    ObjectsDeleteAll(0, "_Label");
}
//+------------------------------------------------------------------+
