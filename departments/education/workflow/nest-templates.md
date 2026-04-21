# Education — nest templates

---

## Lesson

**Title:** `[Topic] lesson ([audience]) published`

Examples:
- `UTXO lesson (beginner-dev) published`
- `SPV proofs lesson (intermediate) published`

**Description:**
```html
<h3>What</h3>
<p>Single-page Academy lesson on [topic] targeting [audience]. [Length] words + [N] CfU items.</p>
<h3>Why</h3>
<p>[Module gap / curriculum request / refresh reason.]</p>
<h3>Who for</h3>
<p>[Audience + prerequisites, concretely.]</p>
<h3>Objectives</h3>
<ul>
  <li>[Verb-led objective 1]</li>
  <li>[Verb-led objective 2]</li>
  <li>[Verb-led objective 3]</li>
</ul>
<h3>Classification</h3>
<p>Internal (Public on publish).</p>
<h3>Acceptance criteria</h3>
<ul>
  <li>All stated objectives covered in content.</li>
  <li>Every technical claim cross-checked against BSV Academy MCP (`bsv_get_concepts`) or a BRC/BIP.</li>
  <li>3+ CfU items matching lesson definitions exactly.</li>
  <li>Alt text on all diagrams.</li>
  <li>Reading level ≤ [target grade] per reading-level-checker.</li>
  <li>BSVA brand voice passed (external-comm-check).</li>
  <li>Peer review (another educator) recorded as comment.</li>
  <li>Technical review via tension to DevRel/Tech if protocol/consensus claims are made.</li>
  <li>classify-before-publish gate passed by Education Lead.</li>
  <li>Classification flipped to Public in comment after publish.</li>
</ul>
<h3>Labels</h3>
<p>lesson, topic/[slug], audience/[level], classification/internal→public-on-publish</p>
```

---

## Assessment bank

**Title:** `[Module/Lesson] assessment bank v[N] shipped`

**Description:**
```html
<h3>What</h3>
<p>Assessment items for [lesson/module]. [N] items covering [list of objectives].</p>
<h3>Classification</h3>
<p>Internal during development; Public only selectively (example items in marketing).</p>
<h3>Acceptance criteria</h3>
<ul>
  <li>Every item traces to a stated objective.</li>
  <li>Answers quote lesson definitions verbatim.</li>
  <li>No ambiguous stems.</li>
  <li>Distractors reviewed by second educator; plausible misconceptions, not nonsense.</li>
  <li>Item-analysis plan noted (to flag items for revision after pilot).</li>
</ul>
<h3>Labels</h3>
<p>assessment, module/[slug], classification/internal</p>
```

---

## Translation

**Title:** `[Source lesson] — [target language] translation published`

Example: `UTXO lesson — ES translation published`.

**Description:**
```html
<h3>What</h3>
<p>Translation of [source lesson ID @ version] to [target language], register [formal/neutral/regional].</p>
<h3>Classification</h3>
<p>Internal (Public on publish).</p>
<h3>Acceptance criteria</h3>
<ul>
  <li>EN source retained side-by-side until final review.</li>
  <li>Uncertain terms flagged with [?] and resolved with reviewer.</li>
  <li>Termbase updated with any new canonical term choices.</li>
  <li>Native-speaker practitioner review recorded as comment (via tension to reviewer's role).</li>
  <li>Final pass by original author for meaning preservation.</li>
</ul>
<h3>Labels</h3>
<p>translation, source/[lesson-id], target/[lang-code], classification/internal→public-on-publish</p>
```

---

## Learner-support reply

**Title:** `Learner support: [redacted-topic] answered ([source] [date])`

**Description:**
```html
<h3>What</h3>
<p>Drafted/sent reply to learner question about [topic, redacted of personal identifiers].</p>
<h3>Classification</h3>
<p>Confidential (contains learner identifier in the actual reply).</p>
<h3>Acceptance criteria</h3>
<ul>
  <li>PII redacted in the nest description (use anonymizer).</li>
  <li>Reply addresses the diagnosis, in the author's voice.</li>
  <li>If a doc gap was surfaced, follow-up tension opened to update the lesson.</li>
</ul>
<h3>Labels</h3>
<p>learner-support, classification/confidential</p>
```

---

## Course module

**Title:** `[Topic] module published`

**Description:** similar to lesson but at module scope — terminal objectives, lesson map, assessment strategy, estimated total time.
