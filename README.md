# COBOL QUEST: The IRON-7090 Mainframe Chronicles

An interactive **retro mainframe RPG, live `PIC` & fixed-point laboratory, `.cob` code generator, and bug-hunting arcade** designed to make learning the **COBOL** programming language fun, visual, and hands-on — **written 100% in COBOL!**

```text
+====================================================================+
|   ___  ___  ___   ___  _        ___  _   _ ___ ___ _____           |
|  / __|/ _ \| _ ) / _ \| |      / _ \| | | | __/ __|_   _|          |
| | (__| (_) | _ \| (_) | |__   | (_) | |_| | _|\__ \ | |            |
|  \___|\___/|___/ \___/|____|   \__\_\\___/|___|___/ |_|   v1.0     |
|                                                                    |
|        IRON-7090 MAINFRAME CHRONICLES // WRITTEN IN COBOL!         |
+====================================================================+
```

---

## Quick Start on Windows (Zero Setup — Download & Play!)

You don't need to install any compiler to start playing right away:

1. Go to [**Releases**](https://github.com/kivenblake/COBOL-Learning/releases/latest) and download **`COBOL-Quest-Windows-x64.zip`**.
2. Right-click **`COBOL-Quest-Windows-x64.zip`** and click **Extract All...**
3. Open the extracted folder and double-click **`Play-COBOL-Quest.bat`** (or **`COBOL-Quest.exe`**)!

> **Terminal Tip:** Windows 11 Terminal and PowerShell support retro IBM phosphor ANSI colors automatically. If you ever run inside an older console window and want plain monochrome ASCII, just press **`C`** on the Main Menu!

---

## What You'll Do & Learn Inside COBOL QUEST

You are a newly badged **Mainframe Engineer** in Basement Sub-Level 4 tasked with bringing **8 offline COBOL cores** on Mainframe **IRON-7090** back online:

| Mode | Description |
| :--- | :--- |
| **`[1]` 8 Story Missions + Boss Battle** | Bite-sized visual lessons, diagnostic quizzes, and a **Live COBOL Coding Terminal (`CODE>`)** where you type real COBOL statements with smart syntax feedback — culminating in a 3-wave showdown against **`ABEND-S0C7`** during the Midnight Payroll Batch! |
| **`[2]` Interactive `PIC` & Math Lab** | Type any signed decimal (like `-2000.00` or `1234.567`) and watch real COBOL `MOVE` and `COMPUTE` statements format it across `PIC 9(6)`, raw 7-byte `PIC 9(5)V99` RAM (`REDEFINES`), `PIC $***,**9.99-` check protection, and `PIC ZZZ,ZZ9.99CR` accounting format! |
| **`[3]` Live `.cob` Code Generator** | Customize your own compound-interest program, watch COBOL write a real runnable **`my_sandbox.cob`** file to disk, and execute it live! |
| **`[4]` Bug Hunter Arcade** | Diagnose 4 famous real-world production mainframe bugs (rogue periods inside `IF`, Y2K `PIC 99` rollover, edited vs. operational `PIC`, and the Column-73 punch-card cliff) for bonus XP and ranks! |
| **`[5]` Pocket Reference Deck** | Built-in syntax cheat-sheets for Divisions, `PIC` symbols, Verbs, Loops, and Rear Admiral Grace Hopper's COBOL history. |
| **`[6]` Save & FD Record Inspector** | Progress auto-saves to **`savegame.dat`** using genuine COBOL `LINE SEQUENTIAL` file I/O — inspect the exact fixed-width byte slices right inside the app! |

---

## Companion COBOL Programs (`examples/`)

Every mission in the game has a matching, heavily-commented `.cob` source file in `examples/` (and precompiled `.exe` files in the Windows Release zip!):

1. **`examples/01-hello-mainframe.cob`** — Authentic 1960s 80-column Punch-Card Fixed-Format COBOL!
2. **`examples/02-pic-showcase.cob`** — `WORKING-STORAGE` & `PIC` check-protection / `CR` formatting
3. **`examples/03-verbs-and-move.cob`** — Left-aligned text vs. right-aligned numeric `MOVE` & truncation
4. **`examples/04-penny-perfect-bank.cob`** — Fixed-point `COMPUTE ... ROUNDED` & `ON SIZE ERROR`
5. **`examples/05-account-evaluator.cob`** — `88`-level condition ranges & `EVALUATE TRUE`
6. **`examples/06-perform-loops.cob`** — `PERFORM TIMES`, `PERFORM UNTIL`, and `PERFORM VARYING`
7. **`examples/07-branch-table.cob`** — 1-indexed `OCCURS` tables & quarterly revenue aggregation
8. **`examples/08-batch-payroll.cob`** — Sequential file batch job reading `examples/employees.dat`

---

## Compiling From Source (Optional — Edit & Build Your Own COBOL!)

Want to modify `src/cobol-quest.cob` or compile the `my_sandbox.cob` file you generated inside Mode `[3]`?

### Windows
1. Right-click **`scripts\install-gnucobol-windows.ps1`** and select **Run with PowerShell** (installs open-source **GnuCOBOL** via `winget` + MSYS2 and adds `cobc` to your `PATH`).
2. Double-click **`scripts\build-windows.bat`** to compile `COBOL-Quest.exe`, all 8 `examples\*.cob` programs, and `my_sandbox.cob`!

### Linux & macOS
```bash
# Ubuntu / Debian
sudo apt install gnucobol

# macOS (Homebrew)
brew install gnucobol

# Build & Launch COBOL QUEST:
./scripts/build-unix.sh

# Run the automated end-to-end test suite:
./tests/smoke-test.sh
```

---

## Project Structure

```text
COBOL-Learning/
├── Play-COBOL-Quest.bat             # Windows double-click launcher
├── src/
│   ├── cobol-quest.cob              # Main COBOL QUEST RPG & Interactive Tutor
│   └── copybooks/
│       ├── quest-state.cpy          # RPG ranks, XP, badges & REDEFINES table
│       ├── ansi-ui.cpy              # IBM 3270 phosphor ANSI color palette
│       ├── missions-proc.cpy        # 8 Story Missions + 3-Wave Boss Battle
│       └── labs-proc.cpy            # Live PIC Lab, Code Generator, Bug Arcade & Ref
├── examples/                        # 8 standalone runnable COBOL programs + data
├── scripts/                         # Windows (.bat/.ps1) & Unix (.sh) build helpers
└── tests/smoke-test.sh              # Automated full-playthrough & compiler test suite
```
