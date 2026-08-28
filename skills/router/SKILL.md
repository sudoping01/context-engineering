---
name: router
description: Which skill in this kit fits the current situation. Consult this first when unsure what to run next.
disable-model-invocation: true
---

# Router

Nobody remembers fourteen skills. This is the map.

## Main flow: idea to shipped

1. **`grilling`** sharpens the idea by interview, pulling `CONTEXT.md`'s
   standing Risk Surface and Deployment Surface questions in automatically.
   Settle every branch before code exists.
2. **Can every open question be settled in conversation?** If one needs a
   runnable answer (a state model, a UI, business logic that's hard to
   reason about on paper), detour through **`prototype`** — throwaway code
   that answers exactly that question, then folds the verdict back in.
3. **Build.** `tdd` drives the red/green loop at the seams agreed in step 1.
4. **`code-review`** before merge — two-axis, Standards + Spec, against
   `CODING_STANDARDS.md` and the originating spec.
5. **`deployment-readiness`** before the change reaches shared or
   production infrastructure. **`release-management`** for the release
   itself and the window after it ships.

## On-ramps: things that feed into the main flow

- **A pile of bug reports or feature requests that arrived raw** →
  **`triage`**. Produces agent-ready issues that step 3 picks up. Don't
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

Two references other skills pull in; reach for them directly when the
words are the problem, not the process.

- **`domain-modeling`**: keeps `CONTEXT.md`'s glossary honest. The active
  discipline behind `grilling`, not a document you read once.
- **`codebase-design`**: the deep-module vocabulary (module, interface,
  seam, adapter, depth, leverage, locality) for a module's *shape*. `tdd`,
  `code-review`, and `improve-architecture` all speak it.

## Running record

- **`decision-record`**: the running log of decisions, failures,
  constraints, and open questions discovered while doing the work — updated
  the moment they happen, not in a tidy-up pass at the end. Distinct from
  `docs/adr/`: an ADR is for the load-bearing, hard-to-reverse decisions;
  the decision record is for everything smaller that still shouldn't be
  lost. Promote an entry to its own ADR the moment it turns out to matter
  more than it looked.

## Standalone

- **`resolving-merge-conflicts`** — mid-conflict, resolve by intent traced
  to each side's primary source, never `--abort`.
- **`git-safety`** — not a flow step, a standing gate. Install once; it
  blocks destructive git commands regardless of which flow is running.

## Precondition

Fill in `CONTEXT.md` and `CODING_STANDARDS.md` before the first real flow.
Nothing above works well against an empty glossary.
