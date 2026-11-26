       >>SOURCE FORMAT FREE
*> ===================================================================
*> PROGRAM : COBOL-QUEST (IRON-7090 MAINFRAME CHRONICLES)
*> AUTHOR  : Built in 100% GnuCOBOL for Interactive COBOL Learning
*> PURPOSE : An interactive RPG adventure, live PIC/math laboratory,
*>           code generator, bug-hunting arcade, and pocket reference
*>           designed to make learning COBOL fun and hands-on!
*> ===================================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. COBOL-QUEST.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           *> Real COBOL Sequential File I/O used to save player stats!
           SELECT SAVE-FILE
               ASSIGN TO "savegame.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-SAVE-STATUS.

           *> Used by the Live COBOL Sandbox to generate runnable .cob code!
           SELECT SANDBOX-FILE
               ASSIGN TO "my_sandbox.cob"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-SANDBOX-STATUS.

       DATA DIVISION.
       FILE SECTION.
       FD  SAVE-FILE.
       01  SAVE-RECORD.
           05  SR-MAGIC                PIC X(10).
           05  SR-PLAYER-NAME          PIC X(20).
           05  SR-PLAYER-XP            PIC 9(5).
           05  SR-BEST-STREAK          PIC 9(3).
           05  SR-BUGS-SQUASHED        PIC 9(3).
           05  SR-MISSIONS             PIC X(8).
           05  SR-COLOR-MODE           PIC X.

       FD  SANDBOX-FILE.
       01  SANDBOX-LINE                PIC X(80).

       WORKING-STORAGE SECTION.
       COPY "quest-state.cpy".
       COPY "ansi-ui.cpy".

       *> Menu & Navigation Controls
       01  WS-NAV-CONTROLS.
           05  WS-MENU-CHOICE          PIC X(16) VALUE SPACES.
           05  WS-UPPER-CHOICE         PIC X(16) VALUE SPACES.
           05  WS-PAUSE-DUMMY          PIC X(16) VALUE SPACES.
           05  WS-APP-RUNNING          PIC X     VALUE "Y".
               88  KEEP-RUNNING                  VALUE "Y".
               88  SHUTDOWN-NOW                  VALUE "N".
           05  WS-EMPTY-GUARD          PIC 99    VALUE 0.
           05  WS-IDX                  PIC 99    VALUE 1.
           05  WS-IDX-DISP             PIC 9     VALUE 1.
           05  WS-MISSION-NUM          PIC 99    VALUE 0.

       *> Quiz & Live COBOL Coding Terminal Engine
       01  WS-CHALLENGE-ENGINE.
           05  WS-QUIZ-ANS             PIC X(16) VALUE SPACES.
           05  WS-QUIZ-DONE            PIC X     VALUE "N".
           05  WS-CODE-INPUT           PIC X(80) VALUE SPACES.
           05  WS-CODE-UPPER           PIC X(80) VALUE SPACES.
           05  WS-CODE-SOLVED          PIC X     VALUE "N".
           05  WS-CHALLENGE-ID         PIC 99    VALUE 0.
           05  WS-HINT-TEXT            PIC X(76) VALUE SPACES.
           05  WS-MODEL-ANSWER         PIC X(76) VALUE SPACES.
           05  WS-PROMPT-DESC          PIC X(76) VALUE SPACES.
           05  WS-CNT-1                PIC 99    VALUE 0.
           05  WS-CNT-2                PIC 99    VALUE 0.
           05  WS-CNT-3                PIC 99    VALUE 0.
           05  WS-CNT-4                PIC 99    VALUE 0.
           05  WS-CNT-5                PIC 99    VALUE 0.
           05  WS-CNT-EQ               PIC 99    VALUE 0.
           05  WS-TRIM-LEN             PIC 99    VALUE 0.
           05  WS-LAST-CH              PIC X     VALUE SPACE.
           05  WS-XP-GAIN              PIC 9(4)  VALUE 0.
           05  WS-XP-GAIN-FMT          PIC Z,ZZ9.

       *> Boss Encounter (Mission 8: Midnight Payroll Batch)
       01  WS-BOSS-STATE.
           05  WS-MAINFRAME-HP         PIC S9(3) VALUE 100.
           05  WS-BOSS-HP              PIC S9(3) VALUE 300.
           05  WS-HP-FMT               PIC ZZ9.
           05  WS-BOSS-FMT             PIC ZZ9.

       *> Interactive PIC & Fixed-Point Math Lab Variables
       01  WS-PIC-LAB.
           05  WS-LAB-INPUT            PIC X(24) VALUE SPACES.
           05  WS-LAB-DEC              PIC S9(6)V999 VALUE 0.
           05  WS-PIC-INT              PIC 9(6).
           05  WS-PIC-V99              PIC 9(5)V99.
           05  WS-PIC-V99-RAW REDEFINES WS-PIC-V99 PIC X(7).
           05  WS-PIC-ZERO             PIC ZZZ,ZZ9.99.
           05  WS-PIC-CHECK            PIC $***,**9.99-.
           05  WS-PIC-SIGN             PIC +ZZZ,ZZ9.99.
           05  WS-PIC-CR               PIC ZZZ,ZZ9.99CR.
           05  WS-DIV-TRUNC            PIC 9(4)V99.
           05  WS-DIV-ROUND            PIC 9(4)V99.
           05  WS-DIV-DISP-1           PIC Z,ZZ9.99.
           05  WS-DIV-DISP-2           PIC Z,ZZ9.99.

       *> Live COBOL Sandbox & Code Generator Variables
       01  WS-SANDBOX-VARS.
           05  WS-GEN-PROG             PIC X(12) VALUE "MYBANK".
           05  WS-GEN-MSG              PIC X(36) VALUE SPACES.
           05  WS-GEN-DEP-STR          PIC X(16) VALUE SPACES.
           05  WS-GEN-RATE-STR         PIC X(16) VALUE SPACES.
           05  WS-GEN-YRS-STR          PIC X(10) VALUE SPACES.
           05  WS-GEN-DEPOSIT          PIC 9(6)V99 VALUE 1000.00.
           05  WS-GEN-RATE             PIC 9(2)V99 VALUE 05.25.
           05  WS-GEN-YEARS            PIC 99      VALUE 05.
           05  WS-GEN-CUR-BAL          PIC 9(7)V99 VALUE 0.
           05  WS-GEN-INT              PIC 9(6)V99 VALUE 0.
           05  WS-GEN-YR-IDX           PIC 99      VALUE 1.
           05  WS-GEN-YR-FMT           PIC Z9.
           05  WS-GEN-BAL-FMT          PIC $Z,ZZZ,ZZ9.99.
           05  WS-GEN-INT-FMT          PIC $ZZZ,ZZ9.99.
           05  WS-GEN-DEP-CLEAN        PIC 999999.99.
           05  WS-GEN-RATE-CLEAN       PIC 99.99.
           05  WS-GEN-YRS-CLEAN        PIC 99.

       *> Bug Hunter Arcade & Reference Variables
       01  WS-ARCADE-VARS.
           05  WS-BUG-SCORE            PIC 99    VALUE 0.
           05  WS-REF-CHOICE           PIC X(16) VALUE SPACES.

       PROCEDURE DIVISION.
       0000-MAIN-CONTROL.
           PERFORM 0100-INIT-PALETTE
           PERFORM 0200-BOOT-AND-LOAD
           PERFORM 0300-MAIN-HUB-LOOP UNTIL SHUTDOWN-NOW
           PERFORM 0900-SAVE-GAME-QUIET
           PERFORM 0990-SIGN-OFF-BANNER
           STOP RUN.

