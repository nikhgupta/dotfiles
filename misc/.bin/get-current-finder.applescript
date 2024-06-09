#!/usr/bin/env osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Get Current Finder window
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ??
# @raycast.packageName NIK Utils

# Documentation:
# @raycast.author Nikhil Gupta
# @raycast.authorURL nikhgupta.com

tell application "Finder"
  if exists Finder window 1 then
    set currentDir to target of Finder window 1 as alias
  else
    set currentDir to desktop as alias
  end if
end tell

return POSIX path of currentDir
