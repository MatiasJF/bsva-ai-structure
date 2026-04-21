#!/usr/bin/env bash
# BSVA AI — welcome launcher (macOS / Linux)
#
# Runs ONCE after install: starts the local server, opens the tutorial
# and the marketplace in browser tabs, then returns. Gated by a flag
# file so repeated Claude sessions don't re-open the browser.
#
# Wired via the SessionStart hook in settings.bsva-template.json.
#
# Usage:
#   welcome.sh             one-shot (does nothing if already shown)
#   welcome.sh --force     ignore flag, open both tabs again
#   welcome.sh --reset     remove flag and exit (doesn't open anything)

set -u

FLAG="$HOME/.claude/.bsva-welcome-shown"
PORT=8765
FORCE=0

for arg in "$@"; do
  case "$arg" in
    --force) FORCE=1 ;;
    --reset) rm -f "$FLAG"; echo "cleared $FLAG"; exit 0 ;;
    -h|--help) sed -n '1,14p' "$0"; exit 0 ;;
  esac
done

# Already shown? bail silently so Claude's SessionStart isn't noisy.
if [[ $FORCE -eq 0 && -f "$FLAG" ]]; then
  exit 0
fi

TUTORIAL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$TUTORIAL_DIR/.." && pwd)"
TUTORIAL_URL="http://localhost:${PORT}/tutorial/index.html"
MARKET_URL="http://localhost:${PORT}/marketplace/index.html"

open_url() {
  local url="$1"
  (command -v open      &>/dev/null && open      "$url" 2>/dev/null) ||
  (command -v xdg-open  &>/dev/null && xdg-open  "$url" 2>/dev/null) ||
  (command -v wslview   &>/dev/null && wslview   "$url" 2>/dev/null) || true
}

server_is_up() {
  # quick 1-second probe; success if marketplace loads
  curl -sf --max-time 1 "http://127.0.0.1:${PORT}/tutorial/index.html" >/dev/null 2>&1
}

start_server_detached() {
  # Run start.sh in background; it execs into http.server after regenerating the index.
  mkdir -p "$HOME/.claude"
  local logfile="$HOME/.claude/bsva-welcome.log"
  nohup bash "$TUTORIAL_DIR/start.sh" --no-open --no-regen >"$logfile" 2>&1 &
  disown 2>/dev/null || true

  # Wait up to ~4s for the server to respond
  for _ in 1 2 3 4 5 6 7 8; do
    if server_is_up; then return 0; fi
    sleep 0.5
  done
  return 1
}

# Regenerate the marketplace index synchronously (quick; avoids showing stale data)
if command -v python3 &>/dev/null && [[ -f "$REPO_DIR/marketplace/generate_index.py" ]]; then
  python3 "$REPO_DIR/marketplace/generate_index.py" >/dev/null 2>&1 || true
fi

if ! server_is_up; then
  start_server_detached || {
    # Couldn't start a server — bail but still create the flag so we don't nag on every session.
    touch "$FLAG" 2>/dev/null || true
    exit 0
  }
fi

# Open both tabs (marketplace first — it's where people usually want to land)
open_url "$MARKET_URL"
sleep 0.3
open_url "$TUTORIAL_URL"

# Mark done
touch "$FLAG" 2>/dev/null || true

exit 0
