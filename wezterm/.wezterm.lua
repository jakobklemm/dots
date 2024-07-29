-- Pull in the wezterm API
local wezterm = require("wezterm")

local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.font = wezterm.font("Lilex Nerd Font")
config.font_size = 12

config.enable_tab_bar = false

config.audible_bell = "Disabled"

config.skip_close_confirmation_for_processes_named = {
	"bash",
	"sh",
	"zsh",
	"fish",
	"tmux",
	"nu",
	"cmd.exe",
	"pwsh.exe",
	"powershell.exe",
}

-- config.window_decorations = "RESIZE"

config.window_background_opacity = 0.99

config.color_scheme = "Catppuccin Mocha"

config.keys = {
	{
		key = "Backspace",
		mods = "CTRL",
		action = act.SendKey({ key = "w", mods = "CTRL" }),
	},
}

-- and finally, return the configuration to wezterm
return config
