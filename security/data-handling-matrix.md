# Data handling matrix

What you may do with each tier. See `classification.md` for tier definitions.

---

## Master matrix

| Action | 🟢 Public | 🟡 Internal | 🟠 Confidential | 🔴 Restricted |
|---|:---:|:---:|:---:|:---:|
| **Sharing** | | | | |
| Paste into Claude CLI | ✅ | ✅ | ✅* | ❌ |
| Paste into Claude Desktop app | ✅ | ✅ | ✅* | ❌ |
| Paste into claude.ai web interface | ✅ | ❌ | ❌ | ❌ |
| Paste into a 3rd-party AI tool not approved by BSVA | ✅ | ❌ | ❌ | ❌ |
| Share in Nestr (scoped circle) | ✅ | ✅ | ✅ | ✅ (legal/exec circle) |
| Share in Nestr (workspace-wide) | ✅ | ✅ | ❌ | ❌ |
| Share in external Slack / Discord | ✅ | ❌ | ❌ | ❌ |
| Email to external party | ✅ | ❌ (unless approved) | ❌ | ❌ |
| **Storage** | | | | |
| Store in personal cloud (Dropbox / iCloud / Google Drive) | ✅ | ❌ (BSVA-approved only) | ❌ | ❌ |
| Store on personal device | ✅ | ✅ (with disk encryption) | ✅ (encrypted + locked) | ❌ (BSVA-managed only) |
| Commit to a public repo | ✅ | ❌ | ❌ | ❌ |
| Commit to a BSVA private repo | ✅ | ✅ | ✅ | ❌ (special handling) |
| **Processing** | | | | |
| Upload to online renderer (Mermaid live, draw.io, Excalidraw cloud) | ✅ | ❌ | ❌ | ❌ |
| Paste into gist / pastebin | ✅ | ❌ | ❌ | ❌ |
| Paste into a screenshot tool that uploads to cloud | ✅ | ❌ | ❌ | ❌ |
| Run through 3rd-party translation service | ✅ | ❌ (BSVA-approved only) | ❌ | ❌ |
| **AI / Claude specifics** | | | | |
| Include in a skill committed to this repo | ✅ | ✅ (no secrets) | ❌ | ❌ |
| Include in a CLAUDE.md committed to this repo | ✅ | ✅ (no secrets) | ❌ | ❌ |
| Use Claude's WebFetch / WebSearch on this URL | ✅ | ⚠ (BSVA-internal URLs may leak via DNS) | ❌ | ❌ |
| Give Claude MCP write access to this data | ✅ | ✅ | ⚠ (scope narrowly) | ❌ |
| **Display** | | | | |
| Show on public conference slides | ✅ | ❌ | ❌ | ❌ |
| Show in a Zoom screen share with external parties | ✅ | ❌ | ❌ | ❌ |

*Confidential via Claude: redact first, session must be CLI or Desktop (not web), no third-party renderers, permissions scoped to the current project folder.

---

## Clarifications

### "Approved" third-party tools
BSVA maintains a list in `approved-external-tools.md`. A tool's presence on that list authorizes use at the specified tier — nothing more.

### Encryption requirements
"Disk encryption" means FileVault (macOS), BitLocker (Windows), or LUKS (Linux). If you don't know whether it's on, ask IT / DevRel.

### The Nestr nuance
Nestr tensions are access-controlled by circle membership. A tension in a legal circle is Restricted-safe; the same content in a general circle is not.

### Web vs Desktop vs CLI
The web interface (`claude.ai`) is the lowest-friction surface but also the most permissive with your data — it sends content directly to Anthropic. Desktop and CLI give you:
- MCP scope control
- File access controls
- Per-project system prompts (your department's CLAUDE.md)
- Local audit trails

For non-Public content, **always** use Desktop or CLI.

---

## The "no" list (always)

Regardless of tier claim or context:

- Never commit an API key, private key, or password to any repo.
- Never paste an SSH private key anywhere.
- Never send real user PII (emails, phone numbers, names + identifiable data) to a 3rd-party AI tool without a DPA in place.
- Never take a screenshot of a ClaudeCode session that includes Confidential-or-higher content and share it without redaction.
