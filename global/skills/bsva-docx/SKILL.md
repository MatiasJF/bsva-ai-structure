---
name: bsva-docx
description: Generate professional .docx documents using the BSV Association Word Template 2025. Use this skill whenever asked to create a BSVA-branded document, a document using the BSV template, or any .docx that should follow BSV Association formatting. Also triggers on requests for Chronicle-related documents.
classification: Internal
owner: "@bsva/devrel"
---

# bsva-docx

This directory is a **pointer skill**. The actual skill implementation ships with the Claude Code install (or a BSVA internal distribution) — this SKILL.md documents that BSVA has adopted it as a global standard and declares how it must be used inside BSVA.

## When Claude should invoke this

- User asks for a BSVA-branded Word document
- User mentions "Chronicle", "briefing doc", "position paper" in BSVA context
- User asks to convert Markdown / notes into a formatted .docx

## Classification rules

The skill produces documents that inherit the classification of their content. The skill itself does not reclassify — **the human chooses the classification** before asking for the document. See `guides/for-humans/07-BEFORE-YOU-PASTE.md`.

## Where the real skill lives

The implementation is distributed with the Claude Code runtime. If the skill is not available on your machine, contact DevRel.

## Owner

DevRel maintains BSVA's usage conventions for this skill. Technical updates to the underlying template come from the BSVA brand team.
