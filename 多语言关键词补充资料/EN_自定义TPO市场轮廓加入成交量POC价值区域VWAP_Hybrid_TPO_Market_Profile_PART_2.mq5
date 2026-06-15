//+------------------------------------------------------------------+
//|                             Hybrid TPO Market Profile PART 2.mq5 |
//|                           Copyright 2026, Allan Munene Mutiiria. |
//|                                   https://t.me/Forex_Algo_Trader |
//+------------------------------------------------------------------+
#property copyright "Copyright 2026, Allan Munene Mutiiria."
#property link "https://t.me/Forex_Algo_Trader"
#property version "1.00"
#property strict

#property indicator_chart_window
#property indicator_buffers 0
#property indicator_plots 0

//+------------------------------------------------------------------+
//| Enums                                                            |
//+------------------------------------------------------------------+
enum MarketProfileTimeframe { // Define market profile timeframe enum
   INTRADAY,                  // Intraday
   DAILY,                     // Daily
   WEEKLY,                    // Weekly
   MONTHLY,                   // Monthly
   FIXED                      // Fixed
};

enum TpoCharacterType {      // Define TPO character type enum
   SQUARE,                   // ■ Square
   CIRCLE,                   // ● Circle
   ALPHABETIC                // A-Za-z
};

enum MidpointAlgorithm {     // Define midpoint algorithm enum
   HIGH_LOW_MID,             // High/Low mid
   TPO_COUNT_BASED           // Number of TPOs
};

enum MarkPeriodOpens {       // Define mark period opens enum
   NONE,                     // No
   SWAP_CASE,                // Swap case
   USE_ZERO                  // Use '0'
};

enum TextSize {              // Define text size enum
   TINY,                     // Tiny
   SMALL,                    // Small
   NORMAL                    // Normal
};

//+------------------------------------------------------------------+
//| Inputs                                                           |
//+------------------------------------------------------------------+
sinput group "Settings"
input double ticksPerTpoLetter = 10;             // Ticks per letter
input bool highlightVolumeProfilePoc = true;     // Highlight POC based on VP?
input bool useVolumeProfilePocForValueArea = true; // Use VP POC for Value Area?
input bool highlightSessionVwap = false;         // Highlight session VWAP?
input bool showExtensionLines = false;           // Show extension lines?
input bool splitProfile = false;                 // Split MP?

sinput group "Time"
input MarketProfileTimeframe profileTimeframe = DAILY; // Timeframe
input string timezone = "Exchange";              // Timezone
input string dailySessionRange = "0830-1500";    // Daily session
input int intradayProfileLengthMinutes = 60;     // Profile length in minutes (Intraday)
input datetime fixedTimeRangeStart = D'2026.02.01 08:30'; // From (Fixed)
input datetime fixedTimeRangeEnd = D'2026.02.02 15:00'; // Till (Fixed)
input bool renderVolumes = true;                 // Render volume numbers? (Fixed)

sinput group "Rendering"
input TpoCharacterType tpoCharacterType = SQUARE; // TPO characters
input int valueAreaPercent = 70;                 // Value Area Percent
input int initialBalancePeriods = 2;             // IB periods
input int initialBalanceLineWidth = 2;           // IB line width
input int priceMarkerWidth = 2;                  // Price marker width
input int priceMarkerLength = 1;                 // Price marker length
input TextSize textSize = NORMAL;                // Font size
input MarkPeriodOpens markPeriodOpens = NONE;    // Mark period open?
input MidpointAlgorithm midpointAlgorithm = HIGH_LOW_MID; // Midpoint algo

sinput group "Colors"
input color defaultTpoColor = clrGray;           // Default
input color singlePrintColor = 0xd56a6a;         // Single Print
input color valueAreaColor = clrBlack;           // Value Area
input color pointOfControlColor = 0x3f7cff;      // POC
input color volumeProfilePocColor = 0x87c74c;    // VP POC
input color openColor = clrDodgerBlue;           // Open
input color closeColor = clrRed;                 // Close
input color initialBalanceHighlightColor = clrDodgerBlue; // IB
input color initialBalanceBackgroundColor = 0x606D79; // IB background
input color sessionVwapColor = 0xFF9925;         // Session VWAP
input color pocExtensionColor = 0x87c74c;        // POC extension
input color valueAreaHighExtensionColor = clrBlack; // VAH extension
input color valueAreaLowExtensionColor = clrBlack; // VAL extension
input color highExtensionColor = clrRed;         // High extension
input color lowExtensionColor = clrGreen;        // Low extension
input color midpointExtensionColor = 0x7649ff;   // Midpoint extension
input color fixedRangeBackgroundColor = 0x3179f5; // Fixed range background

//+------------------------------------------------------------------+
//| Constants                                                        |
//+------------------------------------------------------------------+
#define MAX_BARS_BACK 5000
#define TPO_CHARACTERS_STRING "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

//+------------------------------------------------------------------+
//| Structures                                                       |
//+------------------------------------------------------------------+
struct TpoPriceLevel {       // Define TPO price level structure
   double price;             // Store price level
   string tpoString;         // Store TPO string
   int tpoCount;             // Store TPO count
   double volume;            // Store volume
};

struct ProfileSessionData {  // Define profile session data structure
   datetime startTime;       // Store start time
   datetime endTime;         // Store end time
   double sessionOpen;       // Store session open price
   double sessionClose;      // Store session close price
   double sessionHigh;       // Store session high price
   double sessionLow;        // Store session low price
   double initialBalanceHigh;// Store initial balance high
   double initialBalanceLow; // Store initial balance low
   double vwap;              // Store VWAP
   int pointOfControlIndex;  // Store point of control index
   int volumeProfilePocIndex;// Store volume profile POC index
   TpoPriceLevel levels[];   // Store array of price levels
   int periodCount;          // Store period count
   double periodHighs[];     // Store array of period highs
   double periodLows[];      // Store array of period lows
   double periodOpens[];     // Store array of period opens
   double volumeProfilePrices[]; // Store array of volume profile prices
   double volumeProfileVolumes[]; // Store array of volume profile volumes
};

//+------------------------------------------------------------------+
//| Global Variables                                                 |
//+------------------------------------------------------------------+
string objectPrefix = "HTMP_";     //--- Set object prefix
ProfileSessionData sessions[];     //--- Declare sessions array
int activeSessionIndex = -1;       //--- Initialize active session index
double tpoPriceGridStep = 0;       //--- Initialize TPO price grid step
string tpoCharacterSet[];          //--- Declare TPO character set array
datetime previousBarTime = 0;      //--- Initialize previous bar time
datetime lastCompletedBarTime = 0; //--- Initialize last completed bar time
bool isNewSession = false;         //--- Initialize new session flag
int labelFontSize = 10;            //--- Set label font size
int maxSessionHistory = 20;        //--- Set maximum session history
int timezoneOffsetSeconds = 0;     //--- Initialize timezone offset in seconds

//+------------------------------------------------------------------+
//| Initialize custom indicator                                      |
//+------------------------------------------------------------------+
int OnInit() {
   IndicatorSetString(INDICATOR_SHORTNAME, "Hybrid TPO Market Profile"); //--- Set indicator short name
   
   tpoPriceGridStep = ticksPerTpoLetter * _Point; //--- Calculate TPO price grid step
   
   ArrayResize(tpoCharacterSet, 52);              //--- Resize TPO character set array
   for(int i = 0; i < 52; i++) {                  //--- Loop through characters
      tpoCharacterSet[i] = StringSubstr(TPO_CHARACTERS_STRING, i, 1); //--- Assign character to array
   }
   
   switch(textSize) {                             //--- Switch on text size
      case TINY: labelFontSize = 7; break;        //--- Set tiny font size
      case SMALL: labelFontSize = 9; break;       //--- Set small font size
      case NORMAL: labelFontSize = 11; break;     //--- Set normal font size
   }
   
   if(timezone != "Exchange") {                   //--- Check if timezone is not exchange
      string tzString = StringSubstr(timezone, 3); //--- Extract timezone string
      int offset = (int)StringToInteger(tzString); //--- Convert offset to integer
      timezoneOffsetSeconds = offset * 3600;       //--- Calculate timezone offset in seconds
   }
   
   ArrayResize(sessions, 0);                      //--- Resize sessions array to zero
   
   return(INIT_SUCCEEDED);                        //--- Return initialization success
}

//+------------------------------------------------------------------+
//| Deinitialize custom indicator                                    |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
   DeleteAllIndicatorObjects();                   //--- Delete all indicator objects
}

//+------------------------------------------------------------------+
//| Delete all indicator objects                                     |
//+------------------------------------------------------------------+
void DeleteAllIndicatorObjects() {
   int total = ObjectsTotal(0, 0, -1);            //--- Get total number of objects
   for(int i = total - 1; i >= 0; i--) {          //--- Loop through objects in reverse
      string name = ObjectName(0, i, 0, -1);      //--- Get object name
      if(StringFind(name, objectPrefix) == 0)     //--- Check if name starts with prefix
         ObjectDelete(0, name);                   //--- Delete object
   }
}

//+------------------------------------------------------------------+
//| Delete session objects                                           |
//+------------------------------------------------------------------+
void DeleteSessionObjects(datetime sessionTime) {
   string sessionString = IntegerToString(sessionTime); //--- Convert session time to string
   
   int total = ObjectsTotal(0, 0, -1);            //--- Get total number of objects
   for(int i = total - 1; i >= 0; i--) {          //--- Loop through objects in reverse
      string name = ObjectName(0, i, 0, -1);      //--- Get object name
      if(StringFind(name, objectPrefix) == 0 && StringFind(name, sessionString) > 0) //--- Check if matches session
         ObjectDelete(0, name);                   //--- Delete object
   }
}

