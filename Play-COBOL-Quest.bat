@echo off
setlocal
title COBOL QUEST // IRON-7090 Mainframe Chronicles
cd /d "%~dp0"

REM Enable ANSI colors in legacy Windows Console Host if needed
reg add HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>nul

REM Ensure bundled GnuCOBOL runtime DLLs are on PATH
if exist "%~dp0runtime\windows-x64" (
    set "PATH=%~dp0runtime\windows-x64;%~dp0;%PATH%"
)
if exist "%~dp0runtime" (
    set "PATH=%~dp0runtime;%PATH%"
)

REM 1. Run prebuilt COBOL binary directly if present in runtime\windows-x64
if exist "%~dp0runtime\windows-x64\cobol-quest.exe" (
    "%~dp0runtime\windows-x64\cobol-quest.exe"
    echo.
    pause
    exit /b 0
)

REM 2. Run prebuilt COBOL-Quest.exe if present (standalone zip layout)
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

REM 3. Otherwise compile from COBOL source if GnuCOBOL (cobc) is installed
if exist "C:\msys64\mingw64\bin\cobc.exe" (
    set "PATH=C:\msys64\mingw64\bin;%PATH%"
)
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
echo  Double-click scripts\Install-GnuCOBOL-Windows.bat to install cobc,
echo  or pull the latest repo files so COBOL-Quest.exe is in this folder!
echo ====================================================================
pause
exit /b 1
