# Operations — session logging

When to enable the `Stop` hook audit log for Operations sessions.

---

## The rule

**Always** enable session logging for:
- Legal sessions.
- Exec sessions.
- Any Confidential-or-higher session.

**Optional** for:
- Biz-dev lead-list building against public sources.
- Marketing drafting.

## How to enable

In your `~/.claude/settings.json`:

```json
{
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          { "type": "command", "command": "echo \"[$(date -u +%FT%TZ)] operations session ended; dept=$DEPT\" >> ~/.claude/bsva-ops-activity.log" }
        ]
      }
    ]
  }
}
```

(You can envelop the cmd per sub-section if you handle multiple Operations roles.)

## What the log captures

- Start and stop timestamps of each session.
- Which `DEPT` env var was set (if you scope per-department).
- No content — just boundary markers.

## Retention

- Logs retained per the document-retention policy (Legal Lead sets the duration).
- Logs on your machine are Restricted if Legal/Exec content was in the session — treat accordingly.

## Review

- Random-sample audit of logs during BSVA's periodic review (Security + Legal).
- Logs do **not** contain content; they are used to confirm sessions happened within policy, not to review what was discussed.

## Content logging is deliberately out of scope

BSVA does **not** log Claude session content by default. The `Stop` hook above is a session-boundary log only. Content logging would:
- Create a huge Confidential dataset to defend.
- Disincentivize honest Claude usage.
- Add compliance burden.

If an incident investigation needs specific session content, the user whose session it was can provide context per `security/incident-response.md`. The log helps us know the session happened; the human provides what was in it.
