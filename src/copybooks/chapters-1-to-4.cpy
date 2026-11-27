*> ===================================================================
*> COPYBOOK: chapters-1-to-4.cpy
*> PURPOSE : Zero-to-Master Curriculum Chapters 1 through 4!
*>           Designed for someone with ZERO prior coding experience.
*> ===================================================================

       1000-MISSION-SELECT-MENU.
           MOVE SPACES TO WS-UPPER-CHOICE
           PERFORM UNTIL WS-UPPER-CHOICE = "B" OR SHUTDOWN-NOW
               PERFORM 0400-RECALC-RANK-AND-BAR
               PERFORM 0150-CLEAR-SCREEN
               DISPLAY FUNCTION TRIM(C-GRN)
                   "+============= ZERO-TO-MASTER COBOL CURRICULUM (1-8) ==============+"
                   FUNCTION TRIM(C-RST)
               DISPLAY "  New to coding? Start at [1] -- zero prior experience needed!"
               DISPLAY FUNCTION TRIM(C-GRN)
                   "+------------------------------------------------------------------+"
                   FUNCTION TRIM(C-RST)
               PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 8
                   MOVE WS-IDX TO WS-IDX-DISP
                   IF WS-MISSION-DONE(WS-IDX) = "Y"
                       DISPLAY "  " FUNCTION TRIM(C-YLW) "[" WS-IDX-DISP "]"
                           FUNCTION TRIM(C-RST) " " WS-SUBSYSTEM-LABEL(WS-IDX)
                           " " FUNCTION TRIM(C-GRN) "[MASTERED]"
                           FUNCTION TRIM(C-RST)
                   ELSE
                       DISPLAY "  " FUNCTION TRIM(C-YLW) "[" WS-IDX-DISP "]"
                           FUNCTION TRIM(C-RST) " " WS-SUBSYSTEM-LABEL(WS-IDX)
                           " " FUNCTION TRIM(C-DIM) "[  TODO  ]"
                           FUNCTION TRIM(C-RST)
                   END-IF
               END-PERFORM
               DISPLAY FUNCTION TRIM(C-GRN)
                   "+------------------------------------------------------------------+"
                   FUNCTION TRIM(C-RST)
               DISPLAY "  " FUNCTION TRIM(C-YLW) "[B]" FUNCTION TRIM(C-RST)
                   " Back to Main Console"
               DISPLAY " "
               DISPLAY FUNCTION TRIM(C-CYN) "  CHAPTER (1-8 or B)> "
                   FUNCTION TRIM(C-RST) WITH NO ADVANCING
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
                   WHEN "1" PERFORM 2100-CHAPTER-1
                   WHEN "2" PERFORM 2200-CHAPTER-2
                   WHEN "3" PERFORM 2300-CHAPTER-3
                   WHEN "4" PERFORM 2400-CHAPTER-4
                   WHEN "5" PERFORM 2500-CHAPTER-5
                   WHEN "6" PERFORM 2600-CHAPTER-6
                   WHEN "7" PERFORM 2700-CHAPTER-7
                   WHEN "8" PERFORM 2800-CHAPTER-8
                   WHEN "B"
                   WHEN "0"
                   WHEN "Q"
                       MOVE "B" TO WS-UPPER-CHOICE
                   WHEN SPACES
                       CONTINUE
                   WHEN OTHER
                       DISPLAY FUNCTION TRIM(C-RED)
                           "  Type a chapter number 1-8, or B to go back."
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
               MOVE 120 TO WS-XP-GAIN
               DISPLAY FUNCTION TRIM(C-GRN)
                   "  +============================================================+"
                   FUNCTION TRIM(C-RST)
               DISPLAY FUNCTION TRIM(C-GRN)
                   "  |  CHAPTER MASTERED! IRON-7090 SUBSYSTEM BROUGHT ONLINE!     |"
                   FUNCTION TRIM(C-RST)
               DISPLAY FUNCTION TRIM(C-GRN)
                   "  +============================================================+"
                   FUNCTION TRIM(C-RST)
               PERFORM 0450-AWARD-XP
           ELSE
               MOVE 25 TO WS-XP-GAIN
               DISPLAY FUNCTION TRIM(C-CYN)
                   "  [PRACTICE COMPLETE] Extra mastery reps logged!"
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
*> CHAPTER 1: WHAT IS CODE? SAYING HELLO & YOUR FIRST PROGRAM
*> ===================================================================
       2100-CHAPTER-1.
           *> --- LESSON PAGE 1 OF 3 ---
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== CHAPTER 1 (Page 1/3): WHAT IS A COMPUTER PROGRAM? ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  Welcome! Even if you have NEVER written a line of code in your"
           DISPLAY "  life, you already know how to think like a programmer."
           DISPLAY " "
           DISPLAY "  A " FUNCTION TRIM(C-YLW) "program" FUNCTION TRIM(C-RST)
               " is simply a recipe: a list of clear, step-by-step"
           DISPLAY "  instructions that the computer reads from TOP to BOTTOM."
           DISPLAY "  Computers are super fast, but they have zero imagination -- they"
           DISPLAY "  do ONLY what your instructions explicitly say!"
           DISPLAY " "
           DISPLAY "  In 1959, pioneer Rear Admiral Grace Hopper helped inspire "
               FUNCTION TRIM(C-GRN) "COBOL" FUNCTION TRIM(C-RST)
           DISPLAY "  (COmmon Business-Oriented Language) with a bold goal: code should"
           DISPLAY "  read like plain English sentences! Look at a real COBOL line:"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               '      DISPLAY "HELLO WORLD".'
               FUNCTION TRIM(C-RST)
           DISPLAY " "
           DISPLAY "  Look at the 3 pieces of that sentence:"
           DISPLAY "    1. " FUNCTION TRIM(C-YLW) "DISPLAY" FUNCTION TRIM(C-RST)
               "       -> An action word (a VERB) meaning 'show on screen'."
           DISPLAY "    2. " FUNCTION TRIM(C-YLW) '"HELLO WORLD"' FUNCTION TRIM(C-RST)
               " -> Quotation marks mean 'print these exact letters'."
           DISPLAY "                    (Programmers call text in quotes a STRING!)"
           DISPLAY "    3. " FUNCTION TRIM(C-YLW) "." FUNCTION TRIM(C-RST)
               "             -> A PERIOD tells COBOL this sentence is finished!"
           PERFORM 9000-PRESS-ENTER
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- QUIZ 1: VERIFY DISPLAY, QUOTES & PERIOD ---
           INITIALIZE WS-QUIZ-BANK
           MOVE "CHAPTER 1 CHECK" TO WS-Q-TITLE

           MOVE 'You want the screen to show: WELCOME ABOARD'
               TO QZ-Q1(1)
           MOVE 'Why do we write DISPLAY "WELCOME ABOARD". with quotes & a period?'
               TO QZ-Q2(1)
           MOVE "Quotes make letters bigger on the monitor"
               TO QZ-OPT-A(1)
           MOVE "Quotes mark exact text to print, and '.' ends the sentence!"
               TO QZ-OPT-B(1)
           MOVE "COBOL ignores both quotes and periods"
               TO QZ-OPT-C(1)
           MOVE "B" TO QZ-ANS(1)
           MOVE "Quotes wrap exact text (a string), and '.' finishes the sentence!"
               TO QZ-OK-MSG(1)
           MOVE 'In COBOL, quotation marks ("...") say: print these exact characters.'
               TO QZ-WHY-1(1)
           MOVE "Without quotes, COBOL thinks WELCOME is the name of a command/box!"
               TO QZ-WHY-2(1)
           MOVE "And just like English, a period (.) marks the end of the instruction."
               TO QZ-WHY-3(1)

           MOVE "What happens if you leave off the period (.) at the end of a"
               TO QZ-Q1(2)
           MOVE 'standalone COBOL sentence like DISPLAY "READY" ?'
               TO QZ-Q2(2)
           MOVE "Nothing -- periods are just decoration"
               TO QZ-OPT-A(2)
           MOVE "It prints READY backwards"
               TO QZ-OPT-B(2)
           MOVE "COBOL doesn't know the sentence ended & runs into the next line!"
               TO QZ-OPT-C(2)
           MOVE "C" TO QZ-ANS(2)
           MOVE "Spot on! The period tells COBOL where your sentence stops."
               TO QZ-OK-MSG(2)
           MOVE "Think of COBOL like reading a paragraph aloud: without a period (.),"
               TO QZ-WHY-1(2)
           MOVE "the compiler thinks the next line is still part of the same sentence!"
               TO QZ-WHY-2(2)
           MOVE "That's why finishing standalone sentences with '.' is Rule #1."
               TO QZ-WHY-3(2)

           PERFORM 7800-RUN-ADAPTIVE-QUIZ
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- DRILL 1A: YOUR VERY FIRST LINE OF CODE (DISPLAY) ---
           INITIALIZE WS-DRILL-BANK
           MOVE "YOUR FIRST COBOL LINE (DISPLAY)" TO DRL-HEADER

           *> Variant 1
           MOVE "Write a COBOL line that prints HELLO MAINFRAME on the screen."
               TO DV-TASK-1(1)
           MOVE "(Start with the verb, wrap the message in quotes, end with a period!)"
               TO DV-TASK-2(1)
           MOVE 'Similar example: to print HI THERE, write:  DISPLAY "HI THERE".'
               TO DV-HINT-1(1)
           MOVE 'Blueprint:  DISPLAY "_______________".'
               TO DV-HINT-2(1)
           MOVE 'DISPLAY "HELLO MAINFRAME".'
               TO DV-SOLUTION(1)
           MOVE "DISPLAY is the verb that prints output onto the terminal screen."
               TO DV-ANAT-1(1)
           MOVE '"HELLO MAINFRAME" is wrapped in quotes so those exact words print.'
               TO DV-ANAT-2(1)
           MOVE "The period (.) at the end tells COBOL the instruction is complete."
               TO DV-ANAT-3(1)
           MOVE "Screen prints -> HELLO MAINFRAME"
               TO DV-EFFECT(1)
           MOVE "Y" TO DV-FORBID-EQ(1) DV-QUOTE-RULE(1) DV-NEED-PERIOD(1)
                       DV-CHECK-ORDER(1)
           MOVE "DISPLAY" TO DV-TOK-1(1)
           MOVE "Start with the action verb DISPLAY (meaning 'show on screen')."
               TO DV-ERR-1(1)
           MOVE "HELLO MAINFRAME" TO DV-TOK-2(1)
           MOVE 'Put the exact phrase HELLO MAINFRAME inside your quotes!'
               TO DV-ERR-2(1)

           *> Variant 2
           MOVE "Write a COBOL line that prints SYSTEM ONLINE on the screen."
               TO DV-TASK-1(2)
           MOVE "(Verb first, exact message inside quotes, period at the end!)"
               TO DV-TASK-2(2)
           MOVE 'Similar example: to print GOOD JOB, write:  DISPLAY "GOOD JOB".'
               TO DV-HINT-1(2)
           MOVE 'Blueprint:  DISPLAY "_____________".'
               TO DV-HINT-2(2)
           MOVE 'DISPLAY "SYSTEM ONLINE".'
               TO DV-SOLUTION(2)
           MOVE "DISPLAY tells the computer to show something on the screen."
               TO DV-ANAT-1(2)
           MOVE '"SYSTEM ONLINE" in quotes is the exact text string to print.'
               TO DV-ANAT-2(2)
           MOVE "The closing period (.) finishes the COBOL sentence."
               TO DV-ANAT-3(2)
           MOVE "Screen prints -> SYSTEM ONLINE"
               TO DV-EFFECT(2)
           MOVE "Y" TO DV-FORBID-EQ(2) DV-QUOTE-RULE(2) DV-NEED-PERIOD(2)
                       DV-CHECK-ORDER(2)
           MOVE "DISPLAY" TO DV-TOK-1(2)
           MOVE "Begin your sentence with the verb DISPLAY."
               TO DV-ERR-1(2)
           MOVE "SYSTEM ONLINE" TO DV-TOK-2(2)
           MOVE 'Include the exact message SYSTEM ONLINE inside your quotes!'
               TO DV-ERR-2(2)

           *> Variant 3
           MOVE "Write a COBOL line that prints READY TO LEARN on the screen."
               TO DV-TASK-1(3)
           MOVE "(Action verb + quoted text + closing period!)"
               TO DV-TASK-2(3)
           MOVE 'Similar example: to print ALL SET, write:  DISPLAY "ALL SET".'
               TO DV-HINT-1(3)
           MOVE 'Blueprint:  DISPLAY "______________".'
               TO DV-HINT-2(3)
           MOVE 'DISPLAY "READY TO LEARN".'
               TO DV-SOLUTION(3)
           MOVE "DISPLAY is COBOL's screen-printing verb."
               TO DV-ANAT-1(3)
           MOVE '"READY TO LEARN" in quotes tells COBOL what text to output.'
               TO DV-ANAT-2(3)
           MOVE "The trailing period (.) marks the end of the statement."
               TO DV-ANAT-3(3)
           MOVE "Screen prints -> READY TO LEARN"
               TO DV-EFFECT(3)
           MOVE "Y" TO DV-FORBID-EQ(3) DV-QUOTE-RULE(3) DV-NEED-PERIOD(3)
                       DV-CHECK-ORDER(3)
           MOVE "DISPLAY" TO DV-TOK-1(3)
           MOVE "Begin with DISPLAY to print text to the screen."
               TO DV-ERR-1(3)
           MOVE "READY TO LEARN" TO DV-TOK-2(3)
           MOVE 'Include the exact words READY TO LEARN inside quotation marks!'
               TO DV-ERR-2(3)

           PERFORM 8000-RUN-ADAPTIVE-DRILL
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- LESSON PAGE 2 OF 3: WRAPPING LINES INTO A REAL PROGRAM ---
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== CHAPTER 1 (Page 2/3): HOW A COMPLETE PROGRAM LOOKS ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  You just wrote real COBOL! Now, how do we turn that single line"
           DISPLAY "  into a complete program file that a computer can run?"
           DISPLAY " "
           DISPLAY "  Every COBOL program needs an "
               FUNCTION TRIM(C-YLW) "ID Badge" FUNCTION TRIM(C-RST)
               " at the top (so the computer"
           DISPLAY "  knows its name) and an "
               FUNCTION TRIM(C-YLW) "Action Section" FUNCTION TRIM(C-RST)
               " where your verbs live:"
           DISPLAY " "
           DISPLAY "  +--------------------------------------------------------------+"
           DISPLAY "  | " FUNCTION TRIM(C-GRN) "IDENTIFICATION DIVISION."
               FUNCTION TRIM(C-RST) "    <- Section 1: The ID Badge area  |"
           DISPLAY "  | " FUNCTION TRIM(C-GRN) "PROGRAM-ID. GREETER."
               FUNCTION TRIM(C-RST) "        <- Names this program GREETER    |"
           DISPLAY "  |                                                              |"
           DISPLAY "  | " FUNCTION TRIM(C-GRN) "PROCEDURE DIVISION."
               FUNCTION TRIM(C-RST) "         <- Section 2: Action steps start |"
           DISPLAY "  | " FUNCTION TRIM(C-GRN) '    DISPLAY "HELLO!".'
               FUNCTION TRIM(C-RST) "       <- Step 1: Print HELLO!          |"
           DISPLAY "  | " FUNCTION TRIM(C-GRN) "    STOP RUN."
               FUNCTION TRIM(C-RST) "               <- Step 2: End the program!      |"
           DISPLAY "  +--------------------------------------------------------------+"
           DISPLAY " "
           DISPLAY "  Look closely at " FUNCTION TRIM(C-YLW) "PROGRAM-ID. GREETER."
               FUNCTION TRIM(C-RST) ":"
           DISPLAY "    * PROGRAM-ID has a " FUNCTION TRIM(C-YLW) "hyphen (-)"
               FUNCTION TRIM(C-RST) " connecting the two words, then a period."
           DISPLAY "    * Program names (like GREETER) do NOT wear quotes, and end"
           DISPLAY "      with a period (.) too!"
           PERFORM 9000-PRESS-ENTER
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- DRILL 1B: PROGRAM-ID ---
           INITIALIZE WS-DRILL-BANK
           MOVE "NAMING A PROGRAM (PROGRAM-ID)" TO DRL-HEADER

           *> Variant 1
           MOVE "Write the PROGRAM-ID line to give this program the name VAULT."
               TO DV-TASK-1(1)
           MOVE "(Remember: hyphen in PROGRAM-ID, no quotes, two periods total!)"
               TO DV-TASK-2(1)
           MOVE "Similar example: to name a program CLOCK, write:  PROGRAM-ID. CLOCK."
               TO DV-HINT-1(1)
           MOVE "Blueprint:  PROGRAM-ID. _____."
               TO DV-HINT-2(1)
           MOVE "PROGRAM-ID. VAULT."
               TO DV-SOLUTION(1)
           MOVE "PROGRAM-ID. (with a hyphen & period!) announces the program's name."
               TO DV-ANAT-1(1)
           MOVE "VAULT is the program's identifier (written bare without quotes)."
               TO DV-ANAT-2(1)
           MOVE "The final period (.) completes the PROGRAM-ID entry."
               TO DV-ANAT-3(1)
           MOVE "Mainframe registers new program ID -> VAULT"
               TO DV-EFFECT(1)
           MOVE "Y" TO DV-FORBID-EQ(1) DV-NEED-PERIOD(1) DV-CHECK-ORDER(1)
           MOVE "N" TO DV-QUOTE-RULE(1)
           MOVE "PROGRAM-ID." TO DV-TOK-1(1)
           MOVE "Start with PROGRAM-ID. (include both the hyphen '-' and period '.')."
               TO DV-ERR-1(1)
           MOVE "VAULT" TO DV-TOK-2(1)
           MOVE "Follow PROGRAM-ID. with the program name VAULT."
               TO DV-ERR-2(1)

           *> Variant 2
           MOVE "Write the PROGRAM-ID line to give this program the name LEDGER."
               TO DV-TASK-1(2)
           MOVE "(No quotes around program names -- don't forget both periods!)"
               TO DV-TASK-2(2)
           MOVE "Similar example: to name a program TIMER, write:  PROGRAM-ID. TIMER."
               TO DV-HINT-1(2)
           MOVE "Blueprint:  PROGRAM-ID. ______."
               TO DV-HINT-2(2)
           MOVE "PROGRAM-ID. LEDGER."
               TO DV-SOLUTION(2)
           MOVE "PROGRAM-ID. is COBOL's mandatory label for naming a program."
               TO DV-ANAT-1(2)
           MOVE "LEDGER is the name we chose (no quotes around names/labels!)."
               TO DV-ANAT-2(2)
           MOVE "The period (.) at the end finishes the entry."
               TO DV-ANAT-3(2)
           MOVE "Mainframe registers new program ID -> LEDGER"
               TO DV-EFFECT(2)
           MOVE "Y" TO DV-FORBID-EQ(2) DV-NEED-PERIOD(2) DV-CHECK-ORDER(2)
           MOVE "N" TO DV-QUOTE-RULE(2)
           MOVE "PROGRAM-ID." TO DV-TOK-1(2)
           MOVE "Begin with PROGRAM-ID. (hyphenated, followed by a period!)."
               TO DV-ERR-1(2)
           MOVE "LEDGER" TO DV-TOK-2(2)
           MOVE "Give the program the name LEDGER."
               TO DV-ERR-2(2)

           *> Variant 3
           MOVE "Write the PROGRAM-ID line to give this program the name ROCKET."
               TO DV-TASK-1(3)
           MOVE "(Hyphenated PROGRAM-ID., bare name ROCKET, closing period!)"
               TO DV-TASK-2(3)
           MOVE "Similar example: to name a program RADAR, write:  PROGRAM-ID. RADAR."
               TO DV-HINT-1(3)
           MOVE "Blueprint:  PROGRAM-ID. ______."
               TO DV-HINT-2(3)
           MOVE "PROGRAM-ID. ROCKET."
               TO DV-SOLUTION(3)
           MOVE "PROGRAM-ID. introduces the official name of the COBOL program."
               TO DV-ANAT-1(3)
           MOVE "ROCKET is the bare identifier name."
               TO DV-ANAT-2(3)
           MOVE "A final period (.) closes the header entry."
               TO DV-ANAT-3(3)
           MOVE "Mainframe registers new program ID -> ROCKET"
               TO DV-EFFECT(3)
           MOVE "Y" TO DV-FORBID-EQ(3) DV-NEED-PERIOD(3) DV-CHECK-ORDER(3)
           MOVE "N" TO DV-QUOTE-RULE(3)
           MOVE "PROGRAM-ID." TO DV-TOK-1(3)
           MOVE "Begin with PROGRAM-ID. (don't forget the hyphen and period)."
               TO DV-ERR-1(3)
           MOVE "ROCKET" TO DV-TOK-2(3)
           MOVE "Specify ROCKET as the program name."
               TO DV-ERR-2(3)

           PERFORM 8000-RUN-ADAPTIVE-DRILL
           MOVE 1 TO WS-MISSION-NUM
           PERFORM 1900-COMPLETE-MISSION.

