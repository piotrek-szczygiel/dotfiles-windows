local wezterm = require 'wezterm';
local dimmer = {brightness=0.01}

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
  },

  background = {
    -- This is the deepest/back-most layer. It will be rendered first
    {
      source = {File="/dev/background/Backgrounds/spaceship_bg_1.png"},
      -- The texture tiles vertically but not horizontally.
      -- When we repeat it, mirror it so that it appears "more seamless".
      -- An alternative to this is to set `width = "100%"` and have
      -- it stretch across the display
      repeat_x = "Mirror",
      hsb = dimmer,
      -- When the viewport scrolls, move this layer 10% of the number of
      -- pixels moved by the main viewport. This makes it appear to be
      -- further behind the text.
      attachment = {Parallax=0.1},
    },
    -- Subsequent layers are rendered over the top of each other
    {
      source = {File="/dev/background/Overlays/overlay_1_spines.png"},
      width = "100%",
      repeat_x = "NoRepeat",

      -- position the spins starting at the bottom, and repeating every
      -- two screens.
      vertical_align = "Bottom",
      repeat_y_size = "200%",
      hsb = dimmer,

      -- The parallax factor is higher than the background layer, so this
      -- one will appear to be closer when we scroll
      attachment = {Parallax=0.2},
    },
    {
      source = {File="/dev/background/Overlays/overlay_2_alienball.png"},
      width = "100%",
      repeat_x = "NoRepeat",

      -- start at 10% of the screen and repeat every 2 screens
      vertical_offset = "10%",
      repeat_y_size = "200%",
      hsb = dimmer,
      attachment = {Parallax=0.3},
    },
    {
      source = {File="/dev/background/Overlays/overlay_3_lobster.png"},
      width = "100%",
      repeat_x = "NoRepeat",

      vertical_offset = "30%",
      repeat_y_size = "200%",
      hsb = dimmer,
      attachment = {Parallax=0.4},
    },
    {
      source = {File="/dev/background/Overlays/overlay_4_spiderlegs.png"},
      width = "100%",
      repeat_x = "NoRepeat",

      vertical_offset = "50%",
      repeat_y_size = "150%",
      hsb = dimmer,
      attachment = {Parallax=0.5},
    }
  }
}