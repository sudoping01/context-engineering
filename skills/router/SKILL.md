---
name: router
description: Which skill in this kit fits the current situation. Consult this first when unsure what to run next.
disable-model-invocation: true
---

# Router

Nobody remembers seventeen skills. This is the map.

## Main flow: idea to shipped

1. **`grilling`** sharpens the idea by interview, pulling `CONTEXT.md`'s
   standing Risk, System, and Deployment Surface questions in
   automatically.
   Settle every branch before code exists.
2. **Does the change span more than one module, process, or service?**
   Then it's system-shaped, and **`system-design`** supplies the frontier
   nodes `grilling` asks: boundaries, data flow, consistency, what happens
   when a dependency is slow rather than down, backpressure, capacity,
   contracts. This is the layer `codebase-design` (one module) and
   `deployment-readiness` (one rollout) both sit beside, not inside.
3. **Can every open question be settled in conversation?** If one needs a
   runnable answer (a state model, a UI, load or failure behavior, business
   logic that's hard to reason about on paper), detour through
   **`prototype`** — throwaway code that answers exactly that question,
   then folds the verdict back in. If one can't be settled at all, it
   becomes a `docs/questions/` entry, not a silent default.
4. **Build.** `tdd` drives the red/green loop at the seams agreed in step 1.
5. **`code-review`** before merge — two-axis, Standards + Spec, against
   `CODING_STANDARDS.md` and the originating spec.
6. **`deployment-readiness`** before the change reaches shared or
   production infrastructure. **`release-management`** for the release
   itself and the window after it ships.

## On-ramps: things that feed into the main flow

- **A pile of bug reports or feature requests that arrived raw** →
  **`triage`**. Produces agent-ready issues that step 4 picks up. Don't
  triage work you already scoped yourself in step 1 — that's already
  agent-ready.
- **Something's broken and doesn't yield to a quick look** →
  **`diagnosing-bugs`**. Refuses to hypothesize before a red-capable repro
  exists. If the finding is "there's no seam to lock this down," that's a
  handoff to `improve-architecture`, not a reason to ship a fragile fix.
- **Investigating something before you know enough to grill it** →
  **`research`**. Delegate reading legwork against primary sources; bring
  the cited findings into `grilling` rather than treating research as a
  substitute for the interview.

## Codebase health: not feature work, upkeep

- **`improve-architecture`** scans for deepening opportunities using the
  `codebase-design` vocabulary. Run it when nothing's on fire, to keep the
  codebase navigable for the next agent (or human) that touches it.

## Vocabulary underneath

Three references other skills pull in; reach for them directly when the
words are the problem, not the process.

- **`domain-modeling`**: keeps `CONTEXT.md`'s glossary honest. The active
  discipline behind `grilling`, not a document you read once.
- **`codebase-design`**: the deep-module vocabulary (module, interface,
  seam, adapter, depth, leverage, locality) for a module's *shape*. `tdd`,
  `code-review`, and `improve-architecture` all speak it.
- **`system-design`**: the vocabulary one level up (boundary, contract,
  consistency, backpressure, cascading failure, idempotency) for how the
  parts fit and how the whole degrades. Reach for it directly when the
  question is about the space *between* modules, not inside one.

## Where knowledge goes

Three artifacts, three jobs. Putting something in the wrong one is how it
gets lost.

- **`docs/adr/`** — answers that are load-bearing or hard to reverse.
  Individually citable; `code-review` cites one to suppress a smell.
- **`docs/questions/`** — questions `grilling` *couldn't* settle, each with
  what was assumed in its place and what breaks if that's wrong. An
  unanswered question that isn't written down becomes an invented answer.
- **`decision-record`** — the running log of everything smaller: decisions
  with their rejected alternative, failures with their evidence, invisible
  constraints. Updated the moment they happen, not in a tidy-up pass.
  Every entry tagged FACT / DECISION / ASSUMPTION / UNKNOWN, because an
  assumption written in the voice of a fact becomes one. Promote an entry
  out to an ADR the moment it turns out to matter more than it looked.

## Standalone

- **`resolving-merge-conflicts`** — mid-conflict, resolve by intent traced
  to each side's primary source, never `--abort`.
- **`git-safety`** — not a flow step, a standing gate. Install once; it
  blocks destructive git commands regardless of which flow is running.

## Precondition

Fill in `CONTEXT.md` and `CODING_STANDARDS.md` before the first real flow.
Nothing above works well against an empty glossary.
