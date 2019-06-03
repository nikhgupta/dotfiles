#!/bin/bash
#
# chwall.sh - Programa para alterar o papel de parede.
# Funciona no i3, OpenBox e outros.
#
# Criador por Lucas Saliés Brum a.k.a. sistematico, <lucas at archlinux dot com dot br>
#
# Criado em: 17-06-2016 13:13:58
# Última alteração: 18-06-2016 04:03:48

PASTA="${HOME}/img/elementary/luna"
IMAGEM="${PASTA_PADRAO}/nuvens.jpg"
MODO="--bg-fill"
FEH=$(which feh)

if [ "$1" ]; then
	if [ "$1" == "-h" ] || [ "$1" == "-H" ] || [ "$1" == "--h" ] || [ "$1" == "--H" ] || [ "$1" == "--help" ]; then
		echo 
		echo "Uso: chwall.sh /pasta/dos/wallpapers/"
		echo "     chwall.sh -drVp"
		echo 
		exit 0
	elif [ "$1" == "-v" ] || [ "$1" == "--v" ] || [ "$1" == "--V" ] || [ "$1" == "--version" ]; then
		echo 
		echo "chwall.sh 0.1b"
		echo 
		echo "Por Lucas Saliés Brum"
		echo
		exit 0		
	elif [ "$1" == "-d" ]; then
		rm -f $(cat ${HOME}/.wallpaper)
	elif [ "$1" == "-r" ]; then
		feh $MODO $(cat ${HOME}/.wallpaper)
	elif [ "$1" == "-V" ]; then
		viewnior $(cat ${HOME}/.wallpaper)
	elif [ "$1" == "-p" ]; then
		feh $MODO $IMAGEM
	else
		WALLPAPER="$(find ${1}|shuf -n1)"
		echo ${WALLPAPER} > ${HOME}/.wallpaper
		sleep 2
		feh $MODO ${WALLPAPER}
	fi
else
	if [ "$WALLPAPERS" ]; then
		echo "Modo sem parametros COM var setada"
		WALLPAPER="$(find ${WALLPAPERS}/ |shuf -n1)"
		echo ${WALLPAPER} > ${HOME}/.wallpaper
		sleep 2
		feh $MODO ${WALLPAPER}
	else 
		echo "Modo sem parametros SEM var setada"
		WALLPAPER="$(find ${PASTA_PADRAO}/ |shuf -n1)"
		echo ${WALLPAPER} > ${HOME}/.wallpaper
		sleep 2
		feh $MODO ${WALLPAPER}
	fi
fi

exit 0

