## Primera Parte

1. Relice un script que guarde en el archivo /tmp/usuarios los nombres de los usuarios del
   sistema cuyo UID sea mayor a 1000.

   [solucion: p1e1-1.sh](./scripts/primera_parte/p1e1-1.sh)


2. Implemente un script que reciba como parámetro el nombre de un proceso e informe cada
   15 segundos cuántas instancias de ese proceso están en ejecución.

   [solucion: p1e1-2.sh](./scripts/primera_parte/p1e1-2.sh)


3. Desarrolle un script que guarde en un arreglo todos los archivos del directorio actual (in-
   cluyendo sus subdirectorios) para los cuales el usuario que ejecuta el script tiene permisos
   de ejecución. Luego, implemente las siguientes funciones:
   (a) cantidad: Imprime la cantidad de archivos que se encontraron
   (b) archivos: Imprime los nombres de los archivos encontrados en orden alfabético

   [solucion: p1e1-3.sh](./scripts/primera_parte/p1e1-3.sh)


4. Se le ha encomendado organizar las fotos (en formato jpg) de todos los eventos de los
   que su empresa ha participado en el último año, los cuales se encuentran organizados en
   directorios con el nombre del evento. Para facilitar su búsqueda posterior, los archivos deben
   tener nombres que sigan el siguiente patrón: EVENTO-N.jpg, donde:
   EVENTO es el nombre del evento (el del directorio que se está procesando)
   N es un índice de foto, comenzando en 1
   Realice un script que renombre los archivos de cada subdirectorio del directorio actual
   siguiendo lo especificado en el párrafo anterior.
   Ejemplo: dada la siguiente estructura de archivos y directorios:

   ```
   bashconf15/
    DSC01050.jpg
    DSC01051.jpg
    DSC01052.jpg
    DSC01053.jpg
    DSC01054.jpg
   jsconf−14/
    DSC01230.jpg
    DSC01231.jpg
    DSC01232.jpg
    DSC01235.jpg
    DSC01236.jpg
   oktoberfest−14/
    DSC02229.jpg
    DSC02230.jpg
    DSC02231.jpg
    DSC02232.jpg
   ```

   Se desea terminar con la siguiente estructura luego de ejecutar su script:

   ```
   bashconf15/
    bashconf15−1.jpg
    bashconf15−2.jpg
    bashconf15−3.jpg
    bashconf15−4.jpg
    bashconf15−5.jpg
   jsconf−14/
    jsconf−14−1.jpg
    jsconf−14−2.jpg
    jsconf−14−3.jpg
    jsconf−14−4.jpg
    jsconf−14−5.jpg
   oktoberfest−14/
    oktoberfest−14−1.jpg
    oktoberfest−14−2.jpg
    oktoberfest−14−3.jpg
    oktoberfest−14−4.jpg
   ```
   [solucion: p1e1-4.sh](./scripts/primera_parte/p1e1-4.sh)


5. Escriba un script que liste en orden alfabético inverso el contenido del directorio actual. Es
   decir, si el contenido son los archivos:
   ```
   archivo_1.txt articulo.doc directorio directorio_2 script.sh
   ```
   se espera que el script los liste de la siguiente manera:
   ```
   script.sh directorio_2 directorio articulo.doc archivo_1.txt
   ```

   [solucion: p1e1-5.sh](./scripts/primera_parte/p1e1-5.sh)


