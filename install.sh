#!/usr/bin/env bash
# BSVA AI Structure installer (macOS / Linux)
#
# - Copies global/ skills and MCPs into ~/.claude/
# - Prompts for department (dev-rel / technology / education / operations)
# - Idempotent: safe to re-run; will not overwrite user-added skills
# - Backs up any replaced files to ~/.claude/.bsva-backup/<timestamp>/
#
# Usage:
#   ./install.sh            first-time install or full refresh
#   ./install.sh --sync     pull-only: refresh global/ after `git pull`
#   ./install.sh --dry-run  show what would change, don't write anything

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"
BACKUP_DIR="${CLAUDE_DIR}/.bsva-backup/$(date +%Y%m%d-%H%M%S)"
DRY_RUN=0
SYNC_ONLY=0
SKIP_PREFLIGHT=0

# ── flag parsing ────────────────────────────────────────────────────
for arg in "$@"; do
  case "$arg" in
    --dry-run)         DRY_RUN=1 ;;
    --sync)            SYNC_ONLY=1 ;;
    --skip-preflight)  SKIP_PREFLIGHT=1 ;;
    -h|--help)
      sed -n '1,20p' "$0"; exit 0 ;;
    *) echo "unknown flag: $arg" >&2; exit 1 ;;
  esac
done

