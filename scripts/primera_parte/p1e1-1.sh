#!/usr/bin/env bash
users=$(grep 1000 /etc/passwd)

for user in "${users[@]}"; do

  uid=$(echo "$user" | cut -d: -f3)
  echo "$user"

  [ "$uid" = 1000 ] && echo "$user" | cut -d: -f1 > /tmp/usuarios

done
