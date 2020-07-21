echo off
echo Transferring object files to drive D: ....
copy O\SEQFUNS4.O d:O
copy O\SONGFUNS.O d:O
copy O\SYSFUNS1.O d:O
copy O\SYSFUNS2.O d:O
copy O\SYSFUNS3.O d:O
copy O\SYSFUNS4.O d:O
copy O\SAMPLING.O d:O
copy O\KT_ALT_A.O d:O
copy O\MISCSUBS.O d:O
copy O\TEMPO.O    d:O
copy O\RESET_44.O d:O
copy O\LCD.O      d:O
copy O\GUIDO.O    d:O
copy O\FIELDS.O   d:O
echo Linking ....
\uni\linker -r -F INTLIST2 -o d:INTREG2.O -k
if errorlevel == 1 goto :not_linked
echo Link is complete
goto :cleanup
:not_linked
echo Yo - the link didn't, quite ....
:cleanup
echo Cleaning up drive D: ....
copy d:INTREG2.O c:O
del d:INTREG2.O
del d:O\SEQFUNS4.O
del d:O\SONGFUNS.O
del d:O\SYSFUNS1.O
del d:O\SYSFUNS2.O
del d:O\SYSFUNS3.O
del d:O\SYSFUNS4.O
del d:O\SAMPLING.O
del d:O\KT_ALT_A.O
del d:O\MISCSUBS.O
del d:O\TEMPO.O
del d:O\RESET_44.O
del d:O\LCD.O
del d:O\GUIDO.O
del d:O\FIELDS.O
