       >>SOURCE FORMAT FREE
*> ===================================================================
*> PROGRAM : COBOL-QUEST (ZERO-TO-MASTER MAINFRAME CHRONICLES v2.0)
*> AUTHOR  : Built in 100% GnuCOBOL for Interactive COBOL Learning
*> PURPOSE : Takes a complete newcomer (with ZERO prior programming
*>           experience!) step-by-step to COBOL Mastery through
*>           plain-English lessons, adaptive quizzes, non-spoiler
*>           hints, failure walkthroughs, and 3-variant coding drills!
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
       COPY "drill-engine-data.cpy".

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

       *> Rewards & Arcade Input
       01  WS-REWARD-VARS.
           05  WS-QUIZ-ANS             PIC X(16) VALUE SPACES.
           05  WS-XP-GAIN              PIC 9(4)  VALUE 0.
           05  WS-XP-GAIN-FMT          PIC Z,ZZ9.

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
               "|  \___|\___/|___/ \___/|____|   \__\_\\___/|___|___/ |_|   v2.0     |"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "|                                                                    |"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-YLW)
               "|      ZERO-TO-MASTER EDITION // LEARN COBOL FROM SCRATCH!           |"
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
                               "  [PROFILE LOADED] Welcome back, "
                               FUNCTION TRIM(WS-PLAYER-NAME) "!"
                               FUNCTION TRIM(C-RST)
                           DISPLAY "  Chapters Mastered: "
                               WS-CORES-ONLINE " / 8  |  Rank: "
                               FUNCTION TRIM(WS-RANK-TITLE)
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
               "  Welcome! Never written a single line of code before? Perfect!"
               FUNCTION TRIM(C-RST)
           DISPLAY "  COBOL QUEST teaches you programming from absolute zero all the"
           DISPLAY "  way to COBOL mastery -- using plain English, visual examples,"
           DISPLAY "  concept quizzes, and practice variants until every idea clicks."
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-DIM)
               "  Tip: If color symbols look strange (like <-[1;32m), type C on"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-DIM)
               "       the Main Menu to switch to Clean Plain-ASCII Mode!"
               FUNCTION TRIM(C-RST)
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-YLW)
               "  What name should we print on your learner badge? (ENTER = GRACE-H): "
               FUNCTION TRIM(C-RST) WITH NO ADVANCING
           ACCEPT WS-PLAYER-NAME
           IF WS-PLAYER-NAME = SPACES
               MOVE "GRACE-H" TO WS-PLAYER-NAME
           ELSE
               MOVE FUNCTION UPPER-CASE(WS-PLAYER-NAME) TO WS-PLAYER-NAME
           END-IF
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               "  Welcome aboard, " FUNCTION TRIM(WS-PLAYER-NAME)
               "! Start at [1] on the Main Menu."
               FUNCTION TRIM(C-RST)
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
               "COBOL QUEST // ZERO-TO-MASTER CONSOLE"
               FUNCTION TRIM(C-DIM)
               "      [100% Written in COBOL] "
               FUNCTION TRIM(C-GRN) "|" FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "+--------------------------------------------------------------------+"
               FUNCTION TRIM(C-RST)
           DISPLAY "  Learner  : " FUNCTION TRIM(C-CYN) WS-PLAYER-NAME
               FUNCTION TRIM(C-RST)
               "   XP : " FUNCTION TRIM(C-YLW) WS-XP-FMT
               FUNCTION TRIM(C-RST)
               "   Streak : " FUNCTION TRIM(C-MAG) WS-STREAK-FMT
               FUNCTION TRIM(C-RST)
           DISPLAY "  Rank     : " FUNCTION TRIM(C-GRN) WS-RANK-TITLE
               FUNCTION TRIM(C-RST)
               "   Mastery: [" FUNCTION TRIM(C-GRN) WS-PROGRESS-BAR
               FUNCTION TRIM(C-RST) "] " WS-CORES-ONLINE "/8"
           DISPLAY FUNCTION TRIM(C-GRN)
               "+--------------------------------------------------------------------+"
               FUNCTION TRIM(C-RST)
           DISPLAY "  " FUNCTION TRIM(C-YLW) "[1]" FUNCTION TRIM(C-RST)
               " Zero-to-Master Lessons - 8 Step-by-Step Chapters + Adaptive Code"
           DISPLAY "  " FUNCTION TRIM(C-YLW) "[2]" FUNCTION TRIM(C-RST)
               " Interactive PIC Lab    - Test storage-box shapes & rounding live!"
           DISPLAY "  " FUNCTION TRIM(C-YLW) "[3]" FUNCTION TRIM(C-RST)
               " COBOL Code Generator   - Build & run your own my_sandbox.cob file"
           DISPLAY "  " FUNCTION TRIM(C-YLW) "[4]" FUNCTION TRIM(C-RST)
               " Bug Hunter Arcade      - Spot 4 famous real-world COBOL bugs"
           DISPLAY "  " FUNCTION TRIM(C-YLW) "[5]" FUNCTION TRIM(C-RST)
               " Glossary & Cheat-Sheet - Beginner definitions & quick syntax cards"
           DISPLAY "  " FUNCTION TRIM(C-YLW) "[6]" FUNCTION TRIM(C-RST)
               " Save / Inspect File    - Peek inside your COBOL savegame.dat"
           DISPLAY "  " FUNCTION TRIM(C-YLW) "[C]" FUNCTION TRIM(C-RST)
               " Toggle Color Mode      - Currently: " WS-COLOR-MODE
               " (Y = Phosphor, N = Plain)"
           DISPLAY "  " FUNCTION TRIM(C-YLW) "[Q]" FUNCTION TRIM(C-RST)
               " Save & Quit"
           DISPLAY FUNCTION TRIM(C-GRN)
               "+====================================================================+"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-CYN) "  SELECT (1-6, C, Q)> "
               FUNCTION TRIM(C-RST) WITH NO ADVANCING
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
                   SET SHUTDOWN-NOW TO TRUE
               WHEN SPACES
                   CONTINUE
               WHEN OTHER
                   DISPLAY FUNCTION TRIM(C-RED)
                       "  Please type 1-6, C, or Q and press ENTER."
                       FUNCTION TRIM(C-RST)
                   PERFORM 9000-PRESS-ENTER
           END-EVALUATE.

