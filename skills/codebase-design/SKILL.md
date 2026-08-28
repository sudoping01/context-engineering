---
name: codebase-design
description: Shared vocabulary for designing deep modules. Use when designing or improving a module's interface, deciding where a seam goes, or when another skill needs the deep-module vocabulary.
---

# Codebase Design

Design **deep modules**: a lot of behavior behind a small interface, placed
at a clean seam, testable through that interface. This is the vocabulary
`tdd`, `code-review`, and `improve-architecture` all use — stay consistent
with it rather than drifting into "component," "service," or "boundary."

## Glossary

- **Module**: anything with an interface and an implementation. Scale-
  agnostic: a function, a class, a package, a tier-spanning slice.
- **Interface**: everything a caller must know to use the module correctly
  — type signature, invariants, ordering constraints, error modes, required
  config, performance characteristics. Broader than "API" or "signature."
- **Implementation**: what's inside. Distinct from **Adapter** — a thing can
  be a small adapter over a large implementation (a Postgres repository) or
  a large adapter over a small one (an in-memory fake).
- **Depth**: leverage at the interface. How much behavior a caller or test
  can exercise per unit of interface they have to learn. **Deep** = a lot of
  behavior behind a small interface. **Shallow** = the interface is nearly
  as complex as the implementation.
- **Seam** (Michael Feathers): the place you can alter behavior without
  editing there — the location where a module's interface lives. Where the
  seam goes is a design decision separate from what sits behind it.
- **Adapter**: a concrete thing satisfying an interface at a seam.
  Describes role, not substance.
- **Leverage**: what callers get from depth — one implementation pays back
  across every call site and every test.
- **Locality**: what maintainers get from depth — bugs, knowledge, and
  verification concentrate in one place instead of spreading. Fix once,
  fixed everywhere.

## Deep vs. shallow

A deep module: small interface, a lot of implementation hidden behind it.
A shallow module: interface almost as large as the implementation — the
module is mostly a pass-through, and pass-throughs earn their keep less
often than they're added.

When shaping an interface, ask: can the number of methods shrink? Can the
parameters simplify? Can more complexity move inside, out of the caller's
way?

## Principles

- **Depth is a property of the interface, not the implementation.** A deep
  module can be internally composed of small, swappable parts — they just
  aren't part of what callers see.
- **The deletion test.** Imagine deleting the module. If complexity
  vanishes, it was a pass-through. If it reappears across N callers, the
  module was earning its keep.
- **The interface is the test surface.** Callers and tests cross the same
  seam. Wanting to test past the interface is usually a sign the module is
  the wrong shape.
- **One adapter is a hypothetical seam. Two adapters is a real one.** Don't
  introduce a seam unless something actually varies across it.

## Designing for testability

- **Accept dependencies, don't create them** inside the module — pass the
  payment gateway in, don't `new` it internally.
- **Return results, don't produce side effects** where the caller can react
  to a value instead of inspecting mutated state.
- **Small surface area.** Fewer methods, simpler parameters, less test
  setup required to exercise the behavior.

## Relationships

A Module has one Interface. Depth is measured against that Interface. A
Seam is where the Interface lives. An Adapter sits at a Seam and satisfies
the Interface. Depth produces Leverage for callers and Locality for
maintainers.

## Rejected framings

- Depth as a ratio of implementation-lines to interface-lines rewards
  padding the implementation; depth-as-leverage doesn't.
- "Interface" limited to a language's `interface` keyword or a class's
  public methods is too narrow — it excludes invariants and error modes a
  caller still has to know.
- "Boundary" is overloaded with DDD's bounded context; say seam or
  interface instead.
