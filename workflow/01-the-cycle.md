# 01 — The cycle

The 10 steps, in detail, with a worked DevRel example.

---

## The cycle at a glance

```
1.  DESIRE       I want / need X
2.  CLARIFY      Claude asks what, why, who for, success — before acting
3.  CAPTURE      open a Nestr node: NEST (own work) or TENSION (cross-role)
4.  PLAN-MODE    Claude drafts a plan referencing the nest / tension
5.  DISCUSS      Q&A, alternatives, scope trimming
6.  APPROVE      user confirms the plan
7.  SCAFFOLD     template → project → CLAUDE.md layers
8.  EXECUTE      Claude posts progress as comments; marks tasks done
9.  REPORT       completion note written back to the Nestr node
10. CLOSE        human reviews; project status Done; acceptance criteria met
```

---

## Each step, explained

### 1. DESIRE — "I want / need X"
Someone feels a gap: a frustration, an opportunity, a half-formed idea. **This is the raw input.** It is often vague. That is fine — it's step 1, not step 7.

Examples:
- "I want to write a workshop on BRC-100."
- "We need to research Tier-1 VCs active in infrastructure."
- "Can Claude help me draft a translation of the UTXO lesson?"

### 2. CLARIFY — Claude asks, doesn't act

**This is the hard rule.** Claude never moves from step 1 to step 7. Before touching files or drafting content, Claude asks the CLARIFY questions. The questions are artifact-specific — see `02-clarify.md` for the bank.

Minimum questions every task answers:

1. **What** — concretely, what do you want to exist at the end?
2. **Why** — what purpose or tension does this serve? (If unknown, flag it.)
3. **Who for** — intended audience, concretely.
4. **Success looks like** — how will we know this is done?
5. **Classification tier** — Public / Internal / Confidential / Restricted?

These five land in the Nestr nest description. They stay with the work forever.

### 3. CAPTURE — Nestr nest or tension

Now the work has a name. Decide the shape:

- **Own work under your role** → `nestr_create_nest` as a project, title in **past tense**, acceptance criteria in description, `users: [you]`, labels set. See `04-nestr-conventions.md`.
- **Need another role's time or authority** → `nestr_create_tension`. See `03-nest-vs-tension.md`.

The Nestr node is the work's canonical home from this point on. All decisions, progress, and outcomes post here.

### 4. PLAN-MODE — Claude drafts a plan

With a clarified nest or tension in hand, Claude enters plan-mode (`/plan` or `shift+tab`). The plan references the Nestr node and proposes:
- The files that will be created / changed.
- The order of work.
- Dependencies (skills, MCPs, external reviews).
- A rough time estimate.
- The acceptance criteria the plan will satisfy.

### 5. DISCUSS — Q&A, alternatives, scope

The user reads the plan and pushes back. Typical discussion:
- "Actually this audience is more advanced — add prerequisites." (scope adjustment)
- "Let's skip the PR and keep it a local draft for now." (scope reduction)
- "What about using `simple-mcp` for the scaffold instead?" (alternative)
- "We'll need Tech to review the crypto sections." (dependency identified → becomes a tension later)

The plan is revised as many rounds as needed. Cost of a plan-mode round: seconds. Cost of scaffolding the wrong thing: hours.

### 6. APPROVE — user confirms

Explicit approval, not implied. A clear "go" or "proceed". Until then, Claude stays in plan-mode.

### 7. SCAFFOLD — template → project → layers

Claude executes the first concrete step: scaffold from a template, link the department `CLAUDE.md`, init git, first commit. See `guides/visuals/06-project-scaffolding.md` and your department's `workflow/scaffold-matrix.md`.

### 8. EXECUTE — work happens, comments post

As Claude makes progress:
- Substantial milestones → `nestr_add_comment` on the nest or on the relevant task.
- Tasks complete → `nestr_update_nest` with `completed: true`.
- Unexpected findings (a bug, a gap, a new scope) → **create a linked tension**; don't silently cross the boundary.

The nest description evolves. Acceptance criteria stays stable — if it needs to change, comment on why.

### 9. REPORT — completion note

When the last task is done, Claude writes a completion comment:

- What was produced (links, PRs, URLs).
- What changed from the original plan (and why).
- Any new tensions spawned for follow-up.
- Any repeatable work worth promoting to a skill (see `09-retro-and-skills.md`).

### 10. CLOSE — human reviews

The person accountable for the role reviews against acceptance criteria. If met, status goes to `Done` and `completed: true`. If not, reopen the conversation in comments.

**Closing is not optional.** An open nest is an open loop; open loops accumulate. Close them.

---

## A worked example — DevRel writing a workshop

**Step 1 — DESIRE.**
"I want to run a BRC-100 workshop at DevCon Lagos."

**Step 2 — CLARIFY.**
Claude: "Let me ground this. What's the date? Duration? Audience skill level? Co-delivered or solo? Do we have a slides template already? Who approves the prize/sponsor budget if any? Tier of this content — Internal until event, Public after?"

User answers: "2026-06-15, 90 minutes, intermediate-SDK-dev, solo, bsva-pptx, DevRel Lead approves, Internal → Public."

**Step 3 — CAPTURE.**
`nestr_create_nest` under DevRel role:
- Title: `Workshop "Build a BRC-100 wallet in 90 min" delivered at DevCon Lagos`
- Labels: `workshop`, `event/devcon-lagos`, `skill/intermediate`, `classification/internal→public-on-publish`
- Acceptance criteria (in description HTML):
  - Lesson branches 01–N build sequentially, all pass CI
  - Slides in `bsva-pptx` template, ≤ 30 slides
  - Facilitator notes document exists
  - Dry-run completed with one non-DevRel reviewer
  - Classification flipped to Public after event recording lands

**Step 4 — PLAN-MODE.**
Claude drafts:
1. Scaffold from `departments/developer-relations/templates/new-workshop/`.
2. Outline 5 lessons (intro → wallet basics → BRC-100 interfaces → integrations → wrap-up).
3. Write starter + solution per lesson. Use `simple-mcp` for scaffolding each lesson.
4. Draft slides in Markdown; render with `bsva-pptx`.
5. Dry-run review — open **tension** to DevRel Peer role.
6. Technical review — open **tension** to Tech role.

**Step 5–6 — DISCUSS + APPROVE.**
User: "Lesson 3 is where BRC-100 is introduced — make sure we flag the interface evolution concerns. Also, tension to Tech specifically to sdk-maintainer role, not whole Tech circle. Approved."

**Step 7 — SCAFFOLD.**
Claude runs the scaffold template, links CLAUDE.md, commits.

**Step 8 — EXECUTE.**
Over 3 sessions, Claude drafts lessons. After lesson 3, comments: "Lesson 3 done; flagged interface evolution per discussion; needs Tech review." Opens a tension to sdk-maintainer with the lesson snippet. Continues with 4 and 5 while waiting.

**Step 9 — REPORT.**
Comment on the nest: "Workshop repo ready: github.com/bsva/workshop-lagos-brc100. Slides PR #12. Tech review tension #T-4421 closed with two clarifications, integrated. Dry-run completed with @peer-name, 2 notes — incorporated. Ready for delivery."

**Step 10 — CLOSE.**
DevRel Lead reviews criteria: ✓ ✓ ✓ ✓. Sets `project.status: Done`, `completed: true`. After event, a separate task flips classification to Public.

---

## The cycle is self-similar

Big projects (a workshop) follow the cycle; individual tasks inside them also follow the cycle (writing lesson 3). The discipline scales down and up. The question is always: **have we clarified, captured, planned, and approved — before we're scaffolding?**
