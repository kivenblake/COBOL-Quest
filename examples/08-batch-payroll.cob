       >>SOURCE FORMAT FREE
*> ===================================================================
*> EXAMPLE 08: SEQUENTIAL FILE BATCH PAYROLL PROCESSOR
*> Matches Mission 8 (Final Boss!) of COBOL QUEST!
*> Run from the examples/ folder so it reads employees.dat!
*> ===================================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. BATCH-PAYROLL.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PAYROLL-FILE
               ASSIGN TO "employees.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  PAYROLL-FILE.
       01  EMPLOYEE-RECORD.
           05  EMP-ID          PIC X(6).
           05  EMP-NAME        PIC X(20).
           05  EMP-HOURS       PIC 9(3)V9.
           05  EMP-RATE        PIC 9(3)V99.

       WORKING-STORAGE SECTION.
       01  WS-EOF-FLAG         PIC X          VALUE "N".
           88  EOF-REACHED                    VALUE "Y".
       01  WS-GROSS-PAY        PIC 9(6)V99    VALUE 0.
       01  WS-TOTAL-PAYROLL    PIC 9(7)V99    VALUE 0.
       01  WS-EMP-COUNT        PIC 9(3)       VALUE 0.
       01  WS-PAY-FMT          PIC $ZZZ,ZZ9.99.
       01  WS-TOT-FMT          PIC $Z,ZZZ,ZZ9.99.

       PROCEDURE DIVISION.
           DISPLAY "=== MIDNIGHT PAYROLL BATCH REPORT ==="
           OPEN INPUT PAYROLL-FILE

           PERFORM UNTIL EOF-REACHED
               READ PAYROLL-FILE
                   AT END
                       SET EOF-REACHED TO TRUE
                   NOT AT END
                       ADD 1 TO WS-EMP-COUNT
                       COMPUTE WS-GROSS-PAY ROUNDED = EMP-HOURS * EMP-RATE
                       ADD WS-GROSS-PAY TO WS-TOTAL-PAYROLL
                       MOVE WS-GROSS-PAY TO WS-PAY-FMT
                       DISPLAY EMP-ID " | " EMP-NAME " | Gross: " WS-PAY-FMT
               END-READ
           END-PERFORM

           CLOSE PAYROLL-FILE
           MOVE WS-TOTAL-PAYROLL TO WS-TOT-FMT
           DISPLAY "---------------------------------------------"
           DISPLAY "Employees Processed : " WS-EMP-COUNT
           DISPLAY "Total Batch Payroll : " WS-TOT-FMT
           STOP RUN.
