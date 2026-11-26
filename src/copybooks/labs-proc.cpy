*> ===================================================================
*> COPYBOOK: labs-proc.cpy
*> PURPOSE : Interactive PIC & Math Lab, Live .cob Code Generator,
*>           Bug Hunter Arcade, and Mainframe Pocket Reference Deck!
*> ===================================================================

*> ===================================================================
*> 5000-INTERACTIVE-PIC-LAB: Live COBOL PICTURE Formatting Sandbox!
*> ===================================================================
       5000-INTERACTIVE-PIC-LAB.
           MOVE SPACES TO WS-LAB-INPUT
           PERFORM UNTIL FUNCTION UPPER-CASE(FUNCTION TRIM(WS-LAB-INPUT)) = "B"
                      OR SHUTDOWN-NOW
               PERFORM 0150-CLEAR-SCREEN
               DISPLAY FUNCTION TRIM(C-CYN)
                   "+============= INTERACTIVE PIC & FIXED-POINT LAB ==============+"
                   FUNCTION TRIM(C-RST)
               DISPLAY "  Type ANY number (e.g. 1234.56, -89.5, 42, 99999.995) to watch"
               DISPLAY "  real COBOL MOVE & COMPUTE statements format it live!"
               DISPLAY "  (Type B to return to Main Hub)"
               DISPLAY " "
               DISPLAY FUNCTION TRIM(C-YLW) "  ENTER NUMBER (or B)> "
                   FUNCTION TRIM(C-RST) WITH NO ADVANCING
               ACCEPT WS-LAB-INPUT

               IF FUNCTION TRIM(WS-LAB-INPUT) = SPACES
                   ADD 1 TO WS-EMPTY-GUARD
                   IF WS-EMPTY-GUARD > 15 SET SHUTDOWN-NOW TO TRUE END-IF
               ELSE
                   MOVE 0 TO WS-EMPTY-GUARD
               END-IF

               IF FUNCTION UPPER-CASE(FUNCTION TRIM(WS-LAB-INPUT)) NOT = "B"
                  AND FUNCTION TRIM(WS-LAB-INPUT) NOT = SPACES
                   IF FUNCTION TEST-NUMVAL(WS-LAB-INPUT) = 0
                       COMPUTE WS-LAB-DEC = FUNCTION NUMVAL(WS-LAB-INPUT)
                       MOVE WS-LAB-DEC TO WS-PIC-INT
                       MOVE WS-LAB-DEC TO WS-PIC-V99
                       MOVE WS-LAB-DEC TO WS-PIC-ZERO
                       MOVE WS-LAB-DEC TO WS-PIC-CHECK
                       MOVE WS-LAB-DEC TO WS-PIC-SIGN
                       MOVE WS-LAB-DEC TO WS-PIC-CR

                       COMPUTE WS-DIV-TRUNC         = WS-LAB-DEC / 3
                       COMPUTE WS-DIV-ROUND ROUNDED = WS-LAB-DEC / 3
                       MOVE WS-DIV-TRUNC TO WS-DIV-DISP-1
                       MOVE WS-DIV-ROUND TO WS-DIV-DISP-2

                       DISPLAY " "
                       DISPLAY FUNCTION TRIM(C-GRN)
                           "  LIVE COBOL WORKING-STORAGE MEMORY RESULTS:"
                           FUNCTION TRIM(C-RST)
                       DISPLAY "  +---------------------+----------------+--------------------------+"
                       DISPLAY "  | COBOL PIC CLAUSE    | LIVE OUTPUT    | WHAT COBOL DID           |"
                       DISPLAY "  +---------------------+----------------+--------------------------+"
                       DISPLAY "  | PIC 9(6)            | [" WS-PIC-INT     "]       | Unsigned integer (pad 0) |"
                       DISPLAY "  | PIC 9(5)V99 (RAM!)  | [" WS-PIC-V99-RAW "]      | Implied V = 0 RAM bytes! |"
                       DISPLAY "  | PIC ZZZ,ZZ9.99      | [" WS-PIC-ZERO    "]   | Suppress leading zeros   |"
                       DISPLAY "  | PIC $***,**9.99-    | [" WS-PIC-CHECK   "] | Bank check protection *  |"
                       DISPLAY "  | PIC +ZZZ,ZZ9.99     | [" WS-PIC-SIGN    "]  | Always show + or - sign  |"
                       DISPLAY "  | PIC ZZZ,ZZ9.99CR    | [" WS-PIC-CR      "] | Accounting CR if < 0!    |"
                       DISPLAY "  +---------------------+----------------+--------------------------+"
                       DISPLAY "  FIXED-POINT DIVISION BY 3 DEMO:"
                       DISPLAY "    Without ROUNDED : [" WS-DIV-DISP-1 "]"
                       DISPLAY "    With ROUNDED    : [" WS-DIV-DISP-2 "]"
                       MOVE 15 TO WS-XP-GAIN
                       PERFORM 0450-AWARD-XP
                       PERFORM 9000-PRESS-ENTER
                   ELSE
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  That wasn't a valid number! Try e.g. 1234.56 or -42.50"
                           FUNCTION TRIM(C-RST)
                       PERFORM 9000-PRESS-ENTER
                   END-IF
               END-IF
           END-PERFORM.

