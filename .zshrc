# ~/.zshrc

# Basic pronmpt
PROMPT='%B%F{yellow}zsh%f%b %B%F{blue}%~%f%b %(?.%F{green}.%F{red})%(!.❯❯.❯)%f '
RPROMPT=''
ZLE_RPROMPT_INDENT=0

# Source alias
alias s='source ~/.zshrc'

# Starship
export STARSHIP_CONFIG="$HOME/.config/starship/config.toml"
eval "$(starship init zsh)"

# uv (added by uv install script)
. "$HOME/.local/bin/env"

# uv autocompletion
autoload -Uz compinit && compinit # REQUIREMENT NOT DOCUMENTED
eval "$(uv generate-shell-completion zsh)"

# Set bat theme based on macOS appearance
set_bat_theme() {
  if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q "Dark"; then
    export BAT_THEME="Catppuccin Mocha"
  else
    export BAT_THEME="Catppuccin Latte"
  fi
}
set_bat_theme

# eza
alias ls='eza --color=always --icons=always'
alias tree='eza --tree --color=always --icons=always'

# zoxide
eval "$(zoxide init zsh)"
alias cd="z"

# fzf
source <(fzf --zsh)

# CONTROL + R
# - Search commmand history
# - Optionally copy selected command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Use CONTROL + Y to copy command into clipboard (ZSH)'"

# CONTROL + T
# - Search files and directories
# - Preview file content using bat or directory structure using eza
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'if [ -d {} ]; then eza --tree --color=always --icons=always {}; else bat -n --color=always {}; fi'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
  --color header:italic
  --header 'Use CONTROL + / to toggle preview window (ZSH)'"

# OPTION + C
# Terminal: Requires 'Use Option as Meta key'
# Ghostty: Requires 'macos-option-as-alt = true
# - Search directories
# - Print tree structure in the preview window
# - cd into the selected directory 
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'eza --tree --colour=always --icons=always {}'
  --color header:italic
  --header '(ZSH)'"

# Use fd instead of find and ignore git files (in .gitignore)
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd for listing path candidates
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# More fzf previews
_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)           fzf --preview "$eza_or_bat" "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'" "$@" ;;
    ssh)          fzf --preview 'dig {}' "$@" ;;
    *)            fzf --preview "$eza_or_bat" "$@" ;;
  esac
}

# thefuck
# Alias is: fuck
eval $(thefuck --alias)

# yt-dlp
alias youtube='yt-dlp'