local viperzer0 = {}
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
terminal = "xterm"
modkey = "Mod4"
local floaters = {}

awful.util.shell = terminal
function viperzer0.keybinds(globalkeys)
	globalkeys = gears.table.join(globalkeys,
		awful.key({modkey, },"b", function () awful.spawn("rofi -show run") end,
		{description = "rofi", group="custom"}),
		awful.key({modkey, },"v", function() awful.spawn(terminal .. " -e ranger") end,
		{description = "ranger", group="custom"}),
		awful.key({"Shift", modkey}, "s", function() client.focus.sticky = not client.focus.sticky end,
		{description = "toggle sticky",group = "client"}),
		awful.key({ }, "Print", function() awful.spawn("sh /home/viperzer0/.scripts/screenshot.sh") end,
		{description = "selection screenshot", group = "custom"}),
		awful.key({"Shift" }, "Print", function() awful.spawn("sh /home/viperzer0/.scripts/screenshot.sh -g") end,
		{description = "screenshot", group = "custom"}),
		awful.key({"Shift", modkey,},"v", function() awful.spawn("clipmenu") end, {description = "open clipboard", group="custom"}),
        awful.key({modkey, }, "c", function() awful.spawn('rofi -show pass -modes "pass:/home/viperzer0/.scripts/rofi-pass.sh"') end, {description = "copy password", group="custom"})
	)
	return globalkeys
end
--[[
function viperzer0.set_floating(c)
	for i,v in ipairs(floaters) do
		naughty.notify({text = v})
		if v == c.name then
			c.floating = true
			return
		end
	end
end

function viperzer0.toggle_floating(c)
	found = false	
	for i,v in ipairs(floaters) do 
		if c.floating == false then
			if v == c.name then --Window was previously on our floating table, we can remove it now.
				table.remove(floaters,i)
				return
			end
		else
			if v == c.name then
				found = true
				break
			end
		end
	end
	if c.floating == true then
		naughty.notify({text = "Window was floating"})
	elseif c.floating == false then
		naughty.notify({text = "Window was not floating"})
	end
	if c.floating == true and found == false then
		naughty.notify({text = "HM"})
		table.insert(floaters,c.name)
	end
end
]]--
			
return viperzer0
