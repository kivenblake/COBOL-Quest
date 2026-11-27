*> ===================================================================
*> COPYBOOK: chapters-5-to-8.cpy
*> PURPOSE : Zero-to-Master Curriculum Chapters 5 through 8
*>           + Midnight Payroll Final Mastery Exam!
*> ===================================================================

*> ===================================================================
*> CHAPTER 5: TEACHING THE COMPUTER MATH & PENNY ROUNDING
*> ===================================================================
       2500-CHAPTER-5.
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== CHAPTER 5 (Page 1/2): TWO WAYS TO DO MATH IN COBOL ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  Now that we have number boxes, how do we calculate totals,"
           DISPLAY "  scores, or bank interest? COBOL gives you TWO friendly styles:"
           DISPLAY " "
           DISPLAY "  STYLE 1: " FUNCTION TRIM(C-YLW) "Plain-English Math Verbs"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "      ADD 10 TO SCORE.                 *> Increases SCORE by 10"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "      SUBTRACT FEE FROM BALANCE.       *> Lowers BALANCE by FEE"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "      MULTIPLY PRICE BY QTY GIVING TOTAL."
               FUNCTION TRIM(C-RST)
           DISPLAY " "
           DISPLAY "  STYLE 2: " FUNCTION TRIM(C-YLW) "Formula Style (COMPUTE)"
               FUNCTION TRIM(C-RST)
           DISPLAY "  When you have a longer math formula, start with "
               FUNCTION TRIM(C-GRN) "COMPUTE" FUNCTION TRIM(C-RST) " (which"
           DISPLAY "  IS the one verb in COBOL that uses '=' like a calculator!):"
           DISPLAY FUNCTION TRIM(C-GRN)
               "      COMPUTE TOTAL = PRICE * QTY + TAX."
               FUNCTION TRIM(C-RST)
           DISPLAY "  (Keyboard symbols:  + add  |  - subtract  |  * multiply  |  / divide)"
           PERFORM 9000-PRESS-ENTER
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== CHAPTER 5 (Page 2/2): ROUNDING PENNIES & OVERFLOW ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  Suppose 3 friends split a $20.00 pizza: 20.00 / 3 = 6.6666..."
           DISPLAY "  A money box with V99 only has 2 cent slots! What happens to"
           DISPLAY "  those leftover fractions?"
           DISPLAY " "
           DISPLAY "  * " FUNCTION TRIM(C-RED) "WITHOUT ROUNDED (Default):"
               FUNCTION TRIM(C-RST)
               " COBOL simply chops off extra digits"
           DISPLAY "    (called TRUNCATION):  6.6666... becomes "
               FUNCTION TRIM(C-YLW) "6.66" FUNCTION TRIM(C-RST) "!"
           DISPLAY "  * " FUNCTION TRIM(C-GRN) "WITH ROUNDED:"
               FUNCTION TRIM(C-RST)
               " Adding the word ROUNDED rounds 5-or-higher up:"
           DISPLAY FUNCTION TRIM(C-GRN)
               "      ADD INTEREST TO BALANCE ROUNDED."
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "      COMPUTE SHARE ROUNDED = 20.00 / 3.   *> Gives 6.67!"
               FUNCTION TRIM(C-RST)
           DISPLAY " "
           DISPLAY "  And what if you add 100 into a tiny 2-digit box (PIC 99, max 99)?"
           DISPLAY "  Like pouring a gallon into a teacup, it overflows! You can"
           DISPLAY "  attach " FUNCTION TRIM(C-YLW)
               'ON SIZE ERROR DISPLAY "TOO BIG!"' FUNCTION TRIM(C-RST)
               " to catch overflows safely."
           PERFORM 9000-PRESS-ENTER
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- QUIZ 5 ---
           INITIALIZE WS-QUIZ-BANK
           MOVE "MATH & ROUNDING" TO WS-Q-TITLE

           MOVE "Box SHARE has PIC 99V99 (2 cent slots). What value ends up in"
               TO QZ-Q1(1)
           MOVE "SHARE if you write:  COMPUTE SHARE = 20.00 / 3.  (no ROUNDED)?"
               TO QZ-Q2(1)
           MOVE "06.66 (COBOL chops off extra decimals unless you say ROUNDED!)"
               TO QZ-OPT-A(1)
           MOVE "06.67"
               TO QZ-OPT-B(1)
           MOVE "20.00"
               TO QZ-OPT-C(1)
           MOVE "A" TO QZ-ANS(1)
           MOVE "By default COBOL truncates (6.66); ROUNDED gives 6.67!"
               TO QZ-OK-MSG(1)
           MOVE "20.00 divided by 3 is 6.66666..."
               TO QZ-WHY-1(1)
           MOVE "Unless you include the keyword ROUNDED, COBOL chops off everything"
               TO QZ-WHY-2(1)
           MOVE "past the 2nd cent slot, storing 06.66 instead of 06.67!"
               TO QZ-WHY-3(1)

           MOVE "Which symbol means MULTIPLY inside a COBOL COMPUTE formula?"
               TO QZ-Q1(2)
           MOVE "(For example, multiplying HOURS times RATE)"
               TO QZ-Q2(2)
           MOVE "The letter X  (HOURS X RATE)"
               TO QZ-OPT-A(2)
           MOVE "The asterisk * (HOURS * RATE)"
               TO QZ-OPT-B(2)
           MOVE "The hashtag # (HOURS # RATE)"
               TO QZ-OPT-C(2)
           MOVE "B" TO QZ-ANS(2)
           MOVE "Yes! Computers use * for multiply so it isn't confused with letter X!"
               TO QZ-OK-MSG(2)
           MOVE "If computers used X for multiply, COBOL couldn't tell the letter X"
               TO QZ-WHY-1(2)
           MOVE "apart from a variable name! So * means multiply and / means divide."
               TO QZ-WHY-2(2)
           MOVE "Example: COMPUTE PAY ROUNDED = HOURS * RATE."
               TO QZ-WHY-3(2)

           PERFORM 7800-RUN-ADAPTIVE-QUIZ
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- DRILL 5A: PLAIN-ENGLISH ADD WITH ROUNDED ---
           INITIALIZE WS-DRILL-BANK
           MOVE "ENGLISH MATH WITH ROUNDED (ADD)" TO DRL-HEADER

           MOVE "Add the box INTEREST into the box BALANCE, with half-cent"
               TO DV-TASK-1(1)
           MOVE "rounding turned on! (Use the ADD verb and end with a period.)"
               TO DV-TASK-2(1)
           MOVE "Similar example:  ADD BONUS TO PAYCHECK ROUNDED."
               TO DV-HINT-1(1)
           MOVE "Blueprint:  ADD ________ TO _______ ROUNDED."
               TO DV-HINT-2(1)
           MOVE "ADD INTEREST TO BALANCE ROUNDED."
               TO DV-SOLUTION(1)
           MOVE "ADD <amount> TO <target> increases the target box in place."
               TO DV-ANAT-1(1)
           MOVE "INTEREST is added into BALANCE (neither box name wears quotes!)."
               TO DV-ANAT-2(1)
           MOVE "ROUNDED ensures half-cents round up cleanly before the '.'."
               TO DV-ANAT-3(1)
           MOVE "BALANCE updated with exact rounded penny precision!"
               TO DV-EFFECT(1)
           MOVE "Y" TO DV-FORBID-EQ(1) DV-NEED-PERIOD(1) DV-CHECK-ORDER(1)
           MOVE "N" TO DV-QUOTE-RULE(1)
           MOVE "ADD" TO DV-TOK-1(1)
           MOVE "Start with the verb ADD (for formula '=', wait for the next drill!)."
               TO DV-ERR-1(1)
           MOVE "INTEREST" TO DV-TOK-2(1)
           MOVE "Specify INTEREST right after ADD."
               TO DV-ERR-2(1)
           MOVE "BALANCE" TO DV-TOK-3(1)
           MOVE "Put TO BALANCE after INTEREST."
               TO DV-ERR-3(1)
           MOVE "ROUNDED" TO DV-TOK-4(1)
           MOVE "Include the word ROUNDED before the final period!"
               TO DV-ERR-4(1)

           MOVE "Add the box TAX-AMT into the box TOTAL-BILL with rounding"
               TO DV-TASK-1(2)
           MOVE "turned on (use ADD ... TO ... ROUNDED.)."
               TO DV-TASK-2(2)
           MOVE "Similar example:  ADD TIP-AMT TO SUBTOTAL ROUNDED."
               TO DV-HINT-1(2)
           MOVE "Blueprint:  ADD _______ TO __________ ROUNDED."
               TO DV-HINT-2(2)
           MOVE "ADD TAX-AMT TO TOTAL-BILL ROUNDED."
               TO DV-SOLUTION(2)
           MOVE "ADD starts our plain-English addition sentence."
               TO DV-ANAT-1(2)
           MOVE "TAX-AMT TO TOTAL-BILL adds TAX-AMT into TOTAL-BILL."
               TO DV-ANAT-2(2)
           MOVE "ROUNDED rounds any leftover fraction before the period."
               TO DV-ANAT-3(2)
           MOVE "TOTAL-BILL updated with rounded TAX-AMT!"
               TO DV-EFFECT(2)
           MOVE "Y" TO DV-FORBID-EQ(2) DV-NEED-PERIOD(2) DV-CHECK-ORDER(2)
           MOVE "N" TO DV-QUOTE-RULE(2)
           MOVE "ADD" TO DV-TOK-1(2)
           MOVE "Start with the verb ADD."
               TO DV-ERR-1(2)
           MOVE "TAX-AMT" TO DV-TOK-2(2)
           MOVE "Specify TAX-AMT as the amount to add."
               TO DV-ERR-2(2)
           MOVE "TOTAL-BILL" TO DV-TOK-3(2)
           MOVE "Specify TO TOTAL-BILL as the receiving box."
               TO DV-ERR-3(2)
           MOVE "ROUNDED" TO DV-TOK-4(2)
           MOVE "Add the keyword ROUNDED before the period!"
               TO DV-ERR-4(2)

           MOVE "Add the box DIVIDEND into the box SAVINGS with rounding on."
               TO DV-TASK-1(3)
           MOVE "(Use ADD ... TO ... ROUNDED. and end with a period!)"
               TO DV-TASK-2(3)
           MOVE "Similar example:  ADD REWARD TO POINTS ROUNDED."
               TO DV-HINT-1(3)
           MOVE "Blueprint:  ADD ________ TO _______ ROUNDED."
               TO DV-HINT-2(3)
           MOVE "ADD DIVIDEND TO SAVINGS ROUNDED."
               TO DV-SOLUTION(3)
           MOVE "ADD begins the addition statement."
               TO DV-ANAT-1(3)
           MOVE "DIVIDEND TO SAVINGS adds DIVIDEND into SAVINGS."
               TO DV-ANAT-2(3)
           MOVE "ROUNDED prevents penny truncation."
               TO DV-ANAT-3(3)
           MOVE "SAVINGS increased by rounded DIVIDEND!"
               TO DV-EFFECT(3)
           MOVE "Y" TO DV-FORBID-EQ(3) DV-NEED-PERIOD(3) DV-CHECK-ORDER(3)
           MOVE "N" TO DV-QUOTE-RULE(3)
           MOVE "ADD" TO DV-TOK-1(3)
           MOVE "Start with ADD."
               TO DV-ERR-1(3)
           MOVE "DIVIDEND" TO DV-TOK-2(3)
           MOVE "Include DIVIDEND after ADD."
               TO DV-ERR-2(3)
           MOVE "SAVINGS" TO DV-TOK-3(3)
           MOVE "Include TO SAVINGS."
               TO DV-ERR-3(3)
           MOVE "ROUNDED" TO DV-TOK-4(3)
           MOVE "Include ROUNDED before the final period!"
               TO DV-ERR-4(3)

           PERFORM 8000-RUN-ADAPTIVE-DRILL
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- DRILL 5B: FORMULA STYLE WITH COMPUTE ---
           INITIALIZE WS-DRILL-BANK
           MOVE "FORMULA MATH (COMPUTE ROUNDED)" TO DRL-HEADER

           MOVE "Use COMPUTE (with ROUNDED!) to set GROSS-PAY equal to"
               TO DV-TASK-1(1)
           MOVE "HOURS multiplied by RATE (remember '*' means multiply!)."
               TO DV-TASK-2(1)
           MOVE "Similar example:  COMPUTE AREA ROUNDED = WIDTH * HEIGHT."
               TO DV-HINT-1(1)
           MOVE "Blueprint:  COMPUTE _________ ROUNDED = _____ * ____."
               TO DV-HINT-2(1)
           MOVE "COMPUTE GROSS-PAY ROUNDED = HOURS * RATE."
               TO DV-SOLUTION(1)
           MOVE "COMPUTE GROSS-PAY ROUNDED names the target box with rounding on."
               TO DV-ANAT-1(1)
           MOVE "= separates the target box on the left from the math formula."
               TO DV-ANAT-2(1)
           MOVE "HOURS * RATE. multiplies the two boxes and ends with '.'."
               TO DV-ANAT-3(1)
           MOVE "Calculated GROSS-PAY = HOURS * RATE (rounded to nearest cent)!"
               TO DV-EFFECT(1)
           MOVE " " TO DV-FORBID-EQ(1)
           MOVE "N" TO DV-QUOTE-RULE(1)
           MOVE "Y" TO DV-NEED-PERIOD(1) DV-CHECK-ORDER(1)
           MOVE "COMPUTE" TO DV-TOK-1(1)
           MOVE "Start formula calculations with the verb COMPUTE."
               TO DV-ERR-1(1)
           MOVE "GROSS-PAY" TO DV-TOK-2(1)
           MOVE "Put GROSS-PAY right after COMPUTE as the box receiving the result."
               TO DV-ERR-2(1)
           MOVE "ROUNDED" TO DV-TOK-3(1)
           MOVE "Put ROUNDED right after GROSS-PAY (before the '=' sign!)."
               TO DV-ERR-3(1)
           MOVE "*" TO DV-TOK-4(1)
           MOVE "Use '=' and '*' to multiply HOURS * RATE!"
               TO DV-ERR-4(1)

           MOVE "Use COMPUTE (with ROUNDED!) to set TAX equal to PRICE * 0.08"
               TO DV-TASK-1(2)
           MOVE "(Put ROUNDED right after TAX, before '=', and end with .)."
               TO DV-TASK-2(2)
           MOVE "Similar example:  COMPUTE TIP ROUNDED = BILL * 0.15."
               TO DV-HINT-1(2)
           MOVE "Blueprint:  COMPUTE ___ ROUNDED = _____ * 0.08."
               TO DV-HINT-2(2)
           MOVE "COMPUTE TAX ROUNDED = PRICE * 0.08."
               TO DV-SOLUTION(2)
           MOVE "COMPUTE TAX ROUNDED stores the rounded answer in TAX."
               TO DV-ANAT-1(2)
           MOVE "= introduces the math expression."
               TO DV-ANAT-2(2)
           MOVE "PRICE * 0.08. calculates 8% of PRICE and closes with '.'."
               TO DV-ANAT-3(2)
           MOVE "Calculated rounded 8% sales tax into TAX!"
               TO DV-EFFECT(2)
           MOVE " " TO DV-FORBID-EQ(2)
           MOVE "N" TO DV-QUOTE-RULE(2)
           MOVE "Y" TO DV-NEED-PERIOD(2) DV-CHECK-ORDER(2)
           MOVE "COMPUTE" TO DV-TOK-1(2)
           MOVE "Start with COMPUTE."
               TO DV-ERR-1(2)
           MOVE "TAX" TO DV-TOK-2(2)
           MOVE "Name TAX as the target box after COMPUTE."
               TO DV-ERR-2(2)
           MOVE "ROUNDED" TO DV-TOK-3(2)
           MOVE "Place ROUNDED between TAX and '='!"
               TO DV-ERR-3(2)
           MOVE "0.08" TO DV-TOK-4(2)
           MOVE "Multiply PRICE * 0.08 after the '=' sign!"
               TO DV-ERR-4(2)

           MOVE "Use COMPUTE (with ROUNDED!) to set SHARE equal to TOTAL / 4"
               TO DV-TASK-1(3)
           MOVE "(Remember '/' means divide, and end with a period!)."
               TO DV-TASK-2(3)
           MOVE "Similar example:  COMPUTE HALF ROUNDED = AMOUNT / 2."
               TO DV-HINT-1(3)
           MOVE "Blueprint:  COMPUTE _____ ROUNDED = _____ / 4."
               TO DV-HINT-2(3)
           MOVE "COMPUTE SHARE ROUNDED = TOTAL / 4."
               TO DV-SOLUTION(3)
           MOVE "COMPUTE SHARE ROUNDED prepares to round the division result."
               TO DV-ANAT-1(3)
           MOVE "= connects SHARE to the division formula."
               TO DV-ANAT-2(3)
           MOVE "TOTAL / 4. divides TOTAL by 4 and finishes with '.'."
               TO DV-ANAT-3(3)
           MOVE "Divided TOTAL cleanly into 4 rounded shares!"
               TO DV-EFFECT(3)
           MOVE " " TO DV-FORBID-EQ(3)
           MOVE "N" TO DV-QUOTE-RULE(3)
           MOVE "Y" TO DV-NEED-PERIOD(3) DV-CHECK-ORDER(3)
           MOVE "COMPUTE" TO DV-TOK-1(3)
           MOVE "Begin with COMPUTE."
               TO DV-ERR-1(3)
           MOVE "SHARE" TO DV-TOK-2(3)
           MOVE "Put SHARE after COMPUTE."
               TO DV-ERR-2(3)
           MOVE "ROUNDED" TO DV-TOK-3(3)
           MOVE "Put ROUNDED right after SHARE (before '=')."
               TO DV-ERR-3(3)
           MOVE "/ 4" TO DV-TOK-4(3)
           MOVE "Divide TOTAL / 4 after the '=' sign!"
               TO DV-ERR-4(3)

           PERFORM 8000-RUN-ADAPTIVE-DRILL
           MOVE 5 TO WS-MISSION-NUM
           PERFORM 1900-COMPLETE-MISSION.