//+------------------------------------------------------------------+
//| Create new session                                               |
//+------------------------------------------------------------------+
int CreateNewSession() {
   int size = ArraySize(sessions);                //--- Get size of sessions array
   
   if(size >= maxSessionHistory) {                //--- Check if size exceeds history limit
      DeleteSessionObjects(sessions[0].startTime); //--- Delete old session objects
      
      for(int i = 0; i < size - 1; i++) {         //--- Loop to shift sessions
         sessions[i] = sessions[i + 1];           //--- Copy next session to current
      }
      ArrayResize(sessions, size - 1);            //--- Resize sessions array
      size = size - 1;                            //--- Update size
   }
   
   ArrayResize(sessions, size + 1);               //--- Resize sessions array for new session
   int newIndex = size;                           //--- Set new index
   
   sessions[newIndex].startTime = 0;              //--- Initialize start time
   sessions[newIndex].endTime = 0;                //--- Initialize end time
   sessions[newIndex].sessionOpen = 0;            //--- Initialize session open
   sessions[newIndex].sessionClose = 0;           //--- Initialize session close
   sessions[newIndex].sessionHigh = 0;            //--- Initialize session high
   sessions[newIndex].sessionLow = 0;             //--- Initialize session low
   sessions[newIndex].initialBalanceHigh = 0;     //--- Initialize initial balance high
   sessions[newIndex].initialBalanceLow = 0;      //--- Initialize initial balance low
   sessions[newIndex].vwap = 0;                   //--- Initialize VWAP
   sessions[newIndex].pointOfControlIndex = -1;   //--- Initialize point of control index
   sessions[newIndex].volumeProfilePocIndex = -1; //--- Initialize volume profile POC index
   sessions[newIndex].periodCount = 0;            //--- Initialize period count
   ArrayResize(sessions[newIndex].levels, 0);     //--- Resize levels array
   ArrayResize(sessions[newIndex].periodHighs, 0);//--- Resize period highs array
   ArrayResize(sessions[newIndex].periodLows, 0); //--- Resize period lows array
   ArrayResize(sessions[newIndex].periodOpens, 0);//--- Resize period opens array
   ArrayResize(sessions[newIndex].volumeProfilePrices, 0); //--- Resize volume profile prices array
   ArrayResize(sessions[newIndex].volumeProfileVolumes, 0); //--- Resize volume profile volumes array
   
   return newIndex;                               //--- Return new index
}

//+------------------------------------------------------------------+
//| Quantize price to grid                                           |
//+------------------------------------------------------------------+
double QuantizePriceToGrid(double price) {
   return MathRound(price / tpoPriceGridStep) * tpoPriceGridStep; //--- Calculate and return quantized price
}

//+------------------------------------------------------------------+
//| Parse daily session time range                                   |
//+------------------------------------------------------------------+
bool ParseDailySessionTimeRange(int &startHour, int &startMinute, int &endHour, int &endMinute) {
   string parts[];                                //--- Declare parts array
   int count = StringSplit(dailySessionRange, '-', parts); //--- Split daily session range
   if(count != 2) return false;                   //--- Return false if invalid count
   
   startHour = (int)StringToInteger(StringSubstr(parts[0], 0, 2)); //--- Parse start hour
   startMinute = (int)StringToInteger(StringSubstr(parts[0], 2, 2)); //--- Parse start minute
   endHour = (int)StringToInteger(StringSubstr(parts[1], 0, 2)); //--- Parse end hour
   endMinute = (int)StringToInteger(StringSubstr(parts[1], 2, 2)); //--- Parse end minute
   
   return true;                                   //--- Return true
}

//+------------------------------------------------------------------+
//| Check if bar is within daily session                             |
//+------------------------------------------------------------------+
bool IsBarWithinDailySession(datetime barTime) {
   if(profileTimeframe != DAILY) return true;     //--- Return true if not daily timeframe
   
   int startHour, startMinute, endHour, endMinute;//--- Declare time variables
   if(!ParseDailySessionTimeRange(startHour, startMinute, endHour, endMinute)) return true; //--- Parse and return true if fail
   
   MqlDateTime dateTimeStruct;                    //--- Declare date time struct
   TimeToStruct(barTime + timezoneOffsetSeconds, dateTimeStruct); //--- Convert time to struct
   
   int barMinutes = dateTimeStruct.hour * 60 + dateTimeStruct.min; //--- Calculate bar minutes
   int startMinutes = startHour * 60 + startMinute; //--- Calculate start minutes
   int endMinutes = endHour * 60 + endMinute;     //--- Calculate end minutes
   
   if(endMinutes > startMinutes) {                //--- Check if end after start
      return barMinutes >= startMinutes && barMinutes <= endMinutes; //--- Return if within range
   } else {                                       //--- Handle overnight case
      return barMinutes >= startMinutes || barMinutes <= endMinutes; //--- Return if within range
   }
}

//+------------------------------------------------------------------+
//| Check if new session started                                     |
//+------------------------------------------------------------------+
bool IsNewSessionStarted(datetime currentTime, datetime previousTime) {
   if(previousTime == 0) return true;             //--- Return true if no previous time
   
   datetime adjustedCurrent = currentTime + timezoneOffsetSeconds; //--- Adjust current time
   datetime adjustedPrevious = previousTime + timezoneOffsetSeconds; //--- Adjust previous time
   
   MqlDateTime currentDateTime, previousDateTime; //--- Declare date time structs
   TimeToStruct(adjustedCurrent, currentDateTime); //--- Convert current to struct
   TimeToStruct(adjustedPrevious, previousDateTime); //--- Convert previous to struct
   
   switch(profileTimeframe) {                     //--- Switch on profile timeframe
      case DAILY: {                               //--- Handle daily case
         int startHour, startMinute, endHour, endMinute; //--- Declare time variables
         if(!ParseDailySessionTimeRange(startHour, startMinute, endHour, endMinute)) return false; //--- Parse and return false if fail
         
         datetime sessionStart = StringToTime(TimeToString(adjustedCurrent, TIME_DATE) + " " + 
                                              IntegerToString(startHour, 2, '0') + ":" + 
                                              IntegerToString(startMinute, 2, '0')); //--- Calculate session start
         datetime prevSessionStart = StringToTime(TimeToString(adjustedPrevious, TIME_DATE) + " " + 
                                                   IntegerToString(startHour, 2, '0') + ":" + 
                                                   IntegerToString(startMinute, 2, '0')); //--- Calculate previous session start
         
         return adjustedCurrent >= sessionStart && adjustedPrevious < prevSessionStart; //--- Return if new session
      }
      
      case WEEKLY:                                //--- Handle weekly case
         return currentDateTime.day_of_week < previousDateTime.day_of_week || 
                currentDateTime.day_of_year < previousDateTime.day_of_year; //--- Return if new week
      
      case MONTHLY:                               //--- Handle monthly case
         return currentDateTime.mon != previousDateTime.mon; //--- Return if new month
      
      case FIXED:                                 //--- Handle fixed case
         return currentTime >= fixedTimeRangeStart && previousTime < fixedTimeRangeStart; //--- Return if new fixed range
      
      case INTRADAY: {                            //--- Handle intraday case
         long currentMinute = (adjustedCurrent / 60) * 60; //--- Calculate current minute
         long prevMinute = (adjustedPrevious / 60) * 60; //--- Calculate previous minute
         return (currentMinute % (intradayProfileLengthMinutes * 60)) == 0 && 
                currentMinute != prevMinute;      //--- Return if new intraday profile
      }
   }
   
   return false;                                  //--- Return false
}

//+------------------------------------------------------------------+
//| Check if bar is eligible for processing                          |
//+------------------------------------------------------------------+
bool IsBarEligibleForProcessing(datetime barTime) {
   if(profileTimeframe == FIXED) {                //--- Check fixed timeframe
      return barTime >= fixedTimeRangeStart && barTime <= fixedTimeRangeEnd; //--- Return if within fixed range
   }
   
   if(profileTimeframe == DAILY) {                //--- Check daily timeframe
      return IsBarWithinDailySession(barTime);    //--- Return if within daily session
   }
   
   return true;                                   //--- Return true
}

//+------------------------------------------------------------------+
//| Get or create price level                                        |
//+------------------------------------------------------------------+
int GetOrCreatePriceLevel(int sessionIndex, double price) {
   if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return -1; //--- Return invalid if index out of range
   
   int size = ArraySize(sessions[sessionIndex].levels); //--- Get levels size
   
   for(int i = 0; i < size; i++) {                //--- Loop through levels
      if(MathAbs(sessions[sessionIndex].levels[i].price - price) < _Point / 2) //--- Check if price matches
         return i;                                //--- Return index
   }
   
   ArrayResize(sessions[sessionIndex].levels, size + 1); //--- Resize levels array
   sessions[sessionIndex].levels[size].price = price; //--- Set new price
   sessions[sessionIndex].levels[size].tpoString = ""; //--- Initialize TPO string
   sessions[sessionIndex].levels[size].tpoCount = 0; //--- Initialize TPO count
   sessions[sessionIndex].levels[size].volume = 0; //--- Initialize volume
   
   return size;                                   //--- Return new index
}

//+------------------------------------------------------------------+
//| Convert string to upper case                                     |
//+------------------------------------------------------------------+
string ConvertToUpperCase(string str) {
   string result = str;                           //--- Copy string
   StringToUpper(result);                         //--- Convert to upper case
   return result;                                 //--- Return result
}

//+------------------------------------------------------------------+
//| Convert string to lower case                                     |
//+------------------------------------------------------------------+
string ConvertToLowerCase(string str) {
   string result = str;                           //--- Copy string
   StringToLower(result);                         //--- Convert to lower case
   return result;                                 //--- Return result
}

//+------------------------------------------------------------------+
//| Check if character is upper case                                 |
//+------------------------------------------------------------------+
bool IsUpperCaseCharacter(string character) {
   return character == ConvertToUpperCase(character) && character != ConvertToLowerCase(character); //--- Check and return if upper case
}

//+------------------------------------------------------------------+
//| Add TPO character to level                                       |
//+------------------------------------------------------------------+
void AddTpoCharacterToLevel(int sessionIndex, int levelIndex, int periodIndex) {
   if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if session index invalid
   if(levelIndex < 0 || levelIndex >= ArraySize(sessions[sessionIndex].levels)) return; //--- Return if level index invalid
   
   string tpoCharacter = "";                      //--- Initialize TPO character
   
   switch(tpoCharacterType) {                     //--- Switch on TPO character type
      case SQUARE:                                //--- Handle square case
         tpoCharacter = "■";                      //--- Set square character
         break;                                   //--- Exit case
      case CIRCLE:                                //--- Handle circle case
         tpoCharacter = "●";                      //--- Set circle character
         break;                                   //--- Exit case
      case ALPHABETIC:                            //--- Handle alphabetic case
         tpoCharacter = tpoCharacterSet[periodIndex % 52]; //--- Get alphabetic character
         
         if(markPeriodOpens != NONE && periodIndex < ArraySize(sessions[sessionIndex].periodOpens)) { //--- Check if mark opens and valid index
            double periodOpen = sessions[sessionIndex].periodOpens[periodIndex]; //--- Get period open
            double levelPrice = sessions[sessionIndex].levels[levelIndex].price; //--- Get level price
            
            if(MathAbs(levelPrice - periodOpen) < tpoPriceGridStep / 2) { //--- Check if matches open
               if(markPeriodOpens == SWAP_CASE) {    //--- Check swap case
                  if(IsUpperCaseCharacter(tpoCharacter)) //--- Check if upper
                     tpoCharacter = ConvertToLowerCase(tpoCharacter); //--- Convert to lower
                  else                                  //--- Handle lower
                     tpoCharacter = ConvertToUpperCase(tpoCharacter); //--- Convert to upper
               } else if(markPeriodOpens == USE_ZERO) { //--- Check use zero
                  tpoCharacter = "0";                //--- Set zero character
               }
            }
         }
         break;                                   //--- Exit case
   }
   
   sessions[sessionIndex].levels[levelIndex].tpoString += tpoCharacter; //--- Append character to TPO string
   sessions[sessionIndex].levels[levelIndex].tpoCount++; //--- Increment TPO count
}

