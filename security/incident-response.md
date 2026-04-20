# Incident response

**You pasted something you shouldn't have. Now what?**

First: don't panic. Incidents happen. The worst outcome is silence. The best outcome is a clean report, a known-contained situation, and a lesson that makes the next person's guidance sharper.

---

## The first 5 minutes

### Step 1 — Contain (60 seconds)

Stop the session. Close the chat. Don't continue "just to see what happens".

If you pasted into Claude CLI: `Ctrl-C` to exit. If Desktop: close the conversation.

### Step 2 — Assess what was exposed (2 minutes)

Name it to yourself, out loud or in a note:

- What exactly did I paste? (Content type, not the content.)
- Which surface was it? (CLI / Desktop / web)
- Was it attached, or pasted in chat?
- Was there a private key, API key, or password in it?

### Step 3 — Rotate if a secret was involved (2 minutes, start immediately)

If **any** of these were in the paste, rotate them **now**:

- Production API keys → revoke in the source system, generate a new one.
- Personal API keys (GitHub PAT, etc.) → revoke.
- Private keys / seed phrases → move funds to a new address. Treat the key as compromised.
- Passwords → change them.
- Session tokens / JWTs → invalidate all.

Don't wait until you report. Rotation is always first.

---

## The next 30 minutes

### Step 4 — Notify the right role

For **any** incident involving Confidential or Restricted content, notify:

- **DevRel Lead** (`@bsva/devrel`) — always.
- **Security** (`@bsva/security`) — if credentials, access tokens, or data that could enable further compromise were exposed.
- **Legal Lead** (`@bsva/legal`) — if contract content, NDA-covered content, or personal data was exposed.
- **HR Lead** (`@bsva/hr`) — if HR / personnel data was exposed.

**How to notify**: create a Nestr tension in the department circle, titled `Incident: [one-line summary]`. Mark it Confidential. Do **not** paste the original content into the tension — summarize at a high level.

### Step 5 — Write a short incident note

Fields:

```
Incident summary
  When: <date, time>
  Surface: <Claude CLI / Desktop / web>
  Content type: <contract clause / partner name / API key / etc.>
  Classification of content: <Internal / Confidential / Restricted>
  Was a secret exposed: <yes/no; what was rotated>
  Was the content sent anywhere beyond Claude: <yes/no; where>

What I did to contain:
  - <step 1>
  - <step 2>

What happened before:
  - <what I was trying to do>
  - <what went wrong in classification>

What would have prevented this:
  - <concrete suggestion — a new rule, a better heuristic, a missing check>
```

Save this as a comment on the tension, or as an attachment.

---

## The next 24 hours

### Step 6 — Participate in the blameless review

DevRel + Security will schedule a short review (usually 20–30 minutes) within a business day. Goal: understand what happened, what changed, what to improve in the guidance.

**This is blameless.** The purpose is to improve the system, not to punish the person. BSVA has a strong norm against punishing good-faith reporters — the alternative (silent leaks) is worse for everyone.

### Step 7 — Update the guidance

Almost every incident should result in a PR to this repo:

- New example in `08-what-to-send.md` or `09-what-NOT-to-send.md`.
- New heuristic in `10-redact-before-you-paste.md`.
- New detection signal in `guides/for-claude/classification-enforcement.md`.
- New deny entry in `global/settings.template.json`.

The PR closes the loop: the next BSVA member doesn't make the same mistake because the system now catches it.

---

## Specific incident types

### "I pasted a private key into Claude"

1. Move any funds to a new address immediately.
2. Consider the key permanently compromised.
3. Notify Security within 1 hour.
4. Paste nothing else into that session; close it.

### "I pasted an API key into Claude"

1. Revoke the key in the source service now. Generate a replacement.
2. Check the service's audit log for any use of the key in the last N hours.
3. Notify Security.

### "I pasted a draft contract with partner name + terms"

1. Don't continue the session.
2. Notify Legal + Biz-Dev Lead.
3. Legal determines whether to contact the partner; do not contact them unilaterally.

### "I pasted an internal document and realized halfway through it was Confidential"

1. Stop, close the session.
2. Notify DevRel Lead.
3. Depending on content, may not require Legal.

### "A colleague showed me something on a screen share while I had Claude open — I didn't paste it"

Not an incident. Screen content isn't automatically in Claude's context.

### "Someone else pasted content I think was mis-classified"

Flag it to them directly first. If they disagree / if the content is serious, escalate to DevRel Lead.

---

## What NOT to do

- ❌ Delete the conversation and "hope Anthropic doesn't keep it". (Incident still happened; transparency is the only path.)
- ❌ Email the content to a colleague to ask their opinion. (You're spreading, not containing.)
- ❌ Post about it in a general Slack channel. (That broadens the exposure.)
- ❌ Wait until Monday. (Time matters, especially for credential rotation.)

---

## Reference

- `classification.md` — tier definitions.
- `data-handling-matrix.md` — what's allowed per tier.
- `redaction-playbook.md` — how to prevent next time.
- `human-responsibilities.md` — the division of labor.

---

## The sentence to hold onto

**"Silence makes incidents worse. Disclosure is how BSVA gets better."**

If you're reading this at 11pm after a scary moment: take a breath, rotate the key if there was one, write the note in the morning. You're going to be fine. Close the loop, and help us close it for the next person.
