# Education — typical artifacts

| Rank | Artifact | Cadence | Default tier | Template | Top skills |
|---|---|---|---|---|---|
| 1 | Lesson (single-concept, 500–2000 words) | Weekly | Internal → Public on publish | `templates/new-lesson/` | `lesson-outline-builder`, `academy-term-linker`, `fact-check-gate` |
| 2 | Assessment item / quiz / rubric | With every lesson + refresh cycles | Internal → Public (items) or Confidential (learner responses) | `templates/new-assessment/` | `quiz-generator` |
| 3 | Translation (EN → ES/ZH/PT) | Fork of every published EN asset | Internal → Public | — (works on existing lesson) | `bilingual-side-by-side`, `academy-term-linker` |
| 4 | Learner-support reply | Daily, low per-designer | Confidential (contains PII) | — | `learner-support-drafter`, `anonymizer` |
| 5 | Course module | Monthly | Internal → Public | `templates/new-course-module/` | all lesson-related + `lesson-outline-builder` |

Honorable mentions: instructor notes, slide decks (`bsva-pptx`), syllabus one-pagers (`bsva-onepager`), accessibility passes.

## Classification defaults

- **Internal** during drafting.
- **Public** on publish (classify-before-publish gate).
- **Confidential** for learner data (progress, responses, support tickets).
- **Restricted** for minors' data, disability / accommodation data, any jurisdictional complications.

## What Education never ships without review

- **Technical content touching protocol / cryptography** → tension to DevRel or Tech for fact-check.
- **Anything involving identifiable learners** → Legal + Education Lead, Confidential minimum.
- **Translations before native-speaker review** → tension to the reviewer's role.
- **Claims unsupported by the BSV Academy MCP or a primary spec** → `fact-check-gate` blocks publish.
