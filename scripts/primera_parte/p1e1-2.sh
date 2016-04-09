#!/usr/bin/env bash
if [ $# -gt 0 ]; then

  while true;do

    ps | grep $1 | wc -l
    sleep 15

  done

else

  echo 'Ingrese un Nombre de un proceso como Parametro'

fi
