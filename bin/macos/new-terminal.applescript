#!/usr/bin/env osascript

on is_running(appName)
  tell application "System Events" to (name of processes) contains appName
end is_running

on run argv
  set kittyRunning to is_running("kitty")

  tell application "System Events"
    if kittyRunning then
      tell application "kitty" to activate
      keystroke "n" using {command down}
      set visible of process "kitty" to true
    else
      tell application "kitty" to activate
    end if
  end tell

  if (count of argv) >= 1
    if item 1 of argv is "finder"
      tell application "Finder"
        set pathList to (quoted form of POSIX path of (folder of the front window as alias))
        set textToType to "clear; cd " & pathList
      end tell
    else if item 1 of argv is "nick"
      set textToType to "clear; ssh nick; exit"
    else if item 1 of argv is "iacm"
      set textToType to "clear; ssh iacm; exit"
    else
      set textToType to "clear; cd " & (quoted form of item 1 of argv)
    end if

    tell application "System Events"
      keystroke textToType
      keystroke return
    end tell

    return textToType
  end if
end run
