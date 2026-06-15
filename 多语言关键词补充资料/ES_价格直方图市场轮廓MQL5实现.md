# ES_价格直方图市场轮廓MQL5实现

> 来源标题：El histograma del precio (perfil del mercado) y su implementación en MQL5 - Artículos sobre MQL5
> 来源链接：https://www.mql5.com/es/articles/17
> 下载时间：2026-06-12 23:29:01
> 说明：多语言关键词补充资料，供中文策略语义反向映射使用。

---

[ __](javascript:void\(false\);) [English](/en/articles/17) [Русский](/ru/articles/17) [中文](/zh/articles/17) [Deutsch](/de/articles/17) [日本語](/ja/articles/17) [Português](/pt/articles/17) [한국어](/ko/articles/17) [Français](/fr/articles/17) [Italiano](/it/articles/17) [Türkçe](/tr/articles/17)

__

[ __](/es/articles/17?print= "Versión para imprimir")

![El histograma del precio \(perfil del mercado\) y su implementación en MQL5](https://c.mql5.com/i/articles/overlay.png)

# El histograma del precio (perfil del mercado) y su implementación en MQL5

[MetaTrader 5](/es/articles/mt5) — [Ejemplos](/es/articles/mt5/examples) | 22 enero 2014, 07:50

![](https://c.mql5.com/i/icons.svg#views-usage) 3 854  [ ![](https://c.mql5.com/i/icons.svg#comments-usage) 103 ](/es/forum/18424 "Comentarios")

![Dmitry Voronkov](https://c.mql5.com/avatar/2010/3/4B9E6DA0-951C.jpg)

[Dmitry Voronkov](/es/users/vdv2001)

El perfil del mercado intenta proporcionar esta lógica interna en el contexto del mercado.  
Es un método de análisis que comienza con la comprensión de que el precio solo  
no comunica la información al participante como lo hacen las palabras. Sin una sintaxis  
o contexto, puede que no tenga ningún significado. El volumen es una parte integral de la expresión directa del  
mercado. Si lo entendemos, entenderemos el lenguaje del mercado."  
Robin Mesh  


### 

Introducción  


Hace mucho tiempo, mientras miraba una subscripción a algunas revistas, me encontré con un artículo llamado "Perfil del mercado y entender el lenguaje del mercado" (octubre, 2002) en el diario ruso "Valutny Spekulant" (actualmente se le conoce como un "activo operador en los mercados"). El artículo original fue publicado en ["New Thinking in Technical Analysis: Trading Models from the Masters"](/go?link=https://www.amazon.com/New-Thinking-Technical-Analysis-Trading/dp/1576600491 "http://www.amazon.com/New-Thinking-Technical-Analysis-Trading/dp/1576600491").

El perfil del mercado fue desarrollado por un autor realmente brillante, Peter Steidlmayer. Él fue quien encontró la expresión natural del mercado (volumen) y la organizó para que fuese legible (la curva de campana), de forma que la información objetiva generada por el mercado fuera accesible para los participantes en él. Steidlmayer sugirió el uso de la representación alternativa de la información sobre los movimientos "horizontales" y "verticales" del mercado que llevan a un conjunto completamente diferente de modelos. Este autor asumió que hay un pulso subyacente o patrón fundamental en el mercado llamado el ciclo de equilibrio y desequilibrio. 

El perfil del mercado mide el movimiento horizontal del mercado a través del vertical. Lo llamaremos "equilibrio" a través del "desequilibrio". Esta relación es el principio de organización fundamental del mercado. Todo el estilo de operar de un operador puede cambiar según en qué parte del ciclo de equilibrio/desequilibrio se encuentre el mercado. El perfil del mercado puede determinar tanto el momento en el que el mercado va a cambiar del equilibrio al desequilibrio como la dimensión que va a tener dicho cambio.

Los dos conceptos básicos del perfil del mercado son:  


  1. El mercado es una subasta y se mueve en la dirección del rango de precio en que la oferta y la demanda son más o menos iguales.  

  2. El mercado tiene dos fases: actividad horizontal y vertical. El mercado se mueve verticalmente cuando la oferta y la demanda no son iguales o están en desequilibrio, y horizontalmente cuando están en equilibrio o equilibradas.



El equilibrio del mercado mostrado con el uso del perfil del mercado en el siguiente gráfico tiende a formar una curva de campana casi perfecta, girada 90 grados debido a la orientación del gráfico:  


![](https://c.mql5.com/2/0/c1ps45k3w0gomnwb.PNG)

Figura 1. El perfil del mercado del mercado en equilibrio

La tendencia, el mercado que no está en equilibrio, también forma una curva con forma de campana, pero su centro se ha desplazado hacia arriba o hacia abajo. También son posibles otras configuraciones que forman dos picos de campana, dependiendo del movimiento del precio y de la confianza de los participantes en el mercado.

![](https://c.mql5.com/2/0/98o191fgn7nephf9rn.PNG)

Figura 2. El perfil del mercado en (tendencia de) desequilibrio

El uso de las formas de perfil de cada día para determinar el grado de equilibrio/desequilibrio del mercado puede ser útil, ya que nos da un punto de partida para comprender los cambios entre varios participantes en el mercado.  


Una oportunidad de trading con el mayor beneficio posible aparece cuando el cambio desde el equilibrio al desequilibrio está a punto de producirse. Además, si podemos identificar esa oportunidad de trading y estimar con precisión la magnitud potencial del cambio, podremos estimar la calidad de dicha transacción y la cantidad de tiempo que esta requiere.  


Es necesario recordar que en este artículo veremos el código para dibujar una versión simplificada del perfil del mercado, el llamado histograma del precio basado en la relación entre precio y tiempo.  


El ejemplo de la metodología de trabajo con esta herramienta se encuentra disponible en [http://www.enthios.com/](https://www.mql5.com/go?link=http://www.enthios.com/ "http://www.enthios.com/"), donde un grupo de operadores han estudiado el histograma del precio desde 1998. La estrategia universal de Enthios y un ejemplo de su uso puede consultarse también ahí.

  


### 1\. Histograma del precio  


El histograma del precio es una herramienta muy fidedigna. Es un poco intuitiva pero extremadamente efectiva. El histograma del precio simplemente muestra los puntos de trading "más convenientes" del mercado. Este es un indicador principal, ya que muestra los puntos en los que el mercado puede cambiar su dirección de forma anticipada. Los indicadores como las medias móviles o los osciladores no pueden especificar los puntos exactos de resistencia y apoyo, ya que solo pueden mostrar si el mercado está en sobrecompra o en sobreventa.  


Normalmente, el histograma del precio (o el perfil del mercado) se aplica a los gráficos de precio de 30 min. para estudiar la actividad del mercado durante un día. Prefiero usar los gráficos de 5 min. para los mercados bursátiles y los de 15-30 min. para FOREX.

  


### 2\. Punto de control  


En la figura anterior podemos ver el nivel en el que en el mercado se produjeron transacciones durante la máxima cantidad de tiempo. Esto se muestra con la línea más larga en el histograma. Se llama **punto de control** o **POC.** Algunas veces, como se aprecia en la figura, el histograma tiene dos puntos altos, uno de ellos es un poco más bajo. En tal caso, vemos que el indicador muestra solo un POC, pero de hecho hay dos, y esto debe tenerse en cuenta.  


Además, el nivel porcentual del rango en el histograma también crea niveles adicionales llamados **niveles de POC secundarios** :  


![](https://c.mql5.com/2/0/POC.PNG)

Figura 3. Puntos de control  


¿Qué muestra un POC? El precio recordado por la mayoría de operadores. Cuanto más duran las transacciones del mercado a este precio, más tiempo lo recuerda el mercado.  


Psicológicamente, un POC actúa como un punto de atracción.  


El siguiente gráfico muestra qué pasó unos días antes. Es una buena demostración del poder del histograma del precio.

![](https://c.mql5.com/2/0/POC1__.png)

Figura 4. Los puntos de control no son absolutos, ya que muestran el rango de transacciones  


Los puntos de control no son absolutos, ya que muestran el rango de transacciones. De esta forma, el operador debe estar preparado para actuar cuando el mercado se dirige a un POC. Ayuda a optimizar órdenes usando las observaciones históricas.  


Veamos ahora la Fig.4. El POC del 29.12.2009 tiene un precio de 68.87. Está más claro, incluso sin el histograma y el POC, que el mercado estaba en el rango 68.82~68.96 casi todo el día. El mercado cerró al final del día a 5 puntos por debajo del POC. En el día siguiente provocó una apertura del mercado con una brecha a la baja.  


Es importante comprender que no podemos predecir si el mercado subirá o bajará. Solo podemos suponer que el mercado volverá al POC y a la máxima acumulación de líneas del historial. Pero ¿qué pasará cuando el precio llegue al POC? Lo mismo que ocurre con un objeto elástico que cae al suelo, volverá a retroceder. Si esto ocurre rápidamente, como el golpe con una raqueta a una pelota de tenis, el precio volverá muy rápidamente al nivel inicial.  


Después de la apertura del mercado el 30.12.2009 vemos que hubo una brecha y a continuación el mercado llegó al POC del día anterior, y luego volvió rápidamente al precio de apertura y actualizó el mínimo.  


Observe que el POC no es totalmente preciso (los operadores experimentados saben que no hay niveles de resistencia claros cuando el precio alcanza un máximo, mínimo o un rango de concentración). Lo que ocurre en este punto depende de los participantes en el mercado. Si el deseo colectivo (por ejemplo, una publicación en las noticias) coincide, el mercado pasará a través del POC, pero no es habitual y puede usarse para desarrollar un sistema de trading.  


Preste atención al hecho de que el comportamiento del mercado fue el mismo el 31.12.2009. Cuando el precio alcanzó el POC, los compradores cedieron ante los vendedores.

  


### 3\. Punto de control virgen  


El POC virgen (punto de control virgen) es un nivel que el precio no ha alcanzado en los próximos días.  


La lógica es simple, como se describió anteriormente, el POC es un punto de atracción para el mercado. A medida que el precio se aleja del POC, se incrementa la fuerza de atracción. Y cuando más se alejan los precios del POC virgen mayor es la posibilidad de que cuando vuelva a este nivel, se produzca un rebote y probablemente ocurra también una inversión del precio.  


![](https://c.mql5.com/2/0/VirginPOC.png)

Figura 5. POC virgen anterior y actual

En la Fig. 5, los anteriores POC vírgenes que fueron los niveles de apoyo y resistencia se han marcado con círculos. El POC virgen en funcionamiento se ha marcado con valores de precios.

Una vez que el precio ha llegado al POC virgen deja de ser "virgen". Psicológicamente, el mercado ya no lo ve más como un nivel importante de apoyo o resistencia. Los operadores pueden aún ver los niveles del precio que inicialmente ha formado el POC, pero solo como una simple acumulación de precios.  


Puede consultar más información sobre los niveles del precio en el libro de Eric Naiman "Master-trading: The X-Files" (Capítulo 4, "El nivel del precio es una línea base").

  


### **4\. Implementación del histograma del precio en MQL5**  


Mi primera versión del histograma del precio apareció en 2006 y fue escrita en MQL4, en MetaTrader 4, para uso personal. Durante el desarrollo de este indicador me encontré con algunos problemas y algunos de ellos son los siguientes:  




  1. un número muy reducido de barras en el historial para M5, por no hablar de M1;
  2. la necesidad de desarrollar funciones especiales para trabajar con el historial, como retroceder un día teniendo en cuenta las vacaciones, comprobar el momento del cierre del mercado el viernes, comprobar el momento de la apertura y el cierre del mercado de CFD, etc.;
  3. recálculo del indicador al cambiar los periodos de tiempo y, como resultado, los retrasos en el terminal. 



Por tanto, cuando la prueba beta de MetaTrader 5 y MQL5 comenzó, decidí convertirlo a MQL5.  


Como suele decir la gente "la primera tortita es siempre la más difícil", he intentado implementarlo como un indicador.  


Vamos a empezar por lo bueno: la presencia de un largo historial de cotizaciones por minuto para todos los símbolos, la posibilidad de obtener datos históricos durante un cierto periodo de tiempo en cualquier rango temporal.  


Ahora explicaré lo que ha resultado. No he considerado las características de los indicadores de MQL5:  




  1. el tiempo de ejecución del indicador es crítico;
  2. las características del funcionamiento del indicador después del periodo de tiempo cambian.



La ejecución de la función [OnCalculate()](/es/docs/basis/function/events#oncalculate), que se corresponde con el controlador de evento Calculate, tiene un tiempo de ejecución crítico. Por consiguiente, el procesamiento de 260 días (periodo anual) usando el historial de barras de un minuto lleva mucho tiempo, hasta varios minutos. Por supuesto, podemos aceptarlo si los cálculos se realizan de una vez después de que el indicador se adjunte al gráfico. Pero este no es el caso para los cambios en el periodo de tiempo. Cuando el indicador cambia a otro periodo distinto, la copia anterior del indicador se destruye y se crea una nueva. Por esta razón, [después de cambiar el periodo de tiempo](/es/docs/runtime/running) tenemos que recalcular de nuevo los mismos niveles y esto lleva mucho tiempo.  


Pero como se ha dicho, si no sabemos qué hacer debemos "leer la documentación primero", en nuestro caso la [documentación de MQL5](/es/docs). La solución fue muy sencilla: implementar este indicador como asesor experto que no realice transacciones.  


Las ventajas del asesor experto son:




  1. el tiempo de procesado no es crítico para el controlador de evento [Init](/es/docs/runtime/event_fire#init) en OnTick();
  2. la posibilidad de obtener los parámetros del controlador [OnDeinit](/es/docs/runtime/event_fire#deinit) (debido a const int).  




Los asesores expertos son diferentes a los indicadores por lo siguiente: después de cambiar el periodo de tiempo, el asesor experto genera el evento [DeInit](/es/docs/runtime/event_fire#deinit) con el parámetro REASON_CHARTCHANGE, no borra el asesor experto de la memoria y proporciona los valores de las [variables globales](/es/docs/basis/variables/global). Esto nos permite realizar todos los cálculos de una vez después de adjuntar el asesor experto, cambiando sus parámetros y apareciendo nuevos datos, en nuestro caso, para un nuevo día de trading.  


Vamos a presentar algunas definiciones que nos harán falta más tarde.  


La programación orientada a objeto ([POO)](/es/docs/basis/oop) es un estilo de programación cuyos conceptos básicos son los objetos y las clases.  


El objeto es una entidad en el espacio virtual con un estado y comportamiento específico. Tiene algunos valores de las propiedades (llamadas como atributos) y operaciones (llamadas como métodos).  


En la [POO](/es/docs/basis/oop) la clase es un tipo de dato abstracto especial que se caracteriza por su construcción. La clase es un concepto clave en la POO. Se distingue de los demás tipos de datos abstractos. La definición de los datos en la clase también contiene métodos de clase de su procesamiento de datos (interfaz).  


En programación, hay un concepto de interfaz de software que significa un lista de operaciones posibles que pueden ser realizadas por una parte del programa, incluyendo algoritmos, descripción de los argumentos y el orden de los parámetros de entrada y sus valores devueltos. La interfaz de tipos de datos abstractos ha sido desarrollada para la descripción formal de dicha lista. El propio algoritmo y el código encargados de realizar todos estos cálculos no son especificados y son llamados como implementación de la interfaz.  


La creación de la clase es la creación de una estructura con campos y métodos. Toda la clase puede ser considerada como una plantilla para la creación de objetos en forma de instancias de la clase. Las instancias de la clase se crean usando la misma plantilla, por lo que todas ellas tienen los mismos campos y métodos.  


Vamos a empezar...  


El código fuente se encuentra en 4 archivos. El archivo principal es **PriceHistogram.mq5** y los demás archivos son: **ClassExpert.mqh** , **ClassPriceHistogram.mqh** y **ClassProgressBar.mqh**. Los archivos con la extensión .mqh contienen la descripción y los métodos de las clases. Todos los archivos deben estar en el mismo directorio. El mío es: \MQL5\ Experts\PriceHistogram.

  


**4.1. PriceHistogram.mq5**

La primera línea del código fuente es:  

    
    
    #include "ClassExpert.mqh"

La directiva del compilador [#include](/es/docs/basis/preprosessor/include) incluye el texto del archivo especificado. En nuestro caso es la descripción de la clase CExpert (tratada a continuación).  


El siguiente es un bloque de [variables de entrada,](/es/docs/basis/variables/inputvariables) que son los parámetros del asesor experto.  

    
    
    // The block input parameters
    input int         DayTheHistogram   = 10;          // Days for histogram
    input int         DaysForCalculation= 500;         // Days for calculation(-1 all)
    input uint        RangePercent      = 70;          // Percent range
    input color       InnerRange        =Indigo;       // Inner range
    input color       OuterRange        =Magenta;      // Outer range
    input color       ControlPoint      =Orange;       // Point of Control
    input bool        ShowValue         =true;         // Show Values
    

Después de esto se declara la variable ExtExpert (del tipo de clase CExpert).  


A continuación vienen los controladores de evento estándar que se encuentran en los programas MQL5. Los controladores de evento llaman a los métodos correspondientes de la clase CExpert.  


Solo hay un método que realiza algunas operaciones antes de la ejecución de CExpert, el método OnInit():  

    
    
    int OnInit()
      {
    //---
    // We check for symbol synchronization before the start of calculations
       int err=0;
       while(!(bool)SeriesInfoInteger(Symbol(),0,SERIES_SYNCRONIZED) && err<AMOUNT_OF_ATTEMPTS)
         {
          Sleep(500);
          err++;
         }
    // CExpert class initialization
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
    

Cuando escribí la primera versión del asesor experto y la ejecuté, tuve algunos problemas para comprender por qué termina con un error después de que el terminal de cliente se reinicie o cambie un símbolo. Y esto ocurre cuando el terminal de cliente es desconectado o no se ha usado un símbolo durante mucho tiempo.  


Menos mal que los programadores han añadido el compilador a MetaEditor5. Recuerdo un montón de comandos Print() y Comment() utilizados para comprobar los valores de las variables en MetaEditor4. Muchas gracias a los programadores de MetaEditor5.  


En mi caso, todo fue fácil. El experto se inicia antes de la conexión al servidor y de la actualización de los datos históricos. Para resolver este problema tuve que usar [SeriesInfoInteger(Symbol(),0,SERIES_SYNCRONIZED](/es/docs/series/seriesinfointeger), que informa sobre si los datos se han sincronizado o no y el ciclo while(), en caso de ausencia de la conexión se utiliza el error de la variable del contador.  


Una vez que los datos se han sincronizado o que el ciclo se ha completado debido al contador en ausencia de conexión, pasamos los parámetros de entrada de la clase de nuestro experto CExpert y llamamos al método de inicialización de la clase Init ().  


Como puede ver, gracias al concepto de clases en MQL5, nuestro archivo PriceHistogram.mq5 se ha transformado en una simple plantilla y todos los demás procesos están en la clase CExpert declarada en el archivo ClassExpert.mqh.

  


**4.2. ClassExpert.mqh**  


Vamos a ver su descripción.
    
    
    //+------------------------------------------------------------------+
    //|   Class CExpert                                                  |
    //|   Class description                                              |
    //+------------------------------------------------------------------+
    class CExpert
      {
    public:
       int               DaysForCalculation; // Days to calculate (-1 for all)
       int               DayTheHistogram;    // Days for Histogram 
       int               RangePercent;       // Percent range
       color             InnerRange;         // Internal range color
       color             OuterRange;         // Outer range color
       color             ControlPoint;       // Point of Control (POC) Color
       bool              ShowValue;          // Show value
    

La sección pública está abierta y es accesible desde las variables externas. Podrá comprobar que los nombres de las variables coinciden con los nombres de la sección de los parámetros de entrada descrita en PriceHistogram.mq5. No es necesario ya que los parámetros de entrada sean globales. Pero en este caso es un tributo a las buenas costumbres, ya que es aconsejable evitar el uso de variables externas dentro de la clase.
    
    
    private:
       CList             list_object;        // The dynamic list of CObject class instances
       string            name_symbol;        // Symbol name
       int               count_bars;         // Number of daily bars
       bool              event_on;           // Flag of events processing
    

La sección privada está cerrada desde el exterior y es accesible solo desde dentro de la clase. Me gustaría describir la variable list_object de tipo CList, una clase de la librería estándar de MQL5.  La clase CList es una clase dinámica con una lista de instancias de la clase CObject y sus herederas. Usaré esta lista para almacenar las referencias a los elementos de la clase CPriceHistogram, que es heredera de la clase CObject. Vamos a ver los detalles a continuación. La descripción de la clase CList se encuentra en el archivo List.mqh y se incluye usando la directiva del compilador #include <Arrays\List.mqh>.
    
    
    public:
       // Class constructor
                         CExpert();
       // Class destructor
                        ~CExpert(){Deinit(REASON_CHARTCLOSE);}
       // Initialization method
       bool              Init();
       // Deinitialization method
       void              Deinit(const int reason);
       // Method of OnTick processing
       void              OnTick();
       // Method of OnChartEvent() event processing
       void              OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
       // Method of OnTimer() event processing
       void              OnTimer();
    };

La siguiente es una sección de métodos públicos. Como habrá adivinado, estos métodos (funciones) están disponibles fuera de la clase.  


Y finalmente, el corchete con un punto y coma completa la descripción de la clase.  


Vamos a ver en detalle el método de la clase.  


El constructor de la clase es un bloque especial de declaraciones llamado cuando se crea el objeto. El constructor es similar al método pero se diferencia de este en que no tiene explícitamente un cierto tipo de datos devueltos.   


En el lenguaje MQL5 los constructores no pueden tener ningún parámetro de entrada y cada clase debe tener solo un constructor. En nuestro caso el constructor es una inicialización primaria de las variables.  


El destructor es un método de clase especial usado para la deinicialización del objeto (p. ejm. liberar memoria). En el nuestro, al método se le llama como a Deinit (REASON_CHARTCLOSE);

Init() es un método para la inicialización de la clase. Este es el método más importante de la clase CExpert. En él tiene lugar la creación de los objetos del histograma. Por favor, observe los comentarios para conocer los detalles. Pero me gustaría considerar algunos puntos.  


El primero es que para construir un histograma de precio diario necesitamos los datos del tiempo de apertura de los días para proceder. Aquí me gustaría hacer un inciso y llamar su atención acerca de [las características del trabajo con las series de tiempo](/es/docs/series/timeseries_access). Para la solicitud de datos de otros periodos de tiempo necesitamos un tiempo, por lo que las funciones Bars() y CopyTime(), así como otras funciones que trabajan con series de tiempo, no siempre devuelven los datos deseados a partir en la primera llamada.  


Por ello tengo que poner esta función en el bucle do (...) while (), pero para hacerla finita he usado la variable contador.  

    
    
     int err=0;
     do
       {
        // Calculate the number of days which available from the history
        count_bars=Bars(NULL,PERIOD_D1);
        if(DaysForCalculation+1<count_bars)
           count=DaysForCalculation+1;
        else
           count=count_bars;
        if(DaysForCalculation<=0) count=count_bars;
        rates_total=CopyTime(NULL,PERIOD_D1,0,count,day_time_open);
        Sleep(1);
        err++;
       }
     while(rates_total<=0 && err<AMOUNT_OF_ATTEMPTS);
     if(err>=AMOUNT_OF_ATTEMPTS)
       {
       Print("There is no accessible history PERIOD_D1");
       name_symbol=NULL;
       return(false);
       }

En segundo lugar, el historial de minutos de MetaTrader 5 es igual a los días disponibles, por lo que puede llevar mucho tiempo para proceder y es necesario visualizar el proceso de cálculo. Para este propósito se ha desarrollado la clase CProgressBar (#include "ClassProgressBar.mqh"). Esta crea la barra de progreso en la ventana del gráfico y la actualiza durante el proceso de cálculo.
    
    
     // We create the progress bar on the char to shot the loading process
     CProgressBar   *progress=new CProgressBar;
     progress.Create(0,"Loading",0,150,20);
     progress.Text("Calculation:");
     progress.Maximum=rates_total; 

En tercer lugar, en el ciclo, usando la "nueva" declaración creamos el objeto CPriceHistogram y lo configuramos usando sus métodos y lo inicializamos llamando a Init(). Si tiene éxito lo añadimos a la lista list_object, y si no tiene éxito borramos hist_obj usando la declaración de borrado. La descripción de la clase CPriceHistogram será presentada más adelante. Vea los comentarios en el código.  

    
    
     // In this cycle there is creation of object CPriceHistogram
     // its initialization and addition to the list of objects
     for(int i=0;i<rates_total;i++)
       {
        CPriceHistogram  *hist_obj=new CPriceHistogram();
        //         hist_obj.StepHistigram(step);
        // We set the flag to show text labels
        hist_obj.ShowLevel(ShowValue);
        // We set POCs colour
        hist_obj.ColorPOCs(ControlPoint);
        // We set colour for inner range
        hist_obj.ColorInner(InnerRange);
        // We set colour for outer range
        hist_obj.ColorOuter(OuterRange);
        // We set the percent range
        hist_obj.RangePercent(RangePercent);
        //  hist_obj.ShowSecondaryPOCs((i>=rates_total-DayTheHistogram),PeriodSeconds(PERIOD_D1));
        if(hist_obj.Init(day_time_open[i],day_time_open[i]+PeriodSeconds(PERIOD_D1),(i>=rates_total-DayTheHistogram)))
           list_object.Add(hist_obj);
        else
           delete hist_obj; // Delete object if there was an error
        progress.Value(i);
       }; 

OnTick() es un método llamado cuando se recibe un nuevo tick para un símbolo. Si al comparar los valores del número de días almacenados en la variable count_bars con el número de barras diarias devueltas por Bars (Symbol (), PERIOD_D1) estos no son iguales, llamamos forzosamente al método Init () para la inicialización de la clase, vaciando la lista list_object y cambiando la variable a NULL name_symbol. Si el número de días no ha cambiado el bucle pasa por todos los objetos almacenados en la clase CPriceHistogram list_object y ejecuta un método Redraw () para aquellos que son vírgenes ("virgin").  


Deinit() es un método para la inicialización de la clase. En el caso de REASON_PARAMETERS (los parámetros de entrada fueron cambiados por el usuario) vaciamos la lista list_object y establecemos la variable name_symbol a NULL. En los demás casos el experto no hace nada, pero si queremos añadir algo debemos leer los comentarios.  


OnEvent() es un método para procesar eventos del terminal de cliente. Los eventos se generan por el terminal de cliente cuando el usuario trabaja con el gráfico. Los [detalles](/es/docs/runtime/event_fire) se encuentran disponibles en la documentación del lenguaje MQL5. En este asesor experto se ha usado el evento gráfico CHARTEVENT_OBJECT_CLICK. Haciendo clic en el elemento histograma se muestran los niveles secundarios de los POC y se invierte el color del histograma.  


OnTimer(void) es un método para procesar eventos timer. No se usa en mis programas pero si quiere añadir algunas acciones de temporización (por ejemplo, para mostrar el tiempo), aquí lo tiene. Antes de su uso es necesario añadir las siguientes líneas al constructor de la clase:  

    
    
    EventSetTimer(tiempo en segundos);

Y la siguiente línea al destructor:  

    
    
    EventKillTimer(); 

antes de llamar al método Deinit (REASON_CHARTCLOSE).  


Hemos considerado la clase CExpert, creada para mostrar los métodos de la clase CPriceHistogram.

  


**4.3. ClassPriceHistogram.mqh**   

    
    
    //+------------------------------------------------------------------+
    //|   Class CPriceHistogram                                          |
    //|   Class description                                              |
    //+------------------------------------------------------------------+
    class CPriceHistogram : public CObject
      {
    private:
       // Class variables
       double            high_day,low_day;
       bool              Init_passed;      // Flag if the initialization has passed or not
       CChartObjectTrend *POCLine;
       CChartObjectTrend *SecondTopPOCLine,*SecondBottomPOCLine;
       CChartObjectText  *POCLable;
       CList             ListHistogramInner; // list for inner lines storage 
       CList             ListHistogramOuter; // list for outer lines storage
       bool              show_level;         // to show values of level
       bool              virgin;             // is it virgin
       bool              show_second_poc;    // show secondary POC levels
       double            second_poc_top;     // value of the top secondary POC level
       double            second_poc_bottom;  // value of the bottom secondary POC level
       double            poc_value;          // POC level value
       color             poc_color;          // color of POC level
       datetime          poc_start_time;
       datetime          poc_end_time;
       bool              show_histogram;     // show histogram  
       color             inner_color;        // inner color of the histogram
       color             outer_color;        // outer color of the histogram
       uint              range_percent;      // percent range
       datetime          time_start;         // start time for construction
       datetime          time_end;           // final time of construction
    public:
       // Class constructor
                         CPriceHistogram();
       // Class destructor
                        ~CPriceHistogram(){Delete();}
       // Class initialization
       bool              Init(datetime time_open,datetime time_close,bool showhistogram);
       // To level value
       void              ShowLevel(bool show){show_level=show; if(Init_passed) RefreshPOCs();}
       bool              ShowLevel(){return(show_level);}
       // To show histogram
       void              ShowHistogram(bool show);
       bool              ShowHistogram(){return(show_histogram);}
       // To show Secondary POC levels
       void              ShowSecondaryPOCs(bool show){show_second_poc=show;if(Init_passed)RefreshPOCs();}
       bool              ShowSecondaryPOCs(){return(show_second_poc);}
       // To set color of POC levels
       void              ColorPOCs(color col){poc_color=col; if(Init_passed)RefreshPOCs();}
       color             ColorPOCs(){return(poc_color);}
       // To set internal colour of histogram
       void              ColorInner(color col);
       color             ColorInner(){return(inner_color);}
       // To set outer colour of histogram
       void              ColorOuter(color col);
       color             ColorOuter(){return(outer_color);}
       // To set percent range
       void              RangePercent(uint percent){range_percent=percent; if(Init_passed)calculationPOCs();}
       uint              RangePercent(){return(range_percent);}
       // Returns value of virginity of POC level
       bool              VirginPOCs(){return(virgin);}
       // Returns starting time of histogram construction
       datetime          GetStartDateTime(){return(time_start);}
       // Updating of POC levels
       bool              RefreshPOCs();
    private:
       // Calculations of the histogram and POC levels
       bool              calculationPOCs();
       // Class delete
       void              Delete();
      }; 

En la descripción de la clase he intentado proporcionar comentarios para las variables y métodos de la clase. Vamos a ver en detalle algunos de ellos.  

    
    
    //+------------------------------------------------------------------+
    //|   Class initialization                                           |
    //+------------------------------------------------------------------+
    bool CPriceHistogram::Init(datetime time_open,datetime time_close,bool showhistogram) 

Este método utiliza tres parámetros de entrada: la apertura del edificio, el momento del cierre de la construcción y un flag indicando la construcción de un histograma o solo los niveles de POC.  


En mi ejemplo (clase CExpert) los parámetros de entrada se pasan el día de la apertura y en el momento de la apertura del día siguiente day_time_open [i] + PeriodSeconds (PERIOD_D1). Pero cuando usamos esta clase nada evita preguntarnos, por ejemplo, el tiempo de la sesión europea, la americana, o el tamaño de la brecha en la semana, mes, etc.  

    
    
    //+---------------------------------------------------------------------------------------+
    //|   Calculations of the histogram and POCs levels                                       |
    //+---------------------------------------------------------------------------------------+
    bool CPriceHistogram::calculationPOCs() 

En este método, el origen de todos los niveles y los cálculos de su construcción es un método cerrado privado inaccesible desde el exterior.
    
    
    // We get the data from time_start to time_end
       int err=0;
       do
         {
          //--- for each bar we are copying the open time
          rates_time=CopyTime(NULL,PERIOD_M1,time_start,time_end,iTime);
          if(rates_time<0)
             PrintErrorOnCopyFunction("CopyTime",_Symbol,PERIOD_M1,GetLastError());
    
          //--- for each bar we are copying the High prices
          rates_high=CopyHigh(NULL,PERIOD_M1,time_start,time_end,iHigh);
          if(rates_high<0)
             PrintErrorOnCopyFunction("CopyHigh",_Symbol,PERIOD_M1,GetLastError());
    
          //--- for each bar we are copying the Low prices
          rates_total=CopyLow(NULL,PERIOD_M1,time_start,time_end,iLow);
          if(rates_total<0)
             PrintErrorOnCopyFunction("CopyLow",_Symbol,PERIOD_M1,GetLastError());
    
          err++;
         }
       while((rates_time<=0 || (rates_total!=rates_high && rates_total!=rates_time)) && err<AMOUNT_OF_ATTEMPTS&&!IsStopped());
       if(err>=AMOUNT_OF_ATTEMPTS)
         {
          return(false);
         }
       poc_start_time=iTime[0];
       high_day=iHigh[ArrayMaximum(iHigh,0,WHOLE_ARRAY)];
       low_day=iLow[ArrayMinimum(iLow,0,WHOLE_ARRAY)];
       int count=int((high_day-low_day)/_Point)+1;
    // Count of duration of a finding of the price at each level
       int ThicknessOfLevel[];    // create an array for count of ticks
       ArrayResize(ThicknessOfLevel,count);
       ArrayInitialize(ThicknessOfLevel,0);
       for(int i=0;i<rates_total;i++)
         {
          double C=iLow[i];
          while(C<iHigh[i])
            {
             int Index=int((C-low_day)/_Point);
             ThicknessOfLevel[Index]++;
             C+=_Point;
            }
         }
       int MaxLevel=ArrayMaximum(ThicknessOfLevel,0,count);
       poc_value=low_day+_Point*MaxLevel;

Primero obtenemos los datos históicos de las barras de un minuto para un cierto periodo de tiempo (iTime [], iHigh[], iLow[]). A continuación encontramos el elemento máximo y mínimo de iHigh[] and iLow[]. Luego calculamos el número de puntos (recuento) desde el máximo al mínimo e invertimos la matriz ThicknessOfLevel con los elementos ThicknessOfLevel. En el ciclo, pasamos por cada vela de un minuto desde Low a High y añadimos los datos del periodo de tiempo en este nivel de precio. A continuación, encontramos el elemento máximo de la matriz ThicknessOfLevel, que será el nivel al que el precio estuvo durante más tiempo. Este es nuestro nivel de POC.  

    
    
    // Search for the secondary POCs
       int range_min=ThicknessOfLevel[MaxLevel]-ThicknessOfLevel[MaxLevel]*range_percent/100;
       int DownLine=0;
       int UpLine=0;
       for(int i=0;i<count;i++)
         {
          if(ThicknessOfLevel[i]>=range_min)
            {
             DownLine=i;
             break;
            }
         }
       for(int i=count-1;i>0;i--)
         {
          if(ThicknessOfLevel[i]>=range_min)
            {
             UpLine=i;
             break;
            }
         }
       if(DownLine==0)
          DownLine=MaxLevel;
       if(UpLine==0)
          UpLine=MaxLevel;
       second_poc_top=low_day+_Point*UpLine;
       second_poc_bottom=low_day+_Point*DownLine;
    

El siguiente paso es encontrar los niveles secundarios de POC. Recuerde que nuestro diagrama está dividido. Recuerde que nuestro diagrama se divide en dos rangos, el interno y el externo (mostrado en distintos colores) y el rango de tamaño se define por el porcentaje de tiempo del precio en este nivel. El rango de los límites internos son los niveles secundarios de POC.  


Despúes de encontrar los POC secundarios, rango de porcentaje de límites, procedemos con la construcción del histograma.  

    
    
    // Histogram formation 
       if(show_histogram)
         {
          datetime Delta=(iTime[rates_total-1]-iTime[0]-PeriodSeconds(PERIOD_H1))/ThicknessOfLevel[MaxLevel];
          int step=1;
          
          if(count>100)
             step=count/100;  // Calculate the step of the histogram (100 lines as max)
    
          ListHistogramInner.Clear();
          ListHistogramOuter.Clear();
          for(int i=0;i<count;i+=step)
            {
             string name=TimeToString(time_start)+" "+IntegerToString(i);
             double StartY= low_day+_Point*i;
             datetime EndX= iTime[0]+(ThicknessOfLevel[i])*Delta;
    
             CChartObjectTrend *obj=new CChartObjectTrend();
             obj.Create(0,name,0,poc_start_time,StartY,EndX,StartY);
             obj.Background(true);
             if(i>=DownLine && i<=UpLine)
               {
                obj.Color(inner_color);
                ListHistogramInner.Add(obj);
               }
             else
               {
                obj.Color(outer_color);
                ListHistogramOuter.Add(obj);
               }
            }
         }
    
    

Debe mencionarse que para reducir la carga en el terminal llevo a la pantalla un máximo de 100 líneas para cada histograma. Las líneas del histograma se almacenan en dos listas y en ListHistogramInner y ListHistogramOuter que son objetos ya conocidos para nuestra clase CList. Pero estos punteros se almacenan en la clase estándar de objetos CChartObjectTrend. El por qué de dos listas lo puede adivinar a partir del título: para poder cambiar el color del histograma.  

    
    
    // We receive data beginning from the final time of the histogram till current time
       err=0;
       do
         {
          rates_time=CopyTime(NULL,PERIOD_M1,time_end,last_tick.time,iTime);
          rates_high=CopyHigh(NULL,PERIOD_M1,time_end,last_tick.time,iHigh);
          rates_total=CopyLow(NULL,PERIOD_M1,time_end,last_tick.time,iLow);
          err++;
         }
       while((rates_time<=0 || (rates_total!=rates_high && rates_total!=rates_time)) && err<AMOUNT_OF_ATTEMPTS);
    // If there isn't history, the present day, level is virgin, we hoist the colours
       if(rates_time==0)
         {
          virgin=true;
         }
       else
    // Otherwise we check history
         {
          for(index=0;index<rates_total;index++)
             if(poc_value<iHigh[index] && poc_value>iLow[index]) break;
    
          if(index<rates_total)   // If level has crossed
             poc_end_time=iTime[index];
          else
             virgin=true;
         }
       if(POCLine==NULL)
         {     
          POCLine=new CChartObjectTrend();
          POCLine.Create(0,TimeToString(time_start)+" POC ",0,poc_start_time,poc_value,0,0);
         }
       POCLine.Color(poc_color);
       RefreshPOCs();

He intentado diseñar CPriceHistogram con todos los métodos necesarios, aunque si es insuficiente puede añadirlos usted y yo le ayudaré en ello.

### Resumen  


Una vez más, me gustaría recordar que el histograma del precio es fidedigno pero a la vez una herramienta intuitiva, por lo que serán necesarias las señales de confirmación para poder usarlo.  


Gracias por su interés. Estoy listo para responder a sus preguntas.  


Traducción del ruso hecha por MetaQuotes Ltd.   
Artículo original: [https://www.mql5.com/ru/articles/17](/ru/articles/17)

**Archivos adjuntos** | 

[ __Descargar ZIP](/es/articles/download/17.zip "Descargar todos los anexos a un archivo único ZIP")

[__classexpert.mqh](/es/articles/download/17/classexpert.mqh "Descargar classexpert.mqh") (9.44 KB)

[__classprogressbar.mqh](/es/articles/download/17/classprogressbar.mqh "Descargar classprogressbar.mqh") (3.75 KB)

[__pricehistogram.mq5](/es/articles/download/17/pricehistogram.mq5 "Descargar pricehistogram.mq5") (3.63 KB)

[__colorprogressbar.mqh](/es/articles/download/17/colorprogressbar.mqh "Descargar colorprogressbar.mqh") (4.89 KB)

[__classpricehistogram.mqh](/es/articles/download/17/classpricehistogram.mqh "Descargar classpricehistogram.mqh") (16.07 KB)

**Advertencia:** todos los derechos de estos materiales pertenecen a MetaQuotes Ltd. Queda totalmente prohibido el copiado total o parcial.

Este artículo ha sido escrito por un usuario del sitio web y refleja su punto de vista personal. MetaQuotes Ltd. no se responsabiliza de la exactitud de la información ofrecida, ni de las posibles consecuencias del uso de las soluciones, estrategias o recomendaciones descritas.

![Dmitry Voronkov](https://c.mql5.com/avatar/2010/3/4B9E6DA0-951C_big.jpg)

[Dmitry Voronkov](/es/users/vdv2001 "Dmitry Voronkov")

  * __[Ucrania](https://www.mql5.com/go?https://maps.google.com/?z=4&q=Ucrania "Vive")
  * __[13026](/es/users/vdv2001/achievements "Ranking")



#### Otros artículos del autor

  * [Análisis de los patrones de velas](/es/articles/101)
  * [Un Ejemplo de Sistema de Trading Basado en un Indicador Heikin-Ashi](/es/articles/91)



**Últimos comentarios |[Pasar a la discusión en el foro de los operadores](/es/forum/18424) ** (103) 

![Ryan L Johnson](https://c.mql5.com/avatar/2025/5/68239006-fc9d.png)

**[Ryan L Johnson](/es/users/rjo)** | 5 abr 2023 en 19:38

Sólo un aviso... He descargado todos los archivos a sus directorios correspondientes, compilado, y recibió errores en relación con ClassPriceHistogram.mqh. En la línea 375 en el mismo, simplemente reemplazado 
    
    
    CPriceHistogram::Delete()

con
    
    
    void CPriceHistogram::Delete()

Ahora funciona bien en AMP Futures' MT5 Version 5.00 Build 3661.

@Oleksandr, este "indicador" es técnicamente un Experto. Los [buffers de indicadores](https://www.mql5.com/es/articles/180 "Artículo: Promedio de series de precios para cálculos intermedios sin utilizar buffers adicionales ") no están disponibles en Expertos. Los buffers pueden ser recreados efectivamente usando arrays en Expertos pero solo los buffers de indicadores reales pueden ser llamados por iCustom así que para ese propósito, un nuevo indicador personalizado tendría que ser codificado desde cero. Desafortunadamente, ambas opciones están más allá de mi nivel de capacidad de codificación. Buena suerte en la búsqueda de una ayuda mejor.

![O_M_333](https://c.mql5.com/avatar/avatar_na2.png)

**[O_M_333](/es/users/orelmely)** | 13 abr 2023 en 17:52

¿hay alguna manera de trazar la seesion actual?  
  
  
GRACIAS 

![O_M_333](https://c.mql5.com/avatar/avatar_na2.png)

**[O_M_333](/es/users/orelmely)** | 13 abr 2023 en 18:23

hola he probado a cambiar las lineas de tu comentario , pero sigue sin funcionar , no puedo ver el [perfil de](https://www.metatrader5.com/es/metaeditor/help/development/profiling "Guía del usuario de MetaEditor: Perfiles de código") volumen de la sesion actual  
  
GRACIAS 

![O_M_333](https://c.mql5.com/avatar/avatar_na2.png)

**[O_M_333](/es/users/orelmely)** | 19 abr 2023 en 14:34

**apirakkamjan[#](/en/forum/414/page3#comment_11953750):**  


### _¡¡Quieres ver algo guay!!  
_

File classexpert.mqh Line 104 :: change** >= ** back  to  **< **

hola señor...  
  
No funciona en mi lado.

¿Me pueden ayudar?  
  
GRACIAS 

![Ryan L Johnson](https://c.mql5.com/avatar/2025/5/68239006-fc9d.png)

**[Ryan L Johnson](/es/users/rjo)** | 22 oct 2023 en 18:59

**JHawk[#](/en/forum/414/page5#comment_41420407):**  


Lo que tengo aquí para usted y la comunidad es una actualización, por lo que el histograma utiliza el tickvolume ...

¡Bien hecho! Supongo que usas tickvolume para operar con CFDs sobre S&P 500. Podría tener un ir en la sustitución de tickvolume con realvolume porque voy a estar negociando S & P 500 futuros sobre la CME centralizada.

@ [O_M_333](/en/users/orelmely), te he enviado un mensaje privado.

![Cómo intercambiar datos: una DLL para MQL5 en 10 minutos.](https://c.mql5.com/2/0/mql5_dll_sample__1.png) [Cómo intercambiar datos: una DLL para MQL5 en 10 minutos.](/es/articles/18)

No hay muchos programadores que recuerden cómo escribir una simple DLL y cuáles son las características especiales de los distintos tipos de vinculación del sistema. Usando varios ejemplos intentaré mostrar todo el proceso de creación de la DLL en 10 minutos, así como discutir algunos aspectos técnicos de nuestra implementación de la vinculación. Mostraré el proceso paso a paso de la creación de la DLL en Visual Studio con ejemplos de intercambio de distintos tipos de variables (números, matrices, strings, etc.). Además, explicaré cómo proteger su terminal de cliente de errores fatales con las DLL personalizadas.

![Indicadores William Blau y sistemas de trading en MQL5. Parte 1: indicadores](https://c.mql5.com/2/0/MQL5_Willam_Blau_1.png) [Indicadores William Blau y sistemas de trading en MQL5. Parte 1: indicadores](/es/articles/190)

Este artículo trata sobre los indicadores descritos en el libro de William Blau "Momentum, Direction, y Divergence". El enfoque de William Blau nos permite, con rapidez y precisión, hacer una aproximación sobre las fluctuaciones de la curva de precios para determinar la tendencia del movimiento de precios y los puntos de cambio, eliminando el ruido de fondo en los precios. Mientras tanto, también podemos detectar los estados de sobrecompra/sobreventa del mercado y las señales, que indican el final de una tendencia y el cambio de dirección en los precios.

![Intercambio de datos entre indicadores. Es fácil](https://c.mql5.com/2/0/v5__1.png) [Intercambio de datos entre indicadores. Es fácil](/es/articles/19)

Queremos crear un entorno que proporcione acceso a los datos de los indicadores adjuntos a un gráfico y que tenga las siguientes propiedades: ausencia de copiado de datos; modificación mínima del código de métodos disponibles si necesitamos usarlo; es preferible el código de MQL (por supuesto, tenemos que usar DLL pero usaremos una docena de strings de código de C++). El artículo describe un método sencillo para desarrollar un entorno de programa para el terminal de MetaTrader que proporcione medios para acceder a los buffers del indicador desde otros programas MQL.

![Promediación de series de precio para cálculos intermedios sin usar buffers adicionales](https://c.mql5.com/2/0/averages_MQL5__1.png) [Promediación de series de precio para cálculos intermedios sin usar buffers adicionales](/es/articles/180)

Este artículo trata sobre los algoritmos tradicionales y otros menos habituales utlizados para la promediación en clases simples y de tipo único. Tienen por finalidad un uso universal en casi todos los desarrollos de indicadores. Espero que las clases que se proponen sean una buena alternativa a las "voluminosas" llamadas de los indicadores técnicos y personalizados.

![MQL5 - Lenguaje de estrategias comerciales para el terminal de cliente MetaTrader 5](https://c.mql5.com/i/registerlandings/logo-2.png)

Está perdiendo oportunidades comerciales:

  * Aplicaciones de trading gratuitas
  * 8 000+ señales para copiar
  * Noticias económicas para analizar los mercados financieros



Registro Entrada

  * [Iniciar sesión con Google](https://www.mql5.com/es/auth_oauth2?provider=Google&amp;return=popup&amp;reg=1)



Usted acepta [la política del sitio web](/es/about/privacy) y [ las condiciones de uso](/es/about/terms)

Si no tiene cuenta de usuario, [regístrese](https://www.mql5.com/es/auth_register)

Para iniciar sesión y usar el sitio web MQL5.com es necesario permitir el uso de Сookies.

Por favor, active este ajuste en su navegador, de lo contrario, no podrá iniciar sesión.

  * [Iniciar sesión con Google](https://www.mql5.com/es/auth_oauth2?provider=Google&amp;return=popup)


