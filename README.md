# Engineering Context Kit

A drop-in set of docs and agent skills for AI coding agents, covering full
lifecycle software engineering: design, implementation, review, debugging,
and release.

## Why this exists

Code generation is increasingly solved: a mapping from spec to behavior,
checkable and bounded. Software engineering is not. Software is code plus
everything the spec didn't say — who's adversarial, what happens under
load, what a dependency being *slow* rather than down does to everything
upstream, what breaks in five years, what the deploy does to users
mid-rollout.

Agents are strong at the first and weak at the second, and the gap is not
knowledge. Ask an agent directly how someone defeats an offline license
check and it names clock rollback immediately. Ask it to *build* one and it
compares `datetime.now()` to a stored expiry. The knowledge was there; the
posture wasn't. Nothing in a literal task description triggers the search
for the unasked question, so the question never gets asked.

This kit is a set of structural forcing functions, not a hope that the
agent remembers to ask. Each piece either interviews before code is written,
gates a loop the agent can't skip past, or reviews a diff against a fixed
checklist, rather than trusting judgment alone.

## Structure

```
.
├── AGENTS.md
├── CLAUDE.md
├── CODING_STANDARDS.md
├── CONTEXT.md
├── docs
│   ├── adr
│   │   └── 0000-template.md
│   └── questions
│       └── 0000-template.md
├── README.md
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
    ├── system-design
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

Fill in `CONTEXT.md`'s glossary and its Risk, System, and Deployment
Surface answers as they resolve. Create the first ADR in `docs/adr/` the
first time one of those questions gets a real answer worth remembering —
and the first entry in `docs/questions/` the first time one of them
*can't* be answered, so the gap is recorded instead of silently defaulted.

## Order of use

See `skills/router/SKILL.md` for the full flow map, including on-ramps
(triage, diagnosing-bugs) and standalone tools (resolving-merge-conflicts,
git-safety). Short version:

1. **`grilling`** before writing any non-trivial code, detouring through
   `prototype` or `research` if a question needs a runnable answer or more
   facts than are on hand. Anything it can't settle becomes a
   `docs/questions/` entry rather than a quiet default.
2. **`system-design`** whenever the change spans more than one module,
   process, or service — it supplies the frontier nodes `grilling` asks
   about boundaries, data flow, partial failure, and capacity.
3. **`tdd`** to build, informed by `codebase-design` for module shape.
4. **`code-review`** on the diff before merge.
5. **`deployment-readiness`** before shipping to a shared or production
   environment, **`release-management`** for the release itself.
6. **`improve-architecture`** and **`triage`** run on their own schedule,
   not tied to a single change: codebase upkeep and issue intake,
   respectively.
7. **`git-safety`** is installed once, not run per task — it's a standing
   gate underneath everything else.
