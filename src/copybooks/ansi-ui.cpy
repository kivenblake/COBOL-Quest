*> ===================================================================
*> COPYBOOK: ansi-ui.cpy
*> PURPOSE : ANSI terminal styling tokens (IBM 3270 phosphor palette)
*>           with clean toggle support for plain-ASCII terminals.
*> ===================================================================

       01  WS-ESC                      PIC X     VALUE X"1B".

       01  WS-ANSI-PALETTE.
           05  C-RST                   PIC X(4)  VALUE SPACES.
           05  C-GRN                   PIC X(7)  VALUE SPACES.
           05  C-CYN                   PIC X(7)  VALUE SPACES.
           05  C-YLW                   PIC X(7)  VALUE SPACES.
           05  C-RED                   PIC X(7)  VALUE SPACES.
           05  C-MAG                   PIC X(7)  VALUE SPACES.
           05  C-WHT                   PIC X(7)  VALUE SPACES.
           05  C-DIM                   PIC X(7)  VALUE SPACES.
           05  C-BLU                   PIC X(7)  VALUE SPACES.
           05  C-CLS                   PIC X(7)  VALUE SPACES.
