#!/usr/bin/env bash
#
# Script para criar screencasts(vídeos da captura de tela) usando o ffmpeg.
#
# Desenvolvido por Lucas Saliés Brum <lucas@archlinux.com.br>
#
# Criado em: 09/06/2017 23:26:41
# Última Atualização: 16/01/2018 01:20:47

preset="ultrafast" # ultrafast,superfast,veryfast,faster,fast,medium,slow,slower,veryslow,placebo
#cor=$(awk -F# '/destaque/{print $2;exit}' ${HOME}/.config/polybar/config)
cor="ffb52a"
lixeira="${HOME}/.local/share/Trash"
icone="/usr/share/icons/Arc/devices/24@2x/video-display.png"

resolucao=$(xrandr | grep '*' | awk 'NR==1{print $1}')
audio=$(pacmd list-sinks | grep -A 1 'index: 0' | awk 'NR==2{print $2}' | awk '{print substr($0,2,length($0)-2)}') # list-sources, list-sinks

if [ -f ~/.config/user-dirs.dirs ]; then
    source ~/.config/user-dirs.dirs
    caminho="${XDG_VIDEOS_DIR}/screencast/"
else
    caminho="${HOME}/video/screencast/"
fi

if [ ! $1 ]; then
    data=$(date +%Y-%m-%d_%H-%M-%S)
    arquivo="${caminho}/screencast-${data}.mp4"
    [ ! -d $caminho ] && mkdir -p $caminho
fi

if pgrep -x "ffmpeg" > /dev/null
then
    [ "$(pgrep -x polybar)" ] && [ "$1" == "status" ] && echo "%{F#${cor}}%{F-}" && exit
    if [ ! $1 ]; then
        killall ffmpeg
        #notify-send -i $icone "ScreenCast" "O vídeo <b>$arquivo</b> foi terminado."
        notify-send -i $icone "ScreenCast" "Video terminated."
        exit 0
    fi
else
    [ "$(pgrep -x polybar)" ] && [ "$1" == "status" ] && echo "" && exit
    if [ ! "$1" ]; then
        #notify-send -i $icone "ScreenCast" "O vídeo <b>$arquivo</b> foi iniciado..."
        notify-send -i $icone "ScreenCast" "Video initiated..."

        #ffmpeg -f x11grab -r 25 -s $resolucao -i :0.0 -f pulse -i default -preset $preset -crf 0 -threads 0 -probesize 10M $arquivo
        #ffmpeg -f x11grab -r 25 -s $resolucao -i :0.0 -f pulse -i default -preset $preset -c:v libx264 -c:a aac -b:a 128k -probesize 50M $arquivo
        #ffmpeg -f x11grab -r 25 -s $resolucao -i :0.0 -f pulse -i default -preset $preset -c:v libx264 -c:a aac -b:a 128k -probesize 50M $arquivo
        #ffmpeg -thread_queue_size 512 -f x11grab -r 30 -s $resolucao -i :0.0 -f pulse -i default -preset $preset -c:v libx264 -c:a aac -b:a 128k $arquivo -probesize 50M
        #ffmpeg -thread_queue_size 512 -f x11grab -r 30 -s $resolucao -i :0.0 -f pulse -ac 2 -i default -preset $preset -c:v libx264 -c:a aac -b:a 128k $arquivo -probesize 50M
        #ffmpeg -thread_queue_size 512 -f x11grab -r 30 -s $resolucao -i :0.0 -f pulse -ac 2 -i default -preset $preset -c:v h264_nvenc -qp 0 -c:a aac -b:a 128k $arquivo -probesize 50M
    	#ffmpeg -f alsa -i pulse -f x11grab -r 25 -s $resolucao -i :0 -c:a aac -c:v libx264 -threads 0 $arquivo -probesize 50M
        #ffmpeg -f x11grab -r 25 -s $resolucao -i :0 -f pulse -ac 2 -i default -preset $preset -c:v libx264 -c:a aac -b:a 128k $arquivo -probesize 50M
        #ffmpeg -f x11grab -r 25 -s $resolucao -i :0 -f pulse -ac 2 -i default -preset $preset -c:v libx264 -c:a aac -b:a 128k $arquivo
        #ffmpeg -y -i screencast-2018-01-15_06-09-22.mp4 -c:v mpeg4 -b:v 600k -c:a libmp3lame output.avi
        #ffmpeg -y -f x11grab -r 25 -s $resolucao -i :0 -f pulse -ac 2 -i default -preset $preset -c:v mpeg4 -b:v 800k -c:a libmp3lame $arquivo
        #ffmpeg -y -f x11grab -s $resolucao -i :0 -f pulse -ac 2 -i default -preset $preset -c:v libx264 -c:a libmp3lame $arquivo
        #ffmpeg -f x11grab -s $resolucao -i :0 -f pulse -ac 2 -i default -preset $preset -c:v libx264 -pix_fmt yuv444p -c:a libmp3lame $arquivo
        #ffmpeg -f x11grab -s $resolucao -i :0 -f pulse -ac 2 -i default -preset $preset -c:v mpeg4 -c:a libmp3lame $arquivo

		#ffmpeg -f x11grab -s $resolucao -i :0 -c:v libx264 -crf 23 -profile:v baseline -level 3.0 -pix_fmt yuv420p -c:a aac -ac 2 -strict experimental -b:a 128k -movflags faststart $arquivo

        ffmpeg -f x11grab -s $resolucao -i :0 -f pulse -ac 2 -i default -c:v libx264 -crf 23 -profile:v baseline -level 3.0 -pix_fmt yuv420p -c:a aac -ac 2 -strict experimental -b:a 128k -movflags faststart $arquivo

    elif [ "$1" == "clear" ]; then
        icone="/usr/share/icons/Arc/places/24@2x/user-trash.png"
        listagem=(${caminho}*)
        if [ ${#listagem[@]} -gt 1 ]; then
            mv ${caminho}* ${lixeira}/files/
            notify-send -i $icone "ScreenCast" "Pasta de screencasts limpa!"
        else
            notify-send -i $icone "ScreenCast" "Pasta de screencasts já está limpa!"
        fi
        exit 0
    fi
fi

#if [ -f $arquivo ]; then
#    xclip -selection c -t 'video/mp4' -i $arquivo
#    exit 0
#fi

# Re-encode
# #ffmpeg -y -i screencast-2018-01-15_06-09-22.mp4 -c:v mpeg4 -b:v 600k -c:a libmp3lame output.avi

exit 0
