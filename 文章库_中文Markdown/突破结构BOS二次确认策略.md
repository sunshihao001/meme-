# 突破结构BOS二次确认策略

> 本地文档目标名：突破结构BOS二次确认策略
> 来源标题：突破结构（BoS）交易策略分步指南 - MQL5文章
> 来源链接：https://www.mql5.com/zh/articles/15017
> 下载时间：2026-06-12 23:16:22
> 类型：MQL5中文文章库

---

[ __](javascript:void\(false\);) [English](/en/articles/15017) [Русский](/ru/articles/15017) [Español](/es/articles/15017) [Deutsch](/de/articles/15017) [日本語](/ja/articles/15017) [Português](/pt/articles/15017)

__

[ __](/zh/articles/15017?print= "打印优化版本")

![preview](data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAsICAoIBwsKCQoNDAsNERwSEQ8PESIZGhQcKSQrKigkJyctMkA3LTA9MCcnOEw5PUNFSElIKzZPVU5GVEBHSEX/2wBDAQwNDREPESESEiFFLicuRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUX/wAARCAAQACADASIAAhEBAxEB/8QAGAAAAgMAAAAAAAAAAAAAAAAABAYCAwX/xAAiEAACAgIBAwUAAAAAAAAAAAABAgAEAxGBBRJxFSEiMVH/xAAVAQEBAAAAAAAAAAAAAAAAAAACA//EABgRAAIDAAAAAAAAAAAAAAAAAAARAQIS/9oADAMBAAIRAxEAPwBBGML9kHiF10DMPjvwJXXpNlYd7keBN6l0iuAC+RzKOAS0G9EyitkDKuj+6jV65pQCTzF1K1fEukHMi2Mb9iY9VBmx/9k=)

![突破结构（BoS）交易策略分步指南](https://c.mql5.com/2/80/A_Step-by-Step_Guide_on_Trading_the_Break_of_Structure__600x314.jpg)

# 突破结构（BoS）交易策略分步指南

[MetaTrader 5](/zh/articles/mt5) — [交易](/zh/articles/mt5/trading) | 9 十二月 2024, 12:14

![](https://c.mql5.com/i/icons.svg#views-white-usage) 4 410  [ ![](https://c.mql5.com/i/icons.svg#comments-white-usage) 11 ](/zh/forum/477929 "评论")

![Allan Munene Mutiiria](https://c.mql5.com/avatar/2022/11/637df59b-9551.jpg)

[Allan Munene Mutiiria](/zh/users/29210372)

### 概述

在本文中，我们将讨论BoS这一概念，它是一个标志着市场趋势或方向发生重大转变的术语，特别是在聪明资金概念（Smart Money Concept，简称SMC）的背景下，以及基于这一概念创建自动化交易顾问（Expert Advisor，简称EA）的外汇交易策略。

我们将深入探讨BoS的定义、类型、交易策略应用以及基于[MetaQuotes Language 5](https://www.metaquotes.net/ "https://www.metaquotes.net/")（简称MQL5）为[MetaTrader 5](https://www.metatrader5.com/ "https://www.metatrader5.com/")（简称MT5）平台开发的相关内容，以此深入理解BoS的细微差别。BoS的理念作为交易者学习的一个有用工具，它能够帮助交易者提高预测市场走势的能力，做出更明智的决策，并最终能精通风险管理方面。我们将通过以下主题来实现上述目标：

  1. [BoS的定义](/zh/articles/15017#para1)
  2. [BoS的描述](/zh/articles/15017#para2)
  3. [BoS的类型](/zh/articles/15017#para3)
  4. [交易策略描述](/zh/articles/15017#para4)
  5. [交易策略](/zh/articles/15017#para5)
  6. [在MQL5中实现](/zh/articles/15017#para6)
  7. [策略测试结果](/zh/articles/15017#para7)
  8. [结论](/zh/articles/15017#para8)



在此次探索之旅的过程中，我们将广泛使用[MetaQuotes Language 5](https://www.metaquotes.net/ "https://www.metaquotes.net/")（简称MQL5）作为我们的基础集成开发环境（IDE）编码环境，并在[MetaTrader 5](https://www.metatrader5.com/ "https://www.metatrader5.com/")（简称MT5）交易平台执行相关文件。因此，拥有上述版本是至关重要的。那么，让我们开始吧。

  


### BoS的定义

BoS是技术分析中的一个关键概念，它利用SMC来识别市场趋势或方向上的重大变化。它通常发生在价格明确地穿过先前价格走势所确立的波动低点或波动高点时。当价格上升到波动高点之上或下降到波动低点之下时，它们就打破了先前形成的市场结构，因此得名结构”突破”。这通常表明市场情绪和趋势方向发生了变化，预示着现有趋势的延续或新趋势的开始。

  


### BoS的描述

为了有效地描述BoS，我们首先需要将其与SMC中的其他元素区分开来，这些元素包括市场结构转变（Market Structure Shift，简称MSS）和特性变化（Change of Character，简称CHoCH）。

  * **市场结构转变（MSS）**



> 市场结构转变，你也可能听说过市场动量转变（MMS），发生在价格在下跌趋势相关的最近低位突破，或者相反，在上涨趋势相关的最近高位突破，但却还没有打破最近的波动低点或波动高点的情况。这标志着由于结构的变化而导致的趋势反转，因此得名市场结构的“转变”。

![市场结构转变](https://c.mql5.com/2/80/MSS.png)  


  * **特性变化(CHoCH)**



> 特征变化，从另一方面来说，发生在以下两种情况下：一是在下跌趋势中，价格首先跌破最近的波动低点之后，又突破了最近的最高价；二是在上升趋势中，价格首先突破最近的波动高点之后，又跌破了最近的最低价。

![特征变化](https://c.mql5.com/2/80/CHOCH.png)  


  * **突破结构（BoS）**



> 既然我们已经了解了基于市场结构SMC方法中的三个主要元素之间的关键差异，现在让我们深入探讨本文的主题，即其突破。从之前给出的定义中，您应该已经了解到，结构突破意味着突破过去的高点或低点，以分别创造新的高点或低点。每一次的结构突破都有助于市场趋势向上发展，形成新的更高高点（HH）和新的更高低点（HL），或者向下发展，形成新的更低高点（LH）和新的更低低点（LL），这些通常被描述为价格的波动高点和波动低点。

![结构突破](https://c.mql5.com/2/80/BOS_.png)  


> 唯一有效的规则是：突破必须与K线图的收盘价一致。这意味着，在关于波动高点的突破情况下，收盘价应高于波动点；而在关于波动低点的突破情况下，收盘价则应低于波动点。简而言之，只有K线图或柱形图实体的突破才被视为有效的结构突破，也就是说，K线图的尾部、影线或灯芯的突破被视为无效的结构突破。
> 
>   * **无效BoS设置**
> 


> ![无效BoS](https://c.mql5.com/2/80/INVALID_BOS.png)

>   * **有效BoS设置**
> 


![有效BoS](https://c.mql5.com/2/80/VALID_BOS.png)

  


### BoS的类型

正如已经提到的，结构突破发生在趋势市场中，这意味着它们要么发生在上升趋势中，要么发生在下降趋势中。这就表明，我们只有两种类型的结构突破。

**

  * **看涨结构突破**

**

> 这些发生在上升趋势中，上升趋势的特点是高点不断抬高（HH）且低点也不断上移（HL）。从技术上讲，结构突破是价格突破上升趋势中的最近一个高点，并形成一个新的更高的高点。

![牛市BoS](https://c.mql5.com/2/80/BULL_BOS.png)  


  * **看跌结构突破**



> 在这里，看跌结构突破发生在下降趋势中，下降趋势的特点是低点不断降低（LL）且高点也不断下降（LH）。结构突破是价格突破下降趋势中的最近一个低点，并形成一个新的更低的低点。

![熊市BoS](https://c.mql5.com/2/80/BEAR_BOS.png)

  


### 交易策略描述

为了有效运用这一策略进行交易，您需要遵循一系列的步骤，但不用担心。我们会一步步地讲解。 

以较长时间周期（HTF）为基础：首先，为了进行全面分析，请为选定资产设置较长的时间周期，因为它能提供市场趋势的整体概览。可以包括四小时或每日时间周期，因为它们往往能揭示市场的长期轨迹。我们避免使用较短时间周期，因为它包含许多由于操纵、流动性横扫和像醉酒司机一样曲折的波动点，以致于出现更多不重要的突破。

确定潜在市场趋势：其次，你需要在图表上确定当前的市场趋势。上升趋势包含价格走势中高点不断抬高和低点也不断上移的模式，而下降趋势则由低点不断降低和高点也不断下降的模式组成。

确定入场点：在较长时间周期上确定当前趋势后，您可以在波动高点或波动低点的突破时机入场，这些突破以突破K线图的实体部分收盘。K线图越强，确认信号就越令人放心。

上行趋势示例

![上行趋势示例](https://c.mql5.com/2/80/BOS2.png)  


下行趋势示例

![下行趋势示例](https://c.mql5.com/2/80/BOS1.png)  


在较短的时间周期内，比如五分钟时间周期，您可以使用额外的确认策略，如供需关系、技术指标（如相对强弱指数RSI和MACD（异同移动平均线））或日本K线图形态（如吞噬形态或内包形态）。

确定退出点：进入市场后，我们同样需要一套稳健的策略来退出市场，同时管控我们的风险。对于止损点，我们将其设置在前一个波动点，前提是它靠近持仓的入场点，同时为我们留下有可能的盈利空间。如果不属于这种情况，那么我们就使用固定的点数来确定风险与回报的比例。相反，我们在下一个波动点获利结束，但由于很难确定未来的波动点作为盈利水平的终结，因此我们使用风险与回报的比例作为指引。

### 交易策略

为了让您更容易理解我们传达的概念，我们将其在方案中可视化。

> 看涨结构突破

![牛市BoS](https://c.mql5.com/2/80/Bull_BOS_Chart.png)  


> 看跌结构突破

![熊市BoS](https://c.mql5.com/2/80/Bear_BOS_Chart.png)

  


### 在MetaTrader 5 (MT5)中使用MQL5实现

在学习了关于结构突破交易策略的所有理论之后，让我们将这些理论自动化，并在MQL5中为MetaTrader 5编写一个EA。

要在MetaTrader 5终端中创建EA，请点击“工具”选项卡并选择“MetaQuotes语言编辑器”，或者简单地在键盘上按F4键。这样就会打开MetaQuotes语言编辑器环境，该环境允许用户编写自动交易、技术指标、脚本和函数库。

![打开 MetaQuotes](https://c.mql5.com/2/80/TOOLS.png)  


打开MetaEditor后，点击新建，在弹出的向导中，选中EA（模板）并点击下一步。

![创建一个EA文件](https://c.mql5.com/2/80/NEW.png)

![命名文件名](https://c.mql5.com/2/80/FILE_NAME.png)  


然后，输入您想要的EA文件名，分两次点击“下一步”，最后点击“完成”。在完成所有这些步骤之后，我们现在准备对我们的BoS策略编写代码。

首先，我们在源代码的开头使用[#include](/zh/docs/basis/preprosessor/include)指令来提供一个交易实例。在获得了[CTrade](/zh/docs/standardlibrary/tradeclasses/ctrade)类的访问权限后，我们将使用该类来创建一个交易对象。这一步至关重要，因为我们需要使用它开立交易。
    
    
    #include <Trade/Trade.mqh>
    CTrade obj_Trade;

我们的大部分流程都会在[OnTick](/zh/docs/event_handlers/ontick)事件处理器上执行。由于这仅仅是基于纯粹的价格行为，我们不需要使用OnInit事件处理器来初始化指标句柄。因此，我们的整段代码将只在OnTick事件处理器上执行。首先，让我们看一下这个函数除了其功能之外还接受哪些参数，因为它才是这段代码的核心：  

    
    
    void OnTick(){
    
    }

如上所见，这是一个简单但却至关重要的函数，它不接受任何参数也不返回任何内容。它只是一个空函数（void函数），这意味着它不需要返回任何内容。这个函数被用于EA中，当某个特定商品价格的报价发生新变动（即新的tick到来）时，该函数就会被执行。

既然我们已经知道OnTick函数是在报价每次变动时生成的，那么我们就需要定义一些控制逻辑，以便稍后用于控制特定代码段的执行，使它们每根K线执行一次，而不是每个tick都执行，至少这样可以避免不必要的代码运行，从而节省设备的内存。在寻找波动高点和波动低点时，这一点是有必要的。我们不需要每个tick都进行搜索，只要还在同一根K线上，我们总是能得到相同的结果。逻辑说明如下：
    
    
       static bool isNewBar = false;
       int currBars = iBars(_Symbol,_Period);
       static int prevBars = currBars;
       if (prevBars == currBars){isNewBar = false;}
       else if (prevBars != currBars){isNewBar = true; prevBars = currBars;}

首先，我们定义一个名为“isNewBar”的[静态](/zh/docs/basis/variables/static)布尔变量，并将其值初始化为“false”。这个变量的作用是跟踪图表上是否形成了新的K线。我们使用“static”关键字声明局部变量，以便它在整个函数生命周期内保持其值。这意味着它不会是动态的。通常，我们的变量值始终等于false，除非我们稍后将其更改为true。一旦更改，它将保持其值，并且在下一个tick时不会更新，这与它是动态的情况相反，在动态情况下它总是会被更新为初始值。

接着，我们定义另一个整数变量“currBars”，用于存储指定交易品种和周期（也就是您可能听说过的时间框架）在图表上当前计算出的K线数量。这是通过使用iBars函数实现的，该函数仅接受两个参数，即品种和周期。

继续，我们声明另一个静态整数变量“prevBars”，用于存储当新K线生成时图表上之前的K线总数，并在函数的首次运行时将其初始化为图表上当前K线的数量。我们将使用它来比较当前K线数量与之前的K线数量，以确定图表上新K线生成的情况。

最后，我们使用条件语句来检查当前K线数量是否等于之前的K线数量。如果它们相等，则意味着没有新K线形成，因此“isNewBar”变量值保持为false。否则，如果当前和之前的K线数量不相等，则表示有新K线形成。在这种情况下，我们将“isNewBar”变量值设置为true，并更新“prevBars”以匹配当前的K线数量。因此，通过这段代码，我们可以跟踪是否有新K线形成，并在后续使用此结果来确保我们的每根K线只执行一次实例。

现在，我们可以继续在图表上寻找波动点。我们需要对这些点进行一系列扫描。我们计划通过选择一个特定的柱形，并扫描其所有相邻的柱形（在预定义的范围内），来判断当前柱形在波动高点的情况下是否为范围内的最高点，或者在波动低点的情况下是否为最低点，以此来实现这一目标。首先，让我们定义存储这一逻辑所需的变量。
    
    
       const int length = 20;
       const int limit = 20;

这里，我们定义了两个整数变量“length”和“limit”。“length”代表在识别波动高点和低点时要考虑的柱形范围，而“limit”代表当前正在扫描的特定柱形的索引。例如，我们假设已经选择了索引为10的柱形进行扫描，以确定它是否是一个波动高点。然后，我们遍历所有相邻的柱形（包括左侧和右侧），查找是否存在比当前柱形（索引为10）更高的柱形。因此，左侧的是当前之前的柱形，因此其索引为11（limit等于10，再加1）。当向右遍历时，情况也是如此。

在默认情况下，我们将变量值初始化为20。另外，您应该已经注意到，我们将其定义为“const”且设置为[常量](/zh/book/basis/variables/const_variables)。这样做是为了确保它们的值在程序的执行过程中保持不变，从而保持一致性，有助于在不同柱条上保持相同的波动点分析范围。设置变量值为常量还有助于防止在程序执行过程中意外修改这些变量。

接下来，我们快速定义程序中的其他关键变量。我们需要跟踪当前正在分析的柱条，并评估其与预定义范围内相邻柱条的关系。我们通过定义以下变量来实现这一点。
    
    
       int right_index, left_index;
       bool isSwingHigh = true, isSwingLow = true;
       static double swing_H = -1.0, swing_L = -1.0;
       int curr_bar = limit;

我们首先定义两个整数变量“right_index”和“left_index”，用于跟踪相邻柱形的索引。“right_index”表示当前柱形右侧柱形的索引，而“left_index”表示当前柱形左侧柱形的索引，即被选中进行分析的柱形。再次，我们定义了两个布尔变量“isSwingHigh”和“isSwingLow”，它们作为标识，分别用于确定当前柱形是否是潜在的波动高点或低点，并将它们初始化为true。经过分析之后，如果其中任何一个标识仍为true，则表明存在波动点。此外，我们定义了两个静态双精度变量“swing_H”和“swing_L”，分别存储波动高点和低点的价格水平。我们将它们的值初始化为-1，以简单表示尚未检测到波动高点或低点。它们被设置为静态变量，确保一旦我们确定了波动点，它们就保持不变，还可以将它们存储起来以供将来参考，以便稍后确定它们是否因结构变化而突破。如果发生结构突破，我们将它们的值更改为-1，或者它们将被新生成的波动点所替换。最后，我们有“curr_bar”变量，它用于确定分析的起点。

到目前为止，我们已经完整定义了程序中所有至关重要的变量，接下来可以开始我们的分析循环。为了分析和标记波动点，我们每根K线只需完成一次即可。因此，对于波动点的分析将每根K线只完成一次，这正是“isNewBar”变量起作用之处。
    
    
       if (isNewBar){ ... }

然后，我们使用一个[for循环](/zh/docs/basis/operators/for)来查找波动高点和低点。   

    
    
          for (int j=1; j<=length; j++){
             right_index = curr_bar - j;
             left_index = curr_bar + j;
             if ( (high(curr_bar) <= high(right_index)) || (high(curr_bar) < high(left_index)) ){
                isSwingHigh = false;
             }
             if ( (low(curr_bar) >= low(right_index)) || (low(curr_bar) > low(left_index)) ){
                isSwingLow = false;
             }
          }

我们定义一个循环整数变量“j”，表示将当前柱形与其相邻柱形作比较时要考虑的柱形数量。然后，我们通过从当前柱形的索引中减去“j”来计算当前柱形右侧柱形的索引。使用相同的逻辑，我们通过向当前柱形的索引中增加“j”来获取左侧相邻柱形的索引。如果为了可视化而打印结果，我们可以得到如下内容：

![柱形索引](https://c.mql5.com/2/80/Bars_Index.png)  


打印语句是通过使用以下内置函数实现的：
    
    
             Print("Current Bar Index = ",curr_bar," ::: Right index: ",right_index,", Left index: ",left_index);

到目前为止，非常明确的是，对于选定的柱形索引（在这种情况下为20），我们在指定的长度范围内评估其左侧和右侧的所有相邻柱形。显然，在每次迭代过程中，我们向右减1，向左加1，这导致右侧索引达到0值，通常代表当前柱形，而左侧索引则是预定义长度的两倍。既然我们已经正确地进行了柱形估计，接下来就要确定每次迭代中波动点的存在。 

为了确定是否存在波动高点，我们使用条件语句来检查当前柱形的最高价格是否小于或等于右侧索引柱形的最高价格，或者小于左侧索引柱形的最高价格。如果任一条件为真，则意味着当前柱形与其相邻柱形相比没有更高的高点，因此“isSwingHigh”被设置为false。确定是否存在波动低点的逻辑相同，但条件相反。

循环结束时，如果“isSwingHigh”仍然为ture，则表明当前柱形在长度范围内的相邻柱形中具有更高的高点，将其标记为潜在的波动高点。同样的逻辑也适用于波动低点标识。如果为true，我们将波动点变量填充为相应的价格，并绘制波动点。
    
    
          if (isSwingHigh){
             swing_H = high(curr_bar);
             Print("UP @ BAR INDEX ",curr_bar," of High: ",high(curr_bar));
             drawSwingPoint(TimeToString(time(curr_bar)),time(curr_bar),high(curr_bar),77,clrBlue,-1);
          }
          if (isSwingLow){
             swing_L = low(curr_bar);
             Print("DOWN @ BAR INDEX ",curr_bar," of Low: ",low(curr_bar));
             drawSwingPoint(TimeToString(time(curr_bar)),time(curr_bar),low(curr_bar),77,clrRed,1);
          }

自定义函数用于获取波动高点的高价和波动低点的低价。这些函数的声明如下：
    
    
    double high(int index){return (iHigh(_Symbol,_Period,index));}
    double low(int index){return (iLow(_Symbol,_Period,index));}
    double close(int index){return (iClose(_Symbol,_Period,index));}
    datetime time(int index){return (iTime(_Symbol,_Period,index));}

“high”函数接受一个单一参数或自变量，该参数代表价格数据序列中柱形图的索引，通过该索引可以检索到指定柱形图的高价。同样的逻辑也适用于low（低价）、close（收盘价）和time（时间）函数。

为了在图表上绘制波动点，并将其对应到相应的柱形图上以便于可视化，我们使用以下自定义函数：
    
    
    void drawSwingPoint(string objName,datetime time,double price,int arrCode,
       color clr,int direction){
       
       if (ObjectFind(0,objName) < 0){
          ObjectCreate(0,objName,OBJ_ARROW,0,time,price);
          ObjectSetInteger(0,objName,OBJPROP_ARROWCODE,arrCode);
          ObjectSetInteger(0,objName,OBJPROP_COLOR,clr);
          ObjectSetInteger(0,objName,OBJPROP_FONTSIZE,10);
          if (direction > 0) ObjectSetInteger(0,objName,OBJPROP_ANCHOR,ANCHOR_TOP);
          if (direction < 0) ObjectSetInteger(0,objName,OBJPROP_ANCHOR,ANCHOR_BOTTOM);
          
          string txt = " BoS";
          string objNameDescr = objName + txt;
          ObjectCreate(0,objNameDescr,OBJ_TEXT,0,time,price);
          ObjectSetInteger(0,objNameDescr,OBJPROP_COLOR,clr);
          ObjectSetInteger(0,objNameDescr,OBJPROP_FONTSIZE,10);
          if (direction > 0) {
             ObjectSetInteger(0,objNameDescr,OBJPROP_ANCHOR,ANCHOR_LEFT_UPPER);
             ObjectSetString(0,objNameDescr,OBJPROP_TEXT, " " + txt);
          }
          if (direction < 0) {
             ObjectSetInteger(0,objNameDescr,OBJPROP_ANCHOR,ANCHOR_LEFT_LOWER);
             ObjectSetString(0,objNameDescr,OBJPROP_TEXT, " " + txt);
          }
       }
       ChartRedraw(0);
    }

自定义函数“drawSwingPoint”接受六个参数，以提高其可复用性。这些参数的功能如下：

  * _objName：_ 代表要创建的图形对象名称的字符串。
  * _time：_ 放置指示对象时间坐标的日期时间值。
  * _price：_ 代表放置对象的价格坐标的双精度浮点数值。
  * _arrCode：_ 箭头对象指定的代码的整数型数值。
  * _clr：_ 图形对象的颜色值（例如clrBlue、clrRed）。
  * _direction：_ 指示文本标签放置方向（上或下）的整数性数值。



该函数首先检查图表上是否已经存在具有指定名称（objName）的对象。如果不存在，它会继续新建对象。对象的创建是通过使用内置的“ObjectCreate”函数来实现的，该函数需要指定要绘制的对象，在本例中，是标识为“OBJ_ARROW”的箭头对象，以及时间和价格，它们构成了对象创建点的坐标。之后，我们设置对象的属性，包括箭头代码、颜色、字体大小和锚点。对于箭头代码，MQL5已有一些预定义的[wingdings](/zh/docs/constants/objectconstants/wingdings)字体可以直接使用。以下是这些指定字符的表格：

![箭头代码](https://c.mql5.com/2/80/Arrow_codes.png)  


到目前为止，我们只在图表中绘制了指定的箭头，如下所示：

![无描述的波动点](https://c.mql5.com/2/80/Swing_Point_Without_Description.png)  


由此可见，我们已经成功地使用指定的箭头代码（本例中箭头代码为77）绘制了波动点，但这些波动点却没有描述。因此，为了添加相应的描述，我们将箭头与文本进行拼接。我们新建了另一个指定为“OBJ_TEXT”的文本对象，并为其设置了相应的属性。文本标签作为与波动点相关的描述性注释，提供了关于波动点附加的上下文或信息，使其对交易者和分析师来说更具信息量。我们选择将文本值设置为“BoS”，表示它是一个波动点。

然后，通过将原始“objName”与描述性文本进行拼接，创建变量“objNameDescr”。这个组合名称确保了箭头及其关联的文本标签被链接在一起。以下代码段用于实现这一功能。
    
    
          string txt = " BoS";
          string objNameDescr = objName + txt;
          ObjectCreate(0,objNameDescr,OBJ_TEXT,0,time,price);
          ObjectSetInteger(0,objNameDescr,OBJPROP_COLOR,clr);
          ObjectSetInteger(0,objNameDescr,OBJPROP_FONTSIZE,10);
          if (direction > 0) {
             ObjectSetInteger(0,objNameDescr,OBJPROP_ANCHOR,ANCHOR_LEFT_UPPER);
             ObjectSetString(0,objNameDescr,OBJPROP_TEXT, " " + txt);
          }
          if (direction < 0) {
             ObjectSetInteger(0,objNameDescr,OBJPROP_ANCHOR,ANCHOR_LEFT_LOWER);
             ObjectSetString(0,objNameDescr,OBJPROP_TEXT, " " + txt);
          }

这是我们通过波动点连接及其描述得到的结果。

![有描述的波动点](https://c.mql5.com/2/80/Swing_Point_With_Description.png)  


负责分析柱状图、识别波动高点和低点、数据记录以及将对象分别映射到图表波动点的完整代码如下所示：
    
    
       if (isNewBar){
          for (int j=1; j<=length; j++){
             right_index = curr_bar - j;
             left_index = curr_bar + j;
    
             if ( (high(curr_bar) <= high(right_index)) || (high(curr_bar) < high(left_index)) ){
                isSwingHigh = false;
             }
             if ( (low(curr_bar) >= low(right_index)) || (low(curr_bar) > low(left_index)) ){
                isSwingLow = false;
             }
          }
          
          if (isSwingHigh){
             swing_H = high(curr_bar);
             Print("UP @ BAR INDEX ",curr_bar," of High: ",high(curr_bar));
             drawSwingPoint(TimeToString(time(curr_bar)),time(curr_bar),high(curr_bar),77,clrBlue,-1);
          }
          if (isSwingLow){
             swing_L = low(curr_bar);
             Print("DOWN @ BAR INDEX ",curr_bar," of Low: ",low(curr_bar));
             drawSwingPoint(TimeToString(time(curr_bar)),time(curr_bar),low(curr_bar),77,clrRed,1);
          }
       }

接下来，我们只需识别理论上所述的波动点被突破的情况，如果存在这样的情况，我们就分别可视化突破情况并开立市场头寸。这需要在每一个价格变动（tick）时进行，因此我们不受新柱形图生成的限制。我们首先声明用于在满足相应条件时开立头寸的询价（Ask）和报价（Bid）。请注意，这也需要在每一个价格变动时进行，以便我们获得最新的价格报价。
    
    
       double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
       double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);

在这里，我们定义了双精度数据类型变量来存储最近的价格，并通过将浮点数四舍五入到符号货币的位数来对其进行规范化，以保持准确性。 

为了确定价格是否上涨并突破了波动高点水平，我们使用了一个条件语句。首先，我们通过逻辑检查是否存在波动高点，即其值是否大于零，因为我们不可能突破一个尚不存在的波动高点。然后，如果我们确实已经有一个波动高点，我们会检查报价是否高于波动高点水平，以确保买入头寸是按询价开立的，并且与报价相关的交易水平（即止损和止盈）被正确地映射到突破点之上。最后，我们检查前一根柱形图的收盘价是否高于波动高点水平，以确保我们有一个符合要求的有效突破。如果所有的条件都满足，那么我们就有一个有效的BoS，并将这个实例打印到日志中。
    
    
       if (swing_H > 0 && Bid > swing_H && close(1) > swing_H){
          Print("BREAK UP NOW");
          ...
       }
    

为了可视化突破设置，我们需要绘制一条从波动高点到突破发生的K线图的箭头。这意味着我们需要为箭头的两个点创建两个坐标，通常是箭头的起点（连接到波动点）和箭头的终点（突破发生的K线图）。这在图像上表示会更加直观，如下所示：

![点坐标](https://c.mql5.com/2/80/Point_Coordinates.png)  


我们确实需要的两个坐标是时间（显示为X，代表在x轴上）和价格（显示为Y，代表在y轴上）。为了获取第二个坐标，即结构突破发生的K线图的坐标，我们使用当前柱形的索引，通常是0。然而，要获取包含波动高点的柱形的索引则有些棘手。回想一下，我们只存储了波动高点K线图的价格。我们也可以在存储价格的同时存储柱形的索引，但这完全没有用，因为之后会有新的柱形生成。这并不意味着我们无法找到包含波动点的柱条的索引。我们可以通过遍历之前柱形的最高价格来找到与我们波动高点匹配的一个。以下是实现过程。
    
    
          int swing_H_index = 0;
          for (int i=0; i<=length*2+1000; i++){
             double high_sel = high(i);
             if (high_sel == swing_H){
                swing_H_index = i;
                Print("BREAK HIGH @ BAR ",swing_H_index);
                break;
             }
          }

我们首先定义一个整型变量“swing_H_index”，用于存储波动高点的索引，并将其初始化为0。然后，我们使用for循环遍历所有预定义柱形数量的两倍再额外加上1000柱形（这只是一个任意选择的柱形数量，用于可能找到波动点的范围，这个值可以是任何数），并将所选柱形的最高点与存储的波动高点进行比较。因此，如果我们找到了匹配项，我们就存储该索引并提前退出循环，因为我们已经找到了波动高点柱形的索引。 

使用波动高点柱形的索引，就要检索该柱形的属性。在这种情况下，我们只关心时间，用于标记箭头起点的x坐标。我们使用一个自定义函数，该函数与之前用于映射箭头代码函数没有太大区别。
    
    
    void drawBreakLevel(string objName,datetime time1,double price1,
       datetime time2,double price2,color clr,int direction){
       if (ObjectFind(0,objName) < 0){
          ObjectCreate(0,objName,OBJ_ARROWED_LINE,0,time1,price1,time2,price2);
          ObjectSetInteger(0,objName,OBJPROP_TIME,0,time1);
          ObjectSetDouble(0,objName,OBJPROP_PRICE,0,price1);
          ObjectSetInteger(0,objName,OBJPROP_TIME,1,time2);
          ObjectSetDouble(0,objName,OBJPROP_PRICE,1,price2);
          ObjectSetInteger(0,objName,OBJPROP_COLOR,clr);
          ObjectSetInteger(0,objName,OBJPROP_WIDTH,2);
          
          string txt = " Break   ";
          string objNameDescr = objName + txt;
          ObjectCreate(0,objNameDescr,OBJ_TEXT,0,time2,price2);
          ObjectSetInteger(0,objNameDescr,OBJPROP_COLOR,clr);
          ObjectSetInteger(0,objNameDescr,OBJPROP_FONTSIZE,10);
          if (direction > 0) {
             ObjectSetInteger(0,objNameDescr,OBJPROP_ANCHOR,ANCHOR_RIGHT_UPPER);
             ObjectSetString(0,objNameDescr,OBJPROP_TEXT, " " + txt);
          }
          if (direction < 0) {
             ObjectSetInteger(0,objNameDescr,OBJPROP_ANCHOR,ANCHOR_RIGHT_LOWER);
             ObjectSetString(0,objNameDescr,OBJPROP_TEXT, " " + txt);
          }
       }
       ChartRedraw(0);
    }

以下是与之前函数相比的差异说明。

  1. 我们将函数名称声明为“drawBreakLevel”。
  2. 我们创建的对象是一个箭头线，其标识符为“OBJ_ARROWED_LINE”。
  3. 我们的箭头线包含两个坐标点：第一个坐标点的时间为1，价格为1；第二个坐标点的时间为2，价格为2。
  4. 连接文本为“Break”，表示发生了BoS。



之后，我们使用该函数在图表上绘制表示突破水平的箭头线。对于第二个坐标点的时间2，我们只需加1，就能定位到当前柱形之前的柱形，以确保准确性。接着，我们将波动高点的变量值重置为-1，以表示我们已经突破了该结构，并且该形态已不再存在。这有助于避免在前几个tick上继续寻找突破，因为我们已经突破了波动高点。因此，我们只需等待形成另一个波动高点，然后再次填充该变量，使循环继续。
    
    
          drawBreakLevel(TimeToString(time(0)),time(swing_H_index),high(swing_H_index),
          time(0+1),high(swing_H_index),clrBlue,-1);
          
          swing_H = -1.0;

最后，一旦我们观察到波动高点被突破，就立即开立一个买入头寸。 
    
    
          //--- Open Buy
          obj_Trade.Buy(0.01,_Symbol,Ask,Bid-500*7*_Point,Bid+500*_Point,"BoS Break Up BUY");
          
          return;

我们使用对象“obj_Trade”和点运算符来访问类中包含的所有方法。在这种情况下，我们只需要执行买入操作，使用“Buy”方法，并提供交易量、交易级别和交易备注。最后，我们直接返回，因为一切已就绪，没有更多代码需要执行。但是，如果你还有其它代码，请避免使用return运算符，因为它会终止当前函数的执行并将控制权返回给调用程序。完整的代码如下，确保我们能够找到结构的突破点，绘制箭头线，并开立买入头寸。
    
    
       if (swing_H > 0 && Bid > swing_H && close(1) > swing_H){
          Print("BREAK UP NOW");
          int swing_H_index = 0;
          for (int i=0; i<=length*2+1000; i++){
             double high_sel = high(i);
             if (high_sel == swing_H){
                swing_H_index = i;
                Print("BREAK HIGH @ BAR ",swing_H_index);
                break;
             }
          }
          drawBreakLevel(TimeToString(time(0)),time(swing_H_index),high(swing_H_index),
          time(0+1),high(swing_H_index),clrBlue,-1);
          
          swing_H = -1.0;
          
          //--- Open Buy
          obj_Trade.Buy(0.01,_Symbol,Ask,Bid-500*7*_Point,Bid+500*_Point,"BoS Break Up BUY");
          
          return;
       }

对于波动低点的突破、同时绘制箭头突破线以及开立卖出头寸，逻辑是相同的，但条件相反。其完整的代码如下：
    
    
       else if (swing_L > 0 && Ask < swing_L && close(1) < swing_L){
          Print("BREAK DOWN NOW");
          int swing_L_index = 0;
          for (int i=0; i<=length*2+1000; i++){
             double low_sel = low(i);
             if (low_sel == swing_L){
                swing_L_index = i;
                Print("BREAK LOW @ BAR ",swing_L_index);
                break;
             }
          }
          drawBreakLevel(TimeToString(time(0)),time(swing_L_index),low(swing_L_index),
          time(0+1),low(swing_L_index),clrRed,1);
    
          swing_L = -1.0;
          
          //--- Open Sell
          obj_Trade.Sell(0.01,_Symbol,Bid,Ask+500*7*_Point,Ask-500*_Point,"BoS Break Down SELL");
    
          return;
       }

这代表了BoS的里程碑。

![里程碑](https://c.mql5.com/2/80/Milestone.png)  


以下是使用MQL5创建外汇交易策略BoS所需的完整代码，该策略能够识别突破并相应地开仓。
    
    
    //+------------------------------------------------------------------+
    //|                                                          BOS.mq5 |
    //|                                  Copyright 2024, MetaQuotes Ltd. |
    //|                                             https://www.mql5.com |
    //+------------------------------------------------------------------+
    #property copyright "Copyright 2024, MetaQuotes Ltd."
    #property link      "https://www.mql5.com"
    #property version   "1.00"
    
    #include <Trade/Trade.mqh>
    CTrade obj_Trade;
    
    //+------------------------------------------------------------------+
    //| Expert initialization function                                   |
    //+------------------------------------------------------------------+
    int OnInit(){return(INIT_SUCCEEDED);}
    //+------------------------------------------------------------------+
    //| Expert deinitialization function                                 |
    //+------------------------------------------------------------------+
    void OnDeinit(const int reason){}
    //+------------------------------------------------------------------+
    //| Expert tick function                                             |
    //+------------------------------------------------------------------+
    void OnTick(){
       
       static bool isNewBar = false;
       int currBars = iBars(_Symbol,_Period);
       static int prevBars = currBars;
       if (prevBars == currBars){isNewBar = false;}
       else if (prevBars != currBars){isNewBar = true; prevBars = currBars;}
       
       const int length = 5;
       const int limit = 5;
    
       int right_index, left_index;
       bool isSwingHigh = true, isSwingLow = true;
       static double swing_H = -1.0, swing_L = -1.0;
       int curr_bar = limit;
       
       if (isNewBar){
          for (int j=1; j<=length; j++){
             right_index = curr_bar - j;
             left_index = curr_bar + j;
             //Print("Current Bar Index = ",curr_bar," ::: Right index: ",right_index,", Left index: ",left_index);
             //Print("curr_bar(",curr_bar,") right_index = ",right_index,", left_index = ",left_index);
             // If high of the current bar curr_bar is <= high of the bar at right_index (to the left),
             //or if it’s < high of the bar at left_index (to the right), then isSwingHigh is set to false
             //This means that the current bar curr_bar does not have a higher high compared
             //to its neighbors, and therefore, it’s not a swing high
             if ( (high(curr_bar) <= high(right_index)) || (high(curr_bar) < high(left_index)) ){
                isSwingHigh = false;
             }
             if ( (low(curr_bar) >= low(right_index)) || (low(curr_bar) > low(left_index)) ){
                isSwingLow = false;
             }
          }
          //By the end of the loop, if isSwingHigh is still true, it suggests that 
          //current bar curr_bar has a higher high than the surrounding bars within
          //length range, marking a potential swing high.
          
          if (isSwingHigh){
             swing_H = high(curr_bar);
             Print("UP @ BAR INDEX ",curr_bar," of High: ",high(curr_bar));
             drawSwingPoint(TimeToString(time(curr_bar)),time(curr_bar),high(curr_bar),77,clrBlue,-1);
          }
          if (isSwingLow){
             swing_L = low(curr_bar);
             Print("DOWN @ BAR INDEX ",curr_bar," of Low: ",low(curr_bar));
             drawSwingPoint(TimeToString(time(curr_bar)),time(curr_bar),low(curr_bar),77,clrRed,1);
          }
       }
       
       double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
       double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
    
       if (swing_H > 0 && Bid > swing_H && close(1) > swing_H){
          Print("BREAK UP NOW");
          int swing_H_index = 0;
          for (int i=0; i<=length*2+1000; i++){
             double high_sel = high(i);
             if (high_sel == swing_H){
                swing_H_index = i;
                Print("BREAK HIGH @ BAR ",swing_H_index);
                break;
             }
          }
          drawBreakLevel(TimeToString(time(0)),time(swing_H_index),high(swing_H_index),
          time(0+1),high(swing_H_index),clrBlue,-1);
          
          swing_H = -1.0;
          
          //--- Open Buy
          obj_Trade.Buy(0.01,_Symbol,Ask,Bid-500*7*_Point,Bid+500*_Point,"BoS Break Up BUY");
          
          return;
       }
       else if (swing_L > 0 && Ask < swing_L && close(1) < swing_L){
          Print("BREAK DOWN NOW");
          int swing_L_index = 0;
          for (int i=0; i<=length*2+1000; i++){
             double low_sel = low(i);
             if (low_sel == swing_L){
                swing_L_index = i;
                Print("BREAK LOW @ BAR ",swing_L_index);
                break;
             }
          }
          drawBreakLevel(TimeToString(time(0)),time(swing_L_index),low(swing_L_index),
          time(0+1),low(swing_L_index),clrRed,1);
    
          swing_L = -1.0;
          
          //--- Open Sell
          obj_Trade.Sell(0.01,_Symbol,Bid,Ask+500*7*_Point,Ask-500*_Point,"BoS Break Down SELL");
    
          return;
       }
       
    }
    //+------------------------------------------------------------------+
    
    double high(int index){return (iHigh(_Symbol,_Period,index));}
    double low(int index){return (iLow(_Symbol,_Period,index));}
    double close(int index){return (iClose(_Symbol,_Period,index));}
    datetime time(int index){return (iTime(_Symbol,_Period,index));}
    
    void drawSwingPoint(string objName,datetime time,double price,int arrCode,
       color clr,int direction){
       
       if (ObjectFind(0,objName) < 0){
          ObjectCreate(0,objName,OBJ_ARROW,0,time,price);
          ObjectSetInteger(0,objName,OBJPROP_ARROWCODE,arrCode);
          ObjectSetInteger(0,objName,OBJPROP_COLOR,clr);
          ObjectSetInteger(0,objName,OBJPROP_FONTSIZE,10);
          if (direction > 0) ObjectSetInteger(0,objName,OBJPROP_ANCHOR,ANCHOR_TOP);
          if (direction < 0) ObjectSetInteger(0,objName,OBJPROP_ANCHOR,ANCHOR_BOTTOM);
          
          string txt = " BoS";
          string objNameDescr = objName + txt;
          ObjectCreate(0,objNameDescr,OBJ_TEXT,0,time,price);
          ObjectSetInteger(0,objNameDescr,OBJPROP_COLOR,clr);
          ObjectSetInteger(0,objNameDescr,OBJPROP_FONTSIZE,10);
          if (direction > 0) {
             ObjectSetInteger(0,objNameDescr,OBJPROP_ANCHOR,ANCHOR_LEFT_UPPER);
             ObjectSetString(0,objNameDescr,OBJPROP_TEXT, " " + txt);
          }
          if (direction < 0) {
             ObjectSetInteger(0,objNameDescr,OBJPROP_ANCHOR,ANCHOR_LEFT_LOWER);
             ObjectSetString(0,objNameDescr,OBJPROP_TEXT, " " + txt);
          }
       }
       ChartRedraw(0);
    }
    
    void drawBreakLevel(string objName,datetime time1,double price1,
       datetime time2,double price2,color clr,int direction){
       if (ObjectFind(0,objName) < 0){
          ObjectCreate(0,objName,OBJ_ARROWED_LINE,0,time1,price1,time2,price2);
          ObjectSetInteger(0,objName,OBJPROP_TIME,0,time1);
          ObjectSetDouble(0,objName,OBJPROP_PRICE,0,price1);
          ObjectSetInteger(0,objName,OBJPROP_TIME,1,time2);
          ObjectSetDouble(0,objName,OBJPROP_PRICE,1,price2);
          ObjectSetInteger(0,objName,OBJPROP_COLOR,clr);
          ObjectSetInteger(0,objName,OBJPROP_WIDTH,2);
          
          string txt = " Break   ";
          string objNameDescr = objName + txt;
          ObjectCreate(0,objNameDescr,OBJ_TEXT,0,time2,price2);
          ObjectSetInteger(0,objNameDescr,OBJPROP_COLOR,clr);
          ObjectSetInteger(0,objNameDescr,OBJPROP_FONTSIZE,10);
          if (direction > 0) {
             ObjectSetInteger(0,objNameDescr,OBJPROP_ANCHOR,ANCHOR_RIGHT_UPPER);
             ObjectSetString(0,objNameDescr,OBJPROP_TEXT, " " + txt);
          }
          if (direction < 0) {
             ObjectSetInteger(0,objNameDescr,OBJPROP_ANCHOR,ANCHOR_RIGHT_LOWER);
             ObjectSetString(0,objNameDescr,OBJPROP_TEXT, " " + txt);
          }
       }
       ChartRedraw(0);
    }

恭喜！现在我们基于BoS外汇交易策略创建了一套聪明资金概念交易系统，该系统不仅能够生成交易信号，还能根据生成的信号开仓。

  


### 策略测试结果

在策略测试器上进行测试后，我们得到了以下结果：

  * **余额/资产净值图表：**



![图形](https://c.mql5.com/2/80/GRAPH.png)  


  * **回测结果**



![结果](https://c.mql5.com/2/80/RESULTS.png)  


  


### 结论

综上所述，我们可以自信地说，经过思考研究后，BoS策略的自动化并不像人们认为的那样复杂。从技术层面来看，您可以发现，其创建过程仅需针对策略及其实际需求有清晰的理解，或者说对设置有效策略必须达成的目标有清晰地认识。 

总而言之，本文强调了创建BoS外汇交易策略时必须考虑并需要清晰理解的理论部分。包括其定义、描述、类型以及方案。此外，在策略的编码方面强调了分析K线图、识别波动点、跟踪其突破、可视化输出结果以及根据生成的信号开仓的步骤。从长远来看，这能够实现BoS策略的自动化，促进执行速度的加快和策略的可扩展性。

免责声明：本文中的信息仅用于教学目的。本文旨在展示如何基于聪明资金概念（SMC）方法创建一个结构突破（BoS）EA的示例，因此，作为创建更优化EA的基础，在创建过程中需更多地考虑优化措施和数据提取。所展示的信息并不能保证任何交易结果。 

我们真心希望您觉得这篇文章不仅对您有帮助，并且易于理解，这样您就能在未来的EA开发中利用文章中提供的内容。从技术层面上讲，这篇文章基于SMC方法，特别是用BoS策略来分析市场，为您提供便利。

  


本文由MetaQuotes Ltd译自英文  
原文地址： [https://www.mql5.com/en/articles/15017](/en/articles/15017)

**附加的文件** | 

[ __下载ZIP](/zh/articles/download/15017.zip "下载单独ZIP中的所有附件")

[__Break_of_Structure_jBoSc_EA.mq5](/zh/articles/download/15017/break_of_structure_jbosc_ea.mq5 "下载 Break_of_Structure_jBoSc_EA.mq5") (15.11 KB)

[__Break_of_Structure_tBoSt_EA.ex5](/zh/articles/download/15017/break_of_structure_tbost_ea.ex5 "下载 Break_of_Structure_tBoSt_EA.ex5") (35.08 KB)

**注意:** MetaQuotes Ltd.将保留所有关于这些材料的权利。全部或部分复制或者转载这些材料将被禁止。

本文由网站的一位用户撰写，反映了他们的个人观点。MetaQuotes Ltd 不对所提供信息的准确性负责，也不对因使用所述解决方案、策略或建议而产生的任何后果负责。

![Allan Munene Mutiiria](https://c.mql5.com/avatar/2022/11/637df59b-9551_big.jpg)

[Allan Munene Mutiiria](/zh/users/29210372 "Allan Munene Mutiiria")

  * __[肯尼亚](https://www.mql5.com/go?https://maps.google.com/?z=4&q=%e8%82%af%e5%b0%bc%e4%ba%9a "实时")
  * __[194457](/zh/users/29210372/achievements "等级")



* [](https://forexalgo-trader.com/) <https://forexalgo-trader.com/>

#### 该作者的其他文章

  * [MQL5交易工具（第七部分）：用于多品种持仓与账户监控的信息仪表盘](/zh/articles/18986)
  * [MQL5交易工具（第六部分）：带脉冲动画与控件的动态全息仪表盘](/zh/articles/18880)
  * [MQL5 交易策略自动化（第24篇）：集成风险管理与移动止损的伦敦时段突破系统](/zh/articles/18867)
  * [MQL5 交易工具（第五部分）：创建滚动行情条，实现交易品种实时监控](/zh/articles/18844)
  * [MQL5交易工具（第四部分）：为多周期扫描仪表盘添加动态定位与切换功能](/zh/articles/18786)
  * [MQL5 交易策略自动化（第 23 部分）：带追踪止损与篮子交易的区间补仓系统](/zh/articles/18778)
  * [MQL5交易策略自动化（第二十二部分）：构建基于包络线趋势交易的区间补仓系统](/zh/articles/18720)



**最近评论 |[前往讨论](/zh/forum/477929) ** (11) 

![Vitaly Murlenko](https://c.mql5.com/avatar/2023/1/63d3980b-a02e.jpg)

**[Vitaly Murlenko](/zh/users/drknn)** | 8 11月 2024 在 22:03

作者，我不明白你的意思。你的截图显示了上升趋势，有 HH 和 HL 水平。但接下来的截图却让人一头雾水。你看

[ ![](https://c.mql5.com/3/448/Screenshot_2__1.jpg)](https://c.mql5.com/3/448/Screenshot_2.jpg "https://c.mql5.com/3/448/Screenshot_2.jpg")

那么，如何选择正确的突破水平呢？

![Maxim Kuznetsov](https://c.mql5.com/avatar/2016/1/56935A91-AF51.png)

**[Maxim Kuznetsov](/zh/users/nektomk)** | 8 11月 2024 在 22:43

**Vitaly Murlenko[#](/ru/forum/476121#comment_55071975):**  


作者，我不明白你的意思。你的截图显示了上升趋势，有 HH 和 HL 水平。但接下来的截图却让人一头雾水。请看

那么，如何选择正确的突破水平呢？

所有这些策略只在日内有效（这不是事实）。

它们在日内并不起作用，因为日内有规律的剧烈波动。

但在日内选择截图是很方便的。

![Vitaly Murlenko](https://c.mql5.com/avatar/2023/1/63d3980b-a02e.jpg)

**[Vitaly Murlenko](/zh/users/drknn)** | 8 11月 2024 在 22:44

**Maxim Kuznetsov[#](/ru/forum/476121#comment_55072051):**  


所有这些策略只有在一日游时才有效（这不是事实）。

在日内有规律的剧烈波动是行不通的。

但在日内选择截图很方便。

问题不在于此

![fengbao88](https://c.mql5.com/avatar/2025/8/689eef3d-c431.jpg)

**[fengbao88](/zh/users/fengbao88)** | 25 11月 2025 在 06:55

严重的未来函数，这是纯纯的欺骗，不知道你的目的是什么。 

const int limit = 20; int curr_bar = limit; // = 20

for (int j=1; j<=length; j++){ right_index = curr_bar - j; // 左边：历史柱子（正确） left_index = curr_bar + j; // 右边：未来柱子（严重错误！！！）

if ( (high(curr_bar) <= high(right_index)) || (high(curr_bar) < high(left_index)) ){ isSwingHigh = false; } if ( (low(curr_bar) >= low(right_index)) || (low(curr_bar) > low(left_index)) ){ isSwingLow = false; } }

![Allan Munene Mutiiria](https://c.mql5.com/avatar/2022/11/637df59b-9551.jpg)

**[Allan Munene Mutiiria](/zh/users/29210372)** | 25 11月 2025 在 08:04

**fengbao88[#](/en/forum/468554#comment_58590838):**  
严肃的未来函数，这纯粹是作弊，不知道你的目的是什么。 

const int limit = 20; int curr_bar = limit; // = 20

for (int j=1; j<=length; j++){ right_index = curr_bar - j; // left: historical bar (correct) left_index = curr_bar + j; // right: future bar (seriously wrong!!!)

if ( (high(curr_bar) <= high(right_index))|| (high(curr_bar) < high(left_index)) ){ isSwingHigh = false; } if ( ( (low(curr_bar) >= low( right_index))| (low(curr_bar) > low(left_index)) ){ isSwingLow = false; }}

好吧，那么你们是如何实现的？你的解释清楚地表明你了解我们的方法。扫描左右两个条形图。在你的案例中，你建议怎么做？如果你有更好的方法，这对其他人也会有帮助。谢谢。 

![您应当知道的 MQL5 向导技术（第 13 部分）：智能信号类 DBSCAN](https://c.mql5.com/2/73/MQL5_Wizard_Techniques_you_should_know_Part_13_DBSCAN_for_Expert_Signal_Class___LOGO.png) [您应当知道的 MQL5 向导技术（第 13 部分）：智能信号类 DBSCAN](/zh/articles/14489)

《基于密度的空间聚类参与噪声应用》是一种无监督的数据分组形式，除 2 个参数外，几乎不需要任何输入参数，比之其它方式，譬如 k-平均，这是一个福音。我们深入研究使用由向导组装的智能系统如何在测试、及最终交易时起到建设性作用。

![开发多币种 EA 交易（第 9 部分）：收集单一交易策略实例的优化结果](https://c.mql5.com/2/76/Developing_a_multi-currency_advisor_gPart_9e_SQL____LOGO.png) [开发多币种 EA 交易（第 9 部分）：收集单一交易策略实例的优化结果](/zh/articles/14680)

让我们来概述一下 EA 开发的主要阶段。首先要做的一件事就是优化所开发交易策略的单个实例。让我们试着在一个地方收集优化过程中测试器通过的所有必要信息。

![构建K线图的趋势约束模型（第四部分）：为各个趋势波段自定义显示样式](https://c.mql5.com/2/80/Building_A_Candlestick_Trend_Constraint_Model_Part_4___LOGO.png) [构建K线图的趋势约束模型（第四部分）：为各个趋势波段自定义显示样式](/zh/articles/14899)

在本文中，我们将探讨强大的MQL5语言在MetaTrader 5上绘制各种指标样式的能力。我们还将研究脚本及其在模型中的应用。

![在MetaTrader 5中集成隐马尔可夫模型](https://c.mql5.com/2/80/Integrating_Hidden_Markov_Models_in_MetaTrader_5_____LOGO.png) [在MetaTrader 5中集成隐马尔可夫模型](/zh/articles/15033)

在本文中，我们将展示如何将使用Python训练的隐马尔可夫模型（Hidden Markov Models, HMMs）集成到MetaTrader 5应用程序中。HMM是一种强大的统计工具，用于对时间序列数据进行建模，其中被建模的系统以不可观察（隐藏）的状态为特征。HMM的一个基本前提是，在特定时间处于给定状态的概率取决于该过程在前一个时间点的状态。

![MQL5 - MetaTrader 5客户端内置的交易策略语言](https://c.mql5.com/i/registerlandings/logo-2.png)

您错过了交易机会：

  * 免费交易应用程序
  * 8,000+信号可供复制
  * 探索金融市场的经济新闻



注册 登录

  * [使用 Google 登录](https://www.mql5.com/zh/auth_oauth2?provider=Google&amp;return=popup&amp;reg=1)



您同意[网站政策](/zh/about/privacy)和[使用条款](/zh/about/terms)

如果您没有帐号，请[注册](https://www.mql5.com/zh/auth_register)

可以使用cookies登录MQL5.com网站。

请在您的浏览器中启用必要的设置，否则您将无法登录。

  * [使用 Google 登录](https://www.mql5.com/zh/auth_oauth2?provider=Google&amp;return=popup)


