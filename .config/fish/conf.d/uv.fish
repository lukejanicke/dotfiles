# ~/.config/fish/conf.d/uv.fish

source "$HOME/.local/bin/env.fish" # Added by install script

if status is-interactive

    # uv autocompletion
    uv generate-shell-completion fish | source

end