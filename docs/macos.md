# macOS setup

## Bootstrap

Install the Xcode Command Line Tools and [Homebrew](https://brew.sh/), then run:

```sh
brew install chezmoi
chezmoi init --apply sapple-code
```

Chezmoi installs the managed files and runs the rendered `~/.Brewfile`. The
manifest supports both Apple Silicon and Intel Homebrew installations and
includes Emacs Plus, Ghostty, Karabiner-Elements, tmux, fzf, Silver Searcher,
and the remaining command-line dependencies. Mise is included only when the
optional personal/company layer is enabled.

Ghostty reads its Solarized Light configuration from:

```text
~/Library/Application Support/com.mitchellh.ghostty/config
```

## Finder and Mission Control

Show full paths in Finder titles:

```sh
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
killall Finder
```

Apply the Mission Control shortcuts shown in
[`mission_control_config.png`](mission_control_config.png).

## Emacs client/server setup

This follows the [client/server setup described here](https://www.hhyu.org/posts/emacs_clientserver/).

- `~/bin/emacsserver` finds the currently running server.
- `~/bin/ec` connects to that server or starts a new one.
