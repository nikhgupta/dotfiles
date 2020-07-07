#!/bin/bash

MAP="$HOME/.config/rofi/commands.csv"

if [[ -z "$1" ]]; then
  format_for_command() {
    _term=$(echo $1 | cut -d ',' -f 7)
    _exec=$(echo $1 | cut -d ',' -f 3)
    _try_exec=$(echo $1 | cut -d ',' -f 5)
    [[ -n "$_try_exec" ]] && _exec=$_try_exec
    if [[ "$_term" == "true" ]]; then
      echo "$TERMINAL -e bash -c \"$_exec; read -n 1 -s\""
    else
      echo "bash -c \"$_exec\""
    fi
  }

  IFS=$'\n'
  cmds=""
  for item in $(cat $MAP); do
    _used=$(echo $item | cut -d ',' -f 1)
    if [[ "$_used" == "1" ]]; then
      _name=$(echo $item | cut -d ',' -f 2)
      _term=$(echo $item | cut -d ',' -f 7)
      _icon=$(echo $item | cut -d ',' -f 4)
      _name2=$(echo $item | cut -d ',' -f 6)
      _path=$(echo $item | cut -d ',' -f 9)
      [[ -n "$_name2" ]] && _name="${_name} ($_name2)"
      [[ "$_path" == "custom" ]] && _name=" $_name"
      [[ "$_term" == "true" ]] && _name=" $_name"
      cmds="${cmds}$_name\0icon\x1f$_icon\n"
    fi
  done

  selected=$(echo -ne $cmds | rofi -theme drun -dmenu -i -separator-style none | head -n 1 | awk -F' \\(' '{print $1}')
  found=$(echo $selected | xargs -i --no-run-if-empty grep "{}" "$MAP" | head -n 1)
  bash -c $(format_for_command $found)

  exit 0
elif [[ "$1" == "cache" ]]; then
  parse_desktop_entry() {
    _content=$(cat $1)
    _invalid=$(echo $_content | grep -qi "Type=Application" || echo 1)
    _invalid="${_invalid}$(echo $_content | grep -qi "Hidden=true" && echo 1)"
    _invalid="${_invalid}$(echo $_content | grep -qi "NoDisplay=true" && echo 1)"
    [[ -f $MAP ]] && _invalid="${_invalid}$(cat $MAP | grep -qE ",$1$" && echo 1)"

    if [[ -z "$_invalid" ]]; then
      _name=$(cat $1 | grep '^Name=' | head -n 1 | cut -d '=' -f 2)
      _name2=$(cat $1 | grep '^GenericName=' | head -n 1 | cut -d '=' -f 2)
      _exec=$(cat $1 | grep '^Exec=' | head -n 1 | cut -d '=' -f 2)
      _icon=$(cat $1 | grep '^Icon=' | head -n 1 | cut -d '=' -f 2)
      _try_exec=$(cat $1 | grep '^TryExec=' | head -n 1 | cut -d '=' -f 2)
      _term=$(cat $1 | grep '^Terminal=' | head -n 1 | cut -d '=' -f 2)
      _cats=$(cat $1 | grep '^Categories=' | head -n 1 | cut -d '=' -f 2)
      echo "1,$_name,$_exec,$_icon,$_try_exec,$_name2,$_term,$_cats,$1" | tee -a $MAP
    fi
  }

  for _dir in /usr/share/applications $HOME/.local/share/applications; do
    for _entry in $(find $_dir -type f -iname '*.desktop'); do
      parse_desktop_entry $_entry
    done
  done
fi
