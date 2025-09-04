-- WezTerm configuration for enhanced terminal experience
local wezterm = require 'wezterm'

return {
  -- Appearance
  color_scheme = "Catppuccin Mocha",
  font = wezterm.font("JetBrains Mono", { weight = "Medium" }),
  font_size = 12.0,
  
  -- Window settings
  window_decorations = "RESIZE",
  window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
  },
  
  -- Tab bar
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = false,
  
  -- Key bindings
  keys = {
    -- Split panes
    { key = "%", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal },
    { key = '"', mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical },
    
    -- Navigate panes
    { key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },
    { key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
    
    -- Copy mode
    { key = "[", mods = "CTRL|SHIFT", action = wezterm.action.ActivateCopyMode },
  },
  
  -- Mouse bindings
  mouse_bindings = {
    -- Right click to paste
    {
      event = { Down = { streak = 1, button = "Right" } },
      mods = "NONE",
      action = wezterm.action.PasteFrom("Clipboard"),
    },
  },
  
  -- Performance
  enable_scroll_bar = false,
  scrollback_lines = 10000,
  
  -- Bell
  audible_bell = "Disabled",
  visual_bell = {
    fade_in_duration_ms = 75,
    fade_out_duration_ms = 75,
    target = "CursorColor",
  },
  
  -- Hyperlinks
  hyperlink_rules = wezterm.default_hyperlink_rules(),
}
