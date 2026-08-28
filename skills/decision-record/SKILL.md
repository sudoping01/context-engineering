---
name: decision-record
description: Maintain a running decision record for the work — decisions, failures, constraints, and open questions discovered while doing it. Use throughout, not as documentation written afterwards.
---

# Maintaining a Decision Record

Keep one file as the running record of the work. Set these two lines per
project and leave the rest unchanged:

- **File:** `<path>` (e.g. `docs/spec.md`, `NOTES.md`, `record.md`)
- **Subject:** what the work produces (e.g. a codebase, a dataset, an
  infrastructure estate, a report, a set of experiments)

Treat the record as part of what you deliver, not documentation written
afterwards. Update it at the moment a decision is made or a fact is
discovered, never in a tidy-up pass at the end — by then the reasoning is
gone and only the conclusion is left.

## Relationship to `docs/adr/`

This record and the ADRs in `docs/adr/` are not the same thing. An ADR is
for a decision that's architecturally load-bearing or genuinely hard to
reverse — the kind `grilling` resolves and `code-review` later cites to
suppress a smell. It benefits from being individually addressable and
permanent.

This record is for everything else: the failure that cost an afternoon to
diagnose, the constraint that isn't visible anywhere in the finished
result, the open question that's still open, the smaller decision that
doesn't warrant its own file. If an entry here turns out, in hindsight, to
have been a major or hard-to-reverse decision, promote it: write the ADR,
and replace the entry here with a pointer to it. Don't let something
load-bearing sit buried in a long chronological file when it should be
independently citable.

## What belongs in it

- **Decisions, with the alternative that lost and why.** A decision
  recorded without its rejected alternative reads as arbitrary later, and
  the next person re-opens it from scratch.
- **Facts discovered by doing**, especially failures: what went wrong, the
  evidence, the cause, and what changed as a result. These cost the most to
  learn and are the least recoverable from the finished work.
- **Constraints that are not visible in the result** — a limit imposed by a
  tool, a service, a budget, a policy, a person's availability.
- **Open questions**, stated as questions, with what each possible answer
  would change.
- **Work items and their state**: what is done, what is blocked, and on
  what.

## What does not belong in it

- Anything the subject itself already states. The record explains the
  subject; it does not duplicate it.
- A changelog of your own edits, if the work is under version control or
  otherwise tracked.
- Restatements of the task you were given.

## How to write it

- **Explain why, not what.** The reader can examine the result; they
  cannot see what it was weighed against, or what was tried and abandoned.
- **Update in place.** When something is superseded, rewrite that entry and
  say what changed it. Do not append a new section that contradicts an
  older one and leave both standing.
- **Record only what you verified.** If a claim rests on reasoning rather
  than on something you actually observed, say so in the text. Never write
  a measurement you did not take.
- **Correct the record when you are wrong**, in the record itself. Quietly
  dropping a mistake teaches the next reader nothing and costs them the
  same discovery.
- **Write for someone arriving with no context**, not for the person who
  asked you.
- **Cut what is recoverable.** If deleting a sentence would lose nothing
  that cannot be recovered by examining the subject, delete it.

## The failure to avoid

A record that describes intentions rather than reality. A file claiming
something is finished when it is not, or naming something that no longer
exists, is worse than no file: it is trusted and wrong. Whenever you touch
it, make sure every claim in it still holds.
