# ~/.config/fish/config.fish

if status is-interactive

    # No Fish greeting
    set fish_greeting ""

    # No Fish window title bar updates
    function fish_title; end

    # Fish prompt
    function fish_prompt
        set -l last_status $status
        set_color --bold yellow
        echo -n fish
        set_color normal
        command echo -n " "
        set_color --bold blue
        command echo -n (prompt_pwd)
        set_color normal
        command echo -n " "
        if test $last_status -eq 0
            set_color green
        else
            set_color red
        end
        if test (id -u) -eq 0
            command echo -n "❯❯"
        else
            command echo -n "❯"
        end
        set_color normal
        command echo -n " "
    end

    # Fish right prompt
    function fish_right_prompt; 
        # EMPTY FOR NOW
    end

    # Set Fish theme based on macOS appearance
    function set_fish_theme
        if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q "Dark"
            fish_config theme choose "Catppuccin Mocha"
        else
            fish_config theme choose "Catppuccin Latte"
        end
    end
    set_fish_theme

    # Source
    function s
        source ~/.config/fish/config.fish
    end

end