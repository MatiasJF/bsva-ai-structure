# DevRel — typical artifacts

What DevRel actually ships, ranked by frequency. Use this to match your work to a template + skill + classification.

| Rank | Artifact | Cadence | Default tier | Template | Top skills |
|---|---|---|---|---|---|
| 1 | Dev-support reply (Discord, GitHub, forum) | Daily | Internal → Public (if posted publicly) | — | `draft-dev-support-reply`, `triage-sdk-issue`, `verify-sdk-surface` |
| 2 | SDK example / snippet | Weekly | Internal → Public on publish | `templates/new-sdk-example/` | `sdk-example-scaffold`, `verify-sdk-surface`, `classify-before-publish` |
| 3 | Blog post / tutorial | Bi-weekly | Internal → Public on publish | `templates/new-blog-post/` | `blog-post-from-transcript`, `verify-sdk-surface`, `external-comm-check` |
| 4 | Workshop repo (lessons + slides + notes) | Monthly | Internal → Public after event | `templates/new-workshop/` | `workshop-lesson-splitter`, `verify-sdk-surface` |
| 5 | Conference / hackathon enablement | Quarterly (bursty) | Internal → Public on event announce | — (event-specific) | `workshop-lesson-splitter`, `external-comm-check` |

Honorable mentions:
- SDK documentation patches — usually live in Tech's repo; route as **tensions** to sdk-maintainer.
- Sample repos for enterprise integrations — higher-stakes; may be Confidential until publish.

## Classification defaults

- **Internal** during drafting.
- **Public** on publish (with the classify-before-publish gate and owner approval).
- **Confidential** if the artifact references an unannounced SDK feature, partner, or deal.

## What DevRel never ships without review

- Any artifact with `@bsv/sdk` code → `verify-sdk-surface` required before commit.
- Anything that names a partner pre-announcement → tension to Biz-Dev for clearance, hold publish.
- Anything that makes protocol claims → tension to Tech for fact-check.