*> ===================================================================
*> CHAPTER 6: MAKING DECISIONS (IF / END-IF & LEVEL-88 SWITCHES)
*> ===================================================================
       2600-CHAPTER-6.
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== CHAPTER 6 (Page 1/2): TEACHING CODE TO MAKE CHOICES ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  So far, every line ran from top to bottom. What if an ATM should"
           DISPLAY "  dispense cash ONLY if the balance is big enough? We use "
               FUNCTION TRIM(C-YLW) "IF" FUNCTION TRIM(C-RST) "!"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               "      IF AGE >= 18"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               '          DISPLAY "CAN VOTE"'
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "      ELSE"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               '          DISPLAY "TOO YOUNG"'
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "      END-IF."
               FUNCTION TRIM(C-RST)
           DISPLAY " "
           DISPLAY "  Comparison symbols:  = (equal)  |  > (greater)  |  < (less)  |  >="
           DISPLAY " "
           DISPLAY "  " FUNCTION TRIM(C-RED) "MILLION-DOLLAR SAFETY RULE:"
               FUNCTION TRIM(C-RST) " Notice there are NO periods inside"
           DISPLAY "  the IF block -- ONLY " FUNCTION TRIM(C-YLW) "END-IF."
               FUNCTION TRIM(C-RST) " at the bottom! Why? Because a stray"
           DISPLAY "  period in the middle slams the IF shut early, causing lines"
           DISPLAY "  below it to run EVERY time even when the IF was false!"
           PERFORM 9000-PRESS-ENTER
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== CHAPTER 6 (Page 2/2): LEVEL-88 NICKNAME SWITCHES ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  One of COBOL's most loved inventions is "
               FUNCTION TRIM(C-YLW) "Level-88 Condition Names"
               FUNCTION TRIM(C-RST) "."
           DISPLAY "  Suppose a box VIP-FLAG holds ""Y"" for VIPs and ""N"" for regular:"
           DISPLAY "  Instead of forcing readers to guess what ""Y"" means later, you"
           DISPLAY "  attach an " FUNCTION TRIM(C-GRN) "88" FUNCTION TRIM(C-RST)
               " nickname right underneath the box in DATA DIVISION:"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               '      01 VIP-FLAG       PIC X VALUE "N".'
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               '         88 VIP-CLIENT        VALUE "Y".'
               FUNCTION TRIM(C-RST)
           DISPLAY " "
           DISPLAY "  Now, inside PROCEDURE DIVISION, you can simply write:"
           DISPLAY FUNCTION TRIM(C-GRN)
               '      IF VIP-CLIENT DISPLAY "FREE UPGRADE!" END-IF.'
               FUNCTION TRIM(C-RST)
           DISPLAY "  COBOL automatically checks whether VIP-FLAG equals ""Y""! And"
           DISPLAY "  when you have 3+ choices (like grades A/B/C), COBOL also offers"
           DISPLAY "  EVALUATE TRUE ... WHEN ... END-EVALUATE (see examples/05!)."
           PERFORM 9000-PRESS-ENTER
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- QUIZ 6 ---
           INITIALIZE WS-QUIZ-BANK
           MOVE "DECISIONS & LEVEL-88" TO WS-Q-TITLE

           MOVE "Look at this buggy snippet:"
               TO QZ-Q1(1)
           MOVE '  IF IS-ADMIN  DISPLAY "HI".  DISPLAY "SECRET VAULT".'
               TO QZ-Q2(1)
           MOVE 'Why does a NON-admin still see "SECRET VAULT"?!'
               TO QZ-OPT-A(1)
           MOVE "Because DISPLAY ignores IF statements"
               TO QZ-OPT-A(1)
           MOVE 'The period after "HI". ended the IF early! Use END-IF at the end.'
               TO QZ-OPT-B(1)
           MOVE "IS-ADMIN is spelled with a hyphen"
               TO QZ-OPT-C(1)
           MOVE "B" TO QZ-ANS(1)
           MOVE "Yes! Never put a period mid-IF; close the whole block with END-IF."
               TO QZ-OK-MSG(1)
           MOVE 'That sneaky period right after "HI". told COBOL: the IF sentence'
               TO QZ-WHY-1(1)
           MOVE 'is completely over! So DISPLAY "SECRET VAULT" became a brand-new'
               TO QZ-WHY-2(1)
           MOVE "unconditional sentence! Always omit mid-IF periods and use END-IF."
               TO QZ-WHY-3(1)

           MOVE 'What does level number 88 do in:  88 ACCOUNT-OPEN VALUE "O". ?'
               TO QZ-Q1(2)
           MOVE "(Placed right underneath 01 ACCT-STATUS PIC X.)"
               TO QZ-Q2(2)
           MOVE "It creates 88 separate bank accounts"
               TO QZ-OPT-A(2)
           MOVE 'It gives ACCT-STATUS = "O" a readable true/false nickname!'
               TO QZ-OPT-B(2)
           MOVE "It makes text 88 characters wide"
               TO QZ-OPT-C(2)
           MOVE "B" TO QZ-ANS(2)
           MOVE "Spot on! You can then write: IF ACCOUNT-OPEN ... END-IF!"
               TO QZ-OK-MSG(2)
           MOVE "Level 88 doesn't take extra memory -- it creates a true/false"
               TO QZ-WHY-1(2)
           MOVE 'nickname that turns TRUE whenever the parent box holds "O".'
               TO QZ-WHY-2(2)
           MOVE "That makes your IF statements read like natural English!"
               TO QZ-WHY-3(2)

           PERFORM 7800-RUN-ADAPTIVE-QUIZ
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- DRILL 6A: ONE-LINE IF ... END-IF. ---
           INITIALIZE WS-DRILL-BANK
           MOVE "WRITING AN IF ... END-IF DECISION" TO DRL-HEADER

           MOVE 'Write an IF rule: if SCORE = 100, print "PERFECT", and close'
               TO DV-TASK-1(1)
           MOVE "with END-IF. (All on one line, period ONLY after END-IF!)"
               TO DV-TASK-2(1)
           MOVE 'Similar example:  IF LIVES = 0 DISPLAY "GAME OVER" END-IF.'
               TO DV-HINT-1(1)
           MOVE 'Blueprint:  IF SCORE = 100 DISPLAY "_______" END-IF.'
               TO DV-HINT-2(1)
           MOVE 'IF SCORE = 100 DISPLAY "PERFECT" END-IF.'
               TO DV-SOLUTION(1)
           MOVE "IF SCORE = 100 checks whether box SCORE holds 100."
               TO DV-ANAT-1(1)
           MOVE 'DISPLAY "PERFECT" runs only when that check is true (no period!).'
               TO DV-ANAT-2(1)
           MOVE "END-IF. cleanly closes the decision block with a single period."
               TO DV-ANAT-3(1)
           MOVE 'Decision gate active -> prints "PERFECT" only when SCORE = 100!'
               TO DV-EFFECT(1)
           MOVE " " TO DV-FORBID-EQ(1)
           MOVE "Y" TO DV-QUOTE-RULE(1) DV-NEED-PERIOD(1) DV-CHECK-ORDER(1)
           MOVE "IF" TO DV-TOK-1(1)
           MOVE "Begin your decision with the keyword IF."
               TO DV-ERR-1(1)
           MOVE "SCORE = 100" TO DV-TOK-2(1)
           MOVE "SCORE=100" TO DV-TOK-2-ALT(1)
           MOVE "Check the condition SCORE = 100 right after IF."
               TO DV-ERR-2(1)
           MOVE '"PERFECT"' TO DV-TOK-3(1)
           MOVE "'PERFECT'" TO DV-TOK-3-ALT(1)
           MOVE 'Use DISPLAY "PERFECT" inside the IF!'
               TO DV-ERR-3(1)
           MOVE "END-IF" TO DV-TOK-4(1)
           MOVE "Close your IF block with END-IF (followed by a period)!"
               TO DV-ERR-4(1)

           MOVE 'Write an IF rule: if FUEL < 10, print "LOW FUEL", and close'
               TO DV-TASK-1(2)
           MOVE "with END-IF. (Put the period ONLY at the very end!)"
               TO DV-TASK-2(2)
           MOVE 'Similar example:  IF TEMP < 32 DISPLAY "ICY" END-IF.'
               TO DV-HINT-1(2)
           MOVE 'Blueprint:  IF FUEL < 10 DISPLAY "________" END-IF.'
               TO DV-HINT-2(2)
           MOVE 'IF FUEL < 10 DISPLAY "LOW FUEL" END-IF.'
               TO DV-SOLUTION(2)
           MOVE "IF FUEL < 10 tests whether FUEL is under 10."
               TO DV-ANAT-1(2)
           MOVE 'DISPLAY "LOW FUEL" prints the warning when true.'
               TO DV-ANAT-2(2)
           MOVE "END-IF. seals the IF block safely."
               TO DV-ANAT-3(2)
           MOVE 'Warning sensor armed -> prints "LOW FUEL" when FUEL < 10!'
               TO DV-EFFECT(2)
           MOVE "Y" TO DV-FORBID-EQ(2) DV-QUOTE-RULE(2) DV-NEED-PERIOD(2)
                       DV-CHECK-ORDER(2)
           MOVE "IF" TO DV-TOK-1(2)
           MOVE "Start with IF."
               TO DV-ERR-1(2)
           MOVE "FUEL < 10" TO DV-TOK-2(2)
           MOVE "FUEL<10" TO DV-TOK-2-ALT(2)
           MOVE "Write the check FUEL < 10 after IF."
               TO DV-ERR-2(2)
           MOVE '"LOW FUEL"' TO DV-TOK-3(2)
           MOVE "'LOW FUEL'" TO DV-TOK-3-ALT(2)
           MOVE 'Include DISPLAY "LOW FUEL"!'
               TO DV-ERR-3(2)
           MOVE "END-IF" TO DV-TOK-4(2)
           MOVE "Finish with END-IF.!"
               TO DV-ERR-4(2)

           MOVE 'Write an IF rule: if AGE >= 21, print "ALLOWED", and close'
               TO DV-TASK-1(3)
           MOVE "with END-IF. (Period at the very end!)"
               TO DV-TASK-2(3)
           MOVE 'Similar example:  IF POINTS >= 50 DISPLAY "WIN" END-IF.'
               TO DV-HINT-1(3)
           MOVE 'Blueprint:  IF AGE >= 21 DISPLAY "_______" END-IF.'
               TO DV-HINT-2(3)
           MOVE 'IF AGE >= 21 DISPLAY "ALLOWED" END-IF.'
               TO DV-SOLUTION(3)
           MOVE "IF AGE >= 21 checks if AGE is 21 or more."
               TO DV-ANAT-1(3)
           MOVE 'DISPLAY "ALLOWED" shows the message when true.'
               TO DV-ANAT-2(3)
           MOVE "END-IF. closes the IF block."
               TO DV-ANAT-3(3)
           MOVE 'Age gate active -> prints "ALLOWED" when AGE >= 21!'
               TO DV-EFFECT(3)
           MOVE " " TO DV-FORBID-EQ(3)
           MOVE "Y" TO DV-QUOTE-RULE(3) DV-NEED-PERIOD(3) DV-CHECK-ORDER(3)
           MOVE "IF" TO DV-TOK-1(3)
           MOVE "Start with IF."
               TO DV-ERR-1(3)
           MOVE "AGE >= 21" TO DV-TOK-2(3)
           MOVE "AGE>=21" TO DV-TOK-2-ALT(3)
           MOVE "Check AGE >= 21 right after IF."
               TO DV-ERR-2(3)
           MOVE '"ALLOWED"' TO DV-TOK-3(3)
           MOVE "'ALLOWED'" TO DV-TOK-3-ALT(3)
           MOVE 'Include DISPLAY "ALLOWED"!'
               TO DV-ERR-3(3)
           MOVE "END-IF" TO DV-TOK-4(3)
           MOVE "Close with END-IF.!"
               TO DV-ERR-4(3)

           PERFORM 8000-RUN-ADAPTIVE-DRILL
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- DRILL 6B: LEVEL-88 NICKNAME ---
           INITIALIZE WS-DRILL-BANK
           MOVE "CREATING A LEVEL-88 NICKNAME" TO DRL-HEADER

           MOVE 'Define a level-88 condition named VIP-CLIENT for VALUE "Y"'
               TO DV-TASK-1(1)
           MOVE "(Remember: level 88, nickname, VALUE ""Y"", closing period!)."
               TO DV-TASK-2(1)
           MOVE 'Similar example:  88 IS-MARRIED VALUE "M".'
               TO DV-HINT-1(1)
           MOVE 'Blueprint:  88 __________ VALUE "Y".'
               TO DV-HINT-2(1)
           MOVE '88 VIP-CLIENT VALUE "Y".'
               TO DV-SOLUTION(1)
           MOVE "88 tells COBOL this is a condition nickname (not a new box)."
               TO DV-ANAT-1(1)
           MOVE "VIP-CLIENT is the plain-English name you'll use after IF."
               TO DV-ANAT-2(1)
           MOVE 'VALUE "Y". links the nickname to the letter "Y".'
               TO DV-ANAT-3(1)
           MOVE 'Condition VIP-CLIENT linked to "Y"!'
               TO DV-EFFECT(1)
           MOVE "Y" TO DV-FORBID-EQ(1) DV-QUOTE-RULE(1) DV-NEED-PERIOD(1)
                       DV-CHECK-ORDER(1)
           MOVE "88" TO DV-TOK-1(1)
           MOVE "Start with special level number 88."
               TO DV-ERR-1(1)
           MOVE "VIP-CLIENT" TO DV-TOK-2(1)
           MOVE "Name the condition VIP-CLIENT."
               TO DV-ERR-2(1)
           MOVE '"Y"' TO DV-TOK-3(1)
           MOVE "'Y'" TO DV-TOK-3-ALT(1)
           MOVE 'Specify VALUE "Y" (with quotes around Y!).'
               TO DV-ERR-3(1)
           MOVE "VALUE" TO DV-TOK-4(1)
           MOVE 'Include the keyword VALUE before "Y"!'
               TO DV-ERR-4(1)

           MOVE 'Define a level-88 condition named CARD-LOCKED for VALUE "L"'
               TO DV-TASK-1(2)
           MOVE '(Level 88 + CARD-LOCKED + VALUE "L" + period!).'
               TO DV-TASK-2(2)
           MOVE 'Similar example:  88 DOOR-OPEN VALUE "O".'
               TO DV-HINT-1(2)
           MOVE 'Blueprint:  88 ___________ VALUE "L".'
               TO DV-HINT-2(2)
           MOVE '88 CARD-LOCKED VALUE "L".'
               TO DV-SOLUTION(2)
           MOVE "88 declares a condition-name switch."
               TO DV-ANAT-1(2)
           MOVE "CARD-LOCKED is the readable condition name."
               TO DV-ANAT-2(2)
           MOVE 'VALUE "L". activates CARD-LOCKED whenever the box holds "L".'
               TO DV-ANAT-3(2)
           MOVE 'Condition CARD-LOCKED linked to "L"!'
               TO DV-EFFECT(2)
           MOVE "Y" TO DV-FORBID-EQ(2) DV-QUOTE-RULE(2) DV-NEED-PERIOD(2)
                       DV-CHECK-ORDER(2)
           MOVE "88" TO DV-TOK-1(2)
           MOVE "Start with level number 88."
               TO DV-ERR-1(2)
           MOVE "CARD-LOCKED" TO DV-TOK-2(2)
           MOVE "Name the condition CARD-LOCKED."
               TO DV-ERR-2(2)
           MOVE '"L"' TO DV-TOK-3(2)
           MOVE "'L'" TO DV-TOK-3-ALT(2)
           MOVE 'Put "L" in quotes after VALUE!'
               TO DV-ERR-3(2)
           MOVE "VALUE" TO DV-TOK-4(2)
           MOVE 'Include the word VALUE before "L"!'
               TO DV-ERR-4(2)

           MOVE 'Define a level-88 condition named TAX-EXEMPT for VALUE "E"'
               TO DV-TASK-1(3)
           MOVE '(Level 88 + TAX-EXEMPT + VALUE "E" + period!).'
               TO DV-TASK-2(3)
           MOVE 'Similar example:  88 AUTO-PAY VALUE "A".'
               TO DV-HINT-1(3)
           MOVE 'Blueprint:  88 __________ VALUE "E".'
               TO DV-HINT-2(3)
           MOVE '88 TAX-EXEMPT VALUE "E".'
               TO DV-SOLUTION(3)
           MOVE "88 defines a true/false nickname condition."
               TO DV-ANAT-1(3)
           MOVE "TAX-EXEMPT is the condition name."
               TO DV-ANAT-2(3)
           MOVE 'VALUE "E". ties it to character "E".'
               TO DV-ANAT-3(3)
           MOVE 'Condition TAX-EXEMPT linked to "E"!'
               TO DV-EFFECT(3)
           MOVE "Y" TO DV-FORBID-EQ(3) DV-QUOTE-RULE(3) DV-NEED-PERIOD(3)
                       DV-CHECK-ORDER(3)
           MOVE "88" TO DV-TOK-1(3)
           MOVE "Begin with level 88."
               TO DV-ERR-1(3)
           MOVE "TAX-EXEMPT" TO DV-TOK-2(3)
           MOVE "Name the condition TAX-EXEMPT."
               TO DV-ERR-2(3)
           MOVE '"E"' TO DV-TOK-3(3)
           MOVE "'E'" TO DV-TOK-3-ALT(3)
           MOVE 'Specify "E" in quotes!'
               TO DV-ERR-3(3)
           MOVE "VALUE" TO DV-TOK-4(3)
           MOVE 'Include VALUE before "E"!'
               TO DV-ERR-4(3)

           PERFORM 8000-RUN-ADAPTIVE-DRILL
           MOVE 6 TO WS-MISSION-NUM
           PERFORM 1900-COMPLETE-MISSION.

