---
name: tech:research-note
description: Template-driven research-note scaffold. Forces explicit Question / Decision-that-depends / Method / "Did not do" sections. Time-boxed; supports reproducibility by committing scripts alongside. Invoke when starting a Tech research spike.
classification: Internal
owner: "@bsva/technology"
version: 0.1.0
---

# tech:research-note

Prevents the "I investigated for a week and wrote 40 pages" antipattern.

## Behavior
1. CLARIFY: the one-sentence question, the decision that depends, the time box.
2. Scaffolds from `templates/new-research-note/` — `note.md` skeleton + `scripts/` dir.
3. Enforces the "Did not do" section.
4. On close: proposes follow-up tensions for any gaps surfaced.

## Hard rules
- Question must be one sentence.
- Decision dependency must be explicit.
- Raw data paths referenced, not pasted, when Confidential.
- Method must be reproducible (scripts committed).
