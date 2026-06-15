# EN_自定义TPO市场轮廓加入成交量POC价值区域VWAP

> 来源标题：Creating Custom Indicators in MQL5 (Part 8): Adding Volume Integration for Deeper Market Profile Analysis - MQL5 Articles
> 来源链接：https://www.mql5.com/en/articles/21390
> 下载时间：2026-06-12 23:28:40
> 说明：多语言关键词补充资料，供中文策略语义反向映射使用。

---

__

[ __](/en/articles/21390?print= "Printer friendly version")

![preview](data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAsICAoIBwsKCQoNDAsNERwSEQ8PESIZGhQcKSQrKigkJyctMkA3LTA9MCcnOEw5PUNFSElIKzZPVU5GVEBHSEX/2wBDAQwNDREPESESEiFFLicuRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUX/wAARCAAQACADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAABQMG/8QAHRAAAgICAwEAAAAAAAAAAAAAAQIAAwQRBSExEv/EABYBAQEBAAAAAAAAAAAAAAAAAAMBAv/EABoRAAIDAQEAAAAAAAAAAAAAAAABAhExAxL/2gAMAwEAAhEDEQA/AMFRR9+xGjj0Ze9bhC3svkqM6xR1J0tqkDBP1chU8ZWF9EPuxQr6BkjnWESRyGJ7hxU1rNPT/9k=)

