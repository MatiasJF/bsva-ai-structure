# DevRel — nest title + description templates

Canonical shapes for DevRel Nestr nests. Fill in brackets.

---

## Dev-support reply

**Title:** `SDK [symptom] answered ([source] [date])`

Example: `SDK import error on v1.9 answered (Discord #dev-help 2026-04-20)`.

**Description:**
```html
<h3>What</h3>
<p>Answered dev-support question about [symptom] in [SDK version]. Source: [Discord thread URL / GitHub issue / email].</p>

<h3>Why</h3>
<p>User blocked; public reply helps the next person who hits the same.</p>

<h3>Who for</h3>
<p>[SDK user level, e.g., SDK-new developer].</p>

<h3>Classification</h3>
<p>Internal (Public once posted publicly).</p>

<h3>Acceptance criteria</h3>
<ul>
  <li>Reply posted to [source URL].</li>
  <li>Minimal sanitized repro attached or linked, if a bug report.</li>
  <li>If bug: tension filed to sdk-maintainer with link.</li>
  <li>If doc gap: note added to SDK docs patch queue.</li>
</ul>

<h3>Labels</h3>
<p>dev-support, sdk/[version], triage</p>
```

---

## SDK example

**Title:** `Example: [concept] walkthrough shipped`

Example: `Example: PushDrop token mint walkthrough shipped`.

**Description:**
```html
<h3>What</h3>
<p>A [length] example illustrating [single concept] using @bsv/sdk v[X]. Target surface: [examples repo / blog / workshop].</p>

<h3>Why</h3>
<p>[Developer demand: Discord question rate, recurring support theme, upcoming workshop need, etc.]</p>

<h3>Who for</h3>
<p>[SDK-new / BSV-new / intermediate SDK users].</p>

<h3>Classification</h3>
<p>Internal (Public on publish).</p>

<h3>Acceptance criteria</h3>
<ul>
  <li>Runs on `npm i && npm start` on fresh clone.</li>
  <li>Uses public test vectors or a fresh generated testnet key (never a shared one).</li>
  <li>README has Objectives + Prerequisites + Run instructions.</li>
  <li>No hardcoded secrets.</li>
  <li>DevRel peer review recorded as comment on this nest.</li>
  <li>verify-sdk-surface passed against @bsv/sdk v[X].</li>
</ul>

<h3>Labels</h3>
<p>sdk-example, ts-sdk, audience/[level], classification/internal→public-on-publish</p>
```

---

## Blog post / tutorial

**Title:** `Blog post on [topic] published`

Example: `Blog post on BRC-100 interface evolution published`.

**Description:**
```html
<h3>What</h3>
<p>[Word count range] post on [topic], published on [BSVA blog / cross-post target].</p>

<h3>Why</h3>
<p>[Driving question: developer demand, new spec landing, topic underserved, etc.]</p>

<h3>Who for</h3>
<p>[Audience: specific, concrete].</p>

<h3>Classification</h3>
<p>Internal (Public on publish).</p>

<h3>Acceptance criteria</h3>
<ul>
  <li>[Word count range]; lead paragraph states the claim.</li>
  <li>Cites [BRC/BIP/spec] directly; links BSV Academy concepts for every underlined term.</li>
  <li>Every code snippet runs (verify-sdk-surface passed).</li>
  <li>DevRel peer review recorded in comments.</li>
  <li>Technical review via tension to [Tech sdk-maintainer / other] for [sections X, Y].</li>
  <li>classify-before-publish gate passed by [DevRel Lead].</li>
  <li>Classification flipped to Public in comment after publish.</li>
</ul>

<h3>Labels</h3>
<p>blog, topic/[slug], audience/[level], classification/internal→public-on-publish</p>
```

---

## Workshop

**Title:** `Workshop "[title]" delivered at [event]`

Example: `Workshop "Build a BRC-100 wallet in 90 min" delivered at DevCon Lagos`.

**Description:**
```html
<h3>What</h3>
<p>[Duration] workshop titled "[title]" at [event / date / venue]. Repo includes lessons, starter + solution branches, slides (bsva-pptx), facilitator notes.</p>

<h3>Why</h3>
<p>[Driving reason: event need, developer interest, product adoption, etc.]</p>

<h3>Who for</h3>
<p>Attendees: [skill level + context].</p>

<h3>Classification</h3>
<p>Internal until event. Public after event recording lands.</p>

<h3>Acceptance criteria</h3>
<ul>
  <li>Lesson branches 01–N build sequentially and pass CI.</li>
  <li>Solutions branch passes CI.</li>
  <li>Slides in bsva-pptx template, ≤ [N] slides.</li>
  <li>facilitator-notes.md exists with timing + pitfalls.</li>
  <li>Dry-run completed with one non-DevRel reviewer (recorded as comment).</li>
  <li>All attendee keys / faucet endpoints tested on the event day.</li>
  <li>Classification flipped to Public after publish, with recording URL comment.</li>
</ul>

<h3>Labels</h3>
<p>workshop, event/[slug], skill/[level], needs-tech-review</p>
```

---

## Conference / hackathon enablement

**Title:** `[Enablement type] for [event] delivered`

Examples:
- `Talk "SPV at scale" delivered at DevCon Lagos`
- `Judging rubric for DevCon Lagos hackathon shipped`
- `Prize track spec for BSV Hackathon 2026 published`

**Description follows the pattern above** — always include: event, date, BSVA's role, budget/sponsor tension link, publish gate status.
