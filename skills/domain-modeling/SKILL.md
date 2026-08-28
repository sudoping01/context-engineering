---
name: domain-modeling
description: Build and sharpen the project's domain model. Use when discussing codebase terminology, or editing CONTEXT.md or an ADR.
---

Actively challenge terms and record decisions as they crystallize, not just
read `CONTEXT.md` for vocabulary.

- **Challenge against the glossary**: when a term conflicts with
  `CONTEXT.md`, say so immediately. "Your glossary defines X as A; you seem
  to mean B. Which is it?"
- **Sharpen fuzzy language**: propose a precise term for anything vague or
  overloaded. "You said 'account' — the Customer or the User? Those are
  different things here."
- **Stress-test with scenarios**: invent concrete edge cases that force
  precision about where one concept ends and another begins.
- **Cross-reference with code**: if stated behavior contradicts what the
  code does, surface the contradiction rather than silently trusting either
  source.
- **Update inline**: write the resolved term into `CONTEXT.md`'s glossary
  the moment it's settled, not at session end. Write a new ADR the moment a
  decision is made, not as a batch afterward.

If no `CONTEXT.md` exists, create it when the first term resolves. If no
`docs/adr/` exists, create it when the first decision needs recording.
