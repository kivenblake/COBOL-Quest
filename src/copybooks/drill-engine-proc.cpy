*> ===================================================================
*> COPYBOOK: drill-engine-proc.cpy
*> PURPOSE : Adaptive 2-Variant Quiz Runner & 3-Variant Mastery Coding
*>           Engine (Progressive Non-Spoiler Hints + Productive Failure
*>           Walkthroughs + Automatic Variant Rotation!)
*> ===================================================================

*> ===================================================================
*> 7800-RUN-ADAPTIVE-QUIZ
*> Verifies understanding before coding. Wrong answers receive a full
*> plain-English explanation AND rotate to a new variant question!
*> ===================================================================
       7800-RUN-ADAPTIVE-QUIZ.
           MOVE 1   TO WS-Q-CUR-VAR
           MOVE "N" TO WS-Q-PASSED

           PERFORM UNTIL WS-Q-PASSED = "Y" OR SHUTDOWN-NOW
               DISPLAY " "
               DISPLAY FUNCTION TRIM(C-YLW)
                   "  +--- CONCEPT CHECK: " FUNCTION TRIM(WS-Q-TITLE)
                   " (Variant " WS-Q-CUR-VAR "/2) ---+"
                   FUNCTION TRIM(C-RST)
               DISPLAY "  " FUNCTION TRIM(QZ-Q1(WS-Q-CUR-VAR))
               IF QZ-Q2(WS-Q-CUR-VAR) NOT = SPACES
                   DISPLAY "  " FUNCTION TRIM(QZ-Q2(WS-Q-CUR-VAR))
               END-IF
               DISPLAY " "
               DISPLAY "    " FUNCTION TRIM(C-CYN) "[A]" FUNCTION TRIM(C-RST)
                   " " FUNCTION TRIM(QZ-OPT-A(WS-Q-CUR-VAR))
               DISPLAY "    " FUNCTION TRIM(C-CYN) "[B]" FUNCTION TRIM(C-RST)
                   " " FUNCTION TRIM(QZ-OPT-B(WS-Q-CUR-VAR))
               DISPLAY "    " FUNCTION TRIM(C-CYN) "[C]" FUNCTION TRIM(C-RST)
                   " " FUNCTION TRIM(QZ-OPT-C(WS-Q-CUR-VAR))
               DISPLAY FUNCTION TRIM(C-CYN) "  YOUR CHOICE (A/B/C)> "
                   FUNCTION TRIM(C-RST) WITH NO ADVANCING

               MOVE SPACES TO WS-Q-INPUT
               ACCEPT WS-Q-INPUT
               MOVE FUNCTION UPPER-CASE(FUNCTION TRIM(WS-Q-INPUT))
                   TO WS-Q-INPUT

               IF WS-Q-INPUT = SPACES
                   ADD 1 TO WS-EMPTY-GUARD
                   IF WS-EMPTY-GUARD > 15
                       SET SHUTDOWN-NOW TO TRUE
                   END-IF
               ELSE
                   MOVE 0 TO WS-EMPTY-GUARD
               END-IF

               IF WS-Q-INPUT = QZ-ANS(WS-Q-CUR-VAR)
                   DISPLAY " "
                   DISPLAY FUNCTION TRIM(C-GRN)
                       "  [EXACTLY RIGHT!] "
                       FUNCTION TRIM(QZ-OK-MSG(WS-Q-CUR-VAR))
                       FUNCTION TRIM(C-RST)
                   MOVE 25 TO WS-XP-GAIN
                   PERFORM 0450-AWARD-XP
                   MOVE "Y" TO WS-Q-PASSED
               ELSE IF WS-Q-INPUT = "A" OR WS-Q-INPUT = "B" OR WS-Q-INPUT = "C"
                   MOVE 0 TO WS-PLAYER-STREAK
                   DISPLAY " "
                   DISPLAY FUNCTION TRIM(C-YLW)
                       "  +----------- GOOD TRY! LET'S UNPACK WHY -----------+"
                       FUNCTION TRIM(C-RST)
                   DISPLAY "  The right answer for this one was ["
                       FUNCTION TRIM(C-GRN) QZ-ANS(WS-Q-CUR-VAR)
                       FUNCTION TRIM(C-RST) "]."
                   DISPLAY "  * " FUNCTION TRIM(QZ-WHY-1(WS-Q-CUR-VAR))
                   IF QZ-WHY-2(WS-Q-CUR-VAR) NOT = SPACES
                       DISPLAY "  * " FUNCTION TRIM(QZ-WHY-2(WS-Q-CUR-VAR))
                   END-IF
                   IF QZ-WHY-3(WS-Q-CUR-VAR) NOT = SPACES
                       DISPLAY "  * " FUNCTION TRIM(QZ-WHY-3(WS-Q-CUR-VAR))
                   END-IF
                   DISPLAY FUNCTION TRIM(C-YLW)
                       "  +--------------------------------------------------+"
                       FUNCTION TRIM(C-RST)
                   DISPLAY FUNCTION TRIM(C-DIM)
                       "  [Press ENTER to try a fresh question on this idea...]"
                       FUNCTION TRIM(C-RST) WITH NO ADVANCING
                   ACCEPT WS-PAUSE-DUMMY
                   IF WS-Q-CUR-VAR = 1
                       MOVE 2 TO WS-Q-CUR-VAR
                   ELSE
                       MOVE 1 TO WS-Q-CUR-VAR
                   END-IF
               ELSE IF WS-Q-INPUT NOT = SPACES
                   DISPLAY FUNCTION TRIM(C-RED)
                       "  Please type A, B, or C and press ENTER."
                       FUNCTION TRIM(C-RST)
               END-IF
           END-PERFORM.

