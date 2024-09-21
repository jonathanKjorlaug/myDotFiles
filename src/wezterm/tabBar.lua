local wezterm = require("wezterm")

local module = {}

function module.activateTab(config)
	config.enable_tab_bar = true
	config.use_fancy_tab_bar = true
	config.hide_tab_bar_if_only_one_tab = true
	config.show_new_tab_button_in_tab_bar = false
	config.mouse_wheel_scrolls_tabs = false
	config.use_fancy_tab_bar = false
end

function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local basename = function(s)
		-- Nothing a little regex can't fix
		return string.gsub(s, "(.*/)(?!($))", "", 1)
		-- return s
	end

	local index = tab.tab_index + 1
	local title = tab_title(tab)
	local cwd = tab.active_pane.current_working_dir
	cwd = basename(cwd.path)

	return {
		{ Text = " " .. index .. " " .. title .. " " },
	}
end)

return module
