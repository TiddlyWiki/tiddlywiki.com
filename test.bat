@ECHO OFF

SET RELEASE=%1
IF [%1]==[] goto usage
SET DEST=%CD%\cooked\%RELEASE%\index.html
SET TARGET=%CD%\test\index.html
IF NOT [%2]==[] SET TARGET=%CD%\test\index.%2.html

REM DOWNLOAD *ONE* OF THE FOLLOWING FILE COMPARISON PROGRAMS,
REM OR INSTALL YOUR OWN PREFERRED PROGRAM
REM *** WINDIFF (http://www.grigsoft.com/download-windiff.htm)
SET DIFF="C:\Program Files\WinDiff\WinDiff.exe"
REM *** EXAMDIFF (http://www.prestosoft.com/edp_examdiff.asp)
SET DIFF="C:\Program Files\ExamDiff\ExamDiff.exe"

if EXIST %TARGET% goto diff
echo TEST: %TARGET% not found.
GOTO:eof

:diff
echo TEST: running version comparison...
echo TEST: new=%DEST%
echo TEST: old=%TARGET%
%DIFF% "%DEST%" "%TARGET%"

echo TEST: done
goto:eof

:usage
echo USAGE: %0 {new release #} {old release #}