*> ===================================================================
*> CHAPTER 7: REPEATING WORK (PARAGRAPHS & PERFORM LOOPS)
*> ===================================================================
       2700-CHAPTER-7.
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== CHAPTER 7 (Page 1/2): RECIPE CARDS (PARAGRAPHS) ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  Imagine baking 500 cookies. You wouldn't write 'roll dough,"
           DISPLAY "  cut shape, bake 10 mins' 500 separate times in your cookbook!"
           DISPLAY "  Instead, you group those steps under a named heading -- called"
           DISPLAY "  a " FUNCTION TRIM(C-YLW) "PARAGRAPH"
               FUNCTION TRIM(C-RST) " in COBOL:"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               "      PRINT-DIVIDER.                           <- Paragraph name!"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               '          DISPLAY "------------------------".'
               FUNCTION TRIM(C-RST)
           DISPLAY " "
           DISPLAY "  Now, anywhere in your PROCEDURE DIVISION, one magic verb runs"
           DISPLAY "  that paragraph AND comes right back when it's done: "
               FUNCTION TRIM(C-YLW) "PERFORM" FUNCTION TRIM(C-RST) "!"
           DISPLAY " "
           DISPLAY "    * Run it once:      " FUNCTION TRIM(C-GRN)
               "PERFORM PRINT-DIVIDER." FUNCTION TRIM(C-RST)
           DISPLAY "    * Repeat 5 times:   " FUNCTION TRIM(C-GRN)
               "PERFORM PRINT-DIVIDER 5 TIMES." FUNCTION TRIM(C-RST)
           DISPLAY "  (Repeating steps automatically like that is called a "
               FUNCTION TRIM(C-YLW) "LOOP" FUNCTION TRIM(C-RST) "!)"
           PERFORM 9000-PRESS-ENTER
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== CHAPTER 7 (Page 2/2): SMART LOOPS (UNTIL & VARYING) ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  What if you don't know ahead of time whether a customer has 3"
           DISPLAY "  items in their cart or 300? You tell PERFORM to keep repeating"
           DISPLAY "  " FUNCTION TRIM(C-YLW) "UNTIL" FUNCTION TRIM(C-RST)
               " a stop sign turns true:"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               "      PERFORM RING-UP-ITEM UNTIL CART-EMPTY."
               FUNCTION TRIM(C-RST)
           DISPLAY " "
           DISPLAY "  Important detail: COBOL checks UNTIL *before* each pass -- so"
           DISPLAY "  if the cart is ALREADY empty, it runs 0 times cleanly!"
           DISPLAY " "
           DISPLAY "  And when you want a counter box (1, 2, 3...) to count upward"
           DISPLAY "  automatically on each pass, add "
               FUNCTION TRIM(C-YLW) "VARYING" FUNCTION TRIM(C-RST) ":"
           DISPLAY FUNCTION TRIM(C-GRN)
               "      PERFORM VARYING DAY-NUM FROM 1 BY 1 UNTIL DAY-NUM > 7"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               '          DISPLAY "Day #" DAY-NUM'
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "      END-PERFORM."
               FUNCTION TRIM(C-RST)
           DISPLAY "  -> Runs for DAY-NUM = 1, 2, 3, 4, 5, 6, 7, then stops at 8!"
           PERFORM 9000-PRESS-ENTER
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- QUIZ 7 ---
           INITIALIZE WS-QUIZ-BANK
           MOVE "PARAGRAPHS & PERFORM LOOPS" TO WS-Q-TITLE

           MOVE "Suppose CART-EMPTY is ALREADY true before this line starts:"
               TO QZ-Q1(1)
           MOVE "    PERFORM SCAN-BARCODE UNTIL CART-EMPTY."
               TO QZ-Q2(1)
           MOVE "How many times does SCAN-BARCODE run?"
               TO QZ-Q2(1)
           MOVE "0 times (PERFORM UNTIL checks the condition BEFORE running!)"
               TO QZ-OPT-A(1)
           MOVE "1 time"
               TO QZ-OPT-B(1)
           MOVE "Forever"
               TO QZ-OPT-C(1)
           MOVE "A" TO QZ-ANS(1)
           MOVE "Right! PERFORM UNTIL tests first, so an empty cart runs 0 times."
               TO QZ-OK-MSG(1)
           MOVE "By default, PERFORM UNTIL checks the stop condition at the door"
               TO QZ-WHY-1(1)
           MOVE "BEFORE entering the loop! Since CART-EMPTY is already true,"
               TO QZ-WHY-2(1)
           MOVE "it skips SCAN-BARCODE safely without scanning a phantom item."
               TO QZ-WHY-3(1)

           MOVE "How many times does DISPLAY run in:"
               TO QZ-Q1(2)
           MOVE "  PERFORM VARYING N FROM 1 BY 1 UNTIL N > 4  DISPLAY N  END-PERFORM."
               TO QZ-Q2(2)
           MOVE "3 times (1, 2, 3)"
               TO QZ-OPT-A(2)
           MOVE "4 times (runs for 1, 2, 3, 4 -- stops when N hits 5, which is > 4!)"
               TO QZ-OPT-B(2)
           MOVE "5 times"
               TO QZ-OPT-C(2)
           MOVE "B" TO QZ-ANS(2)
           MOVE "4 times! N=1, 2, 3, and 4 are not > 4; when N becomes 5, it stops."
               TO QZ-OK-MSG(2)
           MOVE "Trace N step-by-step: N=1 (not >4, runs), N=2 (runs), N=3 (runs),"
               TO QZ-WHY-1(2)
           MOVE "N=4 (4 is NOT greater than 4, so it runs!). Then N steps to 5:"
               TO QZ-WHY-2(2)
           MOVE "5 > 4 is TRUE, so the loop stops after 4 clean passes!"
               TO QZ-WHY-3(2)

           PERFORM 7800-RUN-ADAPTIVE-QUIZ
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- DRILL 7A: PERFORM N TIMES ---
           INITIALIZE WS-DRILL-BANK
           MOVE "REPEATING A PARAGRAPH (TIMES)" TO DRL-HEADER

           MOVE "Run the paragraph named PRINT-LINE 5 times using PERFORM."
               TO DV-TASK-1(1)
           MOVE "(No quotes around paragraph names -- end with a period!)"
               TO DV-TASK-2(1)
           MOVE "Similar example:  PERFORM BEEP-ALARM 3 TIMES."
               TO DV-HINT-1(1)
           MOVE "Blueprint:  PERFORM __________ _ TIMES."
               TO DV-HINT-2(1)
           MOVE "PERFORM PRINT-LINE 5 TIMES."
               TO DV-SOLUTION(1)
           MOVE "PERFORM calls a named paragraph recipe."
               TO DV-ANAT-1(1)
           MOVE "PRINT-LINE is the paragraph name to execute."
               TO DV-ANAT-2(1)
           MOVE "5 TIMES. repeats that paragraph 5 times in a row."
               TO DV-ANAT-3(1)
           MOVE "Executed PRINT-LINE 5 times cleanly!"
               TO DV-EFFECT(1)
           MOVE "Y" TO DV-FORBID-EQ(1) DV-NEED-PERIOD(1) DV-CHECK-ORDER(1)
           MOVE "N" TO DV-QUOTE-RULE(1)
           MOVE "PERFORM" TO DV-TOK-1(1)
           MOVE "Start loop and paragraph calls with PERFORM."
               TO DV-ERR-1(1)
           MOVE "PRINT-LINE" TO DV-TOK-2(1)
           MOVE "Specify PRINT-LINE as the paragraph to run."
               TO DV-ERR-2(1)
           MOVE "5" TO DV-TOK-3(1)
           MOVE "Include the count 5!"
               TO DV-ERR-3(1)
           MOVE "TIMES" TO DV-TOK-4(1)
           MOVE "Follow 5 with the word TIMES!"
               TO DV-ERR-4(1)

           MOVE "Run the paragraph named SEND-ALERT 3 times using PERFORM."
               TO DV-TASK-1(2)
           MOVE "(Verb + paragraph name + count + TIMES + period!)"
               TO DV-TASK-2(2)
           MOVE "Similar example:  PERFORM DRAW-STAR 8 TIMES."
               TO DV-HINT-1(2)
           MOVE "Blueprint:  PERFORM __________ _ TIMES."
               TO DV-HINT-2(2)
           MOVE "PERFORM SEND-ALERT 3 TIMES."
               TO DV-SOLUTION(2)
           MOVE "PERFORM launches the paragraph loop."
               TO DV-ANAT-1(2)
           MOVE "SEND-ALERT is the target paragraph."
               TO DV-ANAT-2(2)
           MOVE "3 TIMES. repeats it 3 times."
               TO DV-ANAT-3(2)
           MOVE "Executed SEND-ALERT 3 times!"
               TO DV-EFFECT(2)
           MOVE "Y" TO DV-FORBID-EQ(2) DV-NEED-PERIOD(2) DV-CHECK-ORDER(2)
           MOVE "N" TO DV-QUOTE-RULE(2)
           MOVE "PERFORM" TO DV-TOK-1(2)
           MOVE "Begin with PERFORM."
               TO DV-ERR-1(2)
           MOVE "SEND-ALERT" TO DV-TOK-2(2)
           MOVE "Target the paragraph SEND-ALERT."
               TO DV-ERR-2(2)
           MOVE "3" TO DV-TOK-3(2)
           MOVE "Include the number 3."
               TO DV-ERR-3(2)
           MOVE "TIMES" TO DV-TOK-4(2)
           MOVE "Add the keyword TIMES after 3!"
               TO DV-ERR-4(2)

           MOVE "Run the paragraph named CHECK-SENSOR 10 times using PERFORM."
               TO DV-TASK-1(3)
           MOVE "(End with a period!)"
               TO DV-TASK-2(3)
           MOVE "Similar example:  PERFORM ROLL-DICE 6 TIMES."
               TO DV-HINT-1(3)
           MOVE "Blueprint:  PERFORM ____________ __ TIMES."
               TO DV-HINT-2(3)
           MOVE "PERFORM CHECK-SENSOR 10 TIMES."
               TO DV-SOLUTION(3)
           MOVE "PERFORM invokes the paragraph."
               TO DV-ANAT-1(3)
           MOVE "CHECK-SENSOR is the paragraph name."
               TO DV-ANAT-2(3)
           MOVE "10 TIMES. repeats it 10 times."
               TO DV-ANAT-3(3)
           MOVE "Executed CHECK-SENSOR 10 times!"
               TO DV-EFFECT(3)
           MOVE "Y" TO DV-FORBID-EQ(3) DV-NEED-PERIOD(3) DV-CHECK-ORDER(3)
           MOVE "N" TO DV-QUOTE-RULE(3)
           MOVE "PERFORM" TO DV-TOK-1(3)
           MOVE "Begin with PERFORM."
               TO DV-ERR-1(3)
           MOVE "CHECK-SENSOR" TO DV-TOK-2(3)
           MOVE "Specify paragraph CHECK-SENSOR."
               TO DV-ERR-2(3)
           MOVE "10" TO DV-TOK-3(3)
           MOVE "Include 10."
               TO DV-ERR-3(3)
           MOVE "TIMES" TO DV-TOK-4(3)
           MOVE "Include TIMES after 10!"
               TO DV-ERR-4(3)

           PERFORM 8000-RUN-ADAPTIVE-DRILL
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- DRILL 7B: PERFORM UNTIL ---
           INITIALIZE WS-DRILL-BANK
           MOVE "CONDITIONAL LOOPS (PERFORM UNTIL)" TO DRL-HEADER

           MOVE "Use PERFORM to repeat paragraph READ-NEXT until condition"
               TO DV-TASK-1(1)
           MOVE "FILE-DONE becomes true (end with a period!)."
               TO DV-TASK-2(1)
           MOVE "Similar example:  PERFORM POUR-WATER UNTIL CUP-FULL."
               TO DV-HINT-1(1)
           MOVE "Blueprint:  PERFORM _________ UNTIL _________."
               TO DV-HINT-2(1)
           MOVE "PERFORM READ-NEXT UNTIL FILE-DONE."
               TO DV-SOLUTION(1)
           MOVE "PERFORM READ-NEXT names the paragraph to repeat."
               TO DV-ANAT-1(1)
           MOVE "UNTIL tells COBOL when to stop repeating."
               TO DV-ANAT-2(1)
           MOVE "FILE-DONE. is the level-88 stop condition, ending with '.'."
               TO DV-ANAT-3(1)
           MOVE "Loop runs READ-NEXT repeatedly until FILE-DONE turns true!"
               TO DV-EFFECT(1)
           MOVE "Y" TO DV-FORBID-EQ(1) DV-NEED-PERIOD(1) DV-CHECK-ORDER(1)
           MOVE "N" TO DV-QUOTE-RULE(1)
           MOVE "PERFORM" TO DV-TOK-1(1)
           MOVE "Start with the verb PERFORM."
               TO DV-ERR-1(1)
           MOVE "READ-NEXT" TO DV-TOK-2(1)
           MOVE "Specify paragraph READ-NEXT after PERFORM."
               TO DV-ERR-2(1)
           MOVE "UNTIL" TO DV-TOK-3(1)
           MOVE "Add the keyword UNTIL before your stop condition!"
               TO DV-ERR-3(1)
           MOVE "FILE-DONE" TO DV-TOK-4(1)
           MOVE "End with the condition name FILE-DONE."
               TO DV-ERR-4(1)

           MOVE "Use PERFORM to repeat paragraph PROCESS-ORDER until condition"
               TO DV-TASK-1(2)
           MOVE "QUEUE-EMPTY becomes true (end with a period!)."
               TO DV-TASK-2(2)
           MOVE "Similar example:  PERFORM NEXT-TURN UNTIL GAME-OVER."
               TO DV-HINT-1(2)
           MOVE "Blueprint:  PERFORM _____________ UNTIL ___________."
               TO DV-HINT-2(2)
           MOVE "PERFORM PROCESS-ORDER UNTIL QUEUE-EMPTY."
               TO DV-SOLUTION(2)
           MOVE "PERFORM PROCESS-ORDER runs that paragraph on each pass."
               TO DV-ANAT-1(2)
           MOVE "UNTIL checks the stop condition before each pass."
               TO DV-ANAT-2(2)
           MOVE "QUEUE-EMPTY. stops the loop cleanly once empty."
               TO DV-ANAT-3(2)
           MOVE "Order queue processed until QUEUE-EMPTY!"
               TO DV-EFFECT(2)
           MOVE "Y" TO DV-FORBID-EQ(2) DV-NEED-PERIOD(2) DV-CHECK-ORDER(2)
           MOVE "N" TO DV-QUOTE-RULE(2)
           MOVE "PERFORM" TO DV-TOK-1(2)
           MOVE "Start with PERFORM."
               TO DV-ERR-1(2)
           MOVE "PROCESS-ORDER" TO DV-TOK-2(2)
           MOVE "Name paragraph PROCESS-ORDER."
               TO DV-ERR-2(2)
           MOVE "UNTIL" TO DV-TOK-3(2)
           MOVE "Include the word UNTIL."
               TO DV-ERR-3(2)
           MOVE "QUEUE-EMPTY" TO DV-TOK-4(2)
           MOVE "Specify stop condition QUEUE-EMPTY."
               TO DV-ERR-4(2)

           MOVE "Use PERFORM to repeat paragraph MIX-BATTER until condition"
               TO DV-TASK-1(3)
           MOVE "SMOOTH-ENOUGH becomes true (end with a period!)."
               TO DV-TASK-2(3)
           MOVE "Similar example:  PERFORM HEAT-SOUP UNTIL BOILING."
               TO DV-HINT-1(3)
           MOVE "Blueprint:  PERFORM __________ UNTIL _____________."
               TO DV-HINT-2(3)
           MOVE "PERFORM MIX-BATTER UNTIL SMOOTH-ENOUGH."
               TO DV-SOLUTION(3)
           MOVE "PERFORM MIX-BATTER calls the paragraph."
               TO DV-ANAT-1(3)
           MOVE "UNTIL introduces the stopping rule."
               TO DV-ANAT-2(3)
           MOVE "SMOOTH-ENOUGH. halts the loop once true."
               TO DV-ANAT-3(3)
           MOVE "Loop repeated MIX-BATTER until SMOOTH-ENOUGH!"
               TO DV-EFFECT(3)
           MOVE "Y" TO DV-FORBID-EQ(3) DV-NEED-PERIOD(3) DV-CHECK-ORDER(3)
           MOVE "N" TO DV-QUOTE-RULE(3)
           MOVE "PERFORM" TO DV-TOK-1(3)
           MOVE "Begin with PERFORM."
               TO DV-ERR-1(3)
           MOVE "MIX-BATTER" TO DV-TOK-2(3)
           MOVE "Specify paragraph MIX-BATTER."
               TO DV-ERR-2(3)
           MOVE "UNTIL" TO DV-TOK-3(3)
           MOVE "Include UNTIL."
               TO DV-ERR-3(3)
           MOVE "SMOOTH-ENOUGH" TO DV-TOK-4(3)
           MOVE "Specify condition SMOOTH-ENOUGH."
               TO DV-ERR-4(3)

           PERFORM 8000-RUN-ADAPTIVE-DRILL
           MOVE 7 TO WS-MISSION-NUM
           PERFORM 1900-COMPLETE-MISSION.

