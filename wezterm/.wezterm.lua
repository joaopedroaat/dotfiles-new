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

-- Tmux
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
	{
		-- Create a new tab
		mods = "LEADER",
		key = "c",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		-- Close a pane or tab
		mods = "LEADER",
		key = "x",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		-- Previous tab
		mods = "LEADER",
		key = "b",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		-- Next tab
		mods = "LEADER",
		key = "n",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		-- Split horizontaly
		mods = "LEADER|SHIFT",
		key = "%",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		-- Split verticaly
		mods = "LEADER|SHIFT",
		key = '"',
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		-- Navigate left pane
		mods = "LEADER",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		-- Navigate bottom pane
		mods = "LEADER",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		-- Navigate top pane
		mods = "LEADER",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		-- Navigate right pane
		mods = "LEADER",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		-- Resize left
		mods = "LEADER",
		key = "LeftArrow",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		-- Resize right
		mods = "LEADER",
		key = "RightArrow",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		-- Resize down
		mods = "LEADER",
		key = "DownArrow",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		-- Resize up
		mods = "LEADER",
		key = "UpArrow",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
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

config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false

wezterm.on("update-right-status", function(window, _)
	local prefix = window:leader_is_active() and " " .. "🍄" .. " " or ""

	window:set_left_status(wezterm.format({
		{ Text = prefix },
	}))
end)

-- Misc Settings
config.automatically_reload_config = true

-- Finally, return the configuration to wezterm:
return config
