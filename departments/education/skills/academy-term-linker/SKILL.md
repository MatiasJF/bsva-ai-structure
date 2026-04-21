---
name: academy-term-linker
description: For every underlined or first-appearance term in a lesson, looks up the canonical BSV Academy concept via the bsv_get_concepts MCP and inserts inline links or anchors. Refuses to define a term from training data if the Academy has a canonical definition. Invoke before publish gate on any lesson.
classification: Internal
owner: "@bsva/education"
version: 0.1.0
---

# academy-term-linker

Source-of-truth enforcement for terms.

## Behavior
1. Scans the lesson for technical terms (underlined, italicized, or first-appearance pattern).
2. Queries `bsv_get_concepts` for each.
3. Inserts the canonical link / anchor.
4. If the lesson's definition diverges from the Academy's — flags for author review.

## Hard rules
- Never defines a term from training data if Academy has a definition.
- Never uses outdated terminology (Academy is source of truth).
- Flags definition divergence, doesn't overwrite.