6. Realice un script que copie todos los archivos del directorio home del usuario que lo eje-
   cuta, a un subdirectorio del mismo llamado backup cambiándoles el nombre para que esté
   en mayúsculas. No se deben procesar los subdirectorios del home del usuario,
   únicamente los archivos ubicados directamente en este. Si el directorio backup existe al
   iniciar el script, el contenido del mismo debe borrarse antes de copiar los archivos.

   Ejemplo: si el home del usuario actual contiene:

   ```
   /
    home/
     mi_usuario/
      so/
       practica1.pdf
      ejercicios/
       ejercicio−1.sh
      ejercicio−2.sh
       archivo1.txt
      mi−script.sh
      otro_archivo.txt
   ```

   se espera tener lo siguiente luego de la ejecución del script:

   ```
   /
    home/
     mi_usuario/
      backup/
       ARCHIVO1.TXT
       MI−SCRIPT.SH
       OTRO_ARCHIVO.TXT
      so/
       practica1.pdf
       ejercicios/
       ejercicio−1.sh
       ejercicio−2.sh
      archivo1.txt
      mi−script.sh
      otro_archivo.txt
   ```
   
   [solucion: p1e1-6.sh](./scripts/primera_parte/p1e1-6.sh)


7. Un escritor tiene organizados los capítulos de su próximo libro en distintos archivos de
   texto plano en un mismo directorio, y le ha solicitado ayuda para concatenar el contenido
   de cada uno de ellos en un único archivo final llamado libro.txt, de modo tal que éste
   último contenga el texto de todos los otros archivos, uno luego del otro. Puede asumir que
   los archivos de los capítulos tienen nombres alfabéticamente ordenados:

   ```
   capitulo-01.txt,capitulo-02.txt, ..., capitulo-48.txt, por ejemplo.
   ```

   Tip: man cat.

   [solucion: p1e1-7.sh](./scripts/primera_parte/p1e1-7.sh)


## Segunda Parte

1. La herramienta netcat provee una forma sencilla de establecer una conexión
   TCP/IP. En una terminal levante una sesión de netcat en modo servidor, que
   escuche en la IP 127.0.0.1 (localhost) en un puerto a elección. En otra
   terminal conéctese, también vía netcat, al servidor recién levantado.
   Interactúe y experimente con ambas terminales.echo $hosts

  ```console
  # Servidor
  nc -l 0.0.0.0 -p 9090
  ```

  ```console
  # Cliente
  nc 0.0.0.0 9090
  ```

2. netcat también es bueno al momento de transmitir archivos sobre una red
   TCP/IP. Uti- lizando dos terminales como se hizo en el ejercicio anterior,
   transmita el archivo /etc/passwd desde una sesión de netcat hacia la otra.

  > Tip: recordar pipes y redirecciones.

  ```console
  # Servidor
  nc -l 0.0.0.0 -p 9090 > passwd
  ```

  ```console
  # Cliente
  cat /etc/passwd | nc 0.0.0.0 9090
  ```

3. Desarrolle un script que reciba en su entrada estándar una lista de hosts e
   imprima en su salida estándar únicamente aquellos que tienen el puerto 80
   abierto. Cuando un host no tiene el puerto 80 abierto, netcat tardará varios
   segundos en determinar que la conexión no se puede establecer.

   > Tip: utilizar la opción -w de netcat para disminuir el tiempo de timeout.

   [solucion: p1e3.sh](./scripts/p1e3.sh)

4. Desarrolle un script que reciba en su entrada estándar una lista de hosts
   con el puerto 80 abierto y, para cada uno, realice un requerimiento HTTP GET
   a la URI raíz y devuelva el valor del campo Content-Length de la respuesta.
   Deberá ser posible utilizar como entrada estándar la salida estándar del
   script anterior.

   ```console
   echo www.google.com www.debian.org www.linti.unlp.edu.ar | ./cl.sh
   #=>  www.google.com: 262
   #=>  www.debian.org: 470
   #=>  www.linti.unlp.edu.ar: 223
   ```

  > Tip: printf "GET / HTTP/1.0\r\n\r\n"| ...

  [solucion: p1e4.sh](./scripts/p1e4.sh)

5. Interprete y describa qué es lo que hace el siguiente fragmento de código
   extraído de la man page de netcat.

   ```console
   rm −f /tmp/f; mkfifo /tmp/m
   cat /tmp/f | /bin/sh −i 2>&1 | nc −l 127.0.0.1 1234 > /tmp/f
   ```

   > Tip: man mkfifo

