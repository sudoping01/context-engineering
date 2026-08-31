---
name: improve-architecture
description: Scan a codebase for deepening opportunities and propose refactors that turn shallow modules into deep ones. Use for codebase health, not feature work.
disable-model-invocation: true
---

# Improve Architecture

Surface architectural friction and propose deepening opportunities: refactors
that turn shallow modules into deep ones. The aim is testability and
navigability for whoever — human or agent — touches this code next.

Use the `codebase-design` vocabulary exactly (module, interface, depth,
seam, adapter, leverage, locality) in every finding — and the
`system-design` vocabulary (boundary, contract, consistency, backpressure,
idempotency) where the friction is *between* components rather than inside
one. Read `CONTEXT.md` and any ADRs in the area first — this pass proposes
refactors, it doesn't re-litigate decisions already recorded. Check
`docs/questions/` too: an assumption recorded there that the code has since
outgrown is exactly the kind of thing this pass exists to catch.

## Scope before scanning

Put weight on what's recently changed — deepening a module pays off by
making future changes easier, and recent hot spots are where future changes
are likeliest. If the user named a direction, take it. Otherwise, walk
recent commit history to find the files that keep coming up.

## What to look for

- Where does understanding one concept require bouncing across many small
  modules?
- Where is a module's interface nearly as complex as its implementation
  (shallow)?
- Where have pure functions been extracted purely for testability, while
  the real bugs live in how they're called (no locality)?
- Where do tightly coupled modules leak state or assumptions across their
  seam?
- What's untested, or only testable by reaching past its own interface?

Apply the deletion test to anything suspected shallow: delete it mentally —
does complexity vanish, or does it reappear across every caller? Reappearing
means it was earning its keep; don't flag it.

## Output

Present candidates, each stating: the module, why it's shallow or leaky (in
`codebase-design` terms), and the shape of a deeper alternative — not full
implementation, just enough to evaluate. Picking one becomes an idea to run
through `grilling` before any code changes, since the refactor itself
deserves the same interview discipline as new work.
