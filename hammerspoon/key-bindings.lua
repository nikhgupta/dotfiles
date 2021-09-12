local rb = spoon.RecursiveBinder
local sk = rb.singleKey
local kn = {}
local sh = require"helpers"
local owf = sh.openWithFinder
local yabai = sh.executeYabai
-- define the actual key map here
local recursiveKeyMap = {
	[{ kn, "space", "Seal" }] = function() spoon.Seal:show() end,
	[sk("f", "focus+")] = {
		[sk("w", "windows+")] = {
			[sk("h", "left")] = yabai("window", "focus west"),
			[sk("j", "down")] = yabai("window", "focus south"),
			[sk("k", "up")] = yabai("window", "focus noth"),
			[sk("l", "right")] = yabai("window", "focus east"),
			[sk("\\", "recent")] = yabai("window", "focus recent"),
			[sk(".", "clockwise")] = yabai("window", "focus next"),
			[sk(",", "anti-clockwise")] = yabai("window", "focus prev"),
			[sk("]", "next")] = yabai("window", "focus next"),
			[sk("[", "prev")] = yabai("window", "focus prev"),
			[sk("m", "largest")] = yabai("window", "focus largest")
		}
	}
	-- -- [{ keyNone, "space", "Commander" }] = spoon.Commander.show,
	-- -- [sk("`", "run command")] = sh.runCommand,
	-- [sk("f", "file+")] = {
	-- [sk("D", "Desktop")] = function() owf"~/Desktop" end,
	-- [sk("c", "Code")] = function() owf"~/Code" end,
	-- [sk("w", "Work")] = function() owf"~/Code/work" end,
	-- [sk("d", "Download")] = function() owf"~/Downloads" end,
	-- [sk("a", "Application")] = function() owf"~/Applications" end,
	-- [sk("h", "home")] = function() owf"~" end,
	-- [sk("f", "hello")] = function() hs.alert.show"hello!" end
	-- },
	-- [sk("t", "toggle+")] = {
	-- [sk("v", "file visible")] = function() hs.eventtap.keyStroke({ "cmd", "shift" }, ".") end
	-- },
	-- [sk("a", "app+")] = {
	-- [sk("e", "Emacs")] = function() hs.application.launchOrFocus"Emacs" end,
	-- [sk("s", "Safari")] = function() hs.application.launchOrFocus"Safari" end,
	-- [sk("f", "Finder")] = function() hs.application.launchOrFocus"Finder" end,
	-- [sk("d", "Dictionary")] = function() hs.application.launchOrFocus"Dictionary" end,
	-- [sk("m", "Mail")] = function() hs.application.launchOrFocus"Mail" end,
	-- [sk("q", "QQ")] = function() hs.application.launchOrFocus"QQ" end,
	-- [sk("w", "Wechat")] = function() hs.application.launchOrFocus"Wechat" end,
	-- [sk("g", "Google")] = function() os.execute"open http://google.com" end
	-- },
	-- [sk("i", "insert+")] = { [sk("e", "emoji")] = insertEmoji },
	-- [sk("c", "console+")] = {
	-- [sk("c", "Console")] = function() hs.console.hswindow():focus() end,
	-- [sk("r", "reload config")] = hs.reload
	-- }
}
return recursiveKeyMap