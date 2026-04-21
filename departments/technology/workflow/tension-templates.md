# Technology — tension templates

How Tech asks other roles. Cluster wherever possible.

---

## Tension → Security (security reviewer role)

**When:** crypto / auth / consensus code change; suspected vulnerability; dependency with CVE.

**Title examples:**
- `Security review: SPV proof verification in PR #482`
- `Triage: dependency X has CVE-YYYY-NNNN — impact on reference-node?`

**Pathway:** 3 (outcome).

**Body:**
```html
<h3>Context</h3>
<p>[1–2 sentences + link to the nest / PR.]</p>
<h3>Ask</h3>
<p>[Specific review scope — which files, which scenarios, timeframe.]</p>
<h3>Threat model (my thinking)</h3>
<p>[Attack vectors I considered, mitigations in the PR.]</p>
<h3>By when</h3>
<p>[Hard date if deployment-gated.]</p>
```

---

## Tension → Standards circle (governance)

**When:** proposing a BRC.

**Title:** `Propose BRC: [title] for [purpose]`.
**Labels on tension parts:** `brc-candidate`, plus the sub-part labels (`motivation`, `specification`, etc.).

Follow Nestr governance flow: draft → proposed → accepted/objected.

---

## Tension → DevRel

**When:** SDK surface changes that DevRel will document; example-repo updates; dev-support patterns feeding back into design.

**Title examples:**
- `SDK v1.10 surface review: new methods for BRC-100`
- `Recurring dev-support pattern: header-sync configuration`

**Pathway:** 2 (info share) or 3.

---

## Tension → Ops / SRE

**When:** infra capacity requests, deploy window coordination, on-call handoff.

**Title examples:**
- `Capacity: reference-node staging needs +2 CPU cores`
- `Deploy window request for production feature-flag rollout`

Cluster infra asks weekly where possible.

---

## Tension → Legal

**When:** OSS license review, dependency-license concerns, patent / IP claims in code.

**Title examples:**
- `License review: adding dependency [name] under [license]`
- `Patent concern: BRC candidate uses [technique] — check freedom-to-operate?`

Legal reviews are never fast. Tension early.

---

## Governance tensions (Tech circle)

Examples:
- `Propose role: Release Manager (Tech circle)`
- `Propose policy: all consensus-critical changes require Security + Standards review`
- `Propose domain: BSVA reference-node infrastructure`

---

## Clustering norms for Tech

- **Dependency bumps**: one weekly "dependency review" tension to Security listing all bumps.
- **Code-review asks across repos**: one tension per reviewer role listing all pending reviews.
- **CI / infra asks**: one tension per week to Ops, bulleted.

---

## What Tech never does via tension

- **Production-signing asks** — never via Claude-assisted tension; always via the established signing ceremony.
- **Key rotation coordination** — use dedicated security channel, not general tensions.
- **Incident declaration** — incidents start with a direct page (PagerDuty / on-call); the tension is filed parallel for durable record but does not replace the page.
