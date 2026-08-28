---
name: grilling
description: Interview the user about a plan or design before writing code. Use before any non-trivial implementation, or when the user uses a "grill" trigger phrase.
---

Interview the user until every branch of the design tree is resolved. Do not
write code until this session ends with an empty frontier.

## Design tree

Every decision branches into the decisions that hang off it. The
**frontier** is every decision whose prerequisites are already settled: the
questions answerable right now without guessing at answers you haven't
heard yet.

Always start the frontier by pulling in `CONTEXT.md`'s Risk Surface and
Deployment Surface sections as standing nodes, in addition to whatever the
task itself raises. These don't get skipped because the user didn't
mention them; that's the entire point of the standing list.

## Rounds

Ask the whole frontier in one round: numbered questions, each with your own
recommended answer.

```
❓ **Q1** - **<title>**: <question, may be multiple paragraphs>

➡️ <your recommended answer>

---

❓ **Q2** - **<title>**: <question>

➡️ <your recommended answer>
```

Each answer reshapes the tree: settled decisions push the frontier outward
and unblock questions that depended on them. Recompute and ask the next
round. A question whose answer depends on another still-open question
belongs to a later round.

Facts are your job, never the user's. If a frontier question needs a fact
from the environment (filesystem, existing ADRs, prior code), go find it
yourself; don't ask the user for something you could look up. Don't block
the rest of the frontier on it.

## Done

The session ends when the frontier is empty: every risk-surface question,
every deployment-surface question, every task-specific branch has an
explicit answer, not a silent default. Confirm the shared understanding
with the user before writing any code. Record any answer worth remembering
past this session as an ADR (`docs/adr/`), not just in the conversation.
