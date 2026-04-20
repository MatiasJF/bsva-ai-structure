# Authorization model

What Claude can and cannot access on its own. Corrects misconceptions that drive both over-trust and over-fear.

---

## The five access surfaces

Claude's reach is the union of these five surfaces. It has no reach outside them:

1. **The files in its working directory** (and any paths the human explicitly grants).
2. **The shell commands it's allowed to run** (per `permissions.allow` / `permissions.deny` in `settings.json`).
3. **The MCP servers the human has configured** and their credentials.
4. **The web, via WebFetch / WebSearch** — only if those tools are permitted, and only for URLs it is given or chooses.
5. **Content the human pastes or attaches in the session.**

That's it. There is no secret sixth surface.

---

## File system access

### What Claude sees by default

In a Desktop project: the project's root folder and subfolders.
In a CLI session: the folder you ran `claude` in.
Not: `~/Documents/`, `~/Desktop/`, `~/Downloads/`, system folders, other users' folders.

### What the human controls

Via `permissions.allow` and `permissions.deny`:

```json
{
  "permissions": {
    "allow": ["Read(~/bsva-ai-structure/**)"],
    "deny":  ["Read(~/.ssh/**)", "Read(/etc/**)", "Read(~/.gnupg/**)"]
  }
}
```

The BSVA `settings.template.json` denies `~/.ssh`, `~/.gnupg`, and `/etc` by default. Never remove those denies.

### What Claude will prompt for

Any read of a path not in the allow-list triggers a permission prompt (unless the user is in `--dangerously-skip-permissions` mode — reserved for CI). **Don't grant permissions reflexively.** If Claude asks to read `~/Documents/Contracts/`, ask yourself why.

---

## Shell execution

### The model

Claude asks to run a command; the human approves (or auto-approves via allow-list); the command executes.

### BSVA-mandated denies

Even without specific config, never allow-list these categories:

- `rm -rf` anything
- `git push --force` / `-f`
- `curl * | sh` / `curl * | bash` (arbitrary code execution)
- `sudo *` in a general session
- Anything writing to `/etc`, `/System`, other users' homes

### Pre-approved patterns (safe to allow-list)

Examples from `settings.template.json`:

- `Bash(git status)`, `Bash(git diff:*)`, `Bash(git log:*)`, `Bash(git show:*)`
- `Bash(ls:*)`, `Bash(pwd)`
- Version checks (`node --version`, `npm --version`)

Anything that **mutates** should require a prompt.

---

## MCP access

### What MCPs can do

Each MCP server exposes a fixed set of tools. Claude can only call the tools the server exposes. The BSVA-global MCPs:

- **Nestr** — read / write tensions, circles, roles, in the workspace you're authenticated to.
- **simple-mcp** — scaffold generators (writes files in the current project).
- **WhatsOnChain** — read-only on-chain data. Public blockchain; no credentials needed for most calls.
- **BSV Academy** — read-only knowledge base.

Department-specific MCPs are additive.

### What MCPs cannot do

- Reach data outside the scope their API key grants (e.g., Nestr MCP sees only your Nestr workspace).
- Act on a workspace you aren't a member of.
- Transfer funds, sign transactions, or access wallets unless you explicitly wire a signing MCP and approve each action.

### Credential scoping

- MCP credentials live in `~/.claude/settings.json` or `~/.claude/mcp.json`. **These are personal, never shared.**
- For project-specific MCPs with project-specific credentials, use project-scoped MCPs (`claude mcp add <name> ... --scope project`) and `.env` files in `.gitignore`.
- **Never** commit MCP credentials to this repo, even "temporary" test ones.

---

## Web access

### The two tools

- `WebFetch(url)` — fetches a specific URL.
- `WebSearch(query)` — searches.

### Who controls it

Both tools can be denied globally (via `permissions.deny: ["WebFetch", "WebSearch"]`) or per-URL.

### Why it matters for classification

If the human paste mentions an **internal BSVA URL**, Claude might try to fetch it. That fetch triggers a DNS lookup (observable to whoever owns the network), a TLS handshake (reveals the domain to your ISP and monitoring), and a request that might log to the target server.

**Rule:** Don't let Claude fetch internal URLs. If an internal doc is relevant, attach it instead.

---

## Session data

### What persists

By default: nothing, across sessions. Each session is independent.

### What can be made to persist

The `~/.claude/` folder holds:

- `settings.json` — your configuration.
- `projects/<slug>/memory/` — memory files, if Claude has been instructed to save them.
- `skills/` — global skills.
- `mcp.json` — MCP config.

All of these are **plain files you can read, audit, and delete**. There is no hidden database.

### Audit trail

If you enable the `Stop` hook in `global/settings.template.json`, sessions append a line to `~/.claude/bsva-activity.log`. This is a local file; you control it.

---

## The one principle

**Claude's authority = the union of permissions you've granted.** You can always tighten, you can always revoke, you can always audit. Start narrow; widen only with reason.
