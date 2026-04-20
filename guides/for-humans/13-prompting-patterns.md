# 13 — Prompting patterns

The patterns that consistently get better results at BSVA. Keep this open in a tab; copy what you need.

---

## 1. Spec-first

Before a big task, write a short spec in plain Markdown. Paste it to Claude. Ask Claude to critique the spec *before* implementing.

```
Here's what I want to build / write / do. Before you start, tell me:
- What's unclear?
- What assumptions would you make, and are they right?
- What's the smallest version that would validate the approach?
```

Why: Claude's best output comes from a clear target, and the critique step catches misunderstandings before they waste your time.

---

## 2. Plan-mode

For anything touching more than 2 files or 30 minutes of work: enable plan-mode (`/plan` or `shift+tab`). Claude writes a plan, you approve, then it executes.

Don't skip this for "small" changes. Refactors that seem small are never small.

---

## 3. Critic mode

After any draft:

```
Now read that back as a skeptical reviewer at [our audience]. What's weak?
```

or:

```
Assume the reader is going to try to poke holes in this. Where will they succeed?
```

Best for: blog posts, one-pagers, technical proposals, emails where tone matters.

---

## 4. Transform, don't generate

Claude is strongest when you give it raw material and ask it to reshape. Prefer:

- "Turn these bullet notes into a 3-paragraph brief"
- "Rewrite this email in a more neutral tone"
- "Convert this Markdown into our one-pager skill's input format"

over:

- "Write a blog post about X" (generic result)
- "Draft an email to Y" (no context → hallucinated tone)

---

## 5. Attach instead of paste (for anything >500 words)

Long pastes get truncated or paraphrased inside the model's own summary. Attach files; reference by section.

```
Read the attached brief. Use the 'Objectives' section only.
Draft a 200-word summary aimed at [audience].
```

---

## 6. Scoped permissions

Before a session where Claude will edit code, `cd` into the exact folder you want edited. Don't start a session at `~/` and give it the whole disk.

If using the Desktop app: set the project's working directory to the narrowest possible folder.

---

## 7. Commit-before-commit

If Claude edits your code:

1. `git status` — is this the right baseline?
2. Let Claude make its change.
3. `git diff` — read every line.
4. Commit.

Don't stack three rounds of Claude edits without committing in between. You will regret it.

---

## 8. Fresh session for fresh context

If Claude is getting lost, confused, or inconsistent: `/clear` and start over with a crisper prompt. Don't try to steer a long, messy conversation back on track — it's faster to restart.

---

## 9. Role-framing for voice

BSVA's voice is technical, calm, never hype-y. If Claude is drifting:

```
You are writing for the BSV Association: precise, professional,
never speculative, never price-mentioning, never "revolutionary".
Audience is informed developers and institutions.
Rewrite in that voice.
```

See `guides/for-claude/brand-voice.md`.

---

## 10. The "show, don't tell" example

Paste 2–3 examples of the output you want, then ask for more:

```
Here are three headlines I like for BSVA content:
1. "How SPV works under the hood"
2. "Six UTXOs: a deep dive"
3. "What PushTx can and can't do"

Now give me 5 more in this style for these topics: [list].
```

Far more effective than a style description.

---

## 11. "Don't narrate, just do it"

Claude sometimes explains its reasoning at length. For production content, suppress that:

```
Answer in the final output only. No preamble, no "here's what I did",
no meta-commentary. If you have questions, ask them first as a single
bulleted list. Otherwise produce the final output.
```

---

## 12. Subagents for parallel research

When you need to compare 3 things, spawn 3 subagents:

```
Launch 3 Explore agents in parallel:
- one to research [X]
- one to research [Y]
- one to research [Z]
Then summarize their findings in a comparison table.
```

Much faster than sequential research, and protects your main context from being flooded.

---

## 13. Loop for polling

```
/loop 5m check the status of the build in the current folder
and tell me when it's green.
```

Beats refreshing a terminal every 30 seconds.

---

## 14. The thing to *stop* doing

- Pasting an entire doc and asking "what do you think".
- Giving feedback like "make it better" (be specific).
- Opening 40-turn sessions and blaming Claude when it drifts.
- Skipping `git diff` because you're tired.
- Trusting any claim Claude makes about BSVA people, partners, or numbers without verifying. **Claude does not know these; it will confabulate.**
