#!/bin/bash

# Globals: -----------------------------------------------------------------{{{

RUTAS="/bin;/usr/bin;/usr/local/bin"
RED=$(tput setaf 1)
RESET=$(tput sgr0)
PROMPT_COMMAND=whoami
IDIOTIC_PROMPT='@$($PROMPT_COMMAND)\>'

# end globals --------------------------------------------------------------}}}
# Helpers: -----------------------------------------------------------------{{{

_first_word() { echo "$*" | cut -d ' ' -f 1 ;}

_remove_first_word() {
    local args="$*" word="$(_first_word $args)"
    echo "${args/$word}" # borrar la primera ocurrencia de $word dentro de $var
}

_check_file() {
    # tecnicamente esta funcion no es necesaria ya que bash hace todo esto por
    # nosotros, de la misma manera q las funciones locales solo estan para hacer
    # mas legibles los condicionales
    local file=$1 status=0
    _exists()   { [ -e $1 ] ;}
    _readable() { [ -r $1 ] ;}

    if ! _exists $file; then
        echo 'No such file or directory'; status=1
    elif ! _readable $file; then
        echo 'Permission denied'; status=2
    fi
    return $status
}

_is_builtin()   {
    # Con solo preguntar por 'function' nos alcanza, pero sino incorporamos las
    # 'builtin' la shell va a ser medio inutil, ej: no tenemos siquiera el
    # comando 'cd' disponible

    local type=$(type -t $1)
    [ "${type}" = 'function' ] || [ "${type}" = 'builtin' ]
}

_find_command() {
    # _split_path()   { echo $RUTAS | tr ';' '\n' ;}
    # buscamos el ejecutable, dandole preferencia a los builtin, devolvemos un
    # codigo de salida para poder usarlo en condicionales
    local command=$1

    _is_builtin $command && echo $command && return 0

    _OLD_IFS=$IFS; IFS='\;'
    for dir in ${RUTAS}; do
        [ -x "${dir}/${command}" ] && echo "${dir}/${command}" && return 0
    done
    IFS=$_OLD_IFS
    return 1
}
# end helpers --------------------------------------------------------------}}}
# Builtins: ----------------------------------------------------------------{{{

pwd()   { command pwd ;} # cant do much more than this :P
mkdir() { command mkdir $* 2> /dev/null || echo "no tenes permisos" ;}
sl()    { command ls -1r ;}
ls()    {
    local args="$*"
    _octal() { stat -c '%a' $(echo $* | cut -d ' ' -f9) ;}
    _file_details() {
        local permissions=$(_first_word $*)
        echo "${permissions:0:1}$(_octal "$*") $(echo $* | cut -d ' ' -f3-)"
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
    eval "echo $IDIOTIC_PROMPT"
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
    args=$(_remove_first_word $args) # porq ya lo hacemos de todas formas

    if executable=$(_find_command $comm); then
        eval "${executable} ${args}"
    else
        echo "${RED}No encontre el comando ${RESET}"
    fi
done
# end repl -----------------------------------------------------------------}}}

# vi: fdm=marker
