---
name: tech:new-rfc
description: Emits the structure for a new BRC candidate or internal ADR. Produces the tension parts (motivation, specification, rationale, backward-compat, reference-impl, security-considerations) with BSV Academy cross-references for introduced terms. Invoke when starting RFC / BRC / ADR work.
classification: Internal
owner: "@bsva/technology"
version: 0.1.0
---

# tech:new-rfc

Drafts the RFC scaffold.

## Behavior
1. Decides BRC vs ADR vs both.
2. Produces the section skeleton with placeholder prompts.
3. Pulls BSV Academy concepts via `bsv_get_concepts` for any introduced term.
4. For BRCs: drafts the governance tension with appropriately-labeled parts.
5. Identifies cross-role reviewers needed (Security for crypto, DevRel for developer-facing).

## Hard rules
- BRC without a driving tension is refused — proposal is premature.
- Security-Considerations section is required for any BRC touching cryptography.
- No "revolutionary" / hype language in RFC prose.
