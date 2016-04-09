#!/usr/bin/env bash
arrayFile=$(find -maxdepth 1 -type f ! -path . | sort )
for file in ${arrayFile[@]}; do
  cat $file >> libro.txt
done
