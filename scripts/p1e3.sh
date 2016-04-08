#!/usr/bin/env bash

hosts="$*"

for host in $hosts; do
  netcat -w1 "${host}" 80 && echo $host
done

