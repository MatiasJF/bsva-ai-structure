# 06 — Scopes: global / department / project / personal

Every skill, rule, template, and piece of context you author has a scope. Getting scope right is how the structure stays navigable.

---

## The four scopes

```
┌──────────────────────────────────────────────────────────────┐
│  GLOBAL       ~/.claude/  &  repo global/                    │
│                                                              │
│  Everything every BSVA person needs.                         │
│  Examples: base CLAUDE.md, brand voice, classification,      │
│  Nestr MCP, the 5 global skills, base settings.              │
└──────────────────────────────────────────────────────────────┘
┌──────────────────────────────────────────────────────────────┐
│  DEPARTMENT   repo departments/<dept>/                       │
│                                                              │
│  Everything a department's members share.                    │
│  Examples: dept CLAUDE.md, dept skills, dept templates,      │
│  dept workflow/ folder, dept escalation owners.              │
│                                                              │
│  Operations additionally has SUB-SECTIONS                    │
│  (biz-dev, marketing, legal, exec).                          │
└──────────────────────────────────────────────────────────────┘
┌──────────────────────────────────────────────────────────────┐
│  PROJECT      <project>/CLAUDE.md  &  <project>/.claude/     │
│                                                              │
│  Everything specific to a single piece of work.              │
│  Examples: project CLAUDE.md additions (SDK version,         │
│  audience), project-scoped skills and MCPs, project-specific │
│  allow-lists.                                                │
└──────────────────────────────────────────────────────────────┘
┌──────────────────────────────────────────────────────────────┐
│  PERSONAL     ~/.claude/  (user-only files, not synced)      │
│                                                              │
│  Everything that's yours alone.                              │
│  Examples: personal style preferences, editor shortcuts,     │
│  personal memory files, personal settings overrides.         │
│  NEVER contains shared secrets, never overrides security.    │
└──────────────────────────────────────────────────────────────┘
```

---

## How Claude layers them

Claude reads CLAUDE.md files in order of specificity:

```
1. ~/.claude/CLAUDE.md              (global, installed by bsva-ai-structure)
2. <repo>/departments/<dept>/CLAUDE.md   (when in a dept-linked project)
3. <project>/CLAUDE.md              (project root, if present)
4. <project>/.claude/ (skills, MCPs, settings scoped to project)
```

Rules:
- **Security floors only get tighter** as you go deeper. A project cannot relax a global security rule, but it can tighten one.
- **Voice and style rules cascade.** Department voice refines global; project-specific audience overrides as needed.
- **Skills and MCPs merge.** Project adds to department adds to global.

---

## The scoping question: "where does this belong?"

Before adding a skill, MCP, rule, or template, ask:

1. **Does every BSVA person need this?** → Global.
2. **Does every person in one department need this?** → Department.
3. **Does every person in one sub-section (Operations only) need this?** → Sub-section (e.g., `departments/operations/biz-dev/`).
4. **Is this only useful for this one project?** → Project.
5. **Is this only useful to me?** → Personal.

Start narrow. Promote when adoption spreads. Conversely: if you find yourself copying the same skill into 3 projects, promote it to the department.

---

## Examples by type

### Skills

| Example | Where | Why |
|---|---|---|
| `clarify` (the CLARIFY question bank) | Global | Everyone uses it every session |
| `tension-or-nest` (decides Nestr node type) | Global | Universal |
| `verify-sdk-surface` (kills hallucinated SDK APIs) | Department — DevRel | Only DevRel writes SDK code at this scale |
| `lead-list-builder` | Department — Operations → Biz-Dev | Biz-Dev only |
| `my-workshop-lesson-splitter` | Project | Only this workshop structures lessons this way |
| `my-personal-prose-style` | Personal | Only this person writes in British English |

### Rules

| Example | Where | Why |
|---|---|---|
| "Use BSVA voice" | Global | Everyone's output is BSVA's |
| "SDK code must run" | Department — DevRel | Only DevRel ships SDK code |
| "This service is consensus-critical; no dep upgrades" | Project | Specific to the service |
| "I write in British English" | Personal | Personal preference |

### Templates

| Example | Where | Why |
|---|---|---|
| `CLAUDE.md` template | Global | Everyone starts from it |
| `new-workshop/` | Department — DevRel | Only DevRel uses it |
| `lessons/03-template/` (within a workshop) | Project | Only within this workshop |

### MCPs

| Example | Where | Why |
|---|---|---|
| Nestr | Global | Everyone uses Nestr |
| BSV Academy | Global | Everyone may reference it |
| GitHub | Department — DevRel + Tech | Only these depts write code |
| HubSpot CRM | Department — Operations (Biz-Dev) | Only Biz-Dev has CRM data |
| A workshop-specific faucet API | Project | Lifecycle = this workshop |

---

## The "promote when it spreads" rule

If you make a skill for yourself and a colleague asks to use it:

1. First, share it informally (copy).
2. If three colleagues use it, **promote to department** via PR.
3. If three departments use it, **promote to global** via PR with DevRel + Security review.

Promotion has costs (review, documentation, support), so don't promote prematurely. But once something is shared across colleagues, it belongs in a shared place — otherwise version drift starts.

---

## The "demote when it shrinks" rule

Conversely, if a skill in `global/` is only being used by one department:

1. Propose demotion via PR (move to department).
2. Keep a pointer stub in global so existing references don't break.
3. Evolve independently from there.

---

## Special: Operations' five-level scope

Operations has an extra layer: sub-sections (biz-dev, marketing, legal, exec). This matters because:

- A skill useful to all of Operations → `departments/operations/skills/`.
- A skill useful only to Biz-Dev → `departments/operations/biz-dev/skills/`.
- A skill useful only in a specific Biz-Dev project → project-scoped.

Think of it as: global → dept → sub-section → project → personal.

---

## Where personal files live

Personal files do **not** live in this repo. They live in `~/.claude/` on your machine and are never committed. Examples:

- `~/.claude/CLAUDE.md` — your personal layer (the installer writes the base BSVA version; personalize on top).
- `~/.claude/settings.json` — your personal settings.
- `~/.claude/projects/<slug>/memory/` — persisted memory for specific projects.
- `~/.claude/personal-skills/` — if you want truly personal skills (not shared). (Your department scope is for skills you'd share with peers.)

**Personal files are personal.** Don't commit them. Don't sync them via Dropbox to a shared folder. The installer keeps them out of sync for good reason.

---

## The anti-pattern: misplaced scope

| Symptom | Root cause | Fix |
|---|---|---|
| "I copy-paste this prompt into every session" | Global or department skill that doesn't exist yet | PR it |
| "Every DevRel person has their own version of this template" | Department-scope drift | Merge into one, PR to `departments/developer-relations/templates/` |
| "This skill ships with credentials hardcoded" | Scope mismatch: should be project-scoped with `.env` | Refactor; never ship secrets in shared skills |
| "This rule is in my personal CLAUDE.md but I expect colleagues to follow it" | Personal scope being used as a communication channel | PR the rule to dept or global |

If you're unsure, **default narrower**. Promoting is cheaper than demoting.
