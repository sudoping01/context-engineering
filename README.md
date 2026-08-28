# Engineering Context Kit

A drop-in set of docs and agent skills for AI coding agents, covering full
lifecycle software engineering: design, implementation, review, debugging,
and release. 
## Why this exists

Code is a solved-problem mapping from spec to behavior: checkable, bounded.
Software is code plus everything the spec didn't say: who's adversarial,
what happens under load, what breaks in five years, what the deploy does to
users mid-rollout. AI agents are strong at the first and weak at the second,
not from a knowledge gap but a default-posture gap: nothing in a literal
task description triggers the search for the unasked question.

This kit is a set of structural forcing functions, not a hope that the
agent remembers to ask. Each piece either interviews before code is written,
gates a loop the agent can't skip past, or reviews a diff against a fixed
checklist, rather than trusting judgment alone.

## Structure

```
AGENTS.md               lean root instructions, read natively by Codex, Cursor,
                         Copilot, Windsurf, Zed, Aider, Gemini/Jules, VS Code, JetBrains
CLAUDE.md                one line, @AGENTS.md — Claude Code doesn't read AGENTS.md
                         natively as of writing, so this bridges the two
CONTEXT.md              domain glossary + standing risk-surface questions
CODING_STANDARDS.md     smell baseline the review skill checks every diff against
docs/adr/               decision records, one per resolved risk-surface question
skills/
  router/                 flow map across every skill below — read this when unsure what's next
  grilling/               interview-before-code: build the design tree, ask, don't guess
  domain-modeling/        keep CONTEXT.md and terminology honest as the model changes
  codebase-design/        deep-module vocabulary: module, interface, seam, depth, leverage
  tdd/                    red/green loop, seam discipline, named test anti-patterns
  prototype/              throwaway code to answer a design question before committing to a build
  research/               R&D against primary sources, cited findings feed back into grilling
  diagnosing-bugs/        gated red/green loop for hard bugs, no hypothesizing without it
  resolving-merge-conflicts/  resolve by intent traced to primary sources, never --abort
  code-review/            two-axis diff review: Standards + Spec, severity-tiered output
  improve-architecture/   scan for deepening opportunities using codebase-design vocabulary
  triage/                 state machine for issues and PRs that arrived raw
  decision-record/        running log of decisions, failures, and constraints, updated as they happen
  deployment-readiness/   pre-deploy gate: migration, rollback, parity, observability
  release-management/     versioning, approval gates, post-release verification, rollback triggers
  git-safety/             enforced hook blocking force-push, reset --hard, clean -f, branch -D
```

## Install

Copy this whole tree into a project root. Fill in `AGENTS.md`'s project and
build/test placeholders — keep it short, detail belongs in the linked files,
not duplicated into the root file.

That's it for Codex, Cursor, Copilot, Windsurf, Zed, Aider, Gemini/Jules,
VS Code, and JetBrains — they all read `AGENTS.md` from the repo root
natively, no extra setup.

Claude Code is the one exception: it reads `CLAUDE.md`, not `AGENTS.md`,
natively. The included `CLAUDE.md` is a one-line `@AGENTS.md` import, so the
same content reaches Claude Code without a second copy to maintain. If
Claude Code later adds native `AGENTS.md` support, the bridge file can be
deleted.

Fill in `CONTEXT.md`'s glossary and risk-surface answers as they resolve.
Create the first ADR in `docs/adr/` the first time a risk-surface question
gets a real answer worth remembering.

## Order of use

See `skills/router/SKILL.md` for the full flow map, including on-ramps
(triage, diagnosing-bugs) and standalone tools (resolving-merge-conflicts,
git-safety). Short version:

1. **`grilling`** before writing any non-trivial code, detouring through
   `prototype` or `research` if a question needs a runnable answer or more
   facts than are on hand.
2. **`tdd`** to build, informed by `codebase-design` for module shape.
3. **`code-review`** on the diff before merge.
4. **`deployment-readiness`** before shipping to a shared or production
   environment, **`release-management`** for the release itself.
5. **`improve-architecture`** and **`triage`** run on their own schedule,
   not tied to a single change: codebase upkeep and issue intake,
   respectively.
6. **`git-safety`** is installed once, not run per task — it's a standing
   gate underneath everything else.

## Credit

Interview-as-design-tree, gated bug-diagnosis phases, and two-axis review
are adapted from [mattpocock/skills](https://github.com/mattpocock/skills).
Severity-tier output format (🔴/🟡/✅) and review-category breadth are
adapted from GitHub's Copilot code-review prompt convention. Deployment
readiness and release management are original to this kit.
