#!/usr/bin/env bash
if [ -f ~/.config/user-dirs.dirs ]; then
    source ~/.config/user-dirs.dirs
    dir="${XDG_SCREENCAST_DIR}/"
else
    dir="${HOME}/Video/Screencasts/"
fi

cache="$dir/OLD/"
_status=/tmp/scripts/screencasts.status

if [ "$1" == "open" ]; then
  xdg-open $dir
  exit 0
fi

if [ "$1" == "status" ]; then
    mkdir -p $(dirname $_status)
    truncate -s0 $_status
    echo "" >>$_status
    tail -fn1 $_status
fi

preset="ultrafast" # ultrafast,superfast,veryfast,faster,fast,medium,slow,slower,veryslow,placebo
color="ffb52a"
icon="videoclip-amarok"

resolution=$(xrandr | grep '*' | awk 'NR==1{print $1}')
audio=$(pacmd list-sinks | grep -A 1 'index: 0' | awk 'NR==2{print $2}' | awk '{print substr($0,2,length($0)-2)}') # list-sources, list-sinks

if [ ! $1 ]; then
    archive="${dir}$(date +%Y-%m-%d_%H-%M-%S).mp4"
    [ ! -d $dir ] && mkdir -p $dir
fi

if ps auwwx | grep -i "ffmpeg" | grep -qi "$dir"; then
    if [ ! $1 ]; then
        killall ffmpeg
        notify-send -i $icon "Screencast" "Video terminated."
        echo "" >>$_status
        exit 0
    fi
else
    if [ ! "$1" ]; then
        notify-send -i $icon "Screencast" "Video started..."
        echo "%{F#${color}}%{F-}" >>$_status
        ffmpeg -f x11grab -s $resolution -i $DISPLAY -f pulse -ac 2 -i default -c:v libx264 -crf 23 -profile:v baseline -level 3.0 -pix_fmt yuv420p -c:a aac -ac 2 -strict experimental -b:a 128k -movflags faststart $archive
    elif [ "$1" == "open" ]; then
      xdg-open $dir &
    elif [ "$1" == "cache" ]; then
        icon="tools-wizard"
        listing=(${dir}*.mp4)
        if [ ${#listing[@]} -gt 1 ]; then
            mkdir -p $cache
            mv ${dir}*.mp4 ${cache}
            notify-send -i $icon "Screencast" "Moved existing screencasts to long-term cache."
        else
            notify-send -i $icon "Screencast" "Screencasts folder already cached!"
        fi
        exit 0
    fi
fi

exit 0
