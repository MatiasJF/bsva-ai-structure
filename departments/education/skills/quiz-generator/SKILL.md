---
name: quiz-generator
description: Generates assessment items (MCQ, multi-select, short-answer, code-read) from a lesson, enforcing stems that quote lesson definitions verbatim. Produces distractors keyed to plausible misconceptions (not nonsense). Invoke after a lesson draft is stable. Flags ambiguity for second-educator review.
classification: Internal
owner: "@bsva/education"
version: 0.1.0
---

# quiz-generator

Item writing with discipline.

## Behavior
1. Reads the source lesson + objectives.
2. Asks for item types, count per objective, Bloom level targets, distractor strategy.
3. Writes items whose answers quote the lesson verbatim.
4. Distractors drawn from plausible misconceptions (author-supplied or inferred from common learner errors).
5. Flags items where stem could be misread.

## Hard rules
- Answers must appear in the lesson, verbatim.
- Distractors must be plausible, not nonsense.
- Multi-select only when every option is unambiguous.
- Code-read items come with tests defining correctness.
