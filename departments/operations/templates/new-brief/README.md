# new-brief

A short briefing document template. Use for: executive brief-ins, pre-meeting memos, partner briefings, internal position papers.

## Layout

```
my-brief/
├── README.md       one-line summary + audience
├── CLAUDE.md       link to the nearest-fit operations sub-CLAUDE.md
└── brief.md        the document
```

## brief.md structure

1. **TL;DR** — 2–3 sentences.
2. **Context** — what's going on.
3. **Key facts** — what the reader needs to know, bulleted.
4. **Decisions needed** — if any.
5. **Next steps / asks** — what happens after reading.

Target: **≤ 500 words** total. If longer, split.

## Classification

Briefs default to **Internal** or **Confidential** depending on audience. Set classification explicitly in frontmatter of `brief.md`:

```yaml
---
classification: Confidential
audience: BSVA exec circle
---
```
