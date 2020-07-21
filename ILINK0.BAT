echo off
echo Transferring object files to drive D: ....
copy O\PRIORITY.O d:O
copy O\NON_PRIO.O d:O
copy O\LEVEL2.O   d:O
copy O\REALTIME.O d:O
copy O\LEVEL4.O   d:O
copy O\LEVEL5.O   d:O
copy O\LEVEL6.O   d:O
copy O\VINITMAI.O d:O
copy O\VINITSUB.O d:O
copy O\ASSIGN.O   d:O
copy O\PRO_CLIC.O d:O
copy O\SEQSUBS.O  d:O
copy O\PERF_MID.O d:O
copy O\SEQ_MIDI.O d:O
copy O\AUTO_MID.O d:O
copy O\PRO_PADS.O d:O
copy O\PRO_TC.O   d:O
copy O\PRO_MTC.O  d:O
copy O\BACKGROU.O d:O
copy O\SAMSUBS.O  d:O
copy O\TRANSPOR.O d:O
echo Linking ....
\uni\linker -r -F INTLIST0 -o d:INTREG0.O -k
if errorlevel == 1 goto :not_linked
echo Link is complete
goto :cleanup
:not_linked
echo Yo - the link didn't, quite ....
:cleanup
echo Cleaning up drive D: ....
copy d:INTREG0.O c:O
del d:INTREG0.O
del d:O\PRIORITY.O
del d:O\NON_PRIO.O
del d:O\LEVEL2.O
del d:O\REALTIME.O
del d:O\LEVEL4.O
del d:O\LEVEL5.O
del d:O\LEVEL6.O
del d:O\VINITMAI.O
del d:O\VINITSUB.O
del d:O\ASSIGN.O
del d:O\PRO_CLIC.O
del d:O\SEQSUBS.O
del d:O\PERF_MID.O
del d:O\SEQ_MIDI.O
del d:O\AUTO_MID.O
del d:O\PRO_PADS.O
del d:O\PRO_TC.O
del d:O\PRO_MTC.O
del d:O\BACKGROU.O
del d:O\SAMSUBS.O
del d:O\TRANSPOR.O
