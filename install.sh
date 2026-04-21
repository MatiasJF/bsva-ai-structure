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

# ── flag parsing ────────────────────────────────────────────────────
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    --sync)    SYNC_ONLY=1 ;;
    -h|--help)
      sed -n '1,20p' "$0"; exit 0 ;;
    *) echo "unknown flag: $arg" >&2; exit 1 ;;
  esac
done

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

# ── settings template ───────────────────────────────────────────────
log ""
log "→ writing settings template to ~/.claude/settings.bsva-template.json"
do_cmd "cp '$REPO_DIR/global/settings.template.json' '$CLAUDE_DIR/settings.bsva-template.json'"
log "  merge the template into your ~/.claude/settings.json by hand (or with jq)"

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

log ""
log "✅ done."
log "   backups (if any): $BACKUP_DIR"
log ""
log "Next steps:"
log "  1. open the guided tour:   $REPO_DIR/tutorial/start.sh"
log "  2. read guides/for-humans/07-BEFORE-YOU-PASTE.md"
log "  3. merge ~/.claude/mcp.bsva-template.json into your MCP setup"
log "  4. when starting a new project, run: bsva-link  (see departments/<your-dept>/guides/)"
log ""

# ── offer to launch the guided tour on first install ──────────────
if [[ $SYNC_ONLY -eq 0 && $DRY_RUN -eq 0 && -f "$REPO_DIR/tutorial/start.sh" ]]; then
  log "The guided tour is an interactive HTML walkthrough of this structure."
  log "It takes about 10 minutes. Strongly recommended for first-time setup."
  read -r -p "Launch it now? [Y/n] " launch_choice
  case "${launch_choice:-Y}" in
    n|N|no|No|NO)
      log "Skipped. Re-run anytime: $REPO_DIR/tutorial/start.sh"
      ;;
    *)
      log "Launching tutorial…"
      exec "$REPO_DIR/tutorial/start.sh"
      ;;
  esac
fi
