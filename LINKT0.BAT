echo off
echo Transferring object files to drive D: ....
del d:*.O
del d:O\*.O
copy O\LCD.O      d:O
copy O\GUIDO.O    d:O
copy O\FIELDS.O   d:O
copy O\MISCSUBS.O d:O
copy O\DISKLOW1.O d:O
copy O\DISKLOW2.O d:O
copy O\DISKLOW3.O d:O
copy O\DISKCMD1.O d:O
copy O\DISKCMD2.O d:O
copy O\DISKMAIN.O d:O
copy O\GNRCSCSI.O d:O
copy O\SCSICMDS.O d:O
copy O\RAM_440.O  d:O
copy O\CODECAPP.O d:O
echo Linking ....
\uni\linker -f LINKT0.SPC -F T0LIST -o d:TRAPREG0.OUT -E LNKT0ERR.LST -k
if errorlevel == 1 goto :not_linked
echo Link is complete
goto :cleanup
:not_linked
echo Yo - the link didn't, quite ....
:cleanup
echo Cleaning up drive D: ....
copy d:TRAPREG0.OUT c:
del d:*.OUT
del d:O\*.O
