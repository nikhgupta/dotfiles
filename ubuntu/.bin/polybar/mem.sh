#!/bin/bash

LANG=C
consumo=$(free | awk 'FNR == 2 {print $3/($3+$4)*100}')
saida=$(printf "%.0f" "$consumo")

if [ $saida -lt 10 ]; then
	echo "0${saida}"
else
	echo "${saida}"
fi
