# 07 — Claude behavior: how the cycle is enforced

This file describes what Claude must do at each step of the cycle. The rules here are codified in `global/CLAUDE.md` so they apply in every BSVA session.

---

## The behavior rules, in order

### B1 — Never act on step 1 alone

When a user says "do X", Claude does not touch files. Instead, Claude runs CLARIFY (see `02-clarify.md`) and asks the questions relevant to the artifact.

Acceptable exceptions (see `02-clarify.md` for full list):
- Task is trivial and reversible (format text, convert JSON → YAML).
- User has already answered CLARIFY in the prompt.
- Continuation of a prior session where CLARIFY was run and scope hasn't changed.

Never exceptions for: new projects, anything to be published, anything non-Public-tier, multi-step refactors.

### B2 — Before creating work in Nestr, decide nest vs tension

Claude runs the decision tree from `03-nest-vs-tension.md`. If ambiguous, asks the user. Never creates work on another role's behalf.

### B3 — Before creating a nest, fetch the parent circle's strategy

Use `nestr_get_circle` on the role's parent circle. Read `fields['circle.strategy']`. State alignment in one sentence in the nest description. If no strategy exists, proceed on best judgment AND draft a tension to the circle lead requesting one.

### B4 — Use past-tense titles and structured descriptions

Every nest title in past tense. Every description has the CLARIFY-answers + acceptance-criteria block (see `04-nestr-conventions.md`). Labels 3–6, mixing system + BSVA conventions.

### B5 — Enter plan-mode for non-trivial work

Per `05-plan-mode-discipline.md`. The plan references the Nestr node. Exit plan-mode only on explicit user approval.

### B6 — Post progress as comments on the Nestr node

Milestones, blockers, scope changes, tension spawns. Don't double-post (task comments propagate to parent).

### B7 — Cluster cross-role tensions

Never spam. Use `global:nestr-cluster` to collapse related asks. Aim for ≤ 2 submissions per day per target role.

### B8 — When mid-execution scope changes, pause

Post a comment naming the scope change, propose an updated plan, get re-approval. Do not silently deviate.

### B9 — On completion, write the REPORT comment

Final comment summarizing: what was produced, what changed from plan, new tensions spawned, promotable skills. Then the human (not Claude) sets `project.status: Done` and `completed: true`.

### B10 — Refuse silently-wrong paths

If asked to do something that violates:
- Security floors (`global/CLAUDE.md`) → hard refusal, see `guides/for-claude/refusal-and-escalation.md`.
- Classification rules → confirm the tier with the user before proceeding.
- The cycle itself ("skip the nest, just write the code") → push back once, then defer if the user insists AND the work is not shipped / shared.

---

## The interaction rhythm

A session with Claude under this cycle sounds like:

```
USER:   I want to write a blog post about BRC-100.

CLAUDE: Let me ground this.
        - What exactly: length, target surface?
        - Why: is there a tension driving it?
        - Who for: SDK-users? BSV-new developers?
        - Classification: Internal until publish, then Public?
        - Success: what makes this Done?

USER:   [answers — 1500 words, BSVA blog, intermediate SDK devs,
         Internal→Public, success = published + peer-reviewed]

CLAUDE: Got it. This is a nest under your DevRel role.
        Here's the title I'd use: "Blog post on BRC-100
        interface evolution published". Acceptance criteria:
        [proposes 4 items]. Shall I create the nest and then
        draft a plan? A side-note: the Interface-v2 section
        will need Tech fact-check — I'll draft that as a
        linked tension when we get there.

USER:   Yes, create it.

[Claude calls nestr_create_nest with the structured description.
 Returns nest ID.]

CLAUDE: Nest #N-6611 created. Entering plan-mode.
        [Drafts a plan as in 05-plan-mode-discipline.md example.]

USER:   [discusses, trims, approves]

CLAUDE: Approved, executing.
        [Writes the post. Posts milestone comments. Opens the
         Tech tension as a separate node. Final completion
         comment on the nest.]

CLAUDE: Report: post ready at [path], peer review requested
        in comment, Tech tension T-7021 opened for Section 4.
        Ready for your close once tensions resolve.

USER:   [reviews, marks Done]
```

This pattern is the same across every department. Only the CLARIFY questions and the artifact shape differ.

---

## The global CLAUDE.md addition

The following block is added to `global/CLAUDE.md` under a new section **"Before you act"**:

> ## Before you act
>
> BSVA runs on a 10-step workflow cycle (see `<repo>/workflow/`). At minimum you will:
>
> 1. **CLARIFY** — Never act on a vague ask. Run the CLARIFY questions (`workflow/02-clarify.md`) for the artifact type. Land answers in the Nestr nest description.
> 2. **CAPTURE** — Decide nest vs tension (`workflow/03-nest-vs-tension.md`). Create the Nestr node with a past-tense title and acceptance criteria in the description. Fetch the parent circle's strategy for alignment.
> 3. **PLAN-MODE** — For anything that touches >2 files, takes >30min, ships externally, or is non-Public tier: enter plan-mode. Exit only on explicit user approval.
> 4. **EXECUTE with comments** — Post milestones, blockers, scope changes, and tension spawns as Nestr comments. Don't silently deviate from the approved plan; pause and re-approve if scope changes.
> 5. **REPORT on close** — Final completion comment summarizing outputs, plan deltas, new tensions, promotable skills.
>
> This cycle is **mandatory for shared / shipped work**. Throwaway personal work can skip steps, but never security or classification rules.

Department CLAUDE.md files may tighten further (e.g., Operations sub-sections mandate anonymize-first before any paste), but never loosen.

---

## What users should see

When a new BSVA person starts a Claude session for the first time after reading this repo, they should experience:

- Claude asks clear, non-annoying questions at the start.
- Claude proposes a Nestr nest before writing anything durable.
- Claude enters plan-mode for any substantive work, and waits for approval.
- Claude posts a tidy completion summary to Nestr when done.
- The user's Nestr workspace fills with well-titled, well-described work they can actually find six months from now.

If the experience doesn't look like that, escalate: the CLAUDE.md layering may be broken, or the workflow/ reference is missing, or a skill isn't installed. Ping DevRel.
