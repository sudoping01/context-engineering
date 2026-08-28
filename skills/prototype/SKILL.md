---
name: prototype
description: Build a throwaway prototype to answer a design question. Use when the user wants to sanity-check a state model or logic, or explore what a UI should look like, before committing to a real build.
---

# Prototype

A prototype is throwaway code that answers one question. The question
decides the shape.

## Pick the question

- **"Does this logic or state model feel right?"** Build a single
  shareable file that pushes the state machine through the cases that are
  hard to reason about on paper, drivable by someone non-technical.
- **"What should this look like?"** Generate a few genuinely different UI
  variations, switchable without rebuilding, so the comparison is visible
  side by side rather than imagined.

Getting the question wrong wastes the whole prototype — if it's ambiguous
and nobody's around to ask, default to whichever the surrounding code
suggests (a backend module implies logic, a page implies UI) and state the
assumption at the top of the file.

## Rules

1. **Throwaway from day one, and clearly marked as such.** Keep it near
   where it'll actually be used, but name it so nobody mistakes it for
   production.
2. **Trivial to run.** One command, or a file that just opens. No setup
   required to start looking at the answer.
3. **No persistence by default.** State lives in memory — persistence is
   usually the thing being checked, not something the prototype should
   depend on.
4. **Skip the polish.** No tests beyond what makes it runnable, no
   abstractions. The point is learning something fast, not shipping it.
5. **Surface the state.** After every action, show the full relevant state
   so the person driving it can see what changed.
6. **Capture it when done.** Fold the validated decision into the real
   code. Keep the prototype itself as a primary source somewhere out of
   main, with a pointer to it from wherever the real implementation is
   tracked, and record the verdict — not just the code, the answer it gave.
