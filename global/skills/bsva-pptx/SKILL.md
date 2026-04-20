---
name: bsva-pptx
description: Generate professional .pptx presentations using the BSV Association PowerPoint Template (April 2025). Use this skill whenever asked to create a BSVA-branded presentation, a presentation using the BSV template, or any .pptx that should follow BSV Association formatting.
classification: Internal
owner: "@bsva/devrel"
---

# bsva-pptx

Pointer skill — see `../bsva-docx/SKILL.md` for the pattern.

## When Claude should invoke this

- User asks for a BSVA-branded slide deck
- User mentions "keynote deck", "board deck", "conference slides" in BSVA context
- User asks to convert outline / notes into a presentation

## Classification rules

Presentations often contain Confidential or Restricted information (board, strategy, financials). **Always ask the user to confirm the tier** before generating, and default to `confidential` metadata if the user does not specify.

## Owner

DevRel + BSVA brand team.
