# Education — publication checklist

Extends `workflow/08-publish-gate.md` with Education specifics.

## Before clicking publish

- [ ] All three QA layers passed (pedagogy, technical, accessibility/voice).
- [ ] For translations: native-speaker review closed.
- [ ] `fact-check-gate` ran on final text — zero unsupported claims.
- [ ] `reading-level-checker` reports at or below the target grade level.
- [ ] All diagrams have alt text.
- [ ] All underlined / first-appearance terms link to BSV Academy concepts.
- [ ] CfU items match lesson definitions verbatim.
- [ ] Classification label ready to flip: `classification/internal` → `classification/public`.
- [ ] Education Lead has posted explicit "go" on the nest.

## After publish

- [ ] Live URL posted as a comment on the nest.
- [ ] Classification label flipped.
- [ ] `project.status: Done`; `completed: true`.
- [ ] If this lesson has translations, open a nest per translation target (their own cycle kicks off).
- [ ] Promotable learnings filed as skill-promotion candidates (see `09-retro-and-skills.md`).

## Rollback

If an error is discovered post-publish:

1. Open an incident tension in Education circle, Confidential.
2. Decide: correction note / immediate revision / temporary unpublish.
3. Act. Document every step as comments on the tension.
4. Update the lesson; re-run `fact-check-gate`.
5. Re-publish after Lead approval.
6. Blameless review within a week.

## The principle

Education publishes stay live for years. One wrong definition can mislead thousands of learners. **Spend the time on the gate.**
