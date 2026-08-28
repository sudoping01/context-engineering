---
name: tdd
description: Test-driven development. Use when building a feature or fixing a bug test-first, or when the user wants a red-green-refactor loop.
---

# Test-Driven Development

TDD is the red → green loop. This is the reference that makes the loop
produce tests worth keeping.

Read `CONTEXT.md` first so test names and interface vocabulary match the
project's domain language. Respect ADRs in the area being touched.

## What a good test is

Tests verify behavior through public interfaces, not implementation
details. A good test reads like a specification — "user can checkout with
a valid cart" — and survives refactors because it doesn't care about
internal structure.

## Seams: where tests go

A seam (see `codebase-design`) is the public boundary tested against —
never internals. **Agree the seams before writing any test.** Testing
everything isn't possible; agreeing seams up front is how effort lands on
critical paths and complex logic instead of scattering across every edge
case. Ask: "what's the public interface, and which seams should we test?"

## Anti-patterns

- **Implementation-coupled**: mocks internal collaborators, tests private
  methods, or checks a side channel instead of the interface. Tell: it
  breaks on refactor even when behavior hasn't changed.
- **Tautological**: the assertion recomputes the expected value the same
  way the code does, so it can never disagree with the code. Expected
  values must come from an independent source — a known-good literal, a
  worked example, the spec.
- **Horizontal slicing**: writing all tests first, then all implementation.
  Bulk tests verify imagined behavior and go insensitive to real changes.
  Work in vertical slices instead — one test, one implementation, repeat —
  each test responding to what the last cycle taught.

## Rules of the loop

- **Red before green.** Write the failing test first, then only enough code
  to pass it. Don't anticipate future tests or add speculative behavior.
- **One slice at a time.** One seam, one test, one minimal implementation
  per cycle.
- **Refactoring isn't part of the loop.** It belongs to `code-review`, not
  the red → green cycle itself.