*> ===================================================================
*> 8000-RUN-ADAPTIVE-DRILL
*> 3-Variant Live COBOL Coding Engine!
*> ===================================================================
       8000-RUN-ADAPTIVE-DRILL.
           MOVE 1   TO WS-D-CUR-VAR
           MOVE 0   TO WS-D-ATTEMPTS
           MOVE 0   TO WS-D-HINT-LVL
           MOVE "N" TO WS-D-MASTERED
           PERFORM 8050-PRINT-DRILL-PROMPT

           PERFORM UNTIL WS-D-MASTERED = "Y" OR SHUTDOWN-NOW
               COMPUTE WS-TRY-NUM = WS-D-ATTEMPTS + 1
               DISPLAY FUNCTION TRIM(C-GRN)
                   "  [Try " WS-TRY-NUM "/2] CODE> "
                   FUNCTION TRIM(C-RST) WITH NO ADVANCING
               MOVE SPACES TO WS-D-RAW-IN
               ACCEPT WS-D-RAW-IN
               MOVE FUNCTION UPPER-CASE(FUNCTION TRIM(WS-D-RAW-IN))
                   TO WS-D-UP-IN

               IF WS-D-UP-IN = SPACES
                   ADD 1 TO WS-EMPTY-GUARD
                   IF WS-EMPTY-GUARD > 15
                       SET SHUTDOWN-NOW TO TRUE
                   END-IF
               ELSE
                   MOVE 0 TO WS-EMPTY-GUARD
               END-IF

               EVALUATE WS-D-UP-IN
                   WHEN SPACES
                       CONTINUE

                   WHEN "HINT"
                       ADD 1 TO WS-D-HINT-LVL
                       IF WS-D-HINT-LVL = 1
                           DISPLAY FUNCTION TRIM(C-CYN)
                               "  [CLUE 1/2 - SIMILAR EXAMPLE] "
                               FUNCTION TRIM(C-RST)
                           DISPLAY "    " FUNCTION TRIM(DV-HINT-1(WS-D-CUR-VAR))
                           DISPLAY FUNCTION TRIM(C-DIM)
                               "    (Need a fill-in-the-blank skeleton? Type HINT again!)"
                               FUNCTION TRIM(C-RST)
                       ELSE
                           DISPLAY FUNCTION TRIM(C-CYN)
                               "  [CLUE 2/2 - FILL-IN BLUEPRINT] "
                               FUNCTION TRIM(C-RST)
                           DISPLAY "    " FUNCTION TRIM(DV-HINT-2(WS-D-CUR-VAR))
                           DISPLAY FUNCTION TRIM(C-DIM)
                               "    (Replace the ___ blanks with your own words, or type"
                               FUNCTION TRIM(C-RST)
                           DISPLAY FUNCTION TRIM(C-DIM)
                               "     EXPLAIN for a full walkthrough + a brand-new variant!)"
                               FUNCTION TRIM(C-RST)
                       END-IF

                   WHEN "EXPLAIN"
                   WHEN "SHOW"
                   WHEN "ANSWER"
                   WHEN "HELP"
                       MOVE "(requested walkthrough)" TO WS-D-RAW-IN
                       PERFORM 8500-EXPLAIN-AND-ROTATE

                   WHEN OTHER
                       PERFORM 8200-DIAGNOSE-ATTEMPT
                       IF WS-D-LINE-OK = "Y"
                           DISPLAY " "
                           DISPLAY FUNCTION TRIM(C-GRN)
                               "  [COMPILER ACCEPTED!] Nice work writing real COBOL!"
                               FUNCTION TRIM(C-RST)
                           DISPLAY "  Result: "
                               FUNCTION TRIM(DV-EFFECT(WS-D-CUR-VAR))
                           MOVE 40 TO WS-XP-GAIN
                           PERFORM 0450-AWARD-XP
                           DISPLAY " "
                           DISPLAY FUNCTION TRIM(C-CYN)
                               "  Press ENTER to continue, or type P to practice"
                               FUNCTION TRIM(C-RST)
                           DISPLAY FUNCTION TRIM(C-CYN)
                               "  another variant of this skill (+25 XP)> "
                               FUNCTION TRIM(C-RST) WITH NO ADVANCING
                           MOVE SPACES TO WS-D-POST-CHOICE
                           ACCEPT WS-D-POST-CHOICE
                           IF FUNCTION UPPER-CASE(
                               FUNCTION TRIM(WS-D-POST-CHOICE)) = "P"
                               PERFORM 8600-ADVANCE-VARIANT
                               PERFORM 8050-PRINT-DRILL-PROMPT
                           ELSE
                               MOVE "Y" TO WS-D-MASTERED
                           END-IF
                       ELSE
                           ADD 1 TO WS-D-ATTEMPTS
                           IF WS-D-ATTEMPTS < 2
                               DISPLAY FUNCTION TRIM(C-DIM)
                                   "  -> Give it one more try! (Or type HINT for a clue.)"
                                   FUNCTION TRIM(C-RST)
                           ELSE
                               PERFORM 8500-EXPLAIN-AND-ROTATE
                           END-IF
                       END-IF
               END-EVALUATE
           END-PERFORM.

       8050-PRINT-DRILL-PROMPT.
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-YLW)
               "  +=== HANDS-ON CODING: " FUNCTION TRIM(DRL-HEADER)
               " (Variant " WS-D-CUR-VAR "/3) ===+"
               FUNCTION TRIM(C-RST)
           DISPLAY "  GOAL: " FUNCTION TRIM(DV-TASK-1(WS-D-CUR-VAR))
           IF DV-TASK-2(WS-D-CUR-VAR) NOT = SPACES
               DISPLAY "        " FUNCTION TRIM(DV-TASK-2(WS-D-CUR-VAR))
           END-IF
           DISPLAY FUNCTION TRIM(C-DIM)
               "  Commands: HINT (clue without spoilers) | EXPLAIN (walkthrough + new try)"
               FUNCTION TRIM(C-RST).