*> ===================================================================
*> CHAPTER 8: RECORDS, LISTS (OCCURS), FILES & FINAL MASTERY EXAM!
*> ===================================================================
       2800-CHAPTER-8.
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== CHAPTER 8 (Page 1/3): FOLDERS (RECORDS) & LISTS (OCCURS) ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  Real businesses track structured info -- like an Employee Card"
           DISPLAY "  that bundles ID, Name, and 12 Monthly Paychecks together!"
           DISPLAY " "
           DISPLAY "  1. " FUNCTION TRIM(C-YLW) "GROUP RECORDS (01 -> 05)"
               FUNCTION TRIM(C-RST) ": A '01' folder with NO PIC holds"
           DISPLAY "     smaller '05' sub-boxes indented underneath it!"
           DISPLAY "  2. " FUNCTION TRIM(C-YLW) "NUMBERED LISTS / TABLES (OCCURS)"
               FUNCTION TRIM(C-RST) ": Instead of inventing 12"
           DISPLAY "     boxes (JAN-SALES, FEB-SALES...), add "
               FUNCTION TRIM(C-GRN) "OCCURS 12 TIMES" FUNCTION TRIM(C-RST) ":"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               "      01 EMPLOYEE-CARD."
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "         05 EMP-NAME      PIC X(20)."
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               "         05 MONTH-SALES   PIC 9(6) OCCURS 12 TIMES."
               FUNCTION TRIM(C-RST)
           DISPLAY " "
           DISPLAY "  Now you have 12 numbered lockers! "
               FUNCTION TRIM(C-YLW) "MONTH-SALES(1)" FUNCTION TRIM(C-RST)
               " is Locker #1"
           DISPLAY "  (January), up to " FUNCTION TRIM(C-YLW) "MONTH-SALES(12)"
               FUNCTION TRIM(C-RST) " (December) -- COBOL lists always"
           DISPLAY "  start counting at 1!"
           PERFORM 9000-PRESS-ENTER
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== CHAPTER 8 (Page 2/3): SAVING & READING DISK FILES ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  Storage boxes in WORKING-STORAGE disappear when the program"
           DISPLAY "  closes! To read or save permanent files on your hard drive"
           DISPLAY "  (like payroll data or your savegame.dat!), COBOL uses 4 verbs"
           DISPLAY "  just like reading a physical notebook:"
           DISPLAY " "
           DISPLAY "  1. " FUNCTION TRIM(C-GRN) "OPEN INPUT PAYROLL-FILE."
               FUNCTION TRIM(C-RST)
               "   <- Open an existing file to READ"
           DISPLAY "     (or " FUNCTION TRIM(C-GRN) "OPEN OUTPUT REPORT-FILE."
               FUNCTION TRIM(C-RST) " to create/write a new file!)"
           DISPLAY "  2. " FUNCTION TRIM(C-GRN) "READ PAYROLL-FILE"
               FUNCTION TRIM(C-RST)
               "          <- Read the next line into memory;"
           DISPLAY FUNCTION TRIM(C-GRN)
               "         AT END SET EOF-DONE TO TRUE"
               FUNCTION TRIM(C-RST)
               "  <- flips flag at end-of-file!"
           DISPLAY FUNCTION TRIM(C-GRN)
               "     END-READ."
               FUNCTION TRIM(C-RST)
           DISPLAY "  3. " FUNCTION TRIM(C-GRN) "WRITE REPORT-LINE."
               FUNCTION TRIM(C-RST)
               "         <- Write a record out to disk"
           DISPLAY "  4. " FUNCTION TRIM(C-GRN) "CLOSE PAYROLL-FILE."
               FUNCTION TRIM(C-RST)
               "        <- Save & unlock the file cleanly!"
           PERFORM 9000-PRESS-ENTER
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- QUIZ 8 ---
           INITIALIZE WS-QUIZ-BANK
           MOVE "LISTS (OCCURS) & FILES" TO WS-Q-TITLE

           MOVE "If you create a 7-day list:  05 DAY-TEMP PIC S9(3) OCCURS 7 TIMES."
               TO QZ-Q1(1)
           MOVE "How do you refer to the VERY FIRST day's box in COBOL?"
               TO QZ-Q2(1)
           MOVE "DAY-TEMP(0)"
               TO QZ-OPT-A(1)
           MOVE "DAY-TEMP(1)"
               TO QZ-OPT-B(1)
           MOVE "FIRST-DAY-TEMP"
               TO QZ-OPT-C(1)
           MOVE "B" TO QZ-ANS(1)
           MOVE "Yes! COBOL OCCURS lists use parentheses and start at (1)!"
               TO QZ-OK-MSG(1)
           MOVE "Unlike some languages that start counting at zero, COBOL counts"
               TO QZ-WHY-1(1)
           MOVE "the natural human way starting at 1: DAY-TEMP(1) is Day 1,"
               TO QZ-WHY-2(1)
           MOVE "all the way up to DAY-TEMP(7) for Day 7!"
               TO QZ-WHY-3(1)

           MOVE "When reading through a file one record at a time with READ,"
               TO QZ-Q1(2)
           MOVE "which clause detects that you've reached the end of the file?"
               TO QZ-Q2(2)
           MOVE "AT END"
               TO QZ-OPT-A(2)
           MOVE "WHEN FINISHED"
               TO QZ-OPT-B(2)
           MOVE "STOP FILE"
               TO QZ-OPT-C(2)
           MOVE "A" TO QZ-ANS(2)
           MOVE "AT END triggers cleanly as soon as there are no more records!"
               TO QZ-OK-MSG(2)
           MOVE "Inside READ <file-name> ... END-READ, the AT END clause runs"
               TO QZ-WHY-1(2)
           MOVE "when the last line has already been read, letting you set your"
               TO QZ-WHY-2(2)
           MOVE "loop's stop flag (like SET EOF-DONE TO TRUE) cleanly!"
               TO QZ-WHY-3(2)

           PERFORM 7800-RUN-ADAPTIVE-QUIZ
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- DRILL 8A: OCCURS TABLE ---
           INITIALIZE WS-DRILL-BANK
           MOVE "CREATING A NUMBERED LIST (OCCURS)" TO DRL-HEADER

           MOVE "Declare a sub-box (level 05) named MONTH-SALES with PIC 9(6)"
               TO DV-TASK-1(1)
           MOVE "that repeats 12 times! (End with a period.)"
               TO DV-TASK-2(1)
           MOVE "Similar example (4 quarters):  05 QTR-REV PIC 9(7) OCCURS 4 TIMES."
               TO DV-HINT-1(1)
           MOVE "Blueprint:  05 ___________ PIC 9(6) OCCURS 12 TIMES."
               TO DV-HINT-2(1)
           MOVE "05 MONTH-SALES PIC 9(6) OCCURS 12 TIMES."
               TO DV-SOLUTION(1)
           MOVE "05 MONTH-SALES declares a sub-item inside a 01 record."
               TO DV-ANAT-1(1)
           MOVE "PIC 9(6) gives each locker 6 numeric digits."
               TO DV-ANAT-2(1)
           MOVE "OCCURS 12 TIMES. creates lockers (1) through (12)!"
               TO DV-ANAT-3(1)
           MOVE "Created 12-slot table MONTH-SALES(1) .. MONTH-SALES(12)!"
               TO DV-EFFECT(1)
           MOVE "Y" TO DV-FORBID-EQ(1) DV-NEED-PERIOD(1) DV-CHECK-ORDER(1)
           MOVE "N" TO DV-QUOTE-RULE(1)
           MOVE "05" TO DV-TOK-1(1)
           MOVE "Start with sub-level number 05."
               TO DV-ERR-1(1)
           MOVE "MONTH-SALES" TO DV-TOK-2(1)
           MOVE "Name the table MONTH-SALES."
               TO DV-ERR-2(1)
           MOVE "9(6)" TO DV-TOK-3(1)
           MOVE "999999" TO DV-TOK-3-ALT(1)
           MOVE "Include PIC 9(6) before OCCURS!"
               TO DV-ERR-3(1)
           MOVE "OCCURS 12" TO DV-TOK-4(1)
           MOVE "Add OCCURS 12 TIMES at the end!"
               TO DV-ERR-4(1)

           MOVE "Declare a sub-box (level 05) named DAILY-STEPS with PIC 9(5)"
               TO DV-TASK-1(2)
           MOVE "that repeats 7 times! (End with a period.)"
               TO DV-TASK-2(2)
           MOVE "Similar example:  05 EXAM-SCORE PIC 9(3) OCCURS 5 TIMES."
               TO DV-HINT-1(2)
           MOVE "Blueprint:  05 ___________ PIC 9(5) OCCURS 7 TIMES."
               TO DV-HINT-2(2)
           MOVE "05 DAILY-STEPS PIC 9(5) OCCURS 7 TIMES."
               TO DV-SOLUTION(2)
           MOVE "05 DAILY-STEPS names our repeating sub-field."
               TO DV-ANAT-1(2)
           MOVE "PIC 9(5) gives each day's slot 5 digits."
               TO DV-ANAT-2(2)
           MOVE "OCCURS 7 TIMES. creates DAILY-STEPS(1) through (7)."
               TO DV-ANAT-3(2)
           MOVE "Created 7-day table DAILY-STEPS(1) .. DAILY-STEPS(7)!"
               TO DV-EFFECT(2)
           MOVE "Y" TO DV-FORBID-EQ(2) DV-NEED-PERIOD(2) DV-CHECK-ORDER(2)
           MOVE "N" TO DV-QUOTE-RULE(2)
           MOVE "05" TO DV-TOK-1(2)
           MOVE "Begin with level number 05."
               TO DV-ERR-1(2)
           MOVE "DAILY-STEPS" TO DV-TOK-2(2)
           MOVE "Name the table DAILY-STEPS."
               TO DV-ERR-2(2)
           MOVE "9(5)" TO DV-TOK-3(2)
           MOVE "99999" TO DV-TOK-3-ALT(2)
           MOVE "Specify PIC 9(5)."
               TO DV-ERR-3(2)
           MOVE "OCCURS 7" TO DV-TOK-4(2)
           MOVE "Add OCCURS 7 TIMES!"
               TO DV-ERR-4(2)

           MOVE "Declare a sub-box (level 05) named SEAT-CODE with PIC X(4)"
               TO DV-TASK-1(3)
           MOVE "that repeats 20 times! (End with a period.)"
               TO DV-TASK-2(3)
           MOVE "Similar example:  05 ROOM-TAG PIC X(3) OCCURS 10 TIMES."
               TO DV-HINT-1(3)
           MOVE "Blueprint:  05 _________ PIC X(4) OCCURS 20 TIMES."
               TO DV-HINT-2(3)
           MOVE "05 SEAT-CODE PIC X(4) OCCURS 20 TIMES."
               TO DV-SOLUTION(3)
           MOVE "05 SEAT-CODE defines a sub-item."
               TO DV-ANAT-1(3)
           MOVE "PIC X(4) gives each seat 4 text characters."
               TO DV-ANAT-2(3)
           MOVE "OCCURS 20 TIMES. builds 20 numbered slots."
               TO DV-ANAT-3(3)
           MOVE "Created 20-seat table SEAT-CODE(1) .. SEAT-CODE(20)!"
               TO DV-EFFECT(3)
           MOVE "Y" TO DV-FORBID-EQ(3) DV-NEED-PERIOD(3) DV-CHECK-ORDER(3)
           MOVE "N" TO DV-QUOTE-RULE(3)
           MOVE "05" TO DV-TOK-1(3)
           MOVE "Begin with level 05."
               TO DV-ERR-1(3)
           MOVE "SEAT-CODE" TO DV-TOK-2(3)
           MOVE "Name the table SEAT-CODE."
               TO DV-ERR-2(3)
           MOVE "X(4)" TO DV-TOK-3(3)
           MOVE "XXXX" TO DV-TOK-3-ALT(3)
           MOVE "Use PIC X(4)."
               TO DV-ERR-3(3)
           MOVE "OCCURS 20" TO DV-TOK-4(3)
           MOVE "Add OCCURS 20 TIMES!"
               TO DV-ERR-4(3)

           PERFORM 8000-RUN-ADAPTIVE-DRILL
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- FINAL BOSS MASTERY EXAM! ---
           PERFORM 2850-FINAL-MASTERY-EXAM.

