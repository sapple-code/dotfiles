# fzf prints the correct Bash integration for the installed Homebrew prefix.
if [[ $- == *i* ]] && command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --bash)"
fi
