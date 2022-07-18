local wezterm = require 'wezterm';
local dimmer = {brightness=0.02}

return {
  color_scheme = "UnderTheSea",

  initial_cols = 120,
  initial_rows = 30,

  default_cwd = "/dev",
  enable_scroll_bar = true,
  hide_tab_bar_if_only_one_tab = true,

  audible_bell = "Disabled",
  visual_bell = {
    fade_in_function = "EaseIn",
    fade_in_duration_ms = 150,
    fade_out_function = "EaseOut",
    fade_out_duration_ms = 150,
  },

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

  launch_menu = {
    {
      label = "CMD",
      args = {"cmd"},
    },
    {
      label = "WSL",
      args = {"wsl"},
    },
  },

  keys = {
    { key = "w", mods="CTRL|SHIFT",
      action=wezterm.action.SpawnCommandInNewTab{args={"wsl"}}},

    { key = "|", mods="CTRL|SHIFT",
      action=wezterm.action.SplitHorizontal{domain="CurrentPaneDomain"}},
    { key = "_", mods="CTRL|SHIFT",
      action=wezterm.action.SplitVertical{domain="CurrentPaneDomain"}},

    { key = "|", mods="CTRL|SHIFT|ALT",
      action=wezterm.action.SplitHorizontal{domain="CurrentPaneDomain", args={"wsl"}}},
    { key = "_", mods="CTRL|SHIFT|ALT",
      action=wezterm.action.SplitVertical{domain="CurrentPaneDomain", args={"wsl"}}},

    { key = "l", mods="CTRL|SHIFT",
      action=wezterm.action{ClearScrollback="ScrollbackOnly"}},

    { key = "h", mods="CTRL|SHIFT|ALT",
      action=wezterm.action{ActivatePaneDirection="Left"}},
    { key = "l", mods="CTRL|SHIFT|ALT",
      action=wezterm.action{ActivatePaneDirection="Right"}},
    { key = "k", mods="CTRL|SHIFT|ALT",
      action=wezterm.action{ActivatePaneDirection="Up"}},
    { key = "j", mods="CTRL|SHIFT|ALT",
      action=wezterm.action{ActivatePaneDirection="Down"}},
  },
}