*> ===================================================================
*> 8200-DIAGNOSE-ATTEMPT: Plain-English Beginner Mistake Coach!
*> ===================================================================
       8200-DIAGNOSE-ATTEMPT.
           MOVE "N" TO WS-D-LINE-OK
           MOVE 0 TO WS-TALLY-A WS-TALLY-B WS-TALLY-Q1 WS-TALLY-Q2 WS-TALLY-EQ
           MOVE 0 TO WS-POS-1 WS-POS-2 WS-POS-3

           MOVE FUNCTION LENGTH(FUNCTION TRIM(WS-D-UP-IN)) TO WS-D-LEN
           IF WS-D-LEN > 0
               MOVE WS-D-UP-IN(WS-D-LEN : 1) TO WS-D-LAST-CH
           ELSE
               MOVE SPACE TO WS-D-LAST-CH
           END-IF

           *> 1. Check forbidden '=' when COBOL expects an English verb
           IF DV-FORBID-EQ(WS-D-CUR-VAR) = "Y"
               INSPECT WS-D-UP-IN TALLYING WS-TALLY-EQ FOR ALL "="
               IF WS-TALLY-EQ > 0
                   DISPLAY FUNCTION TRIM(C-YLW)
                       "  [COACHING] Good instinct using '=', which other languages use!"
                       FUNCTION TRIM(C-RST)
                   DISPLAY "  In COBOL, we write a plain-English sentence using verbs"
                   DISPLAY "  (like MOVE or ADD) instead of '='."
                   EXIT PARAGRAPH
               END-IF
           END-IF

           *> 2. Check quotation marks rule (literal text vs box names!)
           INSPECT WS-D-UP-IN TALLYING WS-TALLY-Q1 FOR ALL '"'
           INSPECT WS-D-UP-IN TALLYING WS-TALLY-Q2 FOR ALL "'"
           IF DV-QUOTE-RULE(WS-D-CUR-VAR) = "Y"
               IF WS-TALLY-Q1 < 2 AND WS-TALLY-Q2 < 2
                   DISPLAY FUNCTION TRIM(C-YLW)
                       '  [COACHING] Put quotation marks ("...") around literal text!'
                       FUNCTION TRIM(C-RST)
                   DISPLAY "  Without quotes, COBOL thinks your words are storage-box names"
                   DISPLAY "  instead of exact text to display or store."
                   EXIT PARAGRAPH
               END-IF
           END-IF
           IF DV-QUOTE-RULE(WS-D-CUR-VAR) = "N"
               IF WS-TALLY-Q1 > 0 OR WS-TALLY-Q2 > 0
                   DISPLAY FUNCTION TRIM(C-YLW)
                       "  [COACHING] Remove the quotation marks here!"
                       FUNCTION TRIM(C-RST)
                   DISPLAY "  Storage-box names and pure numbers NEVER wear quotes in COBOL"
                   DISPLAY '  (quotes turn BALANCE into the 7-letter word "BALANCE"!).'
                   EXIT PARAGRAPH
               END-IF
           END-IF

           *> 3. Check Required Token 1
           IF DV-TOK-1(WS-D-CUR-VAR) NOT = SPACES
               MOVE 0 TO WS-TALLY-A
               INSPECT WS-D-UP-IN TALLYING WS-TALLY-A
                   FOR ALL FUNCTION TRIM(DV-TOK-1(WS-D-CUR-VAR))
               IF WS-TALLY-A = 0
                   DISPLAY FUNCTION TRIM(C-RED) "  [CHECK STEP 1] "
                       FUNCTION TRIM(DV-ERR-1(WS-D-CUR-VAR))
                       FUNCTION TRIM(C-RST)
                   EXIT PARAGRAPH
               END-IF
               INSPECT WS-D-UP-IN TALLYING WS-POS-1
                   FOR CHARACTERS BEFORE INITIAL
                   FUNCTION TRIM(DV-TOK-1(WS-D-CUR-VAR))
           END-IF

           *> 4. Check Required Token 2 (or alternative spelling DV-TOK-2-ALT)
           IF DV-TOK-2(WS-D-CUR-VAR) NOT = SPACES
               MOVE 0 TO WS-TALLY-A WS-TALLY-B
               INSPECT WS-D-UP-IN TALLYING WS-TALLY-A
                   FOR ALL FUNCTION TRIM(DV-TOK-2(WS-D-CUR-VAR))
               IF DV-TOK-2-ALT(WS-D-CUR-VAR) NOT = SPACES
                   INSPECT WS-D-UP-IN TALLYING WS-TALLY-B
                       FOR ALL FUNCTION TRIM(DV-TOK-2-ALT(WS-D-CUR-VAR))
               END-IF
               IF WS-TALLY-A = 0 AND WS-TALLY-B = 0
                   DISPLAY FUNCTION TRIM(C-RED) "  [CHECK STEP 2] "
                       FUNCTION TRIM(DV-ERR-2(WS-D-CUR-VAR))
                       FUNCTION TRIM(C-RST)
                   EXIT PARAGRAPH
               END-IF
               IF WS-TALLY-A > 0
                   INSPECT WS-D-UP-IN TALLYING WS-POS-2
                       FOR CHARACTERS BEFORE INITIAL
                       FUNCTION TRIM(DV-TOK-2(WS-D-CUR-VAR))
               ELSE
                   INSPECT WS-D-UP-IN TALLYING WS-POS-2
                       FOR CHARACTERS BEFORE INITIAL
                       FUNCTION TRIM(DV-TOK-2-ALT(WS-D-CUR-VAR))
               END-IF
           END-IF

           *> 5. Check Required Token 3 (or alternative spelling DV-TOK-3-ALT)
           IF DV-TOK-3(WS-D-CUR-VAR) NOT = SPACES
               MOVE 0 TO WS-TALLY-A WS-TALLY-B
               INSPECT WS-D-UP-IN TALLYING WS-TALLY-A
                   FOR ALL FUNCTION TRIM(DV-TOK-3(WS-D-CUR-VAR))
               IF DV-TOK-3-ALT(WS-D-CUR-VAR) NOT = SPACES
                   INSPECT WS-D-UP-IN TALLYING WS-TALLY-B
                       FOR ALL FUNCTION TRIM(DV-TOK-3-ALT(WS-D-CUR-VAR))
               END-IF
               IF WS-TALLY-A = 0 AND WS-TALLY-B = 0
                   DISPLAY FUNCTION TRIM(C-RED) "  [CHECK STEP 3] "
                       FUNCTION TRIM(DV-ERR-3(WS-D-CUR-VAR))
                       FUNCTION TRIM(C-RST)
                   EXIT PARAGRAPH
               END-IF
               IF WS-TALLY-A > 0
                   INSPECT WS-D-UP-IN TALLYING WS-POS-3
                       FOR CHARACTERS BEFORE INITIAL
                       FUNCTION TRIM(DV-TOK-3(WS-D-CUR-VAR))
               ELSE
                   INSPECT WS-D-UP-IN TALLYING WS-POS-3
                       FOR CHARACTERS BEFORE INITIAL
                       FUNCTION TRIM(DV-TOK-3-ALT(WS-D-CUR-VAR))
               END-IF
           END-IF

           *> 6. Check Optional Required Token 4
           IF DV-TOK-4(WS-D-CUR-VAR) NOT = SPACES
               MOVE 0 TO WS-TALLY-A
               INSPECT WS-D-UP-IN TALLYING WS-TALLY-A
                   FOR ALL FUNCTION TRIM(DV-TOK-4(WS-D-CUR-VAR))
               IF WS-TALLY-A = 0
                   DISPLAY FUNCTION TRIM(C-RED) "  [CHECK STEP 4] "
                       FUNCTION TRIM(DV-ERR-4(WS-D-CUR-VAR))
                       FUNCTION TRIM(C-RST)
                   EXIT PARAGRAPH
               END-IF
           END-IF

           *> 7. Check English word order (catches backwards statements!)
           IF DV-CHECK-ORDER(WS-D-CUR-VAR) = "Y"
               IF DV-TOK-2(WS-D-CUR-VAR) NOT = SPACES
                  AND WS-POS-1 > WS-POS-2
                   DISPLAY FUNCTION TRIM(C-YLW)
                       "  [WORD ORDER] You have the right words, just in reverse order!"
                       FUNCTION TRIM(C-RST)
                   DISPLAY "  Make sure " FUNCTION TRIM(DV-TOK-1(WS-D-CUR-VAR))
                       " comes BEFORE " FUNCTION TRIM(DV-TOK-2(WS-D-CUR-VAR)) "."
                   EXIT PARAGRAPH
               END-IF
               IF DV-TOK-3(WS-D-CUR-VAR) NOT = SPACES
                  AND WS-POS-2 > WS-POS-3
                   DISPLAY FUNCTION TRIM(C-YLW)
                       "  [WORD ORDER] Almost! Check the order of the last two parts:"
                       FUNCTION TRIM(C-RST)
                   DISPLAY "  " FUNCTION TRIM(DV-TOK-2(WS-D-CUR-VAR))
                       " should appear BEFORE "
                       FUNCTION TRIM(DV-TOK-3(WS-D-CUR-VAR)) "."
                   EXIT PARAGRAPH
               END-IF
           END-IF

           *> 8. Check ending period (.) rule!
           IF DV-NEED-PERIOD(WS-D-CUR-VAR) = "Y"
               IF WS-D-LAST-CH NOT = "."
                   DISPLAY FUNCTION TRIM(C-YLW)
                       "  [SO CLOSE!] Every word in your COBOL line is right -- you just"
                       FUNCTION TRIM(C-RST)
                   DISPLAY "  forgot the period (.) at the very end to finish the sentence!"
                   EXIT PARAGRAPH
               END-IF
           END-IF

           MOVE "Y" TO WS-D-LINE-OK.