//+------------------------------------------------------------------+
//| Pad levels for split profile                                     |
//+------------------------------------------------------------------+
void PadLevelsForSplitProfile(int sessionIndex) {
   if(!splitProfile || tpoCharacterType != ALPHABETIC) return; //--- Return if not split or not alphabetic
   if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if index invalid
   
   int periodCount = sessions[sessionIndex].periodCount; //--- Get period count
   int levelCount = ArraySize(sessions[sessionIndex].levels); //--- Get level count
   
   for(int i = 0; i < levelCount; i++) {          //--- Loop through levels
      int currentLength = StringLen(sessions[sessionIndex].levels[i].tpoString); //--- Get current length
      if(currentLength < periodCount) {           //--- Check if needs padding
         for(int j = currentLength; j < periodCount; j++) { //--- Loop to pad
            sessions[sessionIndex].levels[i].tpoString += " "; //--- Add space
         }
      }
   }
}

//+------------------------------------------------------------------+
//| Sort price levels descending                                     |
//+------------------------------------------------------------------+
void SortPriceLevelsDescending(int sessionIndex) {
   if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if index invalid
   
   int size = ArraySize(sessions[sessionIndex].levels); //--- Get levels size
   
   for(int i = 0; i < size - 1; i++) {            //--- Outer loop for sorting
      for(int j = 0; j < size - i - 1; j++) {     //--- Inner loop for comparison
         if(sessions[sessionIndex].levels[j].price < sessions[sessionIndex].levels[j + 1].price) { //--- Check if swap needed
            TpoPriceLevel temp = sessions[sessionIndex].levels[j]; //--- Store temporary level
            sessions[sessionIndex].levels[j] = sessions[sessionIndex].levels[j + 1]; //--- Swap levels
            sessions[sessionIndex].levels[j + 1] = temp; //--- Assign temporary back
         }
      }
   }
}

//+------------------------------------------------------------------+
//| Calculate point of control                                       |
//+------------------------------------------------------------------+
void CalculatePointOfControl(int sessionIndex) {
   if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if index invalid
   
   int size = ArraySize(sessions[sessionIndex].levels); //--- Get levels size
   if(size == 0) return;                          //--- Return if no levels
   
   int maxTpoCount = 0;                           //--- Initialize max TPO count
   int pointOfControlIndex = 0;                   //--- Initialize POC index
   
   for(int i = 0; i < size; i++) {                //--- Loop through levels
      if(sessions[sessionIndex].levels[i].tpoCount > maxTpoCount) { //--- Check if higher TPO count
         maxTpoCount = sessions[sessionIndex].levels[i].tpoCount; //--- Update max TPO count
         pointOfControlIndex = i;                 //--- Update POC index
      }
   }
   
   sessions[sessionIndex].pointOfControlIndex = pointOfControlIndex; //--- Set POC index
}

//+------------------------------------------------------------------+
//| Build volume profile and find POC                                |
//+------------------------------------------------------------------+
void BuildVolumeProfileAndFindPoc(int sessionIndex) {
   if(!highlightVolumeProfilePoc) {                //--- Check if not highlight VP POC
      if(sessionIndex >= 0 && sessionIndex < ArraySize(sessions)) //--- Check valid session
         sessions[sessionIndex].volumeProfilePocIndex = -1; //--- Reset VP POC index
      return;                                     //--- Return
   }
   
   if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if index invalid
   if(sessions[sessionIndex].startTime == 0) return; //--- Return if no start time
   
   ENUM_TIMEFRAMES lowerTimeframe = PERIOD_M1;    //--- Set default lower timeframe
   int currentTimeframeSeconds = PeriodSeconds(_Period); //--- Get current timeframe seconds
   
   if(currentTimeframeSeconds < 30 * 60) {        //--- Check for M1 lower
      lowerTimeframe = PERIOD_M1;                 //--- Set M1
   } else if(currentTimeframeSeconds < 60 * 60) { //--- Check for M3 lower
      lowerTimeframe = PERIOD_M3;                 //--- Set M3
   } else if(currentTimeframeSeconds == 60 * 60) {//--- Check for M10 lower
      lowerTimeframe = PERIOD_M10;                //--- Set M10
   } else {                                       //--- Default to H1
      lowerTimeframe = PERIOD_H1;                 //--- Set H1
   }
   
   if(PeriodSeconds(_Period) <= 60) {             //--- Check for 1-minute timeframe
      int size = ArraySize(sessions[sessionIndex].levels); //--- Get levels size
      for(int i = 0; i < size; i++) {             //--- Loop through levels
         int volumeProfileIndex = -1;             //--- Initialize VP index
         for(int j = 0; j < ArraySize(sessions[sessionIndex].volumeProfilePrices); j++) { //--- Loop through VP prices
            if(MathAbs(sessions[sessionIndex].volumeProfilePrices[j] - sessions[sessionIndex].levels[i].price) < _Point / 2) { //--- Check match
               volumeProfileIndex = j;            //--- Set index
               break;                             //--- Exit loop
            }
         }
         
         if(volumeProfileIndex == -1) {         //--- Check if new
            int volumeProfileSize = ArraySize(sessions[sessionIndex].volumeProfilePrices); //--- Get VP size
            ArrayResize(sessions[sessionIndex].volumeProfilePrices, volumeProfileSize + 1); //--- Resize prices
            ArrayResize(sessions[sessionIndex].volumeProfileVolumes, volumeProfileSize + 1); //--- Resize volumes
            sessions[sessionIndex].volumeProfilePrices[volumeProfileSize] = sessions[sessionIndex].levels[i].price; //--- Set price
            sessions[sessionIndex].volumeProfileVolumes[volumeProfileSize] = sessions[sessionIndex].levels[i].volume; //--- Set volume
         } else {                                 //--- Handle existing
            sessions[sessionIndex].volumeProfileVolumes[volumeProfileIndex] += sessions[sessionIndex].levels[i].volume; //--- Add volume
         }
      }
   } else {                                       //--- Handle higher timeframes
      datetime sessionEnd = (sessions[sessionIndex].endTime > 0) ? sessions[sessionIndex].endTime : TimeCurrent(); //--- Get session end
      
      int startBar = iBarShift(_Symbol, lowerTimeframe, sessions[sessionIndex].startTime); //--- Get start bar
      int endBar = iBarShift(_Symbol, lowerTimeframe, sessionEnd); //--- Get end bar
      
      if(startBar < 0 || endBar < 0) return;      //--- Return if invalid bars
      
      int barCount = startBar - endBar + 1;       //--- Calculate bar count
      if(barCount <= 0) return;                   //--- Return if no bars
      
      double highs[], lows[];                     //--- Declare highs and lows arrays
      long volumes[];                             //--- Declare volumes array
      
      ArraySetAsSeries(highs, true);              //--- Set highs as series
      ArraySetAsSeries(lows, true);               //--- Set lows as series
      ArraySetAsSeries(volumes, true);            //--- Set volumes as series
      
      if(CopyHigh(_Symbol, lowerTimeframe, endBar, barCount, highs) <= 0) return; //--- Copy highs
      if(CopyLow(_Symbol, lowerTimeframe, endBar, barCount, lows) <= 0) return; //--- Copy lows
      if(CopyTickVolume(_Symbol, lowerTimeframe, endBar, barCount, volumes) <= 0) return; //--- Copy volumes
      
      for(int i = 0; i < barCount; i++) {         //--- Loop through bars
         double quantizedHigh = QuantizePriceToGrid(highs[i]); //--- Quantize high
         double quantizedLow = QuantizePriceToGrid(lows[i]); //--- Quantize low
         
         int priceCount = (int)MathMax(1, (quantizedHigh - quantizedLow) / tpoPriceGridStep + 1); //--- Calculate price count
         double volumePerLevel = (double)volumes[i] / priceCount; //--- Calculate volume per level
         
         for(double price = quantizedLow; price <= quantizedHigh; price += tpoPriceGridStep) { //--- Loop through prices
            int volumeProfileIndex = -1;          //--- Initialize VP index
            for(int j = 0; j < ArraySize(sessions[sessionIndex].volumeProfilePrices); j++) { //--- Loop through VP prices
               if(MathAbs(sessions[sessionIndex].volumeProfilePrices[j] - price) < _Point / 2) { //--- Check match
                  volumeProfileIndex = j;         //--- Set index
                  break;                          //--- Exit loop
               }
            }
            
            if(volumeProfileIndex == -1) {      //--- Check if new
               int volumeProfileSize = ArraySize(sessions[sessionIndex].volumeProfilePrices); //--- Get VP size
               ArrayResize(sessions[sessionIndex].volumeProfilePrices, volumeProfileSize + 1); //--- Resize prices
               ArrayResize(sessions[sessionIndex].volumeProfileVolumes, volumeProfileSize + 1); //--- Resize volumes
               sessions[sessionIndex].volumeProfilePrices[volumeProfileSize] = price; //--- Set price
               sessions[sessionIndex].volumeProfileVolumes[volumeProfileSize] = volumePerLevel; //--- Set volume
            } else {                              //--- Handle existing
               sessions[sessionIndex].volumeProfileVolumes[volumeProfileIndex] += volumePerLevel; //--- Add volume
            }
         }
      }
   }
   
   double maxVolume = 0;                          //--- Initialize max volume
   double volumeProfilePocPrice = 0;              //--- Initialize VP POC price
   
   for(int i = 0; i < ArraySize(sessions[sessionIndex].volumeProfileVolumes); i++) { //--- Loop through volumes
      if(sessions[sessionIndex].volumeProfileVolumes[i] > maxVolume) { //--- Check if max
         maxVolume = sessions[sessionIndex].volumeProfileVolumes[i]; //--- Update max
         volumeProfilePocPrice = sessions[sessionIndex].volumeProfilePrices[i]; //--- Update price
      }
   }
   
   sessions[sessionIndex].volumeProfilePocIndex = -1; //--- Reset VP POC index
   for(int i = 0; i < ArraySize(sessions[sessionIndex].levels); i++) { //--- Loop through levels
      if(MathAbs(sessions[sessionIndex].levels[i].price - volumeProfilePocPrice) < tpoPriceGridStep / 2) { //--- Check match
         sessions[sessionIndex].volumeProfilePocIndex = i; //--- Set index
         break;                                    //--- Exit loop
      }
   }
}

