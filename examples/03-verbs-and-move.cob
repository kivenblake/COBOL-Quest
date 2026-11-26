       >>SOURCE FORMAT FREE
*> ===================================================================
*> EXAMPLE 03: MOVE ALIGNMENT, DISPLAY & TRUNCATION RULES
*> Matches Mission 3 of COBOL QUEST!
*> ===================================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. VERBS-AND-MOVE.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-FULL-TEXT        PIC X(15) VALUE "COBOL-MAINFRAME".
       01  WS-SMALL-NUM        PIC 9(2)  VALUE 42.
       01  WS-FOUR-DIGIT-YEAR  PIC 9(4)  VALUE 1999.

       01  WS-SHORT-TEXT       PIC X(5).
       01  WS-PADDED-NUM       PIC 9(6).
       01  WS-TRUNC-NUM        PIC 9(3).

       PROCEDURE DIVISION.
           *> Text aligns LEFT (truncates right): "COBOL"
           MOVE WS-FULL-TEXT TO WS-SHORT-TEXT

           *> Numbers align RIGHT / at decimal: "000042"
           MOVE WS-SMALL-NUM TO WS-PADDED-NUM

           *> Watch out! 1999 into PIC 9(3) loses the thousands digit -> "999"
           MOVE WS-FOUR-DIGIT-YEAR TO WS-TRUNC-NUM

           DISPLAY 'Text MOVE ("COBOL-MAINFRAME" -> PIC X(5)) : [' WS-SHORT-TEXT ']'
           DISPLAY "Numeric Pad (42 -> PIC 9(6))              : [" WS-PADDED-NUM "]"
           DISPLAY "Numeric Left-Truncation (1999 -> PIC 9(3)): [" WS-TRUNC-NUM "]"
           STOP RUN.
