       >>SOURCE FORMAT FREE
*> ===================================================================
*> EXAMPLE 02: WORKING-STORAGE & PICTURE (PIC) FORMATTING SHOWCASE
*> Matches Mission 2 of COBOL QUEST!
*> ===================================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PIC-SHOWCASE.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PRODUCT-NAME     PIC X(18)     VALUE "MAINFRAME-TAPE-PRO".
       01  WS-RAW-PRICE        PIC S9(5)V99  VALUE 01499.95.
       01  WS-REFUND-AMT       PIC S9(5)V99  VALUE -00075.50.

       *> Numeric-Edited PIC fields for human-friendly reports & checks:
       01  WS-PRETTY-PRICE     PIC $ZZ,ZZ9.99.
       01  WS-CHECK-PROTECT    PIC $**,**9.99.
       01  WS-ACCOUNTING-CR    PIC $ZZ,ZZ9.99CR.

       PROCEDURE DIVISION.
           MOVE WS-RAW-PRICE  TO WS-PRETTY-PRICE WS-CHECK-PROTECT
           MOVE WS-REFUND-AMT TO WS-ACCOUNTING-CR

           DISPLAY "Product         : " WS-PRODUCT-NAME
           DISPLAY "Pretty Receipt  : " WS-PRETTY-PRICE
           DISPLAY "Printed Check   : " WS-CHECK-PROTECT
           DISPLAY "Refund Ledger   : " WS-ACCOUNTING-CR
           STOP RUN.
