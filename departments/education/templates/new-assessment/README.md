# new-assessment

Scaffold for an assessment item or item-set (quiz, exam, rubric).

## Required for each item

- **Stem** — the question or task.
- **Answer** — what counts as correct.
- **Rubric** (for open-response / project items) — specific criteria, not vague descriptors.
- **Lesson / objective mapping** — which learning objective this item assesses.
- **Difficulty** — beginner / intermediate / advanced.
- **Notes for instructors** — common wrong answers and why.

## Design principles

- **Assess the objective, not the wording.** A learner who's mastered the objective should pass even if they phrase it differently than the lesson.
- **No trick questions.** BSV Academy assesses understanding, not reading comprehension.
- **Avoid "choose all that apply" unless every option is unambiguous.**
- **For code items, tests go alongside the item** — they define correctness.

## Tiers

Assessments about learner progress (their attempts, their scores) are **Confidential**. The items themselves are **Internal** (during development) and may become **Public** only in specific contexts (example items published for marketing; full item banks are never public).
