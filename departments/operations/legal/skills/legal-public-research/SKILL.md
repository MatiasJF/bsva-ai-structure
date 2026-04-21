---
name: legal-public-research
description: Researches public law, regulation, and published guidance from approved sources. Refuses BSVA-specific matter (contracts, privileged material, specific disputes). Session runs Restricted; output is typically Internal research material, never legal advice. Invoke for Legal's allowed research activities only.
classification: Restricted
owner: "@bsva/operations"
version: 0.1.0
---

# legal-public-research

The single narrow scope for Legal's Claude usage.

## Behavior
1. Confirms the question is public-law / regulation / policy — not BSVA-specific matter.
2. Fetches from allowlisted sources (regulatory pubs, public case law, academic journals).
3. Produces a cited summary or jurisdictional comparison.
4. Applies the "not legal advice" disclaimer.
5. `/clear` after delivery.

## Hard rules
- BSVA-specific matter → refuse. Mode A.
- Privileged correspondence → refuse.
- Contract content (signed or draft) → refuse.
- Output is draft research material, not legal advice.
