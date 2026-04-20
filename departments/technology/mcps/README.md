# Technology department MCPs

MCPs specific to Technology work (beyond the global set).

## Candidates

- **BSVA-internal monitoring MCP** — read-only access to internal observability dashboards. Would require security review.
- **BSV reference-node MCP** — controlled access to a reference node for testing. Read-only against mainnet; read/write against BSVA-operated testnet.
- **BSVA internal CI MCP** — read-only access to build status / test results.

None are initially configured — all require the MCP lifecycle (see `guides/visuals/04-mcp-lifecycle.md`).

## Risk

Tech MCPs often touch infrastructure credentials. Default to read-only. Any write-capable MCP requires explicit Security sign-off **per deployment**.
