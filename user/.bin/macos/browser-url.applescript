#!/usr/bin/env osascript

on run argv
  if (count of argv) >= 1 then
    set inp to item 1 of argv
  else
    set inp to "Safari"
  end if

  tell application "System Events"
    if inp is "Google Chrome" then
      tell application "Google Chrome" to return URL of active tab of front window
    else if inp is "Firefox" then
      tell application "Firefox" to activate
      tell application "System Events"
        keystroke "l" using command down
        keystroke "c" using command down
      end tell
      delay 0.5
      return the clipboard
    else if inp is "Safari" then
      tell application "Safari" to return URL of front document
    else
      return
    end if
  end tell
end argv
