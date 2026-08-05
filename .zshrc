case "$(uname -s)" in
  Darwin)
    [[ -r "$HOME/.zshrc.macos.zsh" ]] && source "$HOME/.zshrc.macos.zsh"
    ;;
  Linux)
    [[ -r "$HOME/.zshrc.debian.zsh" ]] && source "$HOME/.zshrc.debian.zsh"
    ;;
esac

[[ -r "$HOME/.zshrc.shared.zsh" ]] && source "$HOME/.zshrc.shared.zsh"

# This file stays local so company credentials and overrides are never
# committed or overwritten by the dotfiles installer.
[[ -r "$HOME/.zshrc.company.zsh" ]] && source "$HOME/.zshrc.company.zsh"
