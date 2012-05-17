@ECHO OFF
SET RELEASE=%1
IF [%1]==[] SET RELEASE=2.6.6a
echo MAKETW: started
echo - - - - - - - - - - - - - - -
call pull %RELEASE%
echo - - - - - - - - - - - - - - -
call bld.bat  %RELEASE%
echo - - - - - - - - - - - - - - -
call test.bat %RELEASE%
echo - - - - - - - - - - - - - - -
call upload.bat %RELEASE%
echo - - - - - - - - - - - - - - -
echo MAKETW: done