*> ===================================================================
*> 0100-INIT-PALETTE: Configure ANSI escape codes or Plain ASCII mode
*> ===================================================================
       0100-INIT-PALETTE.
           IF COLOR-ENABLED
               STRING WS-ESC "[0m"    DELIMITED BY SIZE INTO C-RST
               STRING WS-ESC "[1;32m" DELIMITED BY SIZE INTO C-GRN
               STRING WS-ESC "[1;36m" DELIMITED BY SIZE INTO C-CYN
               STRING WS-ESC "[1;33m" DELIMITED BY SIZE INTO C-YLW
               STRING WS-ESC "[1;31m" DELIMITED BY SIZE INTO C-RED
               STRING WS-ESC "[1;35m" DELIMITED BY SIZE INTO C-MAG
               STRING WS-ESC "[1;37m" DELIMITED BY SIZE INTO C-WHT
               STRING WS-ESC "[0;37m" DELIMITED BY SIZE INTO C-DIM
               STRING WS-ESC "[1;34m" DELIMITED BY SIZE INTO C-BLU
               STRING WS-ESC "[2J"    DELIMITED BY SIZE INTO C-CLS
           ELSE
               INITIALIZE WS-ANSI-PALETTE
           END-IF.

       0150-CLEAR-SCREEN.
           IF COLOR-ENABLED
               DISPLAY WS-ESC "[2J" WS-ESC "[H" WITH NO ADVANCING
           ELSE
               DISPLAY " "
               DISPLAY "======================================================================"
           END-IF.

