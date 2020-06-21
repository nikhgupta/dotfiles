#!/bin/bash
#
# wallpaper.sh - Programa para alterar o papel de parede.
# Funciona no i3, OpenBox e outros.
#
# Criador por Lucas Saliés Brum a.k.a. sistematico, <lucas at archlinux dot com dot br>
#
# Criado em: 17/06/2016 13:13:58
# Última alteração: 05/08/2017 01:07:53

WALL="${HOME}/img/wallpapers/arch-logo/2560x1600/"
#DEFAULT="${HOME}/.wallpaper-default.jpg"
DEFAULT="/usr/share/backgrounds/default"
COR="#1b1b1b"
DIA_PATH="${HOME}/img/modelos"

function uso {
	echo
	echo "Uso: $0 [caminho|imagem]"
	echo "     $0 -rdoc"
	echo "     $0 -day"
	echo
}

if [ ! -f "$DEFAULT" ]; then
	curl https://raw.githubusercontent.com/sistematico/majestic/master/usr/share/backgrounds/default > $DEFAULT
fi

if [ ! -d "$WALL" && ! -f "$WALL" ]; then
	sed -i "s|^\(WALL=\).*|\1\"${DEFAULT}\"|" ${HOME}/bin/wallpaper.sh
	#echo "O diretório $WALL não existe, abortando..."
	#exit 1
fi

if [ "$1" ]; then

	if [ "$1" = "-day" ]; then
		feh --bg-fill \"$(shuf -n1 -e ${DIA_PATH}/$(date +\"%A\")*)\"
	elif [ "$1" = "-r" ]; then
		if [ -f "${HOME}/.wall" ]; then
			WALLPAPER=$(cat ${HOME}/.wall)
		else
			WALLPAPER=$DEFAULT
		fi
	elif [ "$1" = "-d" ]; then
		WALLPAPER=$DEFAULT
	elif [ "$1" = "-o" ]; then
		WALLPAPER=$(cat ${HOME}/.wall)
		viewnior $WALLPAPER
	elif [ "$1" = "-c" ]; then
		hsetroot -solid $COR
	elif [ "$1" != "-r" ] || [ "$1" != "-d" ] || [ "$1" != "-o" ] || [ "$1" != "-c" ] || [ -d "$1" ]; then
		if [ -d "$1" ]; then
			WALLPAPER="$(find "$1" -type f \( -iname \*.jpg -o -iname \*.png -o -iname \*.jpeg \) | shuf -n1)"
		elif [ -f "$1" ]; then
			WALLPAPER=$1
		else
			uso
			exit 0
		fi
	else
		WALL=$(echo $@ | tr ' ' '*')
		WALLPAPER=$(find $WALL -iname "*${WALL}*" | shuf -n1)
	fi
else
	WALLPAPER="$(find $WALL | shuf -n1)"
fi

if [ -f "$WALLPAPER" ]; then
	echo $WALLPAPER > ${HOME}/.wall
fi

if [ "$DESKTOP_SESSION" = "mate" ]; then
	gsettings set org.mate.background picture-filename "$WALLPAPER"
else
	feh --bg-fill "$WALLPAPER"
fi

exit 0
