---
name: decision-record
description: Maintain a running decision record for the work — decisions, failures, constraints, and open questions discovered while doing it. Use throughout, not as documentation written afterwards.
---

# Maintaining a Decision Record

Keep one file as the running record of the work. Default to
`docs/record.md`; override it per project by setting these two lines and
leaving the rest unchanged:

- **File:** `docs/record.md` (or `docs/spec.md`, `NOTES.md` — one file,
  named once, not a new one per session)
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

## Tag every entry

Prefix each entry with what kind of claim it is. Four tags, and the
distinction between them is the entire point of the record:

- **FACT** — observed. You ran it, read it, measured it, or found it in a
  primary source. A fact carries its evidence: the command, the log line,
  the file and line, the source.
- **DECISION** — chosen. Carries the alternative that lost and why, and
  who made the call if it wasn't you.
- **ASSUMPTION** — believed, not verified. Carries what would falsify it
  and what breaks if it's wrong. This is the tag that matters most.
- **UNKNOWN** — an open question. If it's blocking or load-bearing, it
  belongs in `docs/questions/` as well, with this entry pointing at it.

```
FACT (2026-03-04) — Broker rejects payloads over 128 KB. Verified: publish
of a 131,072-byte payload returned RC 2 in mqtt_client.py:212.

ASSUMPTION — Topic count grows monotonically and is never pruned.
Falsified by: any delete path on the registry. Breaks: the incremental
chunk index, which only ever appends. Cost: moderate.
```

An untagged record is the failure mode this exists to prevent. Read back
by a later session — or a later agent — an assumption written in the same
voice as a fact *becomes* a fact, and nothing downstream ever re-checks it.
That is how a system ends up resting on something nobody verified and
nobody remembers choosing.

Two rules follow from this:

- **Never promote a tag silently.** An ASSUMPTION becomes a FACT only when
  someone verifies it, and the entry then carries the evidence and the date
  it was checked. Editing the tag without doing the work is worse than
  leaving it wrong, because it launders the uncertainty.
- **Demote when confidence drops.** If a FACT turns out to have rested on
  reasoning rather than observation, retag it ASSUMPTION and say what
  prompted the change.

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
- **Record only what you verified**, or tag it ASSUMPTION. Never write a
  measurement you did not take, and never write one without saying how it
  was taken.
- **Correct the record when you are wrong**, in the record itself. Quietly
  dropping a mistake teaches the next reader nothing and costs them the
  same discovery.
- **Write for someone arriving with no context**, not for the person who
  asked you.
- **Cut what is recoverable.** If deleting a sentence would lose nothing
  that cannot be recovered by examining the subject, delete it.

## The failure to avoid

A record that describes intentions rather than reality. A file claiming
something is finished when it is not, naming something that no longer
exists, or stating an assumption in the register of a fact, is worse than
no file: it is trusted and wrong. Whenever you touch it, make sure every
claim in it still holds and still carries the right tag.
