10       REM  PROGRAM TO COMPUTE VCA RATE FACTORS FOR EXPONENTIAL ENVELOPES.
20       REM  BASICALLY SAME PROGRAM AS ARATECAL.BAS, REARRANGED SO THAT
30       REM  HIGHER SETTINGS CORRESPOND TO LONGER TIMES (SLOWER RATES?)
40       REM  COMPUTES FACTORS FOR GROWING OR DECAYING EXPONENTIAL ENVELOPES.
50       REM  RESULTS SENT TO SCREEN AND EITHER: COM1 OR FILE (VCATIMES).
60       REM  RESULTS ARE GIVEN DIRECTLY IN 68000 SOURCE FORMAT.
70       REM  COMPUTES SCALING FACTORS FOR EACH OF RATE SETTINGS 1-98.
80       REM  YAH, WE STILL CALL 'EM RATES, EVEN THOUGH THEY'RE REALLY TIMES.
90       REM  AH WELL - WHAT THE FUCK CAN YA DO ....
100       REM  SETTINGS 0 AND 99 ARE SPECIAL CASES DONE W/O COMPUTATION.
110       REM  PREVIOUSLY ASSUMED ENVELOPE ENDPOINTS 0FFFH AND 0001H -
120       REM  NOW COMPUTES ON BASIS OF ENVELOPE ENDPOINTS 0FFFH AND 0030H,
130       REM  SINCE VCA BELOW 30H TENDS TO BE INAUDIBLE IN THE 440.
140       REM  ALSO PREVIOUSLY COMPUTED EXPONENTIAL DISTRIBUTION OF TIMES
150       REM  FOR EACH OF THE SETTINGS - NOW USES PARABOLIC DISTRIBUTION,
160       REM  ALLOWING CONTROL OVER THE SHAPE OF THE DISTRIBUTION CURVE.
170       REM  IN 440, VCA LEVEL IS SCALED BY RATE FACTOR AT EACH UPDATE TIME.
180      PRINT "Transmit results over COM1?" 
190      INPUT " ( 0 = no, 1 = yes) ... : ",TRANS% 
200      IF TRANS% THEN OPEN "COM1:9600,N,8" AS #1 ELSE OPEN "O",#1,"VCATIMES"
210      IF TRANS%=0 THEN PRINT "Results will be saved in file VCATIMES -"
220      INPUT "Enter the time for maximum attack/decay (seconds): ",MAXTIME#
230      MAXUPDATES# = MAXTIME#/8.000001E-03 
240      REM
250      REM      K# = (LOG(MAXUPDATES#)-LOG(2))/97
260      REM      (this was part of exponential distribution algorithm).
270      REM
280      REM   (following is replacement parabolic exponent constant:)
290      PRINT "Specify nonlinearity of time distribution curve"
300      INPUT "(default = 3.000): ",K#
310      IF K# = 0 THEN K# = 3!
320      REM
330      REM  (Z# embodies ratio of envelope endpoints:)
340      REM  (following was used for 0FFFH - 0001H endpoints:)
350      REM  Z# = LOG(4096)
360      REM  (following is used for 0FFFH - 0030H endpoints:)
370      Z# = LOG(4096/48)
380      REM
390      PRINT "Specify type of envelope curve -"
400      PRINT " 0 = decaying (negative) exponential"
410     PRINT " 1 = growing (positive) exponential" 
420     INPUT " -------->  : ",CURVETYPE
430     IF CURVETYPE<>1 THEN CURVETYPE = -1 
440     Z# = CURVETYPE*Z# 
450      PRINT ";"
460      PRINT "; (table computed using nonlinearity coefficient ";
470      PRINT USING "#.###";K#;
480      PRINT ")"
490      PRINT ";"
500      PRINT #1,";"
510      PRINT #1,"; (table computed using nonlinearity coefficient ";
520      PRINT #1,USING "#.###";K#;
530      PRINT #1,")"
540      PRINT #1,";"
550      REM
560      IF CURVETYPE = 1 THEN GOTO 620
570      REM  insert zero-setting entry for exponential-decay table:
580     PRINT "             DC.L    0000000000      ;  0    0.00       1.0    0.0000000000"
590     PRINT #1,"               DC.L    0000000000      ;  0    0.00       1.0    0.0000000000"
600      GOTO 660
610      REM
620      REM  insert zero-setting entry for exponential-growth table:
630      PRINT "             DC.L    0FFFFFFFFH      ;  0    0.00       1.0    65535.999999"
640      PRINT #1,"               DC.L    0FFFFFFFFH      ;  0    0.00       1.0    65535.999999"
650      REM
660     FOR TIMESETTING% = 1 TO 98
670      REM
680      REM  (following was other part of exponential algorithm:)
690      REM  NUMOFUPDATES# = 2*EXP(K#*(TIMESETTING%-1))
700      REM  (whereas this is the parabolic version:)
710      NUMOFUPDATES# = 2 + ((TIMESETTING%/98)^K#)*(MAXUPDATES#-2)
720      REM
730     FULLTIME# = NUMOFUPDATES#*8.000001E-03
740     UPDATEFACTOR# = EXP(Z#/NUMOFUPDATES#)
750     IF CURVETYPE=1 THEN GOTO 780
760     SCALEDFACTOR# = INT(UPDATEFACTOR#*65536#*65536#)  
770     GOTO 790
780     SCALEDFACTOR# = INT((UPDATEFACTOR#*65536#)+.5) 
790     PRINT "             DC.L    ";
800     PRINT USING "##########      ";SCALEDFACTOR#;
810     PRINT "; ";
820     PRINT USING "##  ";TIMESETTING%; 
830     PRINT USING "###.##   ";FULLTIME#;
840     PRINT USING "#####.#   ";NUMOFUPDATES#; 
850     PRINT USING "##.##########";UPDATEFACTOR#
860     PRINT #1,"               DC.L    ";
870     PRINT #1,USING "##########      ";SCALEDFACTOR#;
880     PRINT #1,"; ";
890     PRINT #1,USING "##  ";TIMESETTING%; 
900     PRINT #1,USING "###.##   ";FULLTIME#;
910     PRINT #1,USING "#####.#   ";NUMOFUPDATES#; 
920     PRINT #1,USING "##.##########";UPDATEFACTOR#
930     NEXT TIMESETTING% 
940      REM
950      IF CURVETYPE = 1 THEN GOTO 1010
960      REM  insert max-setting entry for exponential-decay table:
970      PRINT "             DC.L    0FFFFFFFFH      ; 99   ~INF.  ??(HUGE)    0.99999999999999999999999999....."
980      PRINT #1,"               DC.L    0FFFFFFFFH      ; 99   ~INF.  ??(HUGE)    0.99999999999999999999999999....."
990      GOTO 1050
1000      REM
1010      REM  insert max-setting entry for exponential-growth table:
1020      PRINT "             DC.L         65536      ; 99    INF.     INF.     1.0000000000"
1030      PRINT #1,"               DC.L         65536      ; 99    INF.     INF.     1.0000000000"
1040      REM
1050     CLOSE #1
