#!/usr/bin/env zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Generate Random AlphaNumeric Data
# @raycast.mode fullOutput
# @raycast.argument1 { "type": "text", "placeholder": "length (default: 1024)", "optional": true }

# Optional parameters:
# @raycast.icon ??
# @raycast.packageName NIK Workflow

# Documentation:
# @raycast.author Nikhil Gupta
# @raycast.authorURL nikhgupta.com

cat /dev/urandom |
  gtr -dc 'a-zA-Z0-9\{\}\[\]\<\>,\.\/?;:\-=_\+\!@#$%\^\&\*\(\)~' |
  gtr -d '[:space:]' |
  gtr -dc "${2:-'\11\12\40-\176'}" |
  head -c "${1:-1024}"
echo -ne "\n"
