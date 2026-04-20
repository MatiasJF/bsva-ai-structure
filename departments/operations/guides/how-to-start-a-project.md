# How to start an Operations project

## First decision: which sub-section

Operations includes four sub-sections. Pick the one that fits:

- `biz-dev/` — a partnership, sales lead, RFP response.
- `marketing/` — a campaign, post, launch, event.
- `legal/` — contract work, compliance, regulatory filing.
- `exec/` — strategy doc, board / investor communication.

Each sub-section has its own CLAUDE.md and templates (where applicable). Prefer linking to the sub-section CLAUDE.md for more specific context.

## Scaffold

```bash
cp -R ~/bsva-ai-structure/departments/operations/templates/new-brief ~/projects/my-brief
cd ~/projects/my-brief
# link the nearest-fitting CLAUDE.md
ln -s ~/bsva-ai-structure/departments/operations/biz-dev/CLAUDE.md CLAUDE.md
git init && git add . && git commit -m "scaffold"
```

## Pre-flight — extra strict

Operations content is high-sensitivity. Before pasting **anything**:

- Is this an unannounced partner? → **Never Claude.**
- Is this contract / NDA content? → **Legal process.**
- Does this name specific people with specific context? → **Redact to roles.**
- Does this include specific amounts + specific parties? → **Redact.**

See `security/redaction-playbook.md` for the specific techniques.

## Common Operations workflows

### Drafting a partnership proposal
- Use placeholders throughout: `[PARTNER_A]`, `[AMOUNT]`, `[TIMELINE]`.
- Ask Claude for structure, boilerplate, boilerplate-with-tone.
- Fill specifics after, outside Claude.
- Legal review before sending.

### Drafting a blog / announcement
- Fine to share published materials with Claude.
- Draft announcement: keep in Internal tier until approval.
- No mention of unreleased partner/product names until go-live.

### Handling inbound partner communications
- Redact sender identity to `[PARTNER_A]` before pasting.
- Redact any specifics (amounts, timelines, commitments) they named.
- Ask Claude for structural suggestions — you fill in the specifics.

### Contract / legal work
- Never paste contracts. Describe the clause-level question abstractly.
- Legal Lead owns contract drafting; Claude can help with research and structure, not the contract itself.
