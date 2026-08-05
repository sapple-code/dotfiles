# Dotfiles

Zsh and editor configuration for macOS and Debian Linux. The older Bash files
remain available for compatibility.

## Install

```sh
git clone git@github.com:sapple-code/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
./copy-dotfiles.sh
```

The installer selects the platform-specific files and copies everything into
the standard locations under `$HOME`. See [the macOS setup guide](macos-dotfiles/README.md)
for Homebrew dependencies and application setup.

After the shell config is loaded, use `dgit` to run Git commands against this
checkout and `dotfiles` to re-run the installer.

## Zsh configuration layers

`~/.zshrc` loads configuration in this order:

1. `~/.zshrc.macos.zsh` or `~/.zshrc.debian.zsh`
2. `~/.zshrc.shared.zsh`
3. `~/.zshrc.company.zsh`, when present

The company file is intentionally local and is never installed or committed,
so it can safely contain private environment setup and company-specific
overrides.
