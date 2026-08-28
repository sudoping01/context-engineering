---
name: resolving-merge-conflicts
description: Resolve an in-progress git merge or rebase conflict. Use mid-conflict, hunk by hunk.
---

# Resolving Merge Conflicts

1. **See the current state.** Check git history and every conflicting file
   before touching anything.
2. **Find the primary source for each conflict.** Read the commit
   messages, the PR, the original issue — understand why each side made its
   change, not just what changed.
3. **Resolve each hunk by intent.** Preserve both sides' intent where
   possible. Where they're genuinely incompatible, pick whichever matches
   the merge's stated goal, and note the tradeoff explicitly rather than
   silently dropping one side. Never invent new behavior neither side
   asked for.
4. **Run the project's checks** — typecheck, then tests, then format — and
   fix anything the merge broke before considering it resolved.
5. **Finish the operation.** Stage everything, commit. If rebasing,
   continue through every remaining commit. Always resolve; never `--abort`
   as an escape from a hard conflict — an aborted merge just defers the
   same conflict to whoever tries next, usually with less context than
   you have right now.
