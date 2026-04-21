---
name: blog-post-from-transcript
description: Converts a talk recording transcript into a BSVA-voice blog post draft. Invoke when repurposing a DevRel talk, panel, or podcast appearance. Preserves the author's argument structure while applying BSVA voice rules and cite-ability requirements.
classification: Internal
owner: "@bsva/devrel"
version: 0.1.0
---

# blog-post-from-transcript

Transform talks into posts.

## Behavior
1. Takes transcript + target length.
2. Extracts argument structure; rebuilds in blog format (lead → mechanism → example → implication).
3. Applies BSVA voice via `external-comm-check`.
4. Flags claims needing citation; proposes cite candidates.
5. Preserves speaker's distinctive language where it's on-brand.

## Hard rules
- No fabricated quotes attributed to the speaker.
- No claims added that weren't in the transcript.
- Every technical claim cite-able.
