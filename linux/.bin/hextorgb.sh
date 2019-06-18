#!/bin/sh
#
# hextorgb.sh
# Créditos: https://stackoverflow.com/a/7253786
#

if [ -z $1 ]; then
	echo "Utilize uma cor Hexadecimal como entrada."
	echo "Exemplo: $(basename $0) '#1d1f21'"
	echo
	exit 1
fi

if [[ ${1:0:1} == "#" ]]; then
	hexinput=$(echo "$1" | cut -c 2- | tr "[:lower:]" "[:upper:]")
else
	hexinput=$(echo "$1" | tr "[:lower:]" "[:upper:]")  # uppercase-ing
fi

a=`echo $hexinput | cut -c-2`
b=`echo $hexinput | cut -c3-4`
c=`echo $hexinput | cut -c5-6`

r=`echo "ibase=16; $a" | bc`
g=`echo "ibase=16; $b" | bc`
b=`echo "ibase=16; $c" | bc`


rgba="rgba(${r}, ${g}, ${b}, 0.8)"

echo "$rgba" | xclip -rmlastnl -selection clipboard

echo $rgba

exit 0
