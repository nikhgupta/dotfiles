#!/usr/bin/env bash

clear

# Define as cores
vermelho="\e[31m"
verde="\e[32m"
amarelo="\e[33m"
ciano="\e[36m"
azul="\e[34m"
roxo="\e[35m"
roxo2="\e[35;1m"
rst="\e[0m"

cor-echo() {  # imprime as as cores
  echo -e " $vermelho$1: $rst$2"
}

kernel() {
  cor-echo 'KL' "$(uname -r | awk -F'-' '{print $1}')"
}

uptime () {
  up=$(</proc/uptime)
  up=${up//.*}                # string antes de . os segundos
  dias=$((${up}/86400))       # segundos dividido por 86400 são os dias
  horas=$((${up}/3600%24))    # segundos dividido por 3600 % 24 são as horas
  minutos=$((${up}/60%60))       # segundos dividido por 60 % 60 são os minutos
  cor-echo "UP" $dias'd '$horas'h '$minutos'm'
}

shell () {
  shell=$(basename $(echo $SHELL))
  cor-echo 'SH' "$shell"
}

terminal () {
	cor-echo 'TR' $TERMINAL
}

cpu () {
  arm=$(grep ARM /proc/cpuinfo)    # ARM procinfo uses different format
  if [[ "$arm" != "" ]]; then
    cpu=$(grep -m1 -i 'Processor' /proc/cpuinfo | awk -F ' ' '{print $1 $2 $3}')
  else
    cpu=$(grep -m1 -i 'model name' /proc/cpuinfo | awk '{print $6}')
  fi
  cor-echo 'CP' "${cpu#*: }" # everything after colon is processor name
}

gpu () {
  gpu=$(/usr/sbin/lspci | grep VGA | awk -F ': ' '{print $2}' | sed 's/(rev ..)//g')
  cor-echo 'GP' "$gpu"
}

pacotes () {
  packages=$(pacman -Qqs| wc -l)
  cor-echo 'PK' "$packages"
}

wm () {
	if [ -z $DESKTOP_SESSION ]; then
		WM="i3-gaps"
	else
		WM=$DESKTOP_SESSION
	fi
	cor-echo 'WM' $WM
}

distro () {
  [[ -e /etc/os-release ]] && source /etc/os-release
  if [[ -n "$NAME" ]]; then
    cor-echo 'OS' "$NAME"
  else
    cor-echo 'OS' "not found"
  fi
}

cores () {
	for BG in 40m 41m 42m 43m 44m 45m 46m 47m; do
		cor=$(echo -en "\033[$BG  \033[0m")
		cores=$cores$cor
	done
	echo -ne " ${vermelho}CR: $cores"
}

echo
echo -en "                  |  " && cpu
echo -en "  █▀▀▀▀▀▀▀▀▀▀▀█   |  " && distro
echo -en "  █           █   |  " && wm
echo -en "  █           █   |  " && uptime
echo -en "  █   █   █   █   |  " && shell
echo -en "  █           █   |  " && terminal
echo -en "  ▀█▄▄▄▄▄▄▄▄▄█▀   |  " && kernel
echo -en "                  |  " && pacotes
echo -en "                  |  " && cores
echo
#sleep 10
