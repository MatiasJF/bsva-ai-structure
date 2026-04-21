# Executive — restricted session rules

Session hygiene for Exec Claude usage.

## Surface

- **CLI** (terminal) — preferred.
- **Claude Code Desktop** — fine.
- **claude.ai web** — **not allowed** for Exec.
- **IDE extensions** — fine if running same Anthropic account.

## Per-session discipline

1. **Start fresh each task.** `/clear` or new session. Don't let context accumulate across tasks.
2. **Scope file access narrowly.** Project folder only; not `~/` or `~/Documents/`.
3. **Enable Stop-hook logging.** See `../session-logging.md`.
4. **Close sessions explicitly.** Don't leave open when walking away.
5. **No MCP access beyond what the task needs.** Disable Nestr if not needed for the task. Turn on only for creating the nest, then disable.

## What files Claude sees

- Project folder (narrowly scoped).
- The Exec `CLAUDE.md` (layered base + Operations + Exec).
- Attached files you explicitly share.

## What Claude doesn't see

- Anything outside the project folder unless explicitly granted.
- Your email, calendar, Slack — unless an MCP is configured and wanted for the task.
- System files, SSH keys, credentials (denied globally).

## Pre-flight every Exec session

Before pasting anything:

1. **Is this public source material?** If yes → proceed.
2. **Is this BSVA internal-but-non-strategic?** Use `anonymizer` first.
3. **Does this reference board / M&A / HR / unreleased financial?** → STOP. Out of scope for Claude.

## Post-session

- Close the session.
- If any Nestr nest was created / updated, confirm the content in Nestr is within the tier it's labeled for.
- If anything unexpected was pasted (slip), notify DevRel + Security + Legal per `security/incident-response.md`.

## Audit

Exec sessions are subject to periodic audit (Security + Legal). The audit reviews:
- Session boundary logs (from the Stop hook).
- Nestr nodes created during Exec sessions (content + classification).
- Any incident reports.

No content logs are kept by default. Audit is a sampling exercise, not a review of specific utterances.

## The unwritten Exec rule

**If you'd be embarrassed to see the content on the front page of the financial press tomorrow, it doesn't belong in Claude today.** Exec at BSVA represents the organization to the world; session discipline is how we preserve that.