*> ===================================================================
*> 5500-COBOL-CODE-GENERATOR: Generates a real runnable my_sandbox.cob!
*> ===================================================================
       5500-COBOL-CODE-GENERATOR.
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "+============ LIVE COBOL SANDBOX & CODE GENERATOR =============+"
               FUNCTION TRIM(C-RST)
           DISPLAY "  Let's build a real standalone COBOL program (my_sandbox.cob)"
           DISPLAY "  customized with YOUR parameters, save it to disk, and run its"
           DISPLAY "  exact fixed-point compound interest logic live!"
           DISPLAY " "

           DISPLAY "  1. Program ID (press ENTER for MYBANK): " WITH NO ADVANCING
           ACCEPT WS-GEN-PROG
           IF WS-GEN-PROG = SPACES
               MOVE "MYBANK" TO WS-GEN-PROG
           ELSE
               MOVE FUNCTION UPPER-CASE(FUNCTION TRIM(WS-GEN-PROG)) TO WS-GEN-PROG
           END-IF

           DISPLAY "  2. Starting Deposit $ (press ENTER for 1000.00): " WITH NO ADVANCING
           ACCEPT WS-GEN-DEP-STR
           IF FUNCTION TRIM(WS-GEN-DEP-STR) = SPACES
               MOVE 1000.00 TO WS-GEN-DEPOSIT
           ELSE IF FUNCTION TEST-NUMVAL(WS-GEN-DEP-STR) = 0
               COMPUTE WS-GEN-DEPOSIT = FUNCTION NUMVAL(WS-GEN-DEP-STR)
           ELSE
               MOVE 1000.00 TO WS-GEN-DEPOSIT
           END-IF

           DISPLAY "  3. Annual Interest % (press ENTER for 5.25): " WITH NO ADVANCING
           ACCEPT WS-GEN-RATE-STR
           IF FUNCTION TRIM(WS-GEN-RATE-STR) = SPACES
               MOVE 05.25 TO WS-GEN-RATE
           ELSE IF FUNCTION TEST-NUMVAL(WS-GEN-RATE-STR) = 0
               COMPUTE WS-GEN-RATE = FUNCTION NUMVAL(WS-GEN-RATE-STR)
           ELSE
               MOVE 05.25 TO WS-GEN-RATE
           END-IF

           DISPLAY "  4. Years to Compound 1-20 (press ENTER for 5): " WITH NO ADVANCING
           ACCEPT WS-GEN-YRS-STR
           IF FUNCTION TRIM(WS-GEN-YRS-STR) = SPACES
               MOVE 05 TO WS-GEN-YEARS
           ELSE IF FUNCTION TEST-NUMVAL(WS-GEN-YRS-STR) = 0
               COMPUTE WS-GEN-YEARS = FUNCTION NUMVAL(WS-GEN-YRS-STR)
               IF WS-GEN-YEARS < 1 OR WS-GEN-YEARS > 20
                   MOVE 05 TO WS-GEN-YEARS
               END-IF
           ELSE
               MOVE 05 TO WS-GEN-YEARS
           END-IF

           MOVE WS-GEN-DEPOSIT TO WS-GEN-DEP-CLEAN
           MOVE WS-GEN-RATE    TO WS-GEN-RATE-CLEAN
           MOVE WS-GEN-YEARS   TO WS-GEN-YRS-CLEAN

           *> Write actual runnable COBOL source file to my_sandbox.cob!
           OPEN OUTPUT SANDBOX-FILE
           IF WS-SANDBOX-STATUS = "00"
               MOVE "       >>SOURCE FORMAT FREE" TO SANDBOX-LINE
               WRITE SANDBOX-LINE
               MOVE "*> Generated by COBOL QUEST Sandbox!" TO SANDBOX-LINE
               WRITE SANDBOX-LINE
               MOVE "       IDENTIFICATION DIVISION." TO SANDBOX-LINE
               WRITE SANDBOX-LINE
               MOVE SPACES TO SANDBOX-LINE
               STRING "       PROGRAM-ID. " FUNCTION TRIM(WS-GEN-PROG) "."
                   DELIMITED BY SIZE INTO SANDBOX-LINE
               WRITE SANDBOX-LINE
               MOVE "       DATA DIVISION." TO SANDBOX-LINE
               WRITE SANDBOX-LINE
               MOVE "       WORKING-STORAGE SECTION." TO SANDBOX-LINE
               WRITE SANDBOX-LINE
               MOVE SPACES TO SANDBOX-LINE
               STRING "       01 WS-BALANCE  PIC 9(7)V99 VALUE "
                   WS-GEN-DEP-CLEAN "." DELIMITED BY SIZE INTO SANDBOX-LINE
               WRITE SANDBOX-LINE
               MOVE SPACES TO SANDBOX-LINE
               STRING "       01 WS-RATE     PIC 9(2)V99 VALUE "
                   WS-GEN-RATE-CLEAN "." DELIMITED BY SIZE INTO SANDBOX-LINE
               WRITE SANDBOX-LINE
               MOVE "       01 WS-INTEREST PIC 9(6)V99 VALUE 0." TO SANDBOX-LINE
               WRITE SANDBOX-LINE
               MOVE "       01 WS-YEAR     PIC 99      VALUE 1." TO SANDBOX-LINE
               WRITE SANDBOX-LINE
               MOVE "       01 WS-OUT-BAL  PIC $Z,ZZZ,ZZ9.99." TO SANDBOX-LINE
               WRITE SANDBOX-LINE
               MOVE "       PROCEDURE DIVISION." TO SANDBOX-LINE
               WRITE SANDBOX-LINE
               MOVE SPACES TO SANDBOX-LINE
               STRING "           PERFORM VARYING WS-YEAR FROM 1 BY 1 UNTIL WS-YEAR > "
                   WS-GEN-YRS-CLEAN DELIMITED BY SIZE INTO SANDBOX-LINE
               WRITE SANDBOX-LINE
               MOVE "               COMPUTE WS-INTEREST ROUNDED =" TO SANDBOX-LINE
               WRITE SANDBOX-LINE
               MOVE "                   WS-BALANCE * (WS-RATE / 100)" TO SANDBOX-LINE
               WRITE SANDBOX-LINE
               MOVE "               ADD WS-INTEREST TO WS-BALANCE" TO SANDBOX-LINE
               WRITE SANDBOX-LINE
               MOVE "               MOVE WS-BALANCE TO WS-OUT-BAL" TO SANDBOX-LINE
               WRITE SANDBOX-LINE
               MOVE '               DISPLAY "Year " WS-YEAR ": " WS-OUT-BAL'
                   TO SANDBOX-LINE
               WRITE SANDBOX-LINE
               MOVE "           END-PERFORM" TO SANDBOX-LINE
               WRITE SANDBOX-LINE
               MOVE "           STOP RUN." TO SANDBOX-LINE
               WRITE SANDBOX-LINE
               CLOSE SANDBOX-FILE
           END-IF

           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               "  [FILE WRITTEN] Saved runnable COBOL source to: my_sandbox.cob!"
               FUNCTION TRIM(C-RST)
           DISPLAY "  [LIVE EXECUTION PREVIEW OF " FUNCTION TRIM(WS-GEN-PROG) "]:"
           DISPLAY "  --------------------------------------------------------"

           MOVE WS-GEN-DEPOSIT TO WS-GEN-CUR-BAL
           PERFORM VARYING WS-GEN-YR-IDX FROM 1 BY 1
                   UNTIL WS-GEN-YR-IDX > WS-GEN-YEARS
               COMPUTE WS-GEN-INT ROUNDED =
                   WS-GEN-CUR-BAL * (WS-GEN-RATE / 100)
               ADD WS-GEN-INT     TO WS-GEN-CUR-BAL
               MOVE WS-GEN-YR-IDX  TO WS-GEN-YR-FMT
               MOVE WS-GEN-INT     TO WS-GEN-INT-FMT
               MOVE WS-GEN-CUR-BAL TO WS-GEN-BAL-FMT
               DISPLAY "    Year " WS-GEN-YR-FMT
                   " | Interest: +" WS-GEN-INT-FMT
                   " | Balance: " FUNCTION TRIM(C-YLW) WS-GEN-BAL-FMT
                   FUNCTION TRIM(C-RST)
           END-PERFORM

           DISPLAY "  --------------------------------------------------------"
           DISPLAY "  Open " FUNCTION TRIM(C-CYN) "my_sandbox.cob"
               FUNCTION TRIM(C-RST) " in any text editor to inspect the code,"
           DISPLAY "  or compile it with: cobc -x -free my_sandbox.cob"
           MOVE 40 TO WS-XP-GAIN
           PERFORM 0450-AWARD-XP
           PERFORM 0900-SAVE-GAME-QUIET
           PERFORM 9000-PRESS-ENTER.

