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

### 1. Windows (Zero Setup — Download & Play!)
1. Download [**`COBOL-Quest-Windows-x64.zip`**](https://github.com/kivenblake/COBOL-Quest/raw/main/releases/COBOL-Quest-Windows-x64.zip) (3.3 MB).
2. Right-click **`COBOL-Quest-Windows-x64.zip`** → **Extract All...**
3. Double-click **`Play-COBOL-Quest.bat`** (or **`COBOL-Quest.exe`**)!

### 2. Linux (Zero Setup — Standalone x86_64 Binary OR Auto-Build!)
- **Option A — Download Prebuilt Bundle (No `sudo` or compiler required on x86_64):**
  ```bash
  curl -LO https://github.com/kivenblake/COBOL-Quest/raw/main/releases/COBOL-Quest-Linux-x86_64.tar.gz
  tar -xzf COBOL-Quest-Linux-x86_64.tar.gz
  cd COBOL-Quest-Linux-x86_64
  ./Play-COBOL-Quest.sh
  ```
  *(Both GnuCOBOL's `libcob` and `libgmp` are statically linked in, so `./cobol-quest` runs out of the box across Ubuntu, Debian, Fedora, Arch, Linux Mint, Pop!_OS, openSUSE, and WSL!)*

- **Option B — Clone & Run (Any architecture including ARM64 / Raspberry Pi):**
  ```bash
  git clone https://github.com/kivenblake/COBOL-Quest.git
  cd COBOL-Quest
  ./Play-COBOL-Quest.sh
  ```
  *(Automatically offers 1-step `gnucobol` install via `apt`, `dnf`, `pacman`, `zypper`, `apk`, or `xbps` if needed!)*

### 3. macOS (Apple Silicon M1–M4 & Intel Macs)
- **Option A — Download macOS Bundle:**
  1. Download [**`COBOL-Quest-macOS.zip`**](https://github.com/kivenblake/COBOL-Quest/raw/main/releases/COBOL-Quest-macOS.zip) and unzip it.
  2. In Terminal, `cd` into `COBOL-Quest-macOS` and run:
     ```bash
     ./Play-COBOL-Quest.sh
     ```
     — **or** double-click **`Play-COBOL-Quest.command`** in Finder! *(Tip: if macOS Gatekeeper prompts on first Finder open, right-click `Play-COBOL-Quest.command` → **Open**, or run `xattr -d com.apple.quarantine Play-COBOL-Quest.command`.)*
  3. If GnuCOBOL isn't installed yet, the launcher offers a 1-step install via Homebrew (`brew install gnucobol`), compiles natively for your Mac in under a second, and launches the game!

- **Option B — Git Clone + Homebrew:**
  ```bash
  brew install gnucobol
  git clone https://github.com/kivenblake/COBOL-Quest.git
  cd COBOL-Quest
  ./Play-COBOL-Quest.sh
  ```

### 4. Docker (Works on macOS, Linux & Windows — Zero Host Dependencies)
```bash
docker build -t cobol-quest .
docker run -it --rm cobol-quest
```

> **Terminal Tip:** Modern terminals on Windows 11, macOS, and Linux support retro IBM phosphor ANSI colors out of the box. If you ever run in a plain monochrome console, press **`C`** on the Main Menu!

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

Every mission in the game has a matching, heavily-commented `.cob` source file in `examples/` (plus precompiled binaries in the Windows & Linux bundles!):

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

# Windows (PowerShell / CMD)
powershell -ExecutionPolicy Bypass -File scripts\install-gnucobol-windows.ps1
scripts\build-windows.bat
```

---

## Project Structure

```text
COBOL-Quest/
├── Play-COBOL-Quest.bat             # Windows double-click launcher
├── Play-COBOL-Quest.command         # macOS Finder double-click launcher
├── Play-COBOL-Quest.sh              # Universal Linux & macOS launcher
├── Makefile                         # make run / examples / test / install-deps
├── Dockerfile                       # Zero-host-install container option
├── releases/                        # Downloadable Windows, Linux & macOS bundles
├── src/
│   ├── cobol-quest.cob              # Main COBOL QUEST RPG & Interactive Tutor
│   └── copybooks/
│       ├── quest-state.cpy          # RPG ranks, XP, badges & REDEFINES table
│       ├── ansi-ui.cpy              # IBM 3270 phosphor ANSI color palette
│       ├── missions-proc.cpy        # 8 Story Missions + 3-Wave Boss Battle
│       └── labs-proc.cpy            # Live PIC Lab, Code Generator, Bug Arcade & Ref
├── examples/                        # 8 standalone runnable COBOL programs + data
├── scripts/                         # Windows (.bat/.ps1) & Unix (.sh) setup/build scripts
└── tests/smoke-test.sh              # Automated full-playthrough & compiler test suite
```
