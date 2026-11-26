       >>SOURCE FORMAT FREE
*> ===================================================================
*> EXAMPLE 06: PERFORM PARAGRAPHS, TIMES, UNTIL & VARYING
*> Matches Mission 6 of COBOL QUEST!
*> ===================================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PERFORM-LOOPS.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-STEP             PIC 99   VALUE 1.
       01  WS-COUNTDOWN        PIC 9    VALUE 3.

       PROCEDURE DIVISION.
       0000-MAIN.
           PERFORM 1000-PRINT-BANNER 2 TIMES

           PERFORM UNTIL WS-COUNTDOWN = 0
               DISPLAY "T-Minus: " WS-COUNTDOWN
               SUBTRACT 1 FROM WS-COUNTDOWN
           END-PERFORM

           PERFORM VARYING WS-STEP FROM 1 BY 1 UNTIL WS-STEP > 4
               DISPLAY "Batch Stage #" WS-STEP " [COMPLETE]"
           END-PERFORM
           STOP RUN.

       1000-PRINT-BANNER.
           DISPLAY "--- IRON-7090 LOOP ENGINE READY ---".
