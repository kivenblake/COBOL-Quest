       >>SOURCE FORMAT FREE
*> ===================================================================
*> EXAMPLE 07: GROUP RECORDS & 1-INDEXED OCCURS TABLES
*> Matches Mission 7 of COBOL QUEST!
*> ===================================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. BRANCH-TABLE.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-QUARTERLY-REVENUE.
           05  WS-QTR-AMOUNT   PIC 9(6)V99 OCCURS 4 TIMES.

       01  WS-IDX              PIC 9          VALUE 1.
       01  WS-ANNUAL-TOTAL     PIC 9(7)V99    VALUE 0.
       01  WS-FMT-AMT          PIC $Z,ZZZ,ZZ9.99.

       PROCEDURE DIVISION.
           MOVE 125000.50 TO WS-QTR-AMOUNT(1)
           MOVE 148200.75 TO WS-QTR-AMOUNT(2)
           MOVE 139950.00 TO WS-QTR-AMOUNT(3)
           MOVE 182400.25 TO WS-QTR-AMOUNT(4)

           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 4
               ADD WS-QTR-AMOUNT(WS-IDX) TO WS-ANNUAL-TOTAL
               MOVE WS-QTR-AMOUNT(WS-IDX) TO WS-FMT-AMT
               DISPLAY "Quarter Q" WS-IDX " Revenue : " WS-FMT-AMT
           END-PERFORM

           MOVE WS-ANNUAL-TOTAL TO WS-FMT-AMT
           DISPLAY "-----------------------------------"
           DISPLAY "Annual Total       : " WS-FMT-AMT
           STOP RUN.
