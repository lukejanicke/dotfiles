# ~/.config/fish/conf.d/bat.fish

source ~/.config/fish/functions/bat.fish

if status is-interactive
    set_bat_theme
end