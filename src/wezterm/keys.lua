local act = require("wezterm").action
-- Dict of keybindings

local module = {}

function module.activateBindings(config, params)
	local options = {
		tabkeys = true,
		splits = true,
		vimSplitNavigation = true,
	}

	for i, line in ipairs(params) do
		options[i] = line
	end

	config.keys = {}
	local keys = config.keys

	if options.tabkeys then
		for i = 1, 9 do
			table.insert(keys, {
				key = tostring(i),
				mods = "CTRL",
				action = act.ActivateTab(i - 1),
			})
			table.insert(keys, {
				key = tostring(i),
				mods = "CTRL|ALT",
				action = act.MoveTab(i - 1),
			})
		end
	end

	if options.splits then
		table.insert(keys, {
			key = "!",
			mods = "CTRL|SHIFT",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		})

		table.insert(keys, {
			key = '"',
			mods = "CTRL|SHIFT",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		})
	end

	if options.vimSplitNavigation then
		table.insert(keys, {
			key = "h",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Left"),
		})

		table.insert(keys, {
			key = "j",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Down"),
		})

		table.insert(keys, {
			key = "k",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Up"),
		})

		table.insert(keys, {
			key = "l",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Right"),
		})
	end
end

return module
