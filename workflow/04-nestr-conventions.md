# 04 — Nestr conventions

BSVA's conventions for how work looks in Nestr. These extend Nestr's own defaults (see `nestr_help doing-work`), they don't replace them.

---

## Project titles — past tense, always

Nestr's convention: describe the project as if done. BSVA adopts this verbatim.

| ❌ Not this | ✅ This |
|---|---|
| "Write a blog on BRC-100" | "Blog post on BRC-100 interface evolution published" |
| "Research VCs in blockchain infra" | "Tier-1 VCs in blockchain infra lead list shipped" |
| "Build SPV service" | "SPV service v1.0 deployed to staging" |
| "Translate UTXO lesson" | "UTXO lesson Spanish translation published" |
| "Incident response" | "Signing service outage 2026-03-14 resolved" |

**The test:** can you describe this in past tense? If not, the outcome isn't clear enough yet. Back to CLARIFY.

---

## Acceptance criteria — in the description, HTML-formatted

Nestr descriptions accept HTML. BSVA uses a consistent structure:

```html
<h3>What</h3>
<p>[One paragraph restating the artifact, from CLARIFY step 1.]</p>

<h3>Why</h3>
<p>[The purpose / tension, from CLARIFY step 2.]</p>

<h3>Who for</h3>
<p>[Audience, from CLARIFY step 3.]</p>

<h3>Classification</h3>
<p>Internal (Public on publish) / Confidential / Restricted.</p>

<h3>Acceptance criteria</h3>
<ul>
  <li>Specific, verifiable item 1.</li>
  <li>Specific, verifiable item 2.</li>
  <li>Specific, verifiable item 3.</li>
</ul>

<h3>Links</h3>
<ul>
  <li>Tension that spawned this: [link if any]</li>
  <li>Related work: [links]</li>
</ul>
```

**The test for an acceptance-criteria item:** "Could someone verify this is done without asking me?" If no, rewrite.

| ❌ Not this | ✅ This |
|---|---|
| "Workshop is good" | "Lesson branches 01–05 run on `npm i && npm start`" |
| "Lesson is accurate" | "Every protocol claim cites a BRC number or BSV Academy concept" |
| "Lead list is useful" | "300 rows; each row has firm name, URL, stage, portfolio notes, date last checked" |

---

## Labels

Nestr's label system is shared across BSVA. Apply consistently.

### System labels (Nestr-provided)
- `project` — a multi-task outcome.
- `role` / `circle` / `accountability` / `domain` / `policy` — governance-typed nests.
- `skill` — persisted agent know-how (see `09-retro-and-skills.md`).
- `individual-action` — work outside a role's accountability.

### BSVA conventions
- `classification/public` | `classification/internal` | `classification/confidential` | `classification/restricted` — the tier.
- `dept/devrel` | `dept/tech` | `dept/education` | `dept/operations` — department owner.
- `artifact/blog` | `artifact/workshop` | `artifact/service` | `artifact/lesson` | `artifact/lead-list` | `artifact/rfc` | `artifact/research` | `artifact/brief` — artifact type.
- `event/<slug>` — if tied to an event: `event/devcon-lagos-2026`.
- `audience/<level>` — `audience/beginner-dev` / `audience/intermediate-sdk` / etc. for content work.

Labels are cheap. Use 3–6 per nest.

---

## Status lifecycle

Nestr nest status values BSVA uses:

| Status | What it means |
|---|---|
| `Future` | Planned but not started. Don't set acceptance criteria yet. |
| `Current` | Actively worked. Acceptance criteria locked. |
| `Waiting` | Blocked on a tension or external dependency. Comment on what's blocking and the tension ID. |
| `Done` | Acceptance criteria met. `completed: true`. Final comment summarizing outcome. |

Use `nestr_update_nest` to move between statuses.

---

## Comments — progress, not prose

During execution, post comments as work lands. The pattern:

**On a task:**
> "Completed lesson 3; added note on interface evolution per discussion. Ready for Tech review."

**On a project (milestones):**
> "Milestone 1 (outline) complete. Lesson branches 01–03 drafted. Running into a question on BRC-100 backward-compat — opening tension T-##### to sdk-maintainer. Switching to lesson 4 while waiting."

Comments on tasks automatically propagate to parents — don't double-post.

### When to comment
- At a milestone, even a small one.
- When blocked.
- When scope changes.
- When another tension is spawned.
- On close, with the summary.

### When not to comment
- Every 5 minutes to prove you're working. (Annoys reviewers.)
- To apologize for slowness. (Explain blockers if they exist; don't editorialize.)
- Personal reflections. (Not the purpose of the nest.)

---

## Clustering cross-role requests

From Nestr's `doing-work`:

> An agent creating 20 tensions per hour is technically correct but practically hostile.

**BSVA norm:** ≤ 2 tension submissions per day per target role, unless urgent. Prepare as drafts; submit in a batch. Use the `global:nestr-cluster` skill.

Examples of clustering:

- 8 SDK doc fixes across different pages → **one** tension titled "SDK docs cleanup batch April 2026" with a bulleted task list.
- 3 different marketing copy asks for the same campaign → **one** tension with three numbered items.
- 5 Legal-review asks for template updates → **one** tension, even if they're on different templates.

**Don't cluster across unrelated contexts.** Legal review of a contract template has nothing to do with Legal review of a new MNDA; those belong in separate tensions.

---

## Fetching strategy before creating work

From Nestr's `doing-work`:

> **Before starting work:** Fetch the parent circle and review its strategy. Prioritize aligned work; defer what doesn't align.

The `global:clarify` skill does this automatically: when creating a nest, it fetches the role's parent circle's `fields['circle.strategy']` and proposes a one-line alignment statement in the nest description.

If no strategy exists: proceed on best judgment AND create a tension with the circle lead requesting a strategy. Don't silently lack a North Star.

---

## The "users" field is required

From `doing-work`:

> Placing a project under a role does NOT assign it. You MUST include `users` with the role filler's user ID, otherwise the project appears unassigned and won't show up in the user's work views.

Every nest created under a role:
- Single-filler role → `users: [the filler's user ID]`
- Multi-filler role + you energize it → `users: [your user ID]`
- Unfilled role → `users: []` or omit

Accountabilities / domains / policies never have `users`.

---

## Linking nests and tensions

Use `nestr_add_graph_link` to connect related work:

- Tension spawned a nest → link them (`relation: "parent"` or custom like `"spawned-from"`).
- Nest has a dependency on another tension → link.
- Nest belongs to an event → link to the event's nest.

Linking keeps the graph navigable. Don't over-link — only where it helps future readers orient.

---

## Summary table

| Convention | Rule |
|---|---|
| Project title | Past tense, describing the outcome |
| Description | CLARIFY answers + acceptance criteria (HTML) |
| Labels | 3–6, mixing system + BSVA conventions |
| Status | Future / Current / Waiting / Done |
| Comments | Milestones, blockers, scope changes, tension spawns, close |
| Clustering | ≤ 2 tensions/day/target role, use `global:nestr-cluster` |
| Strategy check | Fetch parent circle's strategy before creating |
| Users field | Required on every role-scoped nest |
| Linking | Use graph links for cross-cutting relationships |
