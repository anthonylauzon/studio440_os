echo off
del ASMERROR.LST

\utils\stripasm RESET_44 d:RESET_44
echo Assembling RESET_44 ....
\uni\as68000 d:RESET_44 -o d:O\RESET_44.O -E +ASMERROR.LST
spacemrk RESET_44
copy ASMERROR.LST + SPACE
del d:RESET_44
copy d:O\RESET_44.O O
del d:O\RESET_44.O

\utils\stripasm BACKGROU d:BACKGROU
echo Assembling BACKGROU ....
\uni\as68000 d:BACKGROU -o d:O\BACKGROU.O -E +ASMERROR.LST
spacemrk BACKGROU
copy ASMERROR.LST + SPACE
del d:BACKGROU
copy d:O\BACKGROU.O O
del d:O\BACKGROU.O

\utils\stripasm SYSFUNS1 d:SYSFUNS1
echo Assembling SYSFUNS1 ....
\uni\as68000 d:SYSFUNS1 -o d:O\SYSFUNS1.O -E +ASMERROR.LST
spacemrk SYSFUNS1
copy ASMERROR.LST + SPACE
del d:SYSFUNS1
copy d:O\SYSFUNS1.O O
del d:O\SYSFUNS1.O

\utils\stripasm SYSFUNS2 d:SYSFUNS2
echo Assembling SYSFUNS2 ....
\uni\as68000 d:SYSFUNS2 -o d:O\SYSFUNS2.O -E +ASMERROR.LST
spacemrk SYSFUNS2
copy ASMERROR.LST + SPACE
del d:SYSFUNS2
copy d:O\SYSFUNS2.O O
del d:O\SYSFUNS2.O

\utils\stripasm SYSEXCL d:SYSEXCL
echo Assembling SYSEXCL ....
\uni\as68000 d:SYSEXCL -o d:O\SYSEXCL.O -E +ASMERROR.LST
spacemrk SYSEXCL
copy ASMERROR.LST + SPACE
del d:SYSEXCL
copy d:O\SYSEXCL.O O
del d:O\SYSEXCL.O

\utils\stripasm BRANCHES d:BRANCHES
echo Assembling BRANCHES ....
\uni\as68000 d:BRANCHES -o d:O\BRANCHES.O -E +ASMERROR.LST
spacemrk BRANCHES
copy ASMERROR.LST + SPACE
del d:BRANCHES
copy d:O\BRANCHES.O O
del d:O\BRANCHES.O

\utils\stripasm DISKMAIN d:DISKMAIN
echo Assembling DISKMAIN ....
\uni\as68000 d:DISKMAIN -o d:O\DISKMAIN.O -E +ASMERROR.LST
spacemrk DISKMAIN
copy ASMERROR.LST + SPACE
del d:DISKMAIN
copy d:O\DISKMAIN.O O
del d:O\DISKMAIN.O
