# COBOL QUEST v2.0 — Zero-to-Master Edition

An interactive **command-line COBOL tutor, retro mainframe adventure, live `PIC` & fixed-point laboratory, `.cob` code generator, and debugging arcade** built for someone with **zero prior programming experience** — and **written 100% in COBOL!**

```text
+====================================================================+
|   ___  ___  ___   ___  _        ___  _   _ ___ ___ _____           |
|  / __|/ _ \| _ ) / _ \| |      / _ \| | | | __/ __|_   _|          |
| | (__| (_) | _ \| (_) | |__   | (_) | |_| | _|\__ \ | |            |
|  \___|\___/|___/ \___/|____|   \__\_\\___/|___|___/ |_|   v2.0     |
|                                                                    |
|      ZERO-TO-MASTER EDITION // LEARN COBOL FROM SCRATCH!           |
+====================================================================+
```

---

## Why v2.0? Built From the Ground Up for Complete Beginners

Most coding tutorials assume you already know what a *variable*, *string*, *loop*, or *compiler* is. **COBOL QUEST v2.0** assumes **nothing** — guiding you from writing your very first line of code all the way to reading and writing real business batch files:

1. **Plain-English Multi-Page Lessons:** Uses everyday analogies (recipes, labeled storage boxes, quotation-mark stickers vs. opening boxes, 3-digit cups overflowing, numbered lockers, and notebooks) with zero C/Python jargon.
2. **Adaptive 2-Variant Concept Quizzes:** Verifies you understand each idea *before* asking you to write code. If you miss a question, it explains *why* in plain English and serves a **fresh follow-up question** so you never pass by guessing letters.
3. **2-Stage Non-Spoiler `HINT` Clues:**
   - **1st `HINT`:** Shows a parallel example using *completely different* words/numbers — teaching the pattern without giving away the answer.
   - **2nd `HINT`:** Shows a fill-in-the-blank blueprint (`___`) so you still write the code yourself.
4. **Productive Failure → Step-by-Step Breakdown → 3-Variant Rotation:**
   - You get **2 tries** per problem with targeted beginner coaching (catching `=` vs. `MOVE`, accidental quotes around variable box names, reversed word order, or a missing closing period `.`).
   - After 2 misses (or anytime you type **`EXPLAIN`**), COBOL QUEST shows **your line right above the working line**, explains why each piece is there in 3 plain-English steps, and **rotates to a brand-new variant** (16 drills × 3 variants = **48 live coding exercises**!) until you solve one on your own!
   - Even after passing a drill, you can type **`P`** to practice extra variants for bonus XP.

---

## Quick Start — Choose Your Operating System