*> ===================================================================
*> 0200-BOOT-AND-LOAD: Retro Mainframe Boot & Auto-Load Save File
*> ===================================================================
       0200-BOOT-AND-LOAD.
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-GRN)
               "+====================================================================+"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "|   ___  ___  ___   ___  _        ___  _   _ ___ ___ _____           |"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "|  / __|/ _ \| _ ) / _ \| |      / _ \| | | | __/ __|_   _|          |"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-CYN)
               "| | (__| (_) | _ \| (_) | |__   | (_) | |_| | _|\__ \ | |            |"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-CYN)
               "|  \___|\___/|___/ \___/|____|   \__\_\\___/|___|___/ |_|   v1.0     |"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "|                                                                    |"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-YLW)
               "|        IRON-7090 MAINFRAME CHRONICLES // WRITTEN IN COBOL!         |"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "+====================================================================+"
               FUNCTION TRIM(C-RST)
           DISPLAY " "

           OPEN INPUT SAVE-FILE
           IF WS-SAVE-STATUS = "00"
               READ SAVE-FILE
                   AT END
                       CLOSE SAVE-FILE
                       PERFORM 0250-NEW-ENGINEER-ONBOARD
                   NOT AT END
                       CLOSE SAVE-FILE
                       IF SR-MAGIC = "COBQUEST01"
                           MOVE SR-PLAYER-NAME   TO WS-PLAYER-NAME
                           MOVE SR-PLAYER-XP     TO WS-PLAYER-XP
                           MOVE SR-BEST-STREAK   TO WS-BEST-STREAK
                           MOVE SR-BUGS-SQUASHED TO WS-BUGS-SQUASHED
                           MOVE SR-MISSIONS      TO WS-MISSION-TABLE
                           IF SR-COLOR-MODE = "N" OR SR-COLOR-MODE = "Y"
                               MOVE SR-COLOR-MODE TO WS-COLOR-MODE
                               PERFORM 0100-INIT-PALETTE
                           END-IF
                           PERFORM 0400-RECALC-RANK-AND-BAR
                           DISPLAY FUNCTION TRIM(C-GRN)
                               "  [TAPE MOUNTED] Welcome back, Engineer "
                               FUNCTION TRIM(WS-PLAYER-NAME) "!"
                               FUNCTION TRIM(C-RST)
                           DISPLAY "  Loaded profile from savegame.dat ("
                               WS-CORES-ONLINE "/8 Subsystems Online)."
                           PERFORM 9000-PRESS-ENTER
                       ELSE
                           PERFORM 0250-NEW-ENGINEER-ONBOARD
                       END-IF
               END-READ
           ELSE
               PERFORM 0250-NEW-ENGINEER-ONBOARD
           END-IF.

       0250-NEW-ENGINEER-ONBOARD.
           DISPLAY FUNCTION TRIM(C-CYN)
               "  [SUB-LEVEL 4 ALERT] Mainframe IRON-7090 is running on backup power!"
               FUNCTION TRIM(C-RST)
           DISPLAY "  Global ATMs, train schedules, and payroll batch jobs depend on you."
           DISPLAY "  Restore all 8 COBOL Subsystems to save the Big Iron!"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-DIM)
               "  Tip: If terminal symbols look strange (e.g. <-[1;32m), type C on"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-DIM)
               "       the Main Menu to switch to Classic Plain-ASCII Mode!"
               FUNCTION TRIM(C-RST)
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-YLW)
               "  Enter your Engineer Callsign (or press ENTER for GRACE-H): "
               FUNCTION TRIM(C-RST) WITH NO ADVANCING
           ACCEPT WS-PLAYER-NAME
           IF WS-PLAYER-NAME = SPACES
               MOVE "GRACE-H" TO WS-PLAYER-NAME
           ELSE
               MOVE FUNCTION UPPER-CASE(WS-PLAYER-NAME) TO WS-PLAYER-NAME
           END-IF
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               "  Access Granted! Badge issued to Engineer "
               FUNCTION TRIM(WS-PLAYER-NAME) "."
               FUNCTION TRIM(C-RST)
           DISPLAY "  (Named in tribute to Rear Admiral Grace Hopper, pioneer of COBOL!)"
           PERFORM 0900-SAVE-GAME-QUIET
           PERFORM 9000-PRESS-ENTER.

