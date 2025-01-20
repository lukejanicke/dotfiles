# ~/.config/fish/conf.d/zoxide.fish

if status is-interactive

    zoxide init fish | source
    function cd
        z $argv
    end

end
