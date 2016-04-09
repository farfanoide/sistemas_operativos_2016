#!/usr/bin/env bash
arrayDir=$(find -maxdepth 1 ! -path . -type d)
for dir in ${arrayDir[@]};do
    arrayFile=$(\ls $dir)
    count=1
    for file in ${arrayFile[@]};do
      mv "$dir/$file" "$dir/$dir-$count.jpg"
      count=`expr $count + 1`
    done
done
