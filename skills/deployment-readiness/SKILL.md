---
name: deployment-readiness
description: Gate before shipping a change to a shared or production environment. Use before merging or deploying anything that reaches real infrastructure or real users.
---

A change is not deploy-ready because it works locally and passed
`code-review`. This is a separate gate: everything that only breaks once
real infrastructure, real traffic, or real data is involved.

Do not mark a deploy ready without an explicit answer to each item below.
"Not applicable" is a valid answer; silence is not.

## 1. Migration safety

- Does this change require a schema or data migration?
- If yes: can the previous version of the code and the new version both run
  correctly against the migrated state? (Required for any rolling or
  zero-downtime deploy — if the answer is no, the deploy must be a hard
  cutover with downtime, stated explicitly, not discovered mid-rollout.)
- Is there a tested down-migration, or is this irreversible? If
  irreversible, does everyone deploying it know that going in?

## 2. Contract and version skew

- Does this change a shared contract (API shape, message/queue payload,
  event schema)?
- If yes: what happens if an old-version consumer or producer is still
  running when this deploys? Is the change backward and forward compatible
  for the duration of the rollout?

## 3. Environment parity

- What's meaningfully different between staging and production for this
  specific change (data volume, config, third-party sandbox vs. live
  credentials, feature flags)?
- If staging can't actually exercise the risky part of this change, say so;
  don't let a green staging run stand in for confidence it doesn't earn.

## 4. Config and secrets

- Does this introduce a new required env var, secret, or config value?
- Is it provisioned in every target environment already, or does someone
  need to add it before this can deploy? Who, and has it happened?

## 5. Blast radius and rollout strategy

- If this breaks, who or what is affected, and how many?
- Is this shipping as an all-at-once cutover, or gated (feature flag,
  canary, percentage rollout)? If all-at-once, is that a deliberate choice
  for a low-blast-radius change, or a default that should be reconsidered?

## 6. Rollback

- What's the actual rollback path: revert the deploy, flip a flag, or
  something more involved (undo a migration, replay data)?
- Has this rollback path ever actually been exercised, or is it only
  assumed to work?

## 7. Observability

- If this fails in production, what signal tells you it failed: a log, a
  metric, an alert? Does that signal exist yet, or does this deploy
  introduce a failure mode with no way to detect it short of a user report?

## Done

Every item above answered explicitly. Record any answer that reveals a
real tradeoff (irreversible migration, all-at-once cutover for a
meaningful blast radius, no rollback path) as an ADR, since the next person
deploying a related change needs to know it was a deliberate choice, not an
oversight.