*> ===================================================================
*> 0300-MAIN-HUB-LOOP: Central Mainframe Command Console
*> ===================================================================
       0300-MAIN-HUB-LOOP.
           PERFORM 0400-RECALC-RANK-AND-BAR
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-GRN)
               "+====================================================================+"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN) "| " FUNCTION TRIM(C-WHT)
               "IRON-7090 MAINFRAME CONSOLE"
               FUNCTION TRIM(C-DIM)
               "             [100% Powered by GnuCOBOL] "
               FUNCTION TRIM(C-GRN) "|" FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "+--------------------------------------------------------------------+"
               FUNCTION TRIM(C-RST)
           DISPLAY "  Engineer : " FUNCTION TRIM(C-CYN) WS-PLAYER-NAME
               FUNCTION TRIM(C-RST)
               "   XP : " FUNCTION TRIM(C-YLW) WS-XP-FMT
               FUNCTION TRIM(C-RST)
               "   Streak : " FUNCTION TRIM(C-MAG) WS-STREAK-FMT
               FUNCTION TRIM(C-RST)
           DISPLAY "  Rank     : " FUNCTION TRIM(C-GRN) WS-RANK-TITLE
               FUNCTION TRIM(C-RST)
               "   Cores  : [" FUNCTION TRIM(C-GRN) WS-PROGRESS-BAR
               FUNCTION TRIM(C-RST) "] " WS-CORES-ONLINE "/8"
           DISPLAY FUNCTION TRIM(C-GRN)
               "+--------------------------------------------------------------------+"
               FUNCTION TRIM(C-RST)
           DISPLAY "  " FUNCTION TRIM(C-YLW) "[1]" FUNCTION TRIM(C-RST)
               " Story Missions       - Learn COBOL across 8 Chapters + Boss Job"
           DISPLAY "  " FUNCTION TRIM(C-YLW) "[2]" FUNCTION TRIM(C-RST)
               " Interactive PIC Lab  - Test PIC masks & fixed-point math live!"
           DISPLAY "  " FUNCTION TRIM(C-YLW) "[3]" FUNCTION TRIM(C-RST)
               " COBOL Code Generator - Build & run your own my_sandbox.cob file"
           DISPLAY "  " FUNCTION TRIM(C-YLW) "[4]" FUNCTION TRIM(C-RST)
               " Bug Hunter Arcade    - Diagnose real production COBOL bugs"
           DISPLAY "  " FUNCTION TRIM(C-YLW) "[5]" FUNCTION TRIM(C-RST)
               " Pocket Cheat-Sheet   - Quick syntax cards & COBOL history"
           DISPLAY "  " FUNCTION TRIM(C-YLW) "[6]" FUNCTION TRIM(C-RST)
               " Save / Inspect File  - View real COBOL sequential savegame.dat"
           DISPLAY "  " FUNCTION TRIM(C-YLW) "[C]" FUNCTION TRIM(C-RST)
               " Toggle Color Mode    - Currently: " WS-COLOR-MODE
               " (Y = ANSI Phosphor, N = Plain)"
           DISPLAY "  " FUNCTION TRIM(C-YLW) "[Q]" FUNCTION TRIM(C-RST)
               " Log Off & Auto-Save"
           DISPLAY FUNCTION TRIM(C-GRN)
               "+====================================================================+"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-CYN) "  IRON-7090> " FUNCTION TRIM(C-RST)
               WITH NO ADVANCING
           MOVE SPACES TO WS-MENU-CHOICE
           ACCEPT WS-MENU-CHOICE
           MOVE FUNCTION UPPER-CASE(FUNCTION TRIM(WS-MENU-CHOICE))
               TO WS-UPPER-CHOICE

           IF WS-UPPER-CHOICE = SPACES
               ADD 1 TO WS-EMPTY-GUARD
               IF WS-EMPTY-GUARD > 20
                   SET SHUTDOWN-NOW TO TRUE
               END-IF
           ELSE
               MOVE 0 TO WS-EMPTY-GUARD
           END-IF

           EVALUATE WS-UPPER-CHOICE
               WHEN "1"
                   PERFORM 1000-MISSION-SELECT-MENU
               WHEN "2"
                   PERFORM 5000-INTERACTIVE-PIC-LAB
               WHEN "3"
                   PERFORM 5500-COBOL-CODE-GENERATOR
               WHEN "4"
                   PERFORM 6000-BUG-HUNTER-ARCADE
               WHEN "5"
                   PERFORM 7000-POCKET-REFERENCE
               WHEN "6"
                   PERFORM 0800-SAVE-AND-INSPECT-MENU
               WHEN "C"
                   IF COLOR-ENABLED
                       SET COLOR-DISABLED TO TRUE
                   ELSE
                       SET COLOR-ENABLED TO TRUE
                   END-IF
                   PERFORM 0100-INIT-PALETTE
               WHEN "Q"
               WHEN "QUIT"
               WHEN "EXIT"
               WHEN "0"
                   SET SHUTDOWN-NOW TO TRUE
               WHEN SPACES
                   CONTINUE
               WHEN OTHER
                   DISPLAY FUNCTION TRIM(C-RED)
                       "  Unknown command. Type 1-6, C, or Q."
                       FUNCTION TRIM(C-RST)
                   PERFORM 9000-PRESS-ENTER
           END-EVALUATE.

