#!/bin/bash
pac=$(checkupdates 2> /dev/null | wc -l)
aur=$(cower -u 2> /dev/null | wc -l)

#echo "$pac %{F#5b5b5b}%{F-} $aur"
echo "${pac}/${aur}"
