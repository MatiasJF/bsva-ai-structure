---
name: reading-level-checker
description: Checks a lesson or passage against a target reading level (Flesch-Kincaid or equivalent), plus jargon density and sentence-length spread. Returns specific suggestions to simplify without losing technical accuracy. Invoke before publish gate.
classification: Internal
owner: "@bsva/education"
version: 0.1.0
---

# reading-level-checker

## Behavior
1. Reads the content + target grade level.
2. Computes reading-level metrics (FK, SMOG, or similar).
3. Flags: passive voice overuse, sentence-length outliers, high-jargon paragraphs.
4. Suggests simplifications that preserve technical accuracy.

## Hard rules
- Never simplifies a technical claim in a way that changes its meaning — flags instead.
- Preserves primary-source citations intact.
