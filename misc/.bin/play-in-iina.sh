#!/usr/bin/env zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Play files in IINA
# @raycast.mode fullOutput
# @raycast.argument1 { "type": "text", "placeholder": "directory" }
# @raycast.argument2 { "type": "text", "placeholder": "search params", "optional": true }

# Optional parameters:
# @raycast.icon ??
# @raycast.packageName NIK Workflow

# Documentation:
# @raycast.author Nikhil Gupta
# @raycast.authorURL nikhgupta.com

if [[ "$__CFBundleIdentifier" == "com.raycast.macos" ]]; then
  open -a iina "$(fd "${2:-*.mp4}" -tf "${1:-$HOME}" -gH1)"
else
  cd "${1:-$HOME}" && rgf --files | fzf --query "${2:-.mp4}" --multi --select-1 --bind "ctrl-x:execute(iina {})" --preview-window=down,0% --print0 | xargs -0 -o iina
fi
