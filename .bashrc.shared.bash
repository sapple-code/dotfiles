# Manage the checkout directly and re-run its installer when needed.
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dev/dotfiles}"
alias dgit='git -C "$DOTFILES_DIR"'
alias dotfiles='"$DOTFILES_DIR"/copy-dotfiles.sh'

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

# install z which builds up a database of common directories
# type `z dir-name` to jump to the directory name with autocomplete
. ~/z/z.sh

# install fzf which adds fuzzy autocompletion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

echo "Sourced .bashrc.shared.bash"
