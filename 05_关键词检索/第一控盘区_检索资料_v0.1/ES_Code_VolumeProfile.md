# ES_Code_VolumeProfile

> 来源标题：Descargar gratis el indicador 'Volume Profile' de 'baset84' para MetaTrader 5 en MQL5 Code Base, 2025.12.30
> 来源链接：https://www.mql5.com/es/code/47784
> 下载时间：2026-06-13 02:42:22
> 用途：第一控盘区定义专题补全来源。

---

  * [![](https://c.mql5.com/i/sidebar/mt.svg)MetaTrader 5](/es/code/mt5)
    * [![](https://c.mql5.com/i/sidebar/expert.svg)Asesores Expertos](/es/code/mt5/experts)
    * [![](https://c.mql5.com/i/sidebar/indicator.svg)Indicadores](/es/code/mt5/indicators)
    * [![](https://c.mql5.com/i/sidebar/scripts.svg)Scripts](/es/code/mt5/scripts)
    * [![](https://c.mql5.com/i/sidebar/library.svg)Librerías](/es/code/mt5/libraries)
  * [![](https://c.mql5.com/i/sidebar/mt.svg)MetaTrader 4](/es/code/mt4)
    * [![](https://c.mql5.com/i/sidebar/expert.svg)Asesores Expertos](/es/code/mt4/experts)
    * [![](https://c.mql5.com/i/sidebar/indicator.svg)Indicadores](/es/code/mt4/indicators)
    * [![](https://c.mql5.com/i/sidebar/scripts.svg)Scripts](/es/code/mt4/scripts)
    * [![](https://c.mql5.com/i/sidebar/library.svg)Librerías](/es/code/mt4/libraries)


  * [![](https://c.mql5.com/i/sidebar/storage.svg)Repositorio](/es/code/storage)



__

Mira [cómo descargar](https://youtu.be/rloNyFVtHuA?list=PLltlMLQ7OLeKwyQwC8FhiKwjl9syKhOCK) robots gratis 

__

¡Búscanos en[Facebook](https://www.facebook.com/mql5.community/)!  
Pon "Me gusta" y sigue las noticias

__

¿Es interesante este script?  
Deje un [enlace](/es/code/47784) a él, ¡qué los demás también lo valoren! 

__

¿Le ha gustado el script?  
Evalúe su trabajo en el terminal [MetaTrader 5](https://download.terminal.free/cdn/web/metaquotes.ltd/mt5/mt5setup.exe?utm_source=www.mql5.com&utm_campaign=download)

al bolsillo

![Indicadores](https://c.mql5.com/i/code/indicator.png)

# Volume Profile - indicador para MetaTrader 5

[Mohammad Baset](/es/users/baset84)

![Mohammad Baset](https://c.mql5.com/avatar/2024/1/65930fb1-5225.jpg)

####  [Mohammad Baset](/es/users/baset84)

  * __[Irán](https://www.mql5.com/go?https://maps.google.com/?z=4&q=Ir%c3%a1n "Vive")
  * __[1514](/es/users/baset84/achievements "Ranking")






[ 1 código ](/es/users/baset84/publications) [ 6 comentarios ](/es/users/baset84/publications/all)

|  [Spanish __](javascript:void\(false\);) [English](/en/code/47784) [Русский](/ru/code/47784) [中文](/zh/code/47784) [Deutsch](/de/code/47784) [日本語](/ja/code/47784) [Português](/pt/code/47784) [한국어](/ko/code/47784) [Français](/fr/code/47784) [Italiano](/it/code/47784) [Türkçe](/tr/code/47784)

Visualizaciones: 
    745
Ranking: 
    

(25)
Publicado: 
    30 diciembre 2025, 13:43
Actualizado: 
    29 enero 2026, 13:50
    

[__Volume Profile.mq5](/es/code/download/47784/volume_profile.mq5 "Volume Profile.mq5") (15.55 KB) ver

__[__Descargar ZIP](/es/code/download/47784.zip "Descargar todos los archivos adjuntos en un archivo ZIP") [__Cómo bajar códigos desde MetaEditor](https://www.metatrader5.com/es/metaeditor/help/workspace/toolbox#codebase)

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



     ![MQL5 Freelance](https://c.mql5.com/i/code/icon_freelance.svg) ¿Necesita un robot o indicador basado en este código? Solicítelo en la bolsa freelance  [Pasar a la bolsa](/es/job/new "Pasar a la bolsa")

### ¿Qué es el perfil de volumen?  


La herramienta de perfil de volumen, también conocida como volumen horizontal, ilustra el volumen de transacciones en cada precio dentro de un intervalo de tiempo específico utilizando un gráfico de histograma horizontal. Las barras más largas indican un mayor volumen de transacciones a ese precio, mientras que las barras más cortas representan una menor actividad de transacciones. Los cálculos de este indicador se ejecutan de forma sencilla, lo que permite una ejecución rápida y ligera.

### Cómo utilizar  


Para mostrar el perfil de volumen dentro de un intervalo de tiempo específico, coloque dos líneas verticales que aparecen después de ejecutar el indicador al principio y al final de ese intervalo. Ajustando estas líneas cambiará el perfil de volumen en función del intervalo seleccionado.

  


![captura de pantalla de muestra](https://c.mql5.com/18/175/XAUUSDDaily__5.png)  


**captura de pantalla de ejemplo**

### Ajustes de entrada  


  * **Intervalo de Cálculo** : La suposición detrás de los cálculos de este indicador es que el volumen se distribuye uniformemente a lo largo de la longitud de la vela (desde su mínimo hasta su máximo), lo que puede conducir a resultados menos precisos, especialmente cuando se utilizan rangos de tiempo pequeños (ver Figura 1). Al cambiar esta opción en la sección de entrada, los cálculos pueden basarse en plazos inferiores (por ejemplo, 1 minuto), lo que da lugar a resultados precisos casi comparables a los que se obtienen utilizando datos de ticks para el cálculo (véase la Figura 2).
  * **Número de barras VP** : El número de barras del histograma, donde los números más pequeños muestran el **rango de precios** donde se han producido la mayoría de las transacciones, y los números más grandes muestran los **precios exactos** donde se han producido la mayoría de las transacciones. Al cambiar esta entrada, la posición del Punto de Control (POC) puede cambiar, pero no se debe a un error en los cálculos o a errores en el código, sino a que está buscando algo diferente.
  * **Volumen aplicado** : El volumen aplicado por defecto es el volumen real. Sin embargo, seleccionando 'tick_volume' en la entrada, o en ausencia de datos de volumen real en el servidor, el indicador utilizará datos de volumen de ticks.



  * **Longitud máxima de la barra VP en relación con el ancho del gráfico** : Puede ajustar la longitud de las barras VP en relación con el ancho de su gráfico.



###   


![figura 1 \(marco temporal actual\)](https://c.mql5.com/18/175/current_tf__3.png)

**figura 1: cálculo basado en el marco temporal actual**

  


![figura 2 \(1 minuto\)](https://c.mql5.com/18/175/1minute_tf__3.png)

**figura 2: cálculo basado en el marco temporal de 1 minuto**

### Precaución  


Cuando se utilizan marcos temporales inferiores para el cálculo, el indicador necesita los datos de precios de ese marco temporal, que pueden no haberse descargado todavía. Puede tardar un poco en descargarse, así que tenga paciencia y arrastre y suelte las líneas verticales hasta que se complete la descarga.

Espero que le ayude a realizar operaciones con éxito y me haga feliz comentando los errores y fallos del código.




Traducción del inglés realizada por MetaQuotes Ltd.   
Artículo original: [https://www.mql5.com/en/code/47784](/en/code/47784)

![Cosine distance and cosine similarity](https://c.mql5.com/i/code/library.png) [Cosine distance and cosine similarity](/es/code/47793)

Calcular la distancia coseno y la semejanza entre 2 vectores . La distancia coseno es 1-coseno_semejanza y la semejanza coseno es el producto punto de dos vectores por sus magnitudes multiplicadas.

![Connect Disconnect Sound Alert](https://c.mql5.com/i/code/expert.png) [Connect Disconnect Sound Alert](/es/code/47846)

Esta utilidad es un simple ejemplo para añadir sonido de alerta en la conexión / desconexión

![COLLECT ALL INDICATORS DATA](https://c.mql5.com/i/code/script.png) [COLLECT ALL INDICATORS DATA](/es/code/47755)

Este Script recoge todos los buffers de indicadores incorporados en MQL5 y los almacena en un archivo CSV para su análisis

![Candle ZigZag](https://c.mql5.com/i/code/indicator.png) [Candle ZigZag](/es/code/47743)

Vela ZigZag es un indicador que cambia su pierna si un cambio de color vela
