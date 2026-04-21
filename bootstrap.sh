#!/usr/bin/env bash
# BSVA AI — prerequisite bootstrap (macOS / Linux)
#
# Detects what's missing and offers to install:
#   • git         — required to clone and update this repo
#   • python 3    — required by the installer, launcher, scanner, and merger
#   • a browser   — almost everyone has one; we just note it
#
# Does NOT install Claude Code — that's provisioned by BSVA IT or
# installed manually via https://claude.com/claude-code (the install
# path differs by account type).
#
# Uses the native package manager (no curl-to-bash, no downloads from
# random URLs). You'll be prompted before each install. sudo is used
# only when the package manager requires it.
#
# Usage:
#   ./bootstrap.sh              interactive; asks before each install
#   ./bootstrap.sh --yes        auto-answer yes to install prompts
#   ./bootstrap.sh --check      report status only, don't install

set -u

CHECK_ONLY=0
AUTO_YES=0
for arg in "$@"; do
  case "$arg" in
    --check) CHECK_ONLY=1 ;;
    --yes|-y) AUTO_YES=1 ;;
    -h|--help) sed -n '1,22p' "$0"; exit 0 ;;
    *) echo "unknown flag: $arg" >&2; exit 1 ;;
  esac
done

# ── colors (fall back to plain text if tty not detected) ──────────
if [[ -t 1 ]]; then
  DIM=$'\e[2m'; BOLD=$'\e[1m'; OK=$'\e[32m'; WARN=$'\e[33m'; ERR=$'\e[31m'; RESET=$'\e[0m'
else
  DIM=""; BOLD=""; OK=""; WARN=""; ERR=""; RESET=""
fi

log()  { printf '%s\n' "$*"; }
ok()   { printf '%s✓%s %s\n' "$OK" "$RESET" "$*"; }
warn() { printf '%s⚠%s %s\n' "$WARN" "$RESET" "$*"; }
fail() { printf '%s✗%s %s\n' "$ERR" "$RESET" "$*"; }

confirm() {
  # usage: confirm "Install X?" → 0 if yes, 1 if no
  local prompt="$1"
  if [[ $AUTO_YES -eq 1 ]]; then return 0; fi
  read -r -p "$prompt [Y/n] " ans
  case "${ans:-Y}" in n|N|no|No|NO) return 1 ;; *) return 0 ;; esac
}

have() { command -v "$1" &>/dev/null; }

# ── detect OS + package manager ───────────────────────────────────
OS=""; PM=""; PM_UPDATE=""; PM_INSTALL=""; SUDO=""
uname_s="$(uname -s 2>/dev/null || echo unknown)"
case "$uname_s" in
  Darwin) OS="macos" ;;
  Linux)  OS="linux" ;;
  *)      OS="$uname_s" ;;
esac

if [[ "$OS" == "macos" ]]; then
  if have brew; then
    PM="brew"
    PM_UPDATE="brew update"
    PM_INSTALL="brew install"
  fi
elif [[ "$OS" == "linux" ]]; then
  SUDO="$([[ $EUID -ne 0 ]] && echo 'sudo' || echo '')"
  if   have apt-get; then PM="apt";    PM_UPDATE="$SUDO apt-get update";         PM_INSTALL="$SUDO apt-get install -y"
  elif have dnf;     then PM="dnf";    PM_UPDATE="$SUDO dnf -y check-update || true"; PM_INSTALL="$SUDO dnf install -y"
  elif have yum;     then PM="yum";    PM_UPDATE="$SUDO yum check-update || true";    PM_INSTALL="$SUDO yum install -y"
  elif have pacman;  then PM="pacman"; PM_UPDATE="$SUDO pacman -Sy";             PM_INSTALL="$SUDO pacman -S --noconfirm"
  elif have zypper;  then PM="zypper"; PM_UPDATE="$SUDO zypper refresh";         PM_INSTALL="$SUDO zypper install -y"
  elif have apk;     then PM="apk";    PM_UPDATE="$SUDO apk update";             PM_INSTALL="$SUDO apk add"
  fi
fi

# ── header ────────────────────────────────────────────────────────
log "${BOLD}BSVA AI — prerequisite check${RESET}"
log "  os:       $OS"
log "  pkg mgr:  ${PM:-${WARN}none detected${RESET}}"
log "  mode:     $([[ $CHECK_ONLY -eq 1 ]] && echo check-only || echo interactive)"
log ""

# ── macOS: offer to install Homebrew if absent ────────────────────
if [[ "$OS" == "macos" && -z "$PM" ]]; then
  warn "Homebrew not found — it's the standard macOS package manager."
  log "  Install instructions (requires admin password):"
  log "  ${DIM}/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"${RESET}"
  log ""
  if [[ $CHECK_ONLY -eq 0 ]]; then
    if confirm "Open the Homebrew install page in your browser?"; then
      open "https://brew.sh" 2>/dev/null
    fi
    warn "Re-run ./bootstrap.sh after Homebrew is installed."
  fi
  exit 1