//+------------------------------------------------------------------+
//| Calculate session VWAP                                           |
//+------------------------------------------------------------------+
void CalculateSessionVwap(int sessionIndex) {
   if(!highlightSessionVwap) return;              //--- Return if not highlight VWAP
   if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if index invalid
   
   double sumPriceVolume = 0;                     //--- Initialize sum price volume
   double sumVolume = 0;                          //--- Initialize sum volume
   
   int size = ArraySize(sessions[sessionIndex].levels); //--- Get levels size
   for(int i = 0; i < size; i++) {                //--- Loop through levels
      sumPriceVolume += sessions[sessionIndex].levels[i].price * sessions[sessionIndex].levels[i].volume; //--- Accumulate price volume
      sumVolume += sessions[sessionIndex].levels[i].volume; //--- Accumulate volume
   }
   
   if(sumVolume > 0)                              //--- Check if volume positive
      sessions[sessionIndex].vwap = sumPriceVolume / sumVolume; //--- Calculate VWAP
}

//+------------------------------------------------------------------+
//| Get total TPO count                                              |
//+------------------------------------------------------------------+
int GetTotalTpoCount(int sessionIndex) {
   if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return 0; //--- Return zero if index invalid
   
   int total = 0;                                 //--- Initialize total
   int size = ArraySize(sessions[sessionIndex].levels); //--- Get levels size
   
   for(int i = 0; i < size; i++) {                //--- Loop through levels
      total += sessions[sessionIndex].levels[i].tpoCount; //--- Accumulate TPO count
   }
   
   return total;                                  //--- Return total
}

//+------------------------------------------------------------------+
//| Render open TPO highlight                                        |
//+------------------------------------------------------------------+
void RenderOpenTpoHighlight(int sessionIndex, int openLevelIndex, string &displayStrings[]) {
   if(tpoCharacterType != ALPHABETIC) return;     //--- Return if not alphabetic
   if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if session invalid
   if(openLevelIndex < 0 || openLevelIndex >= ArraySize(sessions[sessionIndex].levels)) return; //--- Return if level invalid
   
   string fullString = displayStrings[openLevelIndex]; //--- Get full display string
   if(StringLen(fullString) == 0) return;         //--- Return if empty string
   
   string openCharacter = StringSubstr(fullString, 0, 1); //--- Extract open character
   string remainingCharacters = StringSubstr(fullString, 1); //--- Extract remaining characters
   
   string objectName = objectPrefix + "OpenTPO_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create object name
   int barIndex = iBarShift(_Symbol, _Period, sessions[sessionIndex].startTime); //--- Get bar index
   if(barIndex < 0) return;                       //--- Return if invalid bar index
   
   datetime labelTime = iTime(_Symbol, _Period, barIndex); //--- Get label time
   int x, y;                                      //--- Declare coordinates
   ChartTimePriceToXY(0, 0, labelTime, sessions[sessionIndex].levels[openLevelIndex].price, x, y); //--- Convert to XY
   
   if(ObjectFind(0, objectName) < 0) {            //--- Check if object not found
      ObjectCreate(0, objectName, OBJ_LABEL, 0, 0, 0); //--- Create label object
   }
   
   ObjectSetInteger(0, objectName, OBJPROP_XDISTANCE, x); //--- Set X distance
   ObjectSetInteger(0, objectName, OBJPROP_YDISTANCE, y); //--- Set Y distance
   ObjectSetInteger(0, objectName, OBJPROP_CORNER, CORNER_LEFT_UPPER); //--- Set corner
   ObjectSetInteger(0, objectName, OBJPROP_ANCHOR, ANCHOR_LEFT); //--- Set anchor
   ObjectSetInteger(0, objectName, OBJPROP_COLOR, openColor); //--- Set color
   ObjectSetInteger(0, objectName, OBJPROP_FONTSIZE, labelFontSize); //--- Set font size
   ObjectSetString(0, objectName, OBJPROP_FONT, "Arial"); //--- Set font
   ObjectSetString(0, objectName, OBJPROP_TEXT, openCharacter); //--- Set text
   ObjectSetInteger(0, objectName, OBJPROP_SELECTABLE, false); //--- Set selectable false
   ObjectSetInteger(0, objectName, OBJPROP_HIDDEN, true); //--- Set hidden true
   
   if(StringLen(remainingCharacters) > 0) {       //--- Check if remaining
      displayStrings[openLevelIndex] = " " + remainingCharacters; //--- Prepend space
   } else {                                       //--- Handle no remaining
      displayStrings[openLevelIndex] = " ";       //--- Set space
   }
}

//+------------------------------------------------------------------+
//| Render close TPO highlight                                       |
//+------------------------------------------------------------------+
void RenderCloseTpoHighlight(int sessionIndex, int closeLevelIndex, string &displayStrings[]) {
   if(tpoCharacterType != ALPHABETIC) return;     //--- Return if not alphabetic
   if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if session invalid
   if(closeLevelIndex < 0 || closeLevelIndex >= ArraySize(sessions[sessionIndex].levels)) return; //--- Return if level invalid
   
   string fullString = displayStrings[closeLevelIndex]; //--- Get full display string
   int stringLength = StringLen(fullString);      //--- Get string length
   if(stringLength == 0) return;                  //--- Return if empty string
   
   string closeCharacter = StringSubstr(fullString, stringLength - 1, 1); //--- Extract close character
   string remainingCharacters = StringSubstr(fullString, 0, stringLength - 1); //--- Extract remaining characters
   
   string objectName = objectPrefix + "CloseTPO_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create object name
   int barIndex = iBarShift(_Symbol, _Period, sessions[sessionIndex].startTime); //--- Get bar index
   if(barIndex < 0) return;                       //--- Return if invalid bar index
   
   datetime labelTime = iTime(_Symbol, _Period, barIndex); //--- Get label time
   int x, y;                                      //--- Declare coordinates
   ChartTimePriceToXY(0, 0, labelTime, sessions[sessionIndex].levels[closeLevelIndex].price, x, y); //--- Convert to XY
   
   int characterWidth = 8;                        //--- Set character width
   int offsetX = (stringLength - 1) * characterWidth; //--- Calculate offset X
   
   if(ObjectFind(0, objectName) < 0) {            //--- Check if object not found
      ObjectCreate(0, objectName, OBJ_LABEL, 0, 0, 0); //--- Create label object
   }
   
   ObjectSetInteger(0, objectName, OBJPROP_XDISTANCE, x + offsetX); //--- Set X distance
   ObjectSetInteger(0, objectName, OBJPROP_YDISTANCE, y); //--- Set Y distance
   ObjectSetInteger(0, objectName, OBJPROP_CORNER, CORNER_LEFT_UPPER); //--- Set corner
   ObjectSetInteger(0, objectName, OBJPROP_ANCHOR, ANCHOR_LEFT); //--- Set anchor
   ObjectSetInteger(0, objectName, OBJPROP_COLOR, closeColor); //--- Set color
   ObjectSetInteger(0, objectName, OBJPROP_FONTSIZE, labelFontSize); //--- Set font size
   ObjectSetString(0, objectName, OBJPROP_FONT, "Arial"); //--- Set font
   ObjectSetString(0, objectName, OBJPROP_TEXT, closeCharacter + "◄"); //--- Set text
   ObjectSetInteger(0, objectName, OBJPROP_SELECTABLE, false); //--- Set selectable false
   ObjectSetInteger(0, objectName, OBJPROP_HIDDEN, true); //--- Set hidden true
   
   displayStrings[closeLevelIndex] = remainingCharacters; //--- Update display string
}