*> ===================================================================
*> CHAPTER 2: THE 4-ROOM BLUEPRINT & HUMAN COMMENTS (*>)
*> ===================================================================
       2200-CHAPTER-2.
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== CHAPTER 2 (Page 1/2): THE 4-ROOM BLUEPRINT ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  Imagine walking into a well-organized bakery. Flour is in the"
           DISPLAY "  Pantry, ovens are in the Kitchen, and the cash register is up"
           DISPLAY "  front -- you always know where to look!"
           DISPLAY " "
           DISPLAY "  Every COBOL program is organized into up to "
               FUNCTION TRIM(C-YLW) "4 DIVISIONS" FUNCTION TRIM(C-RST)
               " (rooms),"
           DISPLAY "  and they ALWAYS appear in this exact 1-2-3-4 order:"
           DISPLAY " "
           DISPLAY "  +--------------------------------------------------------------+"
           DISPLAY "  | 1. " FUNCTION TRIM(C-GRN) "IDENTIFICATION DIVISION."
               FUNCTION TRIM(C-RST) " -> Front Door Nameplate (ID)     |"
           DISPLAY "  | 2. " FUNCTION TRIM(C-GRN) "ENVIRONMENT DIVISION."
               FUNCTION TRIM(C-RST) "    -> Loading Dock (external files) |"
           DISPLAY "  | 3. " FUNCTION TRIM(C-GRN) "DATA DIVISION."
               FUNCTION TRIM(C-RST) "           -> Supply Closet (storage boxes) |"
           DISPLAY "  | 4. " FUNCTION TRIM(C-GRN) "PROCEDURE DIVISION."
               FUNCTION TRIM(C-RST) "      -> Workshop (step-by-step verbs) |"
           DISPLAY "  +--------------------------------------------------------------+"
           DISPLAY " "
           DISPLAY "  If a tiny program doesn't read outside files, you can skip Room 2"
           DISPLAY "  -- but you NEVER put DATA DIVISION after PROCEDURE DIVISION, because"
           DISPLAY "  COBOL sets up all your supplies BEFORE the workshop starts running!"
           PERFORM 9000-PRESS-ENTER
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== CHAPTER 2 (Page 2/2): LEAVING NOTES FOR HUMANS (*>) ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  When real programmers write code, they leave helpful sticky notes"
           DISPLAY "  right inside the file explaining *why* a step is there. These"
           DISPLAY "  notes are called " FUNCTION TRIM(C-YLW) "COMMENTS"
               FUNCTION TRIM(C-RST) " -- the computer completely ignores them!"
           DISPLAY " "
           DISPLAY "  In modern COBOL, type " FUNCTION TRIM(C-GRN) "*>"
               FUNCTION TRIM(C-RST) " (asterisk + greater-than arrow) to make"
           DISPLAY "  everything after it on that line a comment:"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               "      *> Greet the customer when the ATM wakes up"
               FUNCTION TRIM(C-RST)
           DISPLAY FUNCTION TRIM(C-GRN)
               '      DISPLAY "WELCOME TO BIG IRON BANK".'
               FUNCTION TRIM(C-RST)
           DISPLAY " "
           DISPLAY "  Fun history: In the 1960s, programmers typed each line onto a"
           DISPLAY "  stiff 80-column paper punch card! Back then, putting '*' in"
           DISPLAY "  Column 7 marked a comment card. Today, '*>' works anywhere!"
           DISPLAY "  (And because the computer ignores comments, they don't even"
           DISPLAY "  require a period at the end!)"
           PERFORM 9000-PRESS-ENTER
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- QUIZ 2 ---
           INITIALIZE WS-QUIZ-BANK
           MOVE "BLUEPRINT & COMMENTS" TO WS-Q-TITLE

           MOVE "Which " TO QZ-Q1(1)
           MOVE "In which room (Division) do we set up our storage boxes BEFORE"
               TO QZ-Q1(1)
           MOVE "running action steps in the PROCEDURE DIVISION?"
               TO QZ-Q2(1)
           MOVE "DATA DIVISION."
               TO QZ-OPT-A(1)
           MOVE "KITCHEN DIVISION."
               TO QZ-OPT-B(1)
           MOVE "IDENTIFICATION DIVISION."
               TO QZ-OPT-C(1)
           MOVE "A" TO QZ-ANS(1)
           MOVE "DATA DIVISION is the Supply Closet where all storage boxes live!"
               TO QZ-OK-MSG(1)
           MOVE "IDENTIFICATION only names the program, and KITCHEN isn't real."
               TO QZ-WHY-1(1)
           MOVE "DATA DIVISION comes right before PROCEDURE DIVISION so every"
               TO QZ-WHY-2(1)
           MOVE "storage box is ready before your action steps start!"
               TO QZ-WHY-3(1)

           MOVE "What does the computer do when it sees a line starting with *> ?"
               TO QZ-Q1(2)
           MOVE "(For example:  *> Calculate monthly bonus )"
               TO QZ-Q2(2)
           MOVE "It prints the note onto the user's screen"
               TO QZ-OPT-A(2)
           MOVE "It skips it completely -- *> is a comment note for humans!"
               TO QZ-OPT-B(2)
           MOVE "It multiplies two numbers together"
               TO QZ-OPT-C(2)
           MOVE "B" TO QZ-ANS(2)
           MOVE "Right! *> is strictly for human readers; the compiler ignores it."
               TO QZ-OK-MSG(2)
           MOVE "*> marks a human-only comment in modern COBOL."
               TO QZ-WHY-1(2)
           MOVE "Comments never print on screen and never slow down your program;"
               TO QZ-WHY-2(2)
           MOVE "they help you and your teammates understand your code later!"
               TO QZ-WHY-3(2)

           PERFORM 7800-RUN-ADAPTIVE-QUIZ
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- DRILL 2A: WRITE A *> COMMENT ---
           INITIALIZE WS-DRILL-BANK
           MOVE "WRITING A HUMAN COMMENT (*>)" TO DRL-HEADER

           MOVE "Write a COBOL comment line containing the words: DAILY BACKUP"
               TO DV-TASK-1(1)
           MOVE "(Start with the two-character comment symbol, then your note!)"
               TO DV-TASK-2(1)
           MOVE "Similar example:  *> CHECK PASSWORD"
               TO DV-HINT-1(1)
           MOVE "Blueprint:  *> ____________"
               TO DV-HINT-2(1)
           MOVE "*> DAILY BACKUP"
               TO DV-SOLUTION(1)
           MOVE "*> (asterisk + arrow with no space between them) starts a comment."
               TO DV-ANAT-1(1)
           MOVE "DAILY BACKUP is your plain-English note for human readers."
               TO DV-ANAT-2(1)
           MOVE "Comments are ignored by the compiler, so no period is needed!"
               TO DV-ANAT-3(1)
           MOVE "Compiler skips your comment cleanly -- great documentation!"
               TO DV-EFFECT(1)
           MOVE " " TO DV-FORBID-EQ(1) DV-QUOTE-RULE(1) DV-NEED-PERIOD(1)
           MOVE "Y" TO DV-CHECK-ORDER(1)
           MOVE "*>" TO DV-TOK-1(1)
           MOVE "Start with *> (asterisk immediately followed by >) for a comment."
               TO DV-ERR-1(1)
           MOVE "DAILY BACKUP" TO DV-TOK-2(1)
           MOVE "Include the words DAILY BACKUP after *>."
               TO DV-ERR-2(1)

           MOVE "Write a COBOL comment line containing the words: TAX STEP"
               TO DV-TASK-1(2)
           MOVE "(Use modern COBOL's two-character comment starter!)"
               TO DV-TASK-2(2)
           MOVE "Similar example:  *> OPEN VAULT"
               TO DV-HINT-1(2)
           MOVE "Blueprint:  *> ________"
               TO DV-HINT-2(2)
           MOVE "*> TAX STEP"
               TO DV-SOLUTION(2)
           MOVE "*> tells COBOL the rest of this line is a human note."
               TO DV-ANAT-1(2)
           MOVE "TAX STEP explains what the upcoming code is for."
               TO DV-ANAT-2(2)
           MOVE "No quotes or ending period needed on comments!"
               TO DV-ANAT-3(2)
           MOVE "Compiler skips your comment cleanly!"
               TO DV-EFFECT(2)
           MOVE " " TO DV-FORBID-EQ(2) DV-QUOTE-RULE(2) DV-NEED-PERIOD(2)
           MOVE "Y" TO DV-CHECK-ORDER(2)
           MOVE "*>" TO DV-TOK-1(2)
           MOVE "Begin with *> (asterisk + greater-than sign) to write a comment."
               TO DV-ERR-1(2)
           MOVE "TAX STEP" TO DV-TOK-2(2)
           MOVE "Write the note TAX STEP after *>."
               TO DV-ERR-2(2)

           MOVE "Write a COBOL comment line containing the words: START LOOP"
               TO DV-TASK-1(3)
           MOVE "(Start with COBOL's comment marker, followed by START LOOP)"
               TO DV-TASK-2(3)
           MOVE "Similar example:  *> SAVE RECORD"
               TO DV-HINT-1(3)
           MOVE "Blueprint:  *> __________"
               TO DV-HINT-2(3)
           MOVE "*> START LOOP"
               TO DV-SOLUTION(3)
           MOVE "*> marks the line as a comment for humans."
               TO DV-ANAT-1(3)
           MOVE "START LOOP documents the code section clearly."
               TO DV-ANAT-2(3)
           MOVE "The computer skips past *> lines automatically."
               TO DV-ANAT-3(3)
           MOVE "Comment added cleanly!"
               TO DV-EFFECT(3)
           MOVE " " TO DV-FORBID-EQ(3) DV-QUOTE-RULE(3) DV-NEED-PERIOD(3)
           MOVE "Y" TO DV-CHECK-ORDER(3)
           MOVE "*>" TO DV-TOK-1(3)
           MOVE "Use *> to begin a modern COBOL comment."
               TO DV-ERR-1(3)
           MOVE "START LOOP" TO DV-TOK-2(3)
           MOVE "Include the phrase START LOOP in your comment."
               TO DV-ERR-2(3)

           PERFORM 8000-RUN-ADAPTIVE-DRILL
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- DRILL 2B: DIVISION HEADERS ---
           INITIALIZE WS-DRILL-BANK
           MOVE "OPENING A DIVISION ROOM" TO DRL-HEADER

           MOVE "Write the division header line that opens Room #3 (where storage"
               TO DV-TASK-1(1)
           MOVE "boxes & variables are defined). Don't forget the closing period!"
               TO DV-TASK-2(1)
           MOVE "Similar example: Room #2's header is:  ENVIRONMENT DIVISION."
               TO DV-HINT-1(1)
           MOVE "Blueprint:  ____ DIVISION."
               TO DV-HINT-2(1)
           MOVE "DATA DIVISION."
               TO DV-SOLUTION(1)
           MOVE "DATA names the third division (where all data boxes are declared)."
               TO DV-ANAT-1(1)
           MOVE "DIVISION tells COBOL this is one of the 4 major file sections."
               TO DV-ANAT-2(1)
           MOVE "Every division header MUST end with a period (.)."
               TO DV-ANAT-3(1)
           MOVE "DATA DIVISION opened -- ready to create storage boxes!"
               TO DV-EFFECT(1)
           MOVE "Y" TO DV-FORBID-EQ(1) DV-NEED-PERIOD(1) DV-CHECK-ORDER(1)
           MOVE "N" TO DV-QUOTE-RULE(1)
           MOVE "DATA" TO DV-TOK-1(1)
           MOVE "Room #3 (for storage boxes & data) starts with the word DATA."
               TO DV-ERR-1(1)
           MOVE "DIVISION" TO DV-TOK-2(1)
           MOVE "Follow DATA with the word DIVISION."
               TO DV-ERR-2(1)

           MOVE "Write the division header line that opens Room #4 (the Workshop"
               TO DV-TASK-1(2)
           MOVE "where step-by-step action verbs like DISPLAY run)."
               TO DV-TASK-2(2)
           MOVE "Similar example: Room #1's header is:  IDENTIFICATION DIVISION."
               TO DV-HINT-1(2)
           MOVE "Blueprint:  _________ DIVISION."
               TO DV-HINT-2(2)
           MOVE "PROCEDURE DIVISION."
               TO DV-SOLUTION(2)
           MOVE "PROCEDURE names Room #4 -- the step-by-step procedure/recipe."
               TO DV-ANAT-1(2)
           MOVE "DIVISION marks a major section of your COBOL program."
               TO DV-ANAT-2(2)
           MOVE "The closing period (.) finishes the division header."
               TO DV-ANAT-3(2)
           MOVE "PROCEDURE DIVISION opened -- ready to run action verbs!"
               TO DV-EFFECT(2)
           MOVE "Y" TO DV-FORBID-EQ(2) DV-NEED-PERIOD(2) DV-CHECK-ORDER(2)
           MOVE "N" TO DV-QUOTE-RULE(2)
           MOVE "PROCEDURE" TO DV-TOK-1(2)
           MOVE "Room #4 (for executable steps) is called PROCEDURE DIVISION."
               TO DV-ERR-1(2)
           MOVE "DIVISION" TO DV-TOK-2(2)
           MOVE "Follow PROCEDURE with the word DIVISION."
               TO DV-ERR-2(2)

           MOVE "Write the division header line that opens Room #1 (the Front Door"
               TO DV-TASK-1(3)
           MOVE "Nameplate at the very top of every COBOL file)."
               TO DV-TASK-2(3)
           MOVE "Similar example: Room #2's header is:  ENVIRONMENT DIVISION."
               TO DV-HINT-1(3)
           MOVE "Blueprint:  ______________ DIVISION."
               TO DV-HINT-2(3)
           MOVE "IDENTIFICATION DIVISION."
               TO DV-SOLUTION(3)
           MOVE "IDENTIFICATION is the very first division in every COBOL file."
               TO DV-ANAT-1(3)
           MOVE "DIVISION marks the major section header."
               TO DV-ANAT-2(3)
           MOVE "The period (.) closes the header."
               TO DV-ANAT-3(3)
           MOVE "IDENTIFICATION DIVISION opened!"
               TO DV-EFFECT(3)
           MOVE "Y" TO DV-FORBID-EQ(3) DV-NEED-PERIOD(3) DV-CHECK-ORDER(3)
           MOVE "N" TO DV-QUOTE-RULE(3)
           MOVE "IDENTIFICATION" TO DV-TOK-1(3)
           MOVE "Room #1 begins with the word IDENTIFICATION."
               TO DV-ERR-1(3)
           MOVE "DIVISION" TO DV-TOK-2(3)
           MOVE "Follow IDENTIFICATION with DIVISION."
               TO DV-ERR-2(3)

           PERFORM 8000-RUN-ADAPTIVE-DRILL
           MOVE 2 TO WS-MISSION-NUM
           PERFORM 1900-COMPLETE-MISSION.

