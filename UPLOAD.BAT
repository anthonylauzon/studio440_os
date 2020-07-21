echo off

REM  09-May-90
REM  Use mpu_upld.exe to upload 440 absolute code to HP64000 via target MIDI.
REM
REM  Uploads selected portions of code.img:
REM
REM            0x64 thru 0xbb          - hardware interrupt autovectors
REM                                      and TRAP instruction vectors 0-14,
REM                                      since emulation monitor uses
REM                                      TRAP #15 as software breakpoint vector.
REM
REM            0x100 thru end          - all other code.
REM
REM  This permits other emulation monitor vectors to remain in place,
REM  especially the reset vector SP and PC values.
REM  Implicit in this is that the emulation monitor defines all of these
REM  other vectors, and that they are appropriate for emulation operation.
REM  The 440 program has been modified as of this date to have a fixed
REM  reset entry point of 0x100, thus making it unnecessary to explicitly
REM  transfer a reset entry point value to the HP for emulation upon
REM  each new upload - it can be started via a "run from 100H" command.

echo Uploading hardware interrupt autovectors and TRAP 0-14 vectors ....
\utils\mpu_upld code.img 0x64 0xbb
if errorlevel 1 goto :exit
echo Uploading code above 0x100 ....
\utils\mpu_upld code.img 0x100

:exit

