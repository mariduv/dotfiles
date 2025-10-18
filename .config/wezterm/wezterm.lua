local wezterm = require 'wezterm'
local c = wezterm.config_builder()

local is_windows = wezterm.target_triple:match("windows")
local is_mac = wezterm.target_triple:match("darwin")

c.font = wezterm.font_with_fallback {
  'DejaVu Sans Mono',
  'Cascadia Code',
  'Consolas',
  'Menlo',
}

c.font_size = 10.0
if is_mac then
  c.font_size = 12.0
end

c.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
c.freetype_load_target = "Light"

c.animation_fps = 1
c.cursor_blink_ease_in = 'Constant'
c.cursor_blink_ease_out = 'Constant'

c.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

c.window_padding = {
  left = '0.5cell', right = '0.5cell',
  top = '0.4cell', bottom = '0.4cell',
}
c.initial_cols, c.initial_rows = 120, 35

c.colors = { background = "#080808" }
if is_mac then
  -- there is no frame at all otherwise, but this misses the corners.
  c.window_frame = {
    border_left_width = 1,
    border_right_width = 1,
    border_bottom_height = 1,
    border_left_color = "#262626",
    border_right_color = "#262626",
    border_bottom_color = "#262626",
  }
end

if is_windows then
  -- c.default_prog = { 'pwsh.exe' }
  -- So WSL always breaks window focus on start, both windows terminal and wezterm
  c.default_prog = { 'wsl.exe', '--cd', '~' }

  c.launch_menu = {
    { label = 'pwsh',     args = { 'pwsh.exe' } },
    { label = 'cmd',      args = { 'cmd.exe' } },
    { label = "wsl nvim", args = { "wsl.exe", "--cd", "~", "nvim" } },
  }

  -- on Intel Iris Xe graphics, there's artifacting unless you use `prefer_egl`
  -- or `front_end = "WebGpu"`.  WebGpu renders fonts too heavy though.
  -- Also, I think prefer_egl is the -intended- default?
  c.prefer_egl = true
end

local ok, m = pcall(require, "wezterm_local")
if ok then
  m.apply(c)
end

return c
