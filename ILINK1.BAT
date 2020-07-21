echo off
echo Transferring object files to drive D: ....
copy O\SEQCHASE.O d:O
copy O\SWITCHBO.O d:O
copy O\FOOTSWBO.O d:O
copy O\FOOTPADS.O d:O
copy O\TRIGRBOY.O d:O
copy O\SYS_EX.O   d:O
copy O\SNDFUNS1.O d:O
copy O\SNDFUNS2.O d:O
copy O\SNDFUNS3.O d:O
copy O\SEQFUNS1.O d:O
copy O\SEQFUNS2.O d:O
copy O\SEQFUNS3.O d:O
echo Linking ....
\uni\linker -r -F INTLIST1 -o d:INTREG1.O -k
if errorlevel == 1 goto :not_linked
echo Link is complete
goto :cleanup
:not_linked
echo Yo - the link didn't, quite ....
:cleanup
echo Cleaning up drive D: ....
copy d:INTREG1.O c:O
del d:INTREG1.O
del d:O\SEQCHASE.O
del d:O\SWITCHBO.O
del d:O\FOOTSWBO.O
del d:O\FOOTPADS.O
del d:O\TRIGRBOY.O
del d:O\SYS_EX.O
del d:O\SNDFUNS1.O
del d:O\SNDFUNS2.O
del d:O\SNDFUNS3.O
del d:O\SEQFUNS1.O
del d:O\SEQFUNS2.O
del d:O\SEQFUNS3.O
