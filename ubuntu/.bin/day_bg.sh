#!/bin/bash

debug=0
dir="${HOME}/img/day2"
hora=`date +%H`
comando="feh --bg-fill"

arquivos=(
    01.png
    02.png
    03.png
    04.png
    05.png
    06.png
    07.png
    08.png
)

max=${#arquivos[@]}

tempo=(
    4
    10
    12
    16
    18
    19
    21
	0
)

# {START..END..INCREMENT}
for i in {7..0..-1}
do 
    if [ $hora -ge ${tempo[i]} ]; 
	then
        $comando $dir/${arquivos[i]}
        [ $debug -eq 1 ] && echo -e "Indice: ${i}\nHora: ${hora}\nNumero de fotos ${#arquivos[@]}\nWallpaper: ${arquivos[i]}"
        exit
    fi
done

$comando $dir/${file[${#arquivos[@]}]}
[ $debug -eq 1 ] && echo -e "Numero de fotos ${#arquivos[@]}\nWallpaper: ${arquivos[i]}"
