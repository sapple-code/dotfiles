# Debian setup

Install chezmoi using its official package or installer, then initialize the
repository:

```sh
chezmoi init --apply sapple-code
```

The Linux configuration is maintained on a best-effort basis. On systems with
`apt-get`, the first apply attempts to install curl, Emacs, fzf, Git, Silver
Searcher, tmux, xclip, and Zsh. Package failures are reported without blocking
the dotfile installation; other distributions skip the package step.

The main Zsh file sources the Debian layer, shared layer, and optional
personal/company layer in that order. Mise is activated only by the optional
layer and must currently be installed separately on Debian.
