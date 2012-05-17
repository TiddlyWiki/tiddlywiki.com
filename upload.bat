@ECHO OFF
SET RELEASE=%1
IF [%1]==[] SET RELEASE=2.6.6a
SET DEST=%CD%\cooked\%RELEASE%

SET REMOTE_USER=eric
SET HOST=tiddlywiki.com
SET DIR=/var/www/www.tiddlywiki.com/htdocs
SET ARCHIVE_DIR=%DIR%/archive
SET OWNER=www-data:www-data
SET PERM=664
SET FILELIST=%DEST%/index.html %DEST%/index.xml %DEST%/empty.html %DEST%/TiddlySaver.jar %DEST%/empty.zip

SET SCP=ECHO (testing) "C:\Program Files\WinSCP\WinSCP.exe" "scp://%REMOTE_USER%@%HOST%"
REM (NOTE: DOWNLOAD/INSTALL from http://winscp.net/eng/download.php)

choice /M "Please confirm... Enter Y to post build to TiddlyWiki.com"
IF %ERRORLEVEL%==2 GOTO:eof

echo POST: clearing remote target folder (http://tiddlywiki.com/tmp)
%SCP% /command "sudo rm ./tmp/*"
echo POST: uploading files to http://tiddlywiki.com/tmp
%SCP% /command "cd tmp" /upload %FILELIST%
echo POST: setting remote file ownership/permissions...
%SCP% "sudo chown %OWNER% ./tmp/*; sudo chmod %PERM% ./tmp/*"
echo POST: copy index.html to http://tiddlywiki.com/archive/index.%RELEASE%.html
echo POST: copy empty.html to http://tiddlywiki.com/archive/empty.%RELEASE%.html
echo POST: copy empty.html to http://tiddlywiki.com/upgrade/index.html
echo POST: move all files from /tmp to http://tiddlywiki.com/
SET COMMANDS=sudo cp ./tmp/index.html %ARCHIVE_DIR%/index.%RELEASE%.html;
SET COMMANDS=%COMMANDS% sudo cp ./tmp/empty.html %ARCHIVE_DIR%/empty.%RELEASE%.html;
SET COMMANDS=%COMMANDS% sudo cp ./tmp/empty.html %DIR%/upgrade/index.html;
SET COMMANDS=%COMMANDS% sudo mv ./tmp/* %DIR%;
%SCP% /command "%COMMANDS%"
echo POST: done