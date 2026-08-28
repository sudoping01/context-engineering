---
name: release-management
description: Version, gate, and verify an actual release, and define the rollback trigger for the window after it ships. Use when cutting a release, not just merging a change.
---

`deployment-readiness` gates a single change before it ships. This skill
covers the release itself, the batch of changes going out together, and
what happens in the window right after.

## 1. Versioning

- What's the version bump, and why (semver: breaking, additive, fix-only)?
  A version bump that doesn't match the actual change type is a Version
  Skew Blind Spot smell against consumers who trust semver to decide
  whether to upgrade automatically.
- Is the changelog entry written from the consumer's perspective (what
  changed for them), not just a copy of commit messages?

## 2. Approval gates

- Fill in per project: who signs off before this release ships (tech lead,
  on-call, a specific reviewer), and is that gate actually enforced in the
  pipeline or just a norm people can skip under pressure?
- For anything crossing a `deployment-readiness` item with no rollback path
  or an irreversible migration, does the approval gate require that ADR to
  be linked, not just a general thumbs-up?

## 3. Pre-release checklist

- Every change in this release has passed `code-review` and, where it
  reaches production, `deployment-readiness`.
- Aggregate blast radius: several individually low-risk changes shipping
  together can compound. State the combined blast radius, not just each
  change's own.

## 4. Post-release verification

- What's the smoke test run immediately after deploy, and who runs it
  (automated or a human)?
- What's the defined success window: how long does the release get watched
  before it's considered stable, and what's watched during it (error rate,
  latency, a specific metric tied to the change)?

## 5. Rollback trigger

- What specific threshold triggers a rollback decision (error rate above
  X%, a specific alert firing, a specific user-facing symptom reported)?
  A vague "if something looks wrong" is not a trigger; state the number or
  the signal.
- Is the rollback decision automatic or does a human decide? If a human,
  who, and are they actually available during the post-release window?

## Done

Version, changelog, approval gate, smoke test, watch window, and rollback
trigger are all stated explicitly before the release ships, not decided
improvised in the middle of an incident. Record the rollback trigger
threshold in `docs/adr/` if it's meaningfully different from the project's
usual default, so the next release doesn't have to reinvent it.
