---
name: external-comm-check
description: Scans content against BSVA brand-voice rules (banned phrases, capitalization, hype markers, price speculation, non-first-party claims, exclamation density, uncited names). Returns a structured pass/fail/warning report. Invoke on every draft before publish.
classification: Internal
owner: "@bsva/operations"
version: 0.1.0
---

# external-comm-check

The brand-voice linter. Used across Operations and every publish-gate.

## Behavior
1. Reads content.
2. Runs the checks in `marketing/brand-voice-linter.md`.
3. Returns structured pass/fail/warning report with line references.

## Extending
Add new banned phrases, hype markers, or capitalization rules via PR to this skill's body — the vocabulary lives here.

## Hard rules
- Never auto-fixes; author decides per finding.
- "Revolutionary" and friends are blockers, not warnings.
- Exclamation density triggers at >1 per 300 words.
