#!/usr/bin/env bash
#
# Arquivo: videoresize-gui.sh
# Descrição: Script usando o YAD e ffmpeg para redimensionar arquivos de vídeo.
#
# Feito por Lucas Saliés Brum, a.k.a. sistematico <lucas@archlinux.com.br>
#
# Criado em:        2018-06-09 19:39:27
# Última alteração: 2018-07-28 15:59:04

titulo="Video Resize"

#    4:3 aspect ratio resolutions: 640×480, 800×600, 960×720, 1024×768, 1280×960, 1400×1050, 1440×1080 , 1600×1200, 1856×1392, 1920×1440, and 2048×1536.
#    16:10 aspect ratio resolutions: - 1280×800, 1440×900, 1680×1050, 1920×1200 and 2560×1600.
#    16:9 aspect ratio resolutions: 1024×576, 1152×648, 1280×720, 1366×768, 1600×900, 1920×1080, 2560×1440 and 3840×2160.
resolucoes=("2560" "1920" "1680" "1440" "1280" "1080" "720" "640" "480" "320")

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

caminho() {
    echo $(dirname "${1}")
}

#echo "$(echo "${res}" | awk '{$1=$1};1')"
video=$(yad --title "$titulo" --separator=" " --width=400 --form --field="Arquivo:SFL" "$1" | awk '{$1=$1};1')
[[ -z $video ]] && exit 1

novo=$(dirname "${video}")/$(nome "$video" "resize")
largura=$(ffprobe -v quiet -show_format -show_streams "${video}" | grep '^width' | cut -d "=" -f 2)
altura=$(ffprobe -v quiet -show_format -show_streams "${video}" | grep '^height' | cut -d "=" -f 2)

for r in ${resolucoes[@]}; do
    if [ $r -lt $largura ]; then
        res+="${r}!"
    fi
done

resolucao=$(yad --form --width=400 --separator="!" --title "$titulo" --image=gnome-shutdown --button="gtk-close:1" --button="gtk-ok:0" --field="Arquivo:SFL" --field="Resolução:CB" "$novo" "$(echo ${res%?} | awk '{$1=$1};1')")
[[ -z $resolucao ]] && exit 1

saida=$(echo $resolucao | awk -F'!' '{printf "%s", $1}')
resolucao=$(echo $resolucao | awk -F'!' '{printf "%s", $2}')

# -vf "scale=iw/2:ih/2"
(ffmpeg -i "${video}" -filter:v scale=$resolucao:-1 -c:a copy "${saida}" 2>&1 | yad --title "$titulo" --progress --pulsate --auto-close --progress-text "Convertendo...")


if [ $? = 0 ]; then
	yad --info --title "$titulo" --text "Video: $saida redimensionado com sucesso." --button=gtk-ok:1
else
	yad --error --title "$titulo" --text "Falha no redimensionamento de: ${saida}." --button=gtk-ok:1
fi