*> ===================================================================
*> CHAPTER 3: LABELED STORAGE BOXES (VARIABLES & PIC CLAUSES)
*> ===================================================================
       2300-CHAPTER-3.
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== CHAPTER 3 (Page 1/3): WHAT IS A VARIABLE? ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  Printing fixed messages is neat, but real programs need to"
           DISPLAY "  REMEMBER changing things -- like a player's score, a customer's"
           DISPLAY "  name, or a checking account balance!"
           DISPLAY " "
           DISPLAY "  To remember something, we create a "
               FUNCTION TRIM(C-YLW) "VARIABLE" FUNCTION TRIM(C-RST)
               ": imagine a labeled"
           DISPLAY "  storage box sitting on a shelf inside "
               FUNCTION TRIM(C-GRN) "WORKING-STORAGE SECTION."
               FUNCTION TRIM(C-RST)
           DISPLAY "  (which lives inside your DATA DIVISION Supply Closet!)."
           DISPLAY " "
           DISPLAY "  Every box declaration in COBOL answers 3 simple questions:"
           DISPLAY "    1. " FUNCTION TRIM(C-YLW) "OUTLINE LEVEL (01)"
               FUNCTION TRIM(C-RST) " : '01' means a standalone top-level box."
           DISPLAY "    2. " FUNCTION TRIM(C-YLW) "BOX NAME"
               FUNCTION TRIM(C-RST) "           : Use letters, numbers & hyphens (-),"
           DISPLAY "                         like USER-NAME or TICKET-COUNT (no spaces!)."
           DISPLAY "    3. " FUNCTION TRIM(C-YLW) "SHAPE (PIC)"
               FUNCTION TRIM(C-RST) "        : Short for PICTURE -- draws a picture of"
           DISPLAY "                         what kind of characters fit inside & how many!"
           PERFORM 9000-PRESS-ENTER
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== CHAPTER 3 (Page 2/3): TEXT BOXES (X) VS NUMBER BOXES (9) ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  Look at two real storage boxes side by side:"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               '      01 PET-NAME     PIC X(6)  VALUE "COSMO".'
               FUNCTION TRIM(C-RST)
           DISPLAY "         Slots in memory:  [C][O][S][M][O][ ]   <- 6 text slots!"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               "      01 HIGH-SCORE   PIC 9(4)  VALUE 25."
               FUNCTION TRIM(C-RST)
           DISPLAY "         Slots in memory:  [0][0][2][5]         <- 4 digit slots!"
           DISPLAY " "
           DISPLAY "  Decode the " FUNCTION TRIM(C-YLW) "PIC"
               FUNCTION TRIM(C-RST) " symbols:"
           DISPLAY "    * " FUNCTION TRIM(C-YLW) "X" FUNCTION TRIM(C-RST)
               " means ANY character (letters, spaces, punctuation)."
           DISPLAY "      X(6) is shorthand for XXXXXX (6 character slots)."
           DISPLAY "    * " FUNCTION TRIM(C-YLW) "9" FUNCTION TRIM(C-RST)
               " means a NUMBER DIGIT (0 through 9 only!)."
           DISPLAY "      9(4) is shorthand for 9999 (holds 0000 up to 9999)."
           DISPLAY "    * " FUNCTION TRIM(C-YLW) "VALUE ..." FUNCTION TRIM(C-RST)
               " (optional) puts a starting value in the box right away!"
           PERFORM 9000-PRESS-ENTER
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== CHAPTER 3 (Page 3/3): MINUS SIGNS (S) & CENTS (V) ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  What if a bank balance goes negative (-$50.25) or has cents?"
           DISPLAY "  Two tiny letters unlock serious financial power:"
           DISPLAY " "
           DISPLAY "  1. " FUNCTION TRIM(C-YLW) "S = Sign (+/-)"
               FUNCTION TRIM(C-RST) ":"
           DISPLAY "     A plain PIC 9(3) box CANNOT remember a minus sign! If you put"
           DISPLAY "     -42 into PIC 9(3), the '-' drops off and it becomes +42!"
           DISPLAY "     Write " FUNCTION TRIM(C-GRN) "PIC S9(3)"
               FUNCTION TRIM(C-RST) " so the box remembers positive OR negative!"
           DISPLAY " "
           DISPLAY "  2. " FUNCTION TRIM(C-YLW) "V = Where the Decimal Point Lives"
               FUNCTION TRIM(C-RST) ":"
           DISPLAY "     Remember how '.' ends a sentence in COBOL? If you wrote a '.'"
           DISPLAY "     in the middle of a math box, COBOL might think your sentence"
           DISPLAY "     ended! Instead, math boxes use " FUNCTION TRIM(C-GRN) "V"
               FUNCTION TRIM(C-RST) " to mark the decimal split:"
           DISPLAY " "
           DISPLAY FUNCTION TRIM(C-GRN)
               "       01 BALANCE   PIC S9(5)V99."
               FUNCTION TRIM(C-RST)
           DISPLAY "         -> Signed (+/-), up to 5 dollar digits, and 2 cent digits!"
           DISPLAY "            (Holds anything from -99999.99 to +99999.99!)"
           PERFORM 9000-PRESS-ENTER
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- QUIZ 3 ---
           INITIALIZE WS-QUIZ-BANK
           MOVE "STORAGE BOXES & PIC" TO WS-Q-TITLE

           MOVE "You want a storage box to hold a customer's city name (like"
               TO QZ-Q1(1)
           MOVE '"BOSTON" or "ST. LOUIS", up to 15 characters). Which PIC fits?'
               TO QZ-Q2(1)
           MOVE "PIC 9(15)"
               TO QZ-OPT-A(1)
           MOVE "PIC X(15)"
               TO QZ-OPT-B(1)
           MOVE "PIC V99"
               TO QZ-OPT-C(1)
           MOVE "B" TO QZ-ANS(1)
           MOVE "PIC X(15) holds 15 slots of letters, spaces, and punctuation!"
               TO QZ-OK-MSG(1)
           MOVE "Remember: '9' only allows digits 0-9 (so BOSTON wouldn't fit!)."
               TO QZ-WHY-1(1)
           MOVE "'X' stands for any text character (letters, spaces, symbols),"
               TO QZ-WHY-2(1)
           MOVE "and (15) reserves 15 character slots in memory."
               TO QZ-WHY-3(1)

           MOVE "What happens if a temperature drops to -12 degrees, and you store"
               TO QZ-Q1(2)
           MOVE "it inside:  01 TEMP PIC 9(3).  (Notice there is NO 'S'!)"
               TO QZ-Q2(2)
           MOVE "COBOL strips the minus sign and stores +012 (freezing becomes warm!)"
               TO QZ-OPT-A(2)
           MOVE "It automatically adds an S for you"
               TO QZ-OPT-B(2)
           MOVE "It stores the word MINUS"
               TO QZ-OPT-C(2)
           MOVE "A" TO QZ-ANS(2)
           MOVE "Yes! Without 'S' (PIC S9(3)), COBOL forgets minus signs!"
               TO QZ-OK-MSG(2)
           MOVE "An unsigned PIC 9(3) box only has slots for digits 0-9, not +/-."
               TO QZ-WHY-1(2)
           MOVE "So -12 silently loses its minus sign and becomes positive 012!"
               TO QZ-WHY-2(2)
           MOVE "Always write PIC S9(...) whenever a number could be negative."
               TO QZ-WHY-3(2)

           PERFORM 7800-RUN-ADAPTIVE-QUIZ
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- DRILL 3A: CREATE A TEXT BOX ---
           INITIALIZE WS-DRILL-BANK
           MOVE "CREATING A TEXT BOX (PIC X)" TO DRL-HEADER

           MOVE "Create a top-level (01) text box named USER-CITY that holds 12"
               TO DV-TASK-1(1)
           MOVE "text characters (no starting VALUE needed; end with a period!)."
               TO DV-TASK-2(1)
           MOVE "Similar example (8-char box PET-TYPE):  01 PET-TYPE PIC X(8)."
               TO DV-HINT-1(1)
           MOVE "Blueprint:  01 _________ PIC X(__)."
               TO DV-HINT-2(1)
           MOVE "01 USER-CITY PIC X(12)."
               TO DV-SOLUTION(1)
           MOVE "01 marks this as a top-level standalone storage box."
               TO DV-ANAT-1(1)
           MOVE "USER-CITY is the box's label (hyphenated, no spaces or quotes)."
               TO DV-ANAT-2(1)
           MOVE "PIC X(12). reserves 12 text character slots and ends with '.'."
               TO DV-ANAT-3(1)
           MOVE "Allocated 12-character box USER-CITY -> [            ]"
               TO DV-EFFECT(1)
           MOVE "Y" TO DV-FORBID-EQ(1) DV-NEED-PERIOD(1) DV-CHECK-ORDER(1)
           MOVE "N" TO DV-QUOTE-RULE(1)
           MOVE "01" TO DV-TOK-1(1)
           MOVE "Start your declaration with level number 01."
               TO DV-ERR-1(1)
           MOVE "USER-CITY" TO DV-TOK-2(1)
           MOVE "Name your storage box USER-CITY (with a hyphen!)."
               TO DV-ERR-2(1)
           MOVE "X(12)" TO DV-TOK-3(1)
           MOVE "XXXXXXXXXXXX" TO DV-TOK-3-ALT(1)
           MOVE "Use PIC X(12) to give the box 12 text character slots!"
               TO DV-ERR-3(1)
           MOVE "PIC" TO DV-TOK-4(1)
           MOVE "Don't forget the keyword PIC before X(12)!"
               TO DV-ERR-4(1)

           MOVE "Create a top-level (01) text box named BADGE-CODE that holds 6"
               TO DV-TASK-1(2)
           MOVE "text characters (end with a period!)."
               TO DV-TASK-2(2)
           MOVE "Similar example (10-char box ITEM-TAG):  01 ITEM-TAG PIC X(10)."
               TO DV-HINT-1(2)
           MOVE "Blueprint:  01 __________ PIC X(_)."
               TO DV-HINT-2(2)
           MOVE "01 BADGE-CODE PIC X(6)."
               TO DV-SOLUTION(2)
           MOVE "01 creates a standalone variable box."
               TO DV-ANAT-1(2)
           MOVE "BADGE-CODE is the box name."
               TO DV-ANAT-2(2)
           MOVE "PIC X(6). reserves 6 text slots and ends with a period."
               TO DV-ANAT-3(2)
           MOVE "Allocated 6-character box BADGE-CODE -> [      ]"
               TO DV-EFFECT(2)
           MOVE "Y" TO DV-FORBID-EQ(2) DV-NEED-PERIOD(2) DV-CHECK-ORDER(2)
           MOVE "N" TO DV-QUOTE-RULE(2)
           MOVE "01" TO DV-TOK-1(2)
           MOVE "Start with level number 01."
               TO DV-ERR-1(2)
           MOVE "BADGE-CODE" TO DV-TOK-2(2)
           MOVE "Name the box BADGE-CODE."
               TO DV-ERR-2(2)
           MOVE "X(6)" TO DV-TOK-3(2)
           MOVE "XXXXXX" TO DV-TOK-3-ALT(2)
           MOVE "Use PIC X(6) for 6 text characters!"
               TO DV-ERR-3(2)
           MOVE "PIC" TO DV-TOK-4(2)
           MOVE "Include the word PIC before X(6)!"
               TO DV-ERR-4(2)

           MOVE "Create a top-level (01) text box named FIRST-NAME that holds 15"
               TO DV-TASK-1(3)
           MOVE "text characters (end with a period!)."
               TO DV-TASK-2(3)
           MOVE "Similar example (20-char box BOOK-TITLE):  01 BOOK-TITLE PIC X(20)."
               TO DV-HINT-1(3)
           MOVE "Blueprint:  01 __________ PIC X(__)."
               TO DV-HINT-2(3)
           MOVE "01 FIRST-NAME PIC X(15)."
               TO DV-SOLUTION(3)
           MOVE "01 defines a top-level storage item."
               TO DV-ANAT-1(3)
           MOVE "FIRST-NAME labels the box."
               TO DV-ANAT-2(3)
           MOVE "PIC X(15). sets aside 15 alphanumeric character slots."
               TO DV-ANAT-3(3)
           MOVE "Allocated 15-character box FIRST-NAME!"
               TO DV-EFFECT(3)
           MOVE "Y" TO DV-FORBID-EQ(3) DV-NEED-PERIOD(3) DV-CHECK-ORDER(3)
           MOVE "N" TO DV-QUOTE-RULE(3)
           MOVE "01" TO DV-TOK-1(3)
           MOVE "Start with level number 01."
               TO DV-ERR-1(3)
           MOVE "FIRST-NAME" TO DV-TOK-2(3)
           MOVE "Name the box FIRST-NAME."
               TO DV-ERR-2(3)
           MOVE "X(15)" TO DV-TOK-3(3)
           MOVE "Use PIC X(15) for 15 character slots!"
               TO DV-ERR-3(3)
           MOVE "PIC" TO DV-TOK-4(3)
           MOVE "Include the keyword PIC!"
               TO DV-ERR-4(3)

           PERFORM 8000-RUN-ADAPTIVE-DRILL
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- DRILL 3B: SIGNED DECIMAL MONEY BOX ---
           INITIALIZE WS-DRILL-BANK
           MOVE "SIGNED MONEY BOXES (PIC S9...V99)" TO DRL-HEADER

           MOVE "Create a top-level (01) signed money box named BALANCE with"
               TO DV-TASK-1(1)
           MOVE "5 dollar digits and 2 cent digits (use S and V, end with .)."
               TO DV-TASK-2(1)
           MOVE "Similar example (4 dollar digits + 2 cents):  01 FEE PIC S9(4)V99."
               TO DV-HINT-1(1)
           MOVE "Blueprint:  01 _______ PIC S9(_)V99."
               TO DV-HINT-2(1)
           MOVE "01 BALANCE PIC S9(5)V99."
               TO DV-SOLUTION(1)
           MOVE "01 BALANCE creates a top-level box named BALANCE."
               TO DV-ANAT-1(1)
           MOVE "S9(5) means signed (+/-) with 5 digits to the left of the decimal."
               TO DV-ANAT-2(1)
           MOVE "V99. adds 2 implied cent digits and closes with a period."
               TO DV-ANAT-3(1)
           MOVE "Allocated signed decimal box BALANCE (-99999.99 to +99999.99)!"
               TO DV-EFFECT(1)
           MOVE "Y" TO DV-FORBID-EQ(1) DV-NEED-PERIOD(1) DV-CHECK-ORDER(1)
           MOVE "N" TO DV-QUOTE-RULE(1)
           MOVE "01" TO DV-TOK-1(1)
           MOVE "Begin with level number 01."
               TO DV-ERR-1(1)
           MOVE "BALANCE" TO DV-TOK-2(1)
           MOVE "Name the variable BALANCE."
               TO DV-ERR-2(1)
           MOVE "S9(5)V99" TO DV-TOK-3(1)
           MOVE "S99999V99" TO DV-TOK-3-ALT(1)
           MOVE "Use S9(5)V99 -- 'S' for sign, '9(5)' for dollars, 'V99' for cents!"
               TO DV-ERR-3(1)
           MOVE "PIC" TO DV-TOK-4(1)
           MOVE "Include PIC before S9(5)V99!"
               TO DV-ERR-4(1)

           MOVE "Create a top-level (01) signed money box named LOAN-AMT with"
               TO DV-TASK-1(2)
           MOVE "6 dollar digits and 2 cent digits (use S and V, end with .)."
               TO DV-TASK-2(2)
           MOVE "Similar example (3 dollar digits + 2 cents):  01 TAX PIC S9(3)V99."
               TO DV-HINT-1(2)
           MOVE "Blueprint:  01 ________ PIC S9(_)V99."
               TO DV-HINT-2(2)
           MOVE "01 LOAN-AMT PIC S9(6)V99."
               TO DV-SOLUTION(2)
           MOVE "01 LOAN-AMT declares a top-level box named LOAN-AMT."
               TO DV-ANAT-1(2)
           MOVE "S9(6) gives a +/- sign and 6 whole dollar digits."
               TO DV-ANAT-2(2)
           MOVE "V99. adds 2 decimal cent digits and ends the entry with '.'."
               TO DV-ANAT-3(2)
           MOVE "Allocated signed decimal box LOAN-AMT (-999999.99 to +999999.99)!"
               TO DV-EFFECT(2)
           MOVE "Y" TO DV-FORBID-EQ(2) DV-NEED-PERIOD(2) DV-CHECK-ORDER(2)
           MOVE "N" TO DV-QUOTE-RULE(2)
           MOVE "01" TO DV-TOK-1(2)
           MOVE "Start with level number 01."
               TO DV-ERR-1(2)
           MOVE "LOAN-AMT" TO DV-TOK-2(2)
           MOVE "Name the box LOAN-AMT."
               TO DV-ERR-2(2)
           MOVE "S9(6)V99" TO DV-TOK-3(2)
           MOVE "S999999V99" TO DV-TOK-3-ALT(2)
           MOVE "Write S9(6)V99 ('S' for +/-, 6 dollar digits, V99 for 2 cent digits)."
               TO DV-ERR-3(2)
           MOVE "PIC" TO DV-TOK-4(2)
           MOVE "Include the word PIC!"
               TO DV-ERR-4(2)

           MOVE "Create a top-level (01) signed money box named NET-PROFIT with"
               TO DV-TASK-1(3)
           MOVE "7 dollar digits and 2 cent digits (use S and V, end with .)."
               TO DV-TASK-2(3)
           MOVE "Similar example (4 dollar digits + 2 cents):  01 TIP PIC S9(4)V99."
               TO DV-HINT-1(3)
           MOVE "Blueprint:  01 __________ PIC S9(_)V99."
               TO DV-HINT-2(3)
           MOVE "01 NET-PROFIT PIC S9(7)V99."
               TO DV-SOLUTION(3)
           MOVE "01 NET-PROFIT names our top-level storage box."
               TO DV-ANAT-1(3)
           MOVE "S9(7) allows positive/negative values up to 7 dollar digits."
               TO DV-ANAT-2(3)
           MOVE "V99. adds 2 exact cent places and ends with a period."
               TO DV-ANAT-3(3)
           MOVE "Allocated signed decimal box NET-PROFIT!"
               TO DV-EFFECT(3)
           MOVE "Y" TO DV-FORBID-EQ(3) DV-NEED-PERIOD(3) DV-CHECK-ORDER(3)
           MOVE "N" TO DV-QUOTE-RULE(3)
           MOVE "01" TO DV-TOK-1(3)
           MOVE "Start with level number 01."
               TO DV-ERR-1(3)
           MOVE "NET-PROFIT" TO DV-TOK-2(3)
           MOVE "Name the box NET-PROFIT."
               TO DV-ERR-2(3)
           MOVE "S9(7)V99" TO DV-TOK-3(3)
           MOVE "S9999999V99" TO DV-TOK-3-ALT(3)
           MOVE "Use S9(7)V99 for signed 7-dollar, 2-cent precision!"
               TO DV-ERR-3(3)
           MOVE "PIC" TO DV-TOK-4(3)
           MOVE "Include PIC before S9(7)V99!"
               TO DV-ERR-4(3)

           PERFORM 8000-RUN-ADAPTIVE-DRILL
           MOVE 3 TO WS-MISSION-NUM
           PERFORM 1900-COMPLETE-MISSION.

