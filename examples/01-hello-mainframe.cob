000100*=================================================================
000200* EXAMPLE 01: AUTHENTIC 1960s PUNCH-CARD FIXED-FORMAT COBOL!
000300*-----------------------------------------------------------------
000400* Columns 01-06 : Sequence Numbers (kept punch cards in order!)
000500* Column  07    : '*' means Comment Line
000600* Columns 08-11 : Area A (Division, Section, Paragraph, 01 levels)
000700* Columns 12-72 : Area B (Statements: DISPLAY, MOVE, STOP RUN)
000800*=================================================================
000900 IDENTIFICATION DIVISION.
001000 PROGRAM-ID. HELLO-MAINFRAME.
001100
001200 DATA DIVISION.
001300 WORKING-STORAGE SECTION.
001400 01  WS-GREETING         PIC X(38)
001500     VALUE "HELLO FROM CLASSIC 80-COLUMN BIG IRON!".
001600 01  WS-YEAR-INVENTED    PIC 9(4) VALUE 1959.
001700
001800 PROCEDURE DIVISION.
001900 0000-MAIN.
002000     DISPLAY "==============================================".
002100     DISPLAY WS-GREETING.
002200     DISPLAY "COBOL was born in: " WS-YEAR-INVENTED.
002300     DISPLAY "==============================================".
002400     STOP RUN.
