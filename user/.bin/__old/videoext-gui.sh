#!/usr/bin/env bash
#
# Arquivo: videoext-gui.sh
# Descrição: Script usando o YAD e ffmpeg para converter formatos de vídeo.
#
# Feito por Lucas Saliés Brum, a.k.a. sistematico <lucas@archlinux.com.br>
#
# Criado em:        2018-07-22 18:44:41
# Última alteração: 2018-07-23 18:55:20

# ~/.config/Thunar/uca.xml
#<action>
#	<icon>camera-video</icon>
#	<name>Video Ext</name>
#	<unique-id>1528543845224954-1</unique-id>
#	<command>videoext-gui.sh %F</command>
#	<description></description>
#	<patterns>*</patterns>
#	<video-files/>
#</action>

titulo="Video Ext"
extensoes=("mp4" "avi" "mov" "mkv")

command -v yad 1> /dev/null 2> /dev/null
if [ $? = 1 ]; then
	echo "yad não instalado."
	exit
fi

nome() {
    fl=$(basename -- "$1")
    ext="${fl##*.}"
    echo "${fl%.*}.$2.$$.${ext}"
}

exts() {
    fl=$(basename -- "$1")
    ext="${fl##*.}"
    echo "${ext}"
}

if [ "$1" ]; then
    novo=$(dirname "${1}")/$(nome "$1" "cut")
#	nome=$(nome "$1" "novo")

    for e in ${extensoes[@]}; do
        if [ "$e" != "$(exts $1)" ]; then
            ext+="${e}!"
        fi
    done
fi

eval $(yad --title "$titulo" --width=400 --form --field="Arquivo\::SFL" --field="Extensão:CB" --field="Saída:" "$1" "$(echo ${ext%?} | awk '{$1=$1};1')" "$novo" | awk -F'|' '{printf "entrada=\"%s\"\nextensao=%s\nsaida=\"%s\"\n", $1, $2, $3}')
[[ -z $entrada || -z $ext || -z $saida ]] && exit 1

(ffmpeg -i "$entrada" "${saida}.${extensao}"  2>&1 | yad --title "$titulo" --progress --pulsate --auto-close --progress-text "Convertendo...")

if [ $? -eq 0 ]; then
    yad --info --title "$titulo" --text "Video: $(basename ${saida}) cortado com sucesso." --button=gtk-ok:1
else
    yad --error --title "$titulo" --text "Falha no corte de: $(basename ${saida})." --button=gtk-ok:1
fi
