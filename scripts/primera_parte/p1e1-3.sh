#!/usr/bin/env bash
function cantidad:() {
echo $#
}
function archivos:() {
argArray=( $*)
arrsort=( $(
  for el in "${argArray[@]}";do
    echo "$el"
  done | sort) )
echo ${arrsort[@]}
}

array=( $( find -type d -executable ) )

cantidad: ${array[@]}
archivos: ${array[@]}