*> ===================================================================
*> 8500-EXPLAIN-AND-ROTATE
*> Shows side-by-side comparison + plain-English anatomy of the
*> current problem, then switches to a NEW variant to solve solo!
*> ===================================================================
       8500-EXPLAIN-AND-ROTATE.
           MOVE 0 TO WS-PLAYER-STREAK
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-MAG)
               "  +============= LET'S BREAK THIS ONE DOWN STEP-BY-STEP =============+"
               FUNCTION TRIM(C-RST)
           DISPLAY "  Your input   : " FUNCTION TRIM(WS-D-RAW-IN)
           DISPLAY "  Working code : " FUNCTION TRIM(C-GRN)
               FUNCTION TRIM(DV-SOLUTION(WS-D-CUR-VAR)) FUNCTION TRIM(C-RST)
           DISPLAY " "
           DISPLAY "  WHY EACH PART IS THERE:"
           DISPLAY "    1) " FUNCTION TRIM(DV-ANAT-1(WS-D-CUR-VAR))
           DISPLAY "    2) " FUNCTION TRIM(DV-ANAT-2(WS-D-CUR-VAR))
           DISPLAY "    3) " FUNCTION TRIM(DV-ANAT-3(WS-D-CUR-VAR))
           DISPLAY FUNCTION TRIM(C-MAG)
               "  +==================================================================+"
               FUNCTION TRIM(C-RST)
           DISPLAY "  Now that we walked through Variant " WS-D-CUR-VAR
               ", let's try a " FUNCTION TRIM(C-YLW) "FRESH VARIANT"
               FUNCTION TRIM(C-RST) " on"
           DISPLAY "  your own so you can lock in the pattern!"
           DISPLAY FUNCTION TRIM(C-DIM)
               "  [Press ENTER for your new variant...]"
               FUNCTION TRIM(C-RST) WITH NO ADVANCING
           ACCEPT WS-PAUSE-DUMMY
           PERFORM 8600-ADVANCE-VARIANT
           PERFORM 8050-PRINT-DRILL-PROMPT.

       8600-ADVANCE-VARIANT.
           IF WS-D-CUR-VAR = 3
               MOVE 1 TO WS-D-CUR-VAR
           ELSE
               ADD 1 TO WS-D-CUR-VAR
           END-IF
           MOVE 0 TO WS-D-ATTEMPTS
           MOVE 0 TO WS-D-HINT-LVL.
