@echo off
setlocal
title Install GnuCOBOL Compiler ^(Windows^)
cd /d "%~dp0"

echo ====================================================================
echo  Launching Windows GnuCOBOL Installer ^(ExecutionPolicy Bypass^)...
echo ====================================================================
echo.

REM Remove Mark-of-the-Web on downloaded zip files if present, then run .ps1
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Unblock-File -Path '%~dp0install-gnucobol-windows.ps1' -ErrorAction SilentlyContinue"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0install-gnucobol-windows.ps1"

echo.
echo ====================================================================
echo  Installer finished ^(exit code: %ERRORLEVEL%^).
echo ====================================================================
pause
