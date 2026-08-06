# Dotfiles

Chezmoi-managed Zsh, editor, terminal, and compatibility Bash configuration
for macOS and Debian Linux.

## Install

On macOS, install Homebrew first, then run:

```sh
brew install chezmoi
chezmoi init --apply sapple-code
```

Chezmoi asks whether to enable the optional personal/company layer. That layer
activates mise and causes mise to be installed on macOS. It is disabled by
default and its generated file must not contain credentials.

See [the macOS guide](docs/macos.md) or [the Debian guide](docs/debian.md) for
platform details.

## Daily commands

```sh
chezmoi diff                         # preview unapplied changes
chezmoi apply                        # apply the source state
chezmoi edit --apply ~/.zshrc        # edit one source file and apply it
chezmoi update                       # pull, then apply
chezmoi git -- status                # run Git in the source repository
chezmoi cd                           # open a shell in the source repository
```

The repository uses `.chezmoiroot` so documentation remains at the repository
root while the managed source state lives under `home/`.

## Zsh layers

`~/.zshrc` loads configuration in this order:

1. `~/.zshrc.macos.zsh` or `~/.zshrc.debian.zsh`
2. `~/.zshrc.shared.zsh`
3. `~/.zshrc.company.zsh`, when enabled during `chezmoi init`

Machine choices are stored in the local chezmoi configuration, not committed
to this repository. To change the company choice, edit `data.company` in
`~/.config/chezmoi/chezmoi.toml` and run `chezmoi apply`.

## Packages

On macOS, chezmoi renders `~/.Brewfile` and runs `brew bundle --global` whenever
that manifest changes. On Linux, a best-effort apt script installs the shell,
editor, tmux, clipboard, search, and Git dependencies. Unsupported Linux
distributions still receive the dotfiles but skip package installation.
