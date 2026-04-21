# Biz-Dev — partner public-posture playbook

Research a single named (publicly-announced) entity's public stance on a topic. Example: "What has Blockstream said publicly about L2 scaling in the last 12 months?"

---

## When it's OK to name

- Target has publicly announced themselves (firm, fund, exchange, maker).
- Target's stance is referenced via public content (posts, talks, interviews).

**Not OK to name:**
- Target BSVA is in private negotiation with (not yet announced). → Placeholder, not real name, even if they've been publicly-active elsewhere. The **private BSVA context** is what makes it Restricted.
- Anyone from HR / candidate pipeline / internal BSVA.

## The cycle

### 1. CLARIFY
- Target name (confirmed public).
- Topic scope (L2 scaling, institutional custody, regulatory, etc.).
- Time window (last 6 / 12 / 24 months).
- Output form: brief memo, bullet summary, timeline.
- Purpose (intro call prep, sponsorship pitch, general intel).

If Claude detects the target is in private BSVA conversation (user confirms) → **stop and escalate**. This session belongs in Restricted tier, which means placeholder-only.

### 2. CAPTURE
**Nest** under Biz-Dev role. Confidential.

Title: `[PARTNER_A] public-posture brief on [topic] shipped`

Acceptance criteria:
- Sources: allowlisted public content only.
- Timeline / bullets cited with URLs.
- No inference beyond what the source supports.
- BSVA-side context (why we're researching this) is **not** in the nest description; it lives in a private Biz-Dev doc outside Claude.

### 3. EXECUTE
Fetch and summarize. Draft a 1–2 page brief:
- Key public positions (with quotes and URLs).
- Timeline of relevant public statements.
- Audience / platform patterns.
- Open questions / gaps (what the public record doesn't show).

### 4. REPORT
> "Brief ready: `brief-[PARTNER_A]-[topic]-2026-Q2.md`. 12 citations; 3 quotes; 1 gap noted (no public stance on X). File in: `~/ops-briefs/` (Confidential)."

### 5. CLOSE
Biz-Dev Lead or user reviews. If the brief informs a meeting, that meeting's prep is a separate nest (meeting-prep-pack playbook, not written here yet).

---

## What Claude does / doesn't do

Does:
- Search allowlisted sources.
- Summarize with citations.
- Name public entities.
- Note gaps and ambiguities.

Doesn't:
- Make predictions about what the target will do next (speculation = out of scope).
- Combine public data with BSVA's private conversation history.
- Fabricate quotes or attributions.
- Access subscription databases without explicit ToS + contract confirmation.
