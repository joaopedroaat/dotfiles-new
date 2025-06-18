-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
config.window_decorations = "RESIZE"
config.automatically_reload_config = true

-- Set font
config.font = wezterm.font({
	family = "JetBrainsMono Nerd Font",
})
config.font_size = 14

-- Fix wezterm on gnome window maximize
config.enable_wayland = false

-- Set theme
local rose_pine_plugin = wezterm.plugin.require("https://github.com/neapsix/wezterm")

-- Determine theme based on appearance
local current_appearance = wezterm.gui and wezterm.gui.get_appearance() or "Dark"
local rose_pine_theme = (current_appearance:find("Dark")) and rose_pine_plugin.main or rose_pine_plugin.dawn

config.colors = rose_pine_theme.colors()
config.window_frame = rose_pine_theme.window_frame()

-- Finally, return the configuration to wezterm:
return config
