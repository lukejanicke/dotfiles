-- ~/.config/wezterm/wezterm.lua

local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- Catppuccin Theme
function scheme_for_appearance(appearance)
	if appearance:find('Dark') then
		return 'Catppuccin Mocha'
	else
		return 'Catppuccin Latte'
	end
end
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

-- Fonts
config.font = wezterm.font('IosevkaFixed Nerd Font Mono')
config.font_size = 13

-- Window
config.window_decorations = 'RESIZE'

-- Native macOS fullscreen
config.native_macos_fullscreen_mode = true

-- Tab bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

-- Padding
config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 20,
}

-- Confirm on close
config.window_close_confirmation = 'NeverPrompt'

-- Shortcuts
config.keys = {
	{ key = 'f', mods = 'CTRL|CMD', action = wezterm.action.ToggleFullScreen },
	{ key = 'K', mods = 'SHIFT|CMD', action = wezterm.action.ClearScrollback 'ScrollbackOnly' },
	{ key = 'k', mods = 'CMD', action = wezterm.action.ClearScrollback 'ScrollbackAndViewport' }
}

return config
