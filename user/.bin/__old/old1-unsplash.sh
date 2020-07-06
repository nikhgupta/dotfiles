#!/bin/bash

dir="/usr/share/backgrounds/"

if [ "$1" == "-d" ]; then
	if [ -d $dir ]; then
		arquivo=$(find $dir -type f -name "*.jpg" -o -name "*.png" | shuf -n1)
	else
		echo "$dir não existe."
		exit 1
	fi
else
	which xdpyinfo >/dev/null 2>&1 || { echo >&2 "O programa xdpyinfo não está instalado. Abortando."; exit 1; }
	which file >/dev/null 2>&1 || { echo >&2 "O programa file não está instalado. Abortando."; exit 1; }

	dir="${HOME}/img/wallpapers/unsplash"
	nome="unsplash-$(date +'%Y-%m-%d')"
	rand=$(shuf -i 1000-9999 -n 1)
	x=$(xdpyinfo | awk -F '[ x]+' '/dimensions:/{print $3}')
	y=$(xdpyinfo | awk -F '[ x]+' '/dimensions:/{print $4}')
	
	curl -L -s "https://unsplash.it/${x}/${y}?random" > /tmp/$nome
	ext=$(file /tmp/$nome | awk '{print $2}' | tr '[:upper:]' '[:lower:]')
	
	[ ! -d $dir ] && mkdir -p $dir
	arquivo=$dir/$nome.$ext
	
	while : ; do
		if [ -f $arquivo ]; then
			i=$(($i+1))
			arquivo=$dir/$nome-$i.$ext
			echo "Existe, renomeando para ${arquivo}..."
		else
			break
		fi
	done

	mv /tmp/$nome $arquivo
fi

if [ -f $arquivo ]; then
	if [ "$DESKTOP_SESSION" == "mate" ]
		gsettings set org.mate.background picture-filename "$arquivo"
	elif [ "$DESKTOP_SESSION" == "i3" ]; then
		which feh >/dev/null 2>&1 && { feh --bg-fill "$arquivo"; }
	fi	
fi
