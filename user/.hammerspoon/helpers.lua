local obj = {}
obj.__index = obj

function obj.runCommand()
	local buttonValue, command = hs.dialog.textPrompt("", "", "", "OK", "Cancel")
	if buttonValue == "OK" then hs.execute(command) end
end

function obj.openWithFinder(path)
	os.execute("open " .. path)
	hs.application.launchOrFocus"Finder"
end

function obj.useSpoon(argTable)
	local name = argTable.name
	argTable.name = nil
	spoon.SpoonInstall:andUse(name, argTable)
end

function obj.executeYabai(target, command)
	local cmd = "/usr/local/bin/yabai -m " .. target .. " --" .. command
	print(cmd)
	return function() os.execute(cmd) end
end

return obj