//+------------------------------------------------------------------+
//| Render session profile                                           |
//+------------------------------------------------------------------+
void RenderSessionProfile(int sessionIndex) {
   if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if index invalid
   
   int size = ArraySize(sessions[sessionIndex].levels); //--- Get levels size
   if(size == 0 || sessions[sessionIndex].startTime == 0) return; //--- Return if no levels or no start time
   
   int barIndex = iBarShift(_Symbol, _Period, sessions[sessionIndex].startTime); //--- Get bar index
   if(barIndex < 0) return;                       //--- Return if invalid
   
   PadLevelsForSplitProfile(sessionIndex);        //--- Pad levels for split
   SortPriceLevelsDescending(sessionIndex);       //--- Sort levels descending
   CalculatePointOfControl(sessionIndex);         //--- Calculate POC
   BuildVolumeProfileAndFindPoc(sessionIndex);    //--- Build VP and find POC
   
   int totalTpoCount = GetTotalTpoCount(sessionIndex); //--- Get total TPO count
   int pointOfControlIndex = (useVolumeProfilePocForValueArea && sessions[sessionIndex].volumeProfilePocIndex >= 0) ? 
                             sessions[sessionIndex].volumeProfilePocIndex : sessions[sessionIndex].pointOfControlIndex; //--- Select POC index
   
   int valueAreaUpperIndex = pointOfControlIndex; //--- Initialize value area upper index
   int valueAreaLowerIndex = pointOfControlIndex; //--- Initialize value area lower index
   
   if(pointOfControlIndex >= 0) {                 //--- Check valid POC index
      int targetTpoCount = (int)(totalTpoCount * valueAreaPercent / 100.0); //--- Calculate target TPO count
      int currentTpoCount = sessions[sessionIndex].levels[pointOfControlIndex].tpoCount; //--- Set current TPO count
      
      while(currentTpoCount < targetTpoCount && (valueAreaUpperIndex > 0 || valueAreaLowerIndex < size - 1)) { //--- Loop to expand value area
         int upperTpoCount = (valueAreaUpperIndex > 0) ? sessions[sessionIndex].levels[valueAreaUpperIndex - 1].tpoCount : 0; //--- Get upper TPO count
         int lowerTpoCount = (valueAreaLowerIndex < size - 1) ? sessions[sessionIndex].levels[valueAreaLowerIndex + 1].tpoCount : 0; //--- Get lower TPO count
         
         if(upperTpoCount >= lowerTpoCount && valueAreaUpperIndex > 0) { //--- Check upper expansion
            valueAreaUpperIndex--;                //--- Decrement upper index
            currentTpoCount += upperTpoCount;     //--- Add upper TPO
         } else if(valueAreaLowerIndex < size - 1) { //--- Check lower expansion
            valueAreaLowerIndex++;                //--- Increment lower index
            currentTpoCount += lowerTpoCount;     //--- Add lower TPO
         } else if(valueAreaUpperIndex > 0) {     //--- Fallback upper expansion
            valueAreaUpperIndex--;                //--- Decrement upper index
            currentTpoCount += upperTpoCount;     //--- Add upper TPO
         } else {                                 //--- Break if no more
            break;                                //--- Exit loop
         }
      }
   }
   
   string displayStrings[];                       //--- Declare display strings array
   ArrayResize(displayStrings, size);             //--- Resize display strings
   for(int i = 0; i < size; i++) {                //--- Loop through levels
      displayStrings[i] = sessions[sessionIndex].levels[i].tpoString; //--- Copy TPO string
   }
   
   int openLevelIndex  = -1;                      //--- Initialize open level index
   int closeLevelIndex = -1;                      //--- Initialize close level index
   
   if(tpoCharacterType == ALPHABETIC) {           //--- Check alphabetic
      double openPrice  = sessions[sessionIndex].sessionOpen; //--- Get open price
      double closePrice = sessions[sessionIndex].sessionClose; //--- Get close price
      
      for(int i = 0; i < size; i++) {             //--- Loop to find levels
         if(openLevelIndex < 0  && MathAbs(sessions[sessionIndex].levels[i].price - openPrice)  < tpoPriceGridStep / 2) //--- Check open match
            openLevelIndex = i;                   //--- Set open index
         if(closeLevelIndex < 0 && MathAbs(sessions[sessionIndex].levels[i].price - closePrice) < tpoPriceGridStep / 2) //--- Check close match
            closeLevelIndex = i;                  //--- Set close index
      }
      
      RenderOpenTpoHighlight(sessionIndex, openLevelIndex, displayStrings); //--- Render open highlight
      RenderCloseTpoHighlight(sessionIndex, closeLevelIndex, displayStrings); //--- Render close highlight
   }
   
   for(int i = 0; i < size; i++) {                //--- Loop to render levels
      string objectName = objectPrefix + "TPO_" + IntegerToString(sessions[sessionIndex].startTime) + "_" + IntegerToString(i); //--- Create object name
      
      color textColor = defaultTpoColor;          //--- Set default color
      
      if(sessions[sessionIndex].levels[i].tpoCount == 1) { //--- Check single print
         textColor = singlePrintColor;            //--- Set single print color
      }
      
      if(i >= valueAreaUpperIndex && i <= valueAreaLowerIndex) { //--- Check value area
         textColor = valueAreaColor;              //--- Set value area color
      }
      
      if(i == sessions[sessionIndex].pointOfControlIndex && sessions[sessionIndex].volumeProfilePocIndex != sessions[sessionIndex].pointOfControlIndex) { //--- Check TPO POC
         textColor = pointOfControlColor;         //--- Set POC color
      }
      
      if(highlightVolumeProfilePoc && i == sessions[sessionIndex].volumeProfilePocIndex) { //--- Check VP POC
         textColor = volumeProfilePocColor;       //--- Set VP POC color
      }
      
      if(highlightSessionVwap && MathAbs(sessions[sessionIndex].levels[i].price - sessions[sessionIndex].vwap) < tpoPriceGridStep / 2) { //--- Check VWAP
         textColor = sessionVwapColor;            //--- Set VWAP color
      }
      
      if(ObjectFind(0, objectName) < 0) {         //--- Check if object not found
         ObjectCreate(0, objectName, OBJ_LABEL, 0, 0, 0); //--- Create label
         ObjectSetInteger(0, objectName, OBJPROP_XDISTANCE, 0); //--- Set X distance
         ObjectSetInteger(0, objectName, OBJPROP_YDISTANCE, 0); //--- Set Y distance
      }
      
      datetime labelTime = iTime(_Symbol, _Period, barIndex); //--- Get label time
      int x, y;                                   //--- Declare coordinates
      ChartTimePriceToXY(0, 0, labelTime, sessions[sessionIndex].levels[i].price, x, y); //--- Convert to XY
      
      ObjectSetInteger(0, objectName, OBJPROP_XDISTANCE, x); //--- Set X distance
      ObjectSetInteger(0, objectName, OBJPROP_YDISTANCE, y); //--- Set Y distance
      ObjectSetInteger(0, objectName, OBJPROP_CORNER, CORNER_LEFT_UPPER); //--- Set corner
      ObjectSetInteger(0, objectName, OBJPROP_ANCHOR, ANCHOR_LEFT); //--- Set anchor
      ObjectSetInteger(0, objectName, OBJPROP_COLOR, textColor); //--- Set color
      ObjectSetInteger(0, objectName, OBJPROP_FONTSIZE, labelFontSize); //--- Set font size
      ObjectSetString(0, objectName, OBJPROP_FONT, "Arial"); //--- Set font
      ObjectSetString(0, objectName, OBJPROP_TEXT, displayStrings[i]); //--- Set text
      ObjectSetInteger(0, objectName, OBJPROP_SELECTABLE, false); //--- Set selectable false
      ObjectSetInteger(0, objectName, OBJPROP_HIDDEN, true); //--- Set hidden true
   }
   
   RenderOpenCloseMarkers(sessionIndex, barIndex); //--- Render open close markers
   RenderProfileBorderLine(sessionIndex, barIndex); //--- Render profile border
   
   if(initialBalancePeriods > 0)                   //--- Check if IB periods
      RenderInitialBalanceLines(sessionIndex, barIndex); //--- Render IB lines
   
   if(showExtensionLines)                         //--- Check if show extensions
      RenderKeyLevelExtensions(sessionIndex, barIndex, valueAreaUpperIndex, valueAreaLowerIndex); //--- Render extensions
   
   if(profileTimeframe == FIXED && renderVolumes) //--- Check fixed and render volumes
      RenderFixedRangeVolumeLabels(sessionIndex, barIndex); //--- Render volume labels
   
   RenderFixedRangeBackgroundRectangle(sessionIndex); //--- Render fixed background
}

//+------------------------------------------------------------------+
//| Render open close markers                                        |
//+------------------------------------------------------------------+
void RenderOpenCloseMarkers(int sessionIndex, int barIndex) {
   if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if index invalid
   if(sessions[sessionIndex].sessionOpen == 0) return; //--- Return if no open
   
   datetime startTime = iTime(_Symbol, _Period, barIndex); //--- Get start time
   
   string openObjectName = objectPrefix + "Open_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create open object name
   if(ObjectFind(0, openObjectName) < 0) {        //--- Check if not found
      ObjectCreate(0, openObjectName, OBJ_TREND, 0, startTime, sessions[sessionIndex].sessionOpen, 
                   startTime, sessions[sessionIndex].sessionOpen); //--- Create trend object
      ObjectSetInteger(0, openObjectName, OBJPROP_RAY_RIGHT, false); //--- Set ray right false
      ObjectSetInteger(0, openObjectName, OBJPROP_SELECTABLE, false); //--- Set selectable false
      ObjectSetInteger(0, openObjectName, OBJPROP_HIDDEN, true); //--- Set hidden true
   }
   ObjectSetInteger(0, openObjectName, OBJPROP_COLOR, openColor); //--- Set color
   ObjectSetInteger(0, openObjectName, OBJPROP_WIDTH, priceMarkerWidth); //--- Set width
   
   string closeObjectName = objectPrefix + "Close_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create close object name
   if(ObjectFind(0, closeObjectName) < 0) {       //--- Check if not found
      ObjectCreate(0, closeObjectName, OBJ_TREND, 0, startTime, sessions[sessionIndex].sessionClose, 
                   startTime, sessions[sessionIndex].sessionClose); //--- Create trend object
      ObjectSetInteger(0, closeObjectName, OBJPROP_RAY_RIGHT, false); //--- Set ray right false
      ObjectSetInteger(0, closeObjectName, OBJPROP_SELECTABLE, false); //--- Set selectable false
      ObjectSetInteger(0, closeObjectName, OBJPROP_HIDDEN, true); //--- Set hidden true
   }
   ObjectSetInteger(0, closeObjectName, OBJPROP_COLOR, closeColor); //--- Set color
   ObjectSetInteger(0, closeObjectName, OBJPROP_WIDTH, priceMarkerWidth); //--- Set width
}

