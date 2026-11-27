#!/usr/bin/env bash
# ===================================================================
# Play-COBOL-Quest.command
# Double-click this file in macOS Finder to launch COBOL QUEST inside
# Terminal.app (works on both Apple Silicon M1-M4 and Intel Macs)!
# Uses 'bash ./Play-COBOL-Quest.sh' so it works even if +x was lost!
# ===================================================================
cd "$(dirname "$0")" || exit 1

# Remove macOS quarantine attribute on sibling scripts if present
xattr -d com.apple.quarantine ./Play-COBOL-Quest.sh ./scripts/*.sh 2>/dev/null || true

# Set Terminal window title
printf '\033]0;COBOL QUEST // IRON-7090 Mainframe Chronicles\007'

bash ./Play-COBOL-Quest.sh
EXIT_CODE=$?

echo ""
read -r -p "[Press ENTER to close terminal window...]" _ || true
exit $EXIT_CODE
