# Marketing — campaign cycle

The flagship Marketing artifact. Covers: blog launches, product announcements, event campaigns.

---

## The cycle

### 1. CLARIFY
- Campaign name, theme, duration.
- Channels (blog, X, LinkedIn, email, events).
- Audience (developers, institutions, policymakers, general).
- Anchor asset (blog post, white paper, one-pager).
- Dependencies: DevRel fact-check, Biz-Dev name clearance, Ops event logistics, Exec quote?
- Tier: Internal → Public (default). Embargo if coordinated with partner.

### 2. CAPTURE
**Nest** under Marketing role. Internal.

Title: `[Campaign name] campaign launched`

Acceptance criteria:
- Anchor asset published per `publication-checklist` gate.
- Cross-channel copy shipped, each channel's variant reviewed.
- Partner clearances (if applicable) documented in comments.
- Post-launch retro comment within 3 business days.

Linked tensions (prepared in draft, submitted batched):
- DevRel (fact-check).
- Biz-Dev (partner clearance if applicable).
- Tech (if protocol claims are made).
- Legal (if claims or disclaimers involved).

### 3. PLAN-MODE
Draft: anchor, per-channel copy adaptations, timeline, review gates, go-live criteria, rollback plan.

### 4. SCAFFOLD
Project folder for campaign assets. Link Marketing CLAUDE.md.

### 5. EXECUTE
- Write anchor. Run `external-comm-check`.
- Write per-channel variants. Run `external-comm-check` on each.
- Submit clearance tensions. Cluster.
- Integrate feedback.
- Pre-launch: run `classify-before-publish` 1 week out AND 1 day out.

### 6. REPORT
Comment on nest: each asset's live URL, classification flips recorded, key metrics (if available).

### 7. CLOSE
Marketing Lead reviews AC. Post-launch retro within 3 days — promotable patterns → skills.

---

## Per-channel quick-refs

### Blog
- Lead with question or claim, not "In this post, we'll…".
- Links to primary sources.
- Publish via existing blog pipeline (not through Claude).

### Social (X, LinkedIn)
- Per-post: `external-comm-check` per variant.
- No price / speculation talk ever.
- Thread posts: pre-written and scheduled, not live-drafted on the day.

### Email
- Draft → Legal review if new disclaimer or claim.
- Send from BSVA's approved sending domain with list-scrubbing applied.

### Events (marketing side)
- Landing page, invite email, follow-up — each a sub-task.
- Sponsor logos / partner names per Biz-Dev clearance.

---

## Rollback

If post-launch correction needed (factual error, unauthorized naming, voice issue):
1. Open Nestr tension `incident/post-publish`, Confidential.
2. Triage with Marketing Lead (+ Legal if serious).
3. Action: correction / retraction / takedown.
4. Update all affected channels.
5. Blameless review in 5 business days.
6. Guidance PR to tighten the gate for next time.