*> ===================================================================
*> CHAPTER 4: PUTTING DATA IN BOXES & LISTENING (MOVE & ACCEPT)
*> ===================================================================
       2400-CHAPTER-4.
           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               '=== CHAPTER 4 (Page 1/2): "QUOTES" VS BARE BOX NAMES! ==='
               FUNCTION TRIM(C-RST)
           DISPLAY "  Here is the #1 lightbulb moment for every brand-new programmer:"
           DISPLAY "  Suppose you created a box named PLAYER-CITY holding ""DENVER"": "
           DISPLAY " "
           DISPLAY "  * If you write quotes:    " FUNCTION TRIM(C-YLW)
               'DISPLAY "PLAYER-CITY".' FUNCTION TRIM(C-RST)
           DISPLAY "    Screen shows:           PLAYER-CITY   (literal letters!)"
           DISPLAY " "
           DISPLAY "  * If you write NO quotes: " FUNCTION TRIM(C-GRN)
               "DISPLAY PLAYER-CITY." FUNCTION TRIM(C-RST)
           DISPLAY "    Screen shows:           DENVER        (looks INSIDE the box!)"
           DISPLAY " "
           DISPLAY "  Rule to remember forever:"
           DISPLAY "    -> " FUNCTION TRIM(C-YLW) "WITH quotes"
               FUNCTION TRIM(C-RST) "    = exact literal text."
           DISPLAY "    -> " FUNCTION TRIM(C-GRN) "WITHOUT quotes"
               FUNCTION TRIM(C-RST) " = open the storage box with that name!"
           PERFORM 9000-PRESS-ENTER
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           PERFORM 0150-CLEAR-SCREEN
           DISPLAY FUNCTION TRIM(C-CYN)
               "=== CHAPTER 4 (Page 2/2): CHANGING BOXES WITH MOVE & ACCEPT ==="
               FUNCTION TRIM(C-RST)
           DISPLAY "  Once your program is running inside PROCEDURE DIVISION, two"
           DISPLAY "  verbs put fresh data into your storage boxes:"
           DISPLAY " "
           DISPLAY "  1. " FUNCTION TRIM(C-GRN) "MOVE <what> TO <destination-box>."
               FUNCTION TRIM(C-RST)
           DISPLAY "     Copies a value (or another box's value) into a destination box:"
           DISPLAY "       MOVE 500 TO BALANCE.          *> Puts number 500 into BALANCE"
           DISPLAY '       MOVE "VIP" TO BADGE-TYPE.     *> Puts text VIP into BADGE-TYPE'
           DISPLAY "       MOVE OLD-SCORE TO NEW-SCORE.  *> Copies box to box!"
           DISPLAY " "
           DISPLAY "  2. " FUNCTION TRIM(C-GRN) "ACCEPT <destination-box>."
               FUNCTION TRIM(C-RST)
           DISPLAY "     Pauses and waits for the person at the keyboard to type"
           DISPLAY "     something and press ENTER, storing their answer in that box!"
           DISPLAY "       ACCEPT GUEST-NAME.            *> Waits for keyboard input!"
           DISPLAY " "
           DISPLAY "  (Bonus detail: When MOVE-ing text into a box that's too small,"
           DISPLAY '   extra right-hand letters get cut off: "CHICAGO" in X(3) -> "CHI"!)'
           PERFORM 9000-PRESS-ENTER
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- QUIZ 4 ---
           INITIALIZE WS-QUIZ-BANK
           MOVE "QUOTES, MOVE & ACCEPT" TO WS-Q-TITLE

           MOVE 'Box PET-NAME currently holds "REX". What prints on screen if'
               TO QZ-Q1(1)
           MOVE 'you accidentally put quotes:  DISPLAY "PET-NAME". ?'
               TO QZ-Q2(1)
           MOVE "REX"
               TO QZ-OPT-A(1)
           MOVE "The literal word PET-NAME (because quotes print exact letters!)"
               TO QZ-OPT-B(1)
           MOVE "Nothing prints"
               TO QZ-OPT-C(1)
           MOVE "B" TO QZ-ANS(1)
           MOVE "Right! To print REX from inside the box, write DISPLAY PET-NAME."
               TO QZ-OK-MSG(1)
           MOVE "Quotation marks tell COBOL: print these exact characters literally."
               TO QZ-WHY-1(1)
           MOVE "To look INSIDE the storage box named PET-NAME and get REX,"
               TO QZ-WHY-2(1)
           MOVE "you write the box name bare WITHOUT quotes: DISPLAY PET-NAME."
               TO QZ-WHY-3(1)

           MOVE "Which sentence properly puts the number 100 into box SCORE?"
               TO QZ-Q1(2)
           MOVE "(Watch the direction from source value -> TO -> destination box!)"
               TO QZ-Q2(2)
           MOVE "MOVE SCORE TO 100."
               TO QZ-OPT-A(2)
           MOVE 'MOVE 100 TO "SCORE".'
               TO QZ-OPT-B(2)
           MOVE "MOVE 100 TO SCORE."
               TO QZ-OPT-C(2)
           MOVE "C" TO QZ-ANS(2)
           MOVE "MOVE 100 TO SCORE. copies 100 into the bare box name SCORE!"
               TO QZ-OK-MSG(2)
           MOVE "In MOVE <source> TO <destination>., the value you are copying (100)"
               TO QZ-WHY-1(2)
           MOVE "comes FIRST, and the box receiving it (SCORE) comes AFTER TO."
               TO QZ-WHY-2(2)
           MOVE "And SCORE never wears quotes because it's a storage-box name!"
               TO QZ-WHY-3(2)

           PERFORM 7800-RUN-ADAPTIVE-QUIZ
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- DRILL 4A: MOVE ---
           INITIALIZE WS-DRILL-BANK
           MOVE "STORING VALUES WITH MOVE" TO DRL-HEADER

           MOVE "Put the number 500 into the storage box named BALANCE."
               TO DV-TASK-1(1)
           MOVE "(Use COBOL's English verb for moving data, and end with a period!)"
               TO DV-TASK-2(1)
           MOVE "Similar example (putting 10 into LIVES):  MOVE 10 TO LIVES."
               TO DV-HINT-1(1)
           MOVE "Blueprint:  MOVE ___ TO _______."
               TO DV-HINT-2(1)
           MOVE "MOVE 500 TO BALANCE."
               TO DV-SOLUTION(1)
           MOVE "MOVE is COBOL's verb for copying a value into a box."
               TO DV-ANAT-1(1)
           MOVE "500 comes first (what we're copying), followed by TO."
               TO DV-ANAT-2(1)
           MOVE "BALANCE is the bare destination box name, ending with '.'."
               TO DV-ANAT-3(1)
           MOVE "Box BALANCE now holds -> 00500.00"
               TO DV-EFFECT(1)
           MOVE "Y" TO DV-FORBID-EQ(1) DV-NEED-PERIOD(1) DV-CHECK-ORDER(1)
           MOVE "N" TO DV-QUOTE-RULE(1)
           MOVE "MOVE" TO DV-TOK-1(1)
           MOVE "Start with the verb MOVE to copy a value into a box."
               TO DV-ERR-1(1)
           MOVE "500" TO DV-TOK-2(1)
           MOVE "Include the number 500 as the value being moved."
               TO DV-ERR-2(1)
           MOVE "BALANCE" TO DV-TOK-3(1)
           MOVE "Specify BALANCE as the destination box!"
               TO DV-ERR-3(1)
           MOVE " TO " TO DV-TOK-4(1)
           MOVE "Put the word TO between 500 and BALANCE (MOVE 500 TO BALANCE.)."
               TO DV-ERR-4(1)

           MOVE "Put the number 25 into the storage box named TICKETS."
               TO DV-TASK-1(2)
           MOVE "(Remember: source value first, then TO, then bare box name + .)"
               TO DV-TASK-2(2)
           MOVE "Similar example (putting 99 into LEVEL):  MOVE 99 TO LEVEL."
               TO DV-HINT-1(2)
           MOVE "Blueprint:  MOVE __ TO _______."
               TO DV-HINT-2(2)
           MOVE "MOVE 25 TO TICKETS."
               TO DV-SOLUTION(2)
           MOVE "MOVE begins the data-copying instruction."
               TO DV-ANAT-1(2)
           MOVE "25 is the number being copied, followed by TO."
               TO DV-ANAT-2(2)
           MOVE "TICKETS is the destination box (no quotes!), ending with '.'."
               TO DV-ANAT-3(2)
           MOVE "Box TICKETS now holds -> 25"
               TO DV-EFFECT(2)
           MOVE "Y" TO DV-FORBID-EQ(2) DV-NEED-PERIOD(2) DV-CHECK-ORDER(2)
           MOVE "N" TO DV-QUOTE-RULE(2)
           MOVE "MOVE" TO DV-TOK-1(2)
           MOVE "Begin with the verb MOVE."
               TO DV-ERR-1(2)
           MOVE "25" TO DV-TOK-2(2)
           MOVE "Include the number 25."
               TO DV-ERR-2(2)
           MOVE "TICKETS" TO DV-TOK-3(2)
           MOVE "Name TICKETS as the destination box."
               TO DV-ERR-3(2)
           MOVE " TO " TO DV-TOK-4(2)
           MOVE "Include the word TO between 25 and TICKETS!"
               TO DV-ERR-4(2)

           MOVE 'Put the text "OPEN" into the storage box named DOOR-SIGN.'
               TO DV-TASK-1(3)
           MOVE '(Careful: "OPEN" is text so it wears quotes; DOOR-SIGN is a box!)'
               TO DV-TASK-2(3)
           MOVE 'Similar example:  MOVE "READY" TO STATUS-BOX.'
               TO DV-HINT-1(3)
           MOVE 'Blueprint:  MOVE "____" TO _________.'
               TO DV-HINT-2(3)
           MOVE 'MOVE "OPEN" TO DOOR-SIGN.'
               TO DV-SOLUTION(3)
           MOVE 'MOVE copies the quoted text string "OPEN".'
               TO DV-ANAT-1(3)
           MOVE "TO points toward the receiving storage box."
               TO DV-ANAT-2(3)
           MOVE "DOOR-SIGN is written WITHOUT quotes because it's the box name!"
               TO DV-ANAT-3(3)
           MOVE 'Box DOOR-SIGN now holds -> "OPEN"'
               TO DV-EFFECT(3)
           MOVE "Y" TO DV-FORBID-EQ(3) DV-QUOTE-RULE(3) DV-NEED-PERIOD(3)
                       DV-CHECK-ORDER(3)
           MOVE "MOVE" TO DV-TOK-1(3)
           MOVE "Start with the verb MOVE."
               TO DV-ERR-1(3)
           MOVE '"OPEN"' TO DV-TOK-2(3)
           MOVE "'OPEN'" TO DV-TOK-2-ALT(3)
           MOVE 'Wrap the text "OPEN" in quotation marks!'
               TO DV-ERR-2(3)
           MOVE "DOOR-SIGN" TO DV-TOK-3(3)
           MOVE "Write DOOR-SIGN after TO as the destination box."
               TO DV-ERR-3(3)
           MOVE " TO " TO DV-TOK-4(3)
           MOVE 'Include TO between "OPEN" and DOOR-SIGN!'
               TO DV-ERR-4(3)

           PERFORM 8000-RUN-ADAPTIVE-DRILL
           IF SHUTDOWN-NOW EXIT PARAGRAPH END-IF

           *> --- DRILL 4B: ACCEPT KEYBOARD INPUT ---
           INITIALIZE WS-DRILL-BANK
           MOVE "READING KEYBOARD INPUT (ACCEPT)" TO DRL-HEADER

           MOVE "Wait for the user to type on the keyboard and store their answer"
               TO DV-TASK-1(1)
           MOVE "into the storage box named GUEST-NAME (end with a period!)."
               TO DV-TASK-2(1)
           MOVE "Similar example (reading into ZIP-CODE):  ACCEPT ZIP-CODE."
               TO DV-HINT-1(1)
           MOVE "Blueprint:  ACCEPT __________."
               TO DV-HINT-2(1)
           MOVE "ACCEPT GUEST-NAME."
               TO DV-SOLUTION(1)
           MOVE "ACCEPT pauses the program and listens to the keyboard."
               TO DV-ANAT-1(1)
           MOVE "GUEST-NAME (no quotes!) is the box where typed letters are saved."
               TO DV-ANAT-2(1)
           MOVE "The period (.) completes the ACCEPT instruction."
               TO DV-ANAT-3(1)
           MOVE "Keyboard input captured into box GUEST-NAME!"
               TO DV-EFFECT(1)
           MOVE "Y" TO DV-FORBID-EQ(1) DV-NEED-PERIOD(1) DV-CHECK-ORDER(1)
           MOVE "N" TO DV-QUOTE-RULE(1)
           MOVE "ACCEPT" TO DV-TOK-1(1)
           MOVE "Use the verb ACCEPT to read what the user types on the keyboard."
               TO DV-ERR-1(1)
           MOVE "GUEST-NAME" TO DV-TOK-2(1)
           MOVE "Follow ACCEPT with the bare box name GUEST-NAME."
               TO DV-ERR-2(1)

           MOVE "Read keyboard input from the user into the box named PIN-CODE."
               TO DV-TASK-1(2)
           MOVE "(Verb first, bare box name with no quotes, period at the end!)"
               TO DV-TASK-2(2)
           MOVE "Similar example (reading into USER-AGE):  ACCEPT USER-AGE."
               TO DV-HINT-1(2)
           MOVE "Blueprint:  ACCEPT ________."
               TO DV-HINT-2(2)
           MOVE "ACCEPT PIN-CODE."
               TO DV-SOLUTION(2)
           MOVE "ACCEPT waits for the user to type a line and press ENTER."
               TO DV-ANAT-1(2)
           MOVE "PIN-CODE is the storage box that receives what they typed."
               TO DV-ANAT-2(2)
           MOVE "The period (.) ends the sentence."
               TO DV-ANAT-3(2)
           MOVE "Keyboard input captured into box PIN-CODE!"
               TO DV-EFFECT(2)
           MOVE "Y" TO DV-FORBID-EQ(2) DV-NEED-PERIOD(2) DV-CHECK-ORDER(2)
           MOVE "N" TO DV-QUOTE-RULE(2)
           MOVE "ACCEPT" TO DV-TOK-1(2)
           MOVE "Begin with the verb ACCEPT."
               TO DV-ERR-1(2)
           MOVE "PIN-CODE" TO DV-TOK-2(2)
           MOVE "Specify PIN-CODE as the box receiving the input."
               TO DV-ERR-2(2)

           MOVE "Read keyboard input from the user into the box named REPLY-CHOICE."
               TO DV-TASK-1(3)
           MOVE "(No quotes around box names -- finish with a period!)"
               TO DV-TASK-2(3)
           MOVE "Similar example (reading into CITY-IN):  ACCEPT CITY-IN."
               TO DV-HINT-1(3)
           MOVE "Blueprint:  ACCEPT ____________."
               TO DV-HINT-2(3)
           MOVE "ACCEPT REPLY-CHOICE."
               TO DV-SOLUTION(3)
           MOVE "ACCEPT reads a line from the user's keyboard."
               TO DV-ANAT-1(3)
           MOVE "REPLY-CHOICE is the target storage box."
               TO DV-ANAT-2(3)
           MOVE "The closing period (.) finishes the instruction."
               TO DV-ANAT-3(3)
           MOVE "Keyboard input captured into box REPLY-CHOICE!"
               TO DV-EFFECT(3)
           MOVE "Y" TO DV-FORBID-EQ(3) DV-NEED-PERIOD(3) DV-CHECK-ORDER(3)
           MOVE "N" TO DV-QUOTE-RULE(3)
           MOVE "ACCEPT" TO DV-TOK-1(3)
           MOVE "Start with the verb ACCEPT."
               TO DV-ERR-1(3)
           MOVE "REPLY-CHOICE" TO DV-TOK-2(3)
           MOVE "Put REPLY-CHOICE after ACCEPT."
               TO DV-ERR-2(3)

           PERFORM 8000-RUN-ADAPTIVE-DRILL
           MOVE 4 TO WS-MISSION-NUM
           PERFORM 1900-COMPLETE-MISSION.
