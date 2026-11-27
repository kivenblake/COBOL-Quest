@echo off
setlocal
cd /d "%~dp0\.."

REM Automatically add C:\msys64\mingw64\bin if installed in the default location
if exist "C:\msys64\mingw64\bin\cobc.exe" (
    set "PATH=C:\msys64\mingw64\bin;%PATH%"
)
if exist "C:\tools\msys64\mingw64\bin\cobc.exe" (
    set "PATH=C:\tools\msys64\mingw64\bin;%PATH%"
)

where cobc >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ====================================================================
    echo  [ERROR] GnuCOBOL ^(cobc^) is not installed yet!
    echo ====================================================================
    echo  Note: To simply PLAY the game, double-click COBOL-Quest.exe in the
    echo        main folder ^(no compiler needed!^).
    echo.
    echo  To install the compiler for editing .cob files, double-click:
    echo        scripts\Install-GnuCOBOL-Windows.bat
    echo ====================================================================
    pause
    exit /b 1
)

if not exist "bin" mkdir "bin"

echo [1/3] Compiling COBOL QUEST ^(src\cobol-quest.cob^)...
cobc -x -Wall -I src\copybooks src\cobol-quest.cob -o bin\COBOL-Quest.exe
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Compilation of src\cobol-quest.cob failed.
    pause
    exit /b 1
)

if exist "runtime\windows-x64" (
    copy /Y "bin\COBOL-Quest.exe" "runtime\windows-x64\cobol-quest.exe" >nul
)

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
echo Double-click COBOL-Quest.exe ^(or Play-COBOL-Quest.bat^) to play!
pause
