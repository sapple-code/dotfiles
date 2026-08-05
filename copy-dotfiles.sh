#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

install_file() {
    local source="$1"
    local target="$2"

    mkdir -p "$(dirname -- "$target")"
    cp -p "$source" "$target"
}

common_files=(
    .aliases
    .bash_profile
    .bash_prompt
    .bashrc
    .bashrc.shared.bash
    .fzf.bash
    .git-completion.bash
    .git-flow-completion.bash
    .gitconfig
    .gitignore_global
    .vimrc
)

for file in "${common_files[@]}"; do
    install_file "$repo_dir/$file" "$HOME/$file"
done

mkdir -p "$HOME/z"
cp -Rp "$repo_dir/z/." "$HOME/z/"

case "$(uname -s)" in
    Darwin)
        install_file "$repo_dir/macos-dotfiles/.bashrc.macos.bash" "$HOME/.bashrc.macos.bash"
        install_file "$repo_dir/macos-dotfiles/.spacemacs" "$HOME/.spacemacs"
        install_file "$repo_dir/macos-dotfiles/.tmux.conf" "$HOME/.tmux.conf"
        install_file "$repo_dir/macos-dotfiles/bin/ec" "$HOME/bin/ec"
        install_file "$repo_dir/macos-dotfiles/bin/emacs" "$HOME/bin/emacs"
        install_file "$repo_dir/macos-dotfiles/bin/emacsserver" "$HOME/bin/emacsserver"
        install_file "$repo_dir/.dotfiles/emacs.31.init.el" "$HOME/.emacs.d/init.el"
        install_file "$repo_dir/macos-dotfiles/ghostty/config" "$HOME/.config/ghostty/config"
        install_file "$repo_dir/macos-dotfiles/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
        ;;
    Linux)
        install_file "$repo_dir/debian-dotfiles/.bashrc.debian.bash" "$HOME/.bashrc.debian.bash"
        install_file "$repo_dir/debian-dotfiles/.spacemacs" "$HOME/.spacemacs"
        install_file "$repo_dir/debian-dotfiles/.tmux.conf" "$HOME/.tmux.conf"
        install_file "$repo_dir/debian-dotfiles/.emacs.d/init.el" "$HOME/.emacs.d/init.el"
        ;;
    *)
        echo "Unsupported operating system: $(uname -s)" >&2
        exit 1
        ;;
esac

echo "Installed dotfiles from $repo_dir"
