#!/bin/bash
PS=`ps -ef`
#Icon="/path/to/nasa_icon.png"

if echo "$PS"|grep -q 'vlc -I dummy';
    then notify-send -i $Icon "  ISS background OFF" \ "\"Houston, We've Got a Problem !\"";
    kill $(ps aux | grep 'vlc -I dummy' | awk '{print $2}')
else notify-send -i $Icon " ISS background ON" \ "Dowloading data from ISS...";
    livestreamer http://www.ustream.tv/embed/9408562?html5ui best --player "cvlc --no-video" & livestreamer http://ustream.tv/channel/iss-hdev-payload best --player 'vlc -I dummy --video-wallpaper --no-video-title-show --noaudio'
fi
