#!/bin/bash

DOM=$(date +%-d)
HORA=$(date +%H)
DISPLAY=:0.0

#if [ $# -lt 2 ]
#then
#        echo "Usage : $0 Signalnumber PID"
#        exit
#fi

#function set_bg {
  # export DBUS_SESSION_BUS_ADDRESS environment variable
  #PID=$(pgrep -f cinnamon-session)
  #export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)
  #gsettings set org.cinnamon.desktop.background picture-uri file:///tmp/bitday/$1
#}

function set_bg {
    feh --bg-fill "$(find ${DIR}/${DOM}/ | shuf -n1)"
}

if [ $1 -eq "-s" ]
then

    case "$DOM" in
        1)
            SEMANA="domingo"
        ;;
        2)
            SEMANA="domingo"
        ;;
        3)
            SEMANA="domingo"
        ;;
        3)
            SEMANA="domingo"
        ;;
        4)
            SEMANA="domingo"
        ;;        
        5)
            SEMANA="domingo"
        ;;
        6)
            SEMANA="domingo"
        ;;      
        7)
            SEMANA="domingo"
        ;;
        *)
            SEMANA="domingo"
        ;;
    esac
    
    feh --bg-fill "$(find ${DIR}/${DOM}/ | shuf -n1)"

else

HOUR=`date +"%H"`
 
if [ "$HOUR" -gt 2 ] && [ "$HOUR" -le 5 ]; then
  set_bg "08-Late-Night.png"
elif [ "$HOUR" -gt 5 ] && [ "$HOUR" -le 9 ]; then
  set_bg "01-Morning.png"
elif [ "$HOUR" -gt 9 ] && [ "$HOUR" -le 12 ]; then
  set_bg "02-Late-Morning.png"
elif [ "$HOUR" -gt 12 ] && [ "$HOUR" -le 15 ]; then
  set_bg "03-Afternoon.png"
elif [ "$HOUR" -gt 15 ] && [ "$HOUR" -le 17 ]; then
  set_bg "04-Late-Afternoon.png"
elif [ "$HOUR" -gt 17 ] && [ "$HOUR" -le 19 ]; then
  set_bg "05-Evening.png"
elif [ "$HOUR" -gt 19 ] && [ "$HOUR" -le 23 ]; then
  set_bg "06-Late-Evening.png"
elif [ "$HOUR" -ge 0 ] && [ "$HOUR" -le 2 ]; then
  set_bg "07-Night.png"
fi

fi

#walls_dir=$HOME/img/sexy
#selection=$(find $walls_dir -type f -name "*.jpg" -o -name "*.png" | shuf -n1)
#gsettings set org.gnome.desktop.background picture-uri "file://$selection"
