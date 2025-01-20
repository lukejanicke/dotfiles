# ~/.config/fish/conf.d/pyenv.fish

if status is-interactive
    pyenv init - fish | source
end