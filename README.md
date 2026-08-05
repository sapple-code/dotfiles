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

The local company file is intentionally never committed. Its maintained,
non-secret starting point is `.zshrc.company.zsh.template`, which contains the
opt-in mise activation. During an interactive install, `copy-dotfiles.sh` asks
before copying or updating that template as `~/.zshrc.company.zsh`.

For unattended installs, choose explicitly:

```sh
./copy-dotfiles.sh --company     # install or update the local company file
./copy-dotfiles.sh --no-company  # leave it untouched
```

Updating an existing company file requires confirmation (or `--company`) and
creates a timestamped backup before overwriting it.
