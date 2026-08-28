---
name: git-safety
description: Install a hard gate blocking destructive git commands (force push, reset --hard, clean -f, branch -D) before an agent can run them. Use once per machine or per project, not per task.
disable-model-invocation: true
---

# Git Safety

Every other skill in this kit is prose an agent follows by judgment. This
one is different on purpose: a standing technical gate that blocks a
specific class of command regardless of which flow is running or what the
agent decides is a good idea in the moment.

## What it blocks

`git push --force` (and `-f`), `git reset --hard`, `git clean -f`/`-fd`,
`git branch -D`, `git checkout .`, `git restore .`. All destructive or
history-rewriting operations an agent has no business running unattended.

## Install (Claude Code)

1. Ask scope: this project only (`.claude/settings.json`) or every project
   (`~/.claude/settings.json`)?
2. Copy `scripts/block-dangerous-git.sh` to the target location, make it
   executable (`chmod +x`).
3. Register it as a `PreToolUse` hook on the `Bash` tool in the chosen
   settings file, pointed at the script's path.
4. Confirm it's active: attempt a harmless `git status` (should pass) and
   ask the agent to try one blocked command (should be refused with the
   script's message).

## Other agents

Hooks are a Claude Code mechanism specifically; this is one of the few
genuinely tool-specific pieces in the kit rather than something portable
through `AGENTS.md`. For other agents, the equivalent is usually a
pre-command wrapper, a restricted shell, or branch-protection rules on the
remote itself (require PR review, block force-push on protected branches
at the host level) — which are worth having regardless of which agent is
running, since they also protect against a human having a bad day.

## Why this exists as a gate, not a rule

An instruction that says "don't force-push" is advice an agent can
misjudge under pressure — the same failure mode as the reasoning gaps this
whole kit exists to catch, applied to git itself. A gate doesn't ask the
agent to remember; it makes the command fail before it runs.