*> ===================================================================
*> 2850-FINAL-MASTERY-EXAM: Midnight Payroll Batch Rescue!
*> ===================================================================
       2850-FINAL-MASTERY-EXAM.
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-RED)
               "+====================================================================+"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-RED)
               "|   FINAL MASTERY EXAM: RESCUE THE MIDNIGHT PAYROLL BATCH JOB!       |"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-RED)
               "+====================================================================+"
               FUNCTION TRIM(C-RST)
           DISPLAY "  It's 11:58 PM! 50,000 workers are waiting for direct deposit, and"
           DISPLAY "  glitched daemon ABEND-S0C7 scrambled two lines of the batch job!"
           DISPLAY "  Use everything you learned from Zero to Master to save the night:"

           *> Stage 1: Open the Input File (3 variants!)
           INITIALIZE WS-DRILL-BANK
           MOVE "BOSS STAGE 1/2: OPEN FILE FOR READING" TO DRL-HEADER

           MOVE "Open PAYROLL-FILE so the program can READ records from it!"
               TO DV-TASK-1(1)
           MOVE "(Use OPEN + the mode word for reading + PAYROLL-FILE + period.)"
               TO DV-TASK-2(1)
           MOVE "Similar example (opening ORDERS-FILE to read):  OPEN INPUT ORDERS-FILE."
               TO DV-HINT-1(1)
           MOVE "Blueprint:  OPEN INPUT ____________."
               TO DV-HINT-2(1)
           MOVE "OPEN INPUT PAYROLL-FILE."
               TO DV-SOLUTION(1)
           MOVE "OPEN unlocks a disk file for use."
               TO DV-ANAT-1(1)
           MOVE "INPUT means read-only mode (OUTPUT would erase & overwrite it!)."
               TO DV-ANAT-2(1)
           MOVE "PAYROLL-FILE. is the file handle, ending with '.'."
               TO DV-ANAT-3(1)
           MOVE "Tape mounted! Reading 50,000 employee records..."
               TO DV-EFFECT(1)
           MOVE "Y" TO DV-FORBID-EQ(1) DV-NEED-PERIOD(1) DV-CHECK-ORDER(1)
           MOVE "N" TO DV-QUOTE-RULE(1)
           MOVE "OPEN" TO DV-TOK-1(1)
           MOVE "Start with the verb OPEN."
               TO DV-ERR-1(1)
           MOVE "INPUT" TO DV-TOK-2(1)
           MOVE "Follow OPEN with INPUT (meaning read mode!)."
               TO DV-ERR-2(1)
           MOVE "PAYROLL-FILE" TO DV-TOK-3(1)
           MOVE "Specify PAYROLL-FILE as the file to open."
               TO DV-ERR-3(1)

           MOVE "Open HOURS-FILE so the program can READ records from it!"
               TO DV-TASK-1(2)
           MOVE "(OPEN + read mode keyword + HOURS-FILE + period.)"
               TO DV-TASK-2(2)
           MOVE "Similar example:  OPEN INPUT LEDGER-FILE."
               TO DV-HINT-1(2)
           MOVE "Blueprint:  OPEN INPUT __________."
               TO DV-HINT-2(2)
           MOVE "OPEN INPUT HOURS-FILE."
               TO DV-SOLUTION(2)
           MOVE "OPEN prepares the file connection."
               TO DV-ANAT-1(2)
           MOVE "INPUT opens it safely for reading."
               TO DV-ANAT-2(2)
           MOVE "HOURS-FILE. names the file."
               TO DV-ANAT-3(2)
           MOVE "HOURS-FILE mounted for reading!"
               TO DV-EFFECT(2)
           MOVE "Y" TO DV-FORBID-EQ(2) DV-NEED-PERIOD(2) DV-CHECK-ORDER(2)
           MOVE "N" TO DV-QUOTE-RULE(2)
           MOVE "OPEN" TO DV-TOK-1(2)
           MOVE "Begin with OPEN."
               TO DV-ERR-1(2)
           MOVE "INPUT" TO DV-TOK-2(2)
           MOVE "Use INPUT after OPEN to read an existing file."
               TO DV-ERR-2(2)
           MOVE "HOURS-FILE" TO DV-TOK-3(2)
           MOVE "Specify HOURS-FILE."
               TO DV-ERR-3(2)

           MOVE "Open REPORT-FILE in OUTPUT mode so we can write a new report!"
               TO DV-TASK-1(3)
           MOVE "(Use OPEN + OUTPUT + REPORT-FILE + period.)"
               TO DV-TASK-2(3)
           MOVE "Similar example:  OPEN OUTPUT RECEIPT-FILE."
               TO DV-HINT-1(3)
           MOVE "Blueprint:  OPEN OUTPUT ___________."
               TO DV-HINT-2(3)
           MOVE "OPEN OUTPUT REPORT-FILE."
               TO DV-SOLUTION(3)
           MOVE "OPEN starts file access."
               TO DV-ANAT-1(3)
           MOVE "OUTPUT creates/opens a file for writing."
               TO DV-ANAT-2(3)
           MOVE "REPORT-FILE. names the output file."
               TO DV-ANAT-3(3)
           MOVE "REPORT-FILE opened for writing!"
               TO DV-EFFECT(3)
           MOVE "Y" TO DV-FORBID-EQ(3) DV-NEED-PERIOD(3) DV-CHECK-ORDER(3)
           MOVE "N" TO DV-QUOTE-RULE(3)
           MOVE "OPEN" TO DV-TOK-1(3)
           MOVE "Begin with OPEN."
               TO DV-ERR-1(3)
           MOVE "OUTPUT" TO DV-TOK-2(3)
           MOVE "Use OUTPUT after OPEN to write a new file."
               TO DV-ERR-2(3)
           MOVE "REPORT-FILE" TO DV-TOK-3(3)
           MOVE "Specify REPORT-FILE."
               TO DV-ERR-3(3)

           PERFORM 8000-RUN-ADAPTIVE-DRILL
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> Stage 2: Close & Seal the Batch File (3 variants!)
           INITIALIZE WS-DRILL-BANK
           MOVE "BOSS STAGE 2/2: SEAL & CLOSE THE FILE" TO DRL-HEADER

           MOVE "All 50,000 paychecks are calculated! Write the COBOL line to"
               TO DV-TASK-1(1)
           MOVE "properly close PAYROLL-FILE (notice CLOSE needs NO INPUT/OUTPUT!)."
               TO DV-TASK-2(1)
           MOVE "Similar example:  CLOSE ORDERS-FILE."
               TO DV-HINT-1(1)
           MOVE "Blueprint:  CLOSE ____________."
               TO DV-HINT-2(1)
           MOVE "CLOSE PAYROLL-FILE."
               TO DV-SOLUTION(1)
           MOVE "CLOSE saves buffers and releases the operating system lock."
               TO DV-ANAT-1(1)
           MOVE "Unlike OPEN, CLOSE never takes INPUT or OUTPUT -- just the name!"
               TO DV-ANAT-2(1)
           MOVE "PAYROLL-FILE. finishes with a period."
               TO DV-ANAT-3(1)
           MOVE "PAYROLL-FILE sealed! 50,000 paychecks transmitted on time!"
               TO DV-EFFECT(1)
           MOVE "Y" TO DV-FORBID-EQ(1) DV-NEED-PERIOD(1) DV-CHECK-ORDER(1)
           MOVE "N" TO DV-QUOTE-RULE(1)
           MOVE "CLOSE" TO DV-TOK-1(1)
           MOVE "Start with the verb CLOSE."
               TO DV-ERR-1(1)
           MOVE "PAYROLL-FILE" TO DV-TOK-2(1)
           MOVE "Follow CLOSE with PAYROLL-FILE."
               TO DV-ERR-2(1)

           MOVE "Close HOURS-FILE cleanly now that batch reading is complete!"
               TO DV-TASK-1(2)
           MOVE "(Just CLOSE + file name + period!)"
               TO DV-TASK-2(2)
           MOVE "Similar example:  CLOSE LEDGER-FILE."
               TO DV-HINT-1(2)
           MOVE "Blueprint:  CLOSE __________."
               TO DV-HINT-2(2)
           MOVE "CLOSE HOURS-FILE."
               TO DV-SOLUTION(2)
           MOVE "CLOSE releases the open file handle."
               TO DV-ANAT-1(2)
           MOVE "HOURS-FILE names the file being closed."
               TO DV-ANAT-2(2)
           MOVE "The period (.) ends the statement."
               TO DV-ANAT-3(2)
           MOVE "HOURS-FILE closed cleanly!"
               TO DV-EFFECT(2)
           MOVE "Y" TO DV-FORBID-EQ(2) DV-NEED-PERIOD(2) DV-CHECK-ORDER(2)
           MOVE "N" TO DV-QUOTE-RULE(2)
           MOVE "CLOSE" TO DV-TOK-1(2)
           MOVE "Begin with CLOSE."
               TO DV-ERR-1(2)
           MOVE "HOURS-FILE" TO DV-TOK-2(2)
           MOVE "Specify HOURS-FILE."
               TO DV-ERR-2(2)

           MOVE "Close REPORT-FILE so every written line is saved to disk!"
               TO DV-TASK-1(3)
           MOVE "(CLOSE + REPORT-FILE + period!)"
               TO DV-TASK-2(3)
           MOVE "Similar example:  CLOSE RECEIPT-FILE."
               TO DV-HINT-1(3)
           MOVE "Blueprint:  CLOSE ___________."
               TO DV-HINT-2(3)
           MOVE "CLOSE REPORT-FILE."
               TO DV-SOLUTION(3)
           MOVE "CLOSE flushes and saves the output file."
               TO DV-ANAT-1(3)
           MOVE "REPORT-FILE is the file handle."
               TO DV-ANAT-2(3)
           MOVE "Period (.) completes the sentence."
               TO DV-ANAT-3(3)
           MOVE "REPORT-FILE saved and closed!"
               TO DV-EFFECT(3)
           MOVE "Y" TO DV-FORBID-EQ(3) DV-NEED-PERIOD(3) DV-CHECK-ORDER(3)
           MOVE "N" TO DV-QUOTE-RULE(3)
           MOVE "CLOSE" TO DV-TOK-1(3)
           MOVE "Begin with CLOSE."
               TO DV-ERR-1(3)
           MOVE "REPORT-FILE" TO DV-TOK-2(3)
           MOVE "Specify REPORT-FILE."
               TO DV-ERR-2(3)

           PERFORM 8000-RUN-ADAPTIVE-DRILL

           IF NOT SHUTDOWN-NOW
               DISPLAY " "
               DISPLAY FUNCTION TRIM(C-GRN)
                   "  *** ABEND-S0C7 DEFEATED! MIDNIGHT PAYROLL COMPLETED AT 11:59 PM! ***"
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
               "  |         ZERO-TO-MASTER OFFICIAL COBOL CERTIFICATION          |"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-YLW)
               "  +--------------------------------------------------------------+"
               FUNCTION TRIM(C-RST)
           DISPLAY "  |  This certifies that Engineer: "
               FUNCTION TRIM(C-CYN) WS-PLAYER-NAME FUNCTION TRIM(C-RST)
               "          |"
           DISPLAY "  |  started from the ground up and mastered all 8 Chapters of   |"
           DISPLAY "  |  COBOL: Statements, Divisions, Variables & PIC, MOVE/ACCEPT, |"
           DISPLAY "  |  Decimal Math & ROUNDED, IF/88 Logic, PERFORM & File I/O!    |"
           DISPLAY "  |                                                              |"
           DISPLAY "  |  Final Rank : " FUNCTION TRIM(C-GRN) WS-RANK-TITLE
               FUNCTION TRIM(C-RST) "                     |"
           DISPLAY FUNCTION TRIM(C-YLW)
               "  +==============================================================+"
               FUNCTION TRIM(C-RST)
           PERFORM 9000-PRESS-ENTER.
