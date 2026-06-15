# ZH_VWAP成交量加权平均价_外部资金流

> 来源标题：价格行为分析工具包开发（第10部分）：外部资金流（二）VWAP - MQL5文章
> 来源链接：https://www.mql5.com/zh/articles/16984
> 下载时间：2026-06-13 02:50:21
> 用途：POC/AVWAP重新接受专题补全来源。

---

[ __](javascript:void\(false\);) [English](/en/articles/16984) [Русский](/ru/articles/16984) [Español](/es/articles/16984) [Deutsch](/de/articles/16984) [日本語](/ja/articles/16984) [Português](/pt/articles/16984)

__

[ __](/zh/articles/16984?print= "打印优化版本")

![preview](data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAsICAoIBwsKCQoNDAsNERwSEQ8PESIZGhQcKSQrKigkJyctMkA3LTA9MCcnOEw5PUNFSElIKzZPVU5GVEBHSEX/2wBDAQwNDREPESESEiFFLicuRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUX/wAARCAAQACADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAABAUG/8QAIBAAAQQBBAMAAAAAAAAAAAAAAQACAxEEBQYhMRIycf/EABYBAQEBAAAAAAAAAAAAAAAAAAUBAv/EABsRAAIDAAMAAAAAAAAAAAAAAAEDAAIhBBEx/9oADAMBAAIRAxEAPwDIO24Lth4+pOLpAiPNo8eozg9p0ObI72W707Hsi2EHRKOLiMjIJFqvHN4toDhRoJyUxs4rtEchWxhLRYbP/9k=)

