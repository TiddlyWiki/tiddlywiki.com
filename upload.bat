@ECHO OFF
call setenv %1

choice /M "POST: Please confirm... Enter Y to upload to TiddlyWiki.com"
IF %ERRORLEVEL%==2 GOTO:eof

echo POST: clearing remote target folder (http://tiddlywiki.com/tmp)
%SCP% /command "sudo rm ./tmp/*"

echo POST: uploading files to target folder
%SCP% /command "cd tmp" /upload %UPLOADLIST%

echo POST: setting remote file ownership/permissions...
%SCP% /command "sudo chown %OWNER% ./tmp/*; sudo chmod %PERM% ./tmp/*"

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