# 09 — Retro and skill promotion

After CLOSE, there's one more question: **did this work produce something repeatable?** If yes, it becomes a skill. This is how BSVA's Claude gets smarter over time.

---

## The promote-to-skill reflex

During REPORT (step 9) or CLOSE (step 10), ask yourself:

- Did I give Claude the same instruction more than twice in this project?
- Did I or a peer re-explain the same conventions / classifications / formats?
- Was a CLARIFY question set useful enough to bake in?
- Was a review-checklist run enough times that a skill could run it?

If yes to any → **skill candidate**.

---

## What a skill is

A skill is a reusable Claude capability: a structured prompt + optional code + opinionated defaults. In BSVA, skills live:

- `global/skills/` — for every BSVA person.
- `departments/<dept>/skills/` — for one department.
- `departments/operations/<sub>/skills/` — for one sub-section.
- `.claude/skills/` (in a project) — just for this project.

Skills have a `SKILL.md` at minimum. The `description` field is how Claude decides whether to invoke — be specific.

---

## The promotion path

```
Scratch prompt → personal → project → department → global
(loosest)                                       (strictest review)
```

Start at the narrowest useful scope. Promote only when spread is real.

### Step 1 — Capture personally
You've found a repeatable prompt. Save it to `~/.claude/personal-skills/<name>/SKILL.md`. Use it. Refine it.

### Step 2 — Promote to a project
If the skill is useful in a specific project repo, commit it to `.claude/skills/<name>/` in that repo. Now your collaborators see it.

### Step 3 — Promote to the department
If 3+ colleagues use it, PR to `departments/<your-dept>/skills/<name>/`. Go through `guides/visuals/03-skill-lifecycle.md` — department lead review.

### Step 4 — Promote to global
If multiple departments use it, PR to `global/skills/<name>/`. Requires DevRel + Security review. Once global, it ships to every BSVA machine via the installer.

### Inverse path (demotion)
If a skill in `global/` turns out to only be used by one department, demote it (move to dept) with a pointer stub. Keep the structure honest.

---

## What a good skill looks like

### The SKILL.md
```yaml
---
name: verify-sdk-surface
description: Given a snippet of @bsv/sdk TypeScript code, verify every imported symbol and method call actually exists in the installed package version. Invoke when reviewing Claude-produced SDK code, before committing. Critical for DevRel and Tech work.
classification: Internal
owner: "@bsva/devrel"
version: 1.0.0
---

# verify-sdk-surface

## When to invoke
- After Claude writes or refactors code using `@bsv/sdk`.
- Before committing code a reviewer will see.
- During dev-support responses that include SDK snippets.

## What it does
1. Parses the given TS/JS code for imports from `@bsv/sdk`.
2. Resolves each imported symbol against `node_modules/@bsv/sdk/`.
3. Flags symbols that don't exist, are deprecated, or are internal-only.
4. For each resolved symbol, checks the method signatures used match the actual signature.

## Outputs
- ✓ / ✗ per symbol.
- Proposed fix for each failure.
- Notes on deprecated APIs with migration hints.

## Examples
[2–3 input / output pairs.]
```

### Characteristics of good skills
- **Narrow.** Does one thing well. (Bad: "help me write code.") (Good: "verify SDK surface area.")
- **Descriptive description.** Claude matches on description — vague descriptions cause mis-invocation.
- **Has examples.** 2–3 input/output pairs. Reviewers need them.
- **Cites its sources.** If it reads a file, says which. If it calls an MCP, says which.
- **Classification-aware.** Names the tier expectations.
- **Version-pinned.** If it depends on external state (SDK version, spec version), pin.

---

## The retro format

After every shared-work project, a brief retro lives as a **comment** on the Nestr nest. Template:

```
## Retro

Went well:
- [1–3 bullets]

Didn't go well:
- [1–3 bullets]

Repeat:
- [patterns to keep]

Change:
- [patterns to try differently]

Skill promotion candidates:
- [name + proposed scope + rationale]

New tensions spawned for follow-up:
- [#T-xxxx — short summary]
```

Retros are short — 5 minutes to write, 2 to read. If yours grows longer, split it across multiple nests.

---

## Examples of skill promotions from real work

*(These are illustrative patterns. Actual skills emerge from BSVA's workflow.)*

### DevRel
- First project: personally re-typed the same "verify every SDK method against `node_modules`" instruction 8 times. → Personal skill.
- Three colleagues copied the personal skill. → Promoted to `departments/developer-relations/skills/verify-sdk-surface/`.
- Tech started using it for their own SDK-adjacent work. → Promoted to `global/skills/verify-sdk-surface/`.

### Education
- A curriculum designer found herself writing the same audience-level / prerequisite / objectives intake every lesson. → Personal skill.
- Adopted by the whole Education team. → Promoted to `departments/education/skills/lesson-outline-builder/`.

### Operations — Biz-Dev
- A lead-list researcher wrote a prompt that enforces "public sources only, URL citation per row". → Personal skill.
- Became the canonical way Biz-Dev builds lists. → Promoted to `departments/operations/biz-dev/skills/lead-list-builder/`.

---

## Anti-patterns

- **"I'll PR all 12 of my prompts at once."** Don't. Most are specific to one project. Start narrow; promote only what actually spreads.
- **"Everyone's team has slightly different lead-list skills."** Department drift. Consolidate into one shared version; PR disagreements.
- **"Let's make every workflow a skill."** No. Documents are documents, skills are skills. If the instruction fits as a doc that a human reads, leave it a doc.
- **"I made a skill but it's undocumented."** Useless to reviewers; useless to anyone six months from now.

---

## The meta-principle

**Every Claude session at BSVA is a chance to make the next one sharper.** Most sessions won't produce new skills — but the ones that do compound over time. After a year of this discipline, BSVA's Claude is measurably more capable than a fresh install, because the skills people wrote along the way are doing the work.

Reinvest the time you save.
