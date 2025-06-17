-- Pull in the wezterm API
local wezterm = require("wezterm")
local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").main

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
config.window_decorations = "RESIZE"
config.automatically_reload_config = true

-- Fix wezterm on gnome window maximize
config.enable_wayland = false

-- Set theme
config.colors = theme.colors()
config.window_frame = theme.window_frame()

-- Finally, return the configuration to wezterm:
return config
