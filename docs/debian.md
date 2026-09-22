# Debian setup

Install chezmoi using its official package or installer, then initialize the
repository:

```sh
chezmoi init --apply sapple-code
```

The Linux configuration is maintained on a best-effort basis. On systems with
`apt-get`, the first apply attempts to install curl, Emacs, ffmpeg, `fd-find`,
fzf, Git, jq, Silver Searcher, tmux, xclip, and Zsh. A managed `fd` shim invokes
Debian's `fdfind` binary when Pi is selected. Package failures are reported
without blocking the dotfile installation; other distributions skip the
package step.

The main Zsh file sources the Debian layer, shared layer, and optional
personal/company layer in that order. The AI stack script installs mise with its
official installer when needed, installs only the applications selected during
`chezmoi init`, and the shared shell layer activates it.