*> ===================================================================
*> 0400-RECALC-RANK-AND-BAR: Zero-to-Master Progression Ladder!
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
               WHEN WS-PLAYER-XP >= 1500
                   MOVE "COBOL GRANDMASTER"          TO WS-RANK-TITLE
               WHEN WS-PLAYER-XP >= 1100
                   MOVE "SENIOR MAINFRAME ARCHITECT" TO WS-RANK-TITLE
               WHEN WS-PLAYER-XP >= 800
                   MOVE "LOOP & BATCH CONDUCTOR"     TO WS-RANK-TITLE
               WHEN WS-PLAYER-XP >= 550
                   MOVE "LOGIC & LEVEL-88 NAVIGATOR" TO WS-RANK-TITLE
               WHEN WS-PLAYER-XP >= 350
                   MOVE "DECIMAL MATHCRAFTER"        TO WS-RANK-TITLE
               WHEN WS-PLAYER-XP >= 180
                   MOVE "STORAGE BOX BUILDER"        TO WS-RANK-TITLE
               WHEN WS-PLAYER-XP >= 60
                   MOVE "FIRST-LINE APPRENTICE"      TO WS-RANK-TITLE
               WHEN OTHER
                   MOVE "NEWCOMER (ZERO EXP)"        TO WS-RANK-TITLE
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
               " XP | Rank: " FUNCTION TRIM(WS-RANK-TITLE) " ***"
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
           DISPLAY "  Here is how COBOL stores your profile in fixed-size boxes:"
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
           DISPLAY "  Notice how COBOL fixed-width records need NO commas or brackets"
           DISPLAY "  -- every box has an exact width defined by its PIC clause!"
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
                   "  Profile reset to 0 XP (NEWCOMER)."
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
               "  [SESSION SAVED] Great work today, "
               FUNCTION TRIM(WS-PLAYER-NAME) "!"
               FUNCTION TRIM(C-RST)
           DISPLAY "  Open the examples/ folder anytime to inspect real .cob programs!"
           DISPLAY " ".

       9000-PRESS-ENTER.
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-DIM)
               "  [Press ENTER to continue...]" FUNCTION TRIM(C-RST)
               WITH NO ADVANCING
           ACCEPT WS-PAUSE-DUMMY.

       *> Modular Procedure Copybooks
       COPY "drill-engine-proc.cpy".
       COPY "chapters-1-to-4.cpy".
       COPY "chapters-5-to-8.cpy".
       COPY "labs-proc.cpy".
