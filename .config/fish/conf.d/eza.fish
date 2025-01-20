# ~/.config/fish/conf.d/eza.fish

if status is-interactive

    # Enhance ls command with eza
    function ls
        eza --color=always --icons=always $argv
    end
    function tree
        eza --tree --color=always --icons=always $argv
    end

end