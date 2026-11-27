#!/usr/bin/env bash
# ===================================================================
# install-gnucobol-unix.sh
# Cross-platform GnuCOBOL (cobc) installer for macOS & Linux!
# Logs output to install-gnucobol.log if anything fails and offers
# automatic Homebrew bootstrap on fresh Macs.
# ===================================================================
set -uo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG_FILE="$ROOT_DIR/install-gnucobol.log"

export PATH="/opt/homebrew/bin:/usr/local/bin:/opt/local/bin:$PATH"

echo "=== COBOL QUEST: macOS & Linux GnuCOBOL Compiler Setup ==="

if command -v cobc >/dev/null 2>&1; then
  echo "[OK] GnuCOBOL is already installed!"
  cobc --version | head -n 1
  exit 0
fi

OS_NAME="$(uname -s)"
STATUS=0

case "$OS_NAME" in
  Darwin)
    echo "[macOS Detected] Checking package managers..."
    if ! command -v brew >/dev/null 2>&1 && ! command -v port >/dev/null 2>&1; then
      echo "[!] Neither Homebrew nor MacPorts was found on this Mac."
      echo "    (Note: Installing Homebrew may prompt for your Mac password and"
      echo "     Apple's Xcode Command Line Tools on a brand-new Mac.)"
      printf "    Would you like to install Homebrew automatically now? [Y/n]: "
      read -r BREW_REPLY || BREW_REPLY="n"
      case "${BREW_REPLY:-Y}" in
        [Yy]*|"")
          /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || STATUS=$?
          export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
          ;;
        *)
          echo "    Install Homebrew anytime from https://brew.sh and re-run!"
          exit 1
          ;;
      esac
    fi

    if [ "$STATUS" -eq 0 ] && command -v brew >/dev/null 2>&1; then
      echo "-> Installing GnuCOBOL via Homebrew (brew install gnucobol)..."
      brew install gnucobol 2>&1 | tee "$LOG_FILE"
      STATUS=${PIPESTATUS[0]}
    elif [ "$STATUS" -eq 0 ] && command -v port >/dev/null 2>&1; then
      echo "-> Installing GnuCOBOL via MacPorts (sudo port install gnucobol)..."
      sudo port install gnucobol 2>&1 | tee "$LOG_FILE"
      STATUS=${PIPESTATUS[0]}
    fi
    ;;

  Linux)
    echo "[Linux Detected] Detecting system package manager..."
    if command -v apt-get >/dev/null 2>&1; then
      echo "-> Installing via apt-get (Debian / Ubuntu / Mint / Pop!_OS / WSL)..."
      (sudo apt-get update && sudo apt-get install -y gnucobol) 2>&1 | tee "$LOG_FILE"
      STATUS=${PIPESTATUS[0]}
    elif command -v dnf >/dev/null 2>&1; then
      echo "-> Installing via dnf (Fedora / RHEL / Rocky / AlmaLinux)..."
      sudo dnf install -y gnucobol 2>&1 | tee "$LOG_FILE"
      STATUS=${PIPESTATUS[0]}
    elif command -v pacman >/dev/null 2>&1; then
      echo "-> Installing via pacman (Arch / Manjaro / EndeavourOS / SteamOS)..."
      sudo pacman -S --needed gnucobol 2>&1 | tee "$LOG_FILE"
      STATUS=${PIPESTATUS[0]}
    elif command -v zypper >/dev/null 2>&1; then
      echo "-> Installing via zypper (openSUSE)..."
      sudo zypper install -y gnu-cobol 2>&1 | tee "$LOG_FILE"
      STATUS=${PIPESTATUS[0]}
    elif command -v apk >/dev/null 2>&1; then
      echo "-> Installing via apk (Alpine Linux)..."
      sudo apk add gnucobol 2>&1 | tee "$LOG_FILE"
      STATUS=${PIPESTATUS[0]}
    elif command -v xbps-install >/dev/null 2>&1; then
      echo "-> Installing via xbps-install (Void Linux)..."
      sudo xbps-install -S gnucobol 2>&1 | tee "$LOG_FILE"
      STATUS=${PIPESTATUS[0]}
    else
      echo "[!] Could not auto-detect your Linux package manager."
      echo "    Please install 'gnucobol' (or 'gnu-cobol') using your distro's package manager."
      exit 1
    fi
    ;;

  *)
    echo "[!] Unsupported OS ($OS_NAME). On Windows, double-click COBOL-Quest.exe or scripts/Install-GnuCOBOL-Windows.bat."
    exit 1
    ;;
esac

echo ""
if [ "$STATUS" -eq 0 ] && command -v cobc >/dev/null 2>&1; then
  rm -f "$LOG_FILE"
  echo "[SUCCESS] GnuCOBOL installed successfully!"
  cobc --version | head -n 1
  exit 0
else
  echo "[ERROR] GnuCOBOL installation exited with status $STATUS."
  echo "        Details saved to: $LOG_FILE"
  exit 1
fi
