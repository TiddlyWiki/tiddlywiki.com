@ECHO OFF
echo MAKETW: started
echo - - - - - - - - - - - - - - -
call clearenv
call setenv %1
echo SETENV: set build environment for '%RELEASE%'
echo - - - - - - - - - - - - - - -
call pull %RELEASE%
echo - - - - - - - - - - - - - - -
call bld  %RELEASE%
echo - - - - - - - - - - - - - - -
call test %RELEASE% %2
echo - - - - - - - - - - - - - - -
echo MAKETW: done
pause