//+------------------------------------------------------------------+
//| Render profile border line                                       |
//+------------------------------------------------------------------+
void RenderProfileBorderLine(int sessionIndex, int barIndex) {
   if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if index invalid
   if(sessions[sessionIndex].sessionHigh == 0 || sessions[sessionIndex].sessionLow == 0) return; //--- Return if no high low
   
   datetime startTime = iTime(_Symbol, _Period, barIndex); //--- Get start time
   
   color backgroundEdgeColor = 0x606D79;          //--- Set background edge color
   color initialBalanceEdgeColor = initialBalanceHighlightColor; //--- Set IB edge color
   
   if(initialBalancePeriods > 0 && sessions[sessionIndex].initialBalanceHigh > 0 && sessions[sessionIndex].initialBalanceLow > 0) { //--- Check IB
      
      string edge1Name = objectPrefix + "Edge1_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create edge1 name
      if(ObjectFind(0, edge1Name) < 0) {          //--- Check if not found
         ObjectCreate(0, edge1Name, OBJ_TREND, 0, startTime, sessions[sessionIndex].sessionLow, 
                      startTime, sessions[sessionIndex].initialBalanceLow); //--- Create trend
         ObjectSetInteger(0, edge1Name, OBJPROP_RAY_RIGHT, false); //--- Set ray right false
         ObjectSetInteger(0, edge1Name, OBJPROP_SELECTABLE, false); //--- Set selectable false
         ObjectSetInteger(0, edge1Name, OBJPROP_HIDDEN, true); //--- Set hidden true
      }
      ObjectSetDouble(0, edge1Name, OBJPROP_PRICE, 0, sessions[sessionIndex].sessionLow); //--- Set price 0
      ObjectSetDouble(0, edge1Name, OBJPROP_PRICE, 1, sessions[sessionIndex].initialBalanceLow); //--- Set price 1
      ObjectSetInteger(0, edge1Name, OBJPROP_COLOR, backgroundEdgeColor); //--- Set color
      ObjectSetInteger(0, edge1Name, OBJPROP_WIDTH, 3); //--- Set width
      ObjectSetInteger(0, edge1Name, OBJPROP_STYLE, STYLE_SOLID); //--- Set style
      
      string edge2Name = objectPrefix + "Edge2_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create edge2 name
      if(ObjectFind(0, edge2Name) < 0) {          //--- Check if not found
         ObjectCreate(0, edge2Name, OBJ_TREND, 0, startTime, sessions[sessionIndex].initialBalanceLow, 
                      startTime, sessions[sessionIndex].initialBalanceHigh); //--- Create trend
         ObjectSetInteger(0, edge2Name, OBJPROP_RAY_RIGHT, false); //--- Set ray right false
         ObjectSetInteger(0, edge2Name, OBJPROP_SELECTABLE, false); //--- Set selectable false
         ObjectSetInteger(0, edge2Name, OBJPROP_HIDDEN, true); //--- Set hidden true
      }
      ObjectSetDouble(0, edge2Name, OBJPROP_PRICE, 0, sessions[sessionIndex].initialBalanceLow); //--- Set price 0
      ObjectSetDouble(0, edge2Name, OBJPROP_PRICE, 1, sessions[sessionIndex].initialBalanceHigh); //--- Set price 1
      ObjectSetInteger(0, edge2Name, OBJPROP_COLOR, initialBalanceEdgeColor); //--- Set color
      ObjectSetInteger(0, edge2Name, OBJPROP_WIDTH, 3); //--- Set width
      ObjectSetInteger(0, edge2Name, OBJPROP_STYLE, STYLE_SOLID); //--- Set style
      
      string edge3Name = objectPrefix + "Edge3_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create edge3 name
      if(ObjectFind(0, edge3Name) < 0) {          //--- Check if not found
         ObjectCreate(0, edge3Name, OBJ_TREND, 0, startTime, sessions[sessionIndex].initialBalanceHigh, 
                      startTime, sessions[sessionIndex].sessionHigh); //--- Create trend
         ObjectSetInteger(0, edge3Name, OBJPROP_RAY_RIGHT, false); //--- Set ray right false
         ObjectSetInteger(0, edge3Name, OBJPROP_SELECTABLE, false); //--- Set selectable false
         ObjectSetInteger(0, edge3Name, OBJPROP_HIDDEN, true); //--- Set hidden true
      }
      ObjectSetDouble(0, edge3Name, OBJPROP_PRICE, 0, sessions[sessionIndex].initialBalanceHigh); //--- Set price 0
      ObjectSetDouble(0, edge3Name, OBJPROP_PRICE, 1, sessions[sessionIndex].sessionHigh); //--- Set price 1
      ObjectSetInteger(0, edge3Name, OBJPROP_COLOR, backgroundEdgeColor); //--- Set color
      ObjectSetInteger(0, edge3Name, OBJPROP_WIDTH, 3); //--- Set width
      ObjectSetInteger(0, edge3Name, OBJPROP_STYLE, STYLE_SOLID); //--- Set style
      
   } else {                                       //--- Handle no IB
      string edgeName = objectPrefix + "Edge_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create edge name
      if(ObjectFind(0, edgeName) < 0) {           //--- Check if not found
         ObjectCreate(0, edgeName, OBJ_TREND, 0, startTime, sessions[sessionIndex].sessionLow, 
                      startTime, sessions[sessionIndex].sessionHigh); //--- Create trend
         ObjectSetInteger(0, edgeName, OBJPROP_RAY_RIGHT, false); //--- Set ray right false
         ObjectSetInteger(0, edgeName, OBJPROP_SELECTABLE, false); //--- Set selectable false
         ObjectSetInteger(0, edgeName, OBJPROP_HIDDEN, true); //--- Set hidden true
      }
      ObjectSetDouble(0, edgeName, OBJPROP_PRICE, 0, sessions[sessionIndex].sessionLow); //--- Set price 0
      ObjectSetDouble(0, edgeName, OBJPROP_PRICE, 1, sessions[sessionIndex].sessionHigh); //--- Set price 1
      ObjectSetInteger(0, edgeName, OBJPROP_COLOR, backgroundEdgeColor); //--- Set color
      ObjectSetInteger(0, edgeName, OBJPROP_WIDTH, 3); //--- Set width
      ObjectSetInteger(0, edgeName, OBJPROP_STYLE, STYLE_SOLID); //--- Set style
   }
}

//+------------------------------------------------------------------+
//| Render initial balance lines                                     |
//+------------------------------------------------------------------+
void RenderInitialBalanceLines(int sessionIndex, int barIndex) {
   if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if index invalid
   if(sessions[sessionIndex].initialBalanceHigh == 0 || sessions[sessionIndex].initialBalanceLow == 0) return; //--- Return if no IB
   
   datetime startTime = iTime(_Symbol, _Period, barIndex); //--- Get start time
   
   string initialBalanceHighName = objectPrefix + "IB_High_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create IB high name
   if(ObjectFind(0, initialBalanceHighName) < 0) { //--- Check if not found
      ObjectCreate(0, initialBalanceHighName, OBJ_TREND, 0, startTime, sessions[sessionIndex].initialBalanceHigh, 
                   startTime, sessions[sessionIndex].initialBalanceHigh); //--- Create trend
      ObjectSetInteger(0, initialBalanceHighName, OBJPROP_RAY_RIGHT, false); //--- Set ray right false
      ObjectSetInteger(0, initialBalanceHighName, OBJPROP_SELECTABLE, false); //--- Set selectable false
      ObjectSetInteger(0, initialBalanceHighName, OBJPROP_HIDDEN, true); //--- Set hidden true
   }
   ObjectSetInteger(0, initialBalanceHighName, OBJPROP_COLOR, initialBalanceHighlightColor); //--- Set color
   ObjectSetInteger(0, initialBalanceHighName, OBJPROP_WIDTH, initialBalanceLineWidth); //--- Set width
   
   string initialBalanceLowName = objectPrefix + "IB_Low_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create IB low name
   if(ObjectFind(0, initialBalanceLowName) < 0) { //--- Check if not found
      ObjectCreate(0, initialBalanceLowName, OBJ_TREND, 0, startTime, sessions[sessionIndex].initialBalanceLow, 
                   startTime, sessions[sessionIndex].initialBalanceLow); //--- Create trend
      ObjectSetInteger(0, initialBalanceLowName, OBJPROP_RAY_RIGHT, false); //--- Set ray right false
      ObjectSetInteger(0, initialBalanceLowName, OBJPROP_SELECTABLE, false); //--- Set selectable false
      ObjectSetInteger(0, initialBalanceLowName, OBJPROP_HIDDEN, true); //--- Set hidden true
   }
   ObjectSetInteger(0, initialBalanceLowName, OBJPROP_COLOR, initialBalanceHighlightColor); //--- Set color
   ObjectSetInteger(0, initialBalanceLowName, OBJPROP_WIDTH, initialBalanceLineWidth); //--- Set width
}

