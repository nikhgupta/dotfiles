#!/bin/sh
#
# Script para criar screencasts(vídeos da captura de tela) usando o ffmpeg.
#
# Desenvolvido por Lucas Saliés Brum <lucas@archlinux.com.br>
#
# Criado em: 09/06/2017
# Última Atualização: 10/06/2017 09:36:56
#

preset="superfast" # ultrafast,superfast,veryfast,faster,fast,medium,slow,slower,veryslow,placebo
caminho="${HOME}/video/screencast"
data=$(date +%Y-%m-%d_%H-%M-%S)
icone="/usr/share/icons/Arc/devices/24@2x/video-display.png"
arquivo="${caminho}/screencast-${data}.mp4"
resolucao=$(xrandr | grep '*' | awk 'NR==1{print $1}')
audio=$(pacmd list-sinks | grep -A 1 'index: 1' | awk 'NR==2{print $2}' | awk '{print substr($0,2,length($0)-2)}') # list-sources, list-sinks

[ ! -d $caminho ] && mkdir -p $caminho

if pgrep -x "ffmpeg" > /dev/null
then
	killall ffmpeg
	notify-send -i $icone "ScreenCast" "O vídeo <b>$arquivo</b> foi terminado."
    exit 0
else
    notify-send -i $icone "ScreenCast" "O vídeo <b>$arquivo</b> foi iniciado..."
    #ffmpeg -f x11grab -r 25 -s $resolucao -i :0.0 -f pulse -i default -preset $preset -crf 0 -threads 0 -probesize 10M $arquivo
    #ffmpeg -f x11grab -r 25 -s $resolucao -i :0.0 -f pulse -i default -preset $preset -c:v libx264 -c:a aac -b:a 128k -probesize 50M $arquivo
    #ffmpeg -f x11grab -r 25 -s $resolucao -i :0.0 -f pulse -i default -preset $preset -c:v libx264 -c:a aac -b:a 128k -probesize 50M $arquivo
    ffmpeg -thread_queue_size 512 -f x11grab -r 30 -s $resolucao -i :0.0 -f pulse -i default -preset $preset -c:v libx264 -c:a aac -b:a 128k $arquivo -probesize 50M
fi
