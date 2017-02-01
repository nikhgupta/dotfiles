#!/usr/bin/env zsh

# pretend to be busy at office
fun-hexdump(){
  while [ true ]; do
    head -n 100 /dev/urandom
    sleep .1
  done | hexdump -C | GREP_COLOR=34 grep "ca fe"
}

fun-installer(){
  j=0; while true; do
    let j=$j+1
    for i in $(seq 0 20 100); do
      echo $i; sleep 1
    done | dialog --gauge "Install Part $j : `sed $(perl -e "print int rand(99999)")"q;d" /usr/share/dict/words`" 6 40
  done
}

fun-weather(){
  rbcmd="require 'json'; print JSON.parse(ARGF.read)['city']"
  curl wttr.in/$(curl -sL --get https://freegeoip.net/json | ruby -e $rbcmd)
}

# Put a console clock in top right corner.
# A nice way to use the console in full screen without forget the
# current time. You can too add other infos like cpu and mem use.
# http://www.commandlinefu.com/commands/view/7916/put-a-console-clock-in-top-right-corner
fun-clock() {
  while sleep 1; do
    tput sc
    tput cup 0 $(($(tput cols)-29))
    date; tput rc
  done &; clear
}

fun-busy() {
  my_file=$(find /usr/include -type f | sort -R | head -n 1)
  my_len=$(wc -l $my_file | awk "{print $1}")
  let "r = $RANDOM % $my_len" 2>/dev/null
  vim +$r $my_file
}
