#!/usr/bin/env bash
#
# unsplash.sh - Script para alterar o papel de parede uma imagem aleatória do site unsplash.com
#
# Desenvolvido por Lucas Saliés Brum <lucas@archlinux.com.br>
#
# Criado em: 20/12/2017 19:27:31 
# Última Atualização: 03/05/2018 17:36:08

which xdpyinfo >/dev/null 2>&1 || { echo >&2 "O programa xdpyinfo não está instalado. Abortando."; exit 1; }
which file >/dev/null 2>&1 || { echo >&2 "O programa file não está instalado. Abortando."; exit 1; }

mask=$(date +'%Y-%m-%d_%H%M%S')
nome="unsplash-${mask}"
dir="${HOME}/img/wallpapers/unsplash"
arquivo="${dir}/${nome}.jpg"
x=$(xdpyinfo | awk -F '[ x]+' '/dimensions:/{print $3}')
y=$(xdpyinfo | awk -F '[ x]+' '/dimensions:/{print $4}')
max=100
clean=1

[ ! -d $dir ] && mkdir -p $dir

if [ "$1" != "--flush" ] && [ $clean == 1 ]; then
if [ $(ls -1 $dir | wc -l) -gt $max ]; then
	echo "Mais que $max"
	echo "Apagando o último: $(ls -Lt1 $dir | tail -1)"
	rm $dir/$(ls -Lt1 $dir | tail -1)
fi
fi

if [ "$1" == "-d" ]; then
	curl -L -s "https://unsplash.it/${x}/${y}?random" > $arquivo
	echo $arquivo > ~/.unsplash
elif [ "$1" == "--random" ]; then
	arquivo=$dir/$(ls -t1 "$dir" | shuf -n1)
	[ -f $arquivo ] && echo $arquivo > ~/.unsplash
elif [ "$1" == "--flush" ]; then
	rm -f $dir/*
else
	if [ -f ~/.unsplash ]; then
		arquivo=$(cat ~/.unsplash)
	fi
fi

if [ -f $arquivo ]; then
	if [ "$DESKTOP_SESSION" == "mate" ]; then 
   		gsettings set org.mate.background picture-filename "$arquivo"
	else
   		which feh >/dev/null 2>&1 && { feh --bg-fill "$arquivo"; }
    fi  
fi
