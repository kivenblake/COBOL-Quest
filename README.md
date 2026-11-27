# COBOL QUEST: The IRON-7090 Mainframe Chronicles

An interactive **retro mainframe RPG, live `PIC` & fixed-point laboratory, `.cob` code generator, and bug-hunting arcade** designed to make learning the **COBOL** programming language fun, visual, and hands-on — **written 100% in COBOL!**

```text
+====================================================================+
|   ___  ___  ___   ___  _        ___  _   _ ___ ___ _____           |
|  / __|/ _ \| _ ) / _ \| |      / _ \| | | | __/ __|_   _|          |
| | (__| (_) | _ \| (_) | |__   | (_) | |_| | _|\__ \ | |            |
|  \___|\___/|___/ \___/|____|   \__\_\\___/|___|___/ |_|   v1.1     |
|                                                                    |
|        IRON-7090 MAINFRAME CHRONICLES // WRITTEN IN COBOL!         |
+====================================================================+
```

---

## Quick Start — Choose Your Operating System

### 1. Windows (Zero Setup — Ready to Double-Click!)
- **If you downloaded or cloned this repository (`Code -> Download ZIP` or `git clone`):**
  - Open the folder and double-click **`COBOL-Quest.exe`** (or **`Play-COBOL-Quest.bat`**) right in the top folder — the compiled COBOL program and runtime are already bundled inside `runtime\windows-x64\`!
- **Or download the standalone release zip:**
  1. Download [**`COBOL-Quest-Windows-x64.zip`**](https://github.com/kivenblake/COBOL-Quest/raw/main/releases/COBOL-Quest-Windows-x64.zip) (3.3 MB).
  2. Right-click **`COBOL-Quest-Windows-x64.zip`** → **Extract All...**
  3. Double-click **`COBOL-Quest.exe`** (or **`Play-COBOL-Quest.bat`**)!

### 2. Linux (Zero Setup — Ready to Run!)
- **If you downloaded or cloned this repository (`Code -> Download ZIP` or `git clone`):**
  ```bash
  bash Play-COBOL-Quest.sh
  ```
  *(On `x86_64` Linux, this runs the bundled zero-dependency binary in `runtime/linux-x86_64/cobol-quest` immediately with **no `sudo` or compiler required**! On `ARM64` / Raspberry Pi, it automatically compiles from source or offers a 1-step `gnucobol` install.)*
- **Or download the standalone Linux archive:**
  ```bash
  curl -LO https://github.com/kivenblake/COBOL-Quest/raw/main/releases/COBOL-Quest-Linux-x86_64.tar.gz
  tar -xzf COBOL-Quest-Linux-x86_64.tar.gz
  cd COBOL-Quest-Linux-x86_64
  bash Play-COBOL-Quest.sh
  ```

### 3. macOS (Apple Silicon M1–M4 & Intel Macs)
- **Recommended — Terminal Launch (Bypasses Gatekeeper & `chmod` issues):**
  1. Download the repo (`Code -> Download ZIP` or [**`COBOL-Quest-macOS.zip`**](https://github.com/kivenblake/COBOL-Quest/raw/main/releases/COBOL-Quest-macOS.zip)) and unzip it.
  2. Open **Terminal**, `cd` into the folder, and run:
     ```bash
     bash Play-COBOL-Quest.sh
     ```
  3. If GnuCOBOL isn't installed yet, the launcher offers to install Homebrew (if needed) + `gnucobol`, compiles natively for your Mac in under a second, and starts the game!
- **Alternative — Double-Click in Finder:**
  - Double-click **`Play-COBOL-Quest.command`**. *(Note: macOS Gatekeeper blocks downloaded `.command` scripts on first open — if prompted, right-click `Play-COBOL-Quest.command` → **Open** → **Open**, or use `bash Play-COBOL-Quest.sh` in Terminal above.)*

### 4. Docker (Works on macOS, Linux & Windows — Zero Host Dependencies)
```bash
docker build -t cobol-quest .
docker run -it --rm cobol-quest
```

> **Terminal Tip:** Modern terminals on Windows 11, macOS, and Linux support retro IBM phosphor ANSI colors out of the box. If you ever run in a plain monochrome console, press **`C`** on the Main Menu!

---

## What You'll Do & Learn Inside COBOL QUEST

Designed for someone with **zero prior programming experience**, COBOL QUEST guides you from writing your very first `DISPLAY` line all the way to batch file processing:

| Mode | Description |
| :--- | :--- |
| **`[1]` Zero-to-Master Curriculum (8 Chapters)** | Multi-page plain-English lessons (no prior coding jargon!), **2-variant Concept Quizzes** (wrong answers give a full explanation + a fresh follow-up question), and **3-variant Adaptive Coding Drills** with **non-spoiler `HINT` clues** and **2-try productive-failure walkthroughs** that explain why a solution works and rotate to a new variant for you to solve solo! |
| **`[2]` Interactive `PIC` & Math Lab** | Type any signed decimal (like `-2000.00` or `1234.567`) and watch real COBOL `MOVE` and `COMPUTE` statements format it across `PIC 9(6)`, raw 7-byte `PIC 9(5)V99` RAM (`REDEFINES`), `PIC $***,**9.99-` check protection, and `PIC ZZZ,ZZ9.99CR` accounting format! |
| **`[3]` Live `.cob` Code Generator** | Customize your own compound-interest program, watch COBOL write a real runnable **`my_sandbox.cob`** file to disk, and execute it live! |
| **`[4]` Bug Hunter Arcade** | Diagnose 4 famous real-world production mainframe bugs (rogue periods inside `IF`, Y2K `PIC 99` rollover, edited vs. operational `PIC`, and the Column-73 punch-card cliff) for bonus XP and ranks! |
| **`[5]` Beginner Glossary & Cheat-Sheet** | Plain-English definitions of core programming concepts (`Program`, `String`, `Variable`, `Loop`, `Compiler`) plus syntax cards for Divisions, `PIC` symbols, Verbs, and Grace Hopper history. |
| **`[6]` Save & FD Record Inspector** | Progress auto-saves to **`savegame.dat`** using genuine COBOL `LINE SEQUENTIAL` file I/O — inspect the exact fixed-width byte slices right inside the app! |

---

## Companion COBOL Programs (`examples/`)

Every topic in the curriculum has a matching, heavily-commented `.cob` source file in `examples/` (plus precompiled binaries in the Windows & Linux bundles!):

1. **`examples/01-hello-mainframe.cob`** — Authentic 1960s 80-column Punch-Card Fixed-Format COBOL!
2. **`examples/02-pic-showcase.cob`** — `WORKING-STORAGE` & `PIC` check-protection / `CR` formatting
3. **`examples/03-verbs-and-move.cob`** — Left-aligned text vs. right-aligned numeric `MOVE` & truncation
4. **`examples/04-penny-perfect-bank.cob`** — Fixed-point `COMPUTE ... ROUNDED` & `ON SIZE ERROR`
5. **`examples/05-account-evaluator.cob`** — `88`-level condition ranges & `EVALUATE TRUE`
6. **`examples/06-perform-loops.cob`** — `PERFORM TIMES`, `PERFORM UNTIL`, and `PERFORM VARYING`
7. **`examples/07-branch-table.cob`** — 1-indexed `OCCURS` tables & quarterly revenue aggregation
8. **`examples/08-batch-payroll.cob`** — Sequential file batch job reading `examples/employees.dat`

---

## Developer & `make` Commands (macOS / Linux / Windows)

```bash
# macOS & Linux (Makefile)
make install-deps   # Auto-install GnuCOBOL via Homebrew/apt/dnf/pacman/etc.
make run            # Compile & launch COBOL QUEST
make examples       # Compile & execute all 8 companion examples
make test           # Run the full automated playthrough & compiler smoke tests

