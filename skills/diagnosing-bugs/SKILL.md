---
name: diagnosing-bugs
description: Gated diagnosis loop for hard bugs and performance regressions. Use when the user reports something broken, throwing, failing, or slow.
---

A discipline for hard bugs. Do not skip phases without explicit
justification stated to the user.

## Phase 1: Build a feedback loop

Do not read code to form a theory before this exists. If you catch
yourself hypothesizing before a red-capable command exists, stop.

Build one command — a failing test, a curl/HTTP script, a CLI invocation
against a fixture, a replayed captured trace — that:

- **Goes red on this exact bug**, not a nearby one.
- **Is deterministic**, or for flaky bugs, reproduces at a high enough rate
  to debug against.
- **Runs in seconds**, not minutes.
- **Runs unattended.**

Redact every secret before showing commands or output.

## Phase 2: Reproduce and minimize

Run the loop, confirm it produces the user's exact symptom. Shrink the
repro to the smallest scenario that still goes red, cutting one variable at
a time. Done when every remaining element is load-bearing.

## Phase 3: Hypothesize

Generate 3-5 ranked, falsifiable hypotheses before testing any of them.
Each states a prediction: "if X is the cause, changing Y makes the bug
disappear." Show the ranked list to the user before testing; domain
knowledge often reranks it instantly.

## Phase 4: Instrument

One probe per hypothesis, one variable changed at a time. Prefer a debugger
or REPL over logs; never "log everything and grep." Tag every debug log
with a unique prefix for one-grep cleanup. For performance regressions,
measure with a timing harness or profiler before touching logs at all.

## Phase 5: Fix and regression test

Write the regression test before the fix, at the seam that exercises the
real bug pattern as it occurs at the call site. If no correct seam exists,
that absence is itself the finding: the architecture is preventing this bug
from being locked down. Note it, don't fake a shallow test for false
confidence.

Watch the test fail, apply the fix, watch it pass, then re-run the Phase 1
loop against the original scenario.

## Phase 6: Cleanup

- [ ] Original repro no longer reproduces
- [ ] Regression test passes, or seam absence is documented
- [ ] All debug instrumentation removed
- [ ] The correct hypothesis is stated in the commit/PR message
