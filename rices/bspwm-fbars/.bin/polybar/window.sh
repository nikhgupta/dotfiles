#!/bin/bash

_status=/tmp/scripts/window.status
_recent=/tmp/scripts/recent.txt
pidfile=/tmp/scripts/$(basename $0).pid
mkdir -p $(dirname $pidfile)

loop_status() {
  while :; do
    title=$(xdotool getactivewindow getwindowname 2>/dev/null || echo "ArchLinux")
    if [[ "$title" == "kitty" ]] || [[ "$title" == "Alacritty" ]]; then title='Terminal'; fi
    _icon=$(icon_search "${title}")
    [[ $(tail -1 $_status) == "$_icon ${title}" ]] || echo "$_icon $title" >>$_status
    sleep 1
  done
}

truncate_status() {
  while :; do
    sleep 3600
    echo "$(tail -1000 $_status)" >$_status
  done
}

queue_window_status() {
  poly_pids=$(pgrep polybar | tr "\n" " ")
  if head -1 $_status | grep -qi "$poly_pids"; then
    loop_status
  else
    truncate -s0 $_status
    echo "$poly_pids" >>$_status
    loop_status
  fi
}

assign_icon() {
  echo "$3" | grep -i "$2" >/dev/null && icon='\u'$1
}

icon_search() {
  assign_icon f120 "zsh" "$@"
  assign_icon f120 "bash" "$@"
  assign_icon f120 "Terminal" "$@"
  assign_icon f27d "VIM" "$@"
  assign_icon f1be "ncmpcpp" "$@"
  assign_icon f121 "Visual Studio Code" "$@"
  assign_icon f268 "Google Chrome" "$@"
  assign_icon f17c "ArchLinux" "$@"
  assign_icon f266 "Wikipedia" "$@"
  assign_icon f16c "Stack Overflow" "$@"
  assign_icon f18d "Stack Exchange" "$@"
  assign_icon f23a "Medium" "$@"
  assign_icon f1a0 "Google Search" "$@"
  assign_icon f09b "Github" "$@"
  assign_icon f296 "Gitlab" "$@"
  assign_icon f281 "Reddit" "$@"
  assign_icon f144 "Youtube" "$@"

  [[ -n "$icon" ]] && echo -ne "$icon" && return

  _found=$(cat $_recent | grep "$1" | awk -F' --_x_x_x_-- ' '{print $2}')

  if [[ -n "$_found" ]]; then
    echo -ne "$_found"
  else
    $(dirname $(dirname $0))/icon-search.rb $1
  fi
}

if [ "$1" == "copy" ]; then
  xdotool getactivewindow getwindowname 2>/dev/null | xclip -rmlastnl -selection c
elif [ "$1" == "close" ]; then
  focused_window_id=$(xdotool getwindowfocus)
  active_window_id=$(xdotool getactivewindow)
  active_window_pid=$(xdotool getwindowpid "$active_window_id")
  kill -9 $active_window_pid
elif [ "$1" == "jump" ]; then
  rofi -show window
elif [[ ! -f $pidfile ]]; then
  trap "rm -f -- '$pidfile'" EXIT
  echo $$ > $pidfile
  mkdir -p $(dirname $_status)
  queue_window_status &
  truncate_status &
  tail -fn1 $_status
fi
