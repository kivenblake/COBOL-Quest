*> ===================================================================
*> COPYBOOK: drill-engine-data.cpy
*> PURPOSE : Working-Storage structures for the Adaptive 2-Variant
*>           Concept Quiz Engine & 3-Variant Mastery Coding Engine!
*> ===================================================================

       *> ---------------------------------------------------------------
       *> 2-Variant Adaptive Concept Quiz Table
       *> If the learner misses Variant 1, they get a full plain-English
       *> explanation AND then solve Variant 2 to verify understanding!
       *> ---------------------------------------------------------------
       01  WS-QUIZ-BANK.
           05  WS-QZ-VAR               OCCURS 2 TIMES.
               10  QZ-Q1               PIC X(76).
               10  QZ-Q2               PIC X(76).
               10  QZ-OPT-A            PIC X(76).
               10  QZ-OPT-B            PIC X(76).
               10  QZ-OPT-C            PIC X(76).
               10  QZ-ANS              PIC X.
               10  QZ-OK-MSG           PIC X(76).
               10  QZ-WHY-1            PIC X(76).
               10  QZ-WHY-2            PIC X(76).
               10  QZ-WHY-3            PIC X(76).

       01  WS-QUIZ-STATE.
           05  WS-Q-CUR-VAR            PIC 9     VALUE 1.
           05  WS-Q-PASSED             PIC X     VALUE "N".
           05  WS-Q-INPUT              PIC X(16) VALUE SPACES.
           05  WS-Q-TITLE              PIC X(48) VALUE SPACES.

       *> ---------------------------------------------------------------
       *> 3-Variant Adaptive Coding Drill Structure
       *> - Hints NEVER reveal the answer (Hint 1 = parallel example,
       *>   Hint 2 = fill-in-the-blank blueprint).
       *> - 2 missed attempts (or typing EXPLAIN) shows a side-by-side
       *>   breakdown of WHY each token works, then rotates to a NEW
       *>   variant so the learner solves one independently!
       *> ---------------------------------------------------------------
       01  WS-DRILL-BANK.
           05  DRL-HEADER              PIC X(56) VALUE SPACES.
           05  WS-DRL-VAR              OCCURS 3 TIMES.
               10  DV-TASK-1           PIC X(76).
               10  DV-TASK-2           PIC X(76).
               10  DV-HINT-1           PIC X(76).
               10  DV-HINT-2           PIC X(76).
               10  DV-SOLUTION         PIC X(76).
               10  DV-ANAT-1           PIC X(76).
               10  DV-ANAT-2           PIC X(76).
               10  DV-ANAT-3           PIC X(76).
               10  DV-EFFECT           PIC X(76).
               *> Validation rules for this variant:
               10  DV-FORBID-EQ        PIC X.
               10  DV-QUOTE-RULE       PIC X.
               *>   "Y" = must contain quotes, "N" = forbid quotes, " " = either
               10  DV-NEED-PERIOD      PIC X.
               *>   "Y" = must end with '.', "N" = must NOT end with '.' (comments!)
               10  DV-CHECK-ORDER      PIC X.
               *>   "Y" = TOK-1 must appear before TOK-2 (and TOK-2 before TOK-3)
               10  DV-TOK-1            PIC X(24).
               10  DV-ERR-1            PIC X(76).
               10  DV-TOK-2            PIC X(24).
               10  DV-TOK-2-ALT        PIC X(24).
               10  DV-ERR-2            PIC X(76).
               10  DV-TOK-3            PIC X(24).
               10  DV-TOK-3-ALT        PIC X(24).
               10  DV-ERR-3            PIC X(76).
               10  DV-TOK-4            PIC X(24).
               10  DV-ERR-4            PIC X(76).

       01  WS-DRILL-RUNTIME.
           05  WS-D-CUR-VAR            PIC 9     VALUE 1.
           05  WS-D-ATTEMPTS           PIC 9     VALUE 0.
           05  WS-TRY-NUM              PIC 9     VALUE 1.
           05  WS-D-HINT-LVL           PIC 9     VALUE 0.
           05  WS-D-MASTERED           PIC X     VALUE "N".
           05  WS-D-LINE-OK            PIC X     VALUE "N".
           05  WS-D-RAW-IN             PIC X(80) VALUE SPACES.
           05  WS-D-UP-IN              PIC X(80) VALUE SPACES.
           05  WS-D-POST-CHOICE        PIC X(16) VALUE SPACES.
           05  WS-D-LEN                PIC 99    VALUE 0.
           05  WS-D-LAST-CH            PIC X     VALUE SPACE.
           05  WS-TALLY-A              PIC 99    VALUE 0.
           05  WS-TALLY-B              PIC 99    VALUE 0.
           05  WS-TALLY-Q1             PIC 99    VALUE 0.
           05  WS-TALLY-Q2             PIC 99    VALUE 0.
           05  WS-TALLY-EQ             PIC 99    VALUE 0.
           05  WS-POS-1                PIC 99    VALUE 0.
           05  WS-POS-2                PIC 99    VALUE 0.
           05  WS-POS-3                PIC 99    VALUE 0.
           05  WS-TOK-LEN              PIC 99    VALUE 0.
