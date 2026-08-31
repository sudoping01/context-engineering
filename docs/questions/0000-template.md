# NNNN. The question, stated as a question

**Status**: Open | Answered | Obsoleted
**Raised**: YYYY-MM-DD, during <grilling session / review / incident>
**Surface**: Risk | System | Deployment | Task-specific

## Why it's open

Why this could not be settled in the interview. One of: the user doesn't
know yet; it needs a fact nobody has; it's blocked on someone or something
outside this work; it needs a runnable answer (`prototype`) that hasn't
been run.

Not a valid reason: nobody thought to ask. That's a gap in `grilling`, not
an open question.

## What each answer would change

Enumerate the plausible answers and what each one makes true. If every
answer leads to the same implementation, this isn't a real question —
delete it.

## Assumed in the meantime

**Assumption**: what the code currently does, as if this were answered.
**Breaks if wrong**: concretely, what fails and how it would be noticed.
**Cost to reverse**: cheap (local change) | moderate | load-bearing (this
is really an ADR waiting to happen — say so).

If nothing was assumed because the work is genuinely blocked, say
**Blocking**: and name what can't proceed.

## Answer

Fill in when it resolves, with the date and how it was settled — measured,
decided, or overtaken by events. Then set Status. If the answer is
load-bearing or hard to reverse, write the ADR and link it here rather than
leaving the reasoning only in this file.