//+------------------------------------------------------------------+
//| Render key level extensions                                      |
//+------------------------------------------------------------------+
void RenderKeyLevelExtensions(int sessionIndex, int barIndex, int valueAreaUpperIndex, int valueAreaLowerIndex) {
   if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if index invalid
   if(ArraySize(sessions[sessionIndex].levels) == 0) return; //--- Return if no levels
   
   datetime startTime = iTime(_Symbol, _Period, barIndex); //--- Get start time
   
   bool isCurrentSession = (sessionIndex == ArraySize(sessions) - 1); //--- Check if current session
   
   datetime endTime;                              //--- Declare end time
   bool rayRight;                                 //--- Declare ray right
   
   if(isCurrentSession) {                         //--- Handle current session
      endTime = startTime + PeriodSeconds(_Period) * 100; //--- Set end time
      rayRight = true;                            //--- Set ray right true
   } else {                                       //--- Handle past session
      if(sessionIndex + 1 < ArraySize(sessions)) { //--- Check next session
         int nextBarIndex = iBarShift(_Symbol, _Period, sessions[sessionIndex + 1].startTime); //--- Get next bar
         endTime = iTime(_Symbol, _Period, nextBarIndex); //--- Set end time
      } else {                                    //--- Handle last
         endTime = startTime + PeriodSeconds(_Period) * 100; //--- Set end time
      }
      rayRight = false;                           //--- Set ray right false
   }
   
   if(sessions[sessionIndex].volumeProfilePocIndex >= 0 && sessions[sessionIndex].volumeProfilePocIndex < ArraySize(sessions[sessionIndex].levels)) { //--- Check VP POC
      double pocPrice = sessions[sessionIndex].levels[sessions[sessionIndex].volumeProfilePocIndex].price; //--- Get POC price
      string pocExtensionName = objectPrefix + "POC_Ext_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create POC ext name
      if(ObjectFind(0, pocExtensionName) < 0) {   //--- Check if not found
         ObjectCreate(0, pocExtensionName, OBJ_TREND, 0, startTime, pocPrice, endTime, pocPrice); //--- Create trend
         ObjectSetInteger(0, pocExtensionName, OBJPROP_SELECTABLE, false); //--- Set selectable false
         ObjectSetInteger(0, pocExtensionName, OBJPROP_HIDDEN, true); //--- Set hidden true
      } else {                                    //--- Handle existing
         ObjectSetInteger(0, pocExtensionName, OBJPROP_TIME, 0, startTime); //--- Set time 0
         ObjectSetDouble(0, pocExtensionName, OBJPROP_PRICE, 0, pocPrice); //--- Set price 0
         ObjectSetInteger(0, pocExtensionName, OBJPROP_TIME, 1, endTime); //--- Set time 1
         ObjectSetDouble(0, pocExtensionName, OBJPROP_PRICE, 1, pocPrice); //--- Set price 1
      }
      ObjectSetInteger(0, pocExtensionName, OBJPROP_RAY_RIGHT, rayRight); //--- Set ray right
      ObjectSetInteger(0, pocExtensionName, OBJPROP_COLOR, pocExtensionColor); //--- Set color
      ObjectSetInteger(0, pocExtensionName, OBJPROP_WIDTH, 2); //--- Set width
      ObjectSetInteger(0, pocExtensionName, OBJPROP_STYLE, STYLE_SOLID); //--- Set style
   }
   
   if(valueAreaUpperIndex >= 0 && valueAreaUpperIndex < ArraySize(sessions[sessionIndex].levels)) { //--- Check VAH
      double valueAreaHighPrice = sessions[sessionIndex].levels[valueAreaUpperIndex].price; //--- Get VAH price
      string valueAreaHighExtensionName = objectPrefix + "VAH_Ext_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create VAH ext name
      if(ObjectFind(0, valueAreaHighExtensionName) < 0) { //--- Check if not found
         ObjectCreate(0, valueAreaHighExtensionName, OBJ_TREND, 0, startTime, valueAreaHighPrice, endTime, valueAreaHighPrice); //--- Create trend
         ObjectSetInteger(0, valueAreaHighExtensionName, OBJPROP_SELECTABLE, false); //--- Set selectable false
         ObjectSetInteger(0, valueAreaHighExtensionName, OBJPROP_HIDDEN, true); //--- Set hidden true
      } else {                                    //--- Handle existing
         ObjectSetInteger(0, valueAreaHighExtensionName, OBJPROP_TIME, 0, startTime); //--- Set time 0
         ObjectSetDouble(0, valueAreaHighExtensionName, OBJPROP_PRICE, 0, valueAreaHighPrice); //--- Set price 0
         ObjectSetInteger(0, valueAreaHighExtensionName, OBJPROP_TIME, 1, endTime); //--- Set time 1
         ObjectSetDouble(0, valueAreaHighExtensionName, OBJPROP_PRICE, 1, valueAreaHighPrice); //--- Set price 1
      }
      ObjectSetInteger(0, valueAreaHighExtensionName, OBJPROP_RAY_RIGHT, rayRight); //--- Set ray right
      ObjectSetInteger(0, valueAreaHighExtensionName, OBJPROP_COLOR, valueAreaHighExtensionColor); //--- Set color
      ObjectSetInteger(0, valueAreaHighExtensionName, OBJPROP_WIDTH, 1); //--- Set width
      ObjectSetInteger(0, valueAreaHighExtensionName, OBJPROP_STYLE, STYLE_DOT); //--- Set style
   }
   
   if(valueAreaLowerIndex >= 0 && valueAreaLowerIndex < ArraySize(sessions[sessionIndex].levels)) { //--- Check VAL
      double valueAreaLowPrice = sessions[sessionIndex].levels[valueAreaLowerIndex].price; //--- Get VAL price
      string valueAreaLowExtensionName = objectPrefix + "VAL_Ext_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create VAL ext name
      if(ObjectFind(0, valueAreaLowExtensionName) < 0) { //--- Check if not found
         ObjectCreate(0, valueAreaLowExtensionName, OBJ_TREND, 0, startTime, valueAreaLowPrice, endTime, valueAreaLowPrice); //--- Create trend
         ObjectSetInteger(0, valueAreaLowExtensionName, OBJPROP_SELECTABLE, false); //--- Set selectable false
         ObjectSetInteger(0, valueAreaLowExtensionName, OBJPROP_HIDDEN, true); //--- Set hidden true
      } else {                                    //--- Handle existing
         ObjectSetInteger(0, valueAreaLowExtensionName, OBJPROP_TIME, 0, startTime); //--- Set time 0
         ObjectSetDouble(0, valueAreaLowExtensionName, OBJPROP_PRICE, 0, valueAreaLowPrice); //--- Set price 0
         ObjectSetInteger(0, valueAreaLowExtensionName, OBJPROP_TIME, 1, endTime); //--- Set time 1
         ObjectSetDouble(0, valueAreaLowExtensionName, OBJPROP_PRICE, 1, valueAreaLowPrice); //--- Set price 1
      }
      ObjectSetInteger(0, valueAreaLowExtensionName, OBJPROP_RAY_RIGHT, rayRight); //--- Set ray right
      ObjectSetInteger(0, valueAreaLowExtensionName, OBJPROP_COLOR, valueAreaLowExtensionColor); //--- Set color
      ObjectSetInteger(0, valueAreaLowExtensionName, OBJPROP_WIDTH, 1); //--- Set width
      ObjectSetInteger(0, valueAreaLowExtensionName, OBJPROP_STYLE, STYLE_DOT); //--- Set style
   }
   
   string highExtensionName = objectPrefix + "High_Ext_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create high ext name
   if(ObjectFind(0, highExtensionName) < 0) {     //--- Check if not found
      ObjectCreate(0, highExtensionName, OBJ_TREND, 0, startTime, sessions[sessionIndex].sessionHigh, 
                   endTime, sessions[sessionIndex].sessionHigh); //--- Create trend
      ObjectSetInteger(0, highExtensionName, OBJPROP_SELECTABLE, false); //--- Set selectable false
      ObjectSetInteger(0, highExtensionName, OBJPROP_HIDDEN, true); //--- Set hidden true
      ObjectSetInteger(0, highExtensionName, OBJPROP_STYLE, STYLE_DOT); //--- Set style
   } else {                                       //--- Handle existing
      ObjectSetInteger(0, highExtensionName, OBJPROP_TIME, 0, startTime); //--- Set time 0
      ObjectSetDouble(0, highExtensionName, OBJPROP_PRICE, 0, sessions[sessionIndex].sessionHigh); //--- Set price 0
      ObjectSetInteger(0, highExtensionName, OBJPROP_TIME, 1, endTime); //--- Set time 1
      ObjectSetDouble(0, highExtensionName, OBJPROP_PRICE, 1, sessions[sessionIndex].sessionHigh); //--- Set price 1
   }
   ObjectSetInteger(0, highExtensionName, OBJPROP_RAY_RIGHT, rayRight); //--- Set ray right
   ObjectSetInteger(0, highExtensionName, OBJPROP_COLOR, highExtensionColor); //--- Set color
   ObjectSetInteger(0, highExtensionName, OBJPROP_WIDTH, 1); //--- Set width
   
   string lowExtensionName = objectPrefix + "Low_Ext_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create low ext name
   if(ObjectFind(0, lowExtensionName) < 0) {      //--- Check if not found
      ObjectCreate(0, lowExtensionName, OBJ_TREND, 0, startTime, sessions[sessionIndex].sessionLow, 
                   endTime, sessions[sessionIndex].sessionLow); //--- Create trend
      ObjectSetInteger(0, lowExtensionName, OBJPROP_SELECTABLE, false); //--- Set selectable false
      ObjectSetInteger(0, lowExtensionName, OBJPROP_HIDDEN, true); //--- Set hidden true
      ObjectSetInteger(0, lowExtensionName, OBJPROP_STYLE, STYLE_DOT); //--- Set style
   } else {                                       //--- Handle existing
      ObjectSetInteger(0, lowExtensionName, OBJPROP_TIME, 0, startTime); //--- Set time 0
      ObjectSetDouble(0, lowExtensionName, OBJPROP_PRICE, 0, sessions[sessionIndex].sessionLow); //--- Set price 0
      ObjectSetInteger(0, lowExtensionName, OBJPROP_TIME, 1, endTime); //--- Set time 1
      ObjectSetDouble(0, lowExtensionName, OBJPROP_PRICE, 1, sessions[sessionIndex].sessionLow); //--- Set price 1
   }
   ObjectSetInteger(0, lowExtensionName, OBJPROP_RAY_RIGHT, rayRight); //--- Set ray right
   ObjectSetInteger(0, lowExtensionName, OBJPROP_COLOR, lowExtensionColor); //--- Set color
   ObjectSetInteger(0, lowExtensionName, OBJPROP_WIDTH, 1); //--- Set width
   
   double midpointPrice = 0;                      //--- Initialize midpoint price
   if(midpointAlgorithm == HIGH_LOW_MID) {        //--- Check high low mid
      midpointPrice = sessions[sessionIndex].sessionHigh - (sessions[sessionIndex].sessionHigh - sessions[sessionIndex].sessionLow) / 2; //--- Calculate midpoint
   } else {                                       //--- Handle TPO count based
      int totalTpoCount = GetTotalTpoCount(sessionIndex); //--- Get total TPO
      int targetTpoCount = totalTpoCount / 2;     //--- Calculate target
      int currentTpoCount = 0;                    //--- Initialize current
      
      for(int i = 0; i < ArraySize(sessions[sessionIndex].levels); i++) { //--- Loop through levels
         currentTpoCount += sessions[sessionIndex].levels[i].tpoCount; //--- Accumulate TPO
         if(currentTpoCount >= targetTpoCount) {  //--- Check if reached
            midpointPrice = sessions[sessionIndex].levels[i].price; //--- Set midpoint
            break;                                //--- Exit loop
         }
      }
   }
   
   if(midpointPrice > 0) {                        //--- Check if midpoint set
      string midpointExtensionName = objectPrefix + "Mid_Ext_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create mid ext name
      if(ObjectFind(0, midpointExtensionName) < 0) { //--- Check if not found
         ObjectCreate(0, midpointExtensionName, OBJ_TREND, 0, startTime, midpointPrice, endTime, midpointPrice); //--- Create trend
         ObjectSetInteger(0, midpointExtensionName, OBJPROP_SELECTABLE, false); //--- Set selectable false
         ObjectSetInteger(0, midpointExtensionName, OBJPROP_HIDDEN, true); //--- Set hidden true
         ObjectSetInteger(0, midpointExtensionName, OBJPROP_STYLE, STYLE_DOT); //--- Set style
      } else {                                    //--- Handle existing
         ObjectSetInteger(0, midpointExtensionName, OBJPROP_TIME, 0, startTime); //--- Set time 0
         ObjectSetDouble(0, midpointExtensionName, OBJPROP_PRICE, 0, midpointPrice); //--- Set price 0
         ObjectSetInteger(0, midpointExtensionName, OBJPROP_TIME, 1, endTime); //--- Set time 1
         ObjectSetDouble(0, midpointExtensionName, OBJPROP_PRICE, 1, midpointPrice); //--- Set price 1
      }
      ObjectSetInteger(0, midpointExtensionName, OBJPROP_RAY_RIGHT, rayRight); //--- Set ray right
      ObjectSetInteger(0, midpointExtensionName, OBJPROP_COLOR, midpointExtensionColor); //--- Set color
      ObjectSetInteger(0, midpointExtensionName, OBJPROP_WIDTH, 1); //--- Set width
   }
}

