# 03 — Nest vs tension

The most important Nestr distinction. Get this right and Nestr stays clean; get it wrong and it becomes noise.

---

## The rule (memorize)

> **Nest**: work you do *inside* a role you fill.
> **Tension**: an ask *crossing* role boundaries.

If the output lives within your role's accountabilities and you don't need another role's time or authority, it's a **nest** (a project or task you create directly). If completing it requires another role to decide, produce, review, or approve — it's a **tension** to that role.

This matches Nestr's own convention (see `nestr_help tension-processing` and `doing-work`).

---

## Decision tree

```
Start: I have work I want to do.

Q1. Does this work fall inside a role I fill (am I the accountable user)?
    → YES, and it needs no one else's time/authority → NEST under my role.
    → YES, but it needs another role's input/approval before I can finish → NEST (mine) + TENSION (to other role) where the cross-role piece lives.
    → NO, someone else is accountable → TENSION to that role (pathway 3 or 4).

Q2. Is this a governance / structural change (new role, new accountability, new policy)?
    → TENSION on the circle, with governance-labeled parts (role, accountability, domain, policy).

Q3. Is there no role accountable at all?
    → Create the work on the circle with label `individual-action`, AND open a governance tension to capture the gap.

Q4. Is this a personal tension (not role-driven)?
    → Nest on the circle with `individual-action` label.
```

**Rule of thumb:** Does completing this require anyone else's calendar time or authority? → Tension. Otherwise → Nest.

---

## 15 worked cases

A concrete grid so you don't have to re-derive the rule each time.

### DevRel

| Situation | Nest or tension? | Notes |
|---|---|---|
| 1. Write a blog post on BRC-100, I hold DevRel role | **Nest** under DevRel | Title past-tense; acceptance criteria = 1500 words, cites, review. |
| 2. Need Tech to fact-check the crypto sections | **Tension** to sdk-maintainer | Scope: just the section. Link from the blog nest. |
| 3. Need Marketing to cross-post on social | **Tension** to Marketing | Cluster with other pending marketing asks if possible. |
| 4. Respond to a Discord dev-support question | **Nest** (quick) | Acceptance criteria = reply posted + any follow-up tension filed. |

### Technology

| Situation | Nest or tension? | Notes |
|---|---|---|
| 5. Refactor a service I maintain | **Nest** | Acceptance criteria = tests pass, benchmark ≤ 5% regression, CHANGELOG updated. |
| 6. Propose a new BRC | **Tension** on Standards circle | Governance parts: `motivation`, `specification`, `rationale`, `security-considerations`. |
| 7. Security review requested | **Tension** to Security role | Confidential by default. |
| 8. Incident in progress | **Tension** to Tech Lead + Security (Confidential). Individual remediation tasks become nests under each responder. |

### Education

| Situation | Nest or tension? | Notes |
|---|---|---|
| 9. Author a new lesson | **Nest** under Curriculum Designer | Past tense; acceptance criteria from the pedagogy minimums. |
| 10. Need DevRel to technical-review the lesson | **Tension** to DevRel | Scope = just the lesson; include link to the nest. |
| 11. Translate my own lesson to Spanish (I hold Translator role) | **Nest** under Translator role | Linked to the original lesson nest. |
| 12. Need a native reviewer's time | **Tension** to the reviewer's role | Even if it's "just a review". Calendar time = tension. |

### Operations

| Situation | Nest or tension? | Notes |
|---|---|---|
| 13. Build a public VC lead list for blockchain infra | **Nest** under Biz-Dev role | Confidential; sources URL-cited. |
| 14. Legal review of a template | **Tension** to Legal Lead | Restricted session; template stays generic. |
| 15. Exec sign-off on >$X sponsorship | **Tension** to Exec Lead | Never informal; always a tension. |

---

## Common mistakes (and their fixes)

### "I'll just spawn a tension per question"
Hostile. 20 tensions per hour is practically DoS. **Cluster** related asks into one tension with a bulleted list.

### "I'll create the work on the other role's behalf"
No. You can't create nests under someone else's role — even if you think you know what they'd want. Open a tension (pathway 3 or 4) and let them decide.

### "I'll skip Nestr, it's overhead"
For shared work, it's not overhead — it's the source of truth. The nest description is the only place the acceptance criteria durably lives. Without it, next month's "why did we do it this way?" becomes a research project.

### "I'll put everything in a tension because it feels more serious"
No. Tensions are for inter-role communication. If the work is inside your role, a nest keeps the Nestr graph clean.

### "I'll nest cross-role work under my role so I don't lose track"
No. That misrepresents accountability. Use a tension to the correct role, and if you need a personal tracker, rely on comments on the tension or on your own parallel nest.

---

## How Claude helps

When you describe a task, Claude runs this decision tree silently and proposes:

```
"This looks like a nest under your DevRel role. Shall I draft the
nest title and acceptance criteria, then create it? You'll need a
separate tension to Tech for the crypto review — want me to draft
both at once?"
```

You confirm; Claude creates; both are linked.

**This is the `global:tension-or-nest` skill** — one of the global skills installed by default. See `global/skills/tension-or-nest/SKILL.md`.

---

## Cluster, don't spam

From Nestr's own `doing-work` guidance:

> An agent creating 20 tensions per hour is technically correct but practically hostile.

BSVA norm: cluster cross-role tensions into **≤ 2 submissions per day per target role**, unless urgent. Prepare as drafts (`status: draft`), submit as a batch.

The `global:nestr-cluster` skill does this automatically — given N related asks, it produces a single tension with a clear checklist.
