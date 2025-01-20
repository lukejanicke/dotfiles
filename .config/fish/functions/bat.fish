# ~/.config/fish/functions/bat.fish

# Set bat theme based on macOS appearance
function set_bat_theme
    if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q "Dark"
        set -gx BAT_THEME "Catppuccin Mocha"
    else
        set -gx BAT_THEME "Catppuccin Latte"  
    end
end