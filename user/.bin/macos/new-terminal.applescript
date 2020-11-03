#!/usr/bin/env osascript

on run argv
  tell application "System Events"
    tell application "kitty" to activate
    keystroke "n" using {command down}
    set visible of process "kitty" to true
  end tell

  if (count of argv) >= 1
    if item 1 of argv is "finder"
      tell application "Finder"
        set pathList to (quoted form of POSIX path of (folder of the front window as alias))
        set textToType to "clear; cd " & pathList
      end tell
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
