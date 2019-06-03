#!/bin/bash
#
# conkycycle.sh
#

dir="${HOME}/.conky/config"
configs=($dir/*)

link="${HOME}/.conkyrc"
link2=$(readlink $link)
atual=$(basename $link2)
conf=$configs[0]

rm -f $link

echo "Atual: $atual"

for i in "${!configs[@]}"; do
    if [[ "$(basename ${configs[$i]})" = "${atual}" ]]; then
       pos="${i}";
       echo "i $i"
    fi    
done

pos=$((pos+1))

if [[ "$pos" -le ${#configs[@]} ]]; then
    conf=${configs[$pos]}
fi

echo -e "conf: $conf"
ln -s $conf $link
#unset $atual
#unset $readl
#unset $conf

exit 0
#echo -e "config[0]: ${configs[0]}"
#echo ${!configs[@]} # index
#echo ${#configs[@]} # elements 
#echo "${configs[@]}" # total

