# Legal — template starter playbook

The main legitimate Legal use of Claude: drafting generic templates from public reference material.

## When to use this

- Creating or refreshing a BSVA generic template (MNDA, DPA, MSA, Term Sheet, SoW — non-specific).
- The template is a starting-point only; actual deal-specific language is filled outside Claude.

## When not to use this

- Any BSVA-specific matter.
- Any counterparty-specific language.
- Any reference to specific partners, amounts, or timelines.

## The cycle

### 1. CLARIFY
- Template type (MNDA / DPA / MSA / etc.).
- Jurisdiction (Swiss / US / UK / EU / other).
- Reference standards (ISLA MNDA, DPA template from EDPB, industry-standard).
- Generic scope / term assumptions.
- Intended usage: starting-point skeleton for Legal to customize per matter.

### 2. CAPTURE
**Nest** under Legal Lead role. Restricted (session), but the output (a generic template) is Internal.

Title: `[Template type] v[N] starter drafted`

Example: `MNDA starter (Swiss jurisdiction) v1 drafted`.

Acceptance criteria:
- Draws from named public reference standards (listed in description).
- Generic — no named parties, no specific amounts / terms.
- Structurally complete (sections all present).
- BSVA disclaimer: "template only; not legal advice; customize per matter."
- Legal Lead review completed.

### 3. PLAN-MODE
Outline the template's sections (preamble, definitions, obligations, term, termination, remedies, governing law).

### 4. EXECUTE
Draft in Markdown or the BSVA-approved document tool. Reference each section's public-standard source in a comment.

### 5. REPORT
Comment on nest: "Template drafted; [N] sections; refs listed. Ready for Legal Lead review."

### 6. CLOSE
Legal Lead reviews + approves → moves to BSVA's approved template library (outside Claude).

## What Claude does / doesn't do

Does:
- Cite public reference standards.
- Draft structurally complete templates.
- Note common drafting options.
- Apply BSVA disclaimer.

Doesn't:
- Fill in deal-specific terms.
- Access BSVA's actual executed contracts for comparison.
- Suggest "aggressive" or "favorable" language without noting it's a stylistic choice.
- Produce output that could be confused for legal advice.

## After approval

- Templates live in BSVA's approved template library — **not** in this repo.
- Reference them by ID in future work.
- Updates follow the same cycle (new version, referenced standard changes, etc.).
