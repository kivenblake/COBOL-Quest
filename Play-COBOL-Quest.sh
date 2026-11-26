#!/usr/bin/env bash
# ===================================================================
# Play-COBOL-Quest.sh
# Universal one-step launcher for Linux & macOS!
# - Runs prebuilt ./cobol-quest immediately if present & compatible
# - Otherwise compiles from src/cobol-quest.cob using cobc
# - Offers 1-step GnuCOBOL installation if cobc isn't installed yet!
# ===================================================================
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT_DIR"

# Ensure Apple Silicon & Intel Homebrew / MacPorts paths are included
export PATH="/opt/homebrew/bin:/usr/local/bin:/opt/local/bin:$PATH"

OS_ARCH="$(uname -s)-$(uname -m)"

# 1. Run prebuilt standalone Linux x86_64 binary if present & matching arch
if [ "$OS_ARCH" = "Linux-x86_64" ] && [ -x "$ROOT_DIR/cobol-quest" ]; then
  exec "$ROOT_DIR/cobol-quest"
fi

# 2. Run locally compiled ./bin/cobol-quest if already built
if [ -x "$ROOT_DIR/bin/cobol-quest" ]; then
  exec "$ROOT_DIR/bin/cobol-quest"
fi

# 3. If GnuCOBOL (cobc) is installed, compile in ~1 second and launch!
if command -v cobc >/dev/null 2>&1; then
  echo "[IRON-7090] Compiling COBOL QUEST from src/cobol-quest.cob ..."
  mkdir -p "$ROOT_DIR/bin"
  cobc -x -I "$ROOT_DIR/src/copybooks" "$ROOT_DIR/src/cobol-quest.cob" -o "$ROOT_DIR/bin/cobol-quest"
  exec "$ROOT_DIR/bin/cobol-quest"
fi

# 4. Offer automatic 1-step GnuCOBOL installation on macOS or Linux!
echo "===================================================================="
echo " GnuCOBOL (cobc) is not installed yet on this $(uname -s) system."
echo "===================================================================="
printf "Would you like to install GnuCOBOL automatically now and play? [Y/n]: "
read -r REPLY || REPLY="n"
case "${REPLY:-Y}" in
  [Yy]*|"")
    "$ROOT_DIR/scripts/install-gnucobol-unix.sh"
    echo "[IRON-7090] Compiling COBOL QUEST from src/cobol-quest.cob ..."
    mkdir -p "$ROOT_DIR/bin"
    cobc -x -I "$ROOT_DIR/src/copybooks" "$ROOT_DIR/src/cobol-quest.cob" -o "$ROOT_DIR/bin/cobol-quest"
    exec "$ROOT_DIR/bin/cobol-quest"
    ;;
  *)
    echo ""
    echo "No problem! Whenever you're ready, run:"
    echo "  ./scripts/install-gnucobol-unix.sh && ./Play-COBOL-Quest.sh"
    exit 1
    ;;
esac
