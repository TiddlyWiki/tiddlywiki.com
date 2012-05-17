@ECHO OFF

SET RELEASE=%1
IF [%1]==[] SET RELEASE=2.6.6a
SET DEST=%CD%\cooked\%RELEASE%

REM CHOOSE *ONE* OF THE FOLLOWING FILE COMPARISON PROGRAMS,
REM OR INSTALL YOUR OWN PREFERRED PROGRAM

REM WINDIFF:
SET DIFF="C:\Program Files\WinDiff\WinDiff.exe"
REM DOWNLOAD/INSTALL from http://www.grigsoft.com/download-windiff.htm

REM EXAMDIFF:
SET DIFF="C:\Program Files\ExamDiff\ExamDiff.exe"
REM DOWNLOAD/INSTALL from http://www.prestosoft.com/edp_examdiff.asp

if EXIST test\index.html goto diff
choice /M "TEST: 'test\index.html' not found.  Download from TiddlyWiki.com?"
IF %ERRORLEVEL%==2 GOTO:eof
mkdir  test 2> NUL
echo TEST: getting current release from tiddlywiki.com
node ..\TW5\tiddlywiki.js --recipe test.recipe --savewiki test
:diff
echo TEST: running version comparison...
%DIFF% "%DEST%\index.html" test\index.html
echo TEST: done