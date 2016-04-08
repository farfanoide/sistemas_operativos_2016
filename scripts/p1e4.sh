#!/usr/bin/env bash

hosts="$*"

_get_content_length() {
  local host="$1"

  curl -I --silent $host | grep '^Content-Length' | cut -d ':' -f 2
}

for host in $hosts; do
  echo "${host}: $(_get_content_length $host)"
done

