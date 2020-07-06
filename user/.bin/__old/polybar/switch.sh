#!/bin/bash

cor=$(awk -F# '/destaque/{print $2;exit}' ${HOME}/.config/polybar/config)
destino=$(basename $(readlink -f ${HOME}/.config/polybar/principal))
cd ${HOME}/.config/polybar/

if [ ${destino} == "clean" ]; then
	s=""
	if [ $1 ]; then
		ln -sf full principal
	fi
else
	s="%{F#${cor}}%{F-}"
	if [ $1 ]; then
		ln -sf clean principal
	fi
fi

echo "${s}"
