#!/usr/bin/env bash

# run at 16:30
h=0
m=18

while true; do
    # grab current hour and minute
    now_h=$(date "+%H")
	now_m=$(date "+%M")

    # calculate approximate number of seconds until 16:30 using modular 
    # arithmetics
    (( s = (1440 + (10#$h*60 + 10#$m) - (10#$now_h*60 + 10#$now_m)) % 1440 * 60 ))

    printf "Sleeping %d seconds\n" "$s"
    sleep "$s" && notify-send Oiiii
done
