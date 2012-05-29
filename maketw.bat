@ECHO OFF
echo MAKETW: started
echo - - - - - - - - - - - - - - -
call setenv %1
echo SETENV: set build environment for '%RELEASE%'
echo - - - - - - - - - - - - - - -
call pull %RELEASE%
echo - - - - - - - - - - - - - - -
call bld  %RELEASE%
echo - - - - - - - - - - - - - - -
call test %RELEASE% %2
echo - - - - - - - - - - - - - - -
call upload %RELEASE%
echo - - - - - - - - - - - - - - -
echo MAKETW: done
pause