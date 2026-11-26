*> ===================================================================
*> COPYBOOK: quest-state.cpy
*> PURPOSE : Working-Storage player progression, RPG ranks, and
*>           subsystem status table for COBOL QUEST.
*> ===================================================================

       01  WS-GAME-STATE.
           05  WS-PLAYER-NAME          PIC X(20) VALUE "CADET".
           05  WS-PLAYER-XP            PIC 9(5)  VALUE 00000.
           05  WS-PLAYER-STREAK        PIC 9(3)  VALUE 000.
           05  WS-BEST-STREAK          PIC 9(3)  VALUE 000.
           05  WS-BUGS-SQUASHED        PIC 9(3)  VALUE 000.
           05  WS-MISSION-TABLE.
               10  WS-MISSION-DONE     PIC X     OCCURS 8 TIMES
                                                 VALUE "N".
           05  WS-COLOR-MODE           PIC X     VALUE "Y".
               88  COLOR-ENABLED                 VALUE "Y".
               88  COLOR-DISABLED                VALUE "N".

       01  WS-DISPLAY-STATS.
           05  WS-XP-FMT               PIC ZZZ,ZZ9.
           05  WS-STREAK-FMT           PIC ZZ9.
           05  WS-RANK-TITLE           PIC X(26)
                                       VALUE "PUNCH-CARD INTERN".
           05  WS-CORES-ONLINE         PIC 9     VALUE 0.
           05  WS-PROGRESS-BAR         PIC X(16) VALUE SPACES.

       01  WS-SUBSYSTEM-NAMES.
           05  FILLER PIC X(34) VALUE "CORE-01: THE FOUR DIVISIONS       ".
           05  FILLER PIC X(34) VALUE "CORE-02: WORKING-STORAGE & PIC    ".
           05  FILLER PIC X(34) VALUE "CORE-03: MOVE, DISPLAY & ACCEPT   ".
           05  FILLER PIC X(34) VALUE "CORE-04: PENNY-PERFECT MATH       ".
           05  FILLER PIC X(34) VALUE "CORE-05: IF, EVALUATE & LEVEL-88  ".
           05  FILLER PIC X(34) VALUE "CORE-06: PERFORM & LOOPS          ".
           05  FILLER PIC X(34) VALUE "CORE-07: OCCURS TABLES & STRINGS  ".
           05  FILLER PIC X(34) VALUE "CORE-08: FILES & BOSS BATCH JOB   ".
       01  WS-SUBSYSTEM-LIST REDEFINES WS-SUBSYSTEM-NAMES.
           05  WS-SUBSYSTEM-LABEL      PIC X(34) OCCURS 8 TIMES.

       01  WS-SAVE-STATUS              PIC XX    VALUE "00".
       01  WS-SANDBOX-STATUS           PIC XX    VALUE "00".
