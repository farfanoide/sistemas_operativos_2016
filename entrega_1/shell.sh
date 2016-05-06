#!/bin/bash

# Globals: -----------------------------------------------------------------{{{

RUTAS="/bin;/usr/bin;/usr/local/bin;$PWD/externalSO"
RED=$(tput setaf 1)
RESET=$(tput sgr0)
PROMPT_COMMAND=whoami
NUESTRO_PROMPT='@$($PROMPT_COMMAND)\>'

# end globals --------------------------------------------------------------}}}
# Helpers: -----------------------------------------------------------------{{{

_first_word() {
    local args="$*"
    echo "${args%% *}"
}

_last_word() {
    local args="$*"
    echo "${args##* }"
}

_remove_first_word() {
    local args="$*" word="$(_first_word $args)"
    echo "${args#$word}"
}

_exists()   { [ -e $1 ] ;}
_readable() { [ -r $1 ] ;}

_check_file() {
    # todo esto no es necesario ya que unix se encarga de hacer estas
    # comprobaciones.
    local file=$1 status=0
    if ! _exists $file; then
        echo 'No such file or directory'; status=1
    elif ! _readable $file; then
        echo 'Permission denied'; status=2
    fi
    return $status
}

_is_builtin()   {
    # Damos prioridad a nuestras funciones y las builtins de bash
    local type=$(type -t $1)
    [ "${type}" = 'function' ] || [ "${type}" = 'builtin' ]
}

_find_command() {
    # buscamos el ejecutable, dandole preferencia a los builtin, devolvemos un
    # codigo de salida para poder usarlo en condicionales
    local command=$1
    local _rutas=($(echo $RUTAS | tr ';' '\n'))
    local dir
    _is_builtin $command && echo $command && return 0

    for (( i = ${#_rutas[*]} - 1; i >= 0; i--  )); do
        dir=${_rutas[$i]}
        [ -x "${dir}/${command}" ] && echo "${dir}/${command}" && return 0
    done

    return 1
}
# end helpers --------------------------------------------------------------}}}
# Builtins: ----------------------------------------------------------------{{{

pwd() {
  command pwd $*
}

mkdir() {
  local dir="$1"
  local args="$(_remove_first_word $*)"

  _find_base_dir() {
      # checkeamos si nos pasaron un path absoluto o relativo.
      [ ! "${dir:0:1}" = '/' ] && dir="$PWD/$dir"

      # buscamos el primer directorio existente
      while ! _exists $dir; do
          dir=$(dirname $dir)
      done
      echo $dir
  }

  if [ $# -eq 0 ] || [ "${dir:0:1}" = '-' ]; then
      echo "Usage: mkdir <DIRECTORY> [options]" && return 1
  fi

  if [ ! -w "$(_find_base_dir $dir)" ]; then
      echo 'No tenés permiso!' && return 1
  fi

  command mkdir $args $dir 2> /dev/null || echo 'Error!, Directorio/s no creado/s' && return 1
}

sl()    { ls -r $* ;}
ls()    {
    local args="$*"
    _octal() { stat -c '%a' "$1" ;}
    _file_details() {
        local permissions=$(_first_word $*)
        local args="$*"
        local file=$(_last_word $*)
        echo "${permissions:0:1}$(_octal $file) $(echo $* | cut -d ' ' -f3-)"
    }
    _list_details() {
        while read -r file; do
            [[ ! "${file}" =~ "total" ]] && _file_details $file
        done
    }

    if [[ "$args" =~ '-l' ]]; then
        args=${args/-l}
        command ls -l $args | _list_details
    else
        command ls -1 $args
    fi
}

cat() {
    local file=$1
    _check_file $file || return $?
    while read line; do
        echo -e $line
    done < $file
}

tac() {
    local file=$1
    _check_file $file || return $?
    local file_length=$(cat $file | wc -l)

    for (( line = $file_length; line > 0; line-- )); do
        sed -n "${line}p" $file
    done
}

_get_uid() { id -u $(whoami) ;}

_echo_prompt() {
    eval "echo $NUESTRO_PROMPT"
}

prompt() {
  if [ $# -eq 0 ]; then
    export PROMPT_COMMAND=whoami
  else
    [ "$1" = 'largo' ] && export PROMPT_COMMAND="quiensoy --prompt"
    [ "$1" = 'uid' ] && export PROMPT_COMMAND="_get_uid"
  fi
}

quiensoy() {
    local quiensoy="Yo soy $(whoami)"

    if [ $# -eq 1 ]; then
        [ $1 = '+h' ] && quiensoy="${quiensoy} y estoy en la maquina $(hostname)"
        [ $1 = '+inos' ] && quiensoy="${quiensoy} y tengo UID=$(_get_uid)"
    else
        echo "Cantidad de argumentos incorrecta. Solo es posible recibir uno solo."
    fi

    echo $quiensoy
}
# end builtins -------------------------------------------------------------}}}
# REPL: --------------------------------------------------------------------{{{

while true; do

    read -r -p "$(_echo_prompt) " args

    [ -z "$args" ] && continue # Salteamos la iteracion si no escribieron nada

    comm=$(_first_word $args)        # no hace falta unsetearlas en cada vuelta
    args=$(_remove_first_word $args) # porq las redefinimos de todas formas

    if executable=$(_find_command $comm); then
        # Podemos utilizar eval ya que lo estamos invocando con el path
        # absoluto al ejecutable que queremos utilizar. Para el caso de los
        # builtins es indiferente ya que el lookup por defecto de bash funciona
        # de la forma esperada por la catedra, es decir, si queremos invocar el
        # commando cd bash buscara primero si existe una funcion con ese
        # nombre y sino buscara una builtin.
        # Esto nos permite utilizar redireccionamientos en los comandos
        eval "${executable} ${args}"
    else
        echo "${RED}No encontre el comando ${RESET}"
    fi
done
# end repl -----------------------------------------------------------------}}}

# vi: fdm=marker
