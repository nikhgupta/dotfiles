#!/usr/bin/env bash

unclip -z
id=$(wmctrl -l | grep -oP "(?<=)(0x\w+)(?=.*Google Chrome)")
xdotool windowactivate $id
xdotool key --window $id "ctrl+l"
xdotool key --window $id "ctrl+c"
echo $(xclip -o | tail -1) >> ~/.cache/url-list.txt
