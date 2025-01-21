# ~/.config/zsh/zshrc/uv.zsh

. "$HOME/.local/bin/env"

# uv autocompletion
autoload -Uz compinit && compinit # REQUIREMENT NOT DOCUMENTED
eval "$(uv generate-shell-completion zsh)"
