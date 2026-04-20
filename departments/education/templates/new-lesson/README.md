# new-lesson

Scaffold for a single BSV Academy lesson.

## Required frontmatter (in `lesson.md`)

```yaml
---
title: "Lesson title"
audience: "intro | intermediate | advanced"
prerequisites:
  - "understand SPV at a high level"
  - "know what a transaction input is"
objectives:
  - "Explain X in plain language"
  - "Implement Y in code"
duration_minutes: 30
classification: Internal   # Public once published
---
```

## Body structure

1. **Hook** — a concrete scenario or question (2–4 sentences).
2. **Concept** — the explanation, with one worked example.
3. **Practice** — a short exercise or walkthrough.
4. **Check for understanding** — 2–3 quick questions.
5. **Going deeper** — 1–2 links for curious learners.

## File layout

```
my-lesson/
├── README.md         about this lesson
├── CLAUDE.md         symlink to departments/education/CLAUDE.md
├── lesson.md         the lesson itself
├── assets/           images, diagrams
├── exercises/        starter + solution (if code-based)
└── assessment.md     CfU items with answers and rubric
```
