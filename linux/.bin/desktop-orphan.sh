#!/bin/bash

red="\e[31m"
grn="\e[32m"
ylw="\e[33m"
cyn="\e[36m"
blu="\e[34m"
prp="\e[35m"
bprp="\e[35;1m"
rst="\e[0m"


OIFS="$IFS"
IFS=$'\n'
homedir="${HOME}/.local/share/applications"
sysdir="/usr/share/applications"
todos=($(find $sysdir $homedir -type f | egrep -v "/screensavers/" | egrep .desktop))

function orfao {
	arquivo=$(basename $(cat $1 | grep -m1 -iPo '(?<=Exec=)(.*)' | awk '{print $1}'))
	command -v $arquivo 1> /dev/null 2> /dev/null 
	if [ $? = 1 ]; then 
		arquivo=$(cat $1 | grep -m1 -iPo '(?<=Exec=)(.*)' | awk '{print $1}')
		command -v $arquivo 1> /dev/null 2> /dev/null 
		if [ $? = 1 ]; then 
			echo -e "${ylw}-----------------------------------------------------------------------------"
			echo -e "${prp}O executavel ${blu}$arquivo${prp} não foi encontrado."
			echo -e ${red}$1
		fi
	fi
}

for element in "${todos[@]}"; do
	orfao $element
done

IFS="$OIFS"
