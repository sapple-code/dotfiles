# Dotfiles

Shared Bash, Zsh, and editor configuration for macOS and Debian Linux.

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
