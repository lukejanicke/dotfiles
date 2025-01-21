# ~/.zshenv

_source_dir() {
  local dir="$1"
  if [[ -d "$dir" ]]; then
    for file in "$dir"/*.zsh(N); do
      if [[ -f "$file" ]]; then
        source "$file"
      fi
    done
  fi
}

_source_dir ~/.config/zsh/zshenv
