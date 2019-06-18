#!/bin/sh

if [ "$1" == "iniciar" ]; then
	VBoxManage startvm "$2"
elif [ "$1" == "headless" ]; then
	VBoxManage startvm --type headless "$2"
elif [ "$1" == "parar" ]; then
	VBoxManage controlvm "$2" savestate 
else
	echo "Uso: $0 (iniciar|headless|parar)"
	exit 0
fi
