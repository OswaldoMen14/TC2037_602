# Análisis de Tiempos de Ejecución y Complejidad del Código del resaltador de sintaxis de Python
#### Dulce Daniela García Ruíz A01748013
#### Oswaldo Ilhuicatzi Mendizábal A01781988



En el siguiente reporte se presenta el análisis sobre los tiempos de ejecución, así como su complejidad de los algoritmos de la solución planteada. El código se encuentra dentro del módulo `PythonLexer`, está escrito en el lenguaje funcional Elixir y se utiliza para resaltar la sintaxis de Python en un archivo y generar un archivo HTML de salida.

## Código Fuente

```elixir
defmodule PythonLexer do
  # ... (código adjunto en el repositorio de github)
end

PythonLexer.highlight_syntax("test_two.py")
# En esta línea se cambian los archivos de Python a resaltar.
#Asimismo, es en esta función en donde se debe poner el archivo que se desea resaltar con su 
#nombre correspondiente.  
```

## Análisis

El código se divide en tres partes principales: la función `highlight_syntax`, la función `tokenize` y la función `generate_html`. Así, se analizarán cada una de estas partes de manera individual: 

### highlight_syntax

La función `highlight_syntax` es la función principal, se encarga de llamar a `tokenize` y a`generate_html`,de esta manera, realiza las operaciones de lectura y escritura de los documentos de prueba elaborados en Python. 

- Tiempo de ejecución: El tiempo de ejecución de esta función está determinado por la lectura del archivo, el tiempo de "tokenización" (separar cada segmento del código en _tokens_) y el tiempo de generación del HTML. Primero que nada, el tiempo de lectura de un archivo puede ser proporcional al su tamaño, mientras que el tiempo de "tokenización" y generación de HTML dependerá del número de caracteres que haya, así como los _tokens_ generados. Por lo tanto, el tiempo de ejecución total puede variar según el tamaño del archivo de entrada y la complejidad de su sintaxis.
- Complejidad: La complejidad de esta función se puede considerar lineal - _O(n)_ - en relación al tamaño del archivo de entrada y el número de tokens generados.

### tokenize

La función `tokenize` se encarga de dividir el contenido del archivo en _tokens_ y categorizarlos según las expresiones regulares proporcionadas.

- Tiempo de ejecución: El tiempo de ejecución de esta función está determinado por el número de caracteres en el archivo y el número de tokens generados. La función utiliza una llamada a `Enum.reduce` para recorrer los tokens y aplicar expresiones regulares. Por lo tanto, el tiempo de ejecución dependerá del tamaño del archivo y la complejidad de la sintaxis que presenta.
- Complejidad: La complejidad de esta función puede considerarse lineal - _O(n)_ - en relación al número de caracteres en el archivo y el número de tokens generados. 

### generate_html

La función `generate_html` se encarga de generar una representación HTML de los tokens categorizados y colorearlos de acuerdo al CSS generado.

- Tiempo de ejecución: El tiempo de ejecución de esta función está determinado por el número de tokens y la longitud total de los tokens. La función utiliza una llamada a `Enum.map` para procesar cada token y realizar la concatenación de las cadenas de texto. Por lo tanto, el tiempo de ejecución dependerá del número de tokens y la longitud total de los tokens encontrados en cada uno de los archivos de prueba. 
- Complejidad: La complejidad de esta función puede considerarse lineal - _O(n)_ - en relación con el número de tokens y la longitud total de los tokens. 

## Conclusiones

Al finalizar este recorrido y analizando el código, se puede observar lo siguiente:

-El tiempo de ejecución total del código dependerá del tamaño del archivo de entrada y la complejidad de la sintaxis presente en él. La lectura del archivo, la tokenización y la generación de HTML contribuirán al tiempo total de ejecución. De esta manera, podemos expresar la complejidad total del algoritmo de la siguiente manera:
_O(n + m + k * l)_ donde _n_ es la longitud del archivo, _m_ es el número de tokens, _k_ es la cantidad total de tokens encontrados y _l_ la longitud promedio de los tokens. 

Finalmente, el tipo de tecnología que desarrollamos, es decir, un resaltador de sintaxis, tiene consecuencias éticas importantes para la sociedad. Por un lado, permite que la comprensión de los códigos sea mucho más amigable con el usuario desarrollador, pero también puede hacer que la gente dependa demasiado de la tecnología y no logre comprender por sí misma lo que se está haciendo. 