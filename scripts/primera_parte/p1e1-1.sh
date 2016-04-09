#!/usr/bin/env bash
array=$(cat /etc/passwd | grep 1000)
for i in "${array[@]}"
do
  uid=$(echo "$i" | cut -d: -f3)
  if [ $uid = 1000 ]; then
    echo "$i" | cut -d: -f1 > /tmp/usuarios
  fi  
done