![价格行为分析工具包开发（第10部分）：外部资金流（二）VWAP](https://c.mql5.com/2/115/Price_Action_Analysis_Toolkit_Development_Part_10_600x314.jpg)

# 价格行为分析工具包开发（第10部分）：外部资金流（二）VWAP

[MetaTrader 5](/zh/articles/mt5) — [交易系统](/zh/articles/mt5/trading_systems) | 20 十月 2025, 15:05

![](https://c.mql5.com/i/icons.svg#views-white-usage) 984  [ ![](https://c.mql5.com/i/icons.svg#comments-white-usage) 4 ](/zh/forum/498045 "评论")

![Christian Benjamin](https://c.mql5.com/avatar/2025/10/68fd3661-daee.png)

[Christian Benjamin](/zh/users/lynnchris)

### 引言

在我们[上一篇文章](/zh/articles/16967)中，我们介绍了市场数据与外部库的集成，展示了通过各种自动化系统分析市场的能力。Python强大的框架为高级数据分析、预测建模和可视化提供了强大的工具，而MQL5则专注于无缝的交易执行和基于图表的操作。通过结合这些优势，我们实现了一个用于市场分析和交易的灵活、高效且精密的系统。

本文围绕成交量加权平均价格（VWAP）的概念，展示了一个强大的工具，用以提供精确的交易信号。利用Python的高级库进行计算，可以增强分析的准确性，从而产生高度可操作的VWAP信号。我们将首先探讨该策略，然后深入剖析MQL5代码的核心逻辑，并讨论其成果。最后，我们以结论作结。下面让我们看看文章的目录：

  * [理解策略](/zh/articles/16984#para2)
  * [核心逻辑](/zh/articles/16984#para3)
  * [结果](/zh/articles/16984#para4)
  * [结论](/zh/articles/16984#para5)



  


### 理解策略

VWAP，即成交量加权平均价格，是一种技术分析工具，它反映了资产价格与其总交易量之间的关系。它让交易者和投资者了解某只股票在特定时期内的平均成交价格。VWAP通常被较为被动的投资者（如养老基金和共同基金）用作基准，以评估其交易的质量。对于希望确定资产是否以最优价格买入或卖出的交易者来说，它也很有价值。  
要计算VWAP，公式如下：  


VWAP = ∑(资产交易量 × 资产价格) / 当日总交易量

![VWAP 公式](https://c.mql5.com/2/114/image_2025-01-28_003832793.png)

VWAP通常使用单个交易日内下达的订单来计算。不过，它也可以应用于多个时间框架，以进行更广泛的市场分析。在图表上，VWAP显示为一条线，并作为一个动态的参考点。当价格位于VWAP之上时，市场通常处于上升趋势。相反，当价格位于VWAP之下时，市场通常被认为处于下降趋势。在下图中，我通过高亮显示价格倾向于在VWAP附近反应的关键水平，将VWAP策略进行了可视化。这些标记的水平展示了市场通常如何与VWAP线进行互动。

![VWAP 策略](https://c.mql5.com/2/114/image1.png)

图例 1. VWAP 策略

让我们来探索这个系统背后的逻辑。首先，我们将审视下图呈现的要点，然后进行详细解释。

![EA 逻辑](https://c.mql5.com/2/114/FLOWCHART__1.png)

图例 2. 系统逻辑

该VWAP智能交易系统（EA）旨在监控图表，并与Python无缝交互以进行高级市场分析。它将市场数据发送到Python，并将接收到的交易信号记录在MetaTrader 5的“智能交易”选项卡中。该策略利用成交量加权平均价格（VWAP）作为其核心指标，以提供精确且可操作的见解。以下是该策略的详细分解：

> 1\. _数据采集_

EA收集过去150根K线的历史市场数据（价格和成交量）。它确保数据有效（例如，没有缺失或零值）。数据被保存为CSV文件以便追溯，并发送到Python服务器进行分析。

> 2\. _Python 分析_

Python脚本使用接收到的数据计算VWAP，并利用高级库进行精确计算。两个库负责核心计算和分析： _Pandas_ 和 _NumPy_ 。Pandas便于数据操作、滚动平均和累计计算，而 _NumPy_ 则管理数值运算，包括条件逻辑和向量化计算。它们共同为时间序列数据分析提供了高效且准确的处理能力。

分析内容包括：

  * VWAP 计算：确定选定时间范围内按成交量加权的平均价格。
  * 信号生成：根据当前价格与VWAP水平之间的关系提供交易信号（例如，买入/卖出）。
  * 解释说明：每个信号都附带文本解释，以阐明其生成原因。



> 3\. _信号确认_

EA引入了确认机制：

只有当信号在多个时间间隔内（例如，2个确认周期）持续出现时，才会被更新。

这减少了假阳性信号，并提高了信号的可靠性。

> 4\. _输出与警报_

信号以以下方式显示：

  * 警报：用于交易者立即采取行动的实时通知。
  * 日志消息：在EA的终端中打印，供审查使用。



未来版本可能会在图表上包含图形标注，以实现更好的可视化。

> Python：   
>  | MQL5   
>   
> ---|---  
> 高效处理大型数据集。 | 实时监控市场并与图表集成  
> 利用强大的库进行高级计算和建模 | 提供即时警报和通知  
> 确保基于VWAP的策略具有更高的准确性和灵活性  
>  | 在MQL5上使用VWAP有助于凸显关键的支撑和阻力位。这使得交易者能够根据市场对VWAP的反应做出决策，而VWAP通常充当价格运动的强力枢轴点。  
>   
>   
> 

### 核心逻辑

**1\. MQL5 EA**

_初始化：设置EA_

当您首次将智能交易应用于图表时， _OnInit()_ 函数会被执行。此函数负责初始化EA、设置必要的资源，并确保一切准备就绪可以运行。我们通常在这里包含设置任务，例如打印消息、初始化变量或设置参数。在我们的案例中，我们只是打印一条消息来确认EA已被初始化。此步骤还返回 INIT_SUCCEEDED，以表明初始化成功，这对于EA正常运行至关重要。
    
    
    int OnInit()
    {
       Print("VWAP Expert initialized.");
       return(INIT_SUCCEEDED);
    }
    

初始化是EA建立其基础的第一阶段。确保任何参数或资源都已正确设置至关重要。一条简单的确认消息能让您知道EA已准备就绪。

_反初始化：EA停止时进行清理_

当EA从图表上移除或MetaTrader关闭时，就会发生反初始化。此时会调用 _OnDeinit()_ 函数，以清理在 _OnInit()_ 期间分配或初始化的任何资源。在这里，它只是打印一条消息，指示EA正在被反初始化。这是一个良好的实践，可以确保EA可能正在使用的任何资源或进程都被正确关闭，以防止内存泄漏或不必要的后台进程运行。
    
    
    void OnDeinit(const int reason)
    {
       Print("VWAP Expert deinitialized.");
    }
    

正确的反初始化对于维持系统性能至关重要。当EA被移除时，务必清理资源，以避免留下悬空的进程。反初始化函数可能包括保存数据、关闭连接或停止计时器。

_收集市场数据（K线）_

此EA的核心涉及收集用于分析的市场数据（K线）。此过程在 _OnTick()_ 函数内开始，该函数在每次市场价格更新时执行。EA被配置为按设定的时间间隔收集数据，每个间隔由 _signalIntervalMinutes_ 定义。自上次信号发出经过足够的时间后，EA便开始收集最近 _numCandles_ 根K线的市场数据（开盘价、最高价、最低价、收盘价、成交量）。

然后将数据格式化为CSV字符串，这一点至关重要，因为它将被发送到Python服务器进行进一步处理。循环从最新的K线开始向后迭代，以确保我们捕获到最新的市场数据，并使用 _StringFormat()_ 以标准化的方式格式化数据。
    
    
    int totalBars = iBars(Symbol(), Period());
    if (totalBars < numCandles)
    {
       Print("Error: Not enough candles on the chart to collect ", numCandles, " candles.");
       return;
    }
    
    for (int i = numCandles - 1; i >= 0; i--)
    {
       datetime currentTime = iTime(Symbol(), Period(), i);
       if (currentTime == 0) continue;
    
       double high = iHigh(Symbol(), Period(), i);
       double low = iLow(Symbol(), Period(), i);
       double close = iClose(Symbol(), Period(), i);
       double open = iOpen(Symbol(), Period(), i);
       long volume = iVolume(Symbol(), Period(), i);
    
       if (high == 0 || low == 0 || close == 0 || volume == 0)
       {
          Print("Skipping invalid data at ", TimeToString(currentTime, TIME_DATE | TIME_MINUTES));
          continue;
       }
    
       csvData += StringFormat("%s,%.5f,%.5f,%.5f,%.5f,%ld\n",
                               TimeToString(currentTime, TIME_DATE | TIME_MINUTES),
                               high, low, open, close, volume);
    }
    

> _iBars():_

iBars() 函数用于检索当前品种和时间周期图表上可用的K线总数。EA会检查是否有至少 numCandles 根K线可用。如果没有，它会打印一条错误消息并从函数中返回，以阻止进一步的数据收集。

> _for 循环：_

for 循环从最新的K线 _(numCandles_ \- 1) 向后迭代到最旧的K线 (0)，以收集所需数量的K线。

> _iTime(), iHigh(), iLow(), iOpen(), iClose(), iVolume():_

这些函数用于获取每根K线的相关价格数据。 _iTime()_ 获取时间戳， _iHigh()_ 获取最高价， _iLow()_ 获取最低价，以此类推。

> _数据验证：_

在将数据追加到CSV字符串之前，EA会检查是否存在缺失或无效的数据（零值）。如果任何K线的数据无效，迭代将继续，并跳过该根K线。

> _字符串格式化：_

_StringFormat()_ 用于将K线数据格式化为CSV行。每个字段由逗号分隔，时间戳使用 _TimeToString()_ 格式化为可读的字符串。

_将数据写入CSV文件_

一旦我们收集了数据，下一步就是将其写入CSV文件。这一点至关重要，因为我们需要在将数据发送到Python服务器之前，将其在本地保存。 _FileOpen()_ 函数以写入模式打开文件，FileWriteString() 则将格式化后的CSV数据写入其中。写入数据后，文件被关闭，以完成该过程并确保没有数据丢失。

CSV文件保存在 MQL5\Files 目录中，这是MetaTrader中一个用于存储平台可访问文件的专用目录。这确保了在需要时可以轻松检索该文件。
    
    
    string fileName = StringFormat("%s_vwap_data.csv", Symbol());
    string filePath = "MQL5\\Files\\" + fileName;
    int fileHandle = FileOpen(filePath, FILE_WRITE | FILE_CSV | FILE_ANSI);
    if (fileHandle != INVALID_HANDLE) {
        FileWriteString(fileHandle, csvData);
        FileClose(fileHandle);
    } else {
        Print("Failed to open file for writing: ", filePath);
    }
    
    

将数据写入CSV文件是一种在本地存储信息以供未来分析的方法。使用 _FILE_CSV_ 确保数据以标准化格式保存，使其与其他系统（如Python）兼容。这里的错误处理确保了如果文件无法打开，EA能够优雅地处理该问题并打印一条错误消息。

_发送数据到Python服务器进行VWAP分析_

现在，收集好的数据已准备好发送到Python服务器进行分析。这是通过 _WebRequest()_ 函数完成的，该函数允许EA发出HTTP请求。CSV数据被转换为字符数组 _(StringToCharArray())_ ，并通过POST请求发送到服务器。请求头指定了发送的内容是CSV格式，服务器的响应则被捕获在一个结果数组中。

超时参数被设置为5000毫秒（5秒），以确保如果服务器没有响应，请求不会挂起太久。
    
    
    char data[];
    StringToCharArray(csvData, data); 
    
    string headers = "Content-Type: text/csv\r\n";
    char result[];
    string resultHeaders;
    int timeout = 5000;
    
    int responseCode = WebRequest("POST", pythonUrl, headers, timeout, data, result, resultHeaders);
    

这里使用 _HTTP POST_ 是因为它是向服务器发送数据而不改变URL的最佳方式。 _WebRequest()_ 处理与Python服务器的通信，所有繁重的工作（即VWAP计算）都在那里进行。超时设置确保了如果服务器无响应，EA不会卡住，从而保持平稳运行。

_处理来自Python服务器的响应_

发送数据后，我们需要处理来自Python服务器的响应。这正是奇迹发生的地方，因为Python服务器会分析数据，并根据VWAP（成交量加权平均价格）提供一个交易信号。响应以JSON格式返回，我们使用一个辅助函数 _ExtractValueFromJSON()_ 从响应中提取相关值（VWAP和解释说明）。

如果响应成功（HTTP代码为200），我们解析出必要的信息并继续执行交易逻辑。如果响应包含有效数据，我们就可以着手生成一个新的信号。
    
    
    // Check if the request was successful
    if (responseCode == 200) {
        string response = CharArrayToString(result); // Convert the result array to a string
        Print("Server response: ", response);  // Print the server's response
    
        // Validate if the required data is present in the response
        if (StringFind(response, "\"vwap\":") == -1 || StringFind(response, "\"signal_explanation\":") == -1) {
            Print("Error: Invalid response from server. Response: ", response);
            return;
        }
    
        // Extract individual data points from the JSON response
        string vwap = ExtractValueFromJSON(response, "vwap");
        string explanation = ExtractValueFromJSON(response, "signal_explanation");
        string majorSupport = ExtractValueFromJSON(response, "major_support");
        string majorResistance = ExtractValueFromJSON(response, "major_resistance");
        string minorSupport = ExtractValueFromJSON(response, "minor_support");
        string minorResistance = ExtractValueFromJSON(response, "minor_resistance");
    
        // If valid data is received, update the signal
        if (vwap != "" && explanation != "") {
            string newSignal = "VWAP: " + vwap + "\nExplanation: " + explanation
                               + "\nMajor Support: " + majorSupport + "\nMajor Resistance: " + majorResistance
                               + "\nMinor Support: " + minorSupport + "\nMinor Resistance: " + minorResistance;
    
            // Confirm the signal and handle the response further
            if (newSignal != lastSignal) {
                signalConfirmationCount++; // Increment confirmation count
            }
    
            if (signalConfirmationCount >= confirmationInterval) {
                lastSignal = newSignal;  // Set the new signal
                signalConfirmationCount = 0;  // Reset the count
                Print("New VWAP signal: ", newSignal);
                Alert("New VWAP Signal Received:\n" + newSignal); // Alert user of the new signal
            }
        }
    } else {
        Print("Error: WebRequest failed with code ", responseCode, ". Response headers: ", resultHeaders);
    }
    

正确处理响应对于解读服务器的分析至关重要。 _ExtractValueFromJSON()_ 函数确保我们从大量的JSON响应中，只提取我们需要的数据（VWAP和信号解释说明）。如果响应无效或未找到预期的数据，处理错误并避免根据不正确的信号进行操作就显得非常重要。

_信号确认与显示交易信号_

最后一步涉及确认交易信号。在从Python服务器接收到信号后，我们不会立即据此行动。相反，我们要求在多个时间间隔内（由 confirmationInterval 配置）得到确认。这确保了信号在设定的时间段内是一致的，这有助于避免对短期市场噪音做出反应。

一旦信号得到确认，我们就更新 _lastSignal_ 变量，并通过 Alert() 将信号显示给用户。然后，EA会等待下一个有效信号才会再次触发。
    
    
    // Confirm the signal multiple times before updating
    if (newSignal != lastSignal)
    {
        signalConfirmationCount++;  // Increment the confirmation count
    }
    
    // Once the signal has been confirmed enough times
    if (signalConfirmationCount >= confirmationInterval)
    {
        // Update the last signal and reset confirmation count
        lastSignal = newSignal;
        signalConfirmationCount = 0;  // Reset the count after confirmation
    
        // Display the new signal in the log and via an alert
        Print("New VWAP signal: ", newSignal);  // Print to the log
        Alert("New VWAP Signal Received:\n" + newSignal);  // Display alert to the user
    }
    

信号确认有助于避免根据短暂或不可靠的信号进行操作。通过多次确认信号，我们提高了交易决策的准确性和可靠性。警报为交易者提供即时反馈，确保他们能了解重要的变化。

**2\. Python：**

该脚本的流程旨在预处理数据、计算VWAP和相关指标、生成信号，并将有意义的信息返回给EA以供决策。这包括确定主要和次要的支撑/阻力位，以及VWAP和信号解释说明。让我们遵循以下步骤：

_数据准备与预处理_

脚本的第一部分通过执行几个预处理步骤，确保传入的数据是干净且可供分析的。这些步骤确保所有必要的列都包含有效数据，并处理像缺失值或无效值这样的边缘情况。
    
    
    # Ensure critical columns have no missing values
    df = df.dropna(subset=['volume', 'high', 'low', 'open', 'close'])
    
    # Convert 'date' column to datetime
    df.loc[:, 'date'] = pd.to_datetime(df['date'])
    
    # Handle zero volume by replacing with NaN and dropping invalid rows
    df.loc[:, 'volume'] = df['volume'].replace(0, np.nan)
    df = df.dropna(subset=['volume'])
    
    # Check if data exists after filtering
    if df.empty:
        print("No data to calculate VWAP.")
        return pd.DataFrame()
    

脚本使用 _dropna()_ 确保基本列（volume, high, low, open, close）不包含缺失值。它还通过将零成交量替换为 _NaN_ 并删除任何成交量无效的行来处理零成交量问题。日期列被转换为日期时间格式，以便进行时间序列分析。

_VWAP计算与附加指标_

脚本计算VWAP（成交量加权平均价格）以及其他指标，如典型价格、平均价格、平均成交量和支撑/阻力位。
    
    
    # Calculate VWAP and additional metrics
    df.loc[:, 'typical_price'] = (df['high'] + df['low'] + df['close']) / 3
    df.loc[:, 'vwap'] = (df['typical_price'] * df['volume']).cumsum() / df['volume'].cumsum()
    df.loc[:, 'avg_price'] = df[['high', 'low', 'open', 'close']].mean(axis=1)
    df.loc[:, 'avg_volume'] = df['volume'].rolling(window=2, min_periods=1).mean()
    df.loc[:, 'major_support'] = df['low'].min()
    df.loc[:, 'major_resistance'] = df['high'].max()
    df.loc[:, 'minor_support'] = df['low'].rolling(window=3, min_periods=1).mean()
    df.loc[:, 'minor_resistance'] = df['high'].rolling(window=3, min_periods=1).mean()
    

  * VWAP计算：VWAP的计算方式为，以成交量加权的典型价格的累计总和，再除以累计成交量。 
  * 典型价格：典型价格是每个周期内最高价、最低价和收盘价的平均值。



_支撑与阻力_

  * 主要支撑：整个周期内最低价中的最低值。
  * 主要阻力：整个周期内最高价中的最高值。
  * 次要支撑/阻力：以3个周期为窗口，对最低价和最高价计算的滚动平均值。



_信号生成与分析_

这部分计算市场趋势，并根据收盘价相对于VWAP的位置生成交易信号。它还提供了这些信号的说明。
    
    
    # Calculate strength and generate signals
    df.loc[:, 'strength'] = np.where(
        (df['high'] - df['low']) != 0,
        np.abs(df['close'] - df['open']) / (df['high'] - df['low']) * 100,
        0
    )
    
    # Generate Buy/Sell signals based on VWAP
    df.loc[:, 'signal'] = np.where(
        df['close'] > df['vwap'], 'BUY',
        np.where(df['close'] < df['vwap'], 'SELL', 'NEUTRAL')
    )
    
    # Signal explanation
    df.loc[:, 'signal_explanation'] = np.where(
        df['signal'] == 'BUY',
        'The price is trading above the VWAP, indicating bullish market tendencies.',
        np.where(
            df['signal'] == 'SELL',
            'The price is trading below the VWAP, indicating bearish market tendencies.',
            'The price is trading at the VWAP, indicating equilibrium in the market.'
        )
    )
    

_强度计算：_ 此处使用收盘价与开盘价的差值相对于最高价与最低价区间的比率来计算市场强度。数值越高，表明走势越强。

_信号生成_

  * 买入：当收盘价高于VWAP时。
  * 卖出：当收盘价低于VWAP时。
  * 中性：当收盘价等于VWAP时。
  * 信号说明：根据信号，生成一段文本说明，用以指示市场趋势（看涨、看跌或中性）。



_最终响应与输出_

所有计算完成后，脚本会准备最终的输出，其中包含VWAP、交易信号、说明以及关键的支撑/阻力位。
    
    
    # Return data with major and minor support/resistance levels included
    return df[['date', 'vwap', 'signal', 'signal_explanation', 'entry_point', 'major_support', 'major_resistance', 'minor_support', 'minor_resistance']].iloc[-1]
    

  * 最终输出：脚本返回最近（最后一行）的数据，包括VWAP、交易信号、其说明、入场点（设置为VWAP值）以及主要和次要的支撑/阻力位。计算支撑/阻力位是为了帮助进一步识别市场趋势。发送回EA的响应包含了这些值，使其能够据此进行可视化或采取行动。



  


### 结果

我将从两端提供响应：MQL5端和Python端。在此之前，让我先强调一下确保Python脚本先运行的重要性。要了解更多关于创建和运行Python脚本的信息，请务必查看我之前的[文章](/zh/articles/16967)。为确保MetaTrader 5与服务器之间的顺畅通信，请将 _HTTP_ 地址添加到您的MetaTrader 5设置中。导航至 _工具_ >_选项_ ，启用“允许 _WebRequest”_ ，并在提供的字段中输入服务器地址。请参考下面的GIF图进行操作。

![Webrequest](https://c.mql5.com/2/114/Setting_Webrequest_adress.gif)  
  
图例 3. Webrequest 设置  


让我们来看看来自Python和MQL5的响应。

  * _命令提示符中的Python日志_


    
    
    Received data: date,high,low,open,close,volume
    2025.01.22 15:00,8372.10000,8365.60000,8368.90000,8367.80000,3600
    2025.01.22 16:00,8369.00000,8356.60000,8367.90000,8356.80000,3600
    2025.01.22 17:00,8359.00000,8347.800...
    Calculating VWAP...
    127.0.0.1 - - [28/Jan/2025 22:07:59] "POST /vwap HTTP/1.1" 200 -

MQL5 EA成功发送了最近150根K线的数据，包括日期、最高价、最低价、开盘价、收盘价和成交量。Python成功接收到了数据，如上面的命令提示符日志所示。虽然由于数据量较大，并非所有信息都被显示出来，但我们仍然可以观察到几根K线的数值。

  * _MetaTrader 5 专家顾问日志_


    
    
    2025.01.28 22:07:59.452 VWAP (Step Index,H1)    VWAP Expert initialized.
    2025.01.28 22:07:59.513 VWAP (Step Index,H1)    CSV file created: MQL5\Files\Step Index_vwap_data.csv
    2025.01.28 22:07:59.777 VWAP (Step Index,H1)    Server response: {
    2025.01.28 22:07:59.777 VWAP (Step Index,H1)      "entry_point": 8356.202504986322,
    2025.01.28 22:07:59.777 VWAP (Step Index,H1)      "major_resistance": 8404.5,
    2025.01.28 22:07:59.777 VWAP (Step Index,H1)      "major_support": 8305.0,
    2025.01.28 22:07:59.777 VWAP (Step Index,H1)      "minor_resistance": 8348.0,
    2025.01.28 22:07:59.777 VWAP (Step Index,H1)      "minor_support": 8341.699999999999,
    2025.01.28 22:07:59.777 VWAP (Step Index,H1)      "signal": "SELL",
    2025.01.28 22:07:59.777 VWAP (Step Index,H1)      "signal_explanation": "The price is trading below the VWAP, indicating bearish market tendencies.",
    2025.01.28 22:07:59.777 VWAP (Step Index,H1)      "vwap": 8356.202504986322
    2025.01.28 22:07:59.777 VWAP (Step Index,H1)    }
    

MQL5 EA成功接收了来自Python的响应，并将其记录在MetaTrader 5的“专家”日志中。让我们回顾一下分析响应，看看它与MetaTrader 5图表的匹配情况。

![系统结果](https://c.mql5.com/2/114/TESTRESULT.png)

图例 4. 信号显示

让我们回顾一下信号触发后市场的反应，如下图所示。

![市场反应](https://c.mql5.com/2/114/RESULTS.png)

图 5. 市场反应

  


### 结论

成功配置VWAP系统后，监控市场方向并使用VWAP水平进行确认至关重要。VWAP水平位受到市场的高度重视，通常充当关键的支撑或阻力区域。此外，选择适合您交易策略的正确时间周期也至关重要。像M1-M15这样的较短时间周期用于捕捉日内波动，M30在精确性和更广阔的视角之间取得了平衡，H1-H4揭示了多日趋势，而日线/周线图则提供了对长期市场动态的洞察。根据适当的时间周期调整您的方法，能确保其更好地与您的交易目标保持一致。

日期 | 工具名称  | 说明 | 版本  | 更新  | 提示  
---|---|---|---|---|---  
01/10/24 | [图表投影仪（Chart Projector）](/zh/articles/16014) | 用于叠加前一天价格走势（带“幽灵”效果）的脚本。 | 1.0 | 首次发布 | Lynnchris工具箱中的第一款工具  
18/11/24 | [分析评论（Analytical Comment）](/zh/articles/15927) | 它以表格形式提供前一日的市场信息，并预测市场的未来走向。 | 1.0 | 首次发布 | Lynnchris工具箱中的第二款工具  
27/11/24 | [分析大师（Analytics Master）](/zh/articles/16434) | 市场指标每两小时定期更新  | 1.01 | 第二版 | Lynnchris工具箱中的第三款工具  
02/12/24 | [分析预测器](/zh/articles/16559) | 每两小时定期更新市场指标，并集成Telegram推送功能。 | 1.1 | 第三版 | 工具4  
09/12/24 | [波动性导航工具](/zh/articles/16560) | 该EA（智能交易系统）使用布林带、RSI和ATR指标分析市场状况。 | 1.0 | 首次发布 | 工具5  
19/12/24 | [均值回归信号收割器 ](/zh/articles/16700) | 使用均值回归策略分析市场并提供信号  | 1.0  | 首次发布  | 工具6   
9/01/2025  | [信号脉冲 ](/zh/articles/16861) | 多时间框架分析器 | 1.0  | 首次发布  | 工具7   
17/01/2025  | [指标看板](/zh/articles/16584) | 带按钮的分析面板  | 1.0  | 首次发布 | 工具8   
21/01/2025 | [外部资金流](/zh/articles/16967) | 通过外部库进行分析 | 1.0  | 首次发布 | 工具9   
27/01/2025 | VWAP | 成交量加权平均价格  | 1.3  | 首次发布  | 工具10   
  
本文由MetaQuotes Ltd译自英文  
原文地址： [https://www.mql5.com/en/articles/16984](/en/articles/16984)

**附加的文件** | 

[ __下载ZIP](/zh/articles/download/16984.zip "下载单独ZIP中的所有附件")

[__VWAP.py](/zh/articles/download/16984/vwap.py "下载 VWAP.py") (3.89 KB)

[__VWAP.mq5](/zh/articles/download/16984/vwap.mq5 "下载 VWAP.mq5") (6.99 KB)

**注意:** MetaQuotes Ltd.将保留所有关于这些材料的权利。全部或部分复制或者转载这些材料将被禁止。

本文由网站的一位用户撰写，反映了他们的个人观点。MetaQuotes Ltd 不对所提供信息的准确性负责，也不对因使用所述解决方案、策略或建议而产生的任何后果负责。

![Christian Benjamin](https://c.mql5.com/avatar/2025/10/68fd3661-daee_big.png)

[Christian Benjamin](/zh/users/lynnchris "Christian Benjamin")

  * __Developer, Trader and Pastor 在 Out For Christ Ministries International
  * __[津巴布韦](https://www.mql5.com/go?https://maps.google.com/?z=4&q=%e6%b4%a5%e5%b7%b4%e5%b8%83%e9%9f%a6 "实时")
  * __[19977](/zh/users/lynnchris/achievements "等级")



* [](https://www.facebook.com/christian benjamin)

Excellence and integrity define my approach to every project. The same standard is maintained regardless of compensation structure, guided by the conviction that God’s reward surpasses what man can offer. This principle shapes every tool I develop.

#### 该作者的其他文章

  * [价格行为分析工具包开发（第 35 部分）：预测模型训练与部署](/zh/articles/18985)
  * [价格行为分析工具包开发（第三十三部分）：K线区间理论工具](/zh/articles/18911)
  * [价格行为分析工具包开发（第 32 部分）：基于 Python 的 K 线识别引擎（二）—— 使用 TA-Lib 进行检测](/zh/articles/18824)
  * [价格行为分析工具开发（第 31 部分）：基于Python的K线识别引擎（一）—— 手动检测](/zh/articles/18789)
  * [价格行为分析工具包开发（第三十部分）：商品通道指数（CCI）零线的EA](/zh/articles/18551)
  * [价格行为分析工具包开发（第二十九部分）：暴涨与暴跌拦截EA](/zh/articles/18616)
  * [价格行为分析工具开发（第二十八部分）：开盘区间突破工具](/zh/articles/18486)



**最近评论 |[前往讨论](/zh/forum/498045) ** (4) 

![Isuru Weerasinghe](https://c.mql5.com/avatar/2024/7/6691788C-22E6.png)

**[Isuru Weerasinghe](/zh/users/isuruwe)** | 31 1月 2025 在 10:45

您显示该代码在[回溯测试](https://www.mql5.com/zh/articles/2612 "文章：在真实点差上测试交易策略 ") 中正常工作，但我得到了这样的错误 HTTP Code：-错误：4014 .根据文档，它是"函数不允许调用"。 

  


![Christian Benjamin](https://c.mql5.com/avatar/2025/10/68fd3661-daee.png)

**[Christian Benjamin](/zh/users/lynnchris)** | 31 1月 2025 在 10:51

**Isuru Weerasinghe 回溯测试 中正常工作，但我得到了这样的错误 HTTP Code：-错误：4014 .根据文档，它是 "函数不允许调用"。 

  


**

对不起。您需要在 Python 脚本中导入 Backtrader、BT 或 VectorBT 等反向测试库。没有这些库，就无法进行回溯测试。 

![Too Chee Ng](https://c.mql5.com/avatar/2025/6/68446669-e598.png)

**[Too Chee Ng](/zh/users/68360626)** | 30 5月 2025 在 15:19

感谢您的文章。  
我们能否在 MetaTrader 上使用云代理对 _"_ 启用 _WebRequest_ 的 EA "进行[回溯测试](https://www.mql5.com/zh/articles/2612 "文章：在真实点差上测试交易策略 ")（优化）？ 

![Too Chee Ng](https://c.mql5.com/avatar/2025/6/68446669-e598.png)

**[Too Chee Ng](/zh/users/68360626)** | 30 5月 2025 在 15:45

**Too Chee Ng 回溯测试（优化）？**

根据我的发现：

**\- 不** 允许在**云代理** （远程 MQL5.com 网络）上使用 WebRequest()

\- 与 MetaTrader 云代理（阻止外部通信）不同，**局域网代理是** 允许的  


![创建MQL5交易管理员面板（第九部分）：代码组织（1）](https://c.mql5.com/2/117/Creating_a_Trading_Administrator_Panel_in_MQL5_Part_IX___LOGO.png) [创建MQL5交易管理员面板（第九部分）：代码组织（1）](/zh/articles/16539)

这次将深入探讨处理大型代码库时遇到的挑战。我们将探索在MQL5中进行代码组织的最佳实践，并采用一种实用方法来提升我们交易管理面板源代码的可读性和可扩展性。此外，我们致力于开发可复用的代码组件，这些组件有可能为其他开发者在其算法开发过程中带来益处。请继续阅读并参与讨论。

![基于Python与MQL5的特征工程（第三部分）：价格角度（2）——极坐标（Polar Coordinates）法](https://c.mql5.com/2/117/Feature_Engineering_With_Python_And_MQL5_Part_III_Angle_Of_Price_2__LOGO.png) [基于Python与MQL5的特征工程（第三部分）：价格角度（2）——极坐标（Polar Coordinates）法](/zh/articles/17085)

在本文中，我们将第二次尝试将任意市场的价格水平变化转化为对应的角度变化。此次，我们选择了比首次尝试更具数学复杂性的方法，而获得的结果表明，这一调整或许是正确的决策。今天，让我们共同探讨如何通过极坐标以有意义的方式计算价格水平变化所形成的角度，无论您分析的是何种市场。

![精通日志记录（第五部分）：通过缓存和轮转优化处理程序](https://c.mql5.com/2/116/logify60x60.png) [精通日志记录（第五部分）：通过缓存和轮转优化处理程序](/zh/articles/17137)

本文通过为处理器添加格式化器、引入用于管理执行周期的 CIntervalWatcher 类、以及采用缓存和文件轮转进行优化，并辅以性能测试和实际示例，从而改进了该日志库。通过这些改进，我们确保了一个高效、可扩展且能适应不同开发场景的日志系统。

![开发回放系统（第 78 部分）：新 Chart Trade（五）](https://c.mql5.com/2/105/Desenvolvendo_um_sistema_de_Replay_Parte_77___LOGO.png) [开发回放系统（第 78 部分）：新 Chart Trade（五）](/zh/articles/12492)

在本文中，我们将研究如何实现部分接收方代码。在这里我们将实现一个 EA 交易来测试和了解协议交互是如何工作的。此处提供的内容仅用于教育目的。在任何情况下，除了学习和掌握所提出的概念外，都不应出于任何目的使用此应用程序。

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


