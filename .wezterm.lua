local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.keys = {
	{
		key = "+",
		mods = "CMD",
		action = wezterm.action.IncreaseFontSize,
	},
}

config.color_scheme = "Tokyo Night"
config.set_environment_variables = {
	TERM = "xterm-256color",
}
config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 20,
}
-- config.window_decorations = "RESIZE" -- Buttonless decoration
config.window_background_opacity = 0.8
-- config.enable_tab_bar = false
config.macos_window_background_blur = 45 -- Blur effect for macOS

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 15.0

return config
