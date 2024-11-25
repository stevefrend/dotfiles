local wezterm = require("wezterm")

return {
	color_scheme = "Tokyo Night",
	set_environment_variables = {
		TERM = "xterm-256color",
	},
	window_padding = {
		left = 20,
		right = 20,
		top = 10,
		bottom = 10,
	},
	window_decorations = "RESIZE", -- Buttonless decorations
	window_background_opacity = 0.8,
	enable_tab_bar = false,
	macos_window_background_blur = 45, -- Blur effect for macOS

	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 15.0,
}