//+------------------------------------------------------------------+
//| Render fixed range volume labels                                 |
//+------------------------------------------------------------------+
void RenderFixedRangeVolumeLabels(int sessionIndex, int barIndex) {
   if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if index invalid
   if(ArraySize(sessions[sessionIndex].volumeProfilePrices) == 0) return; //--- Return if no VP prices
   
   double maxVolume = 0;                          //--- Initialize max volume
   for(int i = 0; i < ArraySize(sessions[sessionIndex].volumeProfileVolumes); i++) { //--- Loop through volumes
      if(sessions[sessionIndex].volumeProfileVolumes[i] > maxVolume) //--- Check if max
         maxVolume = sessions[sessionIndex].volumeProfileVolumes[i]; //--- Update max
   }
   
   if(maxVolume == 0) return;                     //--- Return if no volume
   
   datetime labelTime = iTime(_Symbol, _Period, barIndex); //--- Get label time
   
   for(int i = 0; i < ArraySize(sessions[sessionIndex].volumeProfilePrices); i++) { //--- Loop through VP prices
      double price = sessions[sessionIndex].volumeProfilePrices[i]; //--- Get price
      double volumeValue = sessions[sessionIndex].volumeProfileVolumes[i]; //--- Get volume
      double ratio = volumeValue / maxVolume;     //--- Calculate ratio
      
      color volumeColor;                          //--- Declare color
      int percent = (int)(100 * ratio);           //--- Calculate percent
      
      if(percent <= 8) {                          //--- Check low percent
         volumeColor = singlePrintColor;          //--- Set single print color
      } else {                                    //--- Handle higher
         int transparency = (int)MathMax(0, 80 - percent); //--- Calculate transparency
         volumeColor = ApplyTransparencyToColor(valueAreaColor, transparency); //--- Apply transparency
      }
      
      string objectName = objectPrefix + "Vol_" + IntegerToString(sessions[sessionIndex].startTime) + "_" + IntegerToString(i); //--- Create object name
      
      int x, y;                                   //--- Declare coordinates
      ChartTimePriceToXY(0, 0, labelTime, price, x, y); //--- Convert to XY
      
      if(ObjectFind(0, objectName) < 0) {         //--- Check if not found
         ObjectCreate(0, objectName, OBJ_LABEL, 0, 0, 0); //--- Create label
      }
      
      ObjectSetInteger(0, objectName, OBJPROP_XDISTANCE, x - 50); //--- Set X distance
      ObjectSetInteger(0, objectName, OBJPROP_YDISTANCE, y); //--- Set Y distance
      ObjectSetInteger(0, objectName, OBJPROP_CORNER, CORNER_LEFT_UPPER); //--- Set corner
      ObjectSetInteger(0, objectName, OBJPROP_ANCHOR, ANCHOR_RIGHT); //--- Set anchor
      ObjectSetInteger(0, objectName, OBJPROP_COLOR, volumeColor); //--- Set color
      ObjectSetInteger(0, objectName, OBJPROP_FONTSIZE, labelFontSize); //--- Set font size
      ObjectSetString(0, objectName, OBJPROP_FONT, "Arial"); //--- Set font
      ObjectSetString(0, objectName, OBJPROP_TEXT, IntegerToString((int)MathRound(volumeValue))); //--- Set text
      ObjectSetInteger(0, objectName, OBJPROP_SELECTABLE, false); //--- Set selectable false
      ObjectSetInteger(0, objectName, OBJPROP_HIDDEN, true); //--- Set hidden true
   }
}

//+------------------------------------------------------------------+
//| Apply transparency to color                                      |
//+------------------------------------------------------------------+
color ApplyTransparencyToColor(color baseColor, int transparency) {
   int red = (int)(baseColor & 0xFF);             //--- Extract red
   int green = (int)((baseColor >> 8) & 0xFF);    //--- Extract green
   int blue = (int)((baseColor >> 16) & 0xFF);    //--- Extract blue
   
   transparency = (int)MathMin(100, MathMax(0, transparency)); //--- Clamp transparency
   int alpha = 255 - (transparency * 255 / 100); //--- Calculate alpha
   
   return (color)((alpha << 24) | (blue << 16) | (green << 8) | red); //--- Return color with alpha
}

//+------------------------------------------------------------------+
//| Render fixed range background rectangle                          |
//+------------------------------------------------------------------+
void RenderFixedRangeBackgroundRectangle(int sessionIndex) {
   if(profileTimeframe != FIXED) return;          //--- Return if not fixed
   if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if index invalid
   
   string objectName = objectPrefix + "FixedBG_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create object name
   
   if(ObjectFind(0, objectName) < 0) {            //--- Check if not found
      ObjectCreate(0, objectName, OBJ_RECTANGLE, 0, sessions[sessionIndex].startTime, sessions[sessionIndex].sessionHigh,
                   sessions[sessionIndex].endTime > 0 ? sessions[sessionIndex].endTime : TimeCurrent(),
                   sessions[sessionIndex].sessionLow); //--- Create rectangle
      ObjectSetInteger(0, objectName, OBJPROP_SELECTABLE, false); //--- Set selectable false
      ObjectSetInteger(0, objectName, OBJPROP_HIDDEN, true); //--- Set hidden true
      ObjectSetInteger(0, objectName, OBJPROP_BACK, true); //--- Set back true
   }
   
   ObjectSetInteger(0, objectName, OBJPROP_COLOR, fixedRangeBackgroundColor); //--- Set color
   ObjectSetInteger(0, objectName, OBJPROP_FILL, true); //--- Set fill true
}

//+------------------------------------------------------------------+
//| Calculate custom indicator                                       |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[]) {
   
   if(rates_total < 2) return 0;                  //--- Return if insufficient rates
   
   datetime currentBarTime = time[rates_total - 1]; //--- Get current bar time
   bool isNewBar = (currentBarTime != lastCompletedBarTime); //--- Check if new bar
   
   if(IsNewSessionStarted(currentBarTime, previousBarTime) || previousBarTime == 0) { //--- Check new session
      if(activeSessionIndex >= 0 && activeSessionIndex < ArraySize(sessions)) { //--- Check active session
         sessions[activeSessionIndex].endTime = previousBarTime; //--- Set end time
         RenderSessionProfile(activeSessionIndex); //--- Render session profile
      }
      
      activeSessionIndex = CreateNewSession();    //--- Create new session
      sessions[activeSessionIndex].startTime = currentBarTime; //--- Set start time
      sessions[activeSessionIndex].sessionOpen = open[rates_total - 1]; //--- Set session open
      sessions[activeSessionIndex].sessionHigh = high[rates_total - 1]; //--- Set session high
      sessions[activeSessionIndex].sessionLow = low[rates_total - 1]; //--- Set session low
      lastCompletedBarTime = currentBarTime;      //--- Update last completed bar time
   }
   
   previousBarTime = currentBarTime;              //--- Update previous bar time
   
   if(isNewBar && IsBarEligibleForProcessing(currentBarTime) && activeSessionIndex >= 0) { //--- Check if process bar
      sessions[activeSessionIndex].sessionHigh = MathMax(sessions[activeSessionIndex].sessionHigh, high[rates_total - 1]); //--- Update session high
      sessions[activeSessionIndex].sessionLow = MathMin(sessions[activeSessionIndex].sessionLow, low[rates_total - 1]); //--- Update session low
      sessions[activeSessionIndex].sessionClose = close[rates_total - 1]; //--- Update session close
      
      int periodIndex = sessions[activeSessionIndex].periodCount; //--- Get period index
      ArrayResize(sessions[activeSessionIndex].periodHighs, periodIndex + 1); //--- Resize period highs
      ArrayResize(sessions[activeSessionIndex].periodLows, periodIndex + 1); //--- Resize period lows
      ArrayResize(sessions[activeSessionIndex].periodOpens, periodIndex + 1); //--- Resize period opens
      
      sessions[activeSessionIndex].periodHighs[periodIndex] = high[rates_total - 1]; //--- Set period high
      sessions[activeSessionIndex].periodLows[periodIndex] = low[rates_total - 1]; //--- Set period low
      sessions[activeSessionIndex].periodOpens[periodIndex] = open[rates_total - 1]; //--- Set period open
      sessions[activeSessionIndex].periodCount++; //--- Increment period count
      
      if(periodIndex < initialBalancePeriods) {   //--- Check if within IB periods
         if(periodIndex == 0) {                   //--- Handle first period
            sessions[activeSessionIndex].initialBalanceHigh = high[rates_total - 1]; //--- Set IB high
            sessions[activeSessionIndex].initialBalanceLow = low[rates_total - 1]; //--- Set IB low
         } else {                                 //--- Handle subsequent
            sessions[activeSessionIndex].initialBalanceHigh = MathMax(sessions[activeSessionIndex].initialBalanceHigh, high[rates_total - 1]); //--- Update IB high
            sessions[activeSessionIndex].initialBalanceLow = MathMin(sessions[activeSessionIndex].initialBalanceLow, low[rates_total - 1]); //--- Update IB low
         }
      }
      
      double quantizedHigh = QuantizePriceToGrid(high[rates_total - 1]); //--- Quantize high
      double quantizedLow = QuantizePriceToGrid(low[rates_total - 1]); //--- Quantize low
      
      for(double price = quantizedLow; price <= quantizedHigh; price += tpoPriceGridStep) { //--- Loop through prices
         int levelIndex = GetOrCreatePriceLevel(activeSessionIndex, price); //--- Get or create level
         if(levelIndex >= 0) {                    //--- Check valid level
            AddTpoCharacterToLevel(activeSessionIndex, levelIndex, periodIndex); //--- Add TPO character
            sessions[activeSessionIndex].levels[levelIndex].volume += (double)tick_volume[rates_total - 1] / 
                                                       MathMax(1, (quantizedHigh - quantizedLow) / tpoPriceGridStep + 1); //--- Add volume
         }
      }
      
      CalculateSessionVwap(activeSessionIndex);   //--- Calculate VWAP
      lastCompletedBarTime = currentBarTime;      //--- Update last completed bar time
   }
   
   if(IsBarEligibleForProcessing(currentBarTime) && activeSessionIndex >= 0) { //--- Check if update session
      sessions[activeSessionIndex].sessionClose = close[rates_total - 1]; //--- Update close
      sessions[activeSessionIndex].sessionHigh = MathMax(sessions[activeSessionIndex].sessionHigh, high[rates_total - 1]); //--- Update high
      sessions[activeSessionIndex].sessionLow = MathMin(sessions[activeSessionIndex].sessionLow, low[rates_total - 1]); //--- Update low
   }
   
   for(int i = 0; i < ArraySize(sessions); i++) { //--- Loop through sessions
      RenderSessionProfile(i);                    //--- Render profile
   }
   
   return rates_total;                            //--- Return rates total
}

//+------------------------------------------------------------------+
//| Handle chart event                                               |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam) {
   if(id == CHARTEVENT_CHART_CHANGE) {            //--- Check chart change event
      for(int i = 0; i < ArraySize(sessions); i++) { //--- Loop through sessions
         RenderSessionProfile(i);                 //--- Render profile
      }
   }
}
//+------------------------------------------------------------------+
