10       REM  PROGRAM TO COMPUTE PAD VELOCITY LOOKUP TABLES.
20       REM  RESULTS SENT TO SCREEN AND EITHER: COM1 OR FILE (VELTABLE).
30       REM  RESULTS ARE GIVEN DIRECTLY IN 68000 SOURCE FORMAT.
40       REM  COMPUTES SCALING FACTORS FOR EACH OF VELOCITIES 1-127,  
50       REM  ASSUMING RAW PAD LEVEL SHIFTED RIGHT ONE BIT, AND NO ZERO RESULT.
60      PRINT "Transmit results over COM1?" 
70      INPUT " ( 0 = no, 1 = yes) ... : ",TRANS% 
80      IF TRANS% THEN OPEN "COM1:9600,N,8" AS #1 ELSE OPEN "O",#1,"VELTABLE"
90      IF TRANS%=0 THEN PRINT "Results will be saved in file VELTABLE -"
100      PRINT
110      INPUT "Enter the curve exponent -  1.00000 = linear, etc. : ",CURVEXP#
120     PRINT ";"
130     PRINT "; (following table generated using exponent = ";
140     PRINT USING "##.###";CURVEXP#;
150     PRINT ")"
160     PRINT ";"
170     PRINT #1,";"
180     PRINT #1,"; (following table generated using exponent = ";
190     PRINT #1,USING "##.###";CURVEXP#;
200     PRINT #1,")"
210     PRINT #1,";"
220      REM 
230      REM  loop begins here:
240      REM
250     FOR VELOCITY = 1 TO 127
260     REM
270     REM do the comput here:
280     INTERNALVEL# = ((VELOCITY/127)^CURVEXP#)*31
290     IF INT(INTERNALVEL#) = 0 THEN INTERNALVEL# = 1
300     REM
310     REM output to screen:
320     PRINT "             DC.B    ";
330     PRINT USING "###             ";INTERNALVEL#;
340     PRINT "; ";
350     PRINT USING "###";VELOCITY
360     REM output to com1 or file:
370     PRINT #1,"               DC.B    ";
380     PRINT #1,USING "###             ";INTERNALVEL#;
390     PRINT #1,"; ";
400     PRINT #1,USING "###";VELOCITY
410     NEXT VELOCITY
420     CLOSE #1
