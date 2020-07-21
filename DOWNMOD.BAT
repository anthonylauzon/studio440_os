echo off
REM  Create an IHX download of specific portion of code.out.
REM  Portion is specified by address, based on full link map.
REM  No address translation - load address set same as start address.
REM  Useful only when no global symbol values have changed,
REM  and when size of loaded region has not enlarged.


echo Creating download file %1.ihx ....
copy code.out e:
down e:code.out -d ihex -o e:%1.ihx -w 0x%2,0x%3,0x%2
copy e:%1.ihx
echo Download file created
del  e:code.*
del  e:%1.*

