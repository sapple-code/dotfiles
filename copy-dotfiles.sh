#!/usr/bin/env bash

set -euo pipefail

usage() {
    cat <<'EOF'
Usage: ./copy-dotfiles.sh [--company | --no-company]

Install shared and platform dotfiles into $HOME.

  --company     Install or update the local company Zsh config from its template.
  --no-company  Leave the local company Zsh config untouched without prompting.
  -h, --help    Show this help.

With neither flag, an interactive terminal prompts before installing or
updating the company config. Non-interactive runs skip it.
EOF
}

company_mode="ask"
while [[ $# -gt 0 ]]; do
    case "$1" in
        --company)
            company_mode="install"
            ;;
        --no-company)
            company_mode="skip"
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            usage >&2
            exit 2
            ;;
    esac
    shift
done

repo_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

install_file() {
    local source="$1"
    local target="$2"

    mkdir -p "$(dirname -- "$target")"
    cp -p "$source" "$target"
}

install_company_config() {
    local template="$repo_dir/.zshrc.company.zsh.template"
    local target="$HOME/.zshrc.company.zsh"
    local answer=""

    case "$company_mode" in
        install)
            answer="yes"
            ;;
        skip)
            return
            ;;
        ask)
            if [[ ! -t 0 ]]; then
                echo "Skipped company config in non-interactive mode; use --company to install it."
                return
            fi
            if [[ -e "$target" ]]; then
                read -r -p "Update $target from the committed template? [y/N] " answer
            else
                read -r -p "Install the optional company Zsh config? [y/N] " answer
            fi
            ;;
    esac

    case "$answer" in
        y|Y|yes|YES)
            if [[ -e "$target" ]] && ! cmp -s "$template" "$target"; then
                local backup_dir="$HOME/.dotfiles-backups/$(date +%Y%m%d-%H%M%S)-company"
                mkdir -p "$backup_dir"
                cp -p "$target" "$backup_dir/.zshrc.company.zsh"
                echo "Backed up the previous company config to $backup_dir"
            fi
            install_file "$template" "$target"
            echo "Installed company config at $target"
            ;;
    esac
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
    .zshrc
    .zshrc.shared.zsh
)

for file in "${common_files[@]}"; do
    install_file "$repo_dir/$file" "$HOME/$file"
done

mkdir -p "$HOME/z"
cp -Rp "$repo_dir/z/." "$HOME/z/"

case "$(uname -s)" in
    Darwin)
        install_file "$repo_dir/macos-dotfiles/.bashrc.macos.bash" "$HOME/.bashrc.macos.bash"
        install_file "$repo_dir/macos-dotfiles/.zshrc.macos.zsh" "$HOME/.zshrc.macos.zsh"
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
        install_file "$repo_dir/debian-dotfiles/.zshrc.debian.zsh" "$HOME/.zshrc.debian.zsh"
        install_file "$repo_dir/debian-dotfiles/.spacemacs" "$HOME/.spacemacs"
        install_file "$repo_dir/debian-dotfiles/.tmux.conf" "$HOME/.tmux.conf"
        install_file "$repo_dir/debian-dotfiles/.emacs.d/init.el" "$HOME/.emacs.d/init.el"
        ;;
    *)
        echo "Unsupported operating system: $(uname -s)" >&2
        exit 1
        ;;
esac

install_company_config

echo "Installed dotfiles from $repo_dir"
