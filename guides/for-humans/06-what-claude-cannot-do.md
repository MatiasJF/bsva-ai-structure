# 06 — What Claude cannot do

A factual reference. Share this with colleagues who are worried, or who over-trust Claude.

---

## File system

| Claim | Reality |
|---|---|
| "Claude can read any file on my computer." | **No.** It reads only what the session is permitted to read — usually the current project folder and files you attach. |
| "Claude can browse my whole disk to find something." | **No.** It must be given a path. It will not wander into `~/Documents/` or `~/Desktop/` uninvited. |
| "Claude automatically reads my Downloads / Drive / iCloud folders." | **No.** Same rule — paths must be granted. |
| "Claude reads hidden files like `.env` or `~/.ssh/`." | **No** — and the BSVA `settings.template.json` explicitly **denies** `~/.ssh/`, `~/.gnupg/`, and `/etc/`. |

## Commands / terminal

| Claim | Reality |
|---|---|
| "Claude can silently run commands on my machine." | **No.** Unless you've pre-approved the command pattern in your allow-list, it will prompt for permission. |
| "Claude can reboot / reformat / mess with my OS." | **Blocked** by default. Destructive patterns (`rm -rf`, `git push --force`) are denied by BSVA defaults. |
| "Claude can install software without me knowing." | **No.** `brew install`, `npm install`, etc., trigger permission prompts unless explicitly allow-listed. |

## Network

| Claim | Reality |
|---|---|
| "Claude is always online and searching the web." | **No.** It has `WebSearch` / `WebFetch` tools, both gated by permissions. Many sessions don't use either. |
| "Claude uploads my files to train future models." | **Not by BSVA's Anthropic configuration.** Work-account data is not used for training. (Verify your account settings if uncertain.) |
| "Claude connects to random services." | **No.** Only the MCP servers you configure. You control the list. |

## Memory

| Claim | Reality |
|---|---|
| "Claude remembers everything we've ever talked about." | **No.** Sessions are independent. |
| "Claude remembers across sessions." | **Only if something is saved to a file it reads**, typically `~/.claude/projects/<slug>/memory/`. All memories are plain markdown you can read, edit, or delete. |
| "BSVA-specific 'memory' is a black box." | **No.** Everything Claude "knows" about BSVA is in this repo and your `CLAUDE.md` layers. Auditable. |

## Identity / accounts

| Claim | Reality |
|---|---|
| "Claude logs in as me on websites." | **No.** It has no credentials unless you paste them (don't). |
| "Claude can impersonate me on Nestr / email / Slack." | **Only** via an MCP you've configured with your own API key, acting on your behalf. The actions are your actions. |

## Social

| Claim | Reality |
|---|---|
| "Claude knows my coworkers and their roles." | **Only** via the Nestr MCP you've connected, and only within the workspace you're in. |
| "Claude knows who's on my team." | **Only** from files you show it, or directory data via a connected MCP. |

---

## Corollary: what this means for BSVA

1. **You are not "leaking by using Claude".** You leak by pasting things into Claude.
2. **You are not at risk of Claude finding something sensitive.** You are at risk of you handing it over.
3. **Audit is possible.** Every Claude interaction is text; every permission is a line in a JSON file. If you wonder what Claude has access to, `cat ~/.claude/settings.json`.

---

## Next

→ `07-BEFORE-YOU-PASTE.md` — turn this knowledge into a 30-second habit.
