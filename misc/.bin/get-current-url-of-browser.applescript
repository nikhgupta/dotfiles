#!/usr/bin/env osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Get Current URL of Browser
# @raycast.mode compact
# @raycast.argument1 { "type": "dropdown", "placeholder": "Browser", "data": [{"title": "Arc Browser", "value": "Arc"}, {"title": "Chrome Browser", "value": "Chrome"}, {"title": "Firefox Browser", "value": "Firefox"}, {"title": "Safari Browser", "value": "Safari"}] }

# Optional parameters:
# @raycast.icon ??
# @raycast.packageName NIK Utils

# Documentation:
# @raycast.author Nikhil Gupta
# @raycast.authorURL nikhgupta.com

on run argv
  if (count of argv) >= 1 then
    set inp to item 1 of argv
  else if application "Safari" is running then
    set inp to "Safari"
  else if application "Google Chrome" is running then
    set inp to "Google Chrome"
  -- else if application "Firefox" is running then
  --   set inp to "Firefox"
  else
    set inp to "Arc"
  end if

  tell application "System Events"
    if inp is "Arc" then
      tell application "Arc" to return URL of active tab of front window
    else if inp is "Google Chrome" then
      tell application "Google Chrome" to return URL of active tab of front window
    -- else if inp is "Firefox" then
    --   tell application "Firefox" to activate
    --   tell application "System Events"
    --     keystroke "l" using command down
    --     keystroke "c" using command down
    --   end tell
    --   delay 0.5
    --   return the clipboard
    else if inp is "Safari" then
      tell application "Safari" to return URL of front document
    else
      return
    end if
  end tell
end argv
