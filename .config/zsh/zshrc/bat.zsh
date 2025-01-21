# ~/.config/zsh/zshrc/bat.zsh

# Set bat theme based on macOS appearance
set_bat_theme() {
  if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q "Dark"; then
    export BAT_THEME="Catppuccin Mocha"
  else
    export BAT_THEME="Catppuccin Latte"
  fi
}
set_bat_theme
