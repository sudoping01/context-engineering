---
name: code-review
description: Review the diff since a fixed point along two axes, Standards and Spec, with severity-tiered output. Use when the user wants a branch, PR, or work-in-progress change reviewed.
---

Two-axis review of the diff between `HEAD` and a fixed point the user
supplies (commit, branch, tag, or merge-base). Run both axes as separate
passes so neither pollutes the other's findings, then aggregate.

## 1. Pin the fixed point and spec

`git diff <fixed-point>...HEAD` (three-dot, against the merge-base).
`git log <fixed-point>..HEAD --oneline` for the commit list. Confirm the ref
resolves and the diff is non-empty before going further.

Find the originating spec: issue references in commit messages, a path the
user gives, or a spec file under `docs/`/`specs/` matching the branch name.
If none exists, ask; if the user says there isn't one, the Spec axis
reports "no spec available" instead of failing.

## 2. Standards axis

Read `CODING_STANDARDS.md` in full: the Fowler baseline plus this repo's
risk-surface, system, and deployment smells. A documented ADR accepting a
tradeoff suppresses that smell; cite the ADR instead of re-flagging it. An
open `docs/questions/` entry does not suppress a smell — it means the
answer was assumed, so check the diff against what that entry says it
assumed, and flag any divergence.

Check the diff against seven areas:

1. **Security**: input validation, auth/authorization, data exposure, the
   Trust-on-Read and Unbounded Exposure smells specifically.
2. **Performance & efficiency**: algorithmic complexity, the
   Recompute-Over-Maintain smell specifically, unnecessary computation.
3. **Code quality**: naming, function/class size, duplication, the full
   Fowler baseline.
4. **Architecture & design**: separation of concerns, dependency direction,
   error handling, the Silent Convention Deviation smell specifically, and
   the Shallow Module / Leaky Seam smells using the `codebase-design`
   vocabulary (module, interface, seam, depth) rather than looser terms.
5. **Testing & documentation**: coverage of the changed behavior, comment
   necessity and clarity, the Implied Protection smell specifically where
   docs overclaim a guarantee.
6. **System behavior**: if the diff crosses a process, service, or
   independent-rate boundary, check it against the system smells —
   Unbounded Wait, Blind Retry, Unbounded Buffer, Shared Write Site,
   Unversioned Contract. Ask what a caller does when the dependency is
   slow rather than down; "it fails" is only an answer if there's a
   timeout. If the diff stays inside one process, say so and skip.
7. **Deployment readiness**: if the diff touches a migration, a shared
   contract, config, or a network-facing surface, check it against the
   deployment smells in `CODING_STANDARDS.md`. If nothing in the diff
   reaches production directly, say so and skip.

## 3. Spec axis

Compare the diff against the spec: what's missing or partial, what's in the
diff but wasn't asked for (scope creep), what looks implemented but is
wrong. Quote the spec line for each finding.

## 4. Output

```
## 🔴 Critical — must fix before merge
- **<file>:<line>** — <problem>. <why it matters>.
  Suggested fix:
  ```<language>
  <code>
  ```
  Rationale: <why this fix, not just what>

## 🟡 Suggestions — worth considering
- **<file>:<line>** — <same shape as above, lower stakes>

## ✅ Good practices — what's done well
- <specific thing, not generic praise>

## Spec
- Missing: <requirement, quoted>
- Scope creep: <behavior not asked for>
- Wrong: <implemented but incorrect against spec>
```

Standards findings and Spec findings stay in separate sections; don't merge
or rerank across axes. A change can pass one and fail the other, and
collapsing them into one ranked list hides that.

End with a one-line summary: count per severity, worst issue within each
axis.