![Creating Custom Indicators in MQL5 \(Part 8\): Adding Volume Integration for Deeper Market Profile Analysis](https://c.mql5.com/2/196/21390-creating-custom-indicators-in-mql5-part-8-adding-volume-integration_600x314.jpg)

# Creating Custom Indicators in MQL5 (Part 8): Adding Volume Integration for Deeper Market Profile Analysis

[MetaTrader 5](/en/articles/mt5) — [Trading systems](/en/articles/mt5/trading_systems) | 24 February 2026, 12:24

![](https://c.mql5.com/i/icons.svg#views-white-usage) 2 951  [ ![](https://c.mql5.com/i/icons.svg#comments-white-usage) 0 ](/en/forum/505859 "Comments")

![Allan Munene Mutiiria](https://c.mql5.com/avatar/2022/11/637df59b-9551.jpg)

[Allan Munene Mutiiria](/en/users/29210372)

### Introduction

In our [previous article (Part 7)](/en/articles/21388), we developed a hybrid [Time Price Opportunity](/go?link=https://snpedge.vicitradingsolutions.com/p/understanding-time-price-opportunity "https://snpedge.vicitradingsolutions.com/p/understanding-time-price-opportunity") (TPO) market profile indicator in [MetaQuotes Language 5](https://www.metaquotes.net/en/metatrader5/algorithmic-trading/mql5 "https://www.metaquotes.net/en/metatrader5/algorithmic-trading/mql5") (MQL5) that supported multiple session timeframes including intraday, daily, weekly, monthly, and fixed periods with timezone adjustments, quantizing prices into a grid, tracking session data for highs, lows, opens, and closes, calculating the point of control and value area from TPO counts, and providing visual rendering on the chart with customizable colors for detailed session analysis.

In Part 8, we enhance this indicator by adding volume integration to enable deeper market profile insights, including volume-based point of control, value areas, and volume-weighted average price calculations with highlighting options. This upgrade incorporates advanced features such as initial balance detection, key level extension lines, split profiles, alternative TPO characters like squares or circles, border lines, background rectangles for fixed ranges, and dynamic volume labels, all while maintaining flexibility across timeframes. We will cover the following topics:

  1. [Integrating Volume and Advanced Features into Hybrid Time Price Opportunity Market Profiles>/a>](/en/articles/21390#para2)
[](/en/articles/21390#para2)
  2. [](/en/articles/21390#para2)[Implementation in MQL5](/en/articles/21390#para3)
  3. [Backtesting](/en/articles/21390#para4)
  4. [Conclusion](/en/articles/21390#para5)



By the end, you’ll have an advanced MQL5 indicator for hybrid Time Price Opportunity market profiles with volume-enhanced analysis, ready for customization—let’s dive in!

  


### Integrating Volume and Advanced Features into Hybrid Time Price Opportunity Market Profiles

The integration of volume data into hybrid [Time Price Opportunity](/go?link=https://snpedge.vicitradingsolutions.com/p/understanding-time-price-opportunity "https://snpedge.vicitradingsolutions.com/p/understanding-time-price-opportunity") (TPO) market profiles elevates traditional price-time analysis by incorporating trading volume at each price level, allowing for the identification of volume-based point of control where the highest volume occurred, and adjusting value areas to reflect actual market participation rather than just time spent. This enhancement provides us with insights into market conviction, such as distinguishing between high-volume fair value zones for potential support or resistance and low-volume areas indicating weak interest or possible breakouts, while features like volume-weighted average price offer a dynamic reference for intraday bias.

We will extend the core session management with volume accumulation per price level, compute volume point of control and weighted average price optionally, detect initial balance from early periods, add extension rendering for key levels like highs, lows, value area boundaries, and midpoint, incorporate character variations and marking options for opens, and enable split views with padding for clearer alphabetic displays, all while supporting fixed-range backgrounds and volume labels for comprehensive profile visualization. In brief, here is a visual representation of our objectives.

![VOLUME MARKET PROFILE ROADMAP](https://c.mql5.com/2/195/Screenshot_2026-02-16_112205__1.png)

  


### Implementation in MQL5

To begin the enhancements implementation, we will first extend the indicator enumerations, inputs, and global variables to support the new volume metrics.
    
    
    //+------------------------------------------------------------------+
    //|                             Hybrid TPO Market Profile PART 2.mq5 |
    //|                           Copyright 2026, Allan Munene Mutiiria. |
    //|                                   https://t.me/Forex_Algo_Trader |
    //+------------------------------------------------------------------+
    #property copyright "Copyright 2026, Allan Munene Mutiiria."
    #property link "https://t.me/Forex_Algo_Trader"
    #property version "1.00"
    #property strict
    
    #property indicator_chart_window
    #property indicator_buffers 0
    #property indicator_plots 0
    
    //+------------------------------------------------------------------+
    //| Enums                                                            |
    //+------------------------------------------------------------------+
    enum MarketProfileTimeframe { // Define market profile timeframe enum
       INTRADAY,                  // Intraday
       DAILY,                     // Daily
       WEEKLY,                    // Weekly
       MONTHLY,                   // Monthly
       FIXED                      // Fixed
    };
    
    enum TpoCharacterType {      // Define TPO character type enum
       SQUARE,                   // ■ Square
       CIRCLE,                   // ● Circle
       ALPHABETIC                // A-Za-z
    };
    
    enum MidpointAlgorithm {     // Define midpoint algorithm enum
       HIGH_LOW_MID,             // High/Low mid
       TPO_COUNT_BASED           // Number of TPOs
    };
    
    enum MarkPeriodOpens {       // Define mark period opens enum
       NONE,                     // No
       SWAP_CASE,                // Swap case
       USE_ZERO                  // Use '0'
    };
    
    enum TextSize {              // Define text size enum
       TINY,                     // Tiny
       SMALL,                    // Small
       NORMAL                    // Normal
    };
    
    //+------------------------------------------------------------------+
    //| Inputs                                                           |
    //+------------------------------------------------------------------+
    sinput group "Settings"
    input double ticksPerTpoLetter = 10;             // Ticks per letter
    input bool highlightVolumeProfilePoc = true;     // Highlight POC based on VP?
    input bool useVolumeProfilePocForValueArea = true; // Use VP POC for Value Area?
    input bool highlightSessionVwap = false;         // Highlight session VWAP?
    input bool showExtensionLines = false;           // Show extension lines?
    input bool splitProfile = false;                 // Split MP?
    
    sinput group "Time"
    input MarketProfileTimeframe profileTimeframe = DAILY; // Timeframe
    input string timezone = "Exchange";              // Timezone
    input string dailySessionRange = "0830-1500";    // Daily session
    input int intradayProfileLengthMinutes = 60;     // Profile length in minutes (Intraday)
    input datetime fixedTimeRangeStart = D'2026.02.01 08:30'; // From (Fixed)
    input datetime fixedTimeRangeEnd = D'2026.02.02 15:00'; // Till (Fixed)
    input bool renderVolumes = true;                 // Render volume numbers? (Fixed)
    
    sinput group "Rendering"
    input TpoCharacterType tpoCharacterType = SQUARE; // TPO characters
    input int valueAreaPercent = 70;                 // Value Area Percent
    input int initialBalancePeriods = 2;             // IB periods
    input int initialBalanceLineWidth = 2;           // IB line width
    input int priceMarkerWidth = 2;                  // Price marker width
    input int priceMarkerLength = 1;                 // Price marker length
    input TextSize textSize = NORMAL;                // Font size
    input MarkPeriodOpens markPeriodOpens = NONE;    // Mark period open?
    input MidpointAlgorithm midpointAlgorithm = HIGH_LOW_MID; // Midpoint algo
    
    sinput group "Colors"
    input color defaultTpoColor = clrGray;           // Default
    input color singlePrintColor = 0xd56a6a;         // Single Print
    input color valueAreaColor = clrBlack;           // Value Area
    input color pointOfControlColor = 0x3f7cff;      // POC
    input color volumeProfilePocColor = 0x87c74c;    // VP POC
    input color openColor = clrDodgerBlue;           // Open
    input color closeColor = clrRed;                 // Close
    input color initialBalanceHighlightColor = clrDodgerBlue; // IB
    input color initialBalanceBackgroundColor = 0x606D79;     // IB background
    input color sessionVwapColor = 0xFF9925;                  // Session VWAP
    input color pocExtensionColor = 0x87c74c;                 // POC extension
    input color valueAreaHighExtensionColor = clrBlack;       // VAH extension
    input color valueAreaLowExtensionColor = clrBlack;        // VAL extension
    input color highExtensionColor = clrRed;                  // High extension
    input color lowExtensionColor = clrGreen;                 // Low extension
    input color midpointExtensionColor = 0x7649ff;            // Midpoint extension
    input color fixedRangeBackgroundColor = 0x3179f5;         // Fixed range background
    
    //+------------------------------------------------------------------+
    //| Constants                                                        |
    //+------------------------------------------------------------------+
    #define MAX_BARS_BACK 5000
    #define TPO_CHARACTERS_STRING "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    
    //+------------------------------------------------------------------+
    //| Structures                                                       |
    //+------------------------------------------------------------------+
    struct TpoPriceLevel {       // Define TPO price level structure
       double price;             // Store price level
       string tpoString;         // Store TPO string
       int tpoCount;             // Store TPO count
       double volume;            // Store volume
    };
    
    struct ProfileSessionData {  // Define profile session data structure
       datetime startTime;       // Store start time
       datetime endTime;         // Store end time
       double sessionOpen;       // Store session open price
       double sessionClose;      // Store session close price
       double sessionHigh;       // Store session high price
       double sessionLow;        // Store session low price
       double initialBalanceHigh;// Store initial balance high
       double initialBalanceLow; // Store initial balance low
       double vwap;              // Store VWAP
       int pointOfControlIndex;  // Store point of control index
       int volumeProfilePocIndex;// Store volume profile POC index
       TpoPriceLevel levels[];   // Store array of price levels
       int periodCount;          // Store period count
       double periodHighs[];     // Store array of period highs
       double periodLows[];      // Store array of period lows
       double periodOpens[];     // Store array of period opens
       double volumeProfilePrices[]; // Store array of volume profile prices
       double volumeProfileVolumes[]; // Store array of volume profile volumes
    };
    
    //+------------------------------------------------------------------+
    //| Global Variables                                                 |
    //+------------------------------------------------------------------+
    string objectPrefix = "HTMP_";     //--- Set object prefix
    ProfileSessionData sessions[];     //--- Declare sessions array
    int activeSessionIndex = -1;       //--- Initialize active session index
    double tpoPriceGridStep = 0;       //--- Initialize TPO price grid step
    string tpoCharacterSet[];          //--- Declare TPO character set array
    datetime previousBarTime = 0;      //--- Initialize previous bar time
    datetime lastCompletedBarTime = 0; //--- Initialize last completed bar time
    bool isNewSession = false;         //--- Initialize new session flag
    int labelFontSize = 10;            //--- Set label font size
    int maxSessionHistory = 20;        //--- Set maximum session history
    int timezoneOffsetSeconds = 0;     //--- Initialize timezone offset in seconds
    

We begin the implementation by defining additional [enumerations](/en/book/basis/builtin_types/user_enums) to expand configuration options for the enhanced hybrid Time Price Opportunity market profile. The "TpoCharacterType" enumeration offers choices like "SQUARE" for block symbols, "CIRCLE" for dot representations, and "ALPHABETIC" for letter-based labeling to suit different visual preferences, instead of the only label option that we had. Next, "MidpointAlgorithm" provides algorithms for midpoint calculation, such as "HIGH_LOW_MID" based on session range or "TPO_COUNT_BASED" using accumulated Time Price Opportunity counts. We add "MarkPeriodOpens" with options including "NONE" to skip marking, "SWAP_CASE" to toggle letter casing for opens, and "USE_ZERO" to denote them with a zero character. Finally, "TextSize" allows scaling text with "TINY", "SMALL", or "NORMAL" settings.

We extend user inputs grouped under sections, incorporating new settings like "highlightVolumeProfilePoc" and "useVolumeProfilePocForValueArea" to toggle volume-based point of control features, "highlightSessionVwap" for weighted average price emphasis, "showExtensionLines" for projecting key levels, and "splitProfile" for separated alphabetic displays. The time group adds "renderVolumes" to control fixed-range volume labels. In rendering, we include selections for Time Price Opportunity character type, initial balance periods, and line width, price marker dimensions, text size, period open marking, and midpoint method. The colors group expands with inputs for volume profile point of control, open markers, initial balance highlights and background, session weighted average price, various extension lines, and fixed-range backgrounds.

We update [structures](/en/docs/basis/types/classes) to support volume integration: "TpoPriceLevel" now includes a volume field alongside price, Time Price Opportunity string, and count; "ProfileSessionData" adds initial balance high and low, weighted average price, volume profile point of control index, arrays for period highs and lows, and separate arrays for volume profile prices and volumes. Global variables are adjusted accordingly, introducing "isNewSession" as a flag and setting "labelFontSize" dynamically later, while retaining elements like object prefix, sessions array, active index, grid step, character set, timestamps, history limit, and timezone offset. Next, we will update the initialization event handler by setting the font size as follows. We have highlighted the specific changes for clarity.
    
    
    //+------------------------------------------------------------------+
    //| Initialize custom indicator                                      |
    //+------------------------------------------------------------------+
    int OnInit() {
       IndicatorSetString(INDICATOR_SHORTNAME, "Hybrid TPO Market Profile"); //--- Set indicator short name
       
       tpoPriceGridStep = ticksPerTpoLetter * _Point; //--- Calculate TPO price grid step
       
       ArrayResize(tpoCharacterSet, 52);              //--- Resize TPO character set array
       for(int i = 0; i < 52; i++) {                  //--- Loop through characters
          tpoCharacterSet[i] = StringSubstr(TPO_CHARACTERS_STRING, i, 1); //--- Assign character to array
       }
       
       switch(textSize) {                             //--- Switch on text size
          case TINY: labelFontSize = 7; break;        //--- Set tiny font size
          case SMALL: labelFontSize = 9; break;       //--- Set small font size
          case NORMAL: labelFontSize = 11; break;     //--- Set normal font size
       }
       
       if(timezone != "Exchange") {                    //--- Check if timezone is not exchange
          string tzString = StringSubstr(timezone, 3); //--- Extract timezone string
          int offset = (int)StringToInteger(tzString); //--- Convert offset to integer
          timezoneOffsetSeconds = offset * 3600;       //--- Calculate timezone offset in seconds
       }
       
       ArrayResize(sessions, 0);                       //--- Resize sessions array to zero
       
       return(INIT_SUCCEEDED);                         //--- Return initialization success
    }
    

Setting the font size here will enable us to adjust the text size for better visibility on different charts. The next thing we will do is adjust the session creation function to handle the new storage arrays and delete the expired ones, for easier management.
    
    
    //+------------------------------------------------------------------+
    //| Delete session objects                                           |
    //+------------------------------------------------------------------+
    void DeleteSessionObjects(datetime sessionTime) {
       string sessionString = IntegerToString(sessionTime); //--- Convert session time to string
       
       int total = ObjectsTotal(0, 0, -1);            //--- Get total number of objects
       for(int i = total - 1; i >= 0; i--) {          //--- Loop through objects in reverse
          string name = ObjectName(0, i, 0, -1);      //--- Get object name
          if(StringFind(name, objectPrefix) == 0 && StringFind(name, sessionString) > 0) //--- Check if matches session
             ObjectDelete(0, name);                   //--- Delete object
       }
    }
    
    //+------------------------------------------------------------------+
    //| Create new session                                               |
    //+------------------------------------------------------------------+
    int CreateNewSession() {
       int size = ArraySize(sessions);                //--- Get size of sessions array
       
       if(size >= maxSessionHistory) {                //--- Check if size exceeds history limit
          DeleteSessionObjects(sessions[0].startTime); //--- Delete old session objects
          
          for(int i = 0; i < size - 1; i++) {         //--- Loop to shift sessions
             sessions[i] = sessions[i + 1];           //--- Copy next session to current
          }
          ArrayResize(sessions, size - 1);            //--- Resize sessions array
          size = size - 1;                            //--- Update size
       }
       
       ArrayResize(sessions, size + 1);               //--- Resize sessions array for new session
       int newIndex = size;                           //--- Set new index
       
       sessions[newIndex].startTime = 0;              //--- Initialize start time
       sessions[newIndex].endTime = 0;                //--- Initialize end time
       sessions[newIndex].sessionOpen = 0;            //--- Initialize session open
       sessions[newIndex].sessionClose = 0;           //--- Initialize session close
       sessions[newIndex].sessionHigh = 0;            //--- Initialize session high
       sessions[newIndex].sessionLow = 0;             //--- Initialize session low
       sessions[newIndex].initialBalanceHigh = 0;     //--- Initialize initial balance high
       sessions[newIndex].initialBalanceLow = 0;      //--- Initialize initial balance low
       sessions[newIndex].vwap = 0;                   //--- Initialize VWAP
       sessions[newIndex].pointOfControlIndex = -1;   //--- Initialize point of control index
       sessions[newIndex].volumeProfilePocIndex = -1; //--- Initialize volume profile POC index
       sessions[newIndex].periodCount = 0;            //--- Initialize period count
       ArrayResize(sessions[newIndex].levels, 0);     //--- Resize levels array
       ArrayResize(sessions[newIndex].periodHighs, 0);//--- Resize period highs array
       ArrayResize(sessions[newIndex].periodLows, 0); //--- Resize period lows array
       ArrayResize(sessions[newIndex].periodOpens, 0);//--- Resize period opens array
       ArrayResize(sessions[newIndex].volumeProfilePrices, 0); //--- Resize volume profile prices array
       ArrayResize(sessions[newIndex].volumeProfileVolumes, 0); //--- Resize volume profile volumes array
       
       return newIndex;                               //--- Return new index
    }
    

First, we introduce the "DeleteSessionObjects" function to remove chart objects tied to a specific session, converting the session time to a string with [IntegerToString](/en/docs/convert/IntegerToString), then looping backward through all objects obtained via [ObjectsTotal](/en/docs/objects/objectstotal), fetching names using [ObjectName](/en/docs/objects/objectname), and deleting those that start with the prefix and include the session string as checked by the [StringFind](/en/docs/strings/stringfind) function.

Then, we enhance the "CreateNewSession" function for managing new profiles, retrieving the current sessions array size with [ArraySize](/en/docs/array/arraysize); if at the history limit, we call "DeleteSessionObjects" on the oldest session's start time to clear visuals, shift remaining sessions forward, and resize downward. We then expand the array for the new entry, initialize its fields, including new ones like initial balance, highs, and lows, weighted average price, volume profile point of control index, and reset counts and indices, while resizing additional arrays for period highs, lows, volume profile prices, and volumes, before returning the new index. With that done, we will need helper functions to change letter casing, which we will use to mark the period openings.
    
    
    //+------------------------------------------------------------------+
    //| Convert string to upper case                                     |
    //+------------------------------------------------------------------+
    string ConvertToUpperCase(string str) {
       string result = str;                           //--- Copy string
       StringToUpper(result);                         //--- Convert to upper case
       return result;                                 //--- Return result
    }
    
    //+------------------------------------------------------------------+
    //| Convert string to lower case                                     |
    //+------------------------------------------------------------------+
    string ConvertToLowerCase(string str) {
       string result = str;                           //--- Copy string
       StringToLower(result);                         //--- Convert to lower case
       return result;                                 //--- Return result
    }
    
    //+------------------------------------------------------------------+
    //| Check if character is upper case                                 |
    //+------------------------------------------------------------------+
    bool IsUpperCaseCharacter(string character) {
       return character == ConvertToUpperCase(character) && character != ConvertToLowerCase(character); //--- Check and return if upper case
    }

Here, we add utility functions for handling string casing to support features like marking period opens with case swaps. The "ConvertToUpperCase" function copies the input string and applies [StringToUpper](/en/docs/strings/stringtoupper) to transform it entirely to uppercase before returning. Similarly, "ConvertToLowerCase" duplicates the string and uses [StringToLower](/en/docs/strings/stringtolower) for full lowercase conversion. To detect casing, "IsUpperCaseCharacter" checks if a single character matches its uppercase version via "ConvertToUpperCase" while differing from its lowercase form through "ConvertToLowerCase", returning true for uppercase letters. Next, we will change how the TPO characters are added to the levels since we now have options for the dots and square characters.
    
    
    //+------------------------------------------------------------------+
    //| Add TPO character to level                                       |
    //+------------------------------------------------------------------+
    void AddTpoCharacterToLevel(int sessionIndex, int levelIndex, int periodIndex) {
       if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if session index invalid
       if(levelIndex < 0 || levelIndex >= ArraySize(sessions[sessionIndex].levels)) return; //--- Return if level index invalid
       
       string tpoCharacter = "";                      //--- Initialize TPO character
       
       switch(tpoCharacterType) {                     //--- Switch on TPO character type
          case SQUARE:                                //--- Handle square case
             tpoCharacter = "■";                      //--- Set square character
             break;                                   //--- Exit case
          case CIRCLE:                                //--- Handle circle case
             tpoCharacter = "●";                      //--- Set circle character
             break;                                   //--- Exit case
          case ALPHABETIC:                            //--- Handle alphabetic case
             tpoCharacter = tpoCharacterSet[periodIndex % 52]; //--- Get alphabetic character
             
             if(markPeriodOpens != NONE && periodIndex < ArraySize(sessions[sessionIndex].periodOpens)) { //--- Check if mark opens and valid index
                double periodOpen = sessions[sessionIndex].periodOpens[periodIndex]; //--- Get period open
                double levelPrice = sessions[sessionIndex].levels[levelIndex].price; //--- Get level price
                
                if(MathAbs(levelPrice - periodOpen) < tpoPriceGridStep / 2) { //--- Check if matches open
                   if(markPeriodOpens == SWAP_CASE) {                         //--- Check swap case
                      if(IsUpperCaseCharacter(tpoCharacter))                  //--- Check if upper
                         tpoCharacter = ConvertToLowerCase(tpoCharacter);     //--- Convert to lower
                      else                                                    //--- Handle lower
                         tpoCharacter = ConvertToUpperCase(tpoCharacter);     //--- Convert to upper
                   } else if(markPeriodOpens == USE_ZERO) {                   //--- Check use zero
                      tpoCharacter = "0";                                     //--- Set zero character
                   }
                }
             }
             break;                                                           //--- Exit case
       }
       
       sessions[sessionIndex].levels[levelIndex].tpoString += tpoCharacter;   //--- Append character to TPO string
       sessions[sessionIndex].levels[levelIndex].tpoCount++;                  //--- Increment TPO count
    }
    

Here, we enhance the "AddTpoCharacterToLevel" function to incorporate customizable Time Price Opportunity representations and open marking, starting with index validations for the session and level using [ArraySize](/en/docs/array/arraysize) to exit early if invalid. We initialize an empty Time Price Opportunity character string, then use a switch on the "tpoCharacterType" enum: for "SQUARE" or "CIRCLE", assign fixed symbols like a block or dot; for "ALPHABETIC", select from the character set with modulo 52 on the period index. For the characters, we decided to use the hard-coded ones because they rendered better than the ones in [Wingdings symbols](https://en.wikipedia.org/wiki/Wingdings "https://en.wikipedia.org/wiki/Wingdings"), but you can still use them for dynamicity.

If alphabetic and "markPeriodOpens" is not "NONE" with a valid period opens array size, we compare the level price to the period open using [MathAbs](/en/docs/math/mathabs) within half the grid step tolerance; if matching, apply "SWAP_CASE" by checking with "IsUpperCaseCharacter" and toggling via "ConvertToLowerCase" or "ConvertToUpperCase", or set to zero for "USE_ZERO". Finally, append the character to the level's string and increment the Time Price Opportunity count to build the profile. We will now define another helper function to add spaces to TPO strings for splitting profiles if enabled, which will create a split view of the profile for clearer separation of periods when using letters.
    
    
    //+------------------------------------------------------------------+
    //| Pad levels for split profile                                     |
    //+------------------------------------------------------------------+
    void PadLevelsForSplitProfile(int sessionIndex) {
       if(!splitProfile || tpoCharacterType != ALPHABETIC) return;         //--- Return if not split or not alphabetic
       if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if index invalid
       
       int periodCount = sessions[sessionIndex].periodCount;               //--- Get period count
       int levelCount = ArraySize(sessions[sessionIndex].levels);          //--- Get level count
       
       for(int i = 0; i < levelCount; i++) {                               //--- Loop through levels
          int currentLength = StringLen(sessions[sessionIndex].levels[i].tpoString); //--- Get current length
          if(currentLength < periodCount) {                                //--- Check if needs padding
             for(int j = currentLength; j < periodCount; j++) {            //--- Loop to pad
                sessions[sessionIndex].levels[i].tpoString += " ";         //--- Add space
             }
          }
       }
    }

We introduce the "PadLevelsForSplitProfile" function to prepare alphabetic Time Price Opportunity strings for split profile views, exiting early if split mode is disabled or the character type is not alphabetic, or if the session index is invalid against the sessions array size. We retrieve the period count and level count, then loop through each level to check the current string length with [StringLen](/en/docs/strings/stringlen); if shorter than the period count, we pad it by appending spaces in an inner loop to align all strings to the same length, ensuring consistent spacing for visual separation in the rendered profile. Next, we will need to build a function to create a volume profile from levels and find the volume-based POC.
    
    
    //+------------------------------------------------------------------+
    //| Build volume profile and find POC                                |
    //+------------------------------------------------------------------+
    void BuildVolumeProfileAndFindPoc(int sessionIndex) {
       if(!highlightVolumeProfilePoc) {                //--- Check if not highlight VP POC
          if(sessionIndex >= 0 && sessionIndex < ArraySize(sessions)) //--- Check valid session
             sessions[sessionIndex].volumeProfilePocIndex = -1; //--- Reset VP POC index
          return;                                     //--- Return
       }
       
       if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if index invalid
       if(sessions[sessionIndex].startTime == 0) return; //--- Return if no start time
       
       ENUM_TIMEFRAMES lowerTimeframe = PERIOD_M1;    //--- Set default lower timeframe
       int currentTimeframeSeconds = PeriodSeconds(_Period); //--- Get current timeframe seconds
       
       if(currentTimeframeSeconds < 30 * 60) {        //--- Check for M1 lower
          lowerTimeframe = PERIOD_M1;                 //--- Set M1
       } else if(currentTimeframeSeconds < 60 * 60) { //--- Check for M3 lower
          lowerTimeframe = PERIOD_M3;                 //--- Set M3
       } else if(currentTimeframeSeconds == 60 * 60) {//--- Check for M10 lower
          lowerTimeframe = PERIOD_M10;                //--- Set M10
       } else {                                       //--- Default to H1
          lowerTimeframe = PERIOD_H1;                 //--- Set H1
       }
       
       if(PeriodSeconds(_Period) <= 60) {             //--- Check for 1-minute timeframe
          int size = ArraySize(sessions[sessionIndex].levels); //--- Get levels size
          for(int i = 0; i < size; i++) {             //--- Loop through levels
             int volumeProfileIndex = -1;             //--- Initialize VP index
             for(int j = 0; j < ArraySize(sessions[sessionIndex].volumeProfilePrices); j++) { //--- Loop through VP prices
                if(MathAbs(sessions[sessionIndex].volumeProfilePrices[j] - sessions[sessionIndex].levels[i].price) < _Point / 2) { //--- Check match
                   volumeProfileIndex = j;            //--- Set index
                   break;                             //--- Exit loop
                }
             }
             
             if(volumeProfileIndex == -1) {         //--- Check if new
                int volumeProfileSize = ArraySize(sessions[sessionIndex].volumeProfilePrices); //--- Get VP size
                ArrayResize(sessions[sessionIndex].volumeProfilePrices, volumeProfileSize + 1); //--- Resize prices
                ArrayResize(sessions[sessionIndex].volumeProfileVolumes, volumeProfileSize + 1); //--- Resize volumes
                sessions[sessionIndex].volumeProfilePrices[volumeProfileSize] = sessions[sessionIndex].levels[i].price; //--- Set price
                sessions[sessionIndex].volumeProfileVolumes[volumeProfileSize] = sessions[sessionIndex].levels[i].volume; //--- Set volume
             } else {                                 //--- Handle existing
                sessions[sessionIndex].volumeProfileVolumes[volumeProfileIndex] += sessions[sessionIndex].levels[i].volume; //--- Add volume
             }
          }
       } else {                                       //--- Handle higher timeframes
          datetime sessionEnd = (sessions[sessionIndex].endTime > 0) ? sessions[sessionIndex].endTime : TimeCurrent(); //--- Get session end
          
          int startBar = iBarShift(_Symbol, lowerTimeframe, sessions[sessionIndex].startTime); //--- Get start bar
          int endBar = iBarShift(_Symbol, lowerTimeframe, sessionEnd); //--- Get end bar
          
          if(startBar < 0 || endBar < 0) return;      //--- Return if invalid bars
          
          int barCount = startBar - endBar + 1;       //--- Calculate bar count
          if(barCount <= 0) return;                   //--- Return if no bars
          
          double highs[], lows[];                     //--- Declare highs and lows arrays
          long volumes[];                             //--- Declare volumes array
          
          ArraySetAsSeries(highs, true);              //--- Set highs as series
          ArraySetAsSeries(lows, true);               //--- Set lows as series
          ArraySetAsSeries(volumes, true);            //--- Set volumes as series
          
          if(CopyHigh(_Symbol, lowerTimeframe, endBar, barCount, highs) <= 0) return; //--- Copy highs
          if(CopyLow(_Symbol, lowerTimeframe, endBar, barCount, lows) <= 0) return; //--- Copy lows
          if(CopyTickVolume(_Symbol, lowerTimeframe, endBar, barCount, volumes) <= 0) return; //--- Copy volumes
          
          for(int i = 0; i < barCount; i++) {         //--- Loop through bars
             double quantizedHigh = QuantizePriceToGrid(highs[i]); //--- Quantize high
             double quantizedLow = QuantizePriceToGrid(lows[i]); //--- Quantize low
             
             int priceCount = (int)MathMax(1, (quantizedHigh - quantizedLow) / tpoPriceGridStep + 1); //--- Calculate price count
             double volumePerLevel = (double)volumes[i] / priceCount; //--- Calculate volume per level
             
             for(double price = quantizedLow; price <= quantizedHigh; price += tpoPriceGridStep) { //--- Loop through prices
                int volumeProfileIndex = -1;          //--- Initialize VP index
                for(int j = 0; j < ArraySize(sessions[sessionIndex].volumeProfilePrices); j++) { //--- Loop through VP prices
                   if(MathAbs(sessions[sessionIndex].volumeProfilePrices[j] - price) < _Point / 2) { //--- Check match
                      volumeProfileIndex = j;         //--- Set index
                      break;                          //--- Exit loop
                   }
                }
                
                if(volumeProfileIndex == -1) {      //--- Check if new
                   int volumeProfileSize = ArraySize(sessions[sessionIndex].volumeProfilePrices); //--- Get VP size
                   ArrayResize(sessions[sessionIndex].volumeProfilePrices, volumeProfileSize + 1); //--- Resize prices
                   ArrayResize(sessions[sessionIndex].volumeProfileVolumes, volumeProfileSize + 1); //--- Resize volumes
                   sessions[sessionIndex].volumeProfilePrices[volumeProfileSize] = price; //--- Set price
                   sessions[sessionIndex].volumeProfileVolumes[volumeProfileSize] = volumePerLevel; //--- Set volume
                } else {                              //--- Handle existing
                   sessions[sessionIndex].volumeProfileVolumes[volumeProfileIndex] += volumePerLevel; //--- Add volume
                }
             }
          }
       }
       
       double maxVolume = 0;                          //--- Initialize max volume
       double volumeProfilePocPrice = 0;              //--- Initialize VP POC price
       
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
             break;                                    //--- Exit loop
          }
       }
    }
    

We implement the "BuildVolumeProfileAndFindPoc" function to construct a separate volume profile for highlighting the volume-based point of control, first checking if the feature is enabled via "highlightVolumeProfilePoc"; if not, we reset the index for valid sessions and exit early. After validating the session index with "ArraySize" and ensuring a start time exists, we select a lower timeframe dynamically using [PeriodSeconds](/en/docs/common/periodseconds) on the current period: setting it to [PERIOD_M1](/en/docs/constants/chartconstants/enum_timeframes) for under 30 minutes, "PERIOD_M3" for under an hour, "PERIOD_M10" for exactly an hour, or "PERIOD_H1" otherwise, to access finer-grained data for accurate volume distribution. If the current period is 60 seconds or less, we loop through existing levels, searching for matching prices in the volume profile arrays with [MathAbs](/en/docs/math/mathabs) tolerance of half a point; if not found, resize the arrays via [ArrayResize](/en/docs/array/arrayresize) and add the price and volume, or accumulate volume if matching.

For higher timeframes, we determine the session end as the set end time or current time from [TimeCurrent](/en/docs/dateandtime/timecurrent), get start and end bar indices with [iBarShift](/en/docs/series/ibarshift) on the lower timeframe, and if valid with a positive count, declare and set series arrays for highs, lows, and volumes. We copy data using [CopyHigh](/en/docs/series/copyhigh), "CopyLow", and [CopyTickVolume](/en/docs/series/copytickvolume) from the end bar onward, then iterate through bars: quantize high and low via "QuantizePriceToGrid", calculate price steps ensuring at least one, divide bar volume evenly per level, and loop through the price range to add or accumulate in the volume profile arrays similarly, using tolerance checks. 

To identify the volume point of control, we initialize max volume and price to zero, scan the volume array to update for the highest value, reset the index, and map the max price back to the closest level index with tolerance, storing it if found, enabling volume-driven highlighting in rendering. We can now compute VWAP from price levels' volumes. Like finding the average price weighted by how much was traded.
    
    
    //+------------------------------------------------------------------+
    //| Calculate session VWAP                                           |
    //+------------------------------------------------------------------+
    void CalculateSessionVwap(int sessionIndex) {
       if(!highlightSessionVwap) return;              //--- Return if not highlight VWAP
       if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if index invalid
       
       double sumPriceVolume = 0;                     //--- Initialize sum price volume
       double sumVolume = 0;                          //--- Initialize sum volume
       
       int size = ArraySize(sessions[sessionIndex].levels); //--- Get levels size
       for(int i = 0; i < size; i++) {                //--- Loop through levels
          sumPriceVolume += sessions[sessionIndex].levels[i].price * sessions[sessionIndex].levels[i].volume; //--- Accumulate price volume
          sumVolume += sessions[sessionIndex].levels[i].volume; //--- Accumulate volume
       }
       
       if(sumVolume > 0)                              //--- Check if volume positive
          sessions[sessionIndex].vwap = sumPriceVolume / sumVolume; //--- Calculate VWAP
    }

To determine the volume-weighted average price for a session, we implement the "CalculateSessionVwap" function, returning early if not or if the session index falls outside valid bounds. We set up accumulators for the sum of price-volume products and total volume, then iterate through the levels to multiply each price by its volume for the product sum and add up the volumes. Provided the total volume exceeds zero, we compute and store the weighted average in the session's vwap field as the product sum divided by the volume sum. With that done, we have all the helpers to aid in computations; we just need to take care of the visual rendering now, for data presentation. First, we will add a function to highlight the open TPO character if alphabetic. Like putting a spotlight on the starting letter. Not necessary, but will enhance quick visual identification.
    
    
    //+------------------------------------------------------------------+
    //| Render open TPO highlight                                        |
    //+------------------------------------------------------------------+
    void RenderOpenTpoHighlight(int sessionIndex, int openLevelIndex, string &displayStrings[]) {
       if(tpoCharacterType != ALPHABETIC) return;                          //--- Return if not alphabetic
       if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if session invalid
       if(openLevelIndex < 0 || openLevelIndex >= ArraySize(sessions[sessionIndex].levels)) return; //--- Return if level invalid
       
       string fullString = displayStrings[openLevelIndex];                 //--- Get full display string
       if(StringLen(fullString) == 0) return;                              //--- Return if empty string
       
       string openCharacter = StringSubstr(fullString, 0, 1);              //--- Extract open character
       string remainingCharacters = StringSubstr(fullString, 1);           //--- Extract remaining characters
       
       string objectName = objectPrefix + "OpenTPO_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create object name
       int barIndex = iBarShift(_Symbol, _Period, sessions[sessionIndex].startTime); //--- Get bar index
       if(barIndex < 0) return;                                            //--- Return if invalid bar index
       
       datetime labelTime = iTime(_Symbol, _Period, barIndex);             //--- Get label time
       int x, y;                                                           //--- Declare coordinates
       ChartTimePriceToXY(0, 0, labelTime, sessions[sessionIndex].levels[openLevelIndex].price, x, y); //--- Convert to XY
       
       if(ObjectFind(0, objectName) < 0) {                                 //--- Check if object not found
          ObjectCreate(0, objectName, OBJ_LABEL, 0, 0, 0);                 //--- Create label object
       }
       
       ObjectSetInteger(0, objectName, OBJPROP_XDISTANCE, x);              //--- Set X distance
       ObjectSetInteger(0, objectName, OBJPROP_YDISTANCE, y);              //--- Set Y distance
       ObjectSetInteger(0, objectName, OBJPROP_CORNER, CORNER_LEFT_UPPER); //--- Set corner
       ObjectSetInteger(0, objectName, OBJPROP_ANCHOR, ANCHOR_LEFT);       //--- Set anchor
       ObjectSetInteger(0, objectName, OBJPROP_COLOR, openColor);          //--- Set color
       ObjectSetInteger(0, objectName, OBJPROP_FONTSIZE, labelFontSize);   //--- Set font size
       ObjectSetString(0, objectName, OBJPROP_FONT, "Arial");              //--- Set font
       ObjectSetString(0, objectName, OBJPROP_TEXT, openCharacter);        //--- Set text
       ObjectSetInteger(0, objectName, OBJPROP_SELECTABLE, false);         //--- Set selectable false
       ObjectSetInteger(0, objectName, OBJPROP_HIDDEN, true);              //--- Set hidden true
       
       if(StringLen(remainingCharacters) > 0) {                            //--- Check if remaining
          displayStrings[openLevelIndex] = " " + remainingCharacters;      //--- Prepend space
       } else {                                                            //--- Handle no remaining
          displayStrings[openLevelIndex] = " ";                            //--- Set space
       }
    }

Here, we add the "RenderOpenTpoHighlight" function to visually emphasize the opening Time Price Opportunity character in alphabetic mode, returning early if the character type is not alphabetic or if session and open level indices are invalid against array sizes. We fetch the display string for the open level, exiting if empty per [StringLen](/en/docs/strings/stringlen), then extract the first character as the open marker using [StringSubstr](/en/docs/strings/stringsubstr) and the rest as remaining. An object name is built combining the prefix with the session start time via [IntegerToString](/en/docs/convert/IntegerToString), and we get the bar index with "iBarShift", returning if invalid. We obtain the label time through "iTime", convert time-price to coordinates using [ChartTimePriceToXY](/en/docs/chart_operations/charttimepricetoxy), and if the object is missing per "ObjectFind", create a label with [ObjectCreate](/en/docs/objects/objectcreate) and [OBJ_LABEL](/en/docs/constants/objectconstants/enum_object/obj_label).

We set its position, corner, anchor, input open color, dynamic font size, Arial font, open character text, and non-selectable/hidden properties via [ObjectSetInteger](/en/docs/objects/objectsetinteger) and "ObjectSetString". Finally, update the display string by prepending a space to remaining characters if any, or setting a single space otherwise, to maintain alignment in the profile rendering. Next thing we will do is render the profile border lines, initial balance lines, and key level extensions.
    
    
    //+------------------------------------------------------------------+
    //| Render profile border line                                       |
    //+------------------------------------------------------------------+
    void RenderProfileBorderLine(int sessionIndex, int barIndex) {
       if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if index invalid
       if(sessions[sessionIndex].sessionHigh == 0 || sessions[sessionIndex].sessionLow == 0) return; //--- Return if no high low
       
       datetime startTime = iTime(_Symbol, _Period, barIndex);             //--- Get start time
       
       color backgroundEdgeColor = 0x606D79;                               //--- Set background edge color
       color initialBalanceEdgeColor = initialBalanceHighlightColor;       //--- Set IB edge color
       
       if(initialBalancePeriods > 0 && sessions[sessionIndex].initialBalanceHigh > 0 && sessions[sessionIndex].initialBalanceLow > 0) { //--- Check IB
          
          string edge1Name = objectPrefix + "Edge1_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create edge1 name
          if(ObjectFind(0, edge1Name) < 0) {                               //--- Check if not found
             ObjectCreate(0, edge1Name, OBJ_TREND, 0, startTime, sessions[sessionIndex].sessionLow, 
                          startTime, sessions[sessionIndex].initialBalanceLow); //--- Create trend
             ObjectSetInteger(0, edge1Name, OBJPROP_RAY_RIGHT, false);     //--- Set ray right false
             ObjectSetInteger(0, edge1Name, OBJPROP_SELECTABLE, false);    //--- Set selectable false
             ObjectSetInteger(0, edge1Name, OBJPROP_HIDDEN, true);         //--- Set hidden true
          }
          ObjectSetDouble(0, edge1Name, OBJPROP_PRICE, 0, sessions[sessionIndex].sessionLow); //--- Set price 0
          ObjectSetDouble(0, edge1Name, OBJPROP_PRICE, 1, sessions[sessionIndex].initialBalanceLow); //--- Set price 1
          ObjectSetInteger(0, edge1Name, OBJPROP_COLOR, backgroundEdgeColor); //--- Set color
          ObjectSetInteger(0, edge1Name, OBJPROP_WIDTH, 3);                //--- Set width
          ObjectSetInteger(0, edge1Name, OBJPROP_STYLE, STYLE_SOLID);      //--- Set style
          
          string edge2Name = objectPrefix + "Edge2_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create edge2 name
          if(ObjectFind(0, edge2Name) < 0) {                               //--- Check if not found
             ObjectCreate(0, edge2Name, OBJ_TREND, 0, startTime, sessions[sessionIndex].initialBalanceLow, 
                          startTime, sessions[sessionIndex].initialBalanceHigh); //--- Create trend
             ObjectSetInteger(0, edge2Name, OBJPROP_RAY_RIGHT, false);     //--- Set ray right false
             ObjectSetInteger(0, edge2Name, OBJPROP_SELECTABLE, false);    //--- Set selectable false
             ObjectSetInteger(0, edge2Name, OBJPROP_HIDDEN, true);         //--- Set hidden true
          }
          ObjectSetDouble(0, edge2Name, OBJPROP_PRICE, 0, sessions[sessionIndex].initialBalanceLow);  //--- Set price 0
          ObjectSetDouble(0, edge2Name, OBJPROP_PRICE, 1, sessions[sessionIndex].initialBalanceHigh); //--- Set price 1
          ObjectSetInteger(0, edge2Name, OBJPROP_COLOR, initialBalanceEdgeColor);                     //--- Set color
          ObjectSetInteger(0, edge2Name, OBJPROP_WIDTH, 3);                //--- Set width
          ObjectSetInteger(0, edge2Name, OBJPROP_STYLE, STYLE_SOLID);      //--- Set style
          
          string edge3Name = objectPrefix + "Edge3_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create edge3 name
          if(ObjectFind(0, edge3Name) < 0) {                               //--- Check if not found
             ObjectCreate(0, edge3Name, OBJ_TREND, 0, startTime, sessions[sessionIndex].initialBalanceHigh, 
                          startTime, sessions[sessionIndex].sessionHigh);  //--- Create trend
             ObjectSetInteger(0, edge3Name, OBJPROP_RAY_RIGHT, false);     //--- Set ray right false
             ObjectSetInteger(0, edge3Name, OBJPROP_SELECTABLE, false);    //--- Set selectable false
             ObjectSetInteger(0, edge3Name, OBJPROP_HIDDEN, true);         //--- Set hidden true
          }
          ObjectSetDouble(0, edge3Name, OBJPROP_PRICE, 0, sessions[sessionIndex].initialBalanceHigh);   //--- Set price 0
          ObjectSetDouble(0, edge3Name, OBJPROP_PRICE, 1, sessions[sessionIndex].sessionHigh);          //--- Set price 1
          ObjectSetInteger(0, edge3Name, OBJPROP_COLOR, backgroundEdgeColor);                           //--- Set color
          ObjectSetInteger(0, edge3Name, OBJPROP_WIDTH, 3);                                             //--- Set width
          ObjectSetInteger(0, edge3Name, OBJPROP_STYLE, STYLE_SOLID);                                   //--- Set style
          
       } else {                                                                                         //--- Handle no IB
          string edgeName = objectPrefix + "Edge_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create edge name
          if(ObjectFind(0, edgeName) < 0) {                                                             //--- Check if not found
             ObjectCreate(0, edgeName, OBJ_TREND, 0, startTime, sessions[sessionIndex].sessionLow, 
                          startTime, sessions[sessionIndex].sessionHigh);                               //--- Create trend
             ObjectSetInteger(0, edgeName, OBJPROP_RAY_RIGHT, false);                                   //--- Set ray right false
             ObjectSetInteger(0, edgeName, OBJPROP_SELECTABLE, false);                                  //--- Set selectable false
             ObjectSetInteger(0, edgeName, OBJPROP_HIDDEN, true);                                       //--- Set hidden true
          }
          ObjectSetDouble(0, edgeName, OBJPROP_PRICE, 0, sessions[sessionIndex].sessionLow);            //--- Set price 0
          ObjectSetDouble(0, edgeName, OBJPROP_PRICE, 1, sessions[sessionIndex].sessionHigh);           //--- Set price 1
          ObjectSetInteger(0, edgeName, OBJPROP_COLOR, backgroundEdgeColor);                            //--- Set color
          ObjectSetInteger(0, edgeName, OBJPROP_WIDTH, 3);                                              //--- Set width
          ObjectSetInteger(0, edgeName, OBJPROP_STYLE, STYLE_SOLID);                                    //--- Set style
       }
    }
    
    //+------------------------------------------------------------------+
    //| Render initial balance lines                                     |
    //+------------------------------------------------------------------+
    void RenderInitialBalanceLines(int sessionIndex, int barIndex) {
       if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return;       //--- Return if index invalid
       if(sessions[sessionIndex].initialBalanceHigh == 0 || sessions[sessionIndex].initialBalanceLow == 0) return; //--- Return if no IB
       
       datetime startTime = iTime(_Symbol, _Period, barIndex);                   //--- Get start time
       
       string initialBalanceHighName = objectPrefix + "IB_High_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create IB high name
       if(ObjectFind(0, initialBalanceHighName) < 0) { //--- Check if not found
          ObjectCreate(0, initialBalanceHighName, OBJ_TREND, 0, startTime, sessions[sessionIndex].initialBalanceHigh, 
                       startTime, sessions[sessionIndex].initialBalanceHigh);     //--- Create trend
          ObjectSetInteger(0, initialBalanceHighName, OBJPROP_RAY_RIGHT, false);  //--- Set ray right false
          ObjectSetInteger(0, initialBalanceHighName, OBJPROP_SELECTABLE, false); //--- Set selectable false
          ObjectSetInteger(0, initialBalanceHighName, OBJPROP_HIDDEN, true);      //--- Set hidden true
       }
       ObjectSetInteger(0, initialBalanceHighName, OBJPROP_COLOR, initialBalanceHighlightColor); //--- Set color
       ObjectSetInteger(0, initialBalanceHighName, OBJPROP_WIDTH, initialBalanceLineWidth);      //--- Set width
       
       string initialBalanceLowName = objectPrefix + "IB_Low_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create IB low name
       if(ObjectFind(0, initialBalanceLowName) < 0) { //--- Check if not found
          ObjectCreate(0, initialBalanceLowName, OBJ_TREND, 0, startTime, sessions[sessionIndex].initialBalanceLow, 
                       startTime, sessions[sessionIndex].initialBalanceLow);      //--- Create trend
          ObjectSetInteger(0, initialBalanceLowName, OBJPROP_RAY_RIGHT, false);   //--- Set ray right false
          ObjectSetInteger(0, initialBalanceLowName, OBJPROP_SELECTABLE, false);  //--- Set selectable false
          ObjectSetInteger(0, initialBalanceLowName, OBJPROP_HIDDEN, true);       //--- Set hidden true
       }
       ObjectSetInteger(0, initialBalanceLowName, OBJPROP_COLOR, initialBalanceHighlightColor); //--- Set color
       ObjectSetInteger(0, initialBalanceLowName, OBJPROP_WIDTH, initialBalanceLineWidth);      //--- Set width
    }
    
    //+------------------------------------------------------------------+
    //| Render key level extensions                                      |
    //+------------------------------------------------------------------+
    void RenderKeyLevelExtensions(int sessionIndex, int barIndex, int valueAreaUpperIndex, int valueAreaLowerIndex) {
       if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if index invalid
       if(ArraySize(sessions[sessionIndex].levels) == 0) return;           //--- Return if no levels
       
       datetime startTime = iTime(_Symbol, _Period, barIndex);             //--- Get start time
       
       bool isCurrentSession = (sessionIndex == ArraySize(sessions) - 1);  //--- Check if current session
       
       datetime endTime;                                                   //--- Declare end time
       bool rayRight;                                                      //--- Declare ray right
       
       if(isCurrentSession) {                                              //--- Handle current session
          endTime = startTime + PeriodSeconds(_Period) * 100;              //--- Set end time
          rayRight = true;                                                 //--- Set ray right true
       } else {                                                            //--- Handle past session
          if(sessionIndex + 1 < ArraySize(sessions)) {                     //--- Check next session
             int nextBarIndex = iBarShift(_Symbol, _Period, sessions[sessionIndex + 1].startTime); //--- Get next bar
             endTime = iTime(_Symbol, _Period, nextBarIndex);              //--- Set end time
          } else {                                                         //--- Handle last
             endTime = startTime + PeriodSeconds(_Period) * 100;           //--- Set end time
          }
          rayRight = false;                                                //--- Set ray right false
       }
       
       if(sessions[sessionIndex].volumeProfilePocIndex >= 0 && sessions[sessionIndex].volumeProfilePocIndex < ArraySize(sessions[sessionIndex].levels)) { //--- Check VP POC
          double pocPrice = sessions[sessionIndex].levels[sessions[sessionIndex].volumeProfilePocIndex].price; //--- Get POC price
          string pocExtensionName = objectPrefix + "POC_Ext_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create POC ext name
          if(ObjectFind(0, pocExtensionName) < 0) {                             //--- Check if not found
             ObjectCreate(0, pocExtensionName, OBJ_TREND, 0, startTime, pocPrice, endTime, pocPrice); //--- Create trend
             ObjectSetInteger(0, pocExtensionName, OBJPROP_SELECTABLE, false);  //--- Set selectable false
             ObjectSetInteger(0, pocExtensionName, OBJPROP_HIDDEN, true);       //--- Set hidden true
          } else {                                    //--- Handle existing
             ObjectSetInteger(0, pocExtensionName, OBJPROP_TIME, 0, startTime); //--- Set time 0
             ObjectSetDouble(0, pocExtensionName, OBJPROP_PRICE, 0, pocPrice);  //--- Set price 0
             ObjectSetInteger(0, pocExtensionName, OBJPROP_TIME, 1, endTime);   //--- Set time 1
             ObjectSetDouble(0, pocExtensionName, OBJPROP_PRICE, 1, pocPrice);  //--- Set price 1
          }
          ObjectSetInteger(0, pocExtensionName, OBJPROP_RAY_RIGHT, rayRight);   //--- Set ray right
          ObjectSetInteger(0, pocExtensionName, OBJPROP_COLOR, pocExtensionColor); //--- Set color
          ObjectSetInteger(0, pocExtensionName, OBJPROP_WIDTH, 2);              //--- Set width
          ObjectSetInteger(0, pocExtensionName, OBJPROP_STYLE, STYLE_SOLID);    //--- Set style
       }
       
       if(valueAreaUpperIndex >= 0 && valueAreaUpperIndex < ArraySize(sessions[sessionIndex].levels)) { //--- Check VAH
          double valueAreaHighPrice = sessions[sessionIndex].levels[valueAreaUpperIndex].price;         //--- Get VAH price
          string valueAreaHighExtensionName = objectPrefix + "VAH_Ext_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create VAH ext name
          if(ObjectFind(0, valueAreaHighExtensionName) < 0) {                                           //--- Check if not found
             ObjectCreate(0, valueAreaHighExtensionName, OBJ_TREND, 0, startTime, valueAreaHighPrice, endTime, valueAreaHighPrice); //--- Create trend
             ObjectSetInteger(0, valueAreaHighExtensionName, OBJPROP_SELECTABLE, false);                //--- Set selectable false
             ObjectSetInteger(0, valueAreaHighExtensionName, OBJPROP_HIDDEN, true);                     //--- Set hidden true
          } else {                                    //--- Handle existing
             ObjectSetInteger(0, valueAreaHighExtensionName, OBJPROP_TIME, 0, startTime);               //--- Set time 0
             ObjectSetDouble(0, valueAreaHighExtensionName, OBJPROP_PRICE, 0, valueAreaHighPrice);      //--- Set price 0
             ObjectSetInteger(0, valueAreaHighExtensionName, OBJPROP_TIME, 1, endTime);                 //--- Set time 1
             ObjectSetDouble(0, valueAreaHighExtensionName, OBJPROP_PRICE, 1, valueAreaHighPrice);      //--- Set price 1
          }
          ObjectSetInteger(0, valueAreaHighExtensionName, OBJPROP_RAY_RIGHT, rayRight);                 //--- Set ray right
          ObjectSetInteger(0, valueAreaHighExtensionName, OBJPROP_COLOR, valueAreaHighExtensionColor);  //--- Set color
          ObjectSetInteger(0, valueAreaHighExtensionName, OBJPROP_WIDTH, 1);                            //--- Set width
          ObjectSetInteger(0, valueAreaHighExtensionName, OBJPROP_STYLE, STYLE_DOT);                    //--- Set style
       }
       
       if(valueAreaLowerIndex >= 0 && valueAreaLowerIndex < ArraySize(sessions[sessionIndex].levels)) { //--- Check VAL
          double valueAreaLowPrice = sessions[sessionIndex].levels[valueAreaLowerIndex].price;          //--- Get VAL price
          string valueAreaLowExtensionName = objectPrefix + "VAL_Ext_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create VAL ext name
          if(ObjectFind(0, valueAreaLowExtensionName) < 0) {                                            //--- Check if not found
             ObjectCreate(0, valueAreaLowExtensionName, OBJ_TREND, 0, startTime, valueAreaLowPrice, endTime, valueAreaLowPrice); //--- Create trend
             ObjectSetInteger(0, valueAreaLowExtensionName, OBJPROP_SELECTABLE, false);                 //--- Set selectable false
             ObjectSetInteger(0, valueAreaLowExtensionName, OBJPROP_HIDDEN, true);                      //--- Set hidden true
          } else {                                                                                      //--- Handle existing
             ObjectSetInteger(0, valueAreaLowExtensionName, OBJPROP_TIME, 0, startTime);                //--- Set time 0
             ObjectSetDouble(0, valueAreaLowExtensionName, OBJPROP_PRICE, 0, valueAreaLowPrice);        //--- Set price 0
             ObjectSetInteger(0, valueAreaLowExtensionName, OBJPROP_TIME, 1, endTime);                  //--- Set time 1
             ObjectSetDouble(0, valueAreaLowExtensionName, OBJPROP_PRICE, 1, valueAreaLowPrice);        //--- Set price 1
          }
          ObjectSetInteger(0, valueAreaLowExtensionName, OBJPROP_RAY_RIGHT, rayRight);                  //--- Set ray right
          ObjectSetInteger(0, valueAreaLowExtensionName, OBJPROP_COLOR, valueAreaLowExtensionColor);    //--- Set color
          ObjectSetInteger(0, valueAreaLowExtensionName, OBJPROP_WIDTH, 1);                             //--- Set width
          ObjectSetInteger(0, valueAreaLowExtensionName, OBJPROP_STYLE, STYLE_DOT);                     //--- Set style
       }
       
       string highExtensionName = objectPrefix + "High_Ext_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create high ext name
       if(ObjectFind(0, highExtensionName) < 0) {                                                       //--- Check if not found
          ObjectCreate(0, highExtensionName, OBJ_TREND, 0, startTime, sessions[sessionIndex].sessionHigh, 
                       endTime, sessions[sessionIndex].sessionHigh);                                    //--- Create trend
          ObjectSetInteger(0, highExtensionName, OBJPROP_SELECTABLE, false);                            //--- Set selectable false
          ObjectSetInteger(0, highExtensionName, OBJPROP_HIDDEN, true);                                 //--- Set hidden true
          ObjectSetInteger(0, highExtensionName, OBJPROP_STYLE, STYLE_DOT);                             //--- Set style
       } else {                                                                                         //--- Handle existing
          ObjectSetInteger(0, highExtensionName, OBJPROP_TIME, 0, startTime);                           //--- Set time 0
          ObjectSetDouble(0, highExtensionName, OBJPROP_PRICE, 0, sessions[sessionIndex].sessionHigh);  //--- Set price 0
          ObjectSetInteger(0, highExtensionName, OBJPROP_TIME, 1, endTime);                             //--- Set time 1
          ObjectSetDouble(0, highExtensionName, OBJPROP_PRICE, 1, sessions[sessionIndex].sessionHigh);  //--- Set price 1
       }
       ObjectSetInteger(0, highExtensionName, OBJPROP_RAY_RIGHT, rayRight);       //--- Set ray right
       ObjectSetInteger(0, highExtensionName, OBJPROP_COLOR, highExtensionColor); //--- Set color
       ObjectSetInteger(0, highExtensionName, OBJPROP_WIDTH, 1);                  //--- Set width
       
       string lowExtensionName = objectPrefix + "Low_Ext_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create low ext name
       if(ObjectFind(0, lowExtensionName) < 0) {                                                                //--- Check if not found
          ObjectCreate(0, lowExtensionName, OBJ_TREND, 0, startTime, sessions[sessionIndex].sessionLow, 
                       endTime, sessions[sessionIndex].sessionLow);                                             //--- Create trend
          ObjectSetInteger(0, lowExtensionName, OBJPROP_SELECTABLE, false);                                     //--- Set selectable false
          ObjectSetInteger(0, lowExtensionName, OBJPROP_HIDDEN, true);                                          //--- Set hidden true
          ObjectSetInteger(0, lowExtensionName, OBJPROP_STYLE, STYLE_DOT);                                      //--- Set style
       } else {                                                                                                 //--- Handle existing
          ObjectSetInteger(0, lowExtensionName, OBJPROP_TIME, 0, startTime);                                    //--- Set time 0
          ObjectSetDouble(0, lowExtensionName, OBJPROP_PRICE, 0, sessions[sessionIndex].sessionLow);            //--- Set price 0
          ObjectSetInteger(0, lowExtensionName, OBJPROP_TIME, 1, endTime);                                      //--- Set time 1
          ObjectSetDouble(0, lowExtensionName, OBJPROP_PRICE, 1, sessions[sessionIndex].sessionLow);            //--- Set price 1
       }
       ObjectSetInteger(0, lowExtensionName, OBJPROP_RAY_RIGHT, rayRight);      //--- Set ray right
       ObjectSetInteger(0, lowExtensionName, OBJPROP_COLOR, lowExtensionColor); //--- Set color
       ObjectSetInteger(0, lowExtensionName, OBJPROP_WIDTH, 1);                 //--- Set width
       
       double midpointPrice = 0;                      //--- Initialize midpoint price
       if(midpointAlgorithm == HIGH_LOW_MID) {        //--- Check high low mid
          midpointPrice = sessions[sessionIndex].sessionHigh - (sessions[sessionIndex].sessionHigh - sessions[sessionIndex].sessionLow) / 2; //--- Calculate midpoint
       } else {                                       //--- Handle TPO count based
          int totalTpoCount = GetTotalTpoCount(sessionIndex); //--- Get total TPO
          int targetTpoCount = totalTpoCount / 2;     //--- Calculate target
          int currentTpoCount = 0;                    //--- Initialize current
          
          for(int i = 0; i < ArraySize(sessions[sessionIndex].levels); i++) { //--- Loop through levels
             currentTpoCount += sessions[sessionIndex].levels[i].tpoCount; //--- Accumulate TPO
             if(currentTpoCount >= targetTpoCount) {  //--- Check if reached
                midpointPrice = sessions[sessionIndex].levels[i].price; //--- Set midpoint
                break;                                //--- Exit loop
             }
          }
       }
       
       if(midpointPrice > 0) {                        //--- Check if midpoint set
          string midpointExtensionName = objectPrefix + "Mid_Ext_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create mid ext name
          if(ObjectFind(0, midpointExtensionName) < 0) { //--- Check if not found
             ObjectCreate(0, midpointExtensionName, OBJ_TREND, 0, startTime, midpointPrice, endTime, midpointPrice); //--- Create trend
             ObjectSetInteger(0, midpointExtensionName, OBJPROP_SELECTABLE, false);  //--- Set selectable false
             ObjectSetInteger(0, midpointExtensionName, OBJPROP_HIDDEN, true);       //--- Set hidden true
             ObjectSetInteger(0, midpointExtensionName, OBJPROP_STYLE, STYLE_DOT);   //--- Set style
          } else {                                                                   //--- Handle existing
             ObjectSetInteger(0, midpointExtensionName, OBJPROP_TIME, 0, startTime); //--- Set time 0
             ObjectSetDouble(0, midpointExtensionName, OBJPROP_PRICE, 0, midpointPrice); //--- Set price 0
             ObjectSetInteger(0, midpointExtensionName, OBJPROP_TIME, 1, endTime);   //--- Set time 1
             ObjectSetDouble(0, midpointExtensionName, OBJPROP_PRICE, 1, midpointPrice); //--- Set price 1
          }
          ObjectSetInteger(0, midpointExtensionName, OBJPROP_RAY_RIGHT, rayRight);   //--- Set ray right
          ObjectSetInteger(0, midpointExtensionName, OBJPROP_COLOR, midpointExtensionColor); //--- Set color
          ObjectSetInteger(0, midpointExtensionName, OBJPROP_WIDTH, 1);              //--- Set width
       }
    }

We introduce the "RenderProfileBorderLine" function to draw vertical border lines outlining the session's price range on the chart, validating the session index, and ensuring high and low prices exist before proceeding. We retrieve the start time with [iTime](/en/docs/series/itime) and set colors for background edges and initial balance highlights. If initial balance periods are positive and values are set, we create or update three trend line segments using "ObjectCreate" with [OBJ_TREND](/en/docs/constants/objectconstants/enum_object/obj_trend): one from session low to initial balance low with background color, another from initial balance low to high with the highlight color, and the last from initial balance high to session high with background color, each configured via [ObjectFind](/en/docs/objects/objectfind), "ObjectSetDouble" for prices, [ObjectSetInteger](/en/docs/objects/objectsetinteger) for no ray extension, non-selectable, hidden, solid style, and width 3. Otherwise, for no initial balance, we draw a single trend line from low to high with the background color and the same properties.

Next, the "RenderInitialBalanceLines" function visualizes the initial balance range if values are available, fetching the start time and creating or updating two horizontal trend lines for high and low via [ObjectCreate](/en/docs/objects/objectcreate) with "OBJ_TREND" at the same coordinates, setting no ray, non-selectable, hidden, input highlight color, and line width.

To project important levels forward, we implement the "RenderKeyLevelExtensions" function, first checking validity and getting the start time, then determining if it's the current session to set an extended end time with ray enabled or use the next session's start for past ones without ray, using [PeriodSeconds](/en/docs/common/periodseconds), "TimeCurrent", and "iBarShift" for calculations. For the volume profile point of control, if valid, we draw a solid line at its price with input extension color and width 2. Similarly, for value area high and low, if indices are in range, create dotted lines with their respective colors and a width of 1. 

We always add dotted extensions for session high and low with input colors. For the midpoint, calculate it based on the "midpointAlgorithm" enumeration—either simple range midpoint or by accumulating Time Price Opportunity counts via "GetTotalTpoCount" to find the halfway level—and if positive, render a dotted line with the midpoint color, all using "ObjectSetInteger" for times, [ObjectSetDouble](/en/docs/objects/objectsetdouble) for prices, ray, style, and other properties after checking or creating it using same approach as the others. The next thing we will need to do is define a logic to show volume numbers next to levels in fixed mode, colored by intensity. Like labeling how busy each price was.
    
    
    //+------------------------------------------------------------------+
    //| Render fixed range volume labels                                 |
    //+------------------------------------------------------------------+
    void RenderFixedRangeVolumeLabels(int sessionIndex, int barIndex) {
       if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return;     //--- Return if index invalid
       if(ArraySize(sessions[sessionIndex].volumeProfilePrices) == 0) return;  //--- Return if no VP prices
       
       double maxVolume = 0;                                                   //--- Initialize max volume
       for(int i = 0; i < ArraySize(sessions[sessionIndex].volumeProfileVolumes); i++) { //--- Loop through volumes
          if(sessions[sessionIndex].volumeProfileVolumes[i] > maxVolume)       //--- Check if max
             maxVolume = sessions[sessionIndex].volumeProfileVolumes[i];       //--- Update max
       }
       
       if(maxVolume == 0) return;                                              //--- Return if no volume
       
       datetime labelTime = iTime(_Symbol, _Period, barIndex);                 //--- Get label time
       
       for(int i = 0; i < ArraySize(sessions[sessionIndex].volumeProfilePrices); i++) { //--- Loop through VP prices
          double price = sessions[sessionIndex].volumeProfilePrices[i];        //--- Get price
          double volumeValue = sessions[sessionIndex].volumeProfileVolumes[i]; //--- Get volume
          double ratio = volumeValue / maxVolume;     //--- Calculate ratio
          
          color volumeColor;                          //--- Declare color
          int percent = (int)(100 * ratio);           //--- Calculate percent
          
          if(percent <= 8) {                          //--- Check low percent
             volumeColor = singlePrintColor;          //--- Set single print color
          } else {                                    //--- Handle higher
             int transparency = (int)MathMax(0, 80 - percent);                     //--- Calculate transparency
             volumeColor = ApplyTransparencyToColor(valueAreaColor, transparency); //--- Apply transparency
          }
          
          string objectName = objectPrefix + "Vol_" + IntegerToString(sessions[sessionIndex].startTime) + "_" + IntegerToString(i); //--- Create object name
          
          int x, y;                                           //--- Declare coordinates
          ChartTimePriceToXY(0, 0, labelTime, price, x, y);   //--- Convert to XY
          
          if(ObjectFind(0, objectName) < 0) {                 //--- Check if not found
             ObjectCreate(0, objectName, OBJ_LABEL, 0, 0, 0); //--- Create label
          }
          
          ObjectSetInteger(0, objectName, OBJPROP_XDISTANCE, x - 50);         //--- Set X distance
          ObjectSetInteger(0, objectName, OBJPROP_YDISTANCE, y);              //--- Set Y distance
          ObjectSetInteger(0, objectName, OBJPROP_CORNER, CORNER_LEFT_UPPER); //--- Set corner
          ObjectSetInteger(0, objectName, OBJPROP_ANCHOR, ANCHOR_RIGHT);      //--- Set anchor
          ObjectSetInteger(0, objectName, OBJPROP_COLOR, volumeColor);        //--- Set color
          ObjectSetInteger(0, objectName, OBJPROP_FONTSIZE, labelFontSize);   //--- Set font size
          ObjectSetString(0, objectName, OBJPROP_FONT, "Arial");              //--- Set font
          ObjectSetString(0, objectName, OBJPROP_TEXT, IntegerToString((int)MathRound(volumeValue))); //--- Set text
          ObjectSetInteger(0, objectName, OBJPROP_SELECTABLE, false);         //--- Set selectable false
          ObjectSetInteger(0, objectName, OBJPROP_HIDDEN, true);              //--- Set hidden true
       }
    }
    
    //+------------------------------------------------------------------+
    //| Apply transparency to color                                      |
    //+------------------------------------------------------------------+
    color ApplyTransparencyToColor(color baseColor, int transparency) {
       int red = (int)(baseColor & 0xFF);             //--- Extract red
       int green = (int)((baseColor >> 8) & 0xFF);    //--- Extract green
       int blue = (int)((baseColor >> 16) & 0xFF);    //--- Extract blue
       
       transparency = (int)MathMin(100, MathMax(0, transparency)); //--- Clamp transparency
       int alpha = 255 - (transparency * 255 / 100); //--- Calculate alpha
       
       return (color)((alpha << 24) | (blue << 16) | (green << 8) | red); //--- Return color with alpha
    }
    

We implement the "RenderFixedRangeVolumeLabels" function to display volume values as labels next to the profile in fixed timeframe mode, first validating the session index and ensuring volume profile prices exist before proceeding. We determine the maximum volume by iterating through the volume array and updating for the highest value, exiting if zero to avoid division issues. After fetching the label time via [iTime](/en/docs/series/itime), we loop through each volume profile entry: calculate the ratio to max, derive a percentage, and set the label color—using single print color for 8% or less, or applying transparency to the value area color with "ApplyTransparencyToColor" for higher, where transparency scales inversely from 0 to 80 based on percent via the [MathMax](/en/docs/math/mathmax) function. 

For each, we construct a unique object name combining prefix, start time, and index through [IntegerToString](/en/docs/convert/IntegerToString), convert time-price to coordinates using "ChartTimePriceToXY", create a label with "ObjectCreate" and "OBJ_LABEL" if missing per [ObjectFind](/en/docs/objects/objectfind), and configure it with offset X position to the left, upper-left corner, right anchor, computed color, dynamic font size, Arial font, rounded volume text from [MathRound](/en/docs/math/mathround) and "IntegerToString", and non-selectable/hidden properties set by the ObjectSetInteger" and "ObjectSetString" functions.

To support variable opacity in visuals, we define the "ApplyTransparencyToColor" function, extracting red, green, and blue components from the base color using [bitwise AND and shifts](/en/docs/basis/operations/bit). We clamp the input transparency between 0 and 100 with [MathMin](/en/docs/math/mathmin) and "MathMax", compute alpha as 255 minus the scaled percentage, and return a new color by shifting alpha left 24 bits and OR-ing with the blue-green-red arrangement. Finally, we can draw a colored background rectangle for fixed timeframes to visually distinguish fixed range profiles on the chart.
    
    
    //+------------------------------------------------------------------+
    //| Render fixed range background rectangle                          |
    //+------------------------------------------------------------------+
    void RenderFixedRangeBackgroundRectangle(int sessionIndex) {
       if(profileTimeframe != FIXED) return;                               //--- Return if not fixed
       if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if index invalid
       
       string objectName = objectPrefix + "FixedBG_" + IntegerToString(sessions[sessionIndex].startTime); //--- Create object name
       
       if(ObjectFind(0, objectName) < 0) {                                 //--- Check if not found
          ObjectCreate(0, objectName, OBJ_RECTANGLE, 0, sessions[sessionIndex].startTime, sessions[sessionIndex].sessionHigh,
                       sessions[sessionIndex].endTime > 0 ? sessions[sessionIndex].endTime : TimeCurrent(),
                       sessions[sessionIndex].sessionLow);                 //--- Create rectangle
          ObjectSetInteger(0, objectName, OBJPROP_SELECTABLE, false);      //--- Set selectable false
          ObjectSetInteger(0, objectName, OBJPROP_HIDDEN, true);           //--- Set hidden true
          ObjectSetInteger(0, objectName, OBJPROP_BACK, true);             //--- Set back true
       }
       
       ObjectSetInteger(0, objectName, OBJPROP_COLOR, fixedRangeBackgroundColor); //--- Set color
       ObjectSetInteger(0, objectName, OBJPROP_FILL, true); //--- Set fill true
    }
    

We add the "RenderFixedRangeBackgroundRectangle" function to draw a filled background for fixed timeframe profiles, enhancing visual separation on the chart, returning early if the timeframe is not "FIXED" or the session index is invalid per array size checks. We construct the object name using the prefix and session start time via [IntegerToString](/en/docs/convert/IntegerToString), then if missing according to [ObjectFind](/en/docs/objects/objectfind), create a rectangle object with [ObjectCreate](/en/docs/objects/objectcreate) and [OBJ_RECTANGLE](/en/docs/constants/objectconstants/enum_object/obj_rectangle) spanning from start time at session high to the end time (falling back to [TimeCurrent](/en/docs/dateandtime/timecurrent) if end time is zero) at session low, setting it non-selectable, hidden, and drawn behind other elements. Regardless, we apply the input fixed range background color and enable solid fill with [ObjectSetInteger](/en/docs/objects/objectsetinteger) to provide a colored backdrop for the profile range. We can now call these functions in the profile rendering master function to do the heavy lifting, so we just call all the logic in the tick calculation event handler.
    
    
    //+------------------------------------------------------------------+
    //| Render session profile                                           |
    //+------------------------------------------------------------------+
    void RenderSessionProfile(int sessionIndex) {
       if(sessionIndex < 0 || sessionIndex >= ArraySize(sessions)) return; //--- Return if index invalid
       
       int size = ArraySize(sessions[sessionIndex].levels); //--- Get levels size
       if(size == 0 || sessions[sessionIndex].startTime == 0) return; //--- Return if no levels or no start time
       
       int barIndex = iBarShift(_Symbol, _Period, sessions[sessionIndex].startTime); //--- Get bar index
       if(barIndex < 0) return;                       //--- Return if invalid
       
       PadLevelsForSplitProfile(sessionIndex);        //--- Pad levels for split
       SortPriceLevelsDescending(sessionIndex);       //--- Sort levels descending
       CalculatePointOfControl(sessionIndex);         //--- Calculate POC
       BuildVolumeProfileAndFindPoc(sessionIndex);    //--- Build VP and find POC
       
       int totalTpoCount = GetTotalTpoCount(sessionIndex); //--- Get total TPO count
       int pointOfControlIndex = (useVolumeProfilePocForValueArea && sessions[sessionIndex].volumeProfilePocIndex >= 0) ? 
                                 sessions[sessionIndex].volumeProfilePocIndex : sessions[sessionIndex].pointOfControlIndex; //--- Select POC index
       
       int valueAreaUpperIndex = pointOfControlIndex; //--- Initialize value area upper index
       int valueAreaLowerIndex = pointOfControlIndex; //--- Initialize value area lower index
       
       if(pointOfControlIndex >= 0) {                 //--- Check valid POC index
          int targetTpoCount = (int)(totalTpoCount * valueAreaPercent / 100.0); //--- Calculate target TPO count
          int currentTpoCount = sessions[sessionIndex].levels[pointOfControlIndex].tpoCount; //--- Set current TPO count
          
          while(currentTpoCount < targetTpoCount && (valueAreaUpperIndex > 0 || valueAreaLowerIndex < size - 1)) { //--- Loop to expand value area
             int upperTpoCount = (valueAreaUpperIndex > 0) ? sessions[sessionIndex].levels[valueAreaUpperIndex - 1].tpoCount : 0; //--- Get upper TPO count
             int lowerTpoCount = (valueAreaLowerIndex < size - 1) ? sessions[sessionIndex].levels[valueAreaLowerIndex + 1].tpoCount : 0; //--- Get lower TPO count
             
             if(upperTpoCount >= lowerTpoCount && valueAreaUpperIndex > 0) { //--- Check upper expansion
                valueAreaUpperIndex--;                //--- Decrement upper index
                currentTpoCount += upperTpoCount;     //--- Add upper TPO
             } else if(valueAreaLowerIndex < size - 1) { //--- Check lower expansion
                valueAreaLowerIndex++;                //--- Increment lower index
                currentTpoCount += lowerTpoCount;     //--- Add lower TPO
             } else if(valueAreaUpperIndex > 0) {     //--- Fallback upper expansion
                valueAreaUpperIndex--;                //--- Decrement upper index
                currentTpoCount += upperTpoCount;     //--- Add upper TPO
             } else {                                 //--- Break if no more
                break;                                //--- Exit loop
             }
          }
       }
       
       string displayStrings[];                       //--- Declare display strings array
       ArrayResize(displayStrings, size);             //--- Resize display strings
       for(int i = 0; i < size; i++) {                //--- Loop through levels
          displayStrings[i] = sessions[sessionIndex].levels[i].tpoString; //--- Copy TPO string
       }
       
       int openLevelIndex  = -1;                      //--- Initialize open level index
       int closeLevelIndex = -1;                      //--- Initialize close level index
       
       if(tpoCharacterType == ALPHABETIC) {           //--- Check alphabetic
          double openPrice  = sessions[sessionIndex].sessionOpen; //--- Get open price
          double closePrice = sessions[sessionIndex].sessionClose; //--- Get close price
          
          for(int i = 0; i < size; i++) {             //--- Loop to find levels
             if(openLevelIndex < 0  && MathAbs(sessions[sessionIndex].levels[i].price - openPrice)  < tpoPriceGridStep / 2) //--- Check open match
                openLevelIndex = i;                   //--- Set open index
             if(closeLevelIndex < 0 && MathAbs(sessions[sessionIndex].levels[i].price - closePrice) < tpoPriceGridStep / 2) //--- Check close match
                closeLevelIndex = i;                  //--- Set close index
          }
          
          RenderOpenTpoHighlight(sessionIndex, openLevelIndex, displayStrings); //--- Render open highlight
          RenderCloseTpoHighlight(sessionIndex, closeLevelIndex, displayStrings); //--- Render close highlight
       }
       
       for(int i = 0; i < size; i++) {                //--- Loop to render levels
          string objectName = objectPrefix + "TPO_" + IntegerToString(sessions[sessionIndex].startTime) + "_" + IntegerToString(i); //--- Create object name
          
          color textColor = defaultTpoColor;          //--- Set default color
          
          if(sessions[sessionIndex].levels[i].tpoCount == 1) { //--- Check single print
             textColor = singlePrintColor;            //--- Set single print color
          }
          
          if(i >= valueAreaUpperIndex && i <= valueAreaLowerIndex) { //--- Check value area
             textColor = valueAreaColor;              //--- Set value area color
          }
          
          if(i == sessions[sessionIndex].pointOfControlIndex && sessions[sessionIndex].volumeProfilePocIndex != sessions[sessionIndex].pointOfControlIndex) { //--- Check TPO POC
             textColor = pointOfControlColor;         //--- Set POC color
          }
          
          if(highlightVolumeProfilePoc && i == sessions[sessionIndex].volumeProfilePocIndex) { //--- Check VP POC
             textColor = volumeProfilePocColor;       //--- Set VP POC color
          }
          
          if(highlightSessionVwap && MathAbs(sessions[sessionIndex].levels[i].price - sessions[sessionIndex].vwap) < tpoPriceGridStep / 2) { //--- Check VWAP
             textColor = sessionVwapColor;            //--- Set VWAP color
          }
          
          if(ObjectFind(0, objectName) < 0) {         //--- Check if object not found
             ObjectCreate(0, objectName, OBJ_LABEL, 0, 0, 0);       //--- Create label
             ObjectSetInteger(0, objectName, OBJPROP_XDISTANCE, 0); //--- Set X distance
             ObjectSetInteger(0, objectName, OBJPROP_YDISTANCE, 0); //--- Set Y distance
          }
          
          datetime labelTime = iTime(_Symbol, _Period, barIndex); //--- Get label time
          int x, y;                                               //--- Declare coordinates
          ChartTimePriceToXY(0, 0, labelTime, sessions[sessionIndex].levels[i].price, x, y); //--- Convert to XY
          
          ObjectSetInteger(0, objectName, OBJPROP_XDISTANCE, x); //--- Set X distance
          ObjectSetInteger(0, objectName, OBJPROP_YDISTANCE, y); //--- Set Y distance
          ObjectSetInteger(0, objectName, OBJPROP_CORNER, CORNER_LEFT_UPPER); //--- Set corner
          ObjectSetInteger(0, objectName, OBJPROP_ANCHOR, ANCHOR_LEFT);       //--- Set anchor
          ObjectSetInteger(0, objectName, OBJPROP_COLOR, textColor);          //--- Set color
          ObjectSetInteger(0, objectName, OBJPROP_FONTSIZE, labelFontSize);   //--- Set font size
          ObjectSetString(0, objectName, OBJPROP_FONT, "Arial");              //--- Set font
          ObjectSetString(0, objectName, OBJPROP_TEXT, displayStrings[i]);    //--- Set text
          ObjectSetInteger(0, objectName, OBJPROP_SELECTABLE, false);         //--- Set selectable false
          ObjectSetInteger(0, objectName, OBJPROP_HIDDEN, true);              //--- Set hidden true
       }
       
       RenderOpenCloseMarkers(sessionIndex, barIndex);  //--- Render open close markers
       RenderProfileBorderLine(sessionIndex, barIndex); //--- Render profile border
       
       if(initialBalancePeriods > 0)                    //--- Check if IB periods
          RenderInitialBalanceLines(sessionIndex, barIndex); //--- Render IB lines
       
       if(showExtensionLines)                           //--- Check if show extensions
          RenderKeyLevelExtensions(sessionIndex, barIndex, valueAreaUpperIndex, valueAreaLowerIndex); //--- Render extensions
       
       if(profileTimeframe == FIXED && renderVolumes)   //--- Check fixed and render volumes
          RenderFixedRangeVolumeLabels(sessionIndex, barIndex); //--- Render volume labels
       
       RenderFixedRangeBackgroundRectangle(sessionIndex); //--- Render fixed background
    }

Here, we enhance the "RenderSessionProfile" function to incorporate advanced features in drawing the market profile, beginning with index and data validations to exit if invalid, no levels, or no start time, then fetching the bar index via the [iBarShift](/en/docs/series/ibarshift) function. We prepare the profile by calling "PadLevelsForSplitProfile" for alignment in split mode, sorting levels descending with "SortPriceLevelsDescending", computing the Time Price Opportunity point of control using "CalculatePointOfControl", and building the volume profile to find its point of control through "BuildVolumeProfileAndFindPoc". 

After obtaining the total Time Price Opportunity count from "GetTotalTpoCount", we select the point of control index conditionally—if "useVolumeProfilePocForValueArea" is true and a volume point of control exists, use that; otherwise, fall back to the Time Price Opportunity one—then initialize and expand value area indices around it, accumulating counts in a loop by preferring the adjacent level with higher Time Price Opportunities until reaching the target based on "valueAreaPercent". To set up visuals, we resize and copy Time Price Opportunity strings into a display array with [ArrayResize](/en/docs/array/arrayresize). If in alphabetic mode, locate open and close level indices by scanning levels with [MathAbs](/en/docs/math/mathabs) tolerance of half the grid step, and render highlights by invoking "RenderOpenTpoHighlight" and "RenderCloseTpoHighlight".

In the main rendering loop for each level, we build a unique object name, start with the default color, and override for single prints, value area range, distinct Time Price Opportunity point of control, highlighted volume point of control, or close matches to the weighted average price using tolerance checks. We create or update labels with "ObjectCreate" and "OBJ_LABEL" if missing per "ObjectFind", convert time-price to coordinates via [ChartTimePriceToXY](/en/docs/chart_operations/charttimepricetoxy) after getting label time from "iTime", and apply position, corner, anchor, color, font size, font, display text, and non-selectable/hidden settings. 

Finally, we add supporting elements by calling "RenderOpenCloseMarkers", "RenderProfileBorderLine", "RenderInitialBalanceLines" if periods are set, "RenderKeyLevelExtensions" with value area indices if extensions are enabled, "RenderFixedRangeVolumeLabels" for fixed timeframes with volumes, and "RenderFixedRangeBackgroundRectangle" for backgrounds. Now, we just need to update the tick calculation event handler to store per-period H/L/O, calculate IB if within periods, add volume to levels, and call VWAP for the entire computation.
    
    
    //+------------------------------------------------------------------+
    //| Calculate custom indicator                                       |
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
       
       if(rates_total < 2) return 0;                              //--- Return if insufficient rates
       
       datetime currentBarTime = time[rates_total - 1];           //--- Get current bar time
       bool isNewBar = (currentBarTime != lastCompletedBarTime);  //--- Check if new bar
       
       if(IsNewSessionStarted(currentBarTime, previousBarTime) || previousBarTime == 0) { //--- Check new session
          if(activeSessionIndex >= 0 && activeSessionIndex < ArraySize(sessions)) { //--- Check active session
             sessions[activeSessionIndex].endTime = previousBarTime; //--- Set end time
             RenderSessionProfile(activeSessionIndex);             //--- Render session profile
          }
          
          activeSessionIndex = CreateNewSession();                 //--- Create new session
          sessions[activeSessionIndex].startTime = currentBarTime; //--- Set start time
          sessions[activeSessionIndex].sessionOpen = open[rates_total - 1]; //--- Set session open
          sessions[activeSessionIndex].sessionHigh = high[rates_total - 1]; //--- Set session high
          sessions[activeSessionIndex].sessionLow = low[rates_total - 1]; //--- Set session low
          lastCompletedBarTime = currentBarTime;                   //--- Update last completed bar time
       }
       
       previousBarTime = currentBarTime;                           //--- Update previous bar time
       
       if(isNewBar && IsBarEligibleForProcessing(currentBarTime) && activeSessionIndex >= 0) { //--- Check if process bar
          sessions[activeSessionIndex].sessionHigh = MathMax(sessions[activeSessionIndex].sessionHigh, high[rates_total - 1]); //--- Update session high
          sessions[activeSessionIndex].sessionLow = MathMin(sessions[activeSessionIndex].sessionLow, low[rates_total - 1]); //--- Update session low
          sessions[activeSessionIndex].sessionClose = close[rates_total - 1]; //--- Update session close
          
          int periodIndex = sessions[activeSessionIndex].periodCount;             //--- Get period index
          ArrayResize(sessions[activeSessionIndex].periodHighs, periodIndex + 1); //--- Resize period highs
          ArrayResize(sessions[activeSessionIndex].periodLows, periodIndex + 1);  //--- Resize period lows
          ArrayResize(sessions[activeSessionIndex].periodOpens, periodIndex + 1); //--- Resize period opens
          
          sessions[activeSessionIndex].periodHighs[periodIndex] = high[rates_total - 1]; //--- Set period high
          sessions[activeSessionIndex].periodLows[periodIndex] = low[rates_total - 1];   //--- Set period low
          sessions[activeSessionIndex].periodOpens[periodIndex] = open[rates_total - 1]; //--- Set period open
          sessions[activeSessionIndex].periodCount++; //--- Increment period count
          
          if(periodIndex < initialBalancePeriods) {   //--- Check if within IB periods
             if(periodIndex == 0) {                   //--- Handle first period
                sessions[activeSessionIndex].initialBalanceHigh = high[rates_total - 1]; //--- Set IB high
                sessions[activeSessionIndex].initialBalanceLow = low[rates_total - 1];   //--- Set IB low
             } else {                                 //--- Handle subsequent
                sessions[activeSessionIndex].initialBalanceHigh = MathMax(sessions[activeSessionIndex].initialBalanceHigh, high[rates_total - 1]); //--- Update IB high
                sessions[activeSessionIndex].initialBalanceLow = MathMin(sessions[activeSessionIndex].initialBalanceLow, low[rates_total - 1]); //--- Update IB low
             }
          }
          
          double quantizedHigh = QuantizePriceToGrid(high[rates_total - 1]); //--- Quantize high
          double quantizedLow = QuantizePriceToGrid(low[rates_total - 1]);   //--- Quantize low
          
          for(double price = quantizedLow; price <= quantizedHigh; price += tpoPriceGridStep) { //--- Loop through prices
             int levelIndex = GetOrCreatePriceLevel(activeSessionIndex, price);                 //--- Get or create level
             if(levelIndex >= 0) {                    //--- Check valid level
                AddTpoCharacterToLevel(activeSessionIndex, levelIndex, periodIndex);            //--- Add TPO character
                sessions[activeSessionIndex].levels[levelIndex].volume += (double)tick_volume[rates_total - 1] / 
                                                           MathMax(1, (quantizedHigh - quantizedLow) / tpoPriceGridStep + 1); //--- Add volume
             }
          }
          
          CalculateSessionVwap(activeSessionIndex);   //--- Calculate VWAP
          lastCompletedBarTime = currentBarTime;      //--- Update last completed bar time
       }
       
       if(IsBarEligibleForProcessing(currentBarTime) && activeSessionIndex >= 0) { //--- Check if update session
          sessions[activeSessionIndex].sessionClose = close[rates_total - 1];      //--- Update close
          sessions[activeSessionIndex].sessionHigh = MathMax(sessions[activeSessionIndex].sessionHigh, high[rates_total - 1]); //--- Update high
          sessions[activeSessionIndex].sessionLow = MathMin(sessions[activeSessionIndex].sessionLow, low[rates_total - 1]); //--- Update low
       }
       
       for(int i = 0; i < ArraySize(sessions); i++) { //--- Loop through sessions
          RenderSessionProfile(i);                    //--- Render profile
       }
       
       return rates_total;                            //--- Return rates total
    }
    

In the [OnCalculate](/en/docs/event_handlers/oncalculate) event handler, we update the logic to integrate the new features like initial balance tracking and volume accumulation during data processing, starting by returning zero if insufficient rates exist. We extract the current bar time and check for a new bar, then if a new session starts per "IsNewSessionStarted" or no previous time, finalize the active session's end time and render it with "RenderSessionProfile" if valid within bounds via [ArraySize](/en/docs/array/arraysize), create a new one using "CreateNewSession", initialize core fields from the current bar, and update the last completed time, just like we did with the prior version.

After setting the previous bar time, if a new eligible bar via "IsBarEligibleForProcessing" and active session exist, we update session extremes with [MathMax](/en/docs/math/mathmax) and [MathMin](/en/docs/math/mathmin) plus close, resize and store period highs, lows, and opens in their arrays, increment the period count, and if within "initialBalancePeriods", set or update initial balance high and low based on the period index. We quantize the bar's high and low, loop through the range to get or create levels with "GetOrCreatePriceLevel", add Time Price Opportunity characters via "AddTpoCharacterToLevel", and accumulate volume proportionally using tick volume divided by price steps ensured at least one with "MathMax", before calculating weighted average price through "CalculateSessionVwap" and updating the last completed time. If the bar is eligible, we refresh the session close, high, and low for live updates, then render all sessions in a loop, and return the total rates. Upon compilation, we get the following outcome.

![HYBRID VOLUME-BASED MARKET PROFILE - DOT CHARACTERS](https://c.mql5.com/2/195/Screenshot_2026-02-16_171605.png)

From the image, we can see that we updated the indicator by adding the volume-based profile logic and enhanced visualization, making it a hybrid version, hence achieving our objectives. The thing that remains is backtesting the program, and that is handled in the next section.

  


### Backtesting

We did the testing, and below is the compiled visualization in a single [Graphics Interchange Format](https://en.wikipedia.org/wiki/GIF "https://en.wikipedia.org/wiki/GIF") (GIF) bitmap image format.

![BACKTEST GIF](https://c.mql5.com/2/195/MP_PART_2_BACKTEST.gif)

  


### Conclusion

In conclusion, we’ve enhanced the hybrid [Time Price Opportunity](/go?link=https://snpedge.vicitradingsolutions.com/p/understanding-time-price-opportunity "https://snpedge.vicitradingsolutions.com/p/understanding-time-price-opportunity") (TPO) market profile indicator in [MQL5](/) by integrating volume data to compute volume-based point of control, value areas, and volume-weighted average price with customizable highlighting. The system adds advanced capabilities such as initial balance detection, key level extension lines, split profiles, alternative TPO characters like squares or circles, border lines, fixed-range backgrounds, and dynamic volume labels for comprehensive visual analysis across timeframes. With this upgraded hybrid Time Price Opportunity market profile indicator, you’re equipped to gain deeper insights into market structure and volume dynamics, ready for further optimization in your trading journey. Happy trading!

**Attached files** | 

[ __Download ZIP](/en/articles/download/21390.zip "Download all attachments in the single ZIP archive")

[__Hybrid_TPO_Market_Profile_PART_2.mq5](/en/articles/download/21390/Hybrid_TPO_Market_Profile_PART_2.mq5 "Download Hybrid_TPO_Market_Profile_PART_2.mq5") (86.16 KB)

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



**[Go to discussion](/en/forum/505859) **

![Swing Extremes and Pullbacks in MQL5 \(Part 1\): Developing a Multi-Timeframe Indicator](https://c.mql5.com/2/197/21330-automating-swing-extremes-and-logo.png) [Swing Extremes and Pullbacks in MQL5 (Part 1): Developing a Multi-Timeframe Indicator](/en/articles/21330)

In this discussion we will Automate Swing Extremes and the Pullback Indicator, which transforms raw lower-timeframe (LTF) price action into a structured map of market intent, precisely identifying swing highs, swing lows, and corrective phases in real time. By programmatically tracking microstructure shifts, it anticipates potential reversals before they fully unfold—turning noise into actionable insight.

![MQL5 Trading Tools \(Part 20\): Canvas Graphing with Statistical Correlation and Regression Analysis](https://c.mql5.com/2/196/21303-mql5-trading-tools-part-20-logo.png) [MQL5 Trading Tools (Part 20): Canvas Graphing with Statistical Correlation and Regression Analysis](/en/articles/21303)

In this article, we create a canvas-based graphing tool in MQL5 for statistical correlation and linear regression analysis between two symbols, with draggable and resizable features. We incorporate ALGLIB for regression calculations, dynamic tick labels, data points, and a stats panel displaying slope, intercept, correlation, and R-squared. This interactive visualization aids in pair trading insights, supporting customizable themes, borders, and real-time updates on new bars

![From Novice to Expert:  Extending a Liquidity Strategy with Trend Filters](https://c.mql5.com/2/197/21133-from-novice-to-expert-extending-logo__1.png) [From Novice to Expert: Extending a Liquidity Strategy with Trend Filters](/en/articles/21133)

The article extends a liquidity-based strategy with a simple trend constraint: trade liquidity zones only in the direction of the EMA(50). It explains filtering rules, presents a reusable TrendFilter.mqh class and EA integration in MQL5, and compares baseline versus filtered tests. Readers gain a clear directional bias, reduced overtrading in countertrend phases, and ready-to-use source files.

![MetaTrader 5 Machine Learning Blueprint \(Part 7\): From Scattered Experiments to Reproducible Results](https://c.mql5.com/2/196/20451-metatrader-5-machine-learning-logo.png) [MetaTrader 5 Machine Learning Blueprint (Part 7): From Scattered Experiments to Reproducible Results](/en/articles/20451)

In the latest installment of this series, we move beyond individual machine learning techniques to address the "Research Chaos" that plagues many quantitative traders. This article focuses on the transition from ad-hoc notebook experiments to a principled, production-grade pipeline that ensures reproducibility, traceability, and efficiency.

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


