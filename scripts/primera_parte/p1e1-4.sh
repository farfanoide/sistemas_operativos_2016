#!/usr/bin/env bash
arrayDir=$(find -type d)
for dir in ${arrayDir[@]};do
  if [ $dir != . ];then
    arrayFile=$(ls $dir)
    count=1
    for file in ${arrayFile[@]};do
      mv $dir'/'$file $dir'/'$dir"-"$count".jpg"
      count=`expr $count + 1`
    done
  fi  
done
