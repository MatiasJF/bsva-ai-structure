# Human responsibilities

**You are the gate. Claude is the backstop.** This page names what "you are the gate" means in practice.

---

## The division of labor

| Who | Responsibility |
|---|---|
| **You (the human)** | Classify content **before** sharing with Claude. Redact when tier requires. Choose the surface (web / Desktop / CLI) appropriate to the tier. Configure permissions. Review Claude's output. Report incidents. |
| **Claude** | Apply hard refusals to secrets and Restricted content. Prompt for confirmation when tier seems off. Never escalate tier silently. Point you to the right process when you're unsure. |
| **DevRel + Security** | Maintain this repo's rules. Respond to escalations. Audit when asked. |
| **Legal** | Sign off on Restricted-related rules. Handle incidents involving legal exposure. |

---

## Your five responsibilities, in detail

### 1. Classify before you share

For every piece of content you're about to paste, attach, or let Claude process:

- Decide the tier (Public / Internal / Confidential / Restricted).
- Use the pre-flight from `guides/for-humans/07-BEFORE-YOU-PASTE.md`.
- When uncertain, up-classify.
- Don't rely on Claude to catch mis-classification. It might; it might not.

**The principle:** if you didn't decide a tier before sharing, you didn't protect the content.

### 2. Redact when tier requires

Per the handling matrix:

- Confidential into Claude → redact per `10-redact-before-you-paste.md` before pasting.
- Internal into a 3rd-party tool → don't. Find a BSVA-approved alternative or skip.
- Restricted into Claude → don't. At all. Ever.

### 3. Choose the right surface

Match the tier to the surface:

```
Tier       Allowed surfaces
─────────  ────────────────────────────────────────
Public     any (web, Desktop, CLI)
Internal   Desktop, CLI only (not web)
Confid.    Desktop, CLI only, scoped, redacted
Restricted none
```

### 4. Configure permissions conservatively

Your `~/.claude/settings.json` is your personal responsibility:

- Start from `global/settings.template.json` (the installer puts it at `~/.claude/settings.bsva-template.json`).
- Only allow-list commands and paths you **need**.
- Deny more than you think necessary — it's easy to loosen, hard to tighten after a mistake.
- Never share your `~/.claude/settings.json` with colleagues (it may contain personal paths or credentials).

### 5. Report incidents

When something goes wrong:
- You pasted something you shouldn't have.
- You realized content was Confidential after the fact.
- You noticed a key or secret appeared in a Claude session.
- You saw someone else do any of the above.

**Report it.** See `incident-response.md`. Silence is worse than disclosure.

---

## What you are NOT responsible for

- Deciding on behalf of the organization what classification tiers exist. (That's a PR to `classification.md`.)
- Interpreting legal questions. (Legal owns that.)
- Getting the rules "perfect" on your first day. (Ask when unsure. Up-classify when guessing. Learn over time.)

---

## What good looks like

A BSVA member operating Claude well:

- Has read `07-BEFORE-YOU-PASTE.md` and the `08`/`09` green/red lists.
- Does a silent pre-flight every session. Takes 5 seconds after the first week.
- Keeps their `~/.claude/settings.json` locked down.
- Treats Claude like a junior colleague with no social context — they review before committing, publishing, sending.
- When they see something they're unsure about, asks a human first, pastes never.

You don't have to be paranoid. You have to be deliberate.
