# Biz-Dev — partnership proposal shell playbook

Claude produces a **placeholder-only template**; real values are filled in a separate document outside Claude.

---

## When to use this

- Drafting a sponsorship proposal.
- Drafting a tech-integration proposal.
- Drafting an RFP response skeleton.
- Drafting a co-marketing proposal.

## When not to use this

- Finalizing a signed document. Claude never sees the final named values.
- Any proposal being actively negotiated with a partner. The in-flight commercial terms stay out.

## The cycle

### 1. CLARIFY
- Deal archetype (sponsorship / tech integration / co-marketing / custom).
- Generic structure needed (sections: executive summary, value prop, scope, commercials, timeline, next steps).
- Placeholder count — how many `[PARTNER_A]` placeholders, how many `[AMOUNT]` placeholders.
- Target audience (technical / business / exec).

### 2. CAPTURE
**Nest** under Biz-Dev role. Confidential.

Title: `Partnership proposal shell ([archetype]) shipped`

Acceptance criteria:
- Template uses placeholders throughout: `[PARTNER_A]`, `[AMOUNT]`, `[TERM_MONTHS]`, `[REGION]`.
- No real partner name, real amount, or real commercial term anywhere.
- Generic structural sections filled: value prop, scope, timeline (in relative terms).
- Voice passed `external-comm-check`.

### 3. EXECUTE
Claude produces a 3–5 page Markdown template with placeholders:

```markdown
# Partnership Proposal: BSVA × [PARTNER_A]

## Executive summary
BSVA proposes a [TERM_MONTHS]-month collaboration with [PARTNER_A]...

## Value proposition
[3–5 bullets in BSVA voice; no specific metrics the partner hasn't shared.]

## Scope
1. [Placeholder for deliverable 1]
2. [Placeholder for deliverable 2]
...

## Commercial terms
- Total value: `[AMOUNT]` (to be agreed)
- Payment schedule: `[MILESTONES]`
- Exclusivity: `[SCOPE]`

## Timeline
- Kick-off: `[DATE]`
- Milestones: `[MILESTONES]`
- Completion: `[DATE]`

## Next steps
`[ACTIONS]`
```

### 4. REPORT
> "Shell ready: `proposal-shell-[archetype].md` — placeholders only; specifics filled outside Claude. External-comm-check: passed."

### 5. CLOSE
Biz-Dev uses the shell in their real proposal doc (outside Claude). Filling in specifics is done locally; the filled version is **not** brought back into Claude.

---

## Hard rules

- **Never** put a real partner name into this skill's input or output.
- **Never** put a real $ amount.
- **Never** reference an in-flight specific deal.

If the user tries to feed specifics — Claude refuses and asks them to genericize first.

## What if the user pastes a partly-filled proposal and asks for edits?

- Run `anonymizer` on it first.
- Edit the anonymized version.
- The user re-fills outside Claude.

Never operate directly on the filled version.
