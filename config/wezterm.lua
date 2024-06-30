local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Catppuccin Macchiato'
config.font_size = 13.0
config.font = wezterm.font {
  family = 'MonoLisa Nerd Font Mono',
  harfbuzz_features = { 'liga=0' },
}
config.freetype_load_target = 'Normal'
config.freetype_render_target = 'Normal'
config.line_height = 1.4
config.hide_tab_bar_if_only_one_tab = true
config.term = "xterm-256color"
config.automatically_reload_config = true
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
return config
