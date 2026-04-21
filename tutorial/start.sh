#!/usr/bin/env bash
# BSVA AI — local browser launcher (macOS / Linux)
#
# Opens the guided tour OR the marketplace in your default browser.
# Runs a small local HTTP server at the repo root (partials require a
# server — browsers block fetch() from file://).
#
# Usage:
#   ./start.sh                        open the tour (default)
#   ./start.sh marketplace            open the marketplace
#   ./start.sh tour 9000              tour on port 9000
#   ./start.sh marketplace 9000       marketplace on port 9000
#   ./start.sh --no-open              don't auto-open the browser
#   ./start.sh --no-regen             skip the marketplace scanner

set -u

TARGET="tour"
PORT="8765"
NO_OPEN=0
REGEN=1

for arg in "$@"; do
  case "$arg" in
    tour|marketplace) TARGET="$arg" ;;
    --no-open) NO_OPEN=1 ;;
    --no-regen) REGEN=0 ;;
    [0-9]*) PORT="$arg" ;;
    -h|--help) sed -n '1,20p' "$0"; exit 0 ;;
  esac
done

TUTORIAL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$TUTORIAL_DIR/.." && pwd)"

if [[ "$TARGET" == "marketplace" ]]; then
  URL="http://localhost:${PORT}/marketplace/index.html"
else
  URL="http://localhost:${PORT}/tutorial/index.html"
fi

log() { printf '%s\n' "$*"; }

pick_python() {
  if command -v python3 &>/dev/null; then echo "python3"; return 0; fi
  if command -v python  &>/dev/null; then echo "python";  return 0; fi
  return 1
}

open_url() {
  if [[ $NO_OPEN -eq 1 ]]; then return; fi
  (command -v open      &>/dev/null && open      "$URL" 2>/dev/null) ||
  (command -v xdg-open  &>/dev/null && xdg-open  "$URL" 2>/dev/null) ||
  (command -v wslview   &>/dev/null && wslview   "$URL" 2>/dev/null) || true
}

cd "$REPO_DIR" || { log "Can't cd to repo folder: $REPO_DIR"; exit 1; }

PY="$(pick_python)" || {
  cat <<EOF
Python is not installed, which is what this launcher uses to serve files.

Options:
  1. Install Python and re-run.
     macOS: brew install python3
     Linux: apt/yum/dnf install python3
  2. Use any other local HTTP server from this folder, e.g.:
       npx serve .
       php -S localhost:${PORT}
     Then open: ${URL}

EOF
  exit 1
}

# Regenerate the marketplace index (fresh every launch)
if [[ $REGEN -eq 1 && -f "$REPO_DIR/marketplace/generate_index.py" ]]; then
  "$PY" "$REPO_DIR/marketplace/generate_index.py" || log "⚠ marketplace scanner failed (continuing anyway)"
fi

log ""
log "BSVA AI — ${TARGET}"
log "  serving: $REPO_DIR"
log "  url:     $URL"
log "  python:  $PY"
log ""
log "Press Ctrl+C to stop the server."
log ""

open_url &

exec "$PY" -m http.server "$PORT" --bind 127.0.0.1
