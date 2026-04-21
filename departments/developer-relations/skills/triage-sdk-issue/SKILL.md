---
name: triage-sdk-issue
description: Classifies a dev-support thread into one of: answer-now, repro-needed, tension-to-Tech (real bug), known-issue. Invoke at the start of any dev-support work. Produces the triage decision plus the recommended next action.
classification: Internal
owner: "@bsva/devrel"
version: 0.1.0
---

# triage-sdk-issue

One-shot classification to keep dev-support flow fast.

## Behavior
1. Reads the thread + any repro.
2. Decides: answer-now / repro-needed / bug-to-Tech / known-issue.
3. For bug-to-Tech: drafts the tension body.
4. For known-issue: finds the prior nest/tension for reference.
5. For repro-needed: drafts the request with exact fields needed.

## Hard rules
- Never classify as "answer-now" if verify-sdk-surface can't resolve the symbols the user is asking about.
- Never auto-escalate to Tech without minimum repro in hand.