# Windows (Optional — only needed if you want to edit & recompile .cob files!)
# Double-click scripts\Install-GnuCOBOL-Windows.bat (bypasses PowerShell ExecutionPolicy), then:
scripts\build-windows.bat
```

---

## Project Structure

```text
COBOL-Quest/
├── COBOL-Quest.exe                  # Windows root double-click executable
├── Play-COBOL-Quest.bat             # Windows batch launcher
├── Play-COBOL-Quest.command         # macOS Finder double-click launcher
├── Play-COBOL-Quest.sh              # Universal Linux & macOS launcher
├── Makefile                         # make run / examples / test / install-deps
├── Dockerfile                       # Zero-host-install container option
├── runtime/                         # Prebuilt Windows x64 & Linux x86_64 binaries
├── releases/                        # Standalone downloadable OS bundles
├── src/
│   ├── cobol-quest.cob              # Main COBOL QUEST v2.0 Console & File I/O
│   └── copybooks/
│       ├── quest-state.cpy          # Zero-to-Master ranks, XP & chapter table
│       ├── ansi-ui.cpy              # IBM 3270 phosphor ANSI color palette
│       ├── drill-engine-data.cpy    # Data tables for multi-variant quizzes & drills
│       ├── drill-engine-proc.cpy    # Non-spoiler hints, mistake coach & variant rotator
│       ├── chapters-1-to-4.cpy      # Chapters 1-4: Zero-coding start -> MOVE/ACCEPT
│       ├── chapters-5-to-8.cpy      # Chapters 5-8: Math, IF/88, PERFORM, Files & Exam
│       └── labs-proc.cpy            # Live PIC Lab, Code Generator, Arcade & Glossary
├── examples/                        # 8 standalone runnable COBOL programs + data
├── scripts/                         # Windows (.bat/.ps1) & Unix (.sh) setup/build scripts
└── tests/smoke-test.sh              # Automated full-playthrough & compiler test suite
```
