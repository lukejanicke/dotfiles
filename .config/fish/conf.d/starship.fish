# ~/.config/fish/conf.d/starship.fish

if status is-interactive

    # Starship
    set -x STARSHIP_CONFIG "$HOME/.config/starship/config.toml"
    starship init fish | source

end