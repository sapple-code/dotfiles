## Computer setup for macOS

1. Install the Xcode Command Line Tools and [Homebrew](https://brew.sh/).

2. Install the terminal, editor, and command-line dependencies:

```sh
brew tap d12frosted/emacs-plus
brew install fzf mise multimarkdown reattach-to-user-namespace \
  the_silver_searcher tmux
brew install --cask d12frosted/emacs-plus/emacs-plus-app ghostty \
  karabiner-elements
```

Emacs Plus tracks the latest stable Emacs release and installs `Emacs.app`
directly into `/Applications`.

3. Copy the dotfiles from the repository root:

```sh
./copy-dotfiles.sh
```

The installer copies the shared and macOS-specific files, including the Emacs,
Ghostty, tmux, and Karabiner configurations, into the standard locations under
your home directory.

Ghostty uses its built-in `iTerm2 Solarized Light` theme and the account login
shell. Zsh is configured in shared, macOS, and optional private company layers.
The older Bash files remain for compatibility, but no account-wide `chsh` or
`/etc/shells` change is required.

4. Update Finder to show full paths:

```sh
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
killall Finder
```

5. Apply the Mission Control shortcuts shown in
`mission_control_config.png`.

## Emacs client/server setup

This follows the [client/server setup described here](https://www.hhyu.org/posts/emacs_clientserver/).

- `bin/emacsserver` finds the currently running server.
- `bin/ec` connects to that server or starts a new one.
