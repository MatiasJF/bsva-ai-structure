# DevRel — cross-role tension templates

How DevRel asks other roles for things. Clustered where possible.

---

## Tension → Tech (sdk-maintainer role)

**When:** SDK bug discovered during support / example; request for review of SDK-adjacent content; need for clarification on unreleased SDK behavior.

**Title examples:**
- `SDK bug report: [symptom] on v[X]`
- `Review request: crypto sections of BRC-100 blog post`
- `Clarification needed: expected behavior of [method] with [edge case]`

**Pathway:** 1 (info request) for clarifications, 3 (outcome) for bug fixes.

**Body template:**
```html
<h3>Context</h3>
<p>[1–2 sentences: what I'm working on, link to my nest.]</p>

<h3>Ask</h3>
<p>[Specific question or request.]</p>

<h3>What I've tried / verified</h3>
<ul>
  <li>[Already consulted docs / Academy MCP / existing issues.]</li>
  <li>[Minimal repro: link or inline.]</li>
</ul>

<h3>By when</h3>
<p>[Hard date if any, otherwise "no rush, helps when you can".]</p>
```

---

## Tension → Marketing

**When:** cross-post request, campaign alignment, event promo copy, press release coordination.

**Title examples:**
- `Cross-post "[blog title]" to [channel]`
- `Promo copy needed for DevCon Lagos workshop`
- `Review BSVA voice on [asset]`

**Pathway:** 3 or 4.

Batch multiple asks into a single tension per campaign (use `global:nestr-cluster`).

---

## Tension → Biz-Dev

**When:** partner clearance before naming, sponsorship coordination, partner-adjacent content review.

**Title examples:**
- `Partner clearance: can I name [PARTNER_A] in the BRC-100 blog?`
- `Sponsorship coordination for BSV Hackathon 2026 prizes`

**Pathway:** 1 or 3.

Sensitivity: Biz-Dev content is Confidential default — the tension body should not include unreleased partner names. Reference them by placeholder; Biz-Dev resolves internally.

---

## Tension → Operations (Events / Legal / Exec)

**When:**
- Events logistics (travel, venue, attendee kits) → Ops.
- License or legal review of open-source material → Legal.
- Public statement involving executive positioning → Exec.

**Title examples:**
- `Travel + per-diem approval for DevCon Lagos`
- `License review for examples repo (MIT)`
- `Exec statement support: BSVA response to [industry event]`

**Pathway:** 3 or 4.

---

## Tension → Education

**When:** Academy lesson mentions SDK feature; cross-training DevRel concepts to learners; joint workshop with Academy instructors.

**Title examples:**
- `Technical review of UTXO lesson before publish`
- `Joint workshop design with Academy for DevCon Lagos`

**Pathway:** 2 (info share), 3, or 4.

---

## Governance tensions

When DevRel proposes a structural change (new role, policy, or domain) on the DevRel circle:

**Title examples:**
- `Propose role: SDK Maintainer (DevRel circle)`
- `Propose policy: all new SDK examples require verify-sdk-surface pass`
- `Propose domain: BSVA DevRel channels on Discord`

Use governance-labeled parts (`role`, `policy`, `domain`, `accountability`). These route to circle consent.

---

## Clustering norms for DevRel

DevRel creates lots of small asks — bias toward clustering:

- **SDK doc fixes**: one weekly tension titled `SDK docs cleanup batch [YYYY-Www]`.
- **Workshop prep asks**: one tension per workshop to each target role.
- **Blog peer-review asks**: one tension per week if multiple posts pending.

Target: ≤ 2 submissions per day per target role. Draft, batch, submit.

---

## What DevRel never does via tension

- **Silent scope growth**: if work grows during a project, don't tuck more into an existing tension. Open a new one.
- **Social requests**: "can we chat about X" isn't a tension. Use a 1:1 or comment on an existing nest.
- **Retroactive capture**: don't create a tension for work already done. If it's done, nest it.
