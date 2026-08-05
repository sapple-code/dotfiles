[[ -r "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dev/dotfiles}"
alias dgit='git -C "$DOTFILES_DIR"'
alias dotfiles='"$DOTFILES_DIR"/copy-dotfiles.sh'

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

export VISUAL=vim
export EDITOR="$VISUAL"

for file in "$HOME"/.{path,exports,aliases,functions,extra}; do
  [[ -r "$file" ]] && source "$file"
done
unset file

[[ -r "$HOME/z/z.sh" ]] && source "$HOME/z/z.sh"

autoload -Uz compinit && compinit

if [[ -o interactive ]] && command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

bindkey -v
export KEYTIMEOUT=1

autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats ' on %F{61}%b%u%c%f'
zstyle ':vcs_info:git:*' actionformats ' on %F{61}%b|%a%u%c%f'
zstyle ':vcs_info:git:*' stagedstr '*'
zstyle ':vcs_info:git:*' unstagedstr '*'

precmd() {
  vcs_info
}

setopt PROMPT_SUBST
PROMPT='%B%F{125}%n %F{244}at %F{166}%m %F{244}in %F{64}%~%f${vcs_info_msg_0_}
%# %b'
PROMPT2='%F{166}→ %f'