*> ===================================================================
*> 6000-BUG-HUNTER-ARCADE: Diagnose Famous Real-World COBOL Bugs!
*> ===================================================================
       6000-BUG-HUNTER-ARCADE.
           MOVE 0 TO WS-BUG-SCORE
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-MAG)
               "+================ BUG HUNTER ARCADE (4 ROUNDS) ================+"
               FUNCTION TRIM(C-RST)
           DISPLAY "  Spot the production mainframe bug in each snippet to earn XP!"
           DISPLAY " "

           *> Bug 1: Rogue Period
           DISPLAY FUNCTION TRIM(C-YLW) "  BUG #1: THE ROGUE PERIOD"
               FUNCTION TRIM(C-RST)
           DISPLAY "    IF USER-IS-ADMIN"
           DISPLAY '        DISPLAY "Admin logged in".'
           DISPLAY "        PERFORM WIPE-ALL-DATABASES"
           DISPLAY "  Why did WIPE-ALL-DATABASES execute for a regular non-admin user?!"
           DISPLAY "    [A] DISPLAY always wipes databases"
           DISPLAY "    [B] The period after ""Admin logged in"". ended the IF block!"
           DISPLAY "    [C] PERFORM runs before IF"
           DISPLAY FUNCTION TRIM(C-CYN) "  DIAGNOSIS (A/B/C)> "
               FUNCTION TRIM(C-RST) WITH NO ADVANCING
           ACCEPT WS-QUIZ-ANS
           IF FUNCTION UPPER-CASE(FUNCTION TRIM(WS-QUIZ-ANS)) = "B"
               ADD 1 TO WS-BUG-SCORE
               ADD 1 TO WS-BUGS-SQUASHED
               DISPLAY FUNCTION TRIM(C-GRN)
                   "  SQUASHED! Remove that period and end the block with END-IF!"
                   FUNCTION TRIM(C-RST)
           ELSE
               DISPLAY FUNCTION TRIM(C-RED)
                   "  Missed! That sneaky period closed the IF statement early!"
                   FUNCTION TRIM(C-RST)
           END-IF

           *> Bug 2: Y2K 2-digit year
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-YLW) "  BUG #2: THE CLASSIC Y2K BUG (1999 -> 2000)"
               FUNCTION TRIM(C-RST)
           DISPLAY "    01 BIRTH-YEAR   PIC 99 VALUE 75."
           DISPLAY "    01 CURRENT-YEAR PIC 99 VALUE 00."
           DISPLAY "    COMPUTE AGE = CURRENT-YEAR - BIRTH-YEAR."
           DISPLAY "  Why did a 25-year-old customer get age +75 (or -75 stripped)?"
           DISPLAY "    [A] Two-digit PIC 99 rolled 2000 to 00 (fix: PIC 9(4) YYYY!)"
           DISPLAY "    [B] COMPUTE cannot subtract"
           DISPLAY "    [C] VALUE 75 is hex"
           DISPLAY FUNCTION TRIM(C-CYN) "  DIAGNOSIS (A/B/C)> "
               FUNCTION TRIM(C-RST) WITH NO ADVANCING
           ACCEPT WS-QUIZ-ANS
           IF FUNCTION UPPER-CASE(FUNCTION TRIM(WS-QUIZ-ANS)) = "A"
               ADD 1 TO WS-BUG-SCORE
               ADD 1 TO WS-BUGS-SQUASHED
               DISPLAY FUNCTION TRIM(C-GRN)
                   "  SQUASHED! Expanding PIC 99 to PIC 9(4) saved the world in 1999!"
                   FUNCTION TRIM(C-RST)
           ELSE
               DISPLAY FUNCTION TRIM(C-RED)
                   "  Missed! PIC 99 stored only 2 year digits (00 - 75 = -75 -> 75)!"
                   FUNCTION TRIM(C-RST)
           END-IF

           *> Bug 3: Literal decimal in WORKING-STORAGE math
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-YLW) "  BUG #3: '.' VS 'V' IN NUMERIC MATH"
               FUNCTION TRIM(C-RST)
           DISPLAY "    01 ITEM-PRICE   PIC $999.99."
           DISPLAY "    ADD 10.00 TO ITEM-PRICE."
           DISPLAY "  Why does the compiler reject ADD on ITEM-PRICE?"
           DISPLAY "    [A] Numbers over 100 cannot be added"
           DISPLAY "    [B] '$' and '.' make it an EDITED display field; do math on"
           DISPLAY "        PIC S9(3)V99 first, then MOVE to PIC $ZZ9.99 for output!"
           DISPLAY "    [C] ADD requires MULTIPLY"
           DISPLAY FUNCTION TRIM(C-CYN) "  DIAGNOSIS (A/B/C)> "
               FUNCTION TRIM(C-RST) WITH NO ADVANCING
           ACCEPT WS-QUIZ-ANS
           IF FUNCTION UPPER-CASE(FUNCTION TRIM(WS-QUIZ-ANS)) = "B"
               ADD 1 TO WS-BUG-SCORE
               ADD 1 TO WS-BUGS-SQUASHED
               DISPLAY FUNCTION TRIM(C-GRN)
                   "  SQUASHED! Keep math fields (V) separate from print fields (.)!"
                   FUNCTION TRIM(C-RST)
           ELSE
               DISPLAY FUNCTION TRIM(C-RED)
                   "  Missed! '$' and '.' create numeric-edited report items!"
                   FUNCTION TRIM(C-RST)
           END-IF

           *> Bug 4: Column 73 truncation in Fixed Format
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-YLW) "  BUG #4: THE INVISIBLE COLUMN-73 CLIFF"
               FUNCTION TRIM(C-RST)
           DISPLAY "  In legacy Fixed-Format COBOL, a programmer wrote a long line"
           DISPLAY "  whose closing period landed in Column 74. What happened?"
           DISPLAY "    [A] Classic punch-card Fixed Format ignores Columns 73-80!"
           DISPLAY "    [B] Column 74 runs twice as fast"
           DISPLAY "    [C] Everything turns uppercase"
           DISPLAY FUNCTION TRIM(C-CYN) "  DIAGNOSIS (A/B/C)> "
               FUNCTION TRIM(C-RST) WITH NO ADVANCING
           ACCEPT WS-QUIZ-ANS
           IF FUNCTION UPPER-CASE(FUNCTION TRIM(WS-QUIZ-ANS)) = "A"
               ADD 1 TO WS-BUG-SCORE
               ADD 1 TO WS-BUGS-SQUASHED
               DISPLAY FUNCTION TRIM(C-GRN)
                   "  SQUASHED! Cols 73-80 were card-deck IDs (or use >>SOURCE FORMAT FREE)!"
                   FUNCTION TRIM(C-RST)
           ELSE
               DISPLAY FUNCTION TRIM(C-RED)
                   "  Missed! In Fixed Format, Columns 73-80 are ignored by the compiler!"
                   FUNCTION TRIM(C-RST)
           END-IF

           DISPLAY " "
           DISPLAY "  ARCADE COMPLETE! You squashed " WS-BUG-SCORE " / 4 bugs!"
           COMPUTE WS-XP-GAIN = WS-BUG-SCORE * 30 + 10
           PERFORM 0450-AWARD-XP
           PERFORM 0900-SAVE-GAME-QUIET
           PERFORM 9000-PRESS-ENTER.