### 1. Windows (Zero Setup — Ready to Double-Click!)
- **If you downloaded or cloned this repository (`Code -> Download ZIP` or `git clone`):**
  - Open the extracted folder and double-click **`COBOL-Quest.exe`** (or **`Play-COBOL-Quest.bat`**) right in the top folder — the compiled v2.0 COBOL program and runtime DLLs are already bundled inside `runtime\windows-x64\`!
- **Or download the standalone release zip:**
  1. Download [**`COBOL-Quest-Windows-x64.zip`**](https://github.com/kivenblake/COBOL-Quest/raw/main/releases/COBOL-Quest-Windows-x64.zip) (3.3 MB).
  2. Right-click **`COBOL-Quest-Windows-x64.zip`** → **Extract All...**
  3. Double-click **`COBOL-Quest.exe`** (or **`Play-COBOL-Quest.bat`**)!

### 2. Linux (Zero Setup — Ready to Run!)
- **If you downloaded or cloned this repository (`Code -> Download ZIP` or `git clone`):**
  ```bash
  bash Play-COBOL-Quest.sh
  ```
  *(On `x86_64` Linux, this runs the bundled zero-dependency v2.0 binary in `runtime/linux-x86_64/cobol-quest` immediately with **no `sudo` or compiler required**! On `ARM64` / Raspberry Pi, it automatically compiles from source or offers a 1-step `gnucobol` install.)*
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
  3. If GnuCOBOL isn't installed yet, the launcher offers to install Homebrew (if needed) + `gnucobol`, compiles v2.0 natively for your Mac in under a second, and starts the game!
- **Alternative — Double-Click in Finder:**
  - Double-click **`Play-COBOL-Quest.command`**. *(Note: macOS Gatekeeper blocks downloaded `.command` scripts on first open — if prompted, right-click `Play-COBOL-Quest.command` → **Open** → **Open**, or run `bash Play-COBOL-Quest.sh` in Terminal above.)*

### 4. Docker (Works on macOS, Linux & Windows — Zero Host Dependencies)
```bash
docker build -t cobol-quest .
docker run -it --rm cobol-quest
```

> **Terminal Tip:** Modern terminals on Windows 11, macOS, and Linux support retro IBM phosphor ANSI colors out of the box. If you ever run in a plain monochrome console, press **`C`** on the Main Menu!

---

## The 8-Chapter Zero-to-Master Curriculum

| Chapter | Topic | What You'll Master (From Zero!) |
| :---: | :--- | :--- |
| **`1`** | **What Is Code? `DISPLAY` & First Program** | How programs run top-to-bottom, verbs, strings (`"..."`), periods (`.`), `IDENTIFICATION DIVISION`, `PROGRAM-ID`, `PROCEDURE DIVISION`, and `STOP RUN` |
| **`2`** | **The 4-Room Blueprint & Comments** | Why COBOL organizes code into 4 Divisions in fixed order, `*>` human comments, and 1960s 80-column punch-card history |
| **`3`** | **Storage Boxes: Variables & `PIC`** | What variables are, naming rules, text boxes (`PIC X`), digit boxes (`PIC 9`), negative signs (`S`), and implied cent decimals (`V99`) |
| **`4`** | **Moving Data & Keyboard Input** | The difference between `"BOX-NAME"` (literal text) vs. `BOX-NAME` (inside the box!), `MOVE ... TO ...`, and `ACCEPT` |
| **`5`** | **Teaching Computers Math & Rounding** | Plain-English `ADD`/`SUBTRACT`/`MULTIPLY` vs. `COMPUTE` formulas, truncation vs. `ROUNDED`, and catching overflows with `ON SIZE ERROR` |
| **`6`** | **Decisions: `IF`, `END-IF` & Level-`88`** | Conditional rules, why mid-`IF` periods cause famous bugs, `END-IF`, `EVALUATE TRUE`, and readable `88`-level nickname switches |
| **`7`** | **Repeating Work: Paragraphs & `PERFORM`** | Reusable recipe-card paragraphs, `PERFORM N TIMES`, `PERFORM UNTIL` (pre-test loops), and `PERFORM VARYING` counters |
| **`8`** | **Lists (`OCCURS`), Files & Final Exam** | Hierarchical `01`/`05` records, 1-indexed `OCCURS` tables, `OPEN`/`READ ... AT END`/`WRITE`/`CLOSE`, and rescuing the Midnight Payroll Batch! |

### All 6 Console Modes
- **`[1]` Zero-to-Master Lessons** — All 8 interactive chapters, adaptive quizzes, and 48 coding variants (`NEWCOMER` → `COBOL GRANDMASTER`).
- **`[2]` Interactive `PIC` & Math Lab** — Type any signed decimal (like `-2000.00` or `1234.567`) to watch real COBOL `MOVE`s format it across `PIC 9(6)`, raw 7-byte `PIC 9(5)V99` RAM (`REDEFINES`), `$***,**9.99-` check protection, and `ZZZ,ZZ9.99CR` accounting masks!
- **`[3]` COBOL Code Generator** — Customize your own compound-interest parameters, save a runnable **`my_sandbox.cob`** file to disk, and run it live!
- **`[4]` Bug Hunter Arcade** — Diagnose 4 famous real-world production COBOL bugs for bonus XP.
- **`[5]` Beginner Glossary & Cheat-Sheet** — Plain-English programming glossary (`[0]`) + quick syntax cards (`[1]`–`[4]`).
- **`[6]` Save & FD Record Inspector** — Inspect your live fixed-width `savegame.dat` record written by COBOL `LINE SEQUENTIAL` file I/O.

---

## Companion COBOL Programs (`examples/`)

Every topic has a matching, heavily-commented `.cob` source file in `examples/` (plus precompiled binaries in the Windows & Linux bundles!):

1. **`examples/01-hello-mainframe.cob`** — Authentic 1960s 80-column Punch-Card Fixed-Format COBOL!
2. **`examples/02-pic-showcase.cob`** — `WORKING-STORAGE` & `PIC` check-protection / `CR` formatting
3. **`examples/03-verbs-and-move.cob`** — Left-aligned text vs. right-aligned numeric `MOVE` & truncation
4. **`examples/04-penny-perfect-bank.cob`** — Fixed-point `COMPUTE ... ROUNDED` & `ON SIZE ERROR`
5. **`examples/05-account-evaluator.cob`** — `88`-level condition ranges & `EVALUATE TRUE`
6. **`examples/06-perform-loops.cob`** — `PERFORM TIMES`, `PERFORM UNTIL`, and `PERFORM VARYING`
7. **`examples/07-branch-table.cob`** — 1-indexed `OCCURS` tables & quarterly revenue aggregation
8. **`examples/08-batch-payroll.cob`** — Sequential file batch job reading `examples/employees.dat`

---

## Optional: Edit & Recompile `.cob` Source Files Locally

```bash
# macOS & Linux (Makefile)
make install-deps   # Auto-install GnuCOBOL via Homebrew/apt/dnf/pacman/etc.
make run            # Compile & launch COBOL QUEST v2.0
make examples       # Compile & execute all 8 companion examples
make test           # Run the automated 8-chapter + variant-rotation test suite

# Windows (Only needed if you want 'cobc' to edit & recompile .cob files!)
# 1. Double-click scripts\Install-GnuCOBOL-Windows.bat (bypasses ExecutionPolicy)
# 2. Double-click scripts\build-windows.bat
```

---

## Project Structure

```text
COBOL-Quest/
├── COBOL-Quest.exe                  # Windows root double-click executable (v2.0)
├── Play-COBOL-Quest.bat             # Windows batch launcher
├── Play-COBOL-Quest.command         # macOS Finder double-click launcher
├── Play-COBOL-Quest.sh              # Universal Linux & macOS launcher
├── Makefile                         # make run / examples / test / install-deps
├── Dockerfile                       # Zero-host-install container option
├── runtime/                         # Prebuilt v2.0 Windows x64 & Linux x86_64 binaries
├── releases/                        # Standalone downloadable OS bundles (v2.0)
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
