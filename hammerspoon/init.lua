sh = require"helpers"
require"hs.ipc"
-- load spoon installer for easier downloading and management of spoons
hs.loadSpoon"SpoonInstall"
-- Reload Configuration on Change
sh.useSpoon{ name = "ReloadConfiguration", start = true }
-- Seal
-- Triggers: pb => pasteboard, sc => screen capture
sh.useSpoon{
	name = "Seal",
	start = true,
	hotkeys = { show = { { "cmd" }, "space" } },
	fn = function(s)
		s:loadPlugins{
			"apps",
			"calc",
			"pasteboard",
			"safari_bookmarks",
			"screencapture"
		}
		s.plugins.apps.appSearchPaths = {
			"/Applications",
			"/System/Applications",
			"~/Applications",
			"/Developer/Applications",
			"/Applications/Xcode.app/Contents/Applications",
			"/System/Library/PreferencePanes",
			"/Library/PreferencePanes",
			"~/Library/PreferencePanes",
			"/System/Library/CoreServices/Applications",
			"/usr/local/Cellar",
			"/Library/Scripts",
			"~/Library/Scripts"
		}
	end
}
-- Commander
sh.useSpoon{ name = "Commander", fn = function() spoon.Commander.forceLayout = "ABC" end }
-- RecursiveBinder
sh.useSpoon{
	name = "RecursiveBinder",
	config = { escapeKey = { {}, "escape" } },
	fn = function(s) spoon.RecursiveBinder.helperFormat.textFont = "Fira Code" end
}
local recursiveKeyMap = require"key-bindings"
hs.hotkey.bind(keyNone, "F19", spoon.RecursiveBinder.recursiveBind(recursiveKeyMap))
-- -- Window
-- sh.useSpoon{
-- name = 'Window',
-- config = function()
-- local hyperMod = {'control' , 'option', 'command'}
-- hs.hotkey.bind(hyperMod, 'h', spoon.Window.moveWindowLeft)
-- hs.hotkey.bind(hyperMod, 'j', spoon.Window.moveWindowDown)
-- hs.hotkey.bind(hyperMod, 'k', spoon.Window.moveWindowUp)
-- hs.hotkey.bind(hyperMod, 'l', spoon.Window.moveWindowRight)
-- hs.hotkey.bind(hyperMod, 'f', spoon.Window.moveWindowFullscreen)
-- hs.hotkey.bind(hyperMod, 'c', spoon.Window.moveWindowCenter)
-- end
-- }
-- -- emacs-china
-- local function Chinese()
-- hs.keycodes.currentSourceID("com.apple.inputmethod.SCIM")
-- end
-- local function English()
-- hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
-- end
-- local function set_app_input_method(app_name, set_input_method_function, event)
-- event = event or hs.window.filter.windowFocused
-- hs.window.filter.new(app_name)
-- :subscribe(event, function()
-- set_input_method_function()
-- end)
-- end
-- set_app_input_method('Hammerspoon', English, hs.window.filter.windowCreated)
-- set_app_input_method('Spotlight', English, hs.window.filter.windowCreated)
-- set_app_input_method('Emacs', English)
-- set_app_input_method('iTerm2', English)
-- set_app_input_method('Safari', English)
-- set_app_input_method('WeChat', Chinese)
-- This method slows down keystokes
-- cxBinding = hs.hotkey.bind({'control'}, 'x', function()
-- print('C-x')
-- cxBinding:disable()
-- hs.eventtap.keyStroke({'control'}, 'x')
-- switchInputMethod()
-- -- to prevent infinite loop
-- hs.timer.doAfter(1, function() cxBinding:enable() end)
-- end)
-- function switchInputMethod()
-- if hs.execute('xkbswitch -g', true) ~= 2 then
-- switchedInput = true
-- hs.execute('xkbswtich -s 2', true)
-- end
-- end
-- function switchInputMethodBack()
-- if switchedInput then
-- switchedInput = false
-- hs.execute('xkbswitch -s 0', true)
-- end
-- end
-- hs.allowAppleScript(true)