# Approved external tools

A tool appears here only if BSVA has cleared it for use **at the specified tier**. Using a tool not listed — at a non-Public tier — is not allowed.

This list is maintained by DevRel + Security. Submit a PR to propose additions.

---

## Tools approved for use with Public content only

These tools may be used freely for Public-tier material. Do not use them with Internal / Confidential / Restricted content.

| Tool | Category | Notes |
|---|---|---|
| **Anthropic claude.ai (web)** | AI chat | Public content only. For Internal+, use Claude Code Desktop or CLI. |
| **Mermaid Live Editor** (`mermaid.live`) | Diagram rendering | Content is sent to mermaid.live servers. Public content only. |
| **draw.io (browser / cloud)** | Diagram editor | Use the **desktop app** for non-public diagrams; cloud version only for Public. |
| **Excalidraw (`excalidraw.com`)** | Whiteboard / sketch | Public content only. Self-hosted instance can be approved separately. |
| **GitHub Gist** | Code/text sharing | Public gists only. Treat "secret" gists as still indexable. |
| **Pastebin (public pastes)** | Text sharing | Avoid for anything you wouldn't publish. |
| **Online JSON / YAML formatters** | Formatters | Public content only. Use local tooling for non-public. |
| **`regex101.com`** | Regex testing | Your test strings are stored server-side if you save. Public-safe inputs only. |

---

## Tools approved for use with Internal (and lower) content

*To be filled in as BSVA approves specific vendors. Candidates under review:*

- (TBD) A BSVA-licensed translation service with a DPA.
- (TBD) A BSVA-self-hosted Excalidraw instance for Internal diagrams.

Until a tool is explicitly listed here, **treat Internal content as "no external tool"** except Claude Code Desktop / CLI with approved MCPs.

---

## Tools approved for use with Confidential content

**None.** Confidential content stays on BSVA-managed systems and approved Claude surfaces (Desktop / CLI with scoped MCPs).

---

## Tools approved for use with Restricted content

**None.** Restricted content is handled through Legal / Exec processes, not self-service tools.

---

## AI tools — explicit stance

BSVA's approved AI tools for non-Public content:

- **Claude Code Desktop** (logged into your BSVA-provisioned Anthropic account).
- **Claude Code CLI** (same account).

BSVA's approved AI tools for Public content only:

- **Claude.ai web** (same account).
- Other AI assistants (ChatGPT, Gemini, Copilot, etc.) — **Public content only**, and only if you have reason to use them over the BSVA-standard Claude stack.

---

## Submitting a tool for approval

If you want a tool added:

1. Open a PR to this file adding the tool + intended tier + rationale.
2. Tag `@bsva/security` and `@bsva/devrel`.
3. For non-Public approval, DevRel will check:
   - DPA / data handling terms
   - Data retention and location
   - Whether content is used for model training
   - Whether BSVA already has a contract
4. Security sign-off required for anything above Public.

**Don't use the tool until the PR is merged.**

---

## Removing a tool

If a tool changes its policy (e.g., starts using customer data for training) or has an incident:

1. Open a PR removing it (or moving it to a lower tier).
2. Notify affected users in the relevant Nestr circle.
3. Do not delete historical references in closed incidents.
