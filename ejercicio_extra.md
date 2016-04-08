Ejercicio extra
===============

Al ejecutar este script:

```bash
#!/bin/bash

# Este ejemplo muestra el comportamiento del alcance de las variables con
# subshells de por medio.

i=0
function f1() {
    let i++
    echo "In f1, SUBSHELL: $BASH_SUBSHELL, i=$i" >&2
}

f1
f1 | f1 | f1

echo "at end, i=$i"
```

Se obtiene la siguiente salida:

```
In f1, SUBSHELL: 0, i=1

In f1, SUBSHELL: 1, i=2

In f1, SUBSHELL: 1, i=2

In f1, SUBSHELL: 1, i=2

at end, i=1
```

Preguntas:

1. ¿Por qué el valor de "i" es "1" y por qué es "2" en determinados casos?

  > Luego de la primer invocacion a `f1` el valor de `i` queda en 1, ahora
  > bien, las subsequentes llamadas son realizadas dentro de la expresion de
  > pipes lo cual genera (concurrentemente) nuevas subshells que heredan el
  > entorno original del script y la modificacion que hacen sobre dicha
  > variable no es propagada al entorno de la shell padre

2. ¿Por qué el valor de "SUBSHELL" es "0" y por qué es "1" en determinados casos?

  > Por lo Mencionado anteriormente, se invocan 3 subshells para ejecutar la
  > sentencia: `f1 | f1 | f1`

3. ¿Por qué dentro de la función "f1" existe ">&2"?

  > Porque sino no se leeria el output de las primeras dos invocaciones dentro
  > de la sentencia de pipes. esta ahi para forzar la salida a `stderr` y asi
  > poder leerla.

