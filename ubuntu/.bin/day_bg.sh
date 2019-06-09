#!/bin/bash

debug=0
dir="${XDG_WALLPAPER_DIR}/timeshift"
cmd="feh --bg-fill"
hour=`date +%H`

files=(01.png 02.png 03.png 04.png 05.png 06.png 07.png 08.png)
max=${#files[@]}

tempo=(4 10 12 16 18 19 21 23)

# {START..END..INCREMENT}
for i in {7..0..-1}
do
    if [ $hour -ge ${tempo[i]} ];
  then
        $cmd $dir/${files[i]}
        [ $debug -eq 1 ] && echo -e "Index: ${i}\nHour: ${hour}\nNumber of photos ${#files[@]}\nWallpaper: ${files[i]}"
        exit
    fi
done

$cmd $dir/${files[i]}
[ $debug -eq 1 ] && echo -e "Number of photos ${#files[@]}\nWallpaper: ${files[i]}"
