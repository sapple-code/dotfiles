# AI stack

The shared dotfiles install two complementary terminal agents:

- **Pi** is the compatibility and mobile-session layer. Its package ecosystem
  supplies `/goal`, subagents, durable background tasks, terminal dictation,
  and `pi-web-ui`.
- **Oh My Pi (`omp`)** is a pinned side-by-side coding-driver trial. It adds
  built-in model roles, first-class subagents and background jobs, Agent Hub,
  voice input, encrypted live collaboration, and Codex/Claude transcript import.
- **Codex Desktop** remains the native desktop and ChatGPT Remote host.

The tools are deliberately separate session stores. `agent-handoff` and the
shared `agent-handoff` skill invoke, resume, import, and summarize across those
stores without rewriting private transcript formats.

## Shared versus local state

| Shared by chezmoi | Local to each computer/account |
| --- | --- |
| Tool and runtime versions | ChatGPT, Anthropic, and OpenAI authentication |
| Pi package names and versions | `~/.pi/agent/settings.json`, `auth.json`, and sessions |
| pi-web-ui voice plugin code | `~/.pi-web` plugin settings, API keys, and UI state |
| `agent-handoff` CLI and skill | `~/.omp/agent` config, auth database, and sessions |
| Shell activation and prerequisites | `~/.codex` config/auth/sessions |
| This architecture document | User-level `AGENTS.md`, `CLAUDE.md`, hooks, and secrets |

Do not add the local column to this repository. Personal and Nubank work
machines receive the same binaries but keep different identities, instructions,
hooks, provider policy, and transcripts.

When both identities must exist on one computer, use separate OS accounts when
possible. OMP also supports isolated `--profile personal` and `--profile nubank`
roots. Pi can use a separate `PI_CODING_AGENT_DIR` per local shell profile. Keep
those profile choices and aliases local rather than committing them here.

## Install and verify

Apply the dotfiles normally:

```sh
chezmoi apply
agent-handoff doctor
pi --version
omp --version
pi-web-ui --version
```

Chezmoi installs the pinned tools through the managed mise fragment, installs
the pinned Pi packages, and installs the pinned pi-web-ui voice-input plugin.
On Debian it bootstraps mise with the official installer when needed. On macOS,
Homebrew installs mise plus `ffmpeg` for Pi terminal dictation.

Authentication is intentionally manual and local. In both `pi` and `omp`, run
`/login` and authenticate the ChatGPT/Codex and Anthropic providers allowed for
that machine. A ChatGPT subscription login and an OpenAI API key are separate
credentials; OpenAI-protocol speech-to-text normally needs `OPENAI_API_KEY`.

## Models and voice

Pi can switch providers with `/model`, or start with an explicit selector:

```sh
pi --model 'anthropic/<claude-model>'
pi --model 'openai-codex/<codex-model>'
```

OMP exposes model roles in `/model` and supports the same idea with
`omp --model <provider/model>`. Keep role choices in the local OMP config so a
work model allow-list does not leak into the personal setup.

Terminal voice options:

- OMP: run `omp setup speech`, enable `stt.enabled` locally, then hold Space to
  record. OMP can use local Whisper or a cloud model speaking the OpenAI
  transcription protocol.
- Pi: configure `~/.pi/agent/stt.json` locally for `pi-voice-stt`. Prefer the
  current `gpt-transcribe` model at `https://api.openai.com/v1`; keep the API
  key in `OPENAI_API_KEY`, never in dotfiles. Use `Ctrl+R` or `/stt`.

## Pi packages, extensions, and skills

Pi has a public package catalog at <https://pi.dev/packages>. A package may
bundle executable TypeScript extensions, Agent Skills instruction folders,
prompt templates, and themes. `pi install npm:<package>` records the package in
the local Pi settings and Pi loads the resources declared by its manifest.

There is a managed catalog and discovery convention, not an app-store security
boundary: most packages are third-party code and extensions execute with the
same user permissions as Pi. This repository therefore pins a small reviewed
set instead of installing arbitrary catalog results. Agent Skills can teach Pi
or Codex how to use existing CLIs; they do not by themselves install or sandbox
an extension. The shared `agent-handoff` skill is an example.

## Background work, goals, and schedules

Pi receives these pinned packages:

- `pi-goal-x` for `/goal` and independent completion review.
- `pi-subagents` for focused and parallel child agents.
- `pi-background-tasks` for durable shell and delegated background work.
- `pi-voice-stt` for terminal dictation.

OMP provides subagents, Agent Hub, async jobs, persistent process supervision,
and plan/goal primitives out of the box.

Recurring schedule definitions remain local. Use `launchd` on macOS or a user
systemd timer on Linux to invoke `agent-handoff run pi` or `agent-handoff run
omp`. This prevents a Nubank schedule from appearing on a personal computer
through dotfile sync. Do not install a young third-party scheduler extension
until its persistence and security model have been reviewed.

## Mobile

### Codex

ChatGPT Remote requires the phone and desktop host to use the same ChatGPT
account **and workspace**. Pair each host from ChatGPT Desktop under
**Settings → Connections**, and keep the host awake and online.

Personal and Nubank work are therefore separate identity lanes. Pair a personal
host while the phone is in the personal account/workspace, and a work host while
it is in the Nubank account/workspace. Nubank administrators may need to enable
Remote Control. Dotfiles never bridge their authentication or transcripts.

### Pi

`pi-web-ui` is the closest current Codex-style Pi surface: it reads the same Pi
session directory, lists projects and conversations, streams running sessions,
and supports multiple background conversations. Start locally with:

```sh
PI_WEB_TOKEN='<local secret>' pi-web-ui --host 127.0.0.1 --port 8787 --cwd "$HOME/dev"
```

Install it as a per-user service only after choosing that machine's workspace,
token storage, and remote-access policy:

```sh
pi-web-ui server install --host 127.0.0.1 --port 8787 --cwd "$HOME/dev"
```

For phone access, keep Pi bound to loopback and place an authenticated HTTPS
reverse proxy or Tailscale Serve in front of it. Do not bind it directly to a
public interface. The installed `voice-input` plugin adds a mobile microphone
button and can use browser speech recognition, local Whisper, or an
OpenAI-compatible `/audio/transcriptions` endpoint; its endpoint, model, and key
stay under `~/.pi-web` on that computer.

OMP's `/collab` is a useful live-session phone link with end-to-end encrypted
session payloads and subagent controls. It is complementary rather than the
primary mobile inbox because it does not yet provide one historical session
list across every project.
