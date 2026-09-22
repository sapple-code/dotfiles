---
name: agent-handoff
description: Invoke, resume, inspect, or hand work between local Pi, Oh My Pi, and Codex sessions. Use for cross-model review or multi-harness workflows; do not use to rewrite another harness's raw session files.
---

# Agent handoff

Use `agent-handoff` as the supported boundary between Pi, Oh My Pi (`omp`), and
Codex. Run `agent-handoff --help` before the first handoff in a session.

- Prefer piping substantial prompts over stdin so they do not appear in the
  process list.
- Set `--cwd` explicitly for new work. Resume by session ID or path only when
  the user identified the target, or after inspecting `agent-handoff sessions`.
- Use `--model` when the user asks for a particular model or provider. Otherwise
  let the target harness use its local default.
- Treat the target as an independent agent. Give it the objective, constraints,
  relevant paths, and the output you need; do not assume it inherited this
  conversation.
- Do not edit Pi, OMP, or Codex JSONL/session databases directly. Handoffs use
  supported CLI resume/import operations. OMP can interactively import a Codex
  transcript with `agent-handoff import-codex`.
- Avoid delegation loops. The wrapper rejects nesting deeper than two harnesses;
  do not bypass that guard.
- Summarize the returned result and preserve source attribution when presenting
  another harness's findings. The calling agent remains responsible for
  verification before changing files or claiming completion.

Examples:

```sh
printf '%s\n' 'Review the current diff for concurrency bugs.' \
  | agent-handoff run pi --cwd "$PWD" --model anthropic/claude-sonnet-4-5

printf '%s\n' 'Recheck the failing test and propose the smallest fix.' \
  | agent-handoff resume codex SESSION_ID
```
