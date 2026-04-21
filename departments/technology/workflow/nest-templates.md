# Technology — nest templates

Canonical past-tense titles + description shapes for Tech nests.

---

## Code change / PR

**Title:** `[feature / fix] [in service]` — past tense on close.

Examples:
- `Header-chain reorg window widened to 100 blocks`
- `SpvClient.verify() added with 3 unit tests`
- `Mempool RPC timeout fix deployed to staging`

**Description:**
```html
<h3>What</h3>
<p>Change in [service @ commit SHA]: [one-sentence outcome].</p>
<h3>Why</h3>
<p>[Driving tension / bug report / perf issue. Link to Nestr tension if one exists.]</p>
<h3>Who for</h3>
<p>[Downstream consumer: SDK users / reference-node ops / internal service X].</p>
<h3>Classification</h3>
<p>Internal. [Confidential if responding to a security report.]</p>
<h3>Acceptance criteria</h3>
<ul>
  <li>Unit tests pass; new cases cover [X].</li>
  <li>Benchmark within 5% of baseline (or justified delta).</li>
  <li>Security reviewer signed off (if crypto / auth / consensus path).</li>
  <li>CHANGELOG updated.</li>
  <li>PR merged; deploy to [env] scheduled.</li>
</ul>
<h3>Labels</h3>
<p>code-change, service/[name], classification/internal</p>
```

---

## Research note

**Title:** `[Question, answered]` — past tense as a statement.

Examples:
- `Header-chain sync rate vs CPU profile investigated`
- `SPV proof size growth under high-throughput tx streams measured`

**Description:**
```html
<h3>Question</h3>
<p>[One sentence.]</p>
<h3>Decision that depends on the answer</h3>
<p>[What we'll change based on result.]</p>
<h3>Classification</h3>
<p>Internal. [Confidential if dataset references specific partner deployments or contains customer traces.]</p>
<h3>Acceptance criteria</h3>
<ul>
  <li>Question answered explicitly: yes / no / it-depends, with evidence.</li>
  <li>Method reproducible — scripts committed, raw-data path referenced (not pasted if Confidential).</li>
  <li>"Did not do" section present (scope boundary).</li>
  <li>Follow-up tensions filed for any new gaps surfaced.</li>
</ul>
<h3>Labels</h3>
<p>research, topic/[slug], classification/internal</p>
```

---

## RFC / BRC / ADR

**Title:** `[BRC candidate / ADR] for [topic] drafted`

Examples:
- `BRC candidate for standardized SPV proof format drafted`
- `ADR: use rocksdb for header cache in reference-node drafted`

**Description:**
```html
<h3>What</h3>
<p>[BRC / ADR] titled "[title]" proposing [specification summary].</p>
<h3>Why</h3>
<p>[Driving tension. Which BRCs does it touch / supersede?]</p>
<h3>Who for</h3>
<p>[Implementers, spec readers, reference-node operators, SDK teams.]</p>
<h3>Classification</h3>
<p>Internal while drafting; Public on BRC submission / ADR publication.</p>
<h3>Acceptance criteria</h3>
<ul>
  <li>Sections: Motivation, Specification, Rationale, Backward-compat, Reference-impl, Security considerations.</li>
  <li>Two named reviewer roles approved (cross-role via tensions).</li>
  <li>Conformance test vectors drafted.</li>
  <li>BSV Academy cross-references added for introduced terms.</li>
  <li>For BRC: submitted to the Standards circle governance tension; number assigned.</li>
</ul>
<h3>Labels</h3>
<p>rfc, brc-candidate, topic/[slug], classification/internal→public-on-publish</p>
```

---

## Incident / postmortem

**Title:** `[Incident short name] resolved`

Examples:
- `Signing service outage 2026-03-14 resolved`
- `Header DB corruption 2026-Q1 triaged`

**Description:**
```html
<h3>What</h3>
<p>[Incident type + time window + services affected.]</p>
<h3>Impact</h3>
<p>[User-facing impact; quantified where possible; customer-data / key exposure flagged.]</p>
<h3>Classification</h3>
<p>Confidential by default; Restricted if customer-key impact or legal exposure.</p>
<h3>Acceptance criteria</h3>
<ul>
  <li>Timeline complete (detection, mitigation, resolution).</li>
  <li>Root cause documented.</li>
  <li>Remediations implemented; each remediation has its own linked nest with acceptance criteria.</li>
  <li>Blameless review completed with Tech Lead + Security.</li>
  <li>If customer-visible: external comms tension to Marketing / Exec complete.</li>
  <li>Follow-ups filed; none left dangling.</li>
</ul>
<h3>Labels</h3>
<p>incident, classification/confidential, severity/[low|med|high|critical]</p>
```

---

## CI / deployment change

**Title:** `[Pipeline / env / config] [outcome]`

Examples:
- `Staging deploy pipeline migrated to v2 workflow`
- `Production feature flag [name] enabled with 10% rollout`

Description follows the code-change pattern with explicit rollback plan and approver named in acceptance criteria.
