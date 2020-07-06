#!/bin/bash

# Range from 1 to 100 is valid
brightness_none=45
brightness_day=60
brightness_transition=35
brightness_night=25

fade_time=3
steps=0.02

bright_fade() {
  _current=$(light -G)
  _expected=$1
  _count=$(bc <<< $fade_time/$steps)
  _change=$(bc <<< "scale=2;($_expected - $_current)/$_count" )
  for i in `seq 1 $_count`; do
    sleep $steps
    light -S $(bc <<< "scale=2;$_current + $i*$_change")
  done
  light -S $1
}

echo $@ >> /tmp/test
if [ "$1" = period-changed ]; then
  case $3 in
    night) bright_fade $brightness_night ;;
    transition) bright_fade $brightness_transition ;;
    daytime) bright_fade $brightness_day ;;
    none) bright_fade $brightness_none ;;
  esac
fi
