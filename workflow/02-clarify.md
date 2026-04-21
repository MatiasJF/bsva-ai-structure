# 02 — CLARIFY

The CLARIFY step is where Claude refuses to act and asks questions instead. This file is the **question bank**.

---

## The universal five

Every task, every department, every artifact. Claude asks these before anything else:

1. **WHAT** — concretely, what artifact should exist when we're done? (Not "a blog post" → "a 1500-word blog post on BRC-100 for the BSVA blog".)
2. **WHY** — what purpose or tension does this serve? Is there an existing Nestr tension driving it? If not, should we create one?
3. **WHO FOR** — specific intended audience. Not "developers" → "SDK-new developers who already know Bitcoin fundamentals".
4. **SUCCESS LOOKS LIKE** — how does the accountable human know this is done? This becomes the acceptance criteria.
5. **CLASSIFICATION TIER** — Public / Internal / Confidential / Restricted. Every artifact has one; if unclear, default up and flag for the owner.

The answers land in the Nestr nest description or the tension body. They stay with the work forever.

---

## Extra questions by artifact type

Each department's `workflow/clarify-questions.md` may extend these. Here are the cross-department defaults.

### Writing / content (blog, lesson, brief, post)
- **Length / format** — word count range, headings expected, diagrams needed?
- **Tone** — default BSVA voice, or audience-specific override?
- **Surface** — BSVA blog / Academy LMS / Medium / partner channel / internal only?
- **Sources** — which primary sources (BRCs, specs, BSV Academy concepts) must be cited?
- **Deadline** — hard date or flexible?

### Code (service, example, workshop, PR)
- **Language / runtime version** — explicit, not "latest".
- **Existing code baseline** — which commit SHA / branch is the starting point?
- **Test strategy** — unit / integration / snapshot / none-acceptable-and-why?
- **External systems touched** — databases, queues, RPC nodes, HSMs?
- **Performance / correctness constraints** — consensus-critical? Latency budget?
- **Review path** — who reviews before merge?

### Research / analysis (note, benchmark, competitive scan)
- **Question** — in one sentence, what are we trying to learn?
- **Decision dependent on it** — what changes based on the answer?
- **Data source + classification** — where does the data come from, what tier?
- **Time box** — hours / day / week of effort before we re-scope?
- **"Did not do" section** — what's explicitly out of scope?

### External communication (proposal, partner email, press response)
- **Named counterparty** — public, or placeholder (`[PARTNER_A]`)?
- **Is this announced** — can we name them in drafts, or redact?
- **Intended effect** — ask, inform, negotiate, decline?
- **Review path** — Marketing / Biz-Dev / Legal / Exec sign-off required?
- **Signature block** — BSVA role signing, not personal name?

### Events (workshop, conference, hackathon)
- **Date, duration, venue** — physical / virtual / hybrid?
- **Audience skill level** — beginner / intermediate / advanced?
- **Co-delivered** — solo or with whom?
- **Budget / funding** — who approves? sponsor involvement?
- **Recording rights** — recorded / not / partial?
- **Dependencies** — faucet, testnet keys, third-party tools?

### Education-specific (lesson, assessment, translation)
- **Prerequisites** — what must the learner already know?
- **Learning objectives** — 3–5 verbs ("identify, compute, distinguish").
- **Assessment strategy** — how will we know the learner got it?
- **For translations:** source version + ID? Target register? Termbase?

### Operations / biz-dev (lead lists, market research)
- **Market scope** — industry / geography / stage / size.
- **Public data only?** — confirm: no internal pipeline, no prior convos, no NDA content.
- **Output schema** — fields, row count, dedup rules.
- **Allowed sources** — which public sites are OK, which require a contract we have?
- **Classification tier on output** — almost always Confidential.

### Legal / exec (public research only)
- **Confirm:** this is public-law / public-policy / public-industry research, NOT BSVA-specific matter. If it's BSVA-specific, Claude refuses.
- **Jurisdiction** — which legal system / regulator?
- **Output use** — draft template / comparison / background brief?

---

## How Claude phrases the CLARIFY round

Good:
> "Before I start, let me ground this. [Short restatement of what I think you want.] To get this right I need to confirm a few things: [grouped questions]. Are there answers you already have, or should I flag them as open and proceed where I can?"

Better — when it makes sense, **cluster** the questions:
> "To scaffold the workshop, I need to settle five things. Rather than ask one-by-one, I'll batch them: [bulleted list]. Reply with as many as you have; I'll ask again for the rest."

Bad:
> [Claude starts writing without asking.] — Violates the rule.
> [Claude asks one question per turn.] — Wastes the user's time.
> [Claude asks 20 questions.] — Hostile. Pick the ones that matter.

---

## When it's OK to skip CLARIFY

- The task is trivial and reversible (format a paragraph, convert JSON to YAML).
- The user has already answered the questions in the prompt. (Don't re-ask what you were told.)
- The task is a continuation of a session where CLARIFY was done — reference the earlier round.

Never skip for: scaffolding new projects, drafting anything that will be published, pasting external content, multi-step refactors, anything touching Restricted content.

---

## Landing the answers in Nestr

When a nest is created in step 3, the **description field** holds:

- The five universal answers (restated cleanly).
- The artifact-specific answers that matter.
- The acceptance criteria derived from "success looks like".
- A link to the tension that spawned this work (if any).

Example description (HTML, as Nestr accepts):

```html
<h3>What</h3>
<p>1500-word blog post on BRC-100 interface evolution, published on the BSVA blog.</p>

<h3>Why</h3>
<p>Developers are asking (Discord #dev-help, GitHub issue #412) about BRC-100 compatibility guarantees.</p>

<h3>Who for</h3>
<p>SDK-using developers who already know Bitcoin fundamentals; intermediate skill.</p>

<h3>Classification</h3>
<p>Internal during drafting, Public on publish.</p>

<h3>Acceptance criteria</h3>
<ul>
  <li>1300–1700 words; lead paragraph states the claim.</li>
  <li>Cites BRC-100 directly; links BSV Academy concepts for any underlined term.</li>
  <li>DevRel peer review recorded as a comment.</li>
  <li>Tech review via tension to sdk-maintainer for any interface claim.</li>
  <li>Classification flipped to Public after publish, with publish URL in final comment.</li>
</ul>
```

**This block is the source of truth** for the rest of the cycle. Plans, PRs, and reviews all reference it.
