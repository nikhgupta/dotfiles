#!/usr/bin/env bash

pidfile=/tmp/scripts/$(basename $0).pid
mkdir -p $(dirname $pidfile)

get_status_icon() {
    if pactl list sources | grep -qi 'mute: yes'; then
        echo ""
    else
        echo "%{F#85888f}%{F-}"
    fi
}

get_status_icon

[[ -f $pidfile ]] && exit 0
trap "rm -f -- '$pidfile'" EXIT

echo $$ > $pidfile
while read line; do
    if echo "$line" | grep -qi "Event 'change' on source #"; then
        get_status_icon
    fi
done < <(pactl subscribe)
