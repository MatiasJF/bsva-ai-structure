---
name: nestr-cluster
description: Collapses N related cross-role asks into one well-structured Nestr tension with a bulleted task list. Invoke when the user has 3+ tensions queued for the same target role, or when Claude notices multiple micro-asks accumulating. Prevents the "20 tensions per hour is hostile" antipattern. Uses draft status and batches submission per BSVA's ≤ 2 submissions/day/target-role norm.
classification: Internal
owner: "@bsva/devrel"
version: 1.0.0
---

# nestr-cluster

BSVA's clustering discipline as a skill. See `workflow/04-nestr-conventions.md` § "Clustering cross-role requests".

## When Claude should invoke this

- User has a list of asks for the same target role (SDK doc fixes, marketing copy reviews, legal template reviews, etc.).
- Multiple tasks in execution have spawned related cross-role questions.
- User says "I have a few things for Tech / Marketing / Legal…".

## Behavior

1. Collect the related asks (either from the user, from prior comments, or from pending drafts).
2. Verify they're genuinely related (same target role + same context). **Don't cluster across unrelated contexts** — a Legal review of a contract template doesn't belong with a Legal review of an MNDA.
3. Produce a single tension draft:

```
Title: [dept] cleanup batch — [period]
Target role: [role name]
Pathway: [info-request / outcome-request / etc.]
Classification: [tier — usually Internal]

Description:
This tension batches [N] related asks for [role]. Please action
items independently; close each with a comment. If any should be
separated, let me know.

Items:
1. [Ask 1] — [brief context + link to source nest / tension]
2. [Ask 2] — [brief context]
3. [Ask 3] — [brief context]
...

Links: [nest IDs that referenced these items]
```

4. Create in **draft** status. Show the user. Submit only on explicit approval — respecting the ≤ 2/day/target-role norm.

## Anti-patterns

- **Clustering unrelated things.** Review each item belongs to the same context before bundling.
- **Clustering urgent + non-urgent.** If one is blocking and others aren't, split.
- **Clustering governance + operational.** Per Nestr conventions, these must be separate tensions.

## Cross-reference

- `workflow/04-nestr-conventions.md`
- Nestr help: `nestr_help tension-processing`.

## Examples

*(Include 2 worked examples: 8 SDK doc fixes bundled to one tension; 3 marketing copy asks for the same campaign bundled.)*