*> ===================================================================
*> 0400-RECALC-RANK-AND-BAR: Uses EVALUATE TRUE & PERFORM VARYING!
*> ===================================================================
       0400-RECALC-RANK-AND-BAR.
           MOVE WS-PLAYER-XP     TO WS-XP-FMT
           MOVE WS-PLAYER-STREAK TO WS-STREAK-FMT
           MOVE 0                TO WS-CORES-ONLINE
           MOVE SPACES           TO WS-PROGRESS-BAR

           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 8
               IF WS-MISSION-DONE(WS-IDX) = "Y"
                   ADD 1 TO WS-CORES-ONLINE
                   MOVE "##" TO WS-PROGRESS-BAR((WS-IDX - 1) * 2 + 1 : 2)
               ELSE
                   MOVE ".." TO WS-PROGRESS-BAR((WS-IDX - 1) * 2 + 1 : 2)
               END-IF
           END-PERFORM

           EVALUATE TRUE
               WHEN WS-PLAYER-XP >= 1400
                   MOVE "GRANDMASTER OF BIG IRON"    TO WS-RANK-TITLE
               WHEN WS-PLAYER-XP >= 1000
                   MOVE "SENIOR CICS ARCHITECT"      TO WS-RANK-TITLE
               WHEN WS-PLAYER-XP >= 700
                   MOVE "BATCH PROCESSING SORCERER"  TO WS-RANK-TITLE
               WHEN WS-PLAYER-XP >= 450
                   MOVE "PROCEDURE DIVISION KNIGHT"  TO WS-RANK-TITLE
               WHEN WS-PLAYER-XP >= 250
                   MOVE "WORKING-STORAGE APPRENTICE" TO WS-RANK-TITLE
               WHEN WS-PLAYER-XP >= 100
                   MOVE "TAPE DRIVE OPERATOR"        TO WS-RANK-TITLE
               WHEN OTHER
                   MOVE "PUNCH-CARD INTERN"          TO WS-RANK-TITLE
           END-EVALUATE.

       0450-AWARD-XP.
           ADD WS-XP-GAIN TO WS-PLAYER-XP
           ADD 1 TO WS-PLAYER-STREAK
           IF WS-PLAYER-STREAK > WS-BEST-STREAK
               MOVE WS-PLAYER-STREAK TO WS-BEST-STREAK
           END-IF
           MOVE WS-XP-GAIN TO WS-XP-GAIN-FMT
           PERFORM 0400-RECALC-RANK-AND-BAR
           DISPLAY FUNCTION TRIM(C-GRN)
               "  *** +" FUNCTION TRIM(WS-XP-GAIN-FMT)
               " XP EARNED! | Current Rank: "
               FUNCTION TRIM(WS-RANK-TITLE) " ***"
               FUNCTION TRIM(C-RST).

*> ===================================================================
*> 0800 & 0900: Real COBOL Sequential File Save & Record Inspector
*> ===================================================================
       0800-SAVE-AND-INSPECT-MENU.
           PERFORM 0900-SAVE-GAME-QUIET
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "+================ SAVE FILE & RECORD INSPECTOR ================+"
               FUNCTION TRIM(C-RST)
           DISPLAY "  Progress saved to " FUNCTION TRIM(C-YLW) "savegame.dat"
               FUNCTION TRIM(C-RST) " using COBOL LINE SEQUENTIAL I/O!"
           DISPLAY " "
           DISPLAY "  Here is the actual COBOL FD (File Description) layout:"
           DISPLAY FUNCTION TRIM(C-GRN)
               "    01 SAVE-RECORD." FUNCTION TRIM(C-RST)
           DISPLAY "       05 SR-MAGIC         PIC X(10) -> [" SR-MAGIC "]"
           DISPLAY "       05 SR-PLAYER-NAME   PIC X(20) -> [" SR-PLAYER-NAME "]"
           DISPLAY "       05 SR-PLAYER-XP     PIC 9(5)  -> [" SR-PLAYER-XP "]"
           DISPLAY "       05 SR-BEST-STREAK   PIC 9(3)  -> [" SR-BEST-STREAK "]"
           DISPLAY "       05 SR-BUGS-SQUASHED PIC 9(3)  -> [" SR-BUGS-SQUASHED "]"
           DISPLAY "       05 SR-MISSIONS      PIC X(8)  -> [" SR-MISSIONS "]"
           DISPLAY "       05 SR-COLOR-MODE    PIC X     -> [" SR-COLOR-MODE "]"
           DISPLAY " "
           DISPLAY "  Notice how COBOL fixed-width records need NO commas or JSON"
           DISPLAY "  brackets -- every field occupies an exact byte slice!"
           DISPLAY " "
           DISPLAY "  Type " FUNCTION TRIM(C-RED) "RESET" FUNCTION TRIM(C-RST)
               " to wipe progress, or press ENTER to return: "
               WITH NO ADVANCING
           ACCEPT WS-MENU-CHOICE
           IF FUNCTION UPPER-CASE(FUNCTION TRIM(WS-MENU-CHOICE)) = "RESET"
               MOVE 0 TO WS-PLAYER-XP WS-PLAYER-STREAK WS-BEST-STREAK
                         WS-BUGS-SQUASHED
               MOVE "NNNNNNNN" TO WS-MISSION-TABLE
               PERFORM 0900-SAVE-GAME-QUIET
               DISPLAY FUNCTION TRIM(C-YLW)
                   "  Profile reset to 0 XP (Punch-Card Intern)."
                   FUNCTION TRIM(C-RST)
               PERFORM 9000-PRESS-ENTER
           END-IF.

       0900-SAVE-GAME-QUIET.
           OPEN OUTPUT SAVE-FILE
           IF WS-SAVE-STATUS = "00"
               MOVE "COBQUEST01"     TO SR-MAGIC
               MOVE WS-PLAYER-NAME   TO SR-PLAYER-NAME
               MOVE WS-PLAYER-XP     TO SR-PLAYER-XP
               MOVE WS-BEST-STREAK   TO SR-BEST-STREAK
               MOVE WS-BUGS-SQUASHED TO SR-BUGS-SQUASHED
               MOVE WS-MISSION-TABLE TO SR-MISSIONS
               MOVE WS-COLOR-MODE    TO SR-COLOR-MODE
               WRITE SAVE-RECORD
               CLOSE SAVE-FILE
           END-IF.

       0990-SIGN-OFF-BANNER.
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               "  [SESSION SAVED] Thank you for playing COBOL QUEST, Engineer "
               FUNCTION TRIM(WS-PLAYER-NAME) "!"
               FUNCTION TRIM(C-RST)
           DISPLAY "  Explore the examples/ folder to read and compile real .cob files!"
           DISPLAY " ".

