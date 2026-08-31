---
name: system-design
description: Interrogate the shape of a system — component boundaries, data flow, consistency, failure behavior under partial failure, capacity, and contracts. Use when a change spans more than one module, process, or service, or introduces a new one.
---

# System Design

`codebase-design` is about the shape of one module. `deployment-readiness`
is about one change reaching shared infrastructure. This is the layer
between: how the parts fit, what flows between them, and how the whole
behaves when one part is slow, wrong, or gone.

Module-level thinking answers "is this interface deep?" It does not answer
"what does a reader see while this write is in flight?" or "what happens to
the queue when the consumer stalls for ten minutes?" Those questions have
no owner unless something asks them.

## When this applies

Treat a change as system-shaped the moment any of these is true, regardless
of how small the diff is:

- State is written in one place and read in another, by different code
  paths, on different schedules.
- A component depends on something it does not control: a network service,
  a broker, a database, another team's code, the clock.
- Work is produced and consumed at independent rates — a queue, a topic, a
  poll loop, a scheduled job.
- A wire format, payload shape, or stored representation crosses a boundary
  something else already depends on.

## Frontier nodes

`CONTEXT.md`'s **System Surface** is the standing list; `grilling` pulls it
in the same way it pulls Risk Surface and Deployment Surface. Every node
needs an explicit answer for the thing being built, not a default assumed.

Two of them catch most real failures, so they get stated fully here.

### Where does this data change, versus where is it read?

Find the write site and the read site and name them separately. Then decide
which one does the expensive work — the derivation, the aggregation, the
chunking, the sort. Recomputing from full source data on every read is only
correct when the source changes about as often as it's read. When the
source changes rarely and the read runs on a timer, the work belongs at the
write site, maintained incrementally, with the invariant and its locking
stated explicitly.

This is a data-flow question, not a performance question. Asking it at
design time is the difference between an incremental structure and a loop
that re-derives an ever-growing value every few seconds. Getting it wrong
is invisible in the diff and shows up months later as drift in latency or
cost. See `Recompute-Over-Maintain` in `CODING_STANDARDS.md`.

### What happens when a dependency is slow, rather than down?

"Down" is the easy case: it fails fast and the error is visible. Slow is
the case that takes systems out. A dependency that answers in 30 seconds
instead of 30 milliseconds holds every caller's connection, thread, or task
open, and the pressure propagates backwards through everything that called
*them*. Answer, per dependency:

- What is the timeout, and is there one at all? An unbounded wait is a
  decision, and usually not the one intended.
- What does the caller do on timeout — fail, degrade, serve stale, queue?
- Does it retry? If so, does retrying make the overload worse (a retry
  storm), and is the operation idempotent enough for a retry to be safe?
- Is there a point where the caller stops trying entirely for a while
  (circuit breaker), or does it hammer a struggling dependency forever?
- If work arrives faster than it drains, what gives: unbounded memory
  growth, dropped work, blocked producers, or explicit rejection? Choose
  one deliberately. Unbounded growth is what you get by not choosing.

## Vocabulary

Use these words precisely; they name distinct things that get conflated.

- **Boundary** — what a component owns exclusively. If two components both
  write the same state, there is no boundary there, only a shared variable
  with extra steps.
- **Contract** — the shape crossing a boundary: payload, wire format,
  stored representation, topic name. Contracts have other people's code on
  the far side, which is what makes them expensive to change.
- **Consistency** — what a reader is guaranteed to see relative to a write.
  Say which one you are promising; "eventually" is an answer, silence is not.
- **Backpressure** — the mechanism by which a slow consumer slows its
  producer. If you cannot name it, there isn't one.
- **Cascading failure** — one component's degradation consuming the
  resources of everything upstream of it, until the failure is systemic.
- **Idempotency** — whether applying an operation twice differs from
  applying it once. Required before any retry is safe.
- **Blast radius** — what is affected when this specific component fails.
  Shared with `deployment-readiness`, which asks it about a rollout.

## Gate

Do not start implementation while any System Surface node is unanswered for
this change. An unanswerable one is not a default — it goes to
`docs/questions/` with what was assumed in its place, per `grilling`.

Record the answers worth keeping in `CONTEXT.md`'s System model section as
they settle, and as an ADR when they are load-bearing or hard to reverse.

## Handoffs

- A boundary that turns out not to contain what varies is a `Leaky Seam` —
  that is `codebase-design` vocabulary, and the fix belongs to
  `improve-architecture` if it's existing code.
- Anything about *rolling out* this change — migration, version skew,
  canary, rollback — is `deployment-readiness`, not here. This skill asks
  what the system is; that one asks what shipping into it costs.
- If a failure-behavior question needs a runnable answer rather than an
  argued one, `prototype` it. Load and failure behavior are exactly the
  kind of thing that is hard to reason about on paper.
