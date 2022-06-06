local wezterm = require 'wezterm';

return {
  initial_cols = 140,
  initial_rows = 40,

  default_cwd = "C:\\work",
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

  keys = {
    { key = "h", mods="CTRL|SHIFT|ALT",
      action=wezterm.action{ActivatePaneDirection="Left"}},
    { key = "l", mods="CTRL|SHIFT|ALT",
      action=wezterm.action{ActivatePaneDirection="Right"}},
    { key = "k", mods="CTRL|SHIFT|ALT",
      action=wezterm.action{ActivatePaneDirection="Up"}},
    { key = "j", mods="CTRL|SHIFT|ALT",
      action=wezterm.action{ActivatePaneDirection="Down"}},

    { key = "l", mods="CTRL|SHIFT",
      action=wezterm.action{ClearScrollback="ScrollbackOnly"}},
  }
}