*> ===================================================================
*> 8000-LIVE-CODE-CHALLENGE: Interactive COBOL Statement Analyzer!
*> ===================================================================
       8000-LIVE-CODE-CHALLENGE.
           MOVE "N" TO WS-CODE-SOLVED
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-YLW)
               "  +---------------- LIVE COBOL CODING TERMINAL ----------------+"
               FUNCTION TRIM(C-RST)
           DISPLAY "  TASK: " WS-PROMPT-DESC
           DISPLAY FUNCTION TRIM(C-DIM)
               "  (Type HINT for a clue, or SHOW to reveal & explain the answer)"
               FUNCTION TRIM(C-RST)

           PERFORM UNTIL WS-CODE-SOLVED = "Y"
               DISPLAY FUNCTION TRIM(C-GRN) "  CODE> " FUNCTION TRIM(C-RST)
                   WITH NO ADVANCING
               MOVE SPACES TO WS-CODE-INPUT
               ACCEPT WS-CODE-INPUT
               MOVE FUNCTION UPPER-CASE(FUNCTION TRIM(WS-CODE-INPUT))
                   TO WS-CODE-UPPER

               IF WS-CODE-UPPER = SPACES
                   ADD 1 TO WS-EMPTY-GUARD
                   IF WS-EMPTY-GUARD > 15
                       MOVE "Y" TO WS-CODE-SOLVED
                       SET SHUTDOWN-NOW TO TRUE
                   END-IF
               ELSE
                   MOVE 0 TO WS-EMPTY-GUARD
               END-IF

               EVALUATE WS-CODE-UPPER
                   WHEN SPACES
                       CONTINUE
                   WHEN "HINT"
                       DISPLAY FUNCTION TRIM(C-CYN) "  [HINT] "
                           FUNCTION TRIM(WS-HINT-TEXT) FUNCTION TRIM(C-RST)
                   WHEN "SHOW"
                   WHEN "ANSWER"
                       DISPLAY FUNCTION TRIM(C-YLW) "  [SOLUTION] "
                           FUNCTION TRIM(WS-MODEL-ANSWER) FUNCTION TRIM(C-RST)
                       DISPLAY "  Type that COBOL statement at CODE> to execute it!"
                   WHEN OTHER
                       PERFORM 8100-CHECK-CHALLENGE-SYNTAX
               END-EVALUATE
           END-PERFORM.

       8100-CHECK-CHALLENGE-SYNTAX.
           MOVE 0 TO WS-CNT-1 WS-CNT-2 WS-CNT-3 WS-CNT-4 WS-CNT-5 WS-CNT-EQ
           MOVE FUNCTION LENGTH(FUNCTION TRIM(WS-CODE-UPPER)) TO WS-TRIM-LEN
           IF WS-TRIM-LEN > 0
               MOVE WS-CODE-UPPER(WS-TRIM-LEN : 1) TO WS-LAST-CH
           ELSE
               MOVE SPACE TO WS-LAST-CH
           END-IF

           EVALUATE WS-CHALLENGE-ID
               *> Mission 1: PROGRAM-ID. VAULT.
               WHEN 1
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-1 FOR ALL "PROGRAM-ID"
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-2 FOR ALL "VAULT"
                   IF WS-CNT-1 = 0
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  [SYNTAX] Start with PROGRAM-ID. (don't forget the hyphen!)"
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-CNT-2 = 0
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  [SYNTAX] Name the program VAULT (e.g., PROGRAM-ID. VAULT.)."
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-LAST-CH NOT = "."
                       DISPLAY FUNCTION TRIM(C-YLW)
                           "  [ALMOST!] You forgot the period (.) at the very end!"
                           FUNCTION TRIM(C-RST)
                   ELSE
                       MOVE "Y" TO WS-CODE-SOLVED
                   END-IF

               *> Mission 2: 01 BALANCE PIC 9(5)V99.
               WHEN 2
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-1 FOR ALL "01 "
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-2 FOR ALL "BALANCE"
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-3 FOR ALL "PIC"
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-4 FOR ALL "9(5)V99"
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-5 FOR ALL "99999V99"
                   IF WS-CNT-1 = 0
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  [SYNTAX] Begin with level number 01 followed by a space."
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-CNT-2 = 0
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  [SYNTAX] Name the variable BALANCE."
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-CNT-3 = 0
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  [SYNTAX] Include the PIC (or PICTURE) clause!"
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-CNT-4 = 0 AND WS-CNT-5 = 0
                       DISPLAY FUNCTION TRIM(C-YLW)
                           "  [PIC TIP] Use 9(5)V99 -- V is the implied decimal point!"
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-LAST-CH NOT = "."
                       DISPLAY FUNCTION TRIM(C-YLW)
                           "  [ALMOST!] Every DATA DIVISION entry must end with a period (.)."
                           FUNCTION TRIM(C-RST)
                   ELSE
                       MOVE "Y" TO WS-CODE-SOLVED
                   END-IF

               *> Mission 3: MOVE 500 TO BALANCE.
               WHEN 3
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-1 FOR ALL "MOVE "
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-2 FOR ALL "500"
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-3 FOR ALL " TO "
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-4 FOR ALL "BALANCE"
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-EQ FOR ALL "="
                   IF WS-CNT-EQ > 0
                       DISPLAY FUNCTION TRIM(C-YLW)
                           "  [COBOL IDIOM] Instead of '=', COBOL uses: MOVE 500 TO BALANCE."
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-CNT-1 = 0 OR WS-CNT-3 = 0
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  [SYNTAX] Use the verb MOVE <value> TO <variable>."
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-CNT-2 = 0 OR WS-CNT-4 = 0
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  [SYNTAX] Move 500 into BALANCE: MOVE 500 TO BALANCE."
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-LAST-CH NOT = "."
                       DISPLAY FUNCTION TRIM(C-YLW)
                           "  [ALMOST!] Add a period (.) at the end of the sentence!"
                           FUNCTION TRIM(C-RST)
                   ELSE
                       MOVE "Y" TO WS-CODE-SOLVED
                   END-IF

               *> Mission 4: ADD INTEREST TO BALANCE ROUNDED. (or COMPUTE)
               WHEN 4
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-1 FOR ALL "ADD "
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-5 FOR ALL "COMPUTE "
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-2 FOR ALL "INTEREST"
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-3 FOR ALL "BALANCE"
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-4 FOR ALL "ROUNDED"
                   IF WS-CNT-1 = 0 AND WS-CNT-5 = 0
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  [SYNTAX] Start with ADD (or COMPUTE)!"
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-CNT-2 = 0 OR WS-CNT-3 = 0
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  [SYNTAX] Reference both INTEREST and BALANCE."
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-CNT-4 = 0
                       DISPLAY FUNCTION TRIM(C-YLW)
                           "  [BANK RULE] Include the keyword ROUNDED so half-cents round up!"
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-LAST-CH NOT = "."
                       DISPLAY FUNCTION TRIM(C-YLW)
                           "  [ALMOST!] End your statement with a period (.)."
                           FUNCTION TRIM(C-RST)
                   ELSE
                       MOVE "Y" TO WS-CODE-SOLVED
                   END-IF

               *> Mission 5: 88 VIP-CLIENT VALUE "Y".
               WHEN 5
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-1 FOR ALL "88 "
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-2 FOR ALL "VIP-CLIENT"
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-3 FOR ALL "VALUE"
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-4 FOR ALL '"Y"'
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-5 FOR ALL "'Y'"
                   IF WS-CNT-1 = 0
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  [SYNTAX] Condition names use special level number 88!"
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-CNT-2 = 0
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  [SYNTAX] Name the condition VIP-CLIENT."
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-CNT-3 = 0 OR (WS-CNT-4 = 0 AND WS-CNT-5 = 0)
                       DISPLAY FUNCTION TRIM(C-YLW)
                           '  [SYNTAX] Specify VALUE "Y" (quotes around Y).'
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-LAST-CH NOT = "."
                       DISPLAY FUNCTION TRIM(C-YLW)
                           "  [ALMOST!] Finish the 88-level entry with a period (.)."
                           FUNCTION TRIM(C-RST)
                   ELSE
                       MOVE "Y" TO WS-CODE-SOLVED
                   END-IF

               *> Mission 6: PERFORM PRINT-LINE 5 TIMES.
               WHEN 6
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-1 FOR ALL "PERFORM "
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-2 FOR ALL "PRINT-LINE"
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-3 FOR ALL "5"
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-4 FOR ALL "TIMES"
                   IF WS-CNT-1 = 0
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  [SYNTAX] Loops and paragraph calls in COBOL start with PERFORM."
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-CNT-2 = 0
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  [SYNTAX] Target paragraph name is PRINT-LINE."
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-CNT-3 = 0 OR WS-CNT-4 = 0
                       DISPLAY FUNCTION TRIM(C-YLW)
                           "  [SYNTAX] Add '5 TIMES' after PRINT-LINE!"
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-LAST-CH NOT = "."
                       DISPLAY FUNCTION TRIM(C-YLW)
                           "  [ALMOST!] Don't forget the period (.) at the end!"
                           FUNCTION TRIM(C-RST)
                   ELSE
                       MOVE "Y" TO WS-CODE-SOLVED
                   END-IF

               *> Mission 7: 05 MONTH-SALES PIC 9(6) OCCURS 12 TIMES.
               WHEN 7
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-1 FOR ALL "05 "
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-2 FOR ALL "MONTH-SALES"
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-3 FOR ALL "PIC"
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-4 FOR ALL "OCCURS 12"
                   IF WS-CNT-1 = 0 OR WS-CNT-2 = 0
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  [SYNTAX] Start with: 05 MONTH-SALES ..."
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-CNT-3 = 0
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  [SYNTAX] Give each element a picture: PIC 9(6)"
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-CNT-4 = 0
                       DISPLAY FUNCTION TRIM(C-YLW)
                           "  [TABLE TIP] Use OCCURS 12 TIMES to create a 12-element array!"
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-LAST-CH NOT = "."
                       DISPLAY FUNCTION TRIM(C-YLW)
                           "  [ALMOST!] End the table definition with a period (.)."
                           FUNCTION TRIM(C-RST)
                   ELSE
                       MOVE "Y" TO WS-CODE-SOLVED
                   END-IF

               *> Mission 8A: OPEN INPUT PAYROLL-FILE.
               WHEN 8
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-1 FOR ALL "OPEN "
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-2 FOR ALL "INPUT "
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-3 FOR ALL "PAYROLL-FILE"
                   IF WS-CNT-1 = 0 OR WS-CNT-2 = 0
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  [SYNTAX] To read a file, use: OPEN INPUT <file-name>."
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-CNT-3 = 0
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  [SYNTAX] Open PAYROLL-FILE: OPEN INPUT PAYROLL-FILE."
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-LAST-CH NOT = "."
                       DISPLAY FUNCTION TRIM(C-YLW)
                           "  [ALMOST!] Add the closing period (.)!"
                           FUNCTION TRIM(C-RST)
                   ELSE
                       MOVE "Y" TO WS-CODE-SOLVED
                   END-IF

               *> Boss Final Blow: CLOSE PAYROLL-FILE.
               WHEN 9
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-1 FOR ALL "CLOSE "
                   INSPECT WS-CODE-UPPER TALLYING WS-CNT-2 FOR ALL "PAYROLL-FILE"
                   IF WS-CNT-1 = 0 OR WS-CNT-2 = 0
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  [BOSS SHIELD] Release the tape lock with: CLOSE PAYROLL-FILE."
                           FUNCTION TRIM(C-RST)
                   ELSE IF WS-LAST-CH NOT = "."
                       DISPLAY FUNCTION TRIM(C-YLW)
                           "  [ALMOST!] Put the final period (.) to seal the batch!"
                           FUNCTION TRIM(C-RST)
                   ELSE
                       MOVE "Y" TO WS-CODE-SOLVED
                   END-IF
           END-EVALUATE.

       9000-PRESS-ENTER.
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-DIM)
               "  [Press ENTER to continue...]" FUNCTION TRIM(C-RST)
               WITH NO ADVANCING
           ACCEPT WS-PAUSE-DUMMY.

       *> Modular Procedure Copybooks for Story Missions & Interactive Labs
       COPY "missions-proc.cpy".
       COPY "labs-proc.cpy".
