#!/usr/bin/env bash
# ===================================================================
# Play-COBOL-Quest.command
# Double-click this file in macOS Finder to launch COBOL QUEST inside
# Terminal.app (works on both Apple Silicon M1-M4 and Intel Macs)!
# ===================================================================
cd "$(dirname "$0")"

# Set Terminal window title
printf '\033]0;COBOL QUEST // IRON-7090 Mainframe Chronicles\007'

./Play-COBOL-Quest.sh
EXIT_CODE=$?

echo ""
read -r -p "[Press ENTER to close terminal window...]" _ || true
exit $EXIT_CODE
