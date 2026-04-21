# 05 — Plan-mode discipline

When Claude uses plan-mode vs when it doesn't.

---

## The rule

**Plan-mode is mandatory** for any work that meets *any* of these:
- Touches more than 2 files.
- Expected to take more than 30 minutes.
- Will be shipped externally (blog, PR, partner comm, published lesson).
- Modifies code that enters a shared system (SDK, Academy, reference services).
- Involves Confidential-or-higher content.

**Plan-mode is optional** for:
- One-file edits within your own scratch.
- Trivial transformations (JSON → YAML, reformat a paragraph).
- Continuation of a session where a plan was already approved and the scope hasn't changed.

**Plan-mode is unhelpful** for:
- 3-line fixes with an obvious outcome.
- Conversational Q&A.

---

## How to enter plan-mode

- **CLI:** `shift+tab` in the prompt, or `/plan`.
- **Desktop app:** toggle the plan-mode chip, or `/plan`.

Claude will propose a plan and wait. You read it, push back in discussion, then approve with a clear "go".

---

## What a good plan looks like

A plan is a short document the user reads in under 2 minutes. It has:

1. **Reference** — link / ID of the Nestr nest or tension.
2. **Goal** — one sentence, restating the acceptance criteria in your own words.
3. **Approach** — the intended order of work, at the right level of detail. (Not "I will write code" → "I will add method `verify()` to `SpvClient`, add 3 unit tests in `spv-client.test.ts`, update `README.md` with a usage block.")
4. **Files** — explicit list of files to be created / changed.
5. **Dependencies** — skills, MCPs, external reviews needed.
6. **Estimate** — a rough time range.
7. **Risks / open questions** — what could go wrong, what you need to confirm.

### Example (Tech)

```
Ref: Nestr nest #N-8842 "SPV verify() added to SpvClient with tests"

Goal
Add a `verify(proof: MerkleProof, txid: string): boolean` method
to SpvClient; 3 unit tests; docs.

Approach
1. Read existing SpvClient implementation (src/spv-client.ts) —
   confirm current shape, headers source.
2. Add verify() method following the Merkle-path pattern from
   SDK's `verifyMerkleProof` utility (verify it exists with a
   grep; don't hallucinate).
3. Add tests in tests/spv-client.test.ts — happy path,
   tampered-proof, missing-header cases.
4. Update README.md with a usage snippet.

Files
- src/spv-client.ts (edit)
- tests/spv-client.test.ts (edit)
- README.md (edit)

Dependencies
- None external. Uses only installed deps.

Estimate
~45 minutes.

Risks / open questions
- Question: is the tampered-proof test expected to throw, or return false?
  (Current suite mixes both styles.)
- Risk: if the headers source changes signature, tests will need
  rework; guarded by adding a header-fixture helper.
```

### Example (DevRel)

```
Ref: Nestr nest #N-6611 "Blog post BRC-100 interface evolution published"

Goal
1500-word blog post on BRC-100 interface evolution, on the BSVA blog.

Approach
1. Outline — 5 H2 sections: What, Why-it-matters, Interface-v1,
   Interface-v2, Migration-patterns.
2. Draft — BSVA voice, primary sources cited inline (BRC-100, spec link).
3. Embed one code example (SDK call) — verify method names against
   installed @bsv/sdk via verify-sdk-surface skill.
4. Peer review — comment on nest when draft ready, ping DevRel Peer.
5. Tension to Tech sdk-maintainer — only for the Interface-v2 section.

Files
- posts/brc-100-interface-evolution/post.md (new)
- posts/brc-100-interface-evolution/assets/ (new dir, may be empty)

Dependencies
- Skill: verify-sdk-surface
- Tension to sdk-maintainer (separate node)

Estimate
~90 minutes for first draft. Peer + technical review each ~1 day.

Risks / open questions
- Audience tone: "intermediate SDK dev, some Bitcoin background" — check
  I'm landing that with the peer reviewer.
```

---

## What a bad plan looks like

> "I'll look at the code, make some changes, and add tests."

Too vague. No file list, no scope, no risks. Ask Claude to redo with specifics.

> "I'll do steps 1-37 outlined here…"

Too detailed. If the plan is longer than the work, something's wrong. Plans are for alignment on approach, not a line-by-line script.

> "Trust me, I got this."

If Claude ever says this, push back.

---

## The discussion phase

After Claude presents a plan, you:

- **Question** assumptions. "Why the Merkle-path pattern and not the index-based one?"
- **Trim scope.** "Skip the README update for now; let's revisit after Tech review."
- **Add constraints.** "Keep the diff under 200 lines or split."
- **Identify dependencies you noticed.** "We'll need a decision from Legal on the license file before we can publish — open that tension now, not at the end."

Rounds: 1–3 typical, sometimes more for complex work. **The plan isn't precious; refining it is free.**

---

## Transitioning from plan to execution

Once approved, say so explicitly:

> "Approved. Go."

Then Claude exits plan-mode and starts executing step 7 (SCAFFOLD) → step 8 (EXECUTE). The approved plan becomes the reference in the Nestr nest description (add it as a comment if the plan evolved during discussion).

---

## If the plan needs to change mid-execution

Any of:
- Discovered a blocker not in the plan.
- Scope grew (or shrank).
- Approach wasn't viable after trying.

**Stop. Post a comment on the nest explaining.** Offer an updated plan. Get re-approval. Resume.

Don't silently do something other than what was approved. That breaks trust and audit.

---

## The meta-rule

Plan-mode is cheap. Wrong work is expensive.

If you're unsure whether a task "needs" plan-mode — use it. The 2 minutes of reading a plan is always less than the 30 minutes of redoing work that went sideways.
