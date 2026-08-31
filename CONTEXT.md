# Context

Domain glossary and system model. Read this before making design decisions.
`grilling` and `domain-modeling` challenge terms against this file and
update it inline as the model sharpens.

## Glossary

<!-- Project-specific terms: Term: precise definition. -->

## Risk Surface

Standing frontier nodes for any `grilling` session touching a new module,
endpoint, or piece of state. Not resolved until each has an explicit answer
for the thing being built, not a default assumed.

- **Trust boundary**: who runs this code, and do they control the inputs it
  trusts (clock, filesystem, env vars, config)? State it, don't assume a
  cooperative user by default.
- **Exposure**: if network-facing, is it authenticated? Rate-limited? What's
  the cost curve under 10x/100x/1000x traffic, and does infra auto-scale in
  response (cost risk)?
- **State growth**: does this introduce data that grows over the system's
  lifetime? Where is the write site vs. the read site, and which one does
  the expensive work?
- **Reversibility**: if this ships as a compiled/packaged artifact, what
  does packaging actually protect versus merely obscure? State it, don't
  imply protection the toolchain doesn't provide.
- **Convention**: does a sibling module, repo, or prior ADR already solve an
  adjacent version of this problem? Point to it or note there's none.

## System Surface

Standing frontier nodes for `grilling` when a change spans more than one
module, process, or service, or introduces a new one. Same rule: explicit
answer required, not a default. The discipline and vocabulary behind these
live in `skills/system-design/SKILL.md`.

- **Boundaries**: what are the components, and what does each own
  exclusively? If two of them write the same state, say so — that's a
  shared variable, not a boundary.
- **Data flow**: for each piece of state, where is it written and where is
  it read? Which of those two sites does the derivation work, and why that
  one?
- **Consistency**: what is a reader guaranteed to see while a write is in
  flight? Name the guarantee; "eventually" is an answer, silence is not.
- **Partial failure**: for each dependency, what happens when it is *slow*
  rather than down — timeout, retry policy, retry safety (idempotency),
  circuit breaker, and what the caller does instead?
- **Backpressure**: when work arrives faster than it drains, what gives —
  memory growth, dropped work, blocked producers, or explicit rejection?
  Unbounded growth is the answer you get by not choosing one.
- **Capacity**: what drives growth here (users, devices, time, retained
  history), and what breaks first at 10x that? Is the growth bounded by
  anything, or only by the system's lifetime?
- **Contracts**: what shape crosses a boundary (payload, wire format,
  stored representation, topic or queue name), who else already depends on
  it, and is it versioned?

## Deployment Surface

Standing frontier nodes for `grilling` when the change reaches a shared or
production environment. Same rule: explicit answer required, not a default.
Full checklist and gate live in `skills/deployment-readiness/SKILL.md`;
these are the questions that belong in the design conversation itself,
before implementation starts, not just before shipping it.

- **Migration**: does this need a schema/data migration? Can the new and
  old code both run against the migrated state during a rolling deploy?
- **Rollback**: if this fails in production, what's the actual rollback
  path, and has it ever been exercised, or only assumed to work?
- **Parity**: what's meaningfully different between staging and production
  for this change (data volume, config, third-party sandbox vs. live)?
- **Blast radius**: if this breaks, who or what is affected, and is there a
  way to limit exposure (flag, canary, percentage rollout) rather than an
  all-or-nothing cutover?

These three surfaces produce three different artifacts, and mixing them up
is how context gets lost:

- An answer that is load-bearing or hard to reverse becomes an ADR,
  `docs/adr/NNNN-<decision>.md`. It needs to be independently citable —
  `code-review` cites one to suppress a smell it would otherwise flag.
- A question that *cannot* be answered yet is not a default and does not
  evaporate. It becomes `docs/questions/NNNN-<slug>.md`, stating what was
  assumed in its place and what breaks if that assumption is wrong. See
  `skills/grilling/SKILL.md`.
- Everything smaller — the decision that isn't load-bearing, the failure
  that cost an afternoon, the constraint invisible in the finished result —
  goes in the running record, `skills/decision-record/SKILL.md`. Promote an
  entry out of it the moment it turns out to matter more than it looked.

## System model

The answers to the System Surface questions above, once they settle:
component boundaries, data flow, consistency guarantees, failure posture,
capacity assumptions. Keep it current — a system model that describes an
intended architecture rather than the running one is trusted and wrong.

<!-- Diagrams, component boundaries, data flow, as they get established. -->
