/* ===================================================================
 * win-launcher.c
 * Lightweight Win32 root launcher (COBOL-Quest.exe) that:
 *   1. Enables ANSI Virtual Terminal colors in Windows Console Host
 *   2. Adds .\runtime\windows-x64 (containing libcob-4.dll) to PATH
 *   3. Executes .\runtime\windows-x64\cobol-quest.exe (compiled from
 *      100% COBOL source in src\cobol-quest.cob) in the repo root!
 * =================================================================== */
#ifndef UNICODE
#define UNICODE
#endif
#ifndef _UNICODE
#define _UNICODE
#endif
#include <windows.h>
#include <stdio.h>
#include <wchar.h>

#ifndef ENABLE_VIRTUAL_TERMINAL_PROCESSING
#define ENABLE_VIRTUAL_TERMINAL_PROCESSING 0x0004
#endif

int wmain(void) {
    SetConsoleTitleW(L"COBOL QUEST // IRON-7090 Mainframe Chronicles");

    /* 1. Enable ANSI color escape sequences on Windows 10/11 consoles */
    HANDLE hOut = GetStdHandle(STD_OUTPUT_HANDLE);
    if (hOut != INVALID_HANDLE_VALUE) {
        DWORD dwMode = 0;
        if (GetConsoleMode(hOut, &dwMode)) {
            SetConsoleMode(hOut, dwMode | ENABLE_VIRTUAL_TERMINAL_PROCESSING);
        }
    }

    /* 2. Resolve the directory containing COBOL-Quest.exe (handles spaces!) */
    wchar_t exePath[MAX_PATH * 2];
    DWORD len = GetModuleFileNameW(NULL, exePath, MAX_PATH * 2);
    if (len == 0 || len >= MAX_PATH * 2) {
        fwprintf(stderr, L"[ERROR] Could not resolve executable path.\n");
        return 1;
    }

    wchar_t *lastSlash = wcsrchr(exePath, L'\\');
    if (lastSlash) {
        *lastSlash = L'\0';
    }

    /* 3. Prepend <root>\runtime\windows-x64 to PATH so libcob-4.dll loads */
    wchar_t runtimeDir[MAX_PATH * 2];
    _snwprintf(runtimeDir, MAX_PATH * 2, L"%ls\\runtime\\windows-x64", exePath);

    wchar_t oldPath[32767];
    DWORD pathLen = GetEnvironmentVariableW(L"PATH", oldPath, 32767);
    wchar_t newPath[32767];
    if (pathLen > 0 && pathLen < 32767) {
        _snwprintf(newPath, 32767, L"%ls;%ls", runtimeDir, oldPath);
    } else {
        _snwprintf(newPath, 32767, L"%ls", runtimeDir);
    }
    SetEnvironmentVariableW(L"PATH", newPath);

    /* 4. Locate compiled COBOL binary (<root>\bin\COBOL-Quest-Core.exe or runtime) */
    wchar_t targetExe[MAX_PATH * 2];
    _snwprintf(targetExe, MAX_PATH * 2, L"%ls\\runtime\\windows-x64\\cobol-quest.exe", exePath);

    wchar_t cmdLine[MAX_PATH * 2 + 4];
    _snwprintf(cmdLine, MAX_PATH * 2 + 4, L"\"%ls\"", targetExe);

    STARTUPINFOW si;
    PROCESS_INFORMATION pi;
    ZeroMemory(&si, sizeof(si));
    si.cb = sizeof(si);
    ZeroMemory(&pi, sizeof(pi));

    if (!CreateProcessW(
            targetExe,
            cmdLine,
            NULL,
            NULL,
            TRUE,
            0,
            NULL,
            exePath,
            &si,
            &pi)) {
        DWORD err = GetLastError();
        fwprintf(stderr,
            L"\n[ERROR] Could not start %ls (Win32 error %lu).\n"
            L"Make sure you extracted the entire folder (including runtime\\windows-x64)!\n",
            targetExe, err);
        fwprintf(stdout, L"\n[Press ENTER to close window...]");
        fflush(stdout);
        getwchar();
        return 1;
    }

    WaitForSingleObject(pi.hProcess, INFINITE);
    DWORD exitCode = 0;
    GetExitCodeProcess(pi.hProcess, &exitCode);
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);

    /* If launched via Explorer double-click (sole process in console), pause cleanly */
    DWORD procList[2];
    if (GetConsoleProcessList(procList, 2) <= 1) {
        fwprintf(stdout, L"[Press ENTER to close window...]");
        fflush(stdout);
        getwchar();
    }

    return (int)exitCode;
}
