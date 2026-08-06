# Add Homebrew and user binaries to PATH on Apple Silicon and Intel Macs.
if command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)"
fi
PATH="$HOME/bin:$PATH"
export PATH

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

if command -v brew >/dev/null 2>&1 && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
    . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
fi
[ -r ~/.git-completion.bash ] && source ~/.git-completion.bash

set -o vi
bind 'set show-mode-in-prompt on'

echo "Sourced .bashrc.macos.bash"
