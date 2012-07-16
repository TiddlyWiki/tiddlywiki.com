@ECHO OFF

REM *** LOCAL TARGET PATHS and FILES
IF [%RELEASE%]==[] SET RELEASE=%1
IF [%RELEASE%]==[] SET RELEASE=2.6.6a
IF [%PULLED%]==[]  SET PULLED=%CD%\pulled
IF [%DEST%]==[]    SET DEST=%CD%\cooked\%RELEASE%
if [%TEST%]==[]    SET TEST=%CD%\test\index.html
if NOT [%2]==[]    SET TEST=%CD%\test\index.%2.html
REM if [%TW5%]==[]     SET TW5=..\TiddlyWiki5\archive\tiddlywiki.js
if [%TW5%]==[]     SET TW5=..\TiddlyWiki5\core\boot.js

REM *** REMOTE TARGET FOLDERS, FILES, and UPLOAD PARAMS
SET REMOTE_USER=tiddlywiki
SET HOST=tiddlywiki.com
SET DIR=/var/www/www.tiddlywiki.com/htdocs
SET ARCHIVE_DIR=%DIR%/archive
SET OWNER=www-data:www-data
SET PERM=664
SET UPLOADLIST=%DEST%/index.html %DEST%/index.xml %DEST%/empty.html %DEST%/TiddlySaver.jar %DEST%/empty.zip

REM *** LOCAL UTILITY APPLICATIONS

REM *** CURL (for PULL.BAT)
REM http://curl.haxx.se/download.html
SET CURL="C:\Program Files\Curl\curl.exe"

REM *** FILE COMPARISON (for TEST.BAT)
REM *** SELECT ONE OF THE FOLLOWING, OR INSTALL/CONFIGURE YOUR OWN PREFERRED PROGRAM
REM http://www.grigsoft.com/download-windiff.htm
REM SET DIFF="C:\Program Files\WinDiff\WinDiff.exe"
REM http://www.prestosoft.com/edp_examdiff.asp
SET DIFF="C:\Program Files\ExamDiff\ExamDiff.exe"

REM *** SECURE SHELL / SECURE COPY (for UPLOAD.BAT)
REM http://winscp.net/eng/download.php
SET SCP=REM (disabled) "C:\Program Files\WinSCP\WinSCP.exe" "scp://%REMOTE_USER%@%HOST%"