@ECHO OFF

REM *** LOCAL TARGET PATHS and FILES
IF [%TIDDLYWIKI_RELEASE%]==[]	SET TIDDLYWIKI_RELEASE=%1
IF [%TIDDLYWIKI_RELEASE%]==[]	SET TIDDLYWIKI_RELEASE=2.7.2
IF [%TIDDLYWIKI_PULLED%]==[]	SET TIDDLYWIKI_PULLED=%CD%\pulled
IF [%TIDDLYWIKI_DEST%]==[]		SET TIDDLYWIKI_DEST=%CD%\cooked\%TIDDLYWIKI_RELEASE%
if [%TIDDLYWIKI_TEST%]==[]		SET TIDDLYWIKI_TEST=%CD%\test\index.html
if NOT [%2]==[]    			SET TIDDLYWIKI_TEST=%CD%\test\index.%2.html
if [%TIDDLYWIKI5_DIR%]==[]		SET TIDDLYWIKI5_DIR=%CD%\..\..\jermolene\tiddlywiki5

REM *** LOCAL UTILITY APPLICATIONS

REM *** CURL (for PULL.BAT)
REM http://curl.haxx.se/download.html
SET CURL="C:\Program Files\Curl\curl.exe"

REM *** BROWSER (for BLD.BAT)
REM SET BROWSER="C:\Program Files (x86)\Mozilla Firefox\firefox.exe"
SET BROWSER="C:\Program Files (x86)\phantomjs\phantomjs.exe"

REM *** FILE COMPARISON (for TEST.BAT)
REM *** SELECT ONE OF THE FOLLOWING, OR INSTALL/CONFIGURE YOUR OWN PREFERRED PROGRAM
REM http://www.grigsoft.com/download-windiff.htm
REM SET DIFF="C:\Program Files\WinDiff\WinDiff.exe"
REM http://www.prestosoft.com/edp_examdiff.asp
SET DIFF="C:\Program Files\ExamDiff\ExamDiff.exe"
