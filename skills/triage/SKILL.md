---
name: triage
description: Move incoming issues and external PRs through a small state machine so intake stays consistent instead of ad hoc. Use for bug reports and feature requests that arrived raw, not for self-scoped work.
disable-model-invocation: true
---

# Triage

A small state machine for issues nobody on the team wrote themselves — bug
reports, incoming feature requests, external PRs. Don't run this on tickets
already produced by a `grilling` session; those are already agent-ready.

## Roles

Two categories: **bug** (something's broken), **enhancement** (new
capability or improvement).

Five states: **needs-triage** (needs evaluation), **needs-info** (waiting
on the reporter), **ready-for-agent** (fully specified, safe to hand to an
agent unattended), **ready-for-human** (needs a person), **wontfix**.

For an external PR, the same states read against the attached code:
ready-for-agent means a brief is attached and the next step is on the
diff; ready-for-human means it's ready for a person to review and merge.

## Process

1. Categorize (bug/enhancement).
2. Verify: reproduce a bug claim, or check a feature request against
   `CONTEXT.md` for whether it conflicts with an existing decision.
3. If underspecified, move to needs-info with the specific missing piece
   named — not a generic "please provide more detail."
4. If it needs a design decision before an agent can safely build it, run
   `grilling` (or hand off to it) before marking ready-for-agent. An issue
   marked ready-for-agent should have its open questions already resolved,
   not deferred to whoever picks it up.
5. Write the agent-ready brief: what's broken or wanted, the seam it's
   testable at, and any constraint from `CONTEXT.md`'s Risk Surface that
   applies.

## Discipline

State the reasoning behind every state change, especially wontfix —
"why not" is as valuable a record as "why," and prevents the same request
resurfacing without anyone remembering it was already considered and
declined.
