@echo off
setlocal
title COBOL QUEST // IRON-7090 Mainframe Chronicles
cd /d "%~dp0"

REM Enable ANSI colors in legacy Windows Console Host if needed
reg add HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>nul

REM Ensure bundled runtime DLLs in .\runtime (if present) are on PATH
if exist "%~dp0runtime" (
    set "PATH=%~dp0runtime;%~dp0;%PATH%"
)

REM 1. Run prebuilt COBOL-Quest.exe if present (from Release .zip!)
if exist "%~dp0COBOL-Quest.exe" (
    "%~dp0COBOL-Quest.exe"
    echo.
    pause
    exit /b 0
)

if exist "%~dp0bin\COBOL-Quest.exe" (
    "%~dp0bin\COBOL-Quest.exe"
    echo.
    pause
    exit /b 0
)

REM 2. Otherwise compile from COBOL source if GnuCOBOL (cobc) is installed
where cobc >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo [IRON-7090] Compiling COBOL QUEST from src\cobol-quest.cob ...
    if not exist "%~dp0bin" mkdir "%~dp0bin"
    cobc -x -I "%~dp0src\copybooks" "%~dp0src\cobol-quest.cob" -o "%~dp0bin\COBOL-Quest.exe"
    if %ERRORLEVEL% EQU 0 (
        "%~dp0bin\COBOL-Quest.exe"
        echo.
        pause
        exit /b 0
    )
)

echo ====================================================================
echo  COBOL-Quest.exe was not found and GnuCOBOL ^(cobc^) is not on PATH.
echo ====================================================================
echo  EASIEST OPTION ^(Zero Setup^):
echo    Download COBOL-Quest-Windows-x64.zip from the GitHub Releases
echo    page, unzip it, and double-click Play-COBOL-Quest.bat!
echo.
echo  OR INSTALL GNUCOBOL COMPILER LOCALLY:
echo    Right-click scripts\install-gnucobol-windows.ps1 and choose
echo    "Run with PowerShell", then run scripts\build-windows.bat.
echo ====================================================================
pause
exit /b 1
