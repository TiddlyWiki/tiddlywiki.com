#!/bin/sh

echo MAKETW: started
echo - - - - - - - - - - - - - - -
./clearenv.sh
./setenv.sh ${1}
echo SETENV: set build environment for '$RELEASE'
echo - - - - - - - - - - - - - - -
./pull.sh $RELEASE
echo - - - - - - - - - - - - - - -
./bld.sh  $RELEASE
echo - - - - - - - - - - - - - - -
./test.sh $RELEASE ${2}
echo - - - - - - - - - - - - - - -
echo MAKETW: done
pause
