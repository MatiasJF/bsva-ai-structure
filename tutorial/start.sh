#!/usr/bin/env bash
# BSVA AI Guided Tour — launcher (macOS / Linux)
#
# Starts a tiny local HTTP server in this folder and opens the tutorial
# in your default browser. Partial-based HTML requires a server — the
# browser blocks fetch() from file:// for security.
#
# Usage:
#   ./start.sh            default port 8765; silent unless error
#   ./start.sh 9000       use port 9000 instead
#   ./start.sh --no-open  start server but don't auto-open browser

set -u

PORT="${1:-8765}"
NO_OPEN=0
if [[ "${1:-}" == "--no-open" ]]; then NO_OPEN=1; PORT=8765; fi
if [[ "${2:-}" == "--no-open" ]]; then NO_OPEN=1; fi

TUTORIAL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
URL="http://localhost:${PORT}/index.html"

log() { printf '%s\n' "$*"; }

pick_python() {
  if command -v python3 &>/dev/null; then echo "python3"; return 0; fi
  if command -v python  &>/dev/null; then echo "python";  return 0; fi
  return 1
}

open_url() {
  if [[ $NO_OPEN -eq 1 ]]; then return; fi
  # Try to open silently, never fail the launcher if it doesn't work
  (command -v open      &>/dev/null && open      "$URL" 2>/dev/null) ||
  (command -v xdg-open  &>/dev/null && xdg-open  "$URL" 2>/dev/null) ||
  (command -v wslview   &>/dev/null && wslview   "$URL" 2>/dev/null) || true
}

cd "$TUTORIAL_DIR" || { log "Can't cd to tutorial folder: $TUTORIAL_DIR"; exit 1; }

PY="$(pick_python)" || {
  cat <<EOF
Python is not installed, which is what this launcher uses to serve files.

You have two options:

  1. Install Python (macOS: 'brew install python3'; Linux: 'apt install python3').
     Then re-run this script.

  2. Use any other local HTTP server you have. For example:
       - Node:  npx serve .
       - PHP:   php -S localhost:${PORT}
     Then open: ${URL}

  3. Or open the plain text guides directly from:
       $(dirname "$TUTORIAL_DIR")/guides/for-humans/

EOF
  exit 1
}

log "BSVA AI Guided Tour"
log "  folder: $TUTORIAL_DIR"
log "  url:    $URL"
log "  python: $PY"
log ""
log "Opening in your browser. Press Ctrl+C to stop the server."
log ""

open_url &

# Run the server in the foreground so Ctrl+C works naturally
exec "$PY" -m http.server "$PORT" --bind 127.0.0.1
