#!/usr/bin/env bash

# Pacotes necessários: sound-theme-freedesktop & libcanberra

# ls /usr/share/sounds/freedesktop/stereo/
online="phone-incoming-call"
offline="phone-outgoing-busy"

#h="127.0.0.1"
#h=${4:-"8.8.8.8"}
#r=${3:-1}

h="8.8.8.8"
r=1
v=1
l=0

function pingar {
	ping -q -c$r $h > /dev/null 2> /dev/null
	if [ $? -eq 0 ]; then
		if [ $v == 1 ]; then
			echo "%{F#8fbcbb}%{F-}"
		fi

		if [ ! -f ~/.ping.lock ]; then
			export DISPLAY=:0 ; canberra-gtk-play -i $online 2>&1
			touch ~/.ping.lock
		fi
	else
		if [ $v == 1 ]; then
			echo "%{F#bf616a}%{F-}"
		fi

		[ ! -f ~/.ping.lock ] && rm -f ~/.ping.lock
		export DISPLAY=:0 ; canberra-gtk-play -i $offline 2>&1
	fi
}

if [ $l = 1 ]; then
	while true; do
		pingar
		sleep 3
	done
else
	pingar
fi

# Never hurts...
exit 0
