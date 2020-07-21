echo off
REM  Wherein we PKARC everything!

echo Deleting \BACKUP\440?????.*
del \backup\440?????.*

REM
REM  REM  Sources will not fit on single floppy if packed into single file:
REM  echo Creating \BACKUP\440SRC1.ARC ....
REM  \comm\pkarc -a \BACKUP\440SRC1.ARC A*.* B*.* C*.* D*.* E*.* F*.*
REM  \comm\pkarc -a \BACKUP\440SRC1.ARC G*.* H*.* I*.* K*.* L*.* M*.*
REM  \comm\pkarc -a \BACKUP\440SRC1.ARC N*.* O*.* P*.* Q*.* R*.*
REM  echo Creating \BACKUP\440SRC2.ARC ....
REM  \comm\pkarc -a \BACKUP\440SRC2.ARC S*.* T*.* U*.* V*.*
REM


pkarc -a \BACKUP\440SRC_A.ARC A*.*
pkarc -a \BACKUP\440SRC_B.ARC B*.*
pkarc -a \BACKUP\440SRC_C.ARC C*.*
pkarc -a \BACKUP\440SRC_D.ARC D*.*
pkarc -a \BACKUP\440SRC_E.ARC E*.*
pkarc -a \BACKUP\440SRC_F.ARC F*.*
pkarc -a \BACKUP\440SRC_G.ARC G*.*
pkarc -a \BACKUP\440SRC_H.ARC H*.*
pkarc -a \BACKUP\440SRC_I.ARC I*.*
pkarc -a \BACKUP\440SRC_J.ARC J*.*
pkarc -a \BACKUP\440SRC_K.ARC K*.*
pkarc -a \BACKUP\440SRC_L.ARC L*.*
pkarc -a \BACKUP\440SRC_M.ARC M*.*
pkarc -a \BACKUP\440SRC_N.ARC N*.*
pkarc -a \BACKUP\440SRC_O.ARC O*.*
pkarc -a \BACKUP\440SRC_P.ARC P*.*
pkarc -a \BACKUP\440SRC_Q.ARC Q*.*
pkarc -a \BACKUP\440SRC_R.ARC R*.*
pkarc -a \BACKUP\440SRC_S.ARC S*.*
pkarc -a \BACKUP\440SRC_T.ARC T*.*
pkarc -a \BACKUP\440SRC_U.ARC U*.*
pkarc -a \BACKUP\440SRC_V.ARC V*.*
pkarc -a \BACKUP\440SRC_W.ARC W*.*
pkarc -a \BACKUP\440SRC_X.ARC X*.*
pkarc -a \BACKUP\440SRC_Y.ARC Y*.*
pkarc -a \BACKUP\440SRC_Z.ARC Z*.*


REM  Obj modules take a long time to build, too:
echo Creating \BACKUP\440OBJ.ARC ....
pkarc -a \BACKUP\440OBJ.ARC O\*.O

echo And the results are:
dir \backup

REM
REM  REM  PKARC stops cold if any provided file spec yields no files on search.
REM  REM  As security, any which are not included above are checked for here,
REM  REM  to draw attention to files which may not be getting backed up.
REM  if exist J*.* echo Warning!!!  Files J*.* found, not included in PKARC list!
REM  if exist W*.* echo Warning!!!  Files W*.* found, not included in PKARC list!
REM  if exist X*.* echo Warning!!!  Files X*.* found, not included in PKARC list!
REM  if exist Y*.* echo Warning!!!  Files Y*.* found, not included in PKARC list!
REM  if exist Z*.* echo Warning!!!  Files Z*.* found, not included in PKARC list!
REM
