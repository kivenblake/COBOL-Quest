*> ===================================================================
*> COPYBOOK: missions-proc.cpy
*> PURPOSE : Story Mission Selector + 8 Interactive COBOL Chapters
*>           + Midnight Payroll Batch Boss Encounter!
*> ===================================================================

       1000-MISSION-SELECT-MENU.
           MOVE SPACES TO WS-UPPER-CHOICE
           PERFORM UNTIL WS-UPPER-CHOICE = "B" OR SHUTDOWN-NOW
               PERFORM 0400-RECALC-RANK-AND-BAR
               PERFORM 0150-CLEAR-SCREEN
               DISPLAY FUNCTION TRIM(C-GRN)
                   "+=================== SUBSYSTEM RESTORATION BAY ====================+"
                   FUNCTION TRIM(C-RST)
               DISPLAY "  Select any IRON-7090 Subsystem Mission (1-8) in order or jump in!"
               DISPLAY FUNCTION TRIM(C-GRN)
                   "+------------------------------------------------------------------+"
                   FUNCTION TRIM(C-RST)
               PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 8
                   MOVE WS-IDX TO WS-IDX-DISP
                   IF WS-MISSION-DONE(WS-IDX) = "Y"
                       DISPLAY "   " FUNCTION TRIM(C-YLW) "[" WS-IDX-DISP "]"
                           FUNCTION TRIM(C-RST) " " WS-SUBSYSTEM-LABEL(WS-IDX)
                           "  " FUNCTION TRIM(C-GRN) "[ONLINE]"
                           FUNCTION TRIM(C-RST)
                   ELSE
                       DISPLAY "   " FUNCTION TRIM(C-YLW) "[" WS-IDX-DISP "]"
                           FUNCTION TRIM(C-RST) " " WS-SUBSYSTEM-LABEL(WS-IDX)
                           "  " FUNCTION TRIM(C-RED) "[OFFLINE]"
                           FUNCTION TRIM(C-RST)
                   END-IF
               END-PERFORM
               DISPLAY FUNCTION TRIM(C-GRN)
                   "+------------------------------------------------------------------+"
                   FUNCTION TRIM(C-RST)
               DISPLAY "   " FUNCTION TRIM(C-YLW) "[B]" FUNCTION TRIM(C-RST)
                   " Back to Main Hub"
               DISPLAY " "
               DISPLAY FUNCTION TRIM(C-CYN) "  MISSION> " FUNCTION TRIM(C-RST)
                   WITH NO ADVANCING
               ACCEPT WS-MENU-CHOICE
               MOVE FUNCTION UPPER-CASE(FUNCTION TRIM(WS-MENU-CHOICE))
                   TO WS-UPPER-CHOICE

               IF WS-UPPER-CHOICE = SPACES
                   ADD 1 TO WS-EMPTY-GUARD
                   IF WS-EMPTY-GUARD > 15
                       SET SHUTDOWN-NOW TO TRUE
                   END-IF
               ELSE
                   MOVE 0 TO WS-EMPTY-GUARD
               END-IF

               EVALUATE WS-UPPER-CHOICE
                   WHEN "1" PERFORM 2100-MISSION-1
                   WHEN "2" PERFORM 2200-MISSION-2
                   WHEN "3" PERFORM 2300-MISSION-3
                   WHEN "4" PERFORM 2400-MISSION-4
                   WHEN "5" PERFORM 2500-MISSION-5
                   WHEN "6" PERFORM 2600-MISSION-6
                   WHEN "7" PERFORM 2700-MISSION-7
                   WHEN "8" PERFORM 2800-MISSION-8
                   WHEN "B"
                   WHEN "0"
                   WHEN "Q"
                       MOVE "B" TO WS-UPPER-CHOICE
                   WHEN SPACES
                       CONTINUE
                   WHEN OTHER
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  Enter 1 through 8, or B to go back."
                           FUNCTION TRIM(C-RST)
                       PERFORM 9000-PRESS-ENTER
               END-EVALUATE
           END-PERFORM.

       1900-COMPLETE-MISSION.
           IF SHUTDOWN-NOW
               EXIT PARAGRAPH
           END-IF
           DISPLAY " "
           IF WS-MISSION-DONE(WS-MISSION-NUM) = "N"
               MOVE "Y" TO WS-MISSION-DONE(WS-MISSION-NUM)
               MOVE 150 TO WS-XP-GAIN
               DISPLAY FUNCTION TRIM(C-GRN)
                   "  +============================================================+"
                   FUNCTION TRIM(C-RST)
               DISPLAY FUNCTION TRIM(C-GRN)
                   "  |  SUBSYSTEM RESTORED! IRON-7090 CORE BROUGHT BACK ONLINE!   |"
                   FUNCTION TRIM(C-RST)
               DISPLAY FUNCTION TRIM(C-GRN)
                   "  +============================================================+"
                   FUNCTION TRIM(C-RST)
               PERFORM 0450-AWARD-XP
           ELSE
               MOVE 25 TO WS-XP-GAIN
               DISPLAY FUNCTION TRIM(C-CYN)
                   "  [REFRESHER COMPLETE] Subsystem calibrated!"
                   FUNCTION TRIM(C-RST)
               PERFORM 0450-AWARD-XP
           END-IF
           PERFORM 0900-SAVE-GAME-QUIET
           IF WS-CORES-ONLINE = 8 AND WS-MISSION-NUM = 8
               PERFORM 2900-VICTORY-CERTIFICATE
           ELSE
               PERFORM 9000-PRESS-ENTER
           END-IF.

