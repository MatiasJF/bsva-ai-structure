# 01 — System architecture

How the BSVA AI structure fits together: the repo, each person's `~/.claude/`, department projects, and MCPs.

---

```mermaid
flowchart TB
  subgraph repo["GitHub: bsva-ai-structure (private)"]
    global["global/<br/>base CLAUDE.md<br/>skills, MCPs, settings"]
    guides["guides/<br/>for-humans<br/>for-claude<br/>visuals"]
    sec["security/<br/>classification,<br/>handling, redaction"]
    depts["departments/<br/>devrel · technology<br/>education · operations"]
  end

  installer(["install.sh / install.ps1<br/>idempotent, with backups"])

  subgraph user["Each BSVA person's machine"]
    claudeDir["~/.claude/<br/>CLAUDE.md (base)<br/>skills/<br/>mcp.json, settings.json"]
    project["Department project<br/>(cloned from template)<br/>• CLAUDE.md (layer 2)<br/>• .claude/skills/<br/>• code / content"]
  end

  subgraph mcps["External MCP servers"]
    nestr["Nestr MCP<br/>(with user's API key)"]
    simple["simple-mcp<br/>(BSV scaffolding)"]
    woc["WhatsOnChain MCP<br/>(public data)"]
    academy["BSV Academy MCP<br/>(knowledge base)"]
  end

  claude[["Claude Code<br/>(CLI or Desktop)"]]

  repo -->|git clone / pull| installer
  installer -->|copies global| claudeDir
  installer -.->|sets department| project
  claudeDir --> claude
  project --> claude
  claude <-->|tool calls| nestr
  claude <-->|tool calls| simple
  claude <-->|tool calls| woc
  claude <-->|tool calls| academy

  style repo fill:#f0f7ff,stroke:#2f6fd8
  style user fill:#f7fff0,stroke:#4fa63b
  style mcps fill:#fffaf0,stroke:#d89a2f
  style claude fill:#fff0f3,stroke:#c0284a
```

---

## Walkthrough

1. **The repo** is the single source of truth for BSVA's Claude guidance. DevRel owns it; departments have write access to their own folders.
2. **The installer** is run once per machine (plus `--sync` after `git pull`). It copies the `global/` pieces into `~/.claude/` and records which department the user belongs to.
3. **The user's `~/.claude/`** is their personal Claude environment. The installer writes the base `CLAUDE.md`, skills, and settings templates here. The user layers their own personal settings on top.
4. **A department project** is created from a department template. Its `CLAUDE.md` is layer 2 of the context stack — it extends, never replaces, the base.
5. **Claude** reads both layers (base + department + any project-specific `CLAUDE.md`) at the start of every session.
6. **MCPs** extend Claude's reach. The four global ones are configured at the user level. Departments can add their own at the project level.

---

## Ownership / RACI

| Step | Responsible | Accountable | Consulted | Informed |
|---|---|---|---|---|
| Repo changes | PR author (in dept folder) or DevRel (global) | DevRel Lead | Security (global/ or security/) | All BSVA |
| Installer changes | DevRel | DevRel + Security | – | All BSVA |
| Personal `~/.claude/` setup | The user | The user | DevRel if stuck | – |
| Department project template | Department Lead | Department Lead | DevRel | All BSVA |
| MCP credentials | The user | The user | Security | – |

---

## See also

- [02 — Onboarding flow](02-onboarding-flow.md) — how a new person travels this architecture on day one.
- [03 — Skill lifecycle](03-skill-lifecycle.md) — how new skills enter the repo.
- `security/authorization-model.md` — what each of these surfaces can and cannot access.
