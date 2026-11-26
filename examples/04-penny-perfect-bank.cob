       >>SOURCE FORMAT FREE
*> ===================================================================
*> EXAMPLE 04: PENNY-PERFECT BANK ARITHMETIC, ROUNDED & ON SIZE ERROR
*> Matches Mission 4 of COBOL QUEST!
*> ===================================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PENNY-PERFECT-BANK.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PRINCIPAL        PIC S9(7)V99 VALUE 12500.00.
       01  WS-ANNUAL-RATE      PIC V9999    VALUE .0475.
       01  WS-INTEREST         PIC S9(5)V99 VALUE 0.
       01  WS-TINY-VAULT       PIC 9(3)V99  VALUE 950.00.
       01  WS-FMT-MONEY        PIC $Z,ZZZ,ZZ9.99.

       PROCEDURE DIVISION.
           COMPUTE WS-INTEREST ROUNDED = WS-PRINCIPAL * WS-ANNUAL-RATE
           ADD WS-INTEREST TO WS-PRINCIPAL

           MOVE WS-INTEREST  TO WS-FMT-MONEY
           DISPLAY "Interest Earned (4.75% ROUNDED): " WS-FMT-MONEY

           MOVE WS-PRINCIPAL TO WS-FMT-MONEY
           DISPLAY "New Vault Balance              : " WS-FMT-MONEY

           *> Demonstrate ON SIZE ERROR safety guard!
           ADD 100.00 TO WS-TINY-VAULT
               ON SIZE ERROR
                   DISPLAY "[SAFETY GUARD] Overflow prevented on WS-TINY-VAULT (PIC 9(3)V99)!"
               NOT ON SIZE ERROR
                   DISPLAY "Vault updated."
           END-ADD
           STOP RUN.
