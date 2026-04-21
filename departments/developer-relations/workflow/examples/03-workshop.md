# Example 3 — Workshop delivered at a conference

A 90-minute workshop at DevCon Lagos, idea → delivery → publish. Same cycle, longer horizon, more tensions.

---

**DESIRE.** DevRel Lead: "We need a BRC-100 wallet workshop for DevCon Lagos. 90 minutes. June 15."

**CLARIFY.** `clarify`:

> - What: 90-min workshop repo with lessons (01–05), slides (bsva-pptx), facilitator notes, attendee handout?
> - Why: DevCon Lagos audience, growing BRC-100 interest, no existing workshop on wallet-building.
> - Who for: intermediate SDK devs, some Bitcoin background.
> - Classification: Internal until event, Public after (recording lands ~1 week post-event).
> - Success: repo deliverable, 80% of attendees complete through lesson 3, no major technical issues.
> - Co-delivered: solo (me) + BSVA booth presence.
> - Budget: travel + per-diem — tension to Ops. Faucet key funding — tension to Tech.

Lead confirms.

**CAPTURE.** Primary **nest**: `Workshop "Build a BRC-100 wallet in 90 min" delivered at DevCon Lagos` (`N-8710`, DevRel role, Internal).

Linked tensions prepared in draft (will submit in batches):

- `T-4020` → sdk-maintainer (Tech): SDK review of lessons 3–4 before event.
- `T-4021` → Ops Lead: travel + per-diem approval for DevCon Lagos.
- `T-4022` → Tech: fund faucet with 50 testnet keys for attendees.
- `T-4023` → Marketing: event promo copy + social post 2 weeks before.

All linked to the primary nest via `nestr_add_graph_link`.

**PLAN-MODE.** Claude drafts a 2-week plan:

- Week 1: lessons 01–05 drafted, tech-review tension submitted, dry-run with one reviewer.
- Week 2: slides in bsva-pptx, facilitator notes, pre-event run through, publish-gate.
- Event day: deliver.
- Post-event: publish gate → Public, recording URL posted.

Files: workshop repo, slides/*.md, facilitator-notes.md.
Skills: `workshop-lesson-splitter`, `sdk-example-scaffold`, `verify-sdk-surface`, `classify-before-publish`.
MCPs: simple-mcp, BSV Academy, GitHub.
Estimate: 2 working days split over 2 weeks.

Approved with one change: "Add a pre-event attendee email — template me a draft, tension to Marketing for voice check."

**EXECUTE.**

- Day 1: scaffolded from `templates/new-workshop/`. Lessons 01–02 drafted. `verify-sdk-surface` at each commit.
- Day 2: Lessons 03–04 drafted. Submitted tension `T-4020` to sdk-maintainer with links to the lesson branches. Comment on nest: "Lessons 1–4 ready for review; 5 is the capstone, in progress."
- Day 3: Lesson 05 (capstone) drafted. Slides in `bsva-pptx`. Ran locally through all lessons — all pass.
- Day 4: SDK review returned with 2 minor corrections (fixed). Dry-run scheduled with another DevRel for Day 5.
- Day 5: Dry-run. Two insights: "lesson 3 is 5min too long" → trimmed. "attendees will want copy-paste snippets" → added a cheat-sheet page. Comment: "Dry-run done, insights integrated."
- Day 6–8: Marketing promo copy drafted; tension `T-4023` submitted. Ops approved travel (`T-4021` closed). Faucet funded (`T-4022` closed).
- Day 10: pre-event check — all lesson branches build, slides render, facilitator-notes.md complete. `classify-before-publish` dry-run (gate not formally passed yet; runs after event for Public flip).
- Event day (June 15): Delivered. Attendance 42. Lesson 3 completion rate: 85% (above target).
- Day 12 (post-event): recording arrives from event team. `classify-before-publish` gate run; all 5 checks ✓. Lead approves publish. Classification flipped: repo set to public, README updated with link to recording.

**REPORT.** Final comment on primary nest:

> "Workshop delivered at DevCon Lagos June 15. 42 attendees, 85% through lesson 3, NPS-equivalent feedback 7.8/10. Repo public at github.com/bsv/workshops-lagos-brc100. Recording: [URL]. Linked tensions all resolved. Learnings for retro: lesson 3's second exercise needs further trim for non-English-primary audiences — noted for the DevCon Mumbai variant. Promotable: the 'cheat-sheet appendix' pattern works well — consider a `workshop-cheatsheet-builder` skill for DevRel."

**CLOSE.** Lead reviews acceptance criteria: all met. `project.status: Done`, `completed: true`.

---

## What this example shows

- Multi-week workshops still follow the same cycle, just with more linked tensions.
- Tensions prepared in `draft` and submitted in batches (not created ad-hoc) respect the "cluster don't spam" norm.
- The retro caught a promotable skill (`workshop-cheatsheet-builder`) that could become a real DevRel skill via the promotion path.
- Classification flip happened explicitly after a gate run, not silently — audit trail preserved.
