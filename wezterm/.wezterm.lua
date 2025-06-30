local wezterm = require("wezterm") -- Pull in wezterm API
local config = wezterm.config_builder() -- This will hold the configuration.

-- Font settings
config.font = wezterm.font({
	family = "JetBrainsMono Nerd Font",
})
config.font_size = 14

-- Theme settings
config.color_scheme = "GruvboxDark"
config.colors = {
	tab_bar = {
		background = "#282828",

		-- Current tab
		active_tab = {
			bg_color = "#282828",
			fg_color = "#d79921",
			underline = "Single",
		},

		-- Other tabs
		inactive_tab = {
			bg_color = "#282828",
			fg_color = "#928374",
		},

		-- Hover effect on inactive tabs
		inactive_tab_hover = {
			bg_color = "#282828",
			fg_color = "#928374",
			underline = "Single",

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab_hover`.
		},

		-- The new tab button that let you create new tabs
		new_tab = {
			bg_color = "#282828",
			fg_color = "#928374",
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over the new tab button
		new_tab_hover = {
			bg_color = "#665c54",
			fg_color = "#ebdbb2",
			italic = true,

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab_hover`.
		},
	},
}

-- Misc Settings
config.automatically_reload_config = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false
config.window_background_opacity = 0.8
config.window_padding = {
	bottom = 0,
}

-- Keybinds
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
	{
		-- Split Horizontally
		mods = "LEADER|SHIFT",
		key = "%",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		-- Split Vertically
		mods = "LEADER|SHIFT",
		key = '"',
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		-- New Tab
		mods = "LEADER",
		key = "c",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		-- Rename Tab
		mods = "LEADER",
		key = ",", -- You can choose a different key if 'r' conflicts
		action = wezterm.action.PromptInputLine({
			description = "Enter new tab title:",
			action = wezterm.action_callback(function(_, pane, line)
				if line then
					-- Set the tab title if the user entered something
					pane:tab():set_title(line)
				end
			end),
		}),
	},
	{
		-- New Workspace
		mods = "LEADER",
		key = "C",
		action = wezterm.action.SwitchToWorkspace,
	},
	{
		-- Rename Workspace
		mods = "LEADER|SHIFT",
		key = "$",
		action = wezterm.action.PromptInputLine({
			description = "Enter new workspace name:",
			action = wezterm.action_callback(function(_, _, line)
				if line and #line > 0 then
					wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
				end
			end),
		}),
	},
	{
		-- List Workspaces
		mods = "LEADER",
		key = "s", -- Consistent with tmux's leader + s
		action = wezterm.action.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES", -- FUZZY enables fuzzy searching, WORKSPACES lists your workspaces
			title = "Select Workspace:", -- Optional title for the launcher
		}),
	},
	{
		-- Resize Left / Activate Resize Mode
		mods = "LEADER|SHIFT",
		key = "LeftArrow",
		action = wezterm.action.Multiple({
			wezterm.action.AdjustPaneSize({ "Left", 2 }),
			wezterm.action.ActivateKeyTable({ name = "resize_pane", one_shot = false, until_unknown = true }),
		}),
	},
	{
		-- Resize Right / Activate Resize Mode
		mods = "LEADER|SHIFT",
		key = "RightArrow",
		action = wezterm.action.Multiple({
			wezterm.action.AdjustPaneSize({ "Right", 2 }),
			wezterm.action.ActivateKeyTable({ name = "resize_pane", one_shot = false, until_unknown = true }),
		}),
	},
	{
		-- Resize Up / Activate Resize Mode
		mods = "LEADER|SHIFT",
		key = "UpArrow",
		action = wezterm.action.Multiple({
			wezterm.action.AdjustPaneSize({ "Up", 2 }),
			wezterm.action.ActivateKeyTable({ name = "resize_pane", one_shot = false, until_unknown = true }),
		}),
	},
	{
		-- Resize Down / Activate Resize Mode
		mods = "LEADER|SHIFT",
		key = "DownArrow",
		action = wezterm.action.Multiple({
			wezterm.action.AdjustPaneSize({ "Down", 2 }),
			wezterm.action.ActivateKeyTable({ name = "resize_pane", one_shot = false, until_unknown = true }),
		}),
	},
	{
		-- Close Pane
		mods = "LEADER",
		key = "x",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		-- Close Pane
		mods = "LEADER",
		key = "X",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		-- Navigate to left pane
		mods = "LEADER",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		-- Navigate to down pane
		mods = "LEADER",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		-- Navigate to up pane
		mods = "LEADER",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		-- Navigate to right pane
		mods = "LEADER",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		-- Previous tab
		mods = "LEADER",
		key = "p",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		-- Next tab
		mods = "LEADER",
		key = "n",
		action = wezterm.action.ActivateTabRelative(1),
	},
}

-- leader + number to activate that tab
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

-- Key Tables
config.key_tables = {
	resize_pane = {
		{ key = "LeftArrow", mods = "SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 2 }) },
		{ key = "DownArrow", mods = "SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 2 }) },
		{ key = "UpArrow", mods = "SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 2 }) },
		{ key = "RightArrow", mods = "SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 2 }) },
		{ key = "Escape", action = wezterm.action.PopKeyTable },
	},
}

-- Status
local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function concat_tables(...)
	local result = {}
	for i = 1, select("#", ...) do
		local t = select(i, ...)
		for _, v in ipairs(t) do
			table.insert(result, v)
		end
	end
	return result
end

wezterm.on("update-right-status", function(window, pane)
	local workspace_module = {
		{ Foreground = { AnsiColor = "Silver" } },
		{ Text = " " .. window:active_workspace() },
		"ResetAttributes",
	}

	local padding_module = {
		{ Text = " " },
	}

	local separator_module = {
		{ Foreground = { AnsiColor = "Silver" } },
		{ Text = " | " },
		"ResetAttributes",
	}
	local separator_ns_module = {
		{ Foreground = { AnsiColor = "Silver" } },
		{ Text = "| " },
		"ResetAttributes",
	}

	local leader_module = (function()
		if window:leader_is_active() then
			return {
				{ Foreground = { AnsiColor = "Black" } },
				{ Background = { AnsiColor = "Olive" } },
				{ Text = " WEZ " },
				"ResetAttributes",
			}
		end
		-- Leader key is not active, return the module with normal styling
		return {
			{ Foreground = { AnsiColor = "Olive" } },
			{ Text = " WEZ " },
			"ResetAttributes",
		}
	end)()

	local pane_application_module = {
		{ Foreground = { AnsiColor = "Aqua" } },
		{ Text = " " .. basename(pane:get_foreground_process_name()) },
		"ResetAttributes",
	}

	window:set_left_status(
		wezterm.format(
			concat_tables(
				leader_module,
				separator_ns_module,
				workspace_module,
				separator_module,
				pane_application_module,
				separator_module
			)
		)
	)

	local date_module = {
		{ Foreground = { AnsiColor = "Silver" } },
		{ Text = wezterm.strftime("%R 󰃰") },
		"ResetAttributes",
	}
	window:set_right_status(wezterm.format(concat_tables(date_module, padding_module)))
end)

-- Finally, return the configuration to wezterm:
return config
