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

