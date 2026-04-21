# Education / BSV Academy — CLAUDE.md

Extends the base `~/.claude/CLAUDE.md`. Security rules are floors.

---

## Who we are

BSV Academy is BSVA's education arm. We design, produce, translate, and support learning materials about the BSV Blockchain — from absolute-beginner courses to enterprise-architect deep dives. We publish at `bsvblockchain.org/bsv-academy` (among other surfaces), and maintain the knowledge base used by the BSV Academy MCP.

---

## Default classification

- **Published materials**: Public.
- **Drafts, outlines, review cycles**: Internal.
- **Learner data** (progress, submissions, scores): Confidential at minimum. PII on learners is often Restricted — check with Legal if it involves minors or sensitive jurisdictions.

---

## Who you are helping

A curriculum designer, course author, translator, or learner-support specialist. They often need Claude to:

- Explain a technical concept in terms an identified audience will understand.
- Turn a spec into a lesson outline.
- Write quiz / assessment items.
- Translate between languages (English ⇄ Spanish / Mandarin / Portuguese, typical).
- Draft learner-support replies.

---

## How to behave in Education work

1. **Pitch to the audience.** A lesson for "intro" and one for "advanced" sound different. Ask which.
2. **Accuracy beats fluency.** A beautifully-written wrong explanation is worse than a plain correct one. For technical content, Claude should prefer citing the BSV Academy MCP and referencing BRCs over improvising.
3. **No shortcuts in assessment items.** Quiz answers must match the lesson's definitions exactly. Ambiguous quiz items are bugs.
4. **Translations are not just grammar.** Translating BSV concepts requires choosing terminology that matches how practitioners in that language actually talk. Flag uncertain terms for human review.
5. **Learner-support replies are personal.** When drafting a reply to a learner, keep the human's voice; don't sanitize away empathy.

---

## Tools Education uses with Claude

- **BSV Academy MCP** — the canonical source of concepts, courses, and pages.
- **bsva-docx** — for participant handouts.
- **bsva-pptx** — for course slide decks.
- **bsva-onepager** — for syllabus summaries, program overviews.
- **Nestr MCP** — tension tracking for course production cycles.

---

## Education-specific rules

- **Learner PII never leaves approved BSVA systems.** Don't paste a learner's full submission (with their name, email, or identifying context) into Claude. Redact the identifier, keep the content.
- **Published materials are Public**, but **drafts are not**. Drafts reference the curriculum's internal ordering, which we don't publish.
- **Translations**: keep the English source alongside the translation in the same document until final review is complete.
- **Accessibility**: image descriptions, alt text, reading-level checks — Claude can help draft them; a human reviews.

---

## Escalation owner

- Education Lead — Nestr role: `Education Lead`.
- For learner-data / privacy questions: Education Lead + Legal.

---

## Workflow

Every Education session follows the BSVA cycle (`<repo>/workflow/`). Education-specific playbooks live in `departments/education/workflow/`, including `qa-and-review.md`, `publication-checklist.md`, `translation-workflow.md`, and `learner-support.md`.

Top 3 Education artifacts: lessons (weekly), assessment items (with every lesson), translations (fork of every EN asset). **Accuracy over fluency** — a confident wrong explanation is worse than a plain correct one. `fact-check-gate` refuses to sign off on unsupported claims.

## Templates

See `templates/`:

- `new-course-module/` — a full module with multiple lessons and assessments.
- `new-lesson/` — a single lesson with objectives, content, checks-for-understanding.
- `new-assessment/` — quiz / exam items with rubrics.

## Skills

See `skills/README.md`.
