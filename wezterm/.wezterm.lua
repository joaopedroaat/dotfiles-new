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

local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function get_rose_pine_variant(appearance)
	if appearance:find("Dark") then
		return rose_pine_plugin.main
	else
		return rose_pine_plugin.dawn
	end
end

local current_theme_variant_function = get_rose_pine_variant(get_appearance())

config.colors = current_theme_variant_function.colors()
config.window_frame = current_theme_variant_function.window_frame()

wezterm.on("theme-changed", function(window, pane)
	local current_appearance = get_appearance()
end)

-- Finally, return the configuration to wezterm:
return config
