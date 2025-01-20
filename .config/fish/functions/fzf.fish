# ~/.config/fish/functions/fzf.fish
    
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
            fzf --preview 'if test -d {}; eza --tree --colour=always --icons=always {}; else; bat -n --color=always {}; end' $argv
    end
end