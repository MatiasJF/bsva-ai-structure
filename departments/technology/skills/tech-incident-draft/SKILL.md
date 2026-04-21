---
name: tech:incident-draft
description: Structures a Confidential incident postmortem draft (timeline / impact / root cause / contributing factors / remediation / follow-ups). Prompts for redaction at each step; refuses to continue if raw customer identifiers or key material appears. Invoke during incident response.
classification: Confidential
owner: "@bsva/technology"
version: 0.1.0
---

# tech:incident-draft

Postmortem draft structuring.

## Behavior
1. Prompts for incident scope + sensitivity; sets classification floor (Confidential min; Restricted for customer-key impact).
2. Runs `anonymizer` on all pasted logs / traces before drafting.
3. Drafts: Summary / Timeline / Impact / Root cause / Contributing factors / Remediations / Follow-ups.
4. Links remediation items to (to-be-created) Nestr nests under the appropriate roles.
5. Flags what needs external comms (tension to Marketing / Exec).

## Hard rules
- Refuses to proceed if key-material exposure detected.
- Refuses to paste-back raw customer identifiers.
- All quantitative impact claims require primary-source (log / metric) citation.