*> ===================================================================
*> MISSION 1: THE FOUR DIVISIONS & PUNCH-CARD HERITAGE
*> ===================================================================
       2100-MISSION-1.
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== MISSION 1: CORE-01 // THE FOUR DIVISIONS OF COBOL ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  COBOL stands for " FUNCTION TRIM(C-YLW)
               "COmmon Business-Oriented Language" FUNCTION TRIM(C-RST) " (1959)."
           DISPLAY "  Every COBOL program is organized like an English outline into"
           DISPLAY "  up to FOUR DIVISIONS -- always in this exact order:"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               "    1. IDENTIFICATION DIVISION.  *> Who is this program?"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "    2. ENVIRONMENT DIVISION.     *> What files/OS are connected?"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "    3. DATA DIVISION.            *> What variables & records exist?"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "    4. PROCEDURE DIVISION.       *> What actions run step-by-step?"
               FUNCTION TRIM(C-RST)
           DISPLAY " "
           DISPLAY "  Notice the " FUNCTION TRIM(C-YLW) "PERIOD (.)"
               FUNCTION TRIM(C-RST) " at the end of headers and sentences!"
           DISPLAY "  In classic 80-column punch cards:"
           DISPLAY "    Cols 1-6: Sequence # | Col 7: '*' for comment | Cols 8-72: Code"
           DISPLAY "  In modern Free Format (>>SOURCE FORMAT FREE), '*>' starts comments"
           DISPLAY "  anywhere on a line! Check examples/01-hello-mainframe.cob to see"
           DISPLAY "  classic punch-card column format in action."
           PERFORM 9000-PRESS-ENTER

           *> Stage B: Quiz
           MOVE "N" TO WS-QUIZ-DONE
           PERFORM UNTIL WS-QUIZ-DONE = "Y" OR SHUTDOWN-NOW
               DISPLAY " "
               DISPLAY FUNCTION TRIM(C-YLW)
                   "  [DIAGNOSTIC QUIZ 1/8]" FUNCTION TRIM(C-RST)
               DISPLAY "  Which COBOL division is the ONLY required header to name"
               DISPLAY "  a minimal modern COBOL program?"
               DISPLAY "    [A] PROCEDURE DIVISION"
               DISPLAY "    [B] IDENTIFICATION DIVISION (with PROGRAM-ID.)"
               DISPLAY "    [C] ARITHMETIC DIVISION"
               DISPLAY FUNCTION TRIM(C-CYN) "  ANSWER (A/B/C)> "
                   FUNCTION TRIM(C-RST) WITH NO ADVANCING
               ACCEPT WS-QUIZ-ANS
               MOVE FUNCTION UPPER-CASE(FUNCTION TRIM(WS-QUIZ-ANS)) TO WS-QUIZ-ANS
               IF WS-QUIZ-ANS = SPACES
                   ADD 1 TO WS-EMPTY-GUARD
                   IF WS-EMPTY-GUARD > 15 SET SHUTDOWN-NOW TO TRUE END-IF
               ELSE
                   MOVE 0 TO WS-EMPTY-GUARD
               END-IF
               EVALUATE WS-QUIZ-ANS
                   WHEN "B"
                       DISPLAY FUNCTION TRIM(C-GRN)
                           "  Correct! Every COBOL program begins with IDENTIFICATION DIVISION."
                           FUNCTION TRIM(C-RST)
                       DISPLAY "  followed by PROGRAM-ID. <NAME>."
                       MOVE "Y" TO WS-QUIZ-DONE
                   WHEN "A"
                   WHEN "C"
                       MOVE 0 TO WS-PLAYER-STREAK
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  Not quite! (Note: ARITHMETIC DIVISION doesn't exist, and"
                           FUNCTION TRIM(C-RST)
                       DISPLAY "  IDENTIFICATION DIVISION + PROGRAM-ID always comes first.)"
                   WHEN OTHER
                       CONTINUE
               END-EVALUATE
           END-PERFORM

           IF NOT SHUTDOWN-NOW
               MOVE 1 TO WS-CHALLENGE-ID
               MOVE "Write the PROGRAM-ID line to name this program VAULT (end with .)"
                   TO WS-PROMPT-DESC
               MOVE "Syntax: PROGRAM-ID. VAULT."
                   TO WS-HINT-TEXT
               MOVE "PROGRAM-ID. VAULT."
                   TO WS-MODEL-ANSWER
               PERFORM 8000-LIVE-CODE-CHALLENGE
               MOVE 1 TO WS-MISSION-NUM
               PERFORM 1900-COMPLETE-MISSION
           END-IF.

*> ===================================================================
*> MISSION 2: WORKING-STORAGE & THE MAGIC OF PIC CLAUSES
*> ===================================================================
       2200-MISSION-2.
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== MISSION 2: CORE-02 // WORKING-STORAGE & PIC CLAUSES ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  Unlike C or Python (which have vague 'int' or 'float' types),"
           DISPLAY "  COBOL declares the EXACT digit-by-digit shape of every variable"
           DISPLAY "  inside DATA DIVISION -> WORKING-STORAGE SECTION!"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               '    01 CUSTOMER-NAME   PIC X(20)    VALUE "ADA".'
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "    01 LOGIN-ATTEMPTS  PIC 9(3)     VALUE 0."
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "    01 ACCT-BALANCE    PIC S9(5)V99 VALUE -125.50."
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "    01 RECEIPT-OUT     PIC $ZZ,ZZ9.99."
               FUNCTION TRIM(C-RST)
           DISPLAY " "
           DISPLAY "  Decode the PIC (PICTURE) symbols:"
           DISPLAY "    " FUNCTION TRIM(C-YLW) "X" FUNCTION TRIM(C-RST)
               " = Any text character     | X(20) means 20 characters"
           DISPLAY "    " FUNCTION TRIM(C-YLW) "9" FUNCTION TRIM(C-RST)
               " = Numeric digit (0-9)    | 9(5) means 5 digits (00000-99999)"
           DISPLAY "    " FUNCTION TRIM(C-YLW) "S" FUNCTION TRIM(C-RST)
               " = Signed (+/-)           | Without S, -50 becomes +50!"
           DISPLAY "    " FUNCTION TRIM(C-YLW) "V" FUNCTION TRIM(C-RST)
               " = Implied decimal point! | 9(5)V99 stores dollars & cents cleanly"
           DISPLAY "    " FUNCTION TRIM(C-YLW) "Z" FUNCTION TRIM(C-RST)
               " = Zero-suppress for nice printing ($ZZ,ZZ9.99 -> $   125.50)"
           PERFORM 9000-PRESS-ENTER

           MOVE "N" TO WS-QUIZ-DONE
           PERFORM UNTIL WS-QUIZ-DONE = "Y" OR SHUTDOWN-NOW
               DISPLAY " "
               DISPLAY FUNCTION TRIM(C-YLW)
                   "  [DIAGNOSTIC QUIZ 2/8]" FUNCTION TRIM(C-RST)
               DISPLAY "  What happens if you MOVE -42 into a variable with PIC 9(3)"
               DISPLAY "  (notice there is NO 'S' in the PIC)?"
               DISPLAY "    [A] The mainframe crashes with a blue screen"
               DISPLAY "    [B] COBOL strips the minus sign and stores positive 042!"
               DISPLAY "    [C] It stores -42 anyway"
               DISPLAY FUNCTION TRIM(C-CYN) "  ANSWER (A/B/C)> "
                   FUNCTION TRIM(C-RST) WITH NO ADVANCING
               ACCEPT WS-QUIZ-ANS
               MOVE FUNCTION UPPER-CASE(FUNCTION TRIM(WS-QUIZ-ANS)) TO WS-QUIZ-ANS
               IF WS-QUIZ-ANS = SPACES
                   ADD 1 TO WS-EMPTY-GUARD
                   IF WS-EMPTY-GUARD > 15 SET SHUTDOWN-NOW TO TRUE END-IF
               ELSE
                   MOVE 0 TO WS-EMPTY-GUARD
               END-IF
               EVALUATE WS-QUIZ-ANS
                   WHEN "B"
                       DISPLAY FUNCTION TRIM(C-GRN)
                           "  Spot on! Unsigned PIC 9(3) drops the minus sign and stores 042."
                           FUNCTION TRIM(C-RST)
                       DISPLAY "  That classic bug has turned bank overdrafts into credits!"
                       MOVE "Y" TO WS-QUIZ-DONE
                   WHEN "A"
                   WHEN "C"
                       MOVE 0 TO WS-PLAYER-STREAK
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  Careful! Without 'S' (PIC S9(3)), COBOL silently takes the"
                           FUNCTION TRIM(C-RST)
                       DISPLAY "  absolute value! Try again."
                   WHEN OTHER
                       CONTINUE
               END-EVALUATE
           END-PERFORM

           IF NOT SHUTDOWN-NOW
               MOVE 2 TO WS-CHALLENGE-ID
               MOVE "Declare level 01 variable BALANCE with picture 9(5)V99 (end with .)"
                   TO WS-PROMPT-DESC
               MOVE "Start with 01, then BALANCE, then PIC 9(5)V99."
                   TO WS-HINT-TEXT
               MOVE "01 BALANCE PIC 9(5)V99."
                   TO WS-MODEL-ANSWER
               PERFORM 8000-LIVE-CODE-CHALLENGE
               MOVE 2 TO WS-MISSION-NUM
               PERFORM 1900-COMPLETE-MISSION
           END-IF.

*> ===================================================================
*> MISSION 3: VERBS OF DATA FLOW (MOVE, DISPLAY, ACCEPT)
*> ===================================================================
       2300-MISSION-3.
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== MISSION 3: CORE-03 // MOVE, DISPLAY & ACCEPT ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  In the PROCEDURE DIVISION, statements start with English VERBS:"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               '    DISPLAY "Enter Deposit: " WITH NO ADVANCING.'
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "    ACCEPT USER-DEPOSIT."
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "    MOVE USER-DEPOSIT TO RECEIPT-AMOUNT."
               FUNCTION TRIM(C-RST)
           DISPLAY " "
           DISPLAY "  CRITICAL COBOL SUPERPOWER (AND TRAP!): Alignment on MOVE"
           DISPLAY "  * Text (PIC X) aligns LEFT and pads/truncates on the RIGHT:"
           DISPLAY '      MOVE "COBOL-ROCKS" TO PIC-X-5   -->  ["COBOL"]'
           DISPLAY "  * Numbers (PIC 9) align at the DECIMAL POINT (or RIGHT):"
           DISPLAY "      MOVE 42   TO PIC-9-5            -->  [00042]"
           DISPLAY "      MOVE 1234 TO PIC-9-3            -->  [234] (Left digit lost!)"
           PERFORM 9000-PRESS-ENTER

           MOVE "N" TO WS-QUIZ-DONE
           PERFORM UNTIL WS-QUIZ-DONE = "Y" OR SHUTDOWN-NOW
               DISPLAY " "
               DISPLAY FUNCTION TRIM(C-YLW)
                   "  [DIAGNOSTIC QUIZ 3/8]" FUNCTION TRIM(C-RST)
               DISPLAY '  If CITY-CODE has PIC X(3), what is stored after:'
               DISPLAY '      MOVE "CHICAGO" TO CITY-CODE.'
               DISPLAY '    [A] "AGO" (rightmost 3 letters)'
               DISPLAY '    [B] "CHI" (leftmost 3 letters)'
               DISPLAY '    [C] Compile error'
               DISPLAY FUNCTION TRIM(C-CYN) "  ANSWER (A/B/C)> "
                   FUNCTION TRIM(C-RST) WITH NO ADVANCING
               ACCEPT WS-QUIZ-ANS
               MOVE FUNCTION UPPER-CASE(FUNCTION TRIM(WS-QUIZ-ANS)) TO WS-QUIZ-ANS
               IF WS-QUIZ-ANS = SPACES
                   ADD 1 TO WS-EMPTY-GUARD
                   IF WS-EMPTY-GUARD > 15 SET SHUTDOWN-NOW TO TRUE END-IF
               ELSE
                   MOVE 0 TO WS-EMPTY-GUARD
               END-IF
               EVALUATE WS-QUIZ-ANS
                   WHEN "B"
                       DISPLAY FUNCTION TRIM(C-GRN)
                           '  Exact! Alphanumeric MOVE fills left-to-right -> "CHI".'
                           FUNCTION TRIM(C-RST)
                       MOVE "Y" TO WS-QUIZ-DONE
                   WHEN "A"
                   WHEN "C"
                       MOVE 0 TO WS-PLAYER-STREAK
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  Remember: Text (PIC X) is left-aligned; numbers (PIC 9)"
                           FUNCTION TRIM(C-RST)
                       DISPLAY "  are decimal/right-aligned! Try again."
                   WHEN OTHER
                       CONTINUE
               END-EVALUATE
           END-PERFORM

           IF NOT SHUTDOWN-NOW
               MOVE 3 TO WS-CHALLENGE-ID
               MOVE "Use MOVE to store 500 into BALANCE (end with a period .)"
                   TO WS-PROMPT-DESC
               MOVE "Remember COBOL reads like English: MOVE <src> TO <dest>."
                   TO WS-HINT-TEXT
               MOVE "MOVE 500 TO BALANCE."
                   TO WS-MODEL-ANSWER
               PERFORM 8000-LIVE-CODE-CHALLENGE
               MOVE 3 TO WS-MISSION-NUM
               PERFORM 1900-COMPLETE-MISSION
           END-IF.

*> ===================================================================
*> MISSION 4: PENNY-PERFECT ARITHMETIC (WHY BANKS LOVE COBOL!)
*> ===================================================================
       2400-MISSION-4.
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== MISSION 4: CORE-04 // PENNY-PERFECT FIXED-POINT MATH ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  Why does COBOL still process ~95% of ATM swipes? Try 0.1 + 0.2"
           DISPLAY "  in binary floating-point (JS/Python): 0.30000000000000004!"
           DISPLAY "  Across 500 million transactions, pennies vanish. COBOL uses"
           DISPLAY "  exact base-10 fixed-point decimal math:"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               "    ADD DEPOSIT TO BALANCE."
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "    SUBTRACT FEE FROM BALANCE."
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "    MULTIPLY BALANCE BY RATE GIVING INTEREST ROUNDED."
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "    COMPUTE TOTAL ROUNDED = PRINCIPAL * (1 + RATE)"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               '        ON SIZE ERROR DISPLAY "OVERFLOW ALERT!"'
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "    END-COMPUTE."
               FUNCTION TRIM(C-RST)
           DISPLAY " "
           DISPLAY "  * By default, COBOL TRUNCATES extra decimals (12.349 -> 12.34)."
           DISPLAY "  * Adding " FUNCTION TRIM(C-YLW) "ROUNDED" FUNCTION TRIM(C-RST)
               " rounds half-cents properly (12.349 -> 12.35)!"
           DISPLAY "  * Adding " FUNCTION TRIM(C-YLW) "ON SIZE ERROR" FUNCTION TRIM(C-RST)
               " catches overflow if a result won't fit in the target PIC!"
           PERFORM 9000-PRESS-ENTER

           MOVE "N" TO WS-QUIZ-DONE
           PERFORM UNTIL WS-QUIZ-DONE = "Y" OR SHUTDOWN-NOW
               DISPLAY " "
               DISPLAY FUNCTION TRIM(C-YLW)
                   "  [DIAGNOSTIC QUIZ 4/8]" FUNCTION TRIM(C-RST)
               DISPLAY "  TAX has PIC 99V99. What is in TAX after:"
               DISPLAY "      COMPUTE TAX = 10.00 / 3."
               DISPLAY "  (Notice ROUNDED is NOT used, and 20.00 / 3 = 6.6666...)"
               DISPLAY "  Wait -- what about: COMPUTE TAX = 20.00 / 3."
               DISPLAY "    [A] 06.67"
               DISPLAY "    [B] 06.66 (truncated without ROUNDED!)"
               DISPLAY "    [C] 07.00"
               DISPLAY FUNCTION TRIM(C-CYN) "  ANSWER (A/B/C)> "
                   FUNCTION TRIM(C-RST) WITH NO ADVANCING
               ACCEPT WS-QUIZ-ANS
               MOVE FUNCTION UPPER-CASE(FUNCTION TRIM(WS-QUIZ-ANS)) TO WS-QUIZ-ANS
               IF WS-QUIZ-ANS = SPACES
                   ADD 1 TO WS-EMPTY-GUARD
                   IF WS-EMPTY-GUARD > 15 SET SHUTDOWN-NOW TO TRUE END-IF
               ELSE
                   MOVE 0 TO WS-EMPTY-GUARD
               END-IF
               EVALUATE WS-QUIZ-ANS
                   WHEN "B"
                       DISPLAY FUNCTION TRIM(C-GRN)
                           "  Bullseye! Without ROUNDED, COBOL chops off extra decimals"
                           FUNCTION TRIM(C-RST)
                       DISPLAY "  to 06.66. With COMPUTE TAX ROUNDED = 20.00 / 3, it's 06.67!"
                       MOVE "Y" TO WS-QUIZ-DONE
                   WHEN "A"
                   WHEN "C"
                       MOVE 0 TO WS-PLAYER-STREAK
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  Remember: COBOL truncates unless you specify ROUNDED!"
                           FUNCTION TRIM(C-RST)
                   WHEN OTHER
                       CONTINUE
               END-EVALUATE
           END-PERFORM

           IF NOT SHUTDOWN-NOW
               MOVE 4 TO WS-CHALLENGE-ID
               MOVE "Add INTEREST to BALANCE with rounding enabled (end with .)"
                   TO WS-PROMPT-DESC
               MOVE "Use: ADD INTEREST TO BALANCE ROUNDED."
                   TO WS-HINT-TEXT
               MOVE "ADD INTEREST TO BALANCE ROUNDED."
                   TO WS-MODEL-ANSWER
               PERFORM 8000-LIVE-CODE-CHALLENGE
               MOVE 4 TO WS-MISSION-NUM
               PERFORM 1900-COMPLETE-MISSION
           END-IF.

*> ===================================================================
*> MISSION 5: LOGIC GATES, EVALUATE TRUE & LEVEL-88 CONDITIONS
*> ===================================================================
       2500-MISSION-5.
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== MISSION 5: CORE-05 // IF, EVALUATE & LEVEL-88 MAGIC ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  One of COBOL's cleanest features is "
               FUNCTION TRIM(C-YLW) "Level-88 Condition Names" FUNCTION TRIM(C-RST) ":"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               '    01 ACCOUNT-STATUS      PIC X VALUE "A".'
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               '       88 ACCT-ACTIVE            VALUE "A".'
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               '       88 ACCT-FROZEN            VALUE "F" "L".'
               FUNCTION TRIM(C-RST)
           DISPLAY " "
           DISPLAY "  Now your PROCEDURE DIVISION reads like pure business English:"
           DISPLAY FUNCTION TRIM(C-GRN)
               "    IF ACCT-ACTIVE"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               '        DISPLAY " Ready for withdrawal!"'
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "    END-IF"
               FUNCTION TRIM(C-RST)
           DISPLAY " "
           DISPLAY "  And for multi-way branching, " FUNCTION TRIM(C-YLW)
               "EVALUATE TRUE" FUNCTION TRIM(C-RST) " beats switch/case:"
           DISPLAY "    EVALUATE TRUE"
           DISPLAY "        WHEN SCORE >= 90  MOVE 'A' TO GRADE"
           DISPLAY "        WHEN SCORE >= 80  MOVE 'B' TO GRADE"
           DISPLAY "        WHEN OTHER        MOVE 'C' TO GRADE"
           DISPLAY "    END-EVALUATE"
           DISPLAY "  PRO TIP: Always close IF with END-IF (don't put stray periods"
           DISPLAY "  inside an IF block, because a period closes ALL open IFs!)."
           PERFORM 9000-PRESS-ENTER

           MOVE "N" TO WS-QUIZ-DONE
           PERFORM UNTIL WS-QUIZ-DONE = "Y" OR SHUTDOWN-NOW
               DISPLAY " "
               DISPLAY FUNCTION TRIM(C-YLW)
                   "  [DIAGNOSTIC QUIZ 5/8]" FUNCTION TRIM(C-RST)
               DISPLAY "  Why is putting an accidental period (.) in the middle of an"
               DISPLAY "  IF block famous as a billion-dollar COBOL bug?"
               DISPLAY "    [A] Periods multiply numbers by 10"
               DISPLAY "    [B] A period immediately terminates the IF sentence, so"
               DISPLAY "        subsequent indented lines run UNCONDITIONALLY!"
               DISPLAY "    [C] Periods comment out the rest of the file"
               DISPLAY FUNCTION TRIM(C-CYN) "  ANSWER (A/B/C)> "
                   FUNCTION TRIM(C-RST) WITH NO ADVANCING
               ACCEPT WS-QUIZ-ANS
               MOVE FUNCTION UPPER-CASE(FUNCTION TRIM(WS-QUIZ-ANS)) TO WS-QUIZ-ANS
               IF WS-QUIZ-ANS = SPACES
                   ADD 1 TO WS-EMPTY-GUARD
                   IF WS-EMPTY-GUARD > 15 SET SHUTDOWN-NOW TO TRUE END-IF
               ELSE
                   MOVE 0 TO WS-EMPTY-GUARD
               END-IF
               EVALUATE WS-QUIZ-ANS
                   WHEN "B"
                       DISPLAY FUNCTION TRIM(C-GRN)
                           "  Exactly! Modern COBOL uses explicit END-IF, END-EVALUATE,"
                           FUNCTION TRIM(C-RST)
                       DISPLAY "  and END-PERFORM with ONE period at the end of a paragraph!"
                       MOVE "Y" TO WS-QUIZ-DONE
                   WHEN "A"
                   WHEN "C"
                       MOVE 0 TO WS-PLAYER-STREAK
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  Think about what a period ends in COBOL: a full sentence!"
                           FUNCTION TRIM(C-RST)
                   WHEN OTHER
                       CONTINUE
               END-EVALUATE
           END-PERFORM

           IF NOT SHUTDOWN-NOW
               MOVE 5 TO WS-CHALLENGE-ID
               MOVE 'Declare an 88-level condition VIP-CLIENT for VALUE "Y" (end with .)'
                   TO WS-PROMPT-DESC
               MOVE 'Syntax: 88 VIP-CLIENT VALUE "Y".'
                   TO WS-HINT-TEXT
               MOVE '88 VIP-CLIENT VALUE "Y".'
                   TO WS-MODEL-ANSWER
               PERFORM 8000-LIVE-CODE-CHALLENGE
               MOVE 5 TO WS-MISSION-NUM
               PERFORM 1900-COMPLETE-MISSION
           END-IF.

*> ===================================================================
*> MISSION 6: PERFORM PARAGRAPHS & LOOPS
*> ===================================================================
       2600-MISSION-6.
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== MISSION 6: CORE-06 // PERFORM PARAGRAPHS & LOOPS ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  One single verb -- " FUNCTION TRIM(C-YLW) "PERFORM"
               FUNCTION TRIM(C-RST) " -- handles subroutine calls, counted"
           DISPLAY "  loops, while-loops, and for-loops in COBOL!"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               "    *> 1. Call a paragraph (and return when it finishes):"
               FUNCTION TRIM(C-RST)
           DISPLAY "    PERFORM 2000-VALIDATE-CARD"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               "    *> 2. Repeat N times:"
               FUNCTION TRIM(C-RST)
           DISPLAY "    PERFORM PRINT-RECEIPT-HEADER 3 TIMES"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               "    *> 3. Condition loop (checks condition BEFORE each pass!):"
               FUNCTION TRIM(C-RST)
           DISPLAY "    PERFORM UNTIL END-OF-FILE"
           DISPLAY "        PERFORM PROCESS-RECORD"
           DISPLAY "    END-PERFORM"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               "    *> 4. Indexed loop (like a for-loop):"
               FUNCTION TRIM(C-RST)
           DISPLAY "    PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX > 12"
           DISPLAY '        DISPLAY "Month: " IDX'
           DISPLAY "    END-PERFORM"
           PERFORM 9000-PRESS-ENTER

           MOVE "N" TO WS-QUIZ-DONE
           PERFORM UNTIL WS-QUIZ-DONE = "Y" OR SHUTDOWN-NOW
               DISPLAY " "
               DISPLAY FUNCTION TRIM(C-YLW)
                   "  [DIAGNOSTIC QUIZ 6/8]" FUNCTION TRIM(C-RST)
               DISPLAY "  How many times does the loop body run in:"
               DISPLAY "      PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX > 5"
               DISPLAY "    [A] 4 times (stops at 4)"
               DISPLAY "    [B] 5 times (runs for IDX = 1, 2, 3, 4, 5; stops when IDX = 6)"
               DISPLAY "    [C] 6 times"
               DISPLAY FUNCTION TRIM(C-CYN) "  ANSWER (A/B/C)> "
                   FUNCTION TRIM(C-RST) WITH NO ADVANCING
               ACCEPT WS-QUIZ-ANS
               MOVE FUNCTION UPPER-CASE(FUNCTION TRIM(WS-QUIZ-ANS)) TO WS-QUIZ-ANS
               IF WS-QUIZ-ANS = SPACES
                   ADD 1 TO WS-EMPTY-GUARD
                   IF WS-EMPTY-GUARD > 15 SET SHUTDOWN-NOW TO TRUE END-IF
               ELSE
                   MOVE 0 TO WS-EMPTY-GUARD
               END-IF
               EVALUATE WS-QUIZ-ANS
                   WHEN "B"
                       DISPLAY FUNCTION TRIM(C-GRN)
                           "  Spot on! UNTIL IDX > 5 stays false for 1..5, then becomes"
                           FUNCTION TRIM(C-RST)
                       DISPLAY "  true when IDX hits 6, giving 5 clean iterations!"
                       MOVE "Y" TO WS-QUIZ-DONE
                   WHEN "A"
                   WHEN "C"
                       MOVE 0 TO WS-PLAYER-STREAK
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  Trace IDX: 1 (<=5), 2, 3, 4, 5 (<=5), then 6 (>5 -> stop)!"
                           FUNCTION TRIM(C-RST)
                   WHEN OTHER
                       CONTINUE
               END-EVALUATE
           END-PERFORM

           IF NOT SHUTDOWN-NOW
               MOVE 6 TO WS-CHALLENGE-ID
               MOVE "Use PERFORM to run paragraph PRINT-LINE 5 times (end with .)"
                   TO WS-PROMPT-DESC
               MOVE "Syntax: PERFORM PRINT-LINE 5 TIMES."
                   TO WS-HINT-TEXT
               MOVE "PERFORM PRINT-LINE 5 TIMES."
                   TO WS-MODEL-ANSWER
               PERFORM 8000-LIVE-CODE-CHALLENGE
               MOVE 6 TO WS-MISSION-NUM
               PERFORM 1900-COMPLETE-MISSION
           END-IF.

*> ===================================================================
*> MISSION 7: TABLES (OCCURS), GROUP RECORDS & STRINGS
*> ===================================================================
       2700-MISSION-7.
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== MISSION 7: CORE-07 // RECORDS, OCCURS TABLES & STRINGS ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  COBOL invented hierarchical structured records using level numbers!"
           DISPLAY "  A Group Item has NO PIC clause -- it contains sub-fields:"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               "    01 EMPLOYEE-RECORD."
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "       05 EMP-ID          PIC 9(6)."
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "       05 EMP-FULL-NAME."
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "          10 FIRST-NAME   PIC X(15)."
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "          10 LAST-NAME    PIC X(20)."
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "       05 MONTHLY-PAY     PIC 9(5)V99 OCCURS 12 TIMES."
               FUNCTION TRIM(C-RST)
           DISPLAY " "
           DISPLAY "  * Arrays in COBOL are called TABLES and use "
               FUNCTION TRIM(C-YLW) "OCCURS N TIMES" FUNCTION TRIM(C-RST) "."
           DISPLAY "  * Subscripts start at " FUNCTION TRIM(C-YLW) "1"
               FUNCTION TRIM(C-RST) " (NOT 0!): MONTHLY-PAY(1) is January!"
           DISPLAY "  * Bonus string verbs: STRING (join), UNSTRING (split CSVs),"
           DISPLAY "    and INSPECT ... TALLYING / REPLACING (how this game grades"
           DISPLAY "    your COBOL code!)."
           PERFORM 9000-PRESS-ENTER

           MOVE "N" TO WS-QUIZ-DONE
           PERFORM UNTIL WS-QUIZ-DONE = "Y" OR SHUTDOWN-NOW
               DISPLAY " "
               DISPLAY FUNCTION TRIM(C-YLW)
                   "  [DIAGNOSTIC QUIZ 7/8]" FUNCTION TRIM(C-RST)
               DISPLAY "  If BRANCH-TOTAL has OCCURS 10 TIMES, what is the index"
               DISPLAY "  of the VERY FIRST element in COBOL?"
               DISPLAY "    [A] BRANCH-TOTAL(0)"
               DISPLAY "    [B] BRANCH-TOTAL(1)"
               DISPLAY "    [C] BRANCH-TOTAL[0]"
               DISPLAY FUNCTION TRIM(C-CYN) "  ANSWER (A/B/C)> "
                   FUNCTION TRIM(C-RST) WITH NO ADVANCING
               ACCEPT WS-QUIZ-ANS
               MOVE FUNCTION UPPER-CASE(FUNCTION TRIM(WS-QUIZ-ANS)) TO WS-QUIZ-ANS
               IF WS-QUIZ-ANS = SPACES
                   ADD 1 TO WS-EMPTY-GUARD
                   IF WS-EMPTY-GUARD > 15 SET SHUTDOWN-NOW TO TRUE END-IF
               ELSE
                   MOVE 0 TO WS-EMPTY-GUARD
               END-IF
               EVALUATE WS-QUIZ-ANS
                   WHEN "B"
                       DISPLAY FUNCTION TRIM(C-GRN)
                           "  Yes! COBOL tables use parentheses and are 1-indexed: (1).."
                           FUNCTION TRIM(C-RST)
                       MOVE "Y" TO WS-QUIZ-DONE
                   WHEN "A"
                   WHEN "C"
                       MOVE 0 TO WS-PLAYER-STREAK
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  COBOL tables use parentheses () and start counting at 1!"
                           FUNCTION TRIM(C-RST)
                   WHEN OTHER
                       CONTINUE
               END-EVALUATE
           END-PERFORM

           IF NOT SHUTDOWN-NOW
               MOVE 7 TO WS-CHALLENGE-ID
               MOVE "Declare 05 MONTH-SALES with PIC 9(6) repeating 12 times (end with .)"
                   TO WS-PROMPT-DESC
               MOVE "Syntax: 05 MONTH-SALES PIC 9(6) OCCURS 12 TIMES."
                   TO WS-HINT-TEXT
               MOVE "05 MONTH-SALES PIC 9(6) OCCURS 12 TIMES."
                   TO WS-MODEL-ANSWER
               PERFORM 8000-LIVE-CODE-CHALLENGE
               MOVE 7 TO WS-MISSION-NUM
               PERFORM 1900-COMPLETE-MISSION
           END-IF.

*> ===================================================================
*> MISSION 8: SEQUENTIAL FILES & THE FINAL BOSS BATCH JOB!
*> ===================================================================
       2800-MISSION-8.
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== MISSION 8: CORE-08 // SEQUENTIAL FILES & BOSS BATCH ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  COBOL's legendary strength is chewing through millions of file"
           DISPLAY "  records in a nightly batch job using 4 steps:"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               '    1. ENVIRONMENT: SELECT PAYROLL-FILE ASSIGN TO "employees.dat"'
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "                        ORGANIZATION IS LINE SEQUENTIAL."
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "    2. DATA (FD):   FD PAYROLL-FILE."
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "                    01 EMP-REC   PIC X(80)."
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "    3. OPEN & READ: OPEN INPUT PAYROLL-FILE"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               '                    READ PAYROLL-FILE AT END MOVE "Y" TO EOF-FLAG'
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "    4. CLOSE:       CLOSE PAYROLL-FILE"
               FUNCTION TRIM(C-RST)
           DISPLAY " "
           DISPLAY "  (Fun fact: COBOL QUEST uses this exact pattern to save your"
           DISPLAY "   stats to savegame.dat AND generate my_sandbox.cob!)"
           PERFORM 9000-PRESS-ENTER

           MOVE 8 TO WS-CHALLENGE-ID
           MOVE "Mount the batch tape for reading: OPEN INPUT PAYROLL-FILE."
               TO WS-PROMPT-DESC
           MOVE "Syntax: OPEN INPUT PAYROLL-FILE."
               TO WS-HINT-TEXT
           MOVE "OPEN INPUT PAYROLL-FILE."
               TO WS-MODEL-ANSWER
           PERFORM 8000-LIVE-CODE-CHALLENGE

           IF NOT SHUTDOWN-NOW
               PERFORM 2850-BOSS-BATTLE
           END-IF.

*> ===================================================================
*> 2850-BOSS-BATTLE: 3-Wave Showdown Against the Midnight Batch Glitch!
*> ===================================================================
       2850-BOSS-BATTLE.
           MOVE 100 TO WS-MAINFRAME-HP
           MOVE 300 TO WS-BOSS-HP
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-RED)
               "+====================================================================+"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-RED)
               "|  WARNING! ROGUE DAEMON 'ABEND-S0C7' DETECTED IN MIDNIGHT PAYROLL!  |"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-RED)
               "+====================================================================+"
               FUNCTION TRIM(C-RST)
           DISPLAY "  50,000 employee paychecks execute in 60 seconds! Defeat ABEND-S0C7"
           DISPLAY "  across 3 live debugging waves to bring IRON-7090 to 100% power!"

           *> Wave 1
           MOVE "N" TO WS-QUIZ-DONE
           PERFORM UNTIL WS-QUIZ-DONE = "Y" OR SHUTDOWN-NOW
               MOVE WS-MAINFRAME-HP TO WS-HP-FMT
               MOVE WS-BOSS-HP      TO WS-BOSS-FMT
               DISPLAY " "
               DISPLAY "  [IRON-7090 HP: " FUNCTION TRIM(C-GRN) WS-HP-FMT "%"
                   FUNCTION TRIM(C-RST) " | BOSS ABEND-S0C7 HP: "
                   FUNCTION TRIM(C-RED) WS-BOSS-FMT FUNCTION TRIM(C-RST) "]"
               DISPLAY FUNCTION TRIM(C-YLW)
                   "  WAVE 1/3: Infinite Loop on Employee #50,000!" FUNCTION TRIM(C-RST)
               DISPLAY "  The batch job keeps re-processing the last employee forever!"
               DISPLAY "  Which clause inside READ PAYROLL-FILE stops the loop at EOF?"
               DISPLAY '    [A] AT END SET EOF-REACHED TO TRUE'
               DISPLAY '    [B] ON OVERFLOW STOP EVERYTHING'
               DISPLAY '    [C] WHEN ZERO EXIT'
               DISPLAY FUNCTION TRIM(C-CYN) "  PATCH (A/B/C)> "
                   FUNCTION TRIM(C-RST) WITH NO ADVANCING
               ACCEPT WS-QUIZ-ANS
               MOVE FUNCTION UPPER-CASE(FUNCTION TRIM(WS-QUIZ-ANS)) TO WS-QUIZ-ANS
               IF WS-QUIZ-ANS = SPACES
                   ADD 1 TO WS-EMPTY-GUARD
                   IF WS-EMPTY-GUARD > 15 SET SHUTDOWN-NOW TO TRUE END-IF
               ELSE
                   MOVE 0 TO WS-EMPTY-GUARD
               END-IF
               EVALUATE WS-QUIZ-ANS
                   WHEN "A"
                       SUBTRACT 100 FROM WS-BOSS-HP
                       DISPLAY FUNCTION TRIM(C-GRN)
                           "  CRITICAL HIT (-100 BOSS HP)! READ ... AT END cleanly flags EOF!"
                           FUNCTION TRIM(C-RST)
                       MOVE "Y" TO WS-QUIZ-DONE
                   WHEN "B"
                   WHEN "C"
                       IF WS-MAINFRAME-HP > 20
                           SUBTRACT 15 FROM WS-MAINFRAME-HP
                       END-IF
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  GLITCH STRIKE (-15% HP)! Hint: Sequential READ uses AT END."
                           FUNCTION TRIM(C-RST)
                   WHEN OTHER
                       CONTINUE
               END-EVALUATE
           END-PERFORM

           *> Wave 2
           MOVE "N" TO WS-QUIZ-DONE
           PERFORM UNTIL WS-QUIZ-DONE = "Y" OR SHUTDOWN-NOW
               MOVE WS-MAINFRAME-HP TO WS-HP-FMT
               MOVE WS-BOSS-HP      TO WS-BOSS-FMT
               DISPLAY " "
               DISPLAY "  [IRON-7090 HP: " FUNCTION TRIM(C-GRN) WS-HP-FMT "%"
                   FUNCTION TRIM(C-RST) " | BOSS ABEND-S0C7 HP: "
                   FUNCTION TRIM(C-RED) WS-BOSS-FMT FUNCTION TRIM(C-RST) "]"
               DISPLAY FUNCTION TRIM(C-YLW)
                   "  WAVE 2/3: Executive Paycheck Truncation!" FUNCTION TRIM(C-RST)
               DISPLAY "  NET-PAY is declared as PIC 9(4)V99, so a $12,500.00 bonus"
               DISPLAY "  is paying out only $2,500.00! How do you fix NET-PAY?"
               DISPLAY "    [A] Change PIC to PIC X(4)"
               DISPLAY "    [B] Widen integer digits to PIC S9(6)V99 (and add ON SIZE ERROR)"
               DISPLAY "    [C] Remove V99"
               DISPLAY FUNCTION TRIM(C-CYN) "  PATCH (A/B/C)> "
                   FUNCTION TRIM(C-RST) WITH NO ADVANCING
               ACCEPT WS-QUIZ-ANS
               MOVE FUNCTION UPPER-CASE(FUNCTION TRIM(WS-QUIZ-ANS)) TO WS-QUIZ-ANS
               IF WS-QUIZ-ANS = SPACES
                   ADD 1 TO WS-EMPTY-GUARD
                   IF WS-EMPTY-GUARD > 15 SET SHUTDOWN-NOW TO TRUE END-IF
               ELSE
                   MOVE 0 TO WS-EMPTY-GUARD
               END-IF
               EVALUATE WS-QUIZ-ANS
                   WHEN "B"
                       SUBTRACT 100 FROM WS-BOSS-HP
                       DISPLAY FUNCTION TRIM(C-GRN)
                           "  DIRECT HIT (-100 BOSS HP)! PIC S9(6)V99 holds up to +/-999,999.99!"
                           FUNCTION TRIM(C-RST)
                       MOVE "Y" TO WS-QUIZ-DONE
                   WHEN "A"
                   WHEN "C"
                       IF WS-MAINFRAME-HP > 20
                           SUBTRACT 15 FROM WS-MAINFRAME-HP
                       END-IF
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  GLITCH STRIKE (-15% HP)! PIC 9(4) only holds 4 digits left of V!"
                           FUNCTION TRIM(C-RST)
                   WHEN OTHER
                       CONTINUE
               END-EVALUATE
           END-PERFORM

           *> Wave 3: Live Code Finisher!
           IF NOT SHUTDOWN-NOW
               MOVE WS-MAINFRAME-HP TO WS-HP-FMT
               MOVE WS-BOSS-HP      TO WS-BOSS-FMT
               DISPLAY " "
               DISPLAY "  [IRON-7090 HP: " FUNCTION TRIM(C-GRN) WS-HP-FMT "%"
                   FUNCTION TRIM(C-RST) " | BOSS ABEND-S0C7 HP: "
                   FUNCTION TRIM(C-RED) WS-BOSS-FMT FUNCTION TRIM(C-RST) "]"
               DISPLAY FUNCTION TRIM(C-YLW)
                   "  FINAL WAVE 3/3: Seal the Batch Tape to Banish ABEND-S0C7!"
                   FUNCTION TRIM(C-RST)
               MOVE 9 TO WS-CHALLENGE-ID
               MOVE "Write the COBOL statement to close PAYROLL-FILE (end with .)"
                   TO WS-PROMPT-DESC
               MOVE "Syntax: CLOSE PAYROLL-FILE."
                   TO WS-HINT-TEXT
               MOVE "CLOSE PAYROLL-FILE."
                   TO WS-MODEL-ANSWER
               PERFORM 8000-LIVE-CODE-CHALLENGE
           END-IF

           IF NOT SHUTDOWN-NOW
               MOVE 0 TO WS-BOSS-HP
               DISPLAY " "
               DISPLAY FUNCTION TRIM(C-GRN)
                   "  *** BOSS DEFEATED! ABEND-S0C7 PURGED! 50,000 PAYCHECKS SENT! ***"
                   FUNCTION TRIM(C-RST)
               IF WS-MISSION-DONE(8) = "N"
                   ADD 150 TO WS-PLAYER-XP
               END-IF
               MOVE 8 TO WS-MISSION-NUM
               PERFORM 1900-COMPLETE-MISSION
           END-IF.

       2900-VICTORY-CERTIFICATE.
           PERFORM 0400-RECALC-RANK-AND-BAR
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-YLW)
               "  +==============================================================+"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-YLW)
               "  |         OFFICIAL IRON-7090 MAINFRAME CERTIFICATION           |"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-YLW)
               "  +--------------------------------------------------------------+"
               FUNCTION TRIM(C-RST)
           DISPLAY "  |  This certifies that Engineer: "
               FUNCTION TRIM(C-CYN) WS-PLAYER-NAME FUNCTION TRIM(C-RST)
               "          |"
           DISPLAY "  |  has restored all 8/8 COBOL Subsystems on Mainframe IRON-7090|"
           DISPLAY "  |  and mastered Divisions, PIC, Verbs, Fixed-Point Math,       |"
           DISPLAY "  |  Level-88 Logic, PERFORM Loops, OCCURS Tables & File I/O!    |"
           DISPLAY "  |                                                              |"
           DISPLAY "  |  Final Rank : " FUNCTION TRIM(C-GRN) WS-RANK-TITLE
               FUNCTION TRIM(C-RST) "                     |"
           DISPLAY FUNCTION TRIM(C-YLW)
               "  +==============================================================+"
               FUNCTION TRIM(C-RST)
           PERFORM 9000-PRESS-ENTER.
