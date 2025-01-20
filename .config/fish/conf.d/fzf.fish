# ~/.config/fish/conf.d/fzf.fish

if status is-interactive

    # Source fzf fish integration
    fzf --fish | source

    # Use fd instead of find and ignore git files (if there is a .gitignore)
    set -x FZF_DEFAULT_COMMAND "fd --hidden --strip-cwd-prefix --exclude .git"
    set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    set -x FZF_ALT_C_COMMAND "fd --type=d --hidden --strip-cwd-prefix --exclude .git"

    # Choose eza or bat command dynamically
    set -g EZA_OR_BAT 'if test -d {}; eza --tree --colour=always --icons=always {}; else; bat -n --color=always {}; end'

    # CONTROL + R
    # - Search commmand history
    # - Optionally copy selected command into clipboard using pbcopy
    set -x FZF_CTRL_R_OPTS "
        --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
        --color header:italic
        --header 'Use CONTROL + Y to copy command into clipboard (FISH)'"

    # CONTROL + T
    # - Search files and diorectories
    # - Preview file content using bat or directory structure using eza
    set -x FZF_CTRL_T_OPTS "
        --walker-skip .git,node_modules,target
        --preview 'if test -d {}; eza --tree --colour=always --icons=always {}; else; bat -n --color=always {}; end'
        --bind 'ctrl-/:change-preview-window(down|hidden|)'
        --color header:italic
        --header 'Use CONTROL + / to toggle preview window (FISH)'"

    # OPTION + C
    # Terminal: Requires 'Use Option as Meta key'
	# Ghostty: Requires 'macos-option-as-alt = true'
    # - Search directories
    # - Print tree structure the preview window
    # - cd into the selected directory 
    set -x FZF_ALT_C_OPTS "
        --walker-skip .git,node_modules,target
        --preview 'eza --tree --colour=always --icons=always {}'
        --color header:italic
        --header '(FISH)'"

end