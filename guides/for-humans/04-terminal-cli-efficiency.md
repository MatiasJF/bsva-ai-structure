# 04 — Claude Code CLI — efficiency

For engineers, DevRel, technical education. Assumes you've done `02-first-hour-setup.md`.

---

## Mental model

The CLI gives you three capability layers on top of the base chat:

```
┌──────────────────────────────────────────────┐
│  4. Automation: hooks, /loop, /schedule       │  ← runs without you
├──────────────────────────────────────────────┤
│  3. Orchestration: subagents, plan-mode       │  ← parallel / structured work
├──────────────────────────────────────────────┤
│  2. Integration: MCPs (tools), skills         │  ← extends Claude's reach
├──────────────────────────────────────────────┤
│  1. Core: chat + files + terminal commands    │  ← default
└──────────────────────────────────────────────┘
```

Learn them bottom-up. Don't reach for layer 4 before you trust layer 1.

---

## Core moves (layer 1)

- `claude` — start a session in the current folder.
- `claude "prompt"` — one-shot: runs prompt, prints answer, exits. Great for scripts.
- `claude --continue` — resume the last session in this folder.
- `/clear` — start a fresh context in the same session (drops transcript, keeps env).
- `/config` — tweak model, theme, permissions.
- `!command` — run a shell command inline (goes into context).

---

## Skills and slash commands (layer 2)

- `/skill-name` — invokes a skill from `~/.claude/skills/` or your project's `.claude/skills/`.
- `/help` — list available skills and built-ins.
- BSVA global skills available everywhere: `/bsva-docx`, `/bsva-pptx`, `/bsva-onepager`.
- Department skills available when you're in a department-linked project.

**When to create a skill**: a prompt you find yourself re-typing more than 3 times, or a multi-step workflow that should be callable by name. See `departments/developer-relations/guides/how-to-start-a-project.md` for the skill-authoring flow.

---

## MCPs (layer 2, cont.)

MCPs are tool connections (Nestr, WhatsOnChain, BSV Academy, simple-mcp). To see what's active:

```bash
claude mcp list
```

To add one:

```bash
claude mcp add <name> <command> --scope user      # user-wide
claude mcp add <name> <command> --scope project   # this project only
```

Prefer `--scope project` for anything with department-specific credentials. See `05-treating-claude-seriously.md` for rules on where credentials live.

---

## Plan-mode and subagents (layer 3)

- **Plan-mode**: before a big change, `/plan` (or hit `shift+tab` in the prompt). Claude drafts a plan, you approve, then execute. Use this for anything touching more than 2 files.
- **Subagents**: parallel workers. `Agent({...})` spawns one; good for independent research queries that would flood your main context. Use `subagent_type: "Explore"` for codebase searches, `"general-purpose"` for broader tasks.

---

## Hooks and automation (layer 4)

Hooks run shell commands on events (`UserPromptSubmit`, `PreToolUse`, `Stop`, etc). Live in `~/.claude/settings.json`.

**BSVA's recommended hooks** (copy into your `settings.json`):

```json
{
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          { "type": "command", "command": "echo 'session ended $(date)' >> ~/.claude/bsva-activity.log" }
        ]
      }
    ]
  }
}
```

See the [skill](../for-humans/../../global/CLAUDE.md) on hook configuration (`update-config`) for the full syntax.

**Scheduled / looping**: `/loop 10m /check-deploy`, `/schedule` for cron-style remote triggers.

---

## Hygiene

- **`/clear` often.** Fresh context = better quality. Sessions that go past ~50 turns start to drift.
- **One task per session.** Don't pile unrelated work into the same context.
- **Commit often.** If Claude edits your code, commit before the next big change — so you can `git diff` the next batch cleanly.
- **Review diffs, don't trust summaries.** Claude's "here's what I did" is a claim, not a proof. Always `git diff` after.

---

## Power-user cheatsheet

| Thing you want | Way to do it |
|---|---|
| Run without prompts (scripting) | `claude --dangerously-skip-permissions "..."` — for trusted CI only |
| Cheap exploration | Explore agent (`subagent_type: "Explore"`) |
| Check before editing | Plan mode + `ExitPlanMode` |
| Hands-off polling | `/loop` with a dynamic interval |
| Find a tool whose schema isn't loaded | `ToolSearch` |
| Save context for next session | Write to `~/.claude/projects/<slug>/memory/` |
