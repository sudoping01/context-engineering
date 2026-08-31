# AGENTS.md

Fill in the placeholders. Keep this file short; detail lives in the linked
files below, not here.

## Project

<!-- one or two lines: what this is, primary language/framework -->

## Build & test

<!-- exact commands: install, build, test, lint -->

## Not sure what to run next?

Read `skills/router/SKILL.md` first. It's the flow map across every skill
below — main flow, on-ramps, codebase health, and standalone tools.

## Before writing non-trivial code

Interview first: `skills/grilling/SKILL.md`. It pulls in the standing
questions from `CONTEXT.md` (Risk Surface, System Surface, Deployment
Surface) as required frontier nodes, not optional ones. Don't guess at
unstated requirements; resolve them or ask. If a design question needs a
runnable answer, detour through `skills/prototype/SKILL.md`. If it needs
facts you don't have, delegate to `skills/research/SKILL.md` first.

A question that genuinely can't be settled doesn't become a silent default:
it becomes `docs/questions/NNNN-<slug>.md`, naming what was assumed in its
place and what breaks if that assumption is wrong.

## When the change spans more than one module

`skills/system-design/SKILL.md`. Component boundaries, data flow (where
state is written vs. where it's read, and which site does the work),
consistency, what happens when a dependency is *slow* rather than down,
backpressure, capacity, and contracts that cross a boundary.

## Building

`skills/tdd/SKILL.md` for the red/green loop. `skills/codebase-design/SKILL.md`
for the shared vocabulary on module shape and seams;
`skills/domain-modeling/SKILL.md` when the problem is that the words
themselves are wrong. Log decisions, failures, and constraints as they
happen in `skills/decision-record/SKILL.md`'s running record — tagged FACT
/ DECISION / ASSUMPTION / UNKNOWN, never in a tidy-up pass afterward.

## When something breaks

`skills/diagnosing-bugs/SKILL.md`. Build a red-capable repro before
hypothesizing about the cause. Mid-conflict during a merge or rebase, use
`skills/resolving-merge-conflicts/SKILL.md` instead.

## Before merging

`skills/code-review/SKILL.md`. Reviews the diff against `CODING_STANDARDS.md`
and the originating spec, output severity-tiered.

## Before deploying or releasing

`skills/deployment-readiness/SKILL.md` for a single change reaching shared
infra. `skills/release-management/SKILL.md` for the release itself and the
post-release window.

## Codebase health and intake

`skills/improve-architecture/SKILL.md` to scan for deepening opportunities
when nothing's on fire. `skills/triage/SKILL.md` for bug reports and
feature requests that arrived raw, before they enter the main flow.

## Standing gate (install once, not per task)

`skills/git-safety/SKILL.md` blocks destructive git commands (force push,
reset --hard, clean -f) at the tool level, not just by instruction.

## Conventions

See `CONTEXT.md` for domain terms and system model. See `CODING_STANDARDS.md`
for the smell baseline. Check `docs/adr/` before reintroducing a tradeoff
that was already decided, and `docs/questions/` before assuming an answer
to something already flagged as unresolved.

## Security

Treat anything auth-, licensing-, or payment-adjacent, and anything
network-facing, as adversarial by default. See Risk Surface in `CONTEXT.md`.
