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

Always start the frontier by pulling in `CONTEXT.md`'s Risk Surface,
System Surface, and Deployment Surface sections as standing nodes, in
addition to whatever the task itself raises. These don't get skipped
because the user didn't mention them; that's the entire point of the
standing list. Pull the System Surface whenever the change spans more than
one module, process, or service — `skills/system-design/SKILL.md` has the
trigger list and the vocabulary behind those nodes.

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

## Questions that can't be settled

Some frontier nodes won't resolve in the room: the user doesn't know yet,
it needs a fact nobody has, it's blocked on someone else, it needs a
`prototype` run that hasn't happened. Such a node is not permission to pick
a default and move on quietly, and it is not allowed to evaporate when the
session ends.

Write it to `docs/questions/NNNN-<slug>.md` (see the template there) with:
what each possible answer would change, what you assumed in its place,
what breaks if that assumption is wrong, and how expensive it is to
reverse. Then say so out loud to the user in the closing summary — an
assumption the user never heard is the one that hardens into a fact three
sessions later.

If nothing can reasonably be assumed, the entry records what is blocked
instead, and that work does not start.

"Nobody thought to ask" is never a reason for an entry here. That's a hole
in the interview; go ask.

## Done

The session ends when the frontier is empty: every risk-surface question,
every system-surface question, every deployment-surface question, every
task-specific branch has either an explicit answer or a `docs/questions/`
entry — never a silent default. Confirm the shared understanding with the
user before writing any code, and read back the assumptions along with the
answers. Record any answer worth remembering past this session as an ADR
(`docs/adr/`), not just in the conversation.
