---
name: research
description: Investigate a question against primary sources and capture findings as a cited markdown file. Use when a topic, API, or library needs to be researched before it can be grilled or designed against.
---

# Research

Reading legwork, done as a background task so the main thread keeps moving.

## Job

1. Investigate against **primary sources**: official docs, source code,
   specs, first-party APIs — not a blog post summarizing them. Follow every
   claim back to the source that actually owns it.
2. Write findings to a single markdown file, citing the source of each
   claim inline, not as a bibliography nobody checks against specific
   lines.
3. Save it wherever the repo already keeps this kind of note; match the
   existing convention. If there's none, pick somewhere sensible and say
   where, out loud.

## What this feeds

Research findings are input to `grilling`, not a substitute for it. A
cited fact about how a library behaves doesn't resolve a design question by
itself — it just means the frontier question in `grilling` can be answered
from evidence instead of assumption. Bring the file into the interview
rather than treating "I researched it" as equivalent to "I decided."

If the research surfaces a security or licensing constraint (a library's
actual guarantees versus what was assumed, a documented CVE, a rate limit
that wasn't known), route that into `CONTEXT.md`'s Risk Surface immediately
rather than letting it sit only in the research file.
