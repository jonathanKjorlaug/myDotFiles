local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Colorscheme
config.color_scheme = "Tokyo Night Storm"
config.font = wezterm.font("MesloLGM Nerd Font")

config.window_decorations = "RESIZE"
require("keys").activateBindings(config, {})

-- Tab bar:
config.enable_tab_bar = false
require("tabBar").activateTab(config)

-- General
config.enable_wayland = false
config.status_update_interval = 1000

wezterm.on("update-right-status", function(window, pane)
	local time = wezterm.strftime("%H:%M")

	window:set_right_status(wezterm.format({
		{ Text = wezterm.nerdfonts.md_clock .. " " .. time },
	}))
end)
return config
