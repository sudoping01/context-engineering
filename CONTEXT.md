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

Once a risk-surface or deployment-surface question gets a real answer worth
remembering, record it as `docs/adr/NNNN-<decision>.md` instead of leaving
it implicit here. For smaller decisions, failures, constraints, and open
questions that come up while doing the work but aren't individually
load-bearing enough for their own ADR, use `skills/decision-record/SKILL.md`'s
running record instead — see that skill for the boundary between the two.

## System model

<!-- Diagrams, module boundaries, data flow, as they get established. -->