fi

# ── per-tool checks ────────────────────────────────────────────────
MISSING=()

check_git() {
  if have git; then
    ok "git   → $(git --version | head -1)"
  else
    warn "git   → not installed"
    MISSING+=("git")
  fi
}

check_python() {
  local py=""
  have python3 && py="python3"
  [[ -z "$py" ]] && have python && py="python"
  if [[ -n "$py" ]]; then
    local ver; ver="$("$py" -c 'import sys; print(sys.version.split()[0])' 2>/dev/null || echo unknown)"
    # require 3.7+
    if [[ "$ver" == "unknown" || "$ver" == 2.* ]]; then
      warn "python3 → found $py ($ver); need Python 3.7+"
      MISSING+=("python3")
    else
      ok "python → $py $ver"
    fi
  else
    warn "python → not installed"
    MISSING+=("python3")
  fi
}

check_browser() {
  # Best-effort. On macOS there's always Safari; on Linux xdg-open
  # will find something; otherwise we note it.
  if [[ "$OS" == "macos" ]]; then
    ok "browser → (system default via \`open\`)"
  elif have xdg-open; then
    ok "browser → (system default via \`xdg-open\`)"
  else
    warn "browser → no \`xdg-open\` found; please make sure a browser is set as your desktop default"
  fi
}

check_claude() {
  if have claude; then
    ok "claude (CLI) → $(claude --version 2>/dev/null | head -1 || echo present)"
  else
    warn "claude (CLI) → not on PATH (Desktop app is fine too; see https://claude.com/claude-code)"
  fi
}

log "${BOLD}Checking required tools…${RESET}"
check_git
check_python
check_browser
log ""
log "${BOLD}Checking optional tools…${RESET}"
check_claude
log ""

# ── install missing ───────────────────────────────────────────────
if [[ ${#MISSING[@]} -eq 0 ]]; then
  ok "All required tools are present. You're good to run ${BOLD}./install.sh${RESET}"
  exit 0
fi

if [[ $CHECK_ONLY -eq 1 ]]; then
  warn "Missing: ${MISSING[*]}"
  log "  Re-run without --check to be offered installs."
  exit 1
fi

if [[ -z "$PM" ]]; then
  fail "No supported package manager detected."
  log "  Please install the missing tools manually: ${MISSING[*]}"
  exit 1
fi

log "${BOLD}Installing missing tools via $PM${RESET}"
log ""

# Map generic names to PM-specific packages
pkg_for() {
  local tool="$1"
  case "$PM:$tool" in
    brew:git)    echo "git" ;;
    brew:python3) echo "python@3.12" ;;
    apt:git)     echo "git" ;;
    apt:python3) echo "python3" ;;
    dnf:git)     echo "git" ;;
    dnf:python3) echo "python3" ;;
    yum:git)     echo "git" ;;
    yum:python3) echo "python3" ;;
    pacman:git)     echo "git" ;;
    pacman:python3) echo "python" ;;
    zypper:git)     echo "git" ;;
    zypper:python3) echo "python3" ;;
    apk:git)     echo "git" ;;
    apk:python3) echo "python3" ;;
    *) echo "$tool" ;;
  esac
}

# Update indices once (for apt/pacman/apk). Safe no-op on brew.
[[ -n "${PM_UPDATE// }" ]] && {
  log "$DIM→ $PM_UPDATE$RESET"
  eval "$PM_UPDATE" || warn "package index update returned non-zero (continuing)"
  log ""
}

for tool in "${MISSING[@]}"; do
  pkg="$(pkg_for "$tool")"
  if confirm "Install $BOLD$tool$RESET ($DIM$pkg via $PM$RESET)?"; then
    log "$DIM→ $PM_INSTALL $pkg$RESET"
    if eval "$PM_INSTALL $pkg"; then
      ok "$tool installed"
    else
      fail "$tool install failed — please install it manually."
    fi
  else
    warn "skipped $tool (you'll need to install it before ./install.sh)"
  fi
  log ""
done

# ── final status ──────────────────────────────────────────────────
log "${BOLD}Re-checking…${RESET}"
MISSING=()
check_git
check_python
log ""

if [[ ${#MISSING[@]} -eq 0 ]]; then
  ok "All required tools now present. Run:"
  log "  ${BOLD}./install.sh${RESET}"
  exit 0
else
  warn "Still missing: ${MISSING[*]}"
  log "  Install them manually, then run: ./install.sh"
  exit 1
fi
