#!/usr/bin/env bash
#
# Source: http://askubuntu.com/a/721919
#

interval=30

killPid () {
	for pid in $(ps aux | grep $(basename $0) | egrep -v grep | awk '{print $2}'); do
    	if [ $pid != $$ ]; then
        	kill -9 $pid 2> /dev/null
    	fi
	done
}

if [ "$1" == 'stop' ]; then
	killPid
	exit 0
fi

killPid

while :
do
	# grep RUNNING /proc/asound/card0/pcm0p/sub0/status
    if [[ ! -z $(pacmd list-sink-inputs | grep RUNNING) ]] ; then
        xdotool key shift ;
	fi

    sleep $interval
done

exit 0
