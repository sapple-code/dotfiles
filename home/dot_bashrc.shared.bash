## Better History 
# https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it
# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"


export VISUAL=vim
export EDITOR="$VISUAL"

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

_mise_bin="$(command -v mise 2>/dev/null || true)"
for _mise_candidate in /opt/homebrew/bin/mise /usr/local/bin/mise; do
  if [[ -z "$_mise_bin" && -x "$_mise_candidate" ]]; then
    _mise_bin="$_mise_candidate"
  fi
done
if [[ -n "$_mise_bin" ]]; then
  eval "$("$_mise_bin" activate bash)"
fi
unset _mise_bin _mise_candidate

# install z which builds up a database of common directories
# type `z dir-name` to jump to the directory name with autocomplete
. ~/z/z.sh

# install fzf which adds fuzzy autocompletion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

echo "Sourced .bashrc.shared.bash"
