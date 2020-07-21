echo off
echo Transferring object files to drive D: ....
copy O\BLOOZE.O   d:O
copy O\DISKLOW1.O d:O
copy O\DISKLOW2.O d:O
copy O\DISKLOW3.O d:O
copy O\DISKCMD1.O d:O
copy O\DISKCMD2.O d:O
copy O\DISKMAIN.O d:O
copy O\GNRCSCSI.O d:O
copy O\SCSICMDS.O d:O
copy O\TABLES.O   d:O
copy O\PHASES.O   d:O
copy O\TUNE_TAB.O d:O
copy O\ROMVECS.O  d:O
copy O\DIAG440.O  d:O
copy O\SOFTDIAG.O d:O
echo Linking ....
\uni\linker -r -F INTLIST3 -o d:INTREG3.O -k
if errorlevel == 1 goto :not_linked
echo Link is complete
goto :cleanup
:not_linked
echo Yo - the link didn't, quite ....
:cleanup
echo Cleaning up drive D: ....
copy d:INTREG3.O c:O
del d:INTREG3.O
del d:O\BLOOZE.O
del d:O\DISKLOW1.O
del d:O\DISKLOW2.O
del d:O\DISKLOW3.O
del d:O\DISKCMD1.O
del d:O\DISKCMD2.O
del d:O\DISKMAIN.O
del d:O\GNRCSCSI.O
del d:O\SCSICMDS.O
del d:O\TABLES.O
del d:O\PHASES.O
del d:O\TUNE_TAB.O
del d:O\ROMVECS.O
del d:O\DIAG440.O
del d:O\SOFTDIAG.O
