local act = require("wezterm").action
-- Dict of keybindings

local module = {}

local function tabKeys(keys)
	for i = 1, 9 do
		table.insert(keys, {
			key = tostring(i),
			mods = "CTRL",
			action = act.ActivateTab(i - 1),
		})
	end
end

function module.activateBindings(config, params)
	local options = {
		tabkeys = true,
	}

	for i, line in ipairs(params) do
		options[i] = line
	end

	config.keys = {}
	local keys = config.keys

	if options.tabkeys then
		tabKeys(keys)
	end
end

return module
