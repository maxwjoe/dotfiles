-- Setup
local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()
local is_windows = wezterm.target_triple:find("windows") ~= nil
local is_macos = wezterm.target_triple:find("darwin") ~= nil

config.max_fps = 120

-- Fonts
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 19

-- Theme
config.color_scheme = "Github Dark"

if is_windows then
  config.win32_system_backdrop = "Acrylic"
  config.window_background_opacity = 0.7
  config.window_frame = config.window_frame or {}
  config.window_frame.font_size = 10.0
end

if is_macos then
  config.window_background_opacity = 0.8
  config.macos_window_background_blur = 50
  config.font_size = 15.0
  config.window_frame = config.window_frame or {}
  config.window_frame.font_size = 13.0
end

-- Windows and Tabs
config.enable_tab_bar = true
config.window_decorations = "RESIZE"

-- Leader

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

-- Multiplexing

config.keys = {
	-- leader + s -> opens split commands (sv, sh, sx)
	{ key = "s", mods = "LEADER", action = act.ActivateKeyTable({ name = "split_mode", one_shot = true }) },
 
	-- leader + t -> opens tab commands (to, tx)
	{ key = "t", mods = "LEADER", action = act.ActivateKeyTable({ name = "tab_mode", one_shot = true }) },

	-- pane navigation: LEADER+h/j/k/l, matching vim's direct binding 
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
}
 
config.key_tables = {
	split_mode = {
		{ key = "v", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) }, -- sv: side-by-side
		{ key = "h", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },   -- sh: stacked
		{ key = "x", action = act.CloseCurrentPane({ confirm = true }) },               -- sx: close split
		{ key = "Escape", action = "PopKeyTable" },
	},
	tab_mode = {
		{ key = "o", action = act.SpawnTab("CurrentPaneDomain") },                       -- to: new tab
		{ key = "x", action = act.CloseCurrentTab({ confirm = true }) },                 -- tx: close tab
		{ key = "Escape", action = "PopKeyTable" },
	},
}

-- Return
return config

