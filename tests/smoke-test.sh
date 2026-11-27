#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
WORK_DIR="$(mktemp -d)"
trap 'rm -rf "$WORK_DIR"' EXIT

echo "=== [1/4] Compiling COBOL QUEST v2.0 & 8 Examples ==="
mkdir -p "$WORK_DIR/bin"
cobc -x -Wall -I "$ROOT_DIR/src/copybooks" "$ROOT_DIR/src/cobol-quest.cob" -o "$WORK_DIR/bin/cobol-quest"

for src in "$ROOT_DIR"/examples/*.cob; do
  base="$(basename "$src" .cob)"
  cobc -x -Wall "$src" -o "$WORK_DIR/bin/$base"
done

echo "=== [2/4] Running Full Playthrough (All 8 Chapters + Variant Rotation + Labs) ==="
cat << 'EOF' | (cd "$WORK_DIR" && ./bin/cobol-quest >/dev/null)
GRACE-H

C
1
1

A

C
HINT
HINT
DISPLAY HELLO MAINFRAME.
DISPLAY "HELLO MAINFRAME"

DISPLAY "SYSTEM ONLINE".


PROGRAM-ID. VAULT.


2


A
*> DAILY BACKUP

DATA DIVISION.


3



B
01 USER-CITY PIC X(12).

01 BALANCE PIC S9(5)V99.


4


B
BALANCE = 500
MOVE BALANCE TO 500.

MOVE 25 TO TICKETS.

ACCEPT GUEST-NAME.


5


A
ADD INTEREST TO BALANCE ROUNDED.

COMPUTE GROSS-PAY ROUNDED = HOURS * RATE.


6


B
IF SCORE = 100 DISPLAY "PERFECT" END-IF.

88 VIP-CLIENT VALUE "Y".


7


A
PERFORM PRINT-LINE 5 TIMES.

PERFORM READ-NEXT UNTIL FILE-DONE.


8


B
05 MONTH-SALES PIC 9(6) OCCURS 12 TIMES.

OPEN INPUT PAYROLL-FILE.

CLOSE PAYROLL-FILE.


B
2
-1234.56

B
3
AUTOBANK
1500.00
5.00
3

4
B
A
B
A

5
0

1

2

3

4

B
6

Q
EOF

echo "=== [3/4] Verifying COBOL Save File (8/8 Mastered) & Generated my_sandbox.cob ==="
grep -q "COBQUEST01GRACE-H" "$WORK_DIR/savegame.dat"
grep -q "YYYYYYYY" "$WORK_DIR/savegame.dat"
cobc -x -Wall "$WORK_DIR/my_sandbox.cob" -o "$WORK_DIR/bin/my_sandbox"
"$WORK_DIR/bin/my_sandbox" | grep -q "Year 03:"

echo "=== [4/4] Running All 8 Companion Example Binaries ==="
for bin_file in "$WORK_DIR"/bin/0*; do
  (cd "$ROOT_DIR/examples" && "$bin_file" >/dev/null)
done

echo "ALL SMOKE TESTS PASSED!"
