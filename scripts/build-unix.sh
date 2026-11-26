#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

# Include Apple Silicon & Intel macOS Homebrew / MacPorts paths
export PATH="/opt/homebrew/bin:/usr/local/bin:/opt/local/bin:$PATH"

if ! command -v cobc >/dev/null 2>&1; then
  echo "[ERROR] GnuCOBOL (cobc) is not installed yet."
  echo "  Auto-install (macOS & Linux): ./scripts/install-gnucobol-unix.sh"
  echo "  macOS (Homebrew)            : brew install gnucobol"
  echo "  Ubuntu / Debian             : sudo apt install gnucobol"
  echo "  Fedora                      : sudo dnf install gnucobol"
  echo "  Arch Linux                  : sudo pacman -S gnucobol"
  exit 1
fi

mkdir -p bin

echo "[1/3] Compiling COBOL QUEST (src/cobol-quest.cob)..."
cobc -x -Wall -I src/copybooks src/cobol-quest.cob -o bin/cobol-quest

echo "[2/3] Compiling all 8 companion COBOL examples..."
for src in examples/*.cob; do
  base="$(basename "$src" .cob)"
  cobc -x -Wall "$src" -o "bin/$base"
done

if [ -f "my_sandbox.cob" ]; then
  echo "[3/3] Compiling your generated my_sandbox.cob..."
  cobc -x -Wall my_sandbox.cob -o bin/my_sandbox
fi

if [ "${1:-}" = "--build-only" ]; then
  echo ""
  echo "[SUCCESS] Built ./bin/cobol-quest and all 8 examples!"
  exit 0
fi

echo ""
echo "[READY] Launching COBOL QUEST..."
exec ./bin/cobol-quest
