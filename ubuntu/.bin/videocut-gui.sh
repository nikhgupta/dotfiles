#!/usr/bin/env bash
#
# Arquivo: videocut-gui.sh
# Descrição: Script usando o YAD e ffmpeg para cortar arquivos de vídeo.
#
# Feito por Lucas Saliés Brum, a.k.a. sistematico <lucas@archlinux.com.br>
#
# Criado em:        2018-06-09 19:39:27
# Última alteração: 2018-07-22 21:08:43

# ~/.config/Thunar/uca.xml
#<action>
#	<icon>camera-video</icon>
#	<name>VideoCut</name>
#	<unique-id>1528543845224954-1</unique-id>
#	<command>videocut-gui.sh %F</command>
#	<description></description>
#	<patterns>*</patterns>
#	<video-files/>
#</action>

titulo="Video Cut"

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

function show_time () {
    num=$(LC_ALL=C; echo $(printf '%.*f\n' 0 "$1"))
    min=0
    hour=0
    day=0
    if ((num>59)); then
        ((sec=num%60))
        ((num=num/60))
        if((num>59));then
            ((min=num%60))
            ((num=num/60))
            if((num>23));then
                ((hour=num%24))
                ((day=num/24))
            else
                ((hour=num))
            fi
        else
            ((min=num))
        fi
    else
        ((sec=num))
    fi

	[[ ${#hour} -lt 2 ]] && hour="0$hour"
	[[ ${#min} -lt 2 ]] && min="0$min"
	[[ ${#sec} -lt 2 ]] && sec="0$sec"

    echo "${hour}:${min}:${sec}"
}

if [ "$1" ]; then
    novo=$(dirname "${1}")/$(nome "$1" "cut")
	t=$(ffprobe -i "$1" -show_entries format=duration -v quiet -of csv="p=0")
	total="$(show_time $t)"
	nome=$(nome "$1" "novo")
else
	total="00:00:00"
fi

eval $(yad --title "$titulo" --width=400 --form --field="Arquivo\::SFL" --field="Início:" --field="Fim:" --field="Saída:" "$1" "00:00:00" "$total" "$novo" | awk -F'|' '{printf "entrada=\"%s\"\ninicio=%s\nfim=%s\nsaida=\"%s\"\n", $1, $2, $3, $4}')
[[ -z $entrada || -z $inicio || -z $fim || -z $saida ]] && exit 1

DIFF=$(($(date +%s --date="$fim")-$(date +%s --date="$inicio")))
offset="$(show_time $DIFF)"

(ffmpeg -ss "$inicio" -t "$offset" -i "$entrada" "$saida"  2>&1 | yad --title "$titulo" --progress --pulsate --auto-close --progress-text "Convertendo...")

if [ $? -eq 0 ]; then
    yad --info --title "$titulo" --text "Video: $(basename ${saida}) cortado com sucesso." --button=gtk-ok:1
else
    yad --error --title "$titulo" --text "Falha no corte de: $(basename ${saida})." --button=gtk-ok:1
fi
