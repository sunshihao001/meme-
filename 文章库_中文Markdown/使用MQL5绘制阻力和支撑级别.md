# 使用MQL5绘制阻力和支撑级别

> 本地文档目标名：使用MQL5绘制阻力和支撑级别
> 来源标题：使用 MQL5 绘制阻力和支撑级别 - MQL5文章
> 来源链接：https://www.mql5.com/zh/articles/1742
> 下载时间：2026-06-12 23:16:31
> 类型：MQL5中文文章库

---

[ __](javascript:void\(false\);) [English](/en/articles/1742) [Русский](/ru/articles/1742) [Español](/es/articles/1742) [Deutsch](/de/articles/1742) [日本語](/ja/articles/1742) [Português](/pt/articles/1742)

__

[ __](/zh/articles/1742?print= "打印优化版本")

![使用 MQL5 绘制阻力和支撑级别](https://c.mql5.com/i/articles/overlay.png)

# 使用 MQL5 绘制阻力和支撑级别

[MetaTrader 5](/zh/articles/mt5) — [示例](/zh/articles/mt5/examples) | 7 十二月 2015, 08:09

![](https://c.mql5.com/i/icons.svg#views-usage) 5 921  [ ![](https://c.mql5.com/i/icons.svg#comments-usage) 19 ](/zh/forum/68335 "评论")

![Aleksandr Teleguz](https://c.mql5.com/avatar/2019/12/5DEA0709-BB9F.jpg)

[Aleksandr Teleguz](/zh/users/shion.bd)

### 目录

  1. [介绍](/zh/articles/1742#vv)
  2. [本文写作目的](/zh/articles/1742#cel)
  3. [早期表述的绘制支撑和阻力的方法摘要](/zh/articles/1742#drsp)
  4. [查找极值原理](/zh/articles/1742#kakn)
  5. [采用最低索引来查找极值的函数 (第一根柱线) Ext_1](/zh/articles/1742#ext1)
  6. [查找所有后续极值的一般函数 Ext_2](/zh/articles/1742#ext2)
  7. [处理结果](/zh/articles/1742#obrr)
  8. [显示支撑和阻力级别的例程](/zh/articles/1742#prim)
  9. [结论](/zh/articles/1742#zak)

  


### 介绍

首先, 我将简要地告诉您支撑和阻力线是什么样的, 它们是如何建立的, 以及如何使用它们来进行交易。

所有趋势图示, 线条和模型均由支撑和阻力线组合, 其背后是经典的趋势分析。阻力线基于最大价格, 在此处交易者 ("牛势") 停止高位买入货币并开始平多仓。金融工具的价格以回滚对此作出响应, 直到在 "熊势" 中发生类似情况, 即支撑线是基于最低价格。

因此, 可以假定, 当货币超买时形成最大点, 以及最小点 - 当它被超卖时。这就是为什么我使用来自 MetaTrader 的标准指标 - 相对强度指数 (RSI) 来绘制支撑和阻力线的原因, 它是由 John Wilder 于 1978 开发并发表的。这个指标可以判断货币的超买和超卖区域。

我使用周期为 8 的 RSI 指标; 这个数值不是我的观察结果 - 这个 RSI 参数是 Eric L. Nyman 在其著作 "The Small Trader's Encyclopedia - 小型交易者的百科全书" 里推荐的, 可用于除了日线及更高级别的所有图表周期。我对 RSI (8) 指标的操作结果极其满意。

有两种对立的意见, 查找最大和最小价格时, 是否应该考虑蜡烛芯 (最高价/最低价)。我个人认为在查找极值点时, 应该考虑它们并比较最高和价最低价。如果您不打算考虑它们, 您可以简单地微调以下的指标代码。

利用支撑和阻力线进行交易, 可以在这些线之外发生, 而价格在这些线形成的通道之间波动时也可。 

![当突破支撑和阻力级别时进行交易](https://c.mql5.com/2/19/support_resistance__1.PNG)  


图示.1. 买入信号

我考虑到第二种方法效率较低, 尤其在制定交易策略时价格从某根线回滚扮演了基本角色。图示 1 示意这种情况, 当价格从阻力线回滚之后, 并未触及支撑线, 翻转并突破阻力线。这会导致一个强买入信号。通过分析这些线与时间轴形成的夹角, 我们定义一般趋势方向, 并且当金融工具的价格穿越这些线时, 可以判断现存趋势增强或反转的结论。通常, 在穿越支撑线之前, 例如, 价格仅到达阻力线的中间 (这个因素增强了交易信号)。

有一个名为 "Autochartist" 的平台设计用来识别趋势图和模型。作为一个实验, 两个月来我在一个演示账户里使用价格自阻力或支撑级别回滚作为信号进行交易 - 许多交易在这些情况中以亏损平仓, 而不像使用级别突破作为信号进行交易。

支持和阻力级别也用于判断趋势加速或减速。在牛势里趋势线角度增加意味着加速, 它的出现将引领趋势延续。在熊势里角度增加, 与之相反, 表明趋势放缓。在牛势里一条支撑线 (基于最低价绘制) 按惯例作为趋势线, 在熊势里一条阻力线 (基于最高价绘制) 按惯例作为趋势线。

![牛势放缓](https://c.mql5.com/2/19/RS2.PNG)  


图示.2. 牛势放缓

![熊势放缓](https://c.mql5.com/2/19/RS1.png)  


图示.3. 熊势放缓

趋势放缓暗示着其在最近的将来可能逆转。

  


### 本文写作目的

分析支撑和阻力线形成的图表是最古老的技术分析方法之一。从我自己的外汇交易市场的经验, 我可以说, 上述方法不仅古老, 但依然有效。我相信有许多交易者会用到它。利用 MetaTrader 5 终端手工构建支撑和阻力线对于掌握理论知识的交易者来讲十分容易。但若是建立一个可以自动绘制这些线的程序, 则情况并非如此。

在本文中, 我打算提出我自己的可同时兼容 MQL5 与 MQL4 的绘图支撑和阻力线的实现方法。希望您能发现这个信息非常有用。

  


### 早期表述的绘制支撑和阻力的方法摘要

许多时候, 货币对的报价范围处于阻力和支撑线之内 — 这背后的事实就是 [Gleb Slobodov 的文章](/zh/articles/1439 "绘制支撑和阻力级别的方法之一") 如何绘制这些线。作为结果, 我们有两条水平级别定义了价格波动的范围。突破其中之一, 也许, 给我们一个买或卖的信号。不过, 所提出的理论还有若干缺点:

  * 分析柱线的数量需要手工选择, 而这个参数设置了一个价格范围, 据此得到阻力和支撑级别。
  * 绘制级别的过程并未完全自动化, 因此消除了创建一个自动交易系统的可能性。
  * 使用这种方法, 我们得到的水平级别不能让我们分析趋势的方向和强度。



在 Igor Gerasko 的[交易策略](/ru/code/9258 "支撑和阻力 - 用于 MetaTrader 4 的 EA") 里使用的支撑和阻力级别指标也定义了水平级别。

在本文中, 我要介绍给您绘制支撑和阻力线的原理, 可以确定趋势方向, 形成趋势模型和图示。线的绘制基于最小和最大极值点。

  


### 查找极值原理 

在给定的时间段内确定最高和最低的价格不存在任何困难。重要的是正确选择分析图表的长度 (时间间隔), 它是持续变化的, 因此不能由手动设置。为了查找货币图表上的这块区域, 我将使用相对强弱指数 (RSI) 指标, 它包含在 MetaTrader 5 终端的一套标准指标里。

超买和超卖级别是根据 RSI 指标的级别来确定。在这些时刻, 我们的货币对在图表上偏离了其方向 (趋势), 导致价格回滚。我们的极值将在这些特别之处形成, 我们将在这些地方搜索最小和最大价格。

超卖级别, 我将采用 RSI 指标值等于 35; 超买级别 - 65 (两个级别位于中值 RSI = 50 上下两边相等的位置)。RSI 指标的周期等于 8。 

应当注意的是, 通常在一波强趋势期间, 例如, 趋势增加, RSI 反复穿越上边界, 但不曾触及底部。这会导致级别调整的需要, 但其与趋势方向不对应。

![搜索极值点](https://c.mql5.com/2/19/o_jsmtvd_2_1.PNG)  


图示.4. 搜索极值柱线的区域  


在上图中, 我已指定了极值柱线的搜索区: 第一, 第二, 第三和第四, 分别对应数字 1, 2, 3 和 4。在穿越底边界之前 (RSI = 35), RSI 指标从当前柱线开始, 处于超卖区 (RSI >= 65) 三次, 所以搜索第一个极值的时间间隔将是三倍。进一步, 搜索区的顺序由三根连续柱线确定。

在区域 1 和 3, 我将查找最高价的柱线, 而在区域 2 和 4 查找最低价。作为结果, 我们将得到 4 个极值点 — 据此组合绘制射线, 我们将得到上升价格通道。

![图示.5. 上升通道](https://c.mql5.com/2/19/Fig5.png)  


图示.5. 上升通道  


如果您曾关注过, 您可能已经注意到了, 此处只有几根柱线可搜索最低价格, 只有 4 根 (每个区域 2 根)。由于上升趋势占优, RSI 指标很少触及最小级别, 指标处于 RSI = 65 级别之外的时间几乎与处于通道 35 < RSI < 65 之内的时间相同。因此, 我在本文中发表的用来查找第二和第四点的指标代码, 使用的 RSI 级别将会向中间偏移 (向 50 靠拢)。取决于第一个极值的类型 (最小或最大), 将设置 RSI 的高位或低位级别。

所有货币对, 所有图表周期的 RSI 级别值以及其中之一的连续偏离, 均要被选择试验。我想这是我的极值判定系统的一个缺陷。

  


### 采用最低索引来查找极值的函数 (第一根柱线) Ext_1

查找极值柱线的函数, 我称之为 "Ext_1", 有以下输入参数:
    
    
    int Ext_1(double low,      //低位 RSI 级别, 超卖级别
              double high,     //高位 RSI 级别, 超买级别
              int bars,        //分析的柱线数量, 避免拷贝不必要的数据
                               //可能的设置 bars = 300
              int h_rsi,       // RSI 指标的句柄
              string symbol,   //图表品种
              float distans,   //距指标级别之一的偏离距离
                               //允许定义搜索第一个极值柱线边界
              ENUM_TIMEFRAMES period_trade) //图表周期

开始的两个函数的输入参数是 RSI 指标的参数。它们在只表现的计算中未扮演任何角色, 且仅便于目测评估值 (指标线的数值相对于给定数值)。我使用这些级别来确定的价格范围, 我将在其中搜索最小值和最大值。参数 "low" 和 "high" ​​在全局层次获取设置在指标代码中的外部变量数值:
    
    
    input double Low_RSI = 35.0; // 查找极值的低位 RSI 级别
    input double High_RSI= 65.0; // 查找极值的高位 RSI 级别
    

输入参数 "bars" 设置将要被拷贝到数组的包含最低和最高价的柱线元素数量, 如同 RSI 指标数值:
    
    
    double m_rsi[],m_high[],m_low[];                              //数组初始化
    int h_high = CopyHigh(symbol, period_trade, 0, bars, m_high); //以蜡烛的最高价填充数组
    int h_low = CopyLow(symbol, period_trade, 0, bars, m_low);    //以蜡烛的最低价填充数组
    if(CopyBuffer(h_rsi, 0, 0, bars, m_rsi)<bars)                 //以 RSI 数据填充数组
    {
       Print("拷贝指标缓存区失败!");
    }
    

数组 m_rsi[],m_high[] 和 m_low[] 具有逆向索引顺序:
    
    
    ArraySetAsSeries(m_rsi,true); 
    ArraySetAsSeries(m_high,true); 
    ArraySetAsSeries(m_low,true);
    

正如我之前所言, 预测牛势, RSI 指标的取值范围从 0 到 100, 大部分时间的数值应 > 50。在最小点形成的时刻, RSI 数值应远低于中心 (50), 超过最大点形成的期间。所以, 在指标的第一个交汇点 (最低或最高), 其它数值将向中间靠近。偏离的幅度由输入参数 "distans" 确定, 其值由外部变量给定:
    
    
    input float Distans=13.0;    // RSI 级别的偏离

函数 "Ext_1" 的输入参数 "h_rsi" 得到 iRSI() 函数初始化期间获取的 RSI 句柄值:
    
    
    h_RSI=iRSI(Trade_Symbol,Period_Trade,Period_RSI,PRICE_CLOSE);  //返回 RSI 指标的句柄

变量 Trade_Symbol 和 Period_Trade 将在全局层面被初始化, 并包含有关货币对和相应图表周期的信息。变量 Period_RSI 包含在我的指标外部参数里指定的 RSI 指标周期值:
    
    
    input uchar Period_RSI =8;   // RSI 周期

一旦我们创建并填充了包含最高价和最低价的数组之后, 同样还有与柱线相对应的 RSI 指标数值, 您可以真正的搜索第一个极值过程。为了确定何处是第一个极值 (支撑或阻力线) 并且在合适的时刻停止分析柱线, 需要两个布尔类型的变量:
    
    
    bool ext_max = true;    //布尔型变量用于停止
    bool ext_min = true;    //在正确的时间分析柱线
    

分别地, 数值 ext_max = true 授权搜索最大极值, 数值 ext_min = true, 授权搜索最小极值。在级别之一的第一个 RSI 指标交汇点 (最低或最高), 布尔变量之一的数值被更改为 false, 且 RSI 级别的交汇之处柱线分析被禁止, 意即所需柱线数量已经分析, 第一个极值已经找到。 

如果, 在分析第一根柱西安时, RSI 指标的数值超出了它的级别, 这好像是极值形成的价格范围已经找到, 这并不完整, 此处没有可分析的点。这种柱线分析应排除在外。在下图中我已经把无需分析的价格范围突出显示 (注意 RSI 指标相对于上位级别的位置):

![在不完整的价格范围禁止分析](https://c.mql5.com/2/19/RS2__3.PNG)  


图示.6. 在不完整的价格范围禁止分析  


为了实现这种操作, 需要创建另一个布尔变量:
    
    
    bool flag=false;

为了确定所分析柱线之间的最大和最小价格, 需要创建以下额外的双精度类型变量:
    
    
    double min = 100000.0;  //用于识别最大和最小价格的变量
    double max = 0.0;       //...
    

柱线搜索第一个极值的完整循环如下:
    
    
    for(int i=0;i<bars;i++) //柱线循环
    {
       double rsi = m_rsi[i];                                   //获取 RSI 指标值
       double price_max = NormalizeDouble(m_high[i], digits);   //最高价 prices
       double price_min = NormalizeDouble(m_low[i], digits);    //选择柱线的最低价
       if(flag==false) //避免在不完整趋势里搜索极值的条件
       {
          if(rsi<=low||rsi>=high) //如果第一根柱线在超卖或超卖区域,
             continue;            //则移至下一根柱线
          else flag = true;       //如果不是, 分析处理  
       }
       if(rsi<low) //如果发现 RSI 于级别交叉
       {
          if(ext_min==true) //如果 RSI 未与高位级别交叉
          {
            if(ext_max==true) //如果搜索最大极值被禁
            {
               ext_max=false;     //则禁止搜索最大极值
               if(distans>=0) high=high-distans; //改变高位级别, 之后
            }                                    //将执行第二根柱线的搜索
            if(price_min<min) //搜索和记忆第一根柱线索引
            {                 //比较最低蜡烛价格
               min=price_min;
               index_bar=i;
            }
          }
          else break; /*由于搜索最小极值已被禁止, 退出循环,
                        这意味着最大值已经找到*/
       }
       if(rsi>high) //进一步, 算法相同, 仅搜索最大极值
       {
          if(ext_max==true)
          {
            if(ext_min==true)
            {
               ext_min=false;
               if(distans>=0) low=low+distans;
            }
            if(price_max>max)
            {
               max=price_max;
               index_bar=i;
            }
          }
          else break; /*由于搜索最大极值已被禁止, 退出循环,
                        这意味着最小值已经找到*/
       }
    }
    

  


### 查找所有后续极值的一般函数 Ext_2

这个函数将接收与 Ext_1 函数相同的输入参数, 加上另外三个重要参数:

  1. 参数包含一个结构的引用, 代表哪一根柱线的索引将被保存。它需要确定从哪一根柱线开始搜索极值。
  2. 极值柱线的序列号码已经被找到 (取值范围从 2 到 4)。它需要从结构里选择期望的柱线索引, 也要确定, 哪根线 (支撑或阻力) 的期望极值将被定位。
  3. 布尔类型参数确定那跟线 (支撑或阻力) 的第一个极值柱线被定位。如果没有这个信息, 不可能基于该序列号码来确定哪一根线的期望柱线应被定位。


    
    
    int Ext_2(double low,    //低位 RSI 级别, 超卖级别
              double high,   //高位 RSI 级别, 超买级别
              int bars,      //分析的柱线数量, 避免拷贝不必要的数据到数组
              int h_rsi,     //RSI 指标的句柄
              string symbol, //表品种
              st_Bars &bars_ext,//包含已发现柱线号码的结构
              char n_bar,    //所需查找的柱线序数号码 (2,3 或 4)
              float distans, //距指标级别之一的偏离距离
              bool first_ext,//第一根柱线类型
              ENUM_TIMEFRAMES period_trade)//图表周期
    

在全局层面, 我们创建一个包含所有 4 个极值柱西线索引的结构类型:
    
    
    struct st_Bars //结构初始化
      {
       int               Bar_1;
       int               Bar_2;
       int               Bar_3;
       int               Bar_4;
      };
    
    st_Bars Bars_Ext; //声明结构类型变量
    

为了确定指标线的期望极值位于何处, 第一, 第二个布尔类型变量必须要被创建:
    
    
    bool high_level= false; //确定期望柱线类型的变量
    bool low_level = false; //...
    

如果期望的极值柱线序数号码等于 2 或 4, 且首根极值柱线落于支撑线上, 则期望的柱线必须落于阻力线上, 所以, 需要分析柱线, 它的 RSI 值高于或等于上位级别 (high 参数)。如果期望的极值柱线的序数号码等于 3, 且第一根极值柱线位于支撑线上, 则期望柱线也将位于这条线上。如果第一根极值柱线位于阻力线上, 那么期望柱线的位置也将被相应选择。
    
    
    if(n_bar!=3)
    {
       if(first_ext==true)//如果第一点是最大值
       {
          low_level=true;//则这应是最小值
          if(distans>=0) low=low+distans; //若有必要, 取代 RSI 的低位级别
       }
       else //如果最小值
       {
          high_level = true;
          if(distans>=0) high=high-distans; //若有必要, 取代 RSI 的高位级别
       }
    }
    else
    {
       if(first_ext==false)//如果第一点是最小值
       {
          low_level=true;//则这应是最小值
          if(distans>=0) high=high-distans; //若有必要, 取代 RSI 的高位级别
       }
       else //如果最大值
       {
          high_level = true;
          if(distans>=0) low=low+distans; //若有必要, 取代 RSI 的低位级别
       }
    }
    

另一个布尔类型的变量用于确定期望极值的发现时间和柱线分析停止的时间。
    
    
    bool _start = false;    

当我们在历史数据里找到进行分析的所需柱线范围, 这个变量的值更改为 true。柱线分析终端, 如果 _start = true, 且当 low_level = true 时, RSI 指标线穿越高位级别, 而当 high_level = true, RSI 指标线穿越低位级别。
    
    
    if(_start==true && ((low_level==true && rsi>=high) || (high_level==true && rsi<=low)))
      break; //如果发现第二个极值, 且 RSI 穿越反向级别
    

极值柱线搜索循环如下:
    
    
    for(int i=bar_1;i<bars;i++) //分析剩余柱线
    {
       rsi=m_rsi[i];
       price_max = NormalizeDouble(m_high[i], digits);
       price_min = NormalizeDouble(m_low[i], digits);
       if(_start==true && ((low_level==true && rsi>=high) || (high_level==true && rsi<=low)))
       {
          break; //如果发现第二个极值, 且 RSI 穿越反向级别
       }
       if(low_level==true) //如果搜索最小极值
       {
          if(rsi<=low)
          {
             if(_start==false) _start=true;
             if(price_min<min)
             {
                min=price_min;
                index_bar=i;
             }
          }
       }
       else //如果搜索最大极值
       {
          if(rsi>=high)
          {
             if(_start==false) _start=true;
             if(price_max>=max)
             {
                max=price_max;
                index_bar=i;
             }
          }
       }
    }
    

变量 Bar_1 包含前一根极值柱线的索引, 其计算使用 switch 操作符:
    
    
    switch(n_bar) //查找前一根柱线索引
    {
       case 2: bar_1 = bars_ext.Bar_1; break;
       case 3: bar_1 = bars_ext.Bar_2; break;
       case 4: bar_1 = bars_ext.Bar_3; break;
    }
    

为了找出第一根极值柱线位于哪条指标线上 (支撑或阻力), 得到其索引以及所获索引柱线的 RSI 指标值就足够了。
    
    
    bool One_ext (st_Bars & bars_ext, // 结构类型变量用于获取第一根柱线的索引
                 string symbol,     //图表品种
                 int h_rsi,         //指标的句柄
                 double low,        //设置 RSI 的超卖级别 (可以使用的高位级别)
                 ENUM_TIMEFRAMES period_trade) //图表周期
      {
       double m_rsi[];               //指标数据数组初始化
       ArraySetAsSeries(m_rsi,true); //索引
       CopyBuffer(h_rsi,0,0,bars_ext.Bar_1+1,m_rsi); //用 RSI 数据填充数组
       double rsi=m_rsi[bars_ext.Bar_1]; //定义第一个极值柱线的 RSI 数值
       if(rsi<=low)                      //如果数值低于低位级别,
          return(false);                 //则第一个极值是最小值
       else                              //如果不是,
       return(true);                     //则是最大值
      }
    

  


### 处理结果

现在我们已知所有四根柱先的索引及其相应的价格 (最低或最高)。为了将每根柱线匹配的指示线数值填充到数组, 需要得到对应于阻力和支撑线的两条方程式。众所周知用于此意图的线方程是: y = kx + b。在我们的情况里, "x" 是柱线索引, 而 "y" 是价格 (对于支撑线 - 蜡烛的最低价, 对于阻力线 - 蜡烛的最高价)。

为了找到 "k" 和 "b" 系数, 在线方程里用相应的值替代两个已知极值柱线值, 以及方称系里所得到的组合表达式。其结果是, 我们在系统上得到以下表达式:
    
    
    K=(price_2-price_1)/(_bar2-_bar1);  //查找系数 K
    B=price_1-K*_bar1;                  //查找系数 B
    

此处
    
    
    double K,B;

"K" 和 "B" 是全局变量, 对应于线方程里的 "k" 和 "b" 系数值;
    
    
    int _bar1,_bar2;

这些柱线索引位于相同的线上;
    
    
    double price_1,price_2;

这是各自柱线的最低价格, 如果需要定义 "K" 和 "B" 支撑线, 或各自柱线的最高价, 您需要确定阻力线的 "K" 和 "B"。

以下呈现的函数设置支撑线的 "K" 和 "B" 全局变量, 如果参数 "_line" 为 false, 且对于阻力线, 若参数 "_line" 为 true:
    
    
    void Level(bool _line,              //参数定义需要查找阻力和支撑线的哪根系数
               bool _first_ext,         //第一个极值的类型 (您已经熟悉了)
               st_Bars &bars_ext,       //包含柱线索引的结构
               string _symbol,          //品种
               ENUM_TIMEFRAMES _period) //图表周期
      {
       int bars=Bars_H;           //分析柱线的数量
       double m_high[],m_low[];         //数组初始化
       ArraySetAsSeries(m_high,true);   //数组从第一个元素开始索引
       ArraySetAsSeries(m_low,true);    //...
       int h_high = CopyHigh(_symbol, _period, 0, bars, m_high); //以蜡烛的最高价填充数组
       int h_low = CopyLow(_symbol, _period, 0, bars, m_low);    //以蜡烛的最低价填充数组
       double price_1,price_2;
       int _bar1,_bar2;
       int digits=(int)SymbolInfoInteger(_symbol,SYMBOL_DIGITS);//当前品种的小数点位数
       if(_line==true)                                          //如果所需是阻力线
         {
          if(_first_ext==true) //如果第一个极值是最大值
            {
             price_1 = NormalizeDouble(m_high[bars_ext.Bar_1], digits);
             price_2 = NormalizeDouble(m_high[bars_ext.Bar_3], digits);
             _bar1 = bars_ext.Bar_1;
             _bar2 = bars_ext.Bar_3;
            }
          else                                                  //如果是最小值
            {
             price_1 = NormalizeDouble(m_high[bars_ext.Bar_2], digits);
             price_2 = NormalizeDouble(m_high[bars_ext.Bar_4], digits);
             _bar1 = bars_ext.Bar_2;
             _bar2 = bars_ext.Bar_4;
            }
         }
       else                                                     //如果所需是支撑线
         {
          if(_first_ext==true) //如果第一个极值是最大值
            {
             price_1 = NormalizeDouble(m_low[bars_ext.Bar_2], digits);
             price_2 = NormalizeDouble(m_low[bars_ext.Bar_4], digits);
             _bar1 = bars_ext.Bar_2;
             _bar2 = bars_ext.Bar_4;
            }
          else                                                  //如果是最小值
            {
             price_1 = NormalizeDouble(m_low[bars_ext.Bar_1], digits);
             price_2 = NormalizeDouble(m_low[bars_ext.Bar_3], digits);
             _bar1 = bars_ext.Bar_1;
             _bar2 = bars_ext.Bar_3;
            }
         }
       K=(price_2-price_1)/(_bar2-_bar1);  //查找系数 K
       B=price_1-K*_bar1;                  //查找系数 B
      }
    

线方程式: y = kx + b, 此处金融工具的价格是 "y" 轴, 而柱线索引是 ​"x" 轴。如果对于 "x" 轴, 我们使用自 1970 年 1 月 1 日以来经过的秒数, 线图表上的休市区域将显示 "混乱" 的结果, 这就是我使用柱线索引的原因。

自 "OnCalculate" 函数, 函数 "Level" 被调用了两次: 第一次是在填充阻力线数组之前, 而第二次是在填充支撑线数组之时:
    
    
    for(int i=0;i<Bars_H;i++)
    {
       resistanceBuffer[i]=NormalizeDouble(K*i+B,Dig);
    }
    Level(false,First_Ext,Bars_Ext,Trade_Symbol,Period_Trade); //得到阻力线的系数 K 和 B
    for(int i=0;i<Bars_H;i++)
    {
       supportBuffer[i]=NormalizeDouble(K*i+B,Dig);
    }
    

  


### 指标显示支撑和阻力级别的例子

下图是指标使用所有上述函数的操作结果绘制的支撑和阻力线:

![指标操作结果](https://c.mql5.com/2/19/Strategii__1.png)  


图示.7. 指标操作结果  


在新的极值柱线形成之后, 指标按照这种方式构成, 支撑和阻力线的数组数值可以改变, 且级别可以自动重画。然而, 如果我们计算并记住其中一条线与图表上的时间轴夹角, 并与同一根线的新夹角进行比较, 可以判断趋势的加速和减速, 正如在本文里曾提到的那样。

指标的完整代码文件附于本文之中。

  


### 结论

当然, 很容易手工建立这些线, 因为您无需为每个品种和周期选择指标参数。不过, 这个指标可以作为一个基础, 或是作为自动交易系统中策略的一部分。在收到指标线的数据数组之后, 您可以分析倾角, 趋势方向, 以及识别由这些线所形成的图形形状。所有这一切, 最终使得它可以分析买入或卖出信号的强度, 在价格通道以内或是突破支撑和阻力线时进行交易。

本文由MetaQuotes Ltd译自俄文  
原文地址： [https://www.mql5.com/ru/articles/1742](/ru/articles/1742)

**附加的文件** | 

[ __下载ZIP](/zh/articles/download/1742.zip "下载单独ZIP中的所有附件")

[__s_rind.mq5](/zh/articles/download/1742/s_rind.mq5 "下载 s_rind.mq5") (34.78 KB)

**注意:** MetaQuotes Ltd.将保留所有关于这些材料的权利。全部或部分复制或者转载这些材料将被禁止。

本文由网站的一位用户撰写，反映了他们的个人观点。MetaQuotes Ltd 不对所提供信息的准确性负责，也不对因使用所述解决方案、策略或建议而产生的任何后果负责。

![Aleksandr Teleguz](https://c.mql5.com/avatar/2019/12/5DEA0709-BB9F_big.jpg)

[Aleksandr Teleguz](/zh/users/shion.bd "Aleksandr Teleguz")

  * __[俄罗斯](https://www.mql5.com/go?https://maps.google.com/?z=4&q=%e4%bf%84%e7%bd%97%e6%96%af "实时")
  * __[5799](/zh/users/shion.bd/achievements "等级")



* [](https://www.facebook.com/aleksandr.investmany)
* [](https://x.com/ad_investmany)

Программист python

**最近评论 |[前往讨论](/zh/forum/68335) ** (19) 

![Andrii Vashchyshyn](https://c.mql5.com/avatar/avatar_na2.png)

**[Andrii Vashchyshyn](/zh/users/andrew9301)** | 30 4月 2022 在 04:40

在哪里可以下载源代码文件？ 

![sashasonik](https://c.mql5.com/avatar/2015/6/559039BF-8FCA.jpg)

**[sashasonik](/zh/users/sashasonik)** | 30 4月 2022 在 17:05

h[ttps://](/go?link=https://zen.yandex.ru/video/watch/626d46f53a1abb7854a03850 "https://zen.yandex.ru/video/watch/626d46f53a1abb7854a03850") zen.yandex.ru/video/watch/626d46f53a1abb7854a03850 

![Aleksandr Teleguz](https://c.mql5.com/avatar/2019/12/5DEA0709-BB9F.jpg)

**[Aleksandr Teleguz](/zh/users/shion.bd)** | 1 5月 2022 在 11:41

**Andrew9301[#](/ru/forum/60775#comment_36186156):**  
在哪里可以下载源代码文件？ 

文章末尾的链接

![StohanoV](https://c.mql5.com/avatar/avatar_na2.png)

**[StohanoV](/zh/users/stohanov)** | 11 8月 2022 在 07:16

亚历山大 谢谢你，做得很好。我有一个要求和建议，用右边的射线代替直线。这样图表会更简洁，你可以清楚地看到趋势的起点。如果在 RSI 指标中添加趋势射线，效果会更好。 

![Aleksandr Teleguz](https://c.mql5.com/avatar/2019/12/5DEA0709-BB9F.jpg)

**[Aleksandr Teleguz](/zh/users/shion.bd)** | 18 10月 2022 在 07:27

**StohanoV[#](/ru/forum/60775/page2#comment_41342979):**  
亚历山大 谢谢你，做得很好。我有一个要求和建议，用右边的射线代替直线。这样图表会更简洁，你可以清楚地看到趋势的起点。如果在 RSI 指标中加入趋势射线，效果会更好。 

是的，我同意你的观点。射线在图表上不那么杂乱

![怎样开发可以获利的交易策略](https://c.mql5.com/2/14/289_2.png) [怎样开发可以获利的交易策略](/zh/articles/1447)

本文为这样的问题提供解答: "是否可以通过神经网络技术，基于历史数据来构建自动交易策略?".

![如何在莫斯科交易所安全地使用您的 EA 进行交易](https://c.mql5.com/2/18/MOEX.png) [如何在莫斯科交易所安全地使用您的 EA 进行交易](/zh/articles/1683)

本文深入研究了交易方式, 通过莫斯科交易所衍生产品市场的例子来说明如何确保在股票和低流动性市场中交易操作的安全性。它带来了一些实践方法, 其交易原理在文章 "Principles of Exchange Pricing through the Example of Moscow Exchange's Derivatives Market - 莫斯科交易所衍生产品市场为例的定价原则" 里描述。

![价格行为. 自动化内含柱交易策略](https://c.mql5.com/2/19/PA.png) [价格行为. 自动化内含柱交易策略](/zh/articles/1771)

本文描述了基于内含柱交易策略开发MetaTrader 4 EA交易, 其中包含了内含柱侦测原则, 以及挂单和止损单的设置规则. 同时也提供了测试和优化的结果.

![MQL5秘笈之：采用关联数组或字典实现快速数据访问](https://c.mql5.com/2/18/MQL5_Associative_Arrays__1.png) [MQL5秘笈之：采用关联数组或字典实现快速数据访问](/zh/articles/1334)

本文介绍一种能够通过key来访问元素的特殊算法。任何基本数据类型都可以被当作key。例如它可以是一个字符串或一个整型值。这样的数据容器通常被称为字典或这关联数组。这为解决问题提供了便捷。

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


