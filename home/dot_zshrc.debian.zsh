if [[ -x /usr/bin/dircolors ]]; then
  if [[ -r "$HOME/.dircolors" ]]; then
    eval "$(dircolors -b "$HOME/.dircolors")"
  else
    eval "$(dircolors -b)"
  fi
  alias ls='ls --color=auto'
fi

if [[ -n "${DISPLAY:-}" ]]; then
  command -v setxkbmap >/dev/null 2>&1 && setxkbmap -option 'caps:ctrl_modifier'
  command -v xcape >/dev/null 2>&1 && xcape -e 'Caps_Lock=Escape'
fi

alias pbcopy='xclip -selection clipboard -in'
alias pbpaste='xclip -selection clipboard -out'
