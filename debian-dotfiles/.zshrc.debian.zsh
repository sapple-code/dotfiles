if [[ -x /usr/bin/dircolors ]]; then
  if [[ -r "$HOME/.dircolors" ]]; then
    eval "$(dircolors -b "$HOME/.dircolors")"
  else
    eval "$(dircolors -b)"
  fi
  alias ls='ls --color=auto'
fi

if [[ -r "$HOME/.asdf/asdf.sh" ]]; then
  source "$HOME/.asdf/asdf.sh"
  fpath=("$HOME/.asdf/completions" $fpath)
fi

if [[ -n "${DISPLAY:-}" ]]; then
  command -v setxkbmap >/dev/null 2>&1 && setxkbmap -option 'caps:ctrl_modifier'
  command -v xcape >/dev/null 2>&1 && xcape -e 'Caps_Lock=Escape'
fi

alias pbcopy='xclip -selection clipboard -in'
alias pbpaste='xclip -selection clipboard -out'
alias dokku='ssh -t dokku@159.65.67.95'
