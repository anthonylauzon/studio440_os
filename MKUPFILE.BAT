echo off

REM  Make image file code.img from absolute file code.out.
REM  Also generate Intel Hex symbols-only file as symbol listing.
REM  Uses RAM disk (drive e:) for speed.

echo Transferring abs file to RAM disk ....
copy code.out e:
echo Creating upload file code.img ....
down e:code.out -d image -o e:code.img
echo Creating symbol listing file code.sym ....
down e:code.out -d ihex -o e:code.sym -lg -w 0w,0k
echo Upload files created - cleaning up ....
copy e:code.*
del  e:code.*
echo mkupfile complete

