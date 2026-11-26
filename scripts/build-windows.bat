@echo off
setlocal
cd /d "%~dp0\.."

where cobc >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] GnuCOBOL ^(cobc^) is not on your PATH yet.
    echo Run scripts\install-gnucobol-windows.ps1 in PowerShell to install it!
    pause
    exit /b 1
)

if not exist "bin" mkdir "bin"

echo [1/3] Compiling COBOL QUEST ^(src\cobol-quest.cob^)...
cobc -x -Wall -I src\copybooks src\cobol-quest.cob -o bin\COBOL-Quest.exe
if %ERRORLEVEL% NEQ 0 exit /b %ERRORLEVEL%

echo [2/3] Compiling all 8 companion examples ^(examples\*.cob^)...
for %%F in (examples\*.cob) do (
    echo       Building %%~nF.exe ...
    cobc -x -Wall "%%F" -o "bin\%%~nF.exe"
)

if exist "my_sandbox.cob" (
    echo [3/3] Compiling your generated my_sandbox.cob ...
    cobc -x -Wall my_sandbox.cob -o bin\my_sandbox.exe
)

echo.
echo [SUCCESS] Built bin\COBOL-Quest.exe and all example programs!
echo Double-click Play-COBOL-Quest.bat to play!
pause
