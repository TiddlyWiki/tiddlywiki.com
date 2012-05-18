@ECHO OFF
SET RELEASE=%1
IF [%RELEASE%]==[] SET RELEASE=2.6.6a
SET TW5=..\TiddlyWiki5\archive\tiddlywiki.js
echo MAKETW: started
echo - - - - - - - - - - - - - - -
call pull %RELEASE%
echo - - - - - - - - - - - - - - -
call bld  %RELEASE%
echo - - - - - - - - - - - - - - -
call test %RELEASE%
echo - - - - - - - - - - - - - - -
call upload %RELEASE%
echo - - - - - - - - - - - - - - -
echo MAKETW: done