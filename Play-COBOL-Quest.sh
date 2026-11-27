#!/usr/bin/env bash
# ===================================================================
# Play-COBOL-Quest.sh
# Hardened launcher for Linux & macOS!
# - Works even if zip extraction stripped 'chmod +x' permissions
#   (can always be run via: bash Play-COBOL-Quest.sh)
# - Auto-restores +x on bundled Linux binary if stripped by unzipper
# - Catches & logs errors without closing the terminal window abruptly
# ===================================================================
set -uo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT_DIR"

# Ensure Apple Silicon (/opt/homebrew) & Intel (/usr/local) paths are included
export PATH="/opt/homebrew/bin:/usr/local/bin:/opt/local/bin:$PATH"

pause_on_error() {
  local code=$?
  echo ""
  echo "===================================================================="
  echo " [LAUNCHER ERROR] Exited with status $code."
  echo " Check install-gnucobol.log (if created) or the message above."
  echo "===================================================================="
  if [ -t 0 ]; then
    read -r -p "[Press ENTER to close...]" _ || true
  fi
  exit "$code"
}

OS_ARCH="$(uname -s)-$(uname -m)"

# 1. Run prebuilt zero-dependency Linux x86_64 binary if present!
#    (Auto-fixes chmod +x in case an archive extractor stripped permissions)
for lx_bin in "$ROOT_DIR/runtime/linux-x86_64/cobol-quest" "$ROOT_DIR/cobol-quest"; do
  if [ "$OS_ARCH" = "Linux-x86_64" ] && [ -f "$lx_bin" ]; then
    [ -x "$lx_bin" ] || chmod +x "$lx_bin" 2>/dev/null || true
    if [ -x "$lx_bin" ]; then
      "$lx_bin" || pause_on_error
      exit 0
    fi
  fi
done

# 2. Run locally compiled ./bin/cobol-quest if already built
if [ -f "$ROOT_DIR/bin/cobol-quest" ]; then
  [ -x "$ROOT_DIR/bin/cobol-quest" ] || chmod +x "$ROOT_DIR/bin/cobol-quest" 2>/dev/null || true
  if [ -x "$ROOT_DIR/bin/cobol-quest" ]; then
    "$ROOT_DIR/bin/cobol-quest" || pause_on_error
    exit 0
  fi
fi

# 3. If GnuCOBOL (cobc) is installed, compile in ~1 second and launch!
if command -v cobc >/dev/null 2>&1; then
  echo "[IRON-7090] Compiling COBOL QUEST from src/cobol-quest.cob ..."
  mkdir -p "$ROOT_DIR/bin"
  cobc -x -I "$ROOT_DIR/src/copybooks" "$ROOT_DIR/src/cobol-quest.cob" -o "$ROOT_DIR/bin/cobol-quest" || pause_on_error
  "$ROOT_DIR/bin/cobol-quest" || pause_on_error
  exit 0
fi

# 4. Offer automatic GnuCOBOL installation on macOS or Linux!
echo "===================================================================="
echo " GnuCOBOL (cobc) is not installed yet on this $(uname -s) system."
echo "===================================================================="
printf "Would you like to install GnuCOBOL automatically now and play? [Y/n]: "
read -r REPLY || REPLY="n"
case "${REPLY:-Y}" in
  [Yy]*|"")
    bash "$ROOT_DIR/scripts/install-gnucobol-unix.sh" || pause_on_error
    # Re-export Homebrew paths in case Homebrew was just installed on macOS
    export PATH="/opt/homebrew/bin:/usr/local/bin:/opt/local/bin:$PATH"
    echo "[IRON-7090] Compiling COBOL QUEST from src/cobol-quest.cob ..."
    mkdir -p "$ROOT_DIR/bin"
    cobc -x -I "$ROOT_DIR/src/copybooks" "$ROOT_DIR/src/cobol-quest.cob" -o "$ROOT_DIR/bin/cobol-quest" || pause_on_error
    "$ROOT_DIR/bin/cobol-quest" || pause_on_error
    ;;
  *)
    echo ""
    echo "No problem! Whenever you're ready, run:"
    echo "  bash scripts/install-gnucobol-unix.sh && bash Play-COBOL-Quest.sh"
    if [ -t 0 ]; then
      read -r -p "[Press ENTER to close...]" _ || true
    fi
    exit 1
    ;;
esac
