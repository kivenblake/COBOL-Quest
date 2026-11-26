# ===================================================================
# install-gnucobol-windows.ps1
# Optional helper to install the GnuCOBOL compiler (cobc) on Windows
# so you can edit & compile your own .cob files locally!
# ===================================================================
$ErrorActionPreference = "Stop"

Write-Host "=== COBOL QUEST: Windows GnuCOBOL Compiler Setup ===" -ForegroundColor Cyan

if (Get-Command cobc -ErrorAction SilentlyContinue) {
    Write-Host "[OK] GnuCOBOL is already installed!" -ForegroundColor Green
    cobc --version
    exit 0
}

$msysBash = "C:\msys64\usr\bin\bash.exe"
if (-not (Test-Path $msysBash)) {
    Write-Host "[1/2] Installing MSYS2 via Windows Package Manager (winget)..." -ForegroundColor Yellow
    winget install -e --id MSYS2.MSYS2 --accept-package-agreements --accept-source-agreements
}

if (Test-Path $msysBash) {
    Write-Host "[2/2] Installing GnuCOBOL (mingw-w64-x86_64-gnucobol) inside MSYS2..." -ForegroundColor Yellow
    & $msysBash -lc "pacman -Syu --noconfirm && pacman -S --noconfirm mingw-w64-x86_64-gnucobol"

    $mingwBin = "C:\msys64\mingw64\bin"
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($userPath -notlike "*$mingwBin*") {
        [Environment]::SetEnvironmentVariable("Path", "$mingwBin;$userPath", "User")
        Write-Host "Added $mingwBin to your User PATH!" -ForegroundColor Green
    }
    $env:Path = "$mingwBin;$env:Path"
    Write-Host "`n[SUCCESS] GnuCOBOL installed! Open a new terminal and run: cobc --version" -ForegroundColor Green
} else {
    Write-Host "Could not find C:\msys64. Please install MSYS2 from https://www.msys2.org/ and run:" -ForegroundColor Red
    Write-Host "  pacman -S mingw-w64-x86_64-gnucobol" -ForegroundColor Yellow
}
