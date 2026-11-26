       >>SOURCE FORMAT FREE
*> ===================================================================
*> EXAMPLE 05: LEVEL-88 CONDITION NAMES & EVALUATE TRUE
*> Matches Mission 5 of COBOL QUEST!
*> ===================================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ACCOUNT-EVALUATOR.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-CREDIT-SCORE     PIC 9(3) VALUE 785.
           88  TIER-PLATINUM            VALUE 760 THRU 850.
           88  TIER-GOLD                VALUE 680 THRU 759.
           88  TIER-STANDARD            VALUE 300 THRU 679.

       01  WS-STATUS-FLAG      PIC X    VALUE "A".
           88  ACCOUNT-ACTIVE           VALUE "A".
           88  ACCOUNT-FROZEN           VALUE "F".

       PROCEDURE DIVISION.
           IF ACCOUNT-ACTIVE
               DISPLAY "Account Status: ACTIVE (Score: " WS-CREDIT-SCORE ")"
           END-IF

           EVALUATE TRUE
               WHEN TIER-PLATINUM
                   DISPLAY "Approved Tier : PLATINUM (APR 3.90%)"
               WHEN TIER-GOLD
                   DISPLAY "Approved Tier : GOLD     (APR 5.40%)"
               WHEN TIER-STANDARD
                   DISPLAY "Approved Tier : STANDARD (APR 8.25%)"
               WHEN OTHER
                   DISPLAY "Score out of range."
           END-EVALUATE
           STOP RUN.
