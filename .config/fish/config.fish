# ~/.config/fish/config.fish

# Homebrew
# This needs to precede Starship Prompt and SHELL reset
# set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
fish_add_path /opt/homebrew/bin /opt/homebrew/sbin
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew
set -gx MANPATH /opt/homebrew/share/man $MANPATH
set -gx INFOPATH /opt/homebrew/share/info $INFOPATH

# MacTeX
set -gx PATH /usr/local/texlive/2024/bin/universal-darwin $PATH

if status is-interactive

    # Fish greeting
    set -U fish_greeting ""

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

    # Starship
    # Should be preceded by Homebrew path configuration!
    starship init fish | source

    # Source
    function s
        source ~/.config/fish/config.fish
    end

    # pyenv
    set -Ux PYENV_ROOT $HOME/.pyenv
    set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
    pyenv init - fish | source

    # eza
    function ls
        eza --color=always --icons=always $argv
    end
    function tree
        eza --tree --color=always --icons=always $argv
    end

    # yt-dlp
    function youtube
        yt-dlp $argv
    end

    # fzf
    fzf --fish | source

    # CONTROL + R
    # - Search commmand history
    # - Optionally copy selected command into clipboard using pbcopy
    set -x FZF_CTRL_R_OPTS "
        --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
        --color header:italic
        --header 'Use CONTROL + Y to copy command into clipboard (FISH)'"

    # Choose eza or bat command dynamically
    set eza_or_bat 'if test -d {}; eza --tree --colour=always --icons=always {}; else; bat -n --color=always {}; end'

    # CONTROL + T
    # - Search files and diorectories
    # - Preview file content using bat or directory structure using eza
    set -x FZF_CTRL_T_OPTS "
        --walker-skip .git,node_modules,target
        --preview '$eza_or_bat'
        --bind 'ctrl-/:change-preview-window(down|hidden|)'
        --color header:italic
        --header 'Use CONTROL + / to toggle preview window (FISH)'"

    # OPTION + C
    # - Search directories
    # - Print tree structure the preview window
    # - cd into the selected directory 
    set -x FZF_ALT_C_OPTS "
        --walker-skip .git,node_modules,target
        --preview 'eza --tree --colour=always --icons=always {}'
        --color header:italic
        --header '(FISH)'"

    # Use fd instead of find and ignore git files (in .gitignore)
    set -x FZF_DEFAULT_COMMAND "fd --hidden --strip-cwd-prefix --exclude .git"
    set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    set -x FZF_ALT_C_COMMAND "fd --type=d --hidden --strip-cwd-prefix --exclude .git"

    # Use fd for listing path candidates
    function _fzf_compgen_path
        fd --hidden --exclude .git . $argv
    end

    # Use fd to generate the list for directory completion
    function _fzf_compgen_dir
        fd --type=d --hidden --exclude .git . $argv
    end

    # More fzf previews
    function _fzf_comprun
        set command $argv[1]
        set -e argv[1]
        switch $command
            case cd
                fzf --preview 'eza --tree --color=always {} | head -200' $argv
            case export
                fzf --preview "command echo $argv" $argv
            case unset
                fzf --preview "command echo $argv" $argv
            case ssh
                fzf --preview 'dig {}' $argv
            case '*'
                fzf --preview $eza_or_bat $argv
        end
    end

    # thefuck
    # Alias is: fuck
    thefuck --alias | source

    # zoxide
    zoxide init fish | source
    function cd
        z $argv
    end

    # Set themes based on macOS appearance
    function set_themes
        if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q "Dark"
            set -gx BAT_THEME "Catppuccin Mocha"
            fish_config theme choose "Catppuccin Mocha"
        else
            set -gx BAT_THEME "Catppuccin Latte"
            fish_config theme choose "Catppuccin Latte"
        end
    end
    set_themes

end
