# RU_风险管理基础类构建

> 来源标题：Управление рисками (Часть 1): Основы построения класса по управлению рисками - Статьи по MQL5
> 来源链接：https://www.mql5.com/ru/articles/16820
> 下载时间：2026-06-13 00:18:13
> 用途：V0.1风险管理语义二次检索补全来源。

---

[ __](javascript:void\(false\);) [English](/en/articles/16820) [中文](/zh/articles/16820) [Español](/es/articles/16820) [Deutsch](/de/articles/16820) [日本語](/ja/articles/16820) [Português](/pt/articles/16820)

__

[ __](/ru/articles/16820?print= "Версия для печати")

![preview](data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAsICAoIBwsKCQoNDAsNERwSEQ8PESIZGhQcKSQrKigkJyctMkA3LTA9MCcnOEw5PUNFSElIKzZPVU5GVEBHSEX/2wBDAQwNDREPESESEiFFLicuRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUX/wAARCAAQACADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAABAUA/8QAHRAAAQQDAQEAAAAAAAAAAAAAAQACAxESITEEUf/EABYBAQEBAAAAAAAAAAAAAAAAAAIBA//EABYRAQEBAAAAAAAAAAAAAAAAAAABEf/aAAwDAQACEQMRAD8AuzSYmx36sz1AirQ5ZbvaMMi7RSxnq5DLZ6kiTXVJgdQAtKa8V1GxZX//2Q==)

![Управление рисками \(Часть 1\): Основы построения класса по управлению рисками](https://c.mql5.com/2/108/Proyecto_nuevo_f1p_600x314.jpg)

# Управление рисками (Часть 1): Основы построения класса по управлению рисками

[MetaTrader 5](/ru/articles/mt5) — [Примеры](/ru/articles/mt5/examples) | 1 августа 2025, 15:12

![](https://c.mql5.com/i/icons.svg#views-usage) 897  [ ![](https://c.mql5.com/i/icons.svg#comments-usage) 0 ](/ru/forum/492367 "Комментарии")

![Niquel Mendoza](https://c.mql5.com/avatar/2024/8/66bbab57-2d8c.png)

[Niquel Mendoza](/ru/users/nique_372)

  * [Введение](/ru/articles/16820#1)
  * [Что такое управление рисками](/ru/articles/16820#2)
  * [Важность автоматической торговли](/ru/articles/16820#3)
  * [Вводные концепции управления рисками](/ru/articles/16820#4)
  * [Cоздание включаемого файла и описание плана](/ru/articles/16820#5)
  * [Создание функций для расчета размера лота](/ru/articles/16820#6)
  * [Создание функций для получения прибыли](/ru/articles/16820#7)
  * [Проверка на практике с помощью создания простого скрипта с включаемым файлом](/ru/articles/16820#8)
  * [Заключение](/ru/articles/16820#9)



###   
  
Введение 

В этой статье мы рассмотрим, что такое управление рисками в трейдинге и его важность в автоматической торговле. Мы начнем с базовых понятий, заложив основу для понимания того, как правильное управление рисками может определять разницу между успехом и неудачей на финансовых рынках. 

Далее мы шаг за шагом создадим класс на MQL5, который реализует полное управление рисками, позволяя контролировать ключевые аспекты, такие как размер лота, максимальные убытки и ожидаемую прибыль.

  


### Что такое управление рисками 

Управление рисками является основополагающим принципом любой торговой стратегии. Его основная цель — отслеживать и контролировать открытые позиции, гарантируя, что убытки не превышают установленные трейдером лимиты, такие как дневные, еженедельные или общие.

Кроме того, управление рисками позволяет определить подходящий размер лота для каждой сделки на основе правил и предпочтений пользователя. Это не только защищает капитал, но и оптимизирует эффективность стратегии, гарантируя, что сделки соответствуют заданному профилю риска.

В целом, грамотное управление рисками не только снижает вероятность катастрофических убытков, но и обеспечивает дисциплинированный подход к принятию разумных финансовых решений.

  


### Важность для автоматической торговли 

Управление рисками играет решающую роль в автоматической торговле, поскольку оно действует как система контроля, которая предотвращает дорогостоящие ошибки, такие как чрезмерная торговля или подверженность ненужным рискам. В контексте торговых ботов, где решения принимаются полностью автоматически, надлежащее управление рисками обеспечивает дисциплинированную и эффективную реализацию стратегий.

Это особенно ценно в таких ситуациях, как отбор на финансирование, где соблюдение строгих ограничений дневных, недельных или общих убытков может стать решающим фактором для успеха или провала. Управление рисками позволяет точно устанавливать эти барьеры, защищая капитал пользователя и оптимизируя его деятельность в конкурентной среде.

Кроме того, это помогает боту действовать более стратегически, ставя четкие ограничения, чтобы избежать чрезмерной торговли или принятия несоразмерных рисков. Благодаря автоматическому расчету размеров лотов и ограничению убытков на сделку, управление рисками не только защищает капитал, но и обеспечивает трейдеру спокойствие, основанное на уверенности, что его бот работает в контролируемых и безопасных пределах.

  


### Вводные концепции управления рисками 

Прежде чем приступить к программированию, важно понять основные переменные и концепции, которые мы будем использовать в управлении рисками. Эти концепции являются фундаментальными для разработки эффективной системы, которая защищает капитал пользователя и обеспечивает контролируемую торговлю. Ниже мы рассмотрим каждую из них:

#### 1\. Максимальный дневной убыток

Это максимальный предел убытка, который бот может накопить за один день (24 часа). Если этот предел достигнут, бот, вероятней всего, закроет все открытые позиции и приостановит любую торговую активность до следующего дня. Такой подход помогает предотвратить серьезное влияние серии неудачных сделок на капитал.

#### 2\. Максимальный недельный убыток

Аналогично дневному убытку, но применяется к интервалу в одну неделю. Если бот превысит установленный предел, он прекратит торговлю до начала следующей недели. Этот параметр идеально подходит для предотвращения значительных убытков на более длительных временных интервалах.

#### 3\. Максимальный общий убыток

Это абсолютный предел убытков, по достижении которого активируется специальная стратегия восстановления. Она может включать в себя уменьшение размеров лотов и более осторожную торговлю с целью постепенного восстановления утраченного капитала. Эта концепция позволяет контролировать общий риск по счету.

#### 4\. Максимальный убыток на сделку

Определяет максимальный убыток, который может быть допущен в одной сделке. Это значение критически важно, поскольку позволяет автоматически рассчитывать идеальный размер лота для каждой сделки в соответствии с уровнем риска, который пользователь готов принять.

#### 5\. Дневная, недельная и общая прибыль

Это переменные, фиксирующие накопленную прибыль за разные периоды времени. Эти метрики полезны для оценки эффективности работы бота и корректировки стратегий на основе полученных результатов.

  


### Создание включаемого файла и описание плана 

В этом разделе мы начнем программировать включаемый файл.

**1.** В верхней части нашей платформы Metatrader находим пункт «IDE» и кликаем по нему:

![ IDE-1](https://c.mql5.com/2/110/IDE-1.png)

**2.** В левом верхнем углу MetaEditor выбираем вкладку «Файл», затем «Новый», и должно появиться примерно следующее:

![IDE-2](https://c.mql5.com/2/110/IDE-2.png)

******3.** Выбираем «Include» и нажимаем «Далее»:

![ IDE-3](https://c.mql5.com/2/110/IDE-3.png)

**4.** Настраиваем включаемый файл, указав ему имя и автора:

![IDE-4](https://c.mql5.com/2/110/IDE-4.png)

На этом создание файла завершено, но это только начало. Теперь я подробно опишу план работы системы управления рисками.

Ниже представлена схема того, как будет работать управление рисками:

![Map-1](https://c.mql5.com/2/110/Map-1.png)

Раздел   
| Описание  | Частота выполнения   
  
---|---|---  
1\. Переменные настройки расчета  | На этом начальном этапе (который выполняется только один раз) устанавливаются все переменные, необходимые для расчета убытков и прибыли.   
  
Основные задачи включают:  


  * определение магического числа для идентификации конкретных сделок советника;
  * установку начального баланса, что особенно актуально при торговле на счетах с финансированием или в проп-компаниях;
  * указание применимых процентных значений риска, и решение, будет ли убыток рассчитываться в **деньгах** или как **процент от баланса/капитала**.

Если выбран расчет по проценту, пользователь должен указать базовое значение, к которому будет применяться этот процент (например, общий баланс, эквити, общий профит или свободная маржа). | Выполняется только **один раз** или при настройке советника.   
2\.   
Расчет прибыли и убытков   
| На этом этапе рассчитывается текущее состояние прибыли и убытков на счете. Включая:  


  * вычисление общей суммы накопленных убытков;
  * регистрацию прибыли по дням, неделям или по сделкам;
  * сравнение накопленных убытков с лимитами, установленными в предыдущем разделе.

Этот процесс выполняется периодически, в соответствии с потребностями пользователя. | Выполняется **ежедневно** , **при открытии сделки** , или **еженедельно** — в зависимости от настроек.   
  
3\.   
Проверка в реальном времени  | В режиме реального времени советник выполняет постоянную проверку (на каждом тике), чтобы убедиться, что текущие убытки не превышают заданных лимитов.  
  
Если какое-либо из значений убытков превышено, советник немедленно закроет все открытые позиции, чтобы предотвратить дальнейшие потери.  | **На каждом тике** (процесс в реальном времени).   
  
С учетом всего вышеизложенного, переходим к созданию первых функций.

  


### Создание функций для расчета размера лота   


Прежде чем приступить к разработке класса, необходимо сначала создать функции, которые позволят нам рассчитать лот.

#### Расчет идеального лота

Чтобы определить идеальный лот, нам сначала нужно рассчитать общий размер лота, то есть тот максимум, который наш счет может купить или продать. Этот расчет основан на знании маржи, необходимой для торговли одним лотом в валюте счета. Получив это значение, мы делим его на свободную маржу счета, округляем результат и таким образом получаем максимальный лот, разрешенный для нашего счета.

#### Предварительные требования

Прежде чем приступить к расчетам, необходимо определить маржу, требуемую для одного лота любого символа. В этом примере в качестве символа будет использоваться золото, однако данный процесс применим к любому другому финансовому символу.

Основная цель — получить надежную основу для эффективного расчета лотов, адаптированного к балансу и марже, доступной на нашем торговом счете.

![ МАРЖА-1](https://c.mql5.com/2/110/MARGIN-1.PNG)

Как видим, приблизительная начальная маржа для покупки одного лота золота составляет 1 326 USD. Следовательно, чтобы рассчитать **максимально допустимый лот** , достаточно просто разделить свободную маржу, доступную на счете, на требуемую начальную маржу. Это соотношение можно представить следующим образом:

![МАРЖА-2](https://c.mql5.com/2/111/margin-2.png)

Свободная маржа:

  * Это доступный капитал на вашем счёте, который можно использовать для открытия новых сделок. В MetaTrader он рассчитывается следующим образом:



![МАРЖА-3](https://c.mql5.com/2/111/margin-3.png)

**Расчет цены для любого типа ордера**  
Теперь, когда мы знаем, как рассчитать **максимальный размер лота** , следующим шагом будет программная реализация этой функциональности. Однако перед тем, как приступить к этому, нам необходимо определить цену, по которой будет исполнен ордер. Для этого мы создадим функцию под названием PriceByOrderType, которая будет рассчитывать и возвращать соответствующую цену в зависимости от типа ордера.
    
    
    double PriceByOrderType(const string symbol, const ENUM_ORDER_TYPE order_type, double DEVIATION = 100, double STOP_LIMIT = 50)

Параметры:

  1. symbol — торговый символ (например, «EURUSD»), по которому будет исполнен ордер,
  2. order_type — тип ордера, основанный на перечислении ENUM_ORDER_TYPE,
  3. DEVIATION — допустимое отклонение в пунктах,
  4. STOP_LIMIT — расстояние в пунктах для ордеров типа STOP_LIMIT.



Шаг 1. Создание необходимых переменных

Сначала объявим переменные, которые будут хранить количество знаков символа, стоимость одного пункта и текущие цены (bid и ask) в структуре MqlTick.
    
    
    int     digits=0; 
    double  point=0; 
    MqlTick tick={}; 
    

Шаг 2. Присвоение значений переменным

Мы используем функции для получения информации о символе, такой как количество знаков, значение пункта и текущие цены.

Получение значения SYMBOL_POINT: 
    
    
    ResetLastError(); 
    if(!SymbolInfoDouble(symbol, SYMBOL_POINT, point)) 
      { 
       Print("SymbolInfoDouble() failed. Error ", GetLastError()); 
       return 0; 
      } 
    

Получение значения SYMBOL_DIGITS:
    
    
    long value=0; 
    if(!SymbolInfoInteger(symbol, SYMBOL_DIGITS, value)) 
      { 
       Print("SymbolInfoInteger() failed. Error ", GetLastError()); 
       return 0; 
      } 
    digits=(int)value; 
    

Получение текущих цен символа:
    
    
    if(!SymbolInfoTick(symbol, tick)) 
      { 
       Print("SymbolInfoTick() failed. Error ", GetLastError()); 
       return 0; 
      } 
    

Шаг 3. ****Расчет цены на основе типа ордера

В зависимости от типа ордера, мы возвращаем соответствующую цену, используя конструкцию switch:
    
    
    switch(order_type) 
      { 
       case ORDER_TYPE_BUY              :  return(tick.ask); 
       case ORDER_TYPE_SELL             :  return(tick.bid); 
       case ORDER_TYPE_BUY_LIMIT        :  return(NormalizeDouble(tick.ask - DEVIATION * point, digits)); 
       case ORDER_TYPE_SELL_LIMIT       :  return(NormalizeDouble(tick.bid + DEVIATION * point, digits)); 
       case ORDER_TYPE_BUY_STOP         :  return(NormalizeDouble(tick.ask + DEVIATION * point, digits)); 
       case ORDER_TYPE_SELL_STOP        :  return(NormalizeDouble(tick.bid - DEVIATION * point, digits)); 
       case ORDER_TYPE_BUY_STOP_LIMIT   :  return(NormalizeDouble(tick.ask + DEVIATION * point - STOP_LIMIT * point, digits)); 
       case ORDER_TYPE_SELL_STOP_LIMIT  :  return(NormalizeDouble(tick.bid - DEVIATION * point + STOP_LIMIT * point, digits)); 
       default                          :  return(0); 
      } 
    

Вот финальная реализация функции: 
    
    
    double PriceByOrderType(const string symbol, const ENUM_ORDER_TYPE order_type, double DEVIATION = 100, double STOP_LIMIT = 50) 
      {
       int     digits=0; 
       double  point=0; 
       MqlTick tick={}; 
    
    //--- we get the Point value of the symbol
       ResetLastError(); 
       if(!SymbolInfoDouble(symbol, SYMBOL_POINT, point)) 
         { 
          Print("SymbolInfoDouble() failed. Error ", GetLastError()); 
          return 0; 
         } 
    
    //--- we get the Digits value of the symbol
       long value=0; 
       if(!SymbolInfoInteger(symbol, SYMBOL_DIGITS, value)) 
         { 
          Print("SymbolInfoInteger() failed. Error ", GetLastError()); 
          return 0; 
         } 
       digits=(int)value; 
    
    //--- we get the latest prices of the symbol
       if(!SymbolInfoTick(symbol, tick)) 
         { 
          Print("SymbolInfoTick() failed. Error ", GetLastError()); 
          return 0; 
         } 
    
    //--- Depending on the type of order, we return the price
       switch(order_type) 
         { 
          case ORDER_TYPE_BUY              :  return(tick.ask); 
          case ORDER_TYPE_SELL             :  return(tick.bid); 
          case ORDER_TYPE_BUY_LIMIT        :  return(NormalizeDouble(tick.ask - DEVIATION * point, digits)); 
          case ORDER_TYPE_SELL_LIMIT       :  return(NormalizeDouble(tick.bid + DEVIATION * point, digits)); 
          case ORDER_TYPE_BUY_STOP         :  return(NormalizeDouble(tick.ask + DEVIATION * point, digits)); 
          case ORDER_TYPE_SELL_STOP        :  return(NormalizeDouble(tick.bid - DEVIATION * point, digits)); 
          case ORDER_TYPE_BUY_STOP_LIMIT   :  return(NormalizeDouble(tick.ask + DEVIATION * point - STOP_LIMIT * point, digits)); 
          case ORDER_TYPE_SELL_STOP_LIMIT  :  return(NormalizeDouble(tick.bid - DEVIATION * point + STOP_LIMIT * point, digits)); 
          default                          :  return(0); 
         } 
      } 
    

Кроме того, понадобится функция для получения типа рыночного ордера по типу ордера, это делается просто:
    
    
    ENUM_ORDER_TYPE MarketOrderByOrderType(ENUM_ORDER_TYPE type) 
      { 
       switch(type) 
         { 
          case ORDER_TYPE_BUY  : case ORDER_TYPE_BUY_LIMIT  : case ORDER_TYPE_BUY_STOP  : case ORDER_TYPE_BUY_STOP_LIMIT  : 
            return(ORDER_TYPE_BUY); 
          case ORDER_TYPE_SELL : case ORDER_TYPE_SELL_LIMIT : case ORDER_TYPE_SELL_STOP : case ORDER_TYPE_SELL_STOP_LIMIT : 
            return(ORDER_TYPE_SELL); 
         } 
       return(WRONG_VALUE); 
      }

**Расчет максимального лота**  
Функция GetMaxLot вычисляет максимальный размер лота, который можно открыть, исходя из доступной свободной маржи и указанного типа ордера. Это ключевой инструмент для управления рисками, который гарантирует соответствие сделок требованиям по марже, установленным брокером.

1\. Создание параметров функции

Функция принимает следующие параметры:
    
    
    double GetMaxLote(ENUM_ORDER_TYPE type, double DEVIATION = 100, double STOP_LIMIT = 50)
    

  * Type — определяет тип ордера, например ORDER_TYPE_BUY или ORDER_TYPE_SELL. Этот параметр является ключевым для корректного расчета цены и маржи.
  * DEVIATION — указывает допустимое отклонение в пунктах для отложенных ордеров. Значение по умолчанию — 100.
  * STOP_LIMIT — представляет расстояние в пунктах для ордеров типа STOP_LIMIT. Значение по умолчанию — 50.



2\. Инициализация необходимых переменных

Объявляются четыре переменные типа double и одно перечисление ORDER_TYPE, которые будут использоваться в рассчетах:
    
    
       //--- Set variables
       double VOLUME = 1.0; //Initial volume size
       ENUM_ORDER_TYPE new_type = MarketOrderByOrderType(type); 
       double price = PriceByOrderType(_Symbol, type, DEVIATION, STOP_LIMIT); // Price for the given order type
       double volume_step = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP); // Volume step for the symbol
       double margin = EMPTY_VALUE; // Required margin, initialized as empty

3\. ****Расчет маржи, необходимой для одного лота

Для определения маржи, требуемой для открытия одного лота при текущих рыночных условиях, используется функция OrderCalcMargin. В случае неудачи, выводится сообщение об ошибке и возвращается 0:
    
    
    ResetLastError(); 
    if (!OrderCalcMargin(new_type, _Symbol, VOLUME, price, margin)) 
      { 
       Print("OrderCalcMargin() failed. Error ", GetLastError()); 
       return 0; // Exit the function if margin calculation fails
      } 
    

4\. Расчет максимального размера лота

Для расчета максимального размера лота используется приведенная выше формула. Это включает в себя деление свободной маржи на требуемую маржу, нормализацию результата по допустимому шагу объема и округление в меньшую сторону во избежание ошибок:
    
    
    double result = MathFloor((AccountInfoDouble(ACCOUNT_MARGIN_FREE) / margin) / volume_step) * volume_step; 
    

5\. ****Возврат результата

В завершение, возвращается рассчитанный максимальный размер лота:
    
    
    return result; // Return the maximum lot size
    

Полная функция:
    
    
    double GetMaxLote(ENUM_ORDER_TYPE type, double DEVIATION = 100, double STOP_LIMIT = 50) 
      { 
       //--- Set variables
       double VOLUME = 1.0; // Initial volume size
       ENUM_ORDER_TYPE new_type = MarketOrderByOrderType(type); 
       double price = PriceByOrderType(_Symbol, type, DEVIATION, STOP_LIMIT); // Price for the given order type
       double volume_step = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);    // Volume step for the symbol
       double margin = EMPTY_VALUE; // Required margin, initialized as empty
      
       //--- Get margin for one lot
       ResetLastError(); 
       if (!OrderCalcMargin(new_type, _Symbol, VOLUME, price, margin)) 
         { 
          Print("OrderCalcMargin() failed. Error ", GetLastError()); 
          return 0; // Exit the function if margin calculation fails
         }
       //--- Calculate the maximum lot size
       double result = MathFloor((AccountInfoDouble(ACCOUNT_MARGIN_FREE) / margin) / volume_step) * volume_step; 
       return result; // Return the maximum lot size
      }

  


### Создание функций для получения прибыли   


После завершения разработки функций для расчета максимального размера лота, следующим шагом является разработка функций, которые рассчитывают прибыль с определенной даты по текущий момент времени. Это критически важно, поскольку при оценке на каждом тике нам необходимо определить, была ли превышена переменная максимального убытка. Для этого мы полагаемся на переменные, хранящие информацию о прибыли. Например, чтобы проверить, был ли превышен максимальный дневной убыток, необходимо знать накопленную прибыль за день, а также текущее эквити.

Расчет текущей прибыли будет выполняться с использованием доступных функций для работы с историей ордеров и транзакций. Это позволит нам получить точные и актуальные данные о прибыли и убытках за определенный период.

**Подробное описание функции**

1\. Инициализация переменных и сброс ошибок:
    
    
    double total_net_profit = 0.0; // Initialize the total net profit
    ResetLastError(); // Reset any previous errors****

  * total_net_profit — инициализируется значением 0,0, что означает, что чистая прибыль еще не была рассчитана.
  * ResetLastError — обеспечивает сброс любых предыдущих ошибок, которые могли возникнуть в коде, перед началом выполнения.



****

2\. Проверка даты начала (start_date):
    
    
    if((start_date > 0 || start_date != D'1971.01.01 00:00'))
    

Эта строка проверяет, является ли допустимой дата, указанная в качестве start_date (то есть не является ли она недействительной по умолчанию, например, 1971.01.01, или нулевой датой). Если дата допустима, код продолжает выполнение выборкой истории сделок.  


3\. Выборка истории сделок:
    
    
    if(!HistorySelect(start_date, TimeCurrent())) 
    {
       Print("Error when selecting orders: ", _LastError); 
       return 0.0; // Exit if unable to select the history
    }

  * HistorySelect — выбирает историю сделок с указанной даты (start_date) до текущего момента времени (TimeCurrent).
  * Если выборка истории не удалась, выводится сообщение об ошибке, и функция завершается, возвращая 0.

****

4\. Получение общего количества сделок: 
    
    
    int total_deals = HistoryDealsTotal(); // Get the total number of deals in history
    

  * HistoryDealsTotal — возвращает общее количество сделок в истории, что позволяет определить, сколько сделок нужно обработать.



5\. Итерация по всем сделкам: 
    
    
    for(int i = 0; i < total_deals; i++)
    {
       ulong deal_ticket = HistoryDealGetTicket(i); // Retrieve the deal ticket

  * На этом этапе запускается цикл for, который будет проходить по всем сделкам в истории.
  * HistoryDealGetTicket — получает уникальный тикет сделки на позиции i, который необходим для получения подробной информации о сделке.



6\. Фильтрация сделок типа "balance": 
    
    
    if(HistoryDealGetInteger(deal_ticket, DEAL_TYPE) == DEAL_TYPE_BALANCE) continue;

Если тип сделки — balance (корректировка баланса, а не реальная торговая сделка), то такая сделка пропускается, и цикл продолжается со следующей.

7\. Получение подробностей сделки: 
    
    
    ENUM_DEAL_ENTRY deal_entry = (ENUM_DEAL_ENTRY)HistoryDealGetInteger(deal_ticket, DEAL_ENTRY); // Get deal entry type
    long deal_close_time_long = HistoryDealGetInteger(deal_ticket, DEAL_TIME);                    // Get deal close time (as long)
    datetime deal_close_time = (datetime)deal_close_time_long;                                    // Explicit conversion to datetime
    ulong position_id = HistoryDealGetInteger(deal_ticket, DEAL_POSITION_ID);                     // Get the position ID

  * deal_entry — определяет, была ли сделка входом или выходом (используется для понимания, была ли сделка открытием или закрытием).
  * deal_close_time — время закрытия сделки. Для удобства обработки преобразуется в тип datetime.
  * position_id — идентификатор позиции, связанной с данной сделкой, что помогает проверить magic number.



8\. Фильтрация сделок по дате и типу: 
    
    
    if(deal_close_time >= start_date && (deal_entry == DEAL_ENTRY_OUT || deal_entry == DEAL_ENTRY_IN))
    

Условие гарантирует, что будут учитываться только те сделки, время закрытия которых больше или равно дате начала start_date, и которые являются допустимыми входными или выходными сделками.  


9\. Фильтрация сделок по Magic Number и типу включения: 
    
    
    if((HistoryDealGetInteger(deal_ticket, DEAL_MAGIC) == specific_magic || specific_magic == GetMagic(position_id)) 
       || include_all_magic == true)
    

  * HistoryDealGetInteger — получает magic number сделки.
  * Если magic number операции совпадает с указанным (specific_magic), или если разрешено включение всех сделок (когда include_all_magic равно true), рассчитывается чистая прибыль по сделке.

  


10\. Расчет чистой прибыли по сделке:
    
    
    double deal_profit = HistoryDealGetDouble(deal_ticket, DEAL_PROFIT);         // Retrieve profit from the deal
    double deal_commission = HistoryDealGetDouble(deal_ticket, DEAL_COMMISSION); // Retrieve commission
    double deal_swap = HistoryDealGetDouble(deal_ticket, DEAL_SWAP);             // Retrieve swap fees
                      
    double deal_net_profit = deal_profit + deal_commission + deal_swap;          // Calculate net profit for the deal
    total_net_profit += deal_net_profit;                                         // Add to the total net profit
    

  * deal_profit — получает прибыль по сделке.
  * deal_commission — получает комиссию по сделке.
  * deal_swap — получает своп по сделке (процентная ставка или комиссия за перенос позиции на следующий торговый день).



Чистая прибыль по сделке рассчитывается как сумма этих трех значений и прибавляется к total_net_profit.

11\. Возврат общей чистой прибыли: 
    
    
    return NormalizeDouble(total_net_profit, 2); // Return the total net profit rounded to 2 decimals
    

В завершение возвращается общая чистая прибыль, округленная до 2 знаков после запятой с помощью NormalizeDouble, чтобы гарантировать значению правильный формат для дальнейшего использования.  


Полная функция:
    
    
    double GetNetProfitSince(bool include_all_magic, ulong specific_magic, datetime start_date)
    {
       double total_net_profit = 0.0; // Initialize the total net profit
       ResetLastError();              // Reset any previous errors
    
       // Check if the start date is valid
       if((start_date > 0 || start_date != D'1971.01.01 00:00'))
       {   
          // Select the order history from the given start date to the current time
          if(!HistorySelect(start_date, TimeCurrent())) 
          {
             Print("Error when selecting orders: ", _LastError); 
             return 0.0; // Exit if unable to select the history
          }
    
          int total_deals = HistoryDealsTotal(); // Get the total number of deals in history
      
          // Iterate through all deals
          for(int i = 0; i < total_deals; i++)
          {
             ulong deal_ticket = HistoryDealGetTicket(i); // Retrieve the deal ticket
    
             // Skip balance-type deals
             if(HistoryDealGetInteger(deal_ticket, DEAL_TYPE) == DEAL_TYPE_BALANCE) continue;            
    
             ENUM_DEAL_ENTRY deal_entry = (ENUM_DEAL_ENTRY)HistoryDealGetInteger(deal_ticket, DEAL_ENTRY); // Get deal entry type
             long deal_close_time_long = HistoryDealGetInteger(deal_ticket, DEAL_TIME);                    // Get deal close time (as long)
             datetime deal_close_time = (datetime)deal_close_time_long;                                    // Explicit conversion to datetime
             ulong position_id = HistoryDealGetInteger(deal_ticket, DEAL_POSITION_ID);                     // Get the position ID
    
             // Check if the deal is within the specified date range and is a valid entry/exit deal
             if(deal_close_time >= start_date && (deal_entry == DEAL_ENTRY_OUT || deal_entry == DEAL_ENTRY_IN))
             {             
                // Check if the deal matches the specified magic number or if all deals are to be included
                if((HistoryDealGetInteger(deal_ticket, DEAL_MAGIC) == specific_magic || specific_magic == GetMagic(position_id)) 
                   || include_all_magic == true)
                {
                   double deal_profit = HistoryDealGetDouble(deal_ticket, DEAL_PROFIT);         // Retrieve profit from the deal
                   double deal_commission = HistoryDealGetDouble(deal_ticket, DEAL_COMMISSION); // Retrieve commission
                   double deal_swap = HistoryDealGetDouble(deal_ticket, DEAL_SWAP);             // Retrieve swap fees
                   
                   double deal_net_profit = deal_profit + deal_commission + deal_swap; // Calculate net profit for the deal
                   total_net_profit += deal_net_profit; // Add to the total net profit
                }
             }
          }
       }
         
       return NormalizeDouble(total_net_profit, 2); // Return the total net profit rounded to 2 decimals
    }

Дополнительная функция для получения magic number ордера:
    
    
    ulong GetMagic(const ulong ticket)
    {
    HistoryOrderSelect(ticket);
    return HistoryOrderGetInteger(ticket,ORDER_MAGIC); 
    } 

  


### Проверка на практике с помощью создания простого скрипта с включаемым файлом 

Теперь давайте создадим функцию, которая преобразует абсолютное расстояние в единицы пунктов для текущего символа. Такое преобразование имеет ключевое значение в трейдинге, поскольку пункты являются стандартной единицей измерения при расчете уровней цен, стопов и целей.

**Математическая формула**  
Формула для расчета расстояния в пунктах проста:

![ЭКСТРА-1](https://c.mql5.com/2/111/extra-1.png)

Где:

  * dist — это абсолютное расстояние, которое мы хотим преобразовать,
  * pointSize — размер одного пункта финансового инструмента (например, 0,0001 для EUR/USD)



**Представление формулы в коде**  
Для реализации этой формулы в MQL5 необходимо выполнить следующие шаги:

  1. Получить размер пункта (pointSize).

Мы используем функцию SymbolInfoDouble для получения значения пункта текущего символа. Параметр _Symbol представляет символ, на котором выполняется скрипт, а SYMBOL_POINT возвращает его размер в пунктах.
    
    double pointSize = SymbolInfoDouble(_Symbol, SYMBOL_POINT);
    

  2. Разделить расстояние на размер пункта и преобразовать в целое число. 

Чтобы вычислить количество пунктов, мы делим расстояние (dist) на размер пункта (pointSize). Затем мы преобразуем результат в целое значение, используя int, поскольку пункты всегда являются целыми числами. 
    
    return (int)(dist / pointSize);
    




**Полная функция**  
Ниже мы представляем функцию в ее окончательном виде:
    
    
    int DistanceToPoint(double dist)
    {
      double pointSize = SymbolInfoDouble(_Symbol, SYMBOL_POINT); // Get the point size for the current symbol
      return (int)(dist / pointSize); // Calculate and return the distance in points 
    }

Чтобы применить на практике все изложенное в этой статье, мы создадим два скрипта.

Теперь мы создадим две важные функции: одну — для расчета идеального лота на основе допустимого убытка на сделку, и другую — для расчета идеального стоп-лосса в пунктах символа на основе заданного лота и риска на сделку. 

**Функция для расчета идеального лота на основе риска на сделку**  
Функция GetIdealLot рассчитывает идеальный размер лота (nlot) с учетом максимально допустимого убытка на сделку и расстояния до стоп-лосса (StopLoss). Это гарантирует, что каждая сделка соблюдает заданный пользователем лимит риска.
    
    
    void GetIdealLot(
        double& nlot,                     // Calculated ideal lot
        double glot,                      // Gross Lot (max lot accorsing to the balance)
        double max_risk_per_operation,    // Maximum allowed risk per trade (in account currency)
        double& new_risk_per_operation,   // Calculated risk for the adjusted lot (in account currency)
        long StopLoss                     // Stop Loss distance (in points)
    )
    

Описание параметров:

  1. nlot — это будет идеальный лот, скорректированный функцией.
  2. glot — это максимально возможный лот, который можно открыть, используя все доступные средства на счете.
  3. max_risk_per_operation — представляет собой максимально допустимый риск на сделку, выраженный в валюте счета.
  4. new_risk_per_operation — указывает фактический риск по скорректированной сделке с учетом рассчитанного лота (nlot), что показывает, сколько будет потеряно, если цена достигнет стоп-лосса.
  5. StopLoss — расстояние до стоп-лосса в пунктах.



1\. Начальная проверка

Функция проверяет, что значение «StopLoss» больше 0, так как недопустимый стоп-лосс сделает невозможным корректный расчет риска.
    
    
    if(StopLoss <= 0)
    {
        Print("[ERROR SL] Stop Loss distance is less than or equal to zero, now correct the stoploss distance: ", StopLoss);
        nlot = 0.0; 
        return;   
    }
    

2\. Инициализация переменных

Инициализируются значения, необходимые для последующих вычислений:

  * spread — текущий спред символа.
  * tick_value — значение одного тика, показывающее, сколько стоит минимальное изменение цены в валюте счета.
  * step — минимально допустимое приращение размера лота.


    
    
    new_risk_per_operation = 0;  // Initialize the new risk
    long spread = (long)SymbolInfoInteger(_Symbol, SYMBOL_SPREAD);
    double tick_value = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE);
    double step = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);
    

3\. Расчет текущего риска (rpo)

Вычисляется текущий риск на сделку (rpo) по следующей формуле:

![РИСК-1](https://c.mql5.com/2/111/risk-1.png)

В коде:
    
    
    double rpo = (glot * (spread + 1 + (StopLoss * tick_value)));
    

4\. Проверка максимального риска

Функция оценивает, превышает ли текущий риск (rpo) максимально допустимый риск на сделку (max_risk_per_operation):

Случай 1. Риск превышает максимально допустимый

  * Размер лота корректируется пропорционально максимально допустимому риску.
  * Скорректированный лот округляется до ближайшего допустимого приращения (step).
  * Вычисляется новый риск, соответствующий этому скорректированному лоту.


    
    
    if(rpo > max_risk_per_operation)
    {
        double new_lot = (max_risk_per_operation / rpo) * glot;
        new_lot = MathFloor(new_lot / step) * step;
        new_risk_per_operation = new_lot * (spread + 1 + (StopLoss * tick_value));
        nlot = new_lot; 
    }
    

Случай 2. Риск в пределах допустимого лимита

  * Если текущий риск не превышает установленный предел, сохраняются исходные значения:


    
    
    else
    {
        new_risk_per_operation = rpo; // Current risk
        nlot = glot;                  // Gross lot
    }
    

Наконец, мы создадим последнюю функцию для расчета стоп-лосса на основе максимально допустимого убытка на сделку и заданного пользователем объема лота:
    
    
    long GetSL(const ENUM_ORDER_TYPE type , double risk_per_operation , double lot) 
    {
     long spread = (long)SymbolInfoInteger(_Symbol, SYMBOL_SPREAD);
     double tick_value = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE);
     double result = ((risk_per_operation/lot)-spread-1)/tick_value;
     
    return long(MathRound(result));
    }  

Описание параметров:

  1. type — тип ордера (покупка или продажа), хотя в данной функции напрямую не используется.
  2. risk_per_operation — максимально допустимый убыток на сделку, выраженный в валюте счета.
  3. lot — размер лота, определяемый пользователем.



**Пошаговая логика работы**

****

1\. Базовая формула:

Исходная формула расчета риска на сделку (rpo) выглядит так:

![РИСК-1](https://c.mql5.com/2/111/risk-1__2.png)

В этой функции мы выразим стоп-лосс, чтобы рассчитать его значение на основе rpo, размера лота и других факторов. 

2\. Выражение стоп-лосса:

  * Обе части уравнения делятся на значение лота (lote):



![РИСК-2](https://c.mql5.com/2/111/risk-2.png)

  * Вычитаем спред и 1 из обеих частей уравнения:   




![РИСК-3](https://c.mql5.com/2/111/risk-3.png)

  * Делим на tick_value, чтобы изолировать StopLoss: 



![РИСК-4](https://c.mql5.com/2/111/risk-4.png)

**Реализация в коде**  
Приведенная выше формула напрямую используется в вычислениях в теле функции:
    
    
    double result = ((risk_per_operation / lot) - spread - 1) / tick_value;

  * risk_per_operation/lot — рассчитывает риск на единицу лота,
  * \- спред - 1 — вычитает спред и дополнительный допуск,
  * /tick_value — преобразует результат в пункты, деля на значение одного тика.

  


Результат округляется и преобразуется в тип long для соответствия требуемому формату: 
    
    
    return long(MathRound(result));
    

Наконец, мы создадим два скрипта для расчета идеального лота и идеального стоп-лосса (sl) в соответствии с заданным риском на сделку. Оба скрипта используют простую, но эффективную логику для автоматизации этих вычислений на основе баланса счета и параметров, заданных пользователем.

**Первый скрипт: расчет идеального лота**  
Этот скрипт рассчитает идеальный размер лота на основе процента риска на сделку, заданного стоп-лосса (sl) в пунктах и типа ордера.

  1. Свойства скрипта:

     * #property strict — гарантирует, что код соответствует строгим правилам компиляции.
     * #property script_show_inputs — позволяет пользователю вводить параметры через графический интерфейс.
  2. Входные параметры (Inputs):


    
    
    input double percentage_risk_per_operation = 1.0; //Risk per operation in %
    input long   sl = 600; //Stops Loss in points
    input ENUM_ORDER_TYPE Order_Type = ORDER_TYPE_BUY; //Order Type

Расчет риска на сделку:

****Формула вычисляет сумму в долларах, которой можно рискнуть в одной сделке, на основе заданного процентного значения:
    
    
    double risk_per_operation = ((percentage_risk_per_operation/100.0) * AccountInfoDouble(ACCOUNT_BALANCE));
    

Вызов функции расчета идеального лота:
    
    
    GetIdealLot(new_lot, GetMaxLote(Order_Type), risk_per_operation, new_risk_per_operation, sl);
    

Сообщения для пользователя: подробная информация о рассчитанных значениях, таких как идеальный лот и скорректированный риск, выводится в консоль и на график.
    
    
    //+------------------------------------------------------------------+
    //|                             Get Lot By Risk Per Trade and SL.mq5 |
    //|                                                        Your name |
    //|                                             https://www.mql5.com |
    //+------------------------------------------------------------------+ 
    #property copyright "Your name"
    #property link      "https://www.mql5.com"
    #property version   "1.00"
    #property strict
    #property script_show_inputs
    
    input double percentage_risk_per_operation = 1.0; // Risk per operation in %
    input long   sl = 600; // Stop Loss in points
    input ENUM_ORDER_TYPE Order_Type = ORDER_TYPE_BUY; // Order Type
    
    #include <Risk Management.mqh>
    
    //+------------------------------------------------------------------+
    //| Main script function                                             |
    //+------------------------------------------------------------------+
    void OnStart()
      {
       // Calculate the maximum allowable risk per operation in account currency
       double risk_per_operation = ((percentage_risk_per_operation / 100.0) * AccountInfoDouble(ACCOUNT_BALANCE));
       
       // Print input and calculated risk details
       Print("Risk Per operation: ", risk_per_operation);
       Print("SL in points: ", sl);
       Print("Order type: ", EnumToString(Order_Type));
       
       double new_lot;
       double new_risk_per_operation;
       
       // Calculate the ideal lot size
       GetIdealLot(new_lot, GetMaxLote(Order_Type), risk_per_operation, new_risk_per_operation, sl);
       
       // Check if the lot size is valid
       if (new_lot <= 0)
         {
          Print("The stop loss is too large or the risk per operation is low. Increase the risk or decrease the stop loss.");
         }
       else
         {
          // Display calculated values
          Print("Ideal Lot: ", new_lot);
          Print("Maximum loss with SL: ", sl, " | Lot: ", new_lot, " is: ", new_risk_per_operation);
          Comment("Ideal Lot: ", new_lot);
         }
       
       Sleep(1000);
       Comment(" ");
      }
    //+------------------------------------------------------------------+
    

**Второй скрипт: расчет идеального SL**  
Этот скрипт вычисляет стоп-лосс в пунктах на основе заданного пользователем лота и максимального риска на сделку.
    
    
    input double percentage_risk_per_operation = 1.0; //Risk per operation in %
    input double Lot = 0.01; //lot
    input ENUM_ORDER_TYPE Order_Type = ORDER_TYPE_BUY; //Order Type

Расчет идеального sl: функция get sl используется для определения стоп-лосса в пунктах: 
    
    
    long new_sl = GetSL(Order_Type, risk_per_operation, Lot);
    

Проверка результата: если вычисленное значение sl недопустимо (new_sl меньше или равно 0), пользователь получает соответствующее уведомление. 
    
    
    //+------------------------------------------------------------------+
    //|                         Get Sl by risk per operation and lot.mq5 |
    //|                                                        Your name |
    //|                                             https://www.mql5.com |
    //+------------------------------------------------------------------+
    #property copyright "Your name"
    #property link      "https://www.mql5.com"
    #property version   "1.00"
    #property strict
    #property script_show_inputs
    
    input double percentage_risk_per_operation = 1.0; // Risk per operation in %
    input double Lot = 0.01; // Lot size
    input ENUM_ORDER_TYPE Order_Type = ORDER_TYPE_BUY; // Order Type
    
    #include <Risk Management.mqh>
    
    //+------------------------------------------------------------------+
    //| Main script function                                             |
    //+------------------------------------------------------------------+
    void OnStart()
      {
       // Calculate the maximum allowable risk per operation in account currency
       double risk_per_operation = ((percentage_risk_per_operation / 100.0) * AccountInfoDouble(ACCOUNT_BALANCE));
       
       // Print input and calculated risk details
       Print("Risk Per operation: ", risk_per_operation);
       Print("Lot size: ", Lot);
       Print("Order type: ", EnumToString(Order_Type));
       
       // Calculate the ideal stop loss
       long new_sl = GetSL(Order_Type, risk_per_operation, Lot);
       
       // Check if the SL is valid
       if (new_sl <= 0)
         {
          Print("The lot size is too high or the risk per operation is too low. Increase the risk or decrease the lot size.");
         }
       else
         {
          // Display calculated values
          Print("For lot: ", Lot, ", and risk: ", risk_per_operation, ", the ideal SL is: ", new_sl);
          Comment("Ideal SL: ", new_sl);
         }
       
       Sleep(1000);
       Comment(" ");
      }
    //+------------------------------------------------------------------+

Теперь, чтобы применить скрипт на практике, мы используем его для получения идеального размера лота на основе заданного риска на сделку. Тестирование проведем на символе XAUUSD, который соответствует золоту. 

![ СКРИПТ-РИСК-1](https://c.mql5.com/2/110/SCRIPT-RISK-1.PNG)

При таких параметрах, как стоп-лосс в 200 пунктов и риск на сделку в размере 1,0% от баланса счета, а также с указанием типа ордера как ORDER_TYPE_BUY, результат будет следующим:

![ СКРИПТ-РИСК-2](https://c.mql5.com/2/110/SCRIPT-RISK-2__1.PNG)

Результат, показанный на вкладке «Эксперты», соответствует размеру лота 0,01 при стоп-лоссе в 200 пунктов и риске на сделку в 3,81, что составляет 1% от баланса счета.

###   
  
Заключение 

Мы завершили первую часть этой серии, в которой сосредоточились на разработке основных функций, которые будут использоваться в классе **управления рисками**. Эти функции являются ключевыми для получения прибыли и выполнения дополнительных вычислений. В следующей части мы рассмотрим, как интегрировать все изученное в графический интерфейс, используя библиотеки элементов управления MQL5. 

Перевод с испанского произведен MetaQuotes Ltd.   
Оригинальная статья: [https://www.mql5.com/es/articles/16820](/es/articles/16820)

**Прикрепленные файлы** | 

[ __Загрузить ZIP](/ru/articles/download/16820.zip "Загрузить все вложения в одном ZIP-архиве")

[__Risk_Management.mqh](/ru/articles/download/16820/risk_management.mqh "Скачать Risk_Management.mqh") (8.27 KB)

[__Get_Sl_by_risk_per_operation_and_lot.mq5](/ru/articles/download/16820/get_sl_by_risk_per_operation_and_lot.mq5 "Скачать Get_Sl_by_risk_per_operation_and_lot.mq5") (3.84 KB)

[__Get_Lot_By_Risk_Per_Trade_and_SL.mq5](/ru/articles/download/16820/get_lot_by_risk_per_trade_and_sl.mq5 "Скачать Get_Lot_By_Risk_Per_Trade_and_SL.mq5") (2.07 KB)

**Предупреждение:** все права на данные материалы принадлежат MetaQuotes Ltd. Полная или частичная перепечатка запрещена.

Данная статья написана пользователем сайта и отражает его личную точку зрения. Компания MetaQuotes Ltd не несет ответственности за достоверность представленной информации, а также за возможные последствия использования описанных решений, стратегий или рекомендаций.

![Niquel Mendoza](https://c.mql5.com/avatar/2024/8/66bbab57-2d8c_big.png)

[Niquel Mendoza](/ru/users/nique_372 "Niquel Mendoza")

  * __[Перу](https://www.mql5.com/go?https://maps.google.com/?z=4&q=%d0%9f%d0%b5%d1%80%d1%83 "Живёт")
  * __[6075](/ru/users/nique_372/achievements "Рейтинг")



#### Другие статьи автора

  * [Реализация частичного закрытия позиций в MQL5](/ru/articles/19682)
  * [Реализация механизма безубыточности в MQL5 (Часть 2): Безубыток на основе ATR и RRR](/ru/articles/18111)
  * [Реализация механизма безубыточности в MQL5 (Часть 1): Базовый класс и режим безубытка по фиксированным пунктам](/ru/articles/17957)
  * [Управление рисками (Часть 5): Интегрируем систему управления рисками в советник](/ru/articles/17640)
  * [Управление рисками (Часть 4): Завершение ключевых методов класса](/ru/articles/17508)
  * [Управление рисками (Часть 3): Создание основного класса для управления рисками](/ru/articles/17249)
  * [Управление рисками (Часть 2): Реализация расчета лотов в графическом интерфейсе](/ru/articles/16985)



**[Перейти к обсуждению на форуме трейдеров](/ru/forum/492367) **

![Теория графов: Алгоритм Дейкстры в трейдинге](https://c.mql5.com/2/155/18760-graph-theory-dijkstra-s-algorithm-logo.png) [Теория графов: Алгоритм Дейкстры в трейдинге](/ru/articles/18760)

Алгоритм Дейкстры — классическое решение по поиску кратчайшего пути в теории графов, которое позволяет оптимизировать торговые стратегии путем моделирования рыночных сетей. Трейдеры могут использовать его для поиска наиболее эффективных маршрутов в данных свечного графика.

![Разработка системы репликации \(Часть 78\): Новый Chart Trade \(V\)](https://c.mql5.com/2/105/Desenvolvendo_um_sistema_de_Replay_Parte_77___LOGO.png) [Разработка системы репликации (Часть 78): Новый Chart Trade (V)](/ru/articles/12492)

В данной статье мы рассмотрим, как нужно реализовывать часть кода получателя. Здесь мы реализуем версию советника, чтобы протестировать и узнать, как работает взаимодействие по протоколу. Представленные здесь материалы предназначены только для обучения. Ни в коем случае не рассматривайте его как окончательное приложение, целью которого не является изучение представленных концепций.

![Разработка инструментария для анализа движения цен \(Часть 5\): Советник Volatility Navigator](https://c.mql5.com/2/105/Price_Action_Analysis_Toolkit_Development_Part_5___LOGO.png) [Разработка инструментария для анализа движения цен (Часть 5): Советник Volatility Navigator](/ru/articles/16560)

Определить направление рынка может быть просто, но вот понять, когда входить на рынок, - гораздо более сложная задача. В этой статье серии "Разработка инструментария для анализа движения цен" я представлю еще один инструмент, который определяет точки входа и уровни стоп-лосса/тейк-профита. Для достижения этой цели использовался язык программирования MQL5.

![Нейросети в трейдинге: Распутывание структурных компонентов \(Окончание\)](https://c.mql5.com/2/161/19022-neyroseti-v-treydinge-rasputivanie-logo.png) [Нейросети в трейдинге: Распутывание структурных компонентов (Окончание)](/ru/articles/19022)

В статье подробно раскрывается SCNN-архитектура и один из вариантов её реализация средствами MQL5. Мы покажем, как декомпозиция временных рядов сочетается с нейросетевыми методами и вниманием.

![MQL5 - Язык торговых стратегий для клиентского терминала MetaTrader 5](https://c.mql5.com/i/registerlandings/logo-2.png)

Вы упускаете торговые возможности:

  * Бесплатные приложения для трейдинга
  * 8 000+ сигналов для копирования
  * Экономические новости для анализа финансовых рынков



Регистрация Вход

  * [Войти через Google](https://www.mql5.com/ru/auth_oauth2?provider=Google&amp;return=popup&amp;reg=1)



Вы принимаете [политику сайта](/ru/about/privacy) и [условия использования](/ru/about/terms)

Если у вас нет учетной записи, [зарегистрируйтесь](https://www.mql5.com/ru/auth_register)

Для авторизации и пользования сайтом MQL5.com необходимо разрешить использование файлов Сookie.

Пожалуйста, включите в вашем браузере данную настройку, иначе вы не сможете авторизоваться.

  * [Войти через Google](https://www.mql5.com/ru/auth_oauth2?provider=Google&amp;return=popup)


