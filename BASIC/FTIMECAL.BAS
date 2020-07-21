10       REM  PROGRAM TO COMPUTE VCF RATE DELTAS FOR ATTACK/DECAY ENVELOPES.
20       REM  BASICALLY SAME PROGRAM AS FRATECAL.BAS, REARRANGED SO THAT
30       REM  HIGHER SETTINGS CORRESPOND TO LONGER TIMES (SLOWER RATES?)
40       REM  COMPUTES FACTORS FOR LINEAR ENVELOPES - ONLY ONE TYPE USEABLE,
50       REM  SINCE VCF INPUT RESPONDS EXPONENTIALLY TO CONTROL VOLTAGE.
60       REM  RESULTS SENT TO SCREEN AND EITHER: COM1 OR FILE (VCFTIMES).
70       REM  RESULTS ARE GIVEN DIRECTLY IN 68000 SOURCE FORMAT.
80       REM  COMPUTES RATE DELTAS FOR EACH OF RATE SETTINGS 1-98.
90       REM  YAH, WE STILL CALL 'EM RATES, EVEN THOUGH THEY'RE REALLY TIMES.
100       REM  AH WELL - WHAT THE FUCK CAN YA DO ....
110       REM  SETTINGS 0 AND 99 ARE SPECIAL CASES DONE W/O COMPUTATION.
120       REM  PREVIOUSLY ASSUMED ENVELOPE ENDPOINTS 0FFFH AND 0001H -
130       REM  NOW COMPUTES ON BASIS OF ENVELOPE ENDPOINTS 0FFFH AND 0030H,
140       REM  SINCE VCF BELOW 30H TENDS TO BE INAUDIBLE IN THE 440.
150       REM  ALSO PREVIOUSLY COMPUTED EXPONENTIAL DISTRIBUTION OF TIMES
160       REM  FOR EACH OF THE SETTINGS - NOW USES PARABOLIC DISTRIBUTION,
170       REM  ALLOWING CONTROL OVER THE SHAPE OF THE DISTRIBUTION CURVE.
180       REM  IN 440, RATE DELTA IS ADDED TO / SUBTRACTED FROM VCF LEVEL
190      REM  AT EACH UPDATE TIME.
200      REM
210      PRINT "Transmit results over COM1?" 
220      INPUT " ( 0 = no, 1 = yes) ... : ",TRANS% 
230      IF TRANS% THEN OPEN "COM1:9600,N,8" AS #1 ELSE OPEN "O",#1,"VCFTIMES"
240      IF TRANS%=0 THEN PRINT "Results will be saved in file VCFTIMES -"
250      INPUT "Enter the time for maximum attack/decay (seconds): ",MAXTIME#
260      MAXUPDATES# = MAXTIME#/8.000001E-03 
270      REM
280      REM      K# = (LOG(MAXUPDATES#)-LOG(2))/97
290      REM      (this was part of exponential distribution algorithm).
300      REM
310      REM   (following is replacement parabolic exponent constant:)
320      PRINT "Specify nonlinearity of time distribution curve"
330      INPUT "(default = 3.000): ",K#
340      IF K# = 0 THEN K# = 3!
350      REM
360      PRINT ";"
370      PRINT "; (table computed using nonlinearity coefficient ";
380      PRINT USING "#.###";K#;
390      PRINT ")"
400      PRINT ";"
410      PRINT #1,";"
420      PRINT #1,"; (table computed using nonlinearity coefficient ";
430      PRINT #1,USING "#.###";K#;
440      PRINT #1,")"
450      PRINT #1,";"
460      REM
470      REM  insert zero-setting entry for rate-delta table:
480     PRINT "             DC.W    65535           ;  0     0.00      1.0  FFF"
490     PRINT #1,"               DC.W    65535           ;  0     0.00      1.0  FFF"
500      REM
510     FOR TIMESETTING% = 1 TO 98
520      REM
530      REM  (following was other part of exponential algorithm:)
540      REM  NUMOFUPDATES# = 2*EXP(K#*(TIMESETTING%-1))
550      REM  (whereas this is the parabolic version:)
560      NUMOFUPDATES# = 2 + ((TIMESETTING%/98)^K#)*(MAXUPDATES#-2)
570      REM
580     FULLTIME# = NUMOFUPDATES#*8.000001E-03
590      REM  this is the 0FFFH - 0030H part right here:
600     UPDATEDELTA# = (65535!-48!)/NUMOFUPDATES#
610     SCALEDFACTOR# = INT(UPDATEDELTA#) 
620     PRINT "             DC.W    ";
630     PRINT USING "#####           ";SCALEDFACTOR#;
640     PRINT "; ";
650     PRINT USING "##   ";TIMESETTING%; 
660     PRINT USING "###.##  ";FULLTIME#;
670     PRINT USING "#####.#  ";NUMOFUPDATES#; 
680     PRINT HEX$(SCALEDFACTOR#/16)
690     PRINT #1,"               DC.W    ";
700     PRINT #1,USING "#####           ";SCALEDFACTOR#;
710     PRINT #1,"; ";
720     PRINT #1,USING "##   ";TIMESETTING%; 
730     PRINT #1,USING "###.##  ";FULLTIME#;
740     PRINT #1,USING "#####.#  ";NUMOFUPDATES#; 
750     PRINT #1,HEX$(SCALEDFACTOR#/16)
760     NEXT TIMESETTING% 
770      REM
780      REM  insert max-setting entry for rate-delta table:
790     PRINT "             DC.W        0           ; 99     INF.     INF.  0"
800     PRINT #1,"               DC.W        0           ; 99     INF.     INF.  0"
810      REM
820     CLOSE #1
