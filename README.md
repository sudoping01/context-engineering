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
sed@sed:~/Desktop/agent-context$ tree
.
├── AGENTS.md
├── CLAUDE.md
├── CODING_STANDARDS.md
├── CONTEXT.md
├── docs
│   └── adr
│       └── 0000-template.md
├── README.md
├── README.pdf
└── skills
    ├── codebase-design
    │   └── SKILL.md
    ├── code-review
    │   └── SKILL.md
    ├── decision-record
    │   └── SKILL.md
    ├── deployment-readiness
    │   └── SKILL.md
    ├── diagnosing-bugs
    │   └── SKILL.md
    ├── domain-modeling
    │   └── SKILL.md
    ├── git-safety
    │   ├── scripts
    │   │   └── block-dangerous-git.sh
    │   └── SKILL.md
    ├── grilling
    │   └── SKILL.md
    ├── improve-architecture
    │   └── SKILL.md
    ├── prototype
    │   └── SKILL.md
    ├── release-management
    │   └── SKILL.md
    ├── research
    │   └── SKILL.md
    ├── resolving-merge-conflicts
    │   └── SKILL.md
    ├── router
    │   └── SKILL.md
    ├── tdd
    │   └── SKILL.md
    └── triage
        └── SKILL.md

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