# ── preflight: check git + python3 are installed ────────────────────
if [[ $SKIP_PREFLIGHT -eq 0 ]]; then
  MISSING_TOOLS=()
  command -v git >/dev/null 2>&1 || MISSING_TOOLS+=(git)
  if ! command -v python3 >/dev/null 2>&1 && ! command -v python >/dev/null 2>&1; then
    MISSING_TOOLS+=(python3)
  fi
  if [[ ${#MISSING_TOOLS[@]} -gt 0 ]]; then
    echo ""
    echo "⚠ Missing required tools: ${MISSING_TOOLS[*]}"
    echo ""
    echo "  Run the bootstrap first — it detects your OS and package"
    echo "  manager and installs the missing pieces for you:"
    echo ""
    echo "    ./bootstrap.sh"
    echo ""
    echo "  Then re-run ./install.sh."
    echo ""
    echo "  (Advanced: bypass with ./install.sh --skip-preflight)"
    echo ""
    exit 1
  fi
fi

log()    { printf '%s\n' "$*"; }
do_cmd() { [[ $DRY_RUN -eq 1 ]] && log "DRY-RUN: $*" || eval "$*"; }

# ── preflight ───────────────────────────────────────────────────────
log "BSVA AI Structure installer"
log "  repo:     $REPO_DIR"
log "  target:   $CLAUDE_DIR"
log "  dry-run:  $DRY_RUN"
log "  sync:     $SYNC_ONLY"

do_cmd "mkdir -p '$CLAUDE_DIR' '$CLAUDE_DIR/skills' '$CLAUDE_DIR/projects' '$BACKUP_DIR'"

# ── copy global skills ──────────────────────────────────────────────
log ""
log "→ installing global skills"
for skill_dir in "$REPO_DIR/global/skills"/*/; do
  [[ -d "$skill_dir" ]] || continue
  skill_name="$(basename "$skill_dir")"
  target="$CLAUDE_DIR/skills/$skill_name"
  if [[ -d "$target" ]]; then
    do_cmd "cp -R '$target' '$BACKUP_DIR/'"
  fi
  do_cmd "rm -rf '$target'"
  do_cmd "cp -R '$skill_dir' '$target'"
  log "  ✓ $skill_name"
done

# ── merge MCP configs ───────────────────────────────────────────────
log ""
log "→ installing global MCP configs (~/.claude/mcp.json)"
log "  NOTE: review ~/.claude/mcp.json after install; add your own credentials where needed"
do_cmd "cp '$REPO_DIR/global/mcps/mcp.template.json' '$CLAUDE_DIR/mcp.bsva-template.json'"

# ── settings template (with repo path substituted) ─────────────────
log ""
log "→ writing settings template to ~/.claude/settings.bsva-template.json"
log "  (substitutes {{REPO_DIR}} with actual repo path)"
if [[ $DRY_RUN -eq 1 ]]; then
  log "DRY-RUN: sed s|{{REPO_DIR}}|$REPO_DIR|g → $CLAUDE_DIR/settings.bsva-template.json"
else
  sed "s|{{REPO_DIR}}|$REPO_DIR|g" "$REPO_DIR/global/settings.template.json" \
    > "$CLAUDE_DIR/settings.bsva-template.json"
fi

# ── base CLAUDE.md ──────────────────────────────────────────────────
log ""
log "→ installing base CLAUDE.md"
if [[ -f "$CLAUDE_DIR/CLAUDE.md" ]]; then
  do_cmd "cp '$CLAUDE_DIR/CLAUDE.md' '$BACKUP_DIR/CLAUDE.md'"
fi
do_cmd "cp '$REPO_DIR/global/CLAUDE.md' '$CLAUDE_DIR/CLAUDE.md'"

# ── department pick ────────────────────────────────────────────────
if [[ $SYNC_ONLY -eq 0 ]]; then
  log ""
  log "→ which department are you in?"
  log "    1) developer-relations"
  log "    2) technology"
  log "    3) education"
  log "    4) operations"
  log "    5) skip (set later with ./install.sh)"
  read -r -p "choice [1-5]: " dept_choice
  case "$dept_choice" in
    1) DEPT="developer-relations" ;;
    2) DEPT="technology" ;;
    3) DEPT="education" ;;
    4) DEPT="operations" ;;
    *) DEPT="" ;;
  esac
  if [[ -n "$DEPT" ]]; then
    do_cmd "echo '$DEPT' > '$CLAUDE_DIR/.bsva-department'"
    log "  ✓ department set: $DEPT"
    log "    department CLAUDE.md, skills, and templates live at:"
    log "    $REPO_DIR/departments/$DEPT/"
  fi
fi

# ── offer to wire the SessionStart hook into real settings.json ────
if [[ $SYNC_ONLY -eq 0 && $DRY_RUN -eq 0 && -f "$REPO_DIR/tutorial/install-hooks.py" ]]; then
  log ""
  log "→ wire SessionStart hook into ~/.claude/settings.json?"
  log "  This makes the tutorial + marketplace open automatically on your"
  log "  FIRST Claude session after install (once only — gated by a flag file)."
  log "  Your settings.json will be backed up before any change."
  read -r -p "Merge the hook now? [Y/n] " hook_choice
  case "${hook_choice:-Y}" in
    n|N|no|No|NO)
      log "  skipped. merge later with:  python3 $REPO_DIR/tutorial/install-hooks.py"
      ;;
    *)
      if command -v python3 &>/dev/null; then
        python3 "$REPO_DIR/tutorial/install-hooks.py" || log "  ⚠ hook merge failed; re-run manually."
      else
        log "  ⚠ python3 not found; re-run after installing:"
        log "    python3 $REPO_DIR/tutorial/install-hooks.py"
      fi
      # Reset the welcome flag so it fires on the next Claude session
      rm -f "$HOME/.claude/.bsva-welcome-shown" 2>/dev/null || true
      ;;
  esac
fi

# ── offer to merge BSVA MCP servers into real mcp.json ────────────
if [[ $SYNC_ONLY -eq 0 && $DRY_RUN -eq 0 && -f "$REPO_DIR/tutorial/install-mcps.py" ]]; then
  log ""
  log "→ wire BSVA's MCP servers into ~/.claude/mcp.json?"
  log "  Adds Nestr, simple-mcp, WhatsOnChain, and BSV Academy as servers Claude can call."
  log "  Your mcp.json will be backed up. Any custom servers you already have are preserved."
  log "  You'll still need to drop your Nestr API key in afterwards — we'll tell you exactly where."
  read -r -p "Merge the MCP servers now? [Y/n] " mcp_choice
  case "${mcp_choice:-Y}" in
    n|N|no|No|NO)
      log "  skipped. merge later with:  python3 $REPO_DIR/tutorial/install-mcps.py"
      ;;
    *)
      if command -v python3 &>/dev/null; then
        python3 "$REPO_DIR/tutorial/install-mcps.py" || log "  ⚠ MCP merge failed; re-run manually."
      else
        log "  ⚠ python3 not found; re-run after installing:"
        log "    python3 $REPO_DIR/tutorial/install-mcps.py"
      fi
      ;;
  esac
fi

log ""
log "✅ done."
log "   backups (if any): $BACKUP_DIR"
log ""
log "Next steps:"
log "  1. Fill in your Nestr API key in ~/.claude/mcp.json"
log "     (if you merged MCPs above, the merger told you exactly which lines)"
log ""
log "  2. Start Claude — tutorial + marketplace will open automatically on your"
log "     first session. Or open them right now:"
log "       $REPO_DIR/tutorial/start.sh              # tutorial"
log "       $REPO_DIR/tutorial/start.sh marketplace  # marketplace"
log ""
log "  3. Must-read before your first real work session:"
log "       $REPO_DIR/guides/for-humans/07-BEFORE-YOU-PASTE.md"
log ""

# ── offer to launch the tour right now too (belt-and-braces) ──────
if [[ $SYNC_ONLY -eq 0 && $DRY_RUN -eq 0 && -f "$REPO_DIR/tutorial/start.sh" ]]; then
  read -r -p "Open the tutorial + marketplace now (in addition to next-session hook)? [Y/n] " launch_choice
  case "${launch_choice:-Y}" in
    n|N|no|No|NO)
      log "Skipped. They'll open on your next Claude session."
      ;;
    *)
      log "Launching…"
      bash "$REPO_DIR/tutorial/welcome.sh" --force
      ;;
  esac
fi