*> ===================================================================
*> 7000-POCKET-REFERENCE: Quick COBOL Cheat-Sheets & History
*> ===================================================================
       7000-POCKET-REFERENCE.
           MOVE SPACES TO WS-REF-CHOICE
           PERFORM UNTIL WS-REF-CHOICE = "B" OR SHUTDOWN-NOW
               PERFORM 0150-CLEAR-SCREEN
               DISPLAY FUNCTION TRIM(C-CYN)
                   "+============= MAINFRAME POCKET REFERENCE DECK ================+"
                   FUNCTION TRIM(C-RST)
               DISPLAY "  [1] Minimal Program Skeleton (Copy-Paste Ready!)"
               DISPLAY "  [2] Complete PIC (PICTURE) Symbol Decoder"
               DISPLAY "  [3] Essential COBOL Verbs & Scope Terminators"
               DISPLAY "  [4] Admiral Grace Hopper & Why COBOL Still Rules Finance"
               DISPLAY "  [B] Back to Main Hub"
               DISPLAY " "
               DISPLAY FUNCTION TRIM(C-CYN) "  CARD> " FUNCTION TRIM(C-RST)
                   WITH NO ADVANCING
               ACCEPT WS-REF-CHOICE
               MOVE FUNCTION UPPER-CASE(FUNCTION TRIM(WS-REF-CHOICE))
                   TO WS-REF-CHOICE

               IF WS-REF-CHOICE = SPACES
                   ADD 1 TO WS-EMPTY-GUARD
                   IF WS-EMPTY-GUARD > 15 SET SHUTDOWN-NOW TO TRUE END-IF
               ELSE
                   MOVE 0 TO WS-EMPTY-GUARD
               END-IF

               EVALUATE WS-REF-CHOICE
                   WHEN "1"
                       DISPLAY " "
                       DISPLAY FUNCTION TRIM(C-GRN)
                           "  --- MINIMAL FREE-FORMAT COBOL PROGRAM ---"
                           FUNCTION TRIM(C-RST)
                       DISPLAY "       >>SOURCE FORMAT FREE"
                       DISPLAY "       IDENTIFICATION DIVISION."
                       DISPLAY "       PROGRAM-ID. HELLO-COBOL."
                       DISPLAY "       DATA DIVISION."
                       DISPLAY "       WORKING-STORAGE SECTION."
                       DISPLAY '       01 WS-NAME PIC X(15) VALUE "WORLD".'
                       DISPLAY "       PROCEDURE DIVISION."
                       DISPLAY '           DISPLAY "HELLO, " FUNCTION TRIM(WS-NAME) "!"'
                       DISPLAY "           STOP RUN."
                       PERFORM 9000-PRESS-ENTER
                   WHEN "2"
                       DISPLAY " "
                       DISPLAY FUNCTION TRIM(C-GRN)
                           "  --- COMPLETE PIC SYMBOL DECODER ---"
                           FUNCTION TRIM(C-RST)
                       DISPLAY "  9  : Digit (0-9)              | 9(4)      -> 4 digits"
                       DISPLAY "  X  : Any character            | X(10)     -> 10-char text"
                       DISPLAY "  A  : Alphabetic (A-Z, space)  | A(5)      -> letters only"
                       DISPLAY "  S  : Operational sign (+/-)   | S9(5)V99  -> signed math!"
                       DISPLAY "  V  : Implied decimal (0 bytes)| 999V99    -> 123.45 math"
                       DISPLAY "  Z  : Suppress leading zero    | ZZZ9      -> '  42'"
                       DISPLAY "  $  : Currency symbol          | $ZZ,ZZ9.99-> '$  1,234.56'"
                       DISPLAY "  *  : Check-protect asterisk   | $**,**9.99-> '$**1,234.56'"
                       PERFORM 9000-PRESS-ENTER
                   WHEN "3"
                       DISPLAY " "
                       DISPLAY FUNCTION TRIM(C-GRN)
                           "  --- ESSENTIAL VERBS & MODERN TERMINATORS ---"
                           FUNCTION TRIM(C-RST)
                       DISPLAY "  I/O   : DISPLAY, ACCEPT, OPEN, READ ... END-READ, WRITE, CLOSE"
                       DISPLAY "  DATA  : MOVE a TO b, INITIALIZE rec, SET flag TO TRUE"
                       DISPLAY "  MATH  : ADD, SUBTRACT, MULTIPLY, DIVIDE, COMPUTE ... END-COMPUTE"
                       DISPLAY "  LOGIC : IF ... ELSE ... END-IF | EVALUATE ... END-EVALUATE"
                       DISPLAY "  LOOPS : PERFORM para | PERFORM UNTIL ... END-PERFORM"
                       DISPLAY "  TEXT  : STRING, UNSTRING, INSPECT, FUNCTION TRIM / UPPER-CASE"
                       PERFORM 9000-PRESS-ENTER
                   WHEN "4"
                       DISPLAY " "
                       DISPLAY FUNCTION TRIM(C-GRN)
                           "  --- GRACE HOPPER & BIG IRON LORE ---"
                           FUNCTION TRIM(C-RST)
                       DISPLAY "  * Rear Admiral Grace Hopper (1906-1992) created FLOW-MATIC,"
                       DISPLAY "    proving computers could be programmed in English words"
                       DISPLAY "    rather than raw machine octal/assembly -- inspiring COBOL"
                       DISPLAY "    at the 1959 CODASYL conference!"
                       DISPLAY "  * Over 200+ BILLION lines of COBOL run in production today,"
                       DISPLAY "    powering banks, insurers, airlines, and government agencies."
                       DISPLAY "  * Every example taught in COBOL QUEST has a real runnable"
                       DISPLAY "    .cob source file waiting for you in the examples/ folder!"
                       PERFORM 9000-PRESS-ENTER
                   WHEN "B"
                   WHEN "0"
                   WHEN "Q"
                       MOVE "B" TO WS-REF-CHOICE
                   WHEN OTHER
                       CONTINUE
               END-EVALUATE
           END-PERFORM.
