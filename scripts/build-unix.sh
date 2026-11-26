#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

if ! command -v cobc >/dev/null 2>&1; then
  echo "[ERROR] GnuCOBOL (cobc) is not installed."
  echo "  macOS : brew install gnucobol"
  echo "  Ubuntu: sudo apt install gnucobol"
  exit 1
fi

mkdir -p bin

echo "[1/2] Compiling COBOL QUEST (src/cobol-quest.cob)..."
cobc -x -Wall -I src/copybooks src/cobol-quest.cob -o bin/cobol-quest

echo "[2/2] Compiling all 8 companion COBOL examples..."
for src in examples/*.cob; do
  base="$(basename "$src" .cob)"
  cobc -x -Wall "$src" -o "bin/$base"
done

echo ""
echo "[READY] Launching COBOL QUEST..."
exec ./bin/cobol-quest
