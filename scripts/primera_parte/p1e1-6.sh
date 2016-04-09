#!/usr/bin/env bash
fileArray=$( find ~/ -maxdepth 1 -type f | cut -d/ -f4 )
echo ${fileArray[@]}
rm -r ~/backup
mkdir ~/backup
for file in ${fileArray[@]};do
  cp ~/$file ~/backup/$(echo $file | tr 'abcdefghijklmnopqrstuvwxyz' 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')
done

