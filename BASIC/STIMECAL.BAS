10       REM  PROGRAM TO COMPUTE VCA/VCF SUSTAIN TIME VALUES.
20       REM  BASICALLY SAME PROGRAM AS FTIMECAL.BAS - PROVIDES OUTPUT 
30       REM  EQUIVALENT TO THE "# OF UPDATES" COLUMN IN COMMENTS FIELD.
40       REM  RESULTS SENT TO SCREEN AND EITHER: COM1 OR FILE (SUSTIMES).
50       REM  RESULTS ARE GIVEN DIRECTLY IN 68000 SOURCE FORMAT.
60       REM  COMPUTES SUSTAIN TIMES FOR EACH OF RATE SETTINGS 1-99.
70        REM  SETTING 0 VALUE IS GENERATED WITHOUT COMPUTATION.
80       REM  SETTING -1 (GATE) IS HANDLED WITHOUT REFERENCE TO TABLE AT ALL.
90       REM  USES PARABOLIC DISTRIBUTION OF SUSTAIN TIMES,
100       REM  ALLOWING CONTROL OVER THE SHAPE OF THE DISTRIBUTION CURVE.
110       REM  IN 440, SUSTAIN TIME COUNT IS DECREMENTED AT EACH UPDATE TIME,
120       REM  SUSTAIN ENDS WHEN COUNT UNDERFLOWS.
130      REM
140      PRINT "Transmit results over COM1?" 
150      INPUT " ( 0 = no, 1 = yes) ... : ",TRANS% 
160      IF TRANS% THEN OPEN "COM1:9600,N,8" AS #1 ELSE OPEN "O",#1,"SUSTIMES"
170      IF TRANS%=0 THEN PRINT "Results will be saved in file SUSTIMES -"
180      INPUT "Enter the time for maximum sustain (seconds): ",MAXTIME#
190      MAXUPDATES# = MAXTIME#/8.000001E-03 
200      REM
210      REM   parabolic exponent constant:
220      PRINT "Specify nonlinearity of time distribution curve"
230      INPUT "(default = 3.000): ",K#
240      IF K# = 0 THEN K# = 3!
250      REM
260      PRINT ";"
270      PRINT "; (table computed using nonlinearity coefficient ";
280      PRINT USING "#.###";K#;
290      PRINT ")"
300      PRINT ";"
310      PRINT #1,";"
320      PRINT #1,"; (table computed using nonlinearity coefficient ";
330      PRINT #1,USING "#.###";K#;
340      PRINT #1,")"
350      PRINT #1,";"
360      REM
370      REM  insert zero-setting entry for sustain-time table:
380     PRINT "             DC.W        0           ;  0     0.00"
390     PRINT #1,"               DC.W        0           ;  0     0.00"
400      REM
410     FOR TIMESETTING% = 1 TO 99
420      REM  this is the parabolic distribution algorithm:
430      NUMOFUPDATES# = 1 + ((TIMESETTING%/99)^K#)*(MAXUPDATES#-1)
440      REM
450     FULLTIME# = NUMOFUPDATES#*8.000001E-03
460     PRINT "             DC.W    ";
470     PRINT USING "#####           ";NUMOFUPDATES#;
480     PRINT "; ";
490     PRINT USING "##   ";TIMESETTING%; 
500     PRINT USING "###.##  ";FULLTIME#
510     PRINT #1,"               DC.W    ";
520     PRINT #1,USING "#####           ";NUMOFUPDATES#;
530     PRINT #1,"; ";
540     PRINT #1,USING "##   ";TIMESETTING%; 
550     PRINT #1,USING "###.##  ";FULLTIME#
560     NEXT TIMESETTING%
570     CLOSE #1
