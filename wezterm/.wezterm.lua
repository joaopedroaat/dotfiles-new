local wezterm = require("wezterm") -- Pull in wezterm API
local config = wezterm.config_builder() -- This will hold the configuration.

-- Font settings
config.font = wezterm.font({
	family = "JetBrainsMono Nerd Font",
})
config.font_size = 14

-- Theme settings
local rose_pine_plugin = wezterm.plugin.require("https://github.com/neapsix/wezterm")

local current_appearance = wezterm.gui and wezterm.gui.get_appearance() or "Dark"
local rose_pine_theme = (current_appearance:find("Dark")) and rose_pine_plugin.main or rose_pine_plugin.dawn

config.colors = rose_pine_theme.colors()
config.window_frame = rose_pine_theme.window_frame()

-- Misc Settings
config.automatically_reload_config = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false

-- Keybinds
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
	{
		-- Previous tab
		mods = "LEADER",
		key = "b",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		-- Next tab
		mods = "LEADER",
		key = "n",
		action = wezterm.action.ActivateTabRelative(1),
	},
}
for i = 1, 9 do
	-- leader + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

-- Finally, return the configuration to wezterm:
return config
