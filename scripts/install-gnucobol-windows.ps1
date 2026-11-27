# ===================================================================
# install-gnucobol-windows.ps1
# Optional helper to install the GnuCOBOL compiler (cobc) on Windows
# so you can edit & compile your own .cob files locally!
#
# TIP: Double-click Install-GnuCOBOL-Windows.bat (in this same folder)
#      so Windows PowerShell ExecutionPolicy doesn't block this script!
# ===================================================================

$logFile = Join-Path $PSScriptRoot "..\install-gnucobol.log"

try {
    Write-Host "====================================================================" -ForegroundColor Cyan
    Write-Host "  COBOL QUEST: Optional Windows GnuCOBOL (cobc) Compiler Installer" -ForegroundColor Cyan
    Write-Host "====================================================================" -ForegroundColor Cyan
    Write-Host "NOTE: You do NOT need this to play COBOL QUEST! You can double-click" -ForegroundColor Gray
    Write-Host "      COBOL-Quest.exe in the main folder right now to play." -ForegroundColor Gray
    Write-Host "      This installer adds 'cobc' so you can compile your own .cob code.`n" -ForegroundColor Gray

    # Check common MSYS2 locations in case MSYS2 is installed but not on PATH yet
    $candidateBins = @(
        "C:\msys64\mingw64\bin",
        "C:\tools\msys64\mingw64\bin",
        "$env:LOCALAPPDATA\Programs\msys64\mingw64\bin",
        "$env:USERPROFILE\scoop\apps\msys2\current\mingw64\bin"
    )
    foreach ($binDir in $candidateBins) {
        if (Test-Path (Join-Path $binDir "cobc.exe")) {
            $env:Path = "$binDir;$env:Path"
            break
        }
    }

    if (Get-Command cobc -ErrorAction SilentlyContinue) {
        Write-Host "[OK] GnuCOBOL (cobc) is already installed!" -ForegroundColor Green
        & cobc --version | Select-Object -First 2
        $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
        $cobcDir = Split-Path (Get-Command cobc).Source -Parent
        if ($userPath -notlike "*$cobcDir*") {
            [Environment]::SetEnvironmentVariable("Path", "$cobcDir;$userPath", "User")
            Write-Host "Added $cobcDir to your Windows User PATH." -ForegroundColor Green
        }
        return
    }

    # Locate or install MSYS2
    $msysRoots = @(
        "C:\msys64",
        "C:\tools\msys64",
        "$env:LOCALAPPDATA\Programs\msys64"
    )
    $msysRoot = $msysRoots | Where-Object { Test-Path (Join-Path $_ "usr\bin\bash.exe") } | Select-Object -First 1

    if (-not $msysRoot) {
        if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
            throw "Windows Package Manager (winget) was not found. Please install MSYS2 manually from https://www.msys2.org/ and re-run this script."
        }

        Write-Host "[1/2] Installing MSYS2 via winget (this may take 1-2 minutes)..." -ForegroundColor Yellow
        & winget install --id MSYS2.MSYS2 --exact --source winget --accept-package-agreements --accept-source-agreements
        Write-Host "      winget finished with code $LASTEXITCODE." -ForegroundColor Gray

        $msysRoot = $msysRoots | Where-Object { Test-Path (Join-Path $_ "usr\bin\bash.exe") } | Select-Object -First 1
    }

    if (-not $msysRoot) {
        throw "MSYS2 bash.exe was not found in C:\msys64 after running winget. Please install MSYS2 from https://www.msys2.org/ (keep default C:\msys64 path) and re-run Install-GnuCOBOL-Windows.bat."
    }

    $msysBash = Join-Path $msysRoot "usr\bin\bash.exe"
    $mingwBin = Join-Path $msysRoot "mingw64\bin"

    Write-Host "[2/2] Installing mingw-w64-x86_64-gnucobol inside MSYS2 ($msysRoot)..." -ForegroundColor Yellow
    & $msysBash -lc "pacman -Sy --noconfirm mingw-w64-x86_64-gnucobol"
    if ($LASTEXITCODE -ne 0) {
        throw "MSYS2 pacman exited with code $LASTEXITCODE while installing mingw-w64-x86_64-gnucobol."
    }

    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($userPath -notlike "*$mingwBin*") {
        [Environment]::SetEnvironmentVariable("Path", "$mingwBin;$userPath", "User")
        Write-Host "Added $mingwBin to your Windows User PATH!" -ForegroundColor Green
    }
    $env:Path = "$mingwBin;$env:Path"

    if (Test-Path (Join-Path $mingwBin "cobc.exe")) {
        Write-Host "`n[SUCCESS] GnuCOBOL is now installed and ready!" -ForegroundColor Green
        & (Join-Path $mingwBin "cobc.exe") --version | Select-Object -First 2
        Write-Host "`nYou can now run scripts\build-windows.bat to compile .cob files!" -ForegroundColor Cyan
    } else {
        throw "Installation completed, but cobc.exe was not found in $mingwBin."
    }
}
catch {
    $errMsg = $_.Exception.Message
    Write-Host "`n====================================================================" -ForegroundColor Red
    Write-Host " [INSTALLER ERROR] $errMsg" -ForegroundColor Red
    Write-Host "====================================================================" -ForegroundColor Red
    Set-Content -Path $logFile -Value ("[" + (Get-Date -Format "u") + "] ERROR: " + ($_ | Out-String)) -Encoding UTF8
    Write-Host "Full error details were also saved to: $logFile" -ForegroundColor Yellow
}
finally {
    Write-Host ""
    [void](Read-Host "Press ENTER to close this window")
}
