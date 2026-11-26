#!/usr/bin/env bash
# ===================================================================
# install-gnucobol-unix.sh
# Cross-platform GnuCOBOL (cobc) installer for macOS & Linux!
# Supports Homebrew, MacPorts, apt, dnf, pacman, zypper, apk & xbps.
# ===================================================================
set -euo pipefail

# Include standard macOS Homebrew / MacPorts paths
export PATH="/opt/homebrew/bin:/usr/local/bin:/opt/local/bin:$PATH"

echo "=== COBOL QUEST: macOS & Linux GnuCOBOL Compiler Setup ==="

if command -v cobc >/dev/null 2>&1; then
  echo "[OK] GnuCOBOL is already installed!"
  cobc --version | head -n 1
  exit 0
fi

OS_NAME="$(uname -s)"

case "$OS_NAME" in
  Darwin)
    echo "[macOS Detected] Checking package managers..."
    if command -v brew >/dev/null 2>&1; then
      echo "-> Installing GnuCOBOL via Homebrew (brew install gnucobol)..."
      brew install gnucobol
    elif command -v port >/dev/null 2>&1; then
      echo "-> Installing GnuCOBOL via MacPorts (sudo port install gnucobol)..."
      sudo port install gnucobol
    else
      echo "[!] Homebrew was not found on this Mac."
      echo "    Install Homebrew first with:"
      echo '    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
      echo "    Then re-run ./Play-COBOL-Quest.command (or run: brew install gnucobol)"
      exit 1
    fi
    ;;

  Linux)
    echo "[Linux Detected] Detecting system package manager..."
    if command -v apt-get >/dev/null 2>&1; then
      echo "-> Installing via apt-get (Debian / Ubuntu / Mint / Pop!_OS / WSL)..."
      sudo apt-get update && sudo apt-get install -y gnucobol
    elif command -v dnf >/dev/null 2>&1; then
      echo "-> Installing via dnf (Fedora / RHEL / Rocky / AlmaLinux)..."
      sudo dnf install -y gnucobol
    elif command -v pacman >/dev/null 2>&1; then
      echo "-> Installing via pacman (Arch / Manjaro / EndeavourOS / SteamOS)..."
      sudo pacman -S --needed gnucobol
    elif command -v zypper >/dev/null 2>&1; then
      echo "-> Installing via zypper (openSUSE)..."
      sudo zypper install -y gnu-cobol
    elif command -v apk >/dev/null 2>&1; then
      echo "-> Installing via apk (Alpine Linux)..."
      sudo apk add gnucobol
    elif command -v xbps-install >/dev/null 2>&1; then
      echo "-> Installing via xbps-install (Void Linux)..."
      sudo xbps-install -S gnucobol
    else
      echo "[!] Could not auto-detect your Linux package manager."
      echo "    Please install the 'gnucobol' (or 'gnu-cobol') package using your distro's package manager."
      exit 1
    fi
    ;;

  *)
    echo "[!] Unsupported OS ($OS_NAME). On Windows, use Play-COBOL-Quest.bat or scripts/install-gnucobol-windows.ps1."
    exit 1
    ;;
esac

echo ""
if command -v cobc >/dev/null 2>&1; then
  echo "[SUCCESS] GnuCOBOL installed successfully!"
  cobc --version | head -n 1
else
  echo "[ERROR] Installation finished, but 'cobc' was not found on PATH."
  exit 1
fi
