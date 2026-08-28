# Coding Standards

`code-review`'s Standards axis reads this file in full on top of its fixed
Fowler smell baseline (Mysterious Name, Duplicated Code, Feature Envy, Data
Clumps, Primitive Obsession, Repeated Switches, Shotgun Surgery, Divergent
Change, Speculative Generality, Message Chains, Middle Man, Refused
Bequest). Entries here are judged the same way: a labelled heuristic to
flag in a diff, not an automatic hard fail. A documented ADR accepting one
of these tradeoffs deliberately suppresses the flag; cite the ADR instead
of re-raising it every review.

## Risk-surface smells

- **Unbounded Exposure**: a new network-facing endpoint with no visible auth
  check and no visible rate limit. Flag even if "internal for now" — that's
  a decision to surface, not a default to accept silently.
- **Trust-on-Read**: logic assuming clock, filesystem, or config is
  uncontrolled by the code's own operator, where the operator plausibly
  controls it (offline license checks, client-side entitlement, anything
  shipped to end-user hardware).
- **Recompute-Over-Maintain**: a scheduled loop, publish cycle, or handler
  that reconstructs a derived value from full source data every run, when
  the source data changes far less often than the loop runs.
- **Implied Protection**: a comment, name, or doc claiming something is
  "secured" or "hidden" by a mechanism (bytecode compilation, minification,
  obfuscation) that doesn't structurally provide that property.
- **Silent Convention Deviation**: new infra duplicating the shape of an
  existing pattern elsewhere in the repo or a sibling repo, without reusing
  or referencing it.

## Design smells (see `skills/codebase-design/SKILL.md` for the vocabulary)

- **Shallow Module**: an interface nearly as complex as its implementation
  — mostly a pass-through. Apply the deletion test before flagging: does
  complexity vanish if this is deleted, or reappear across every caller?
- **Leaky Seam**: a module whose seam doesn't actually contain what varies
  — callers reach past the interface to get real work done, or two
  supposedly-independent adapters silently share mutable state.

## Deployment smells

- **Migration Without Rollback**: a schema or data migration with no stated
  down-migration or reversal plan, or one that's irreversible without data
  loss and nobody flagged it as such.
- **Version Skew Blind Spot**: a change to a shared contract (API shape,
  message format, queue payload) with no consideration of whether the
  previous version's code is still running somewhere during rollout.
- **Config Drift**: a new required env var, secret, or config value
  referenced in code with no corresponding update to environment
  provisioning docs or IaC, so it works locally and breaks on deploy.
- **All-or-Nothing Cutover**: a change with meaningful blast radius shipped
  as a single atomic switch, with no flag, canary, or staged rollout, and no
  stated reason a staged rollout wasn't warranted.
- **Silent Observability Gap**: a new failure mode introduced with no
  corresponding log, metric, or alert that would surface it in production
  before a user reports it.
