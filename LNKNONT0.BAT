echo off
del d:*.O
del d:O\*.O
echo Linking ....
\uni\linker -f LINK.SPC -F NONT0LST -o NONT0.OUT -E NONT0ERR.LST -k
if errorlevel == 1 goto :not_linked
echo Link is complete
goto :cleanup
:not_linked
echo Yo - the link didn't, quite ....
:cleanup
