# 02 — First hour setup

Target: you are productive in Claude within one hour, with BSVA standards applied.

---

## Step 1 — Install Claude Code (15 min)

### If you are an engineer / technical user
```bash
# macOS / Linux
brew install anthropic/tap/claude
# or
npm i -g @anthropic-ai/claude-code
```

### If you are non-technical
Download the **Claude Code** desktop app: https://claude.com/download → Mac / Windows.

> ⚠️ **Don't install "Claude Desktop" from `claude.ai/download`.** That's the consumer chat app — it cannot run BSVA's installer or write files natively, so the rest of this guide will not work with it. You need **Claude Code**, which has native Read / Write / Edit / Bash tools.

Log in with your **Anthropic work account** (not personal). If BSVA has not provisioned your account, ping DevRel in Nestr.

---

## Step 2 — Clone and install the BSVA structure (10 min)

```bash
git clone https://github.com/MatiasJF/bsva-ai-structure.git ~/bsva-ai-structure
cd ~/bsva-ai-structure
./install.sh       # macOS / Linux
./install.ps1      # Windows
```

The installer will:
- copy global skills and MCPs to `~/.claude/`
- install the base `CLAUDE.md` at `~/.claude/CLAUDE.md`
- ask which department you belong to
- back up anything it replaces to `~/.claude/.bsva-backup/`

---

## Step 3 — Connect Claude to Nestr (2 min)

BSVA runs on Nestr. Your Claude needs to talk to it — no API key required, auth is OAuth.

1. Merge the `mcpServers` block from `~/.claude/mcp.bsva-template.json` into your real MCP config (CLI: `~/.claude/mcp.json`; Desktop: Settings → MCP).
2. Restart Claude.
3. On the next session the Nestr MCP will open `https://mcp.nestr.io/` in your browser — sign in with your Nestr account to authorize. That's it.

---

## Step 4 — Verify (5 min)

Open Claude and ask:

> "Use the Nestr MCP to tell me who I am and which workspace I am in."

You should see your name, role, and workspace. If you see an auth error, your API key did not land in the right place.

---

## Step 5 — Read the three flagship guides (15 min)

**Do not skip this step.** These are the three files that change how you use Claude at work:

1. `07-BEFORE-YOU-PASTE.md` — pre-flight checklist
2. `08-what-to-send.md` — green-light examples
3. `09-what-NOT-to-send.md` — red-light examples

---

## Step 6 — Link your first project (5 min)

When you start a new project / folder, run:

```bash
cd ~/my-project
bsva-link              # (provided by install.sh)
```

This symlinks your department's `CLAUDE.md` into the project so Claude reads it automatically. If `bsva-link` is not on your PATH, copy `departments/<your-dept>/CLAUDE.md` into your project root as `CLAUDE.md`.

---

## You're done

Next guide: `03-desktop-app-efficiency.md` (non-tech) or `04-terminal-cli-efficiency.md` (engineers).
