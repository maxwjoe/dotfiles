local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()
local is_windows = wezterm.target_triple:find("windows") ~= nil
local is_macos = wezterm.target_triple:find("darwin") ~= nil

config.max_fps = 120

-- Fonts
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 13

-- Theme
config.color_scheme = "Github Dark"

-- Platform overrides
if is_windows then
  config.default_prog = { "powershell.exe", "-NoLogo" }
  config.win32_system_backdrop = "Acrylic"
  config.window_background_opacity = 0.95
  config.window_frame = { font_size = 10.0 }
end

if is_macos then
  config.font_size = 15.0
  config.window_background_opacity = 0.8
  config.macos_window_background_blur = 50
  config.window_frame = { font_size = 13.0 }
end

-- Tabs
config.enable_tab_bar = true

-- Leader key
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

config.keys = {
  { key = "s", mods = "LEADER", action = act.ActivateKeyTable({ name = "split_mode", one_shot = true }) },
  { key = "t", mods = "LEADER", action = act.ActivateKeyTable({ name = "tab_mode",  one_shot = true }) },
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left")  },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down")  },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up")    },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
}

config.key_tables = {
  split_mode = {
    { key = "v",      action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "h",      action = act.SplitVertical({   domain = "CurrentPaneDomain" }) },
    { key = "x",      action = act.CloseCurrentPane({ confirm = true }) },
    { key = "Escape", action = "PopKeyTable" },
  },
  tab_mode = {
    { key = "o",      action = act.SpawnTab("CurrentPaneDomain") },
    { key = "x",      action = act.CloseCurrentTab({ confirm = true }) },
    { key = "Escape", action = "PopKeyTable" },
  },
